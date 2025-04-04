// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "./Vault.t.sol";

contract AddYieldTest is VaultTest {
    function setUp() public virtual override {
        super.setUp();
        _mintTokens(users.agent, INITIAL_BALANCE);
    }

    function test_AddYield() public {
        _approveAndRecord(users.agent, DEFAULT_AMOUNT);

        vault.addYield(DEFAULT_AMOUNT);

        _verifyTokenTransfers(users.agent, INITIAL_BALANCE - DEFAULT_AMOUNT, DEFAULT_AMOUNT);
        _verifyVaultState(DEFAULT_AMOUNT, 0);

        Vm.Log[] memory entries = vm.getRecordedLogs();
        assertEq(entries.length, 2);

        vm.stopPrank();
    }

    function test_RevertWhen_NonAgentAddsYield() public {
        vm.startPrank(users.alice);

        testToken.approve(address(vault), DEFAULT_AMOUNT);
        vm.expectRevert("Vault: Caller is not an AI Agent");
        vault.addYield(DEFAULT_AMOUNT);

        vm.stopPrank();
    }

    function test_RevertWhen_AddZeroYield() public {
        vm.startPrank(users.agent);

        testToken.approve(address(vault), DEFAULT_AMOUNT);
        vm.expectRevert("Vault: yield amount must be > 0");
        vault.addYield(0);

        vm.stopPrank();
    }

    function test_RevertWhen_AddYieldWithoutApproval() public {
        vm.startPrank(users.agent);

        vm.expectRevert(
            abi.encodeWithSelector(IERC20Errors.ERC20InsufficientAllowance.selector, address(vault), 0, DEFAULT_AMOUNT)
        );
        vault.addYield(DEFAULT_AMOUNT);

        vm.stopPrank();
    }

    function test_RevertWhen_AddYieldWithInsufficientBalance() public {
        vm.startPrank(users.agent);

        uint256 tooMuch = INITIAL_BALANCE + 1;
        testToken.approve(address(vault), tooMuch);

        vm.expectRevert(
            abi.encodeWithSelector(
                IERC20Errors.ERC20InsufficientBalance.selector,
                users.agent,
                INITIAL_BALANCE,
                tooMuch
            )
        );
        vault.addYield(tooMuch);

        vm.stopPrank();
    }
}
