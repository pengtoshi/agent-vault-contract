// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "./Vault.t.sol";

contract DepositTest is VaultTest {
    function setUp() public virtual override {
        super.setUp();

        // Mint initial tokens to users
        _mintTokens(users.alice, INITIAL_BALANCE);
        _mintTokens(users.bob, INITIAL_BALANCE);
    }

    function test_Deposit() public {
        _approveAndRecord(users.alice, DEFAULT_AMOUNT);

        // Calculate expected shares before deposit
        uint256 expectedShares = DEFAULT_AMOUNT; // 1:1 ratio for first deposit

        // Perform deposit
        uint256 shares = vault.deposit(DEFAULT_AMOUNT, users.alice);

        // Verify returned shares amount
        assertEq(shares, expectedShares);

        // Verify token transfers and vault state
        _verifyTokenTransfers(users.alice, INITIAL_BALANCE - DEFAULT_AMOUNT, DEFAULT_AMOUNT);
        _verifyVaultState(DEFAULT_AMOUNT, shares);
        assertEq(vault.balanceOf(users.alice), shares);

        // Verify events
        Vm.Log[] memory entries = vm.getRecordedLogs();
        assertEq(entries.length, 3); // ERC20 Transfer events (2) + Deposit event

        vm.stopPrank();
    }

    function test_DepositWithPermit() public {
        // TODO: Implement deposit with permit test when permit functionality is added
    }

    function test_DepositForOther() public {
        vm.startPrank(users.alice);

        testToken.approve(address(vault), DEFAULT_AMOUNT);
        uint256 shares = vault.deposit(DEFAULT_AMOUNT, users.bob);

        // Verify tokens transferred from alice
        assertEq(testToken.balanceOf(users.alice), INITIAL_BALANCE - DEFAULT_AMOUNT);
        assertEq(testToken.balanceOf(address(vault)), DEFAULT_AMOUNT);

        // Verify shares minted to bob
        assertEq(vault.balanceOf(users.bob), shares);
        assertEq(vault.balanceOf(users.alice), 0);

        vm.stopPrank();
    }

    function test_RevertWhen_DepositZero() public {
        vm.startPrank(users.alice);

        testToken.approve(address(vault), DEFAULT_AMOUNT);
        vm.expectRevert(Vault.ZeroAssets.selector);
        vault.deposit(0, users.alice);

        vm.stopPrank();
    }

    function test_RevertWhen_DepositWithoutApproval() public {
        vm.startPrank(users.alice);

        vm.expectRevert(
            abi.encodeWithSelector(IERC20Errors.ERC20InsufficientAllowance.selector, address(vault), 0, DEFAULT_AMOUNT)
        );
        vault.deposit(DEFAULT_AMOUNT, users.alice);

        vm.stopPrank();
    }

    function test_RevertWhen_DepositWithInsufficientBalance() public {
        vm.startPrank(users.alice);

        uint256 tooMuch = INITIAL_BALANCE + 1;
        testToken.approve(address(vault), tooMuch);

        vm.expectRevert(
            abi.encodeWithSelector(
                IERC20Errors.ERC20InsufficientBalance.selector,
                users.alice,
                INITIAL_BALANCE,
                tooMuch
            )
        );
        vault.deposit(tooMuch, users.alice);

        vm.stopPrank();
    }

    function test_DepositMultiple() public {
        // First deposit by Alice
        vm.startPrank(users.alice);
        testToken.approve(address(vault), DEFAULT_AMOUNT);
        uint256 aliceShares = vault.deposit(DEFAULT_AMOUNT, users.alice);
        vm.stopPrank();

        // Second deposit by Bob
        vm.startPrank(users.bob);
        testToken.approve(address(vault), DEFAULT_AMOUNT);
        uint256 bobShares = vault.deposit(DEFAULT_AMOUNT, users.bob);
        vm.stopPrank();

        // Verify total state
        assertEq(vault.totalAssets(), DEFAULT_AMOUNT * 2);
        assertEq(vault.totalSupply(), aliceShares + bobShares);

        // Verify individual balances
        assertEq(vault.balanceOf(users.alice), aliceShares);
        assertEq(vault.balanceOf(users.bob), bobShares);

        // Verify share amounts are equal (1:1 ratio maintained)
        assertEq(aliceShares, bobShares);
    }
}
