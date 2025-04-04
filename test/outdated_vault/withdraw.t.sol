// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "./Vault.t.sol";

contract WithdrawTest is VaultTest {
    function setUp() public virtual override {
        super.setUp();

        // Mint initial tokens to users
        _mintTokens(users.alice, INITIAL_BALANCE);
        _mintTokens(users.bob, INITIAL_BALANCE);

        // Perform initial deposit
        _approveAndRecord(users.alice, DEFAULT_AMOUNT);
        vault.deposit(DEFAULT_AMOUNT, users.alice);
        vm.stopPrank();
    }

    // Helper function for adding yield
    function _addYield(uint256 yieldAmount) internal {
        vm.startPrank(users.agent);
        _mintTokens(users.agent, yieldAmount);
        testToken.approve(address(vault), yieldAmount);
        vault.addYield(yieldAmount);
        vm.stopPrank();
    }

    function test_Withdraw() public {
        vm.startPrank(users.alice);

        uint256 preBalance = testToken.balanceOf(users.alice);
        uint256 shares = vault.balanceOf(users.alice);

        vm.recordLogs();
        uint256 assets = vault.withdraw(DEFAULT_AMOUNT, users.alice, users.alice);

        assertEq(assets, DEFAULT_AMOUNT);
        _verifyTokenTransfers(users.alice, preBalance + DEFAULT_AMOUNT, 0);
        _verifyVaultState(0, 0);
        assertEq(vault.balanceOf(users.alice), 0);

        Vm.Log[] memory entries = vm.getRecordedLogs();
        assertEq(entries.length, 3);

        vm.stopPrank();
    }

    function test_WithdrawForOther() public {
        vm.startPrank(users.alice);

        uint256 preBalance = testToken.balanceOf(users.bob);
        vault.withdraw(DEFAULT_AMOUNT, users.bob, users.alice);

        _verifyTokenTransfers(users.bob, preBalance + DEFAULT_AMOUNT, 0);
        assertEq(vault.balanceOf(users.alice), 0);

        vm.stopPrank();
    }

    function test_RevertWhen_WithdrawZero() public {
        vm.startPrank(users.alice);
        vm.expectRevert(Vault.ZeroAssets.selector);
        vault.withdraw(0, users.alice, users.alice);
        vm.stopPrank();
    }

    function test_RevertWhen_WithdrawMoreThanBalance() public {
        vm.startPrank(users.alice);
        vm.expectRevert(
            abi.encodeWithSelector(
                ERC4626.ERC4626ExceededMaxWithdraw.selector,
                users.alice,
                DEFAULT_AMOUNT + 1,
                DEFAULT_AMOUNT
            )
        );
        vault.withdraw(DEFAULT_AMOUNT + 1, users.alice, users.alice);
        vm.stopPrank();
    }

    function test_RevertWhen_UnauthorizedWithdraw() public {
        vm.startPrank(users.bob);
        vm.expectRevert(
            abi.encodeWithSelector(IERC20Errors.ERC20InsufficientAllowance.selector, users.bob, 0, DEFAULT_AMOUNT)
        );
        vault.withdraw(DEFAULT_AMOUNT, users.bob, users.alice);
        vm.stopPrank();
    }

    function test_WithdrawPartial() public {
        uint256 withdrawAmount = DEFAULT_AMOUNT / 2;

        vm.startPrank(users.alice);
        uint256 preBalance = testToken.balanceOf(users.alice);
        uint256 preShares = vault.balanceOf(users.alice);

        uint256 shares = vault.withdraw(withdrawAmount, users.alice, users.alice);

        _verifyTokenTransfers(users.alice, preBalance + withdrawAmount, DEFAULT_AMOUNT - withdrawAmount);
        _verifyVaultState(DEFAULT_AMOUNT - withdrawAmount, preShares - shares);

        vm.stopPrank();
    }

    function test_WithdrawAfterYield() public {
        _addYield(DEFAULT_AMOUNT);

        uint256 aliceShares = vault.balanceOf(users.alice);
        uint256 expectedAssets = vault.convertToAssets(aliceShares);

        vm.startPrank(users.alice);
        uint256 preBalance = testToken.balanceOf(users.alice);
        uint256 receivedAssets = vault.redeem(aliceShares, users.alice, users.alice);

        assertEq(receivedAssets, expectedAssets);
        assertEq(testToken.balanceOf(users.alice), preBalance + expectedAssets);
        assertEq(vault.balanceOf(users.alice), 0);
        vm.stopPrank();
    }

    function test_WithdrawProportionalAfterYield() public {
        // Second user deposits the same amount
        _approveAndRecord(users.bob, DEFAULT_AMOUNT);
        vault.deposit(DEFAULT_AMOUNT, users.bob);
        vm.stopPrank();

        _addYield(DEFAULT_AMOUNT);

        uint256 totalAssets = vault.totalAssets();
        assertEq(totalAssets, DEFAULT_AMOUNT * 2 + DEFAULT_AMOUNT);

        // Users withdraw
        (uint256 aliceAssets, uint256 bobAssets) = _withdrawBothUsers();

        // Verify proportional withdrawals
        assertApproxEqAbs(aliceAssets, bobAssets, 1);
        uint256 expectedAmount = DEFAULT_AMOUNT + DEFAULT_AMOUNT / 2;
        assertApproxEqAbs(aliceAssets, expectedAmount, 1);
        assertApproxEqAbs(bobAssets, expectedAmount, 1);

        // Verify vault is empty
        assertApproxEqAbs(vault.totalAssets(), 0, 1);
        assertApproxEqAbs(vault.totalSupply(), 0, 1);
    }

    function test_WithdrawPartialAfterYield() public {
        _addYield(DEFAULT_AMOUNT);

        vm.startPrank(users.alice);
        uint256 aliceShares = vault.balanceOf(users.alice);
        uint256 withdrawShares = aliceShares / 2;
        uint256 expectedAssets = vault.convertToAssets(withdrawShares);

        uint256 preBalance = testToken.balanceOf(users.alice);
        vault.redeem(withdrawShares, users.alice, users.alice);

        assertEq(testToken.balanceOf(users.alice) - preBalance, expectedAssets);
        assertEq(vault.balanceOf(users.alice), withdrawShares);
        vm.stopPrank();
    }

    // Helper function for withdrawing both users' shares
    function _withdrawBothUsers() internal returns (uint256 aliceAssets, uint256 bobAssets) {
        vm.startPrank(users.alice);
        uint256 aliceShares = vault.balanceOf(users.alice);
        aliceAssets = vault.redeem(aliceShares, users.alice, users.alice);
        vm.stopPrank();

        vm.startPrank(users.bob);
        uint256 bobShares = vault.balanceOf(users.bob);
        bobAssets = vault.redeem(bobShares, users.bob, users.bob);
        vm.stopPrank();
    }
}
