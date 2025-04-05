// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "../common/BaseFixture.sol";
import {TestToken} from "contracts/mock/TestToken.sol";
import {TestDefi} from "contracts/mock/TestDefi.sol";
import {TestStrategy} from "contracts/mock/TestStrategy.sol";
import {AgentVault} from "contracts/AgentVault.sol";

contract AgentVaultTest is BaseFixture {
    TestToken internal testToken;
    TestDefi internal defi;
    TestStrategy internal strategy;
    AgentVault internal vault;

    function setUp() public virtual override {
        super.setUp();

        testToken = new TestToken("Test Token", "TEST");
        defi = new TestDefi(IERC20(testToken), 1000);
        strategy = new TestStrategy(IERC20(testToken), defi);

        // Create vault
        vm.startPrank(users.owner);
        address vaultAddress = vaultFactory.createVault{value: AGENT_INITIAL_FUND}(
            IERC20(testToken),
            strategy,
            users.owner,
            users.agent,
            "Test Vault",
            "TV"
        );
        vault = AgentVault(vaultAddress);
        vm.stopPrank();
    }

    function test_InitialState() public {
        assertEq(vault.hasRole(vault.VAULT_MASTER_ROLE(), users.owner), true);
        assertEq(vault.hasRole(vault.AGENT_ROLE(), users.agent), true);
        assertEq(vault.asset(), address(testToken));
        assertEq(address(vault.strategy()), address(strategy));
        assertEq(vault.name(), "Test Vault");
        assertEq(vault.symbol(), "TV");
        assertEq(users.agent.balance, AGENT_INITIAL_FUND);
    }
}
