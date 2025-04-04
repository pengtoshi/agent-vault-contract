// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "./VaultFactory.t.sol";
import {TestToken} from "../common/TestToken.sol";
import {Vault} from "contracts/Vault.sol";

contract VaultTest is BaseFixture {
    TestToken internal testToken;
    Vault internal vault;

    string constant VAULT_NAME = "Test Vault Token";
    string constant VAULT_SYMBOL = "vTEST";

    function setUp() public virtual override {
        super.setUp();

        // Deploy test token
        testToken = new TestToken("Test Token", "TEST");

        // Create vault
        vm.startPrank(users.owner);
        address vaultAddress = vaultFactory.createVault(IERC20(testToken), users.owner, VAULT_NAME, VAULT_SYMBOL);
        vault = Vault(vaultAddress);
        vm.stopPrank();
    }

    // Helper function to mint tokens to users
    function _mintTokens(address user, uint256 amount) internal {
        testToken.mint(user, amount);
    }

    // Helper function to approve and record logs
    function _approveAndRecord(address user, uint256 amount) internal {
        vm.startPrank(user);
        testToken.approve(address(vault), amount);
        vm.recordLogs();
    }

    // Helper function to verify basic vault state
    function _verifyVaultState(uint256 expectedAssets, uint256 expectedShares) internal {
        assertEq(vault.totalAssets(), expectedAssets);
        assertEq(vault.totalSupply(), expectedShares);
    }

    // Helper function to verify token transfers
    function _verifyTokenTransfers(address user, uint256 userExpectedBalance, uint256 vaultExpectedBalance) internal {
        assertEq(testToken.balanceOf(user), userExpectedBalance);
        assertEq(testToken.balanceOf(address(vault)), vaultExpectedBalance);
    }
}
