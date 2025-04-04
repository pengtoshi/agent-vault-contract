// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "./VaultFactory.t.sol";
import {TestToken} from "../common/TestToken.sol";
import {Vault} from "contracts/Vault.sol";

contract CreateVaultTest is VaultFactoryTest {
    TestToken internal testToken;
    Vault internal vault;

    string constant VAULT_NAME = "Test Vault Token";
    string constant VAULT_SYMBOL = "vTEST";

    event VaultCreated(address indexed vault, address indexed asset, string name, string symbol);

    function setUp() public virtual override {
        super.setUp();

        // Deploy test token
        testToken = new TestToken("Test Token", "TEST");
    }

    function test_CreateVault() public {
        vm.startPrank(users.owner);

        // Create Vault
        vm.recordLogs();
        address vaultAddress = vaultFactory.createVault(IERC20(testToken), users.owner, VAULT_NAME, VAULT_SYMBOL);
        vault = Vault(vaultAddress);

        // Verify events
        Vm.Log[] memory entries = vm.getRecordedLogs();
        assertEq(entries.length, 4); // 3 AccessControl events + 1 VaultCreated event

        // VaultCreated event is emitted last
        Vm.Log memory vaultCreatedLog = entries[3];
        assertEq(vaultCreatedLog.topics[0], keccak256("VaultCreated(address,address,string,string)"));
        assertEq(vaultCreatedLog.topics[1], bytes32(uint256(uint160(vaultAddress))));
        assertEq(vaultCreatedLog.topics[2], bytes32(uint256(uint160(address(testToken)))));

        (string memory emittedName, string memory emittedSymbol) = abi.decode(vaultCreatedLog.data, (string, string));
        assertEq(emittedName, VAULT_NAME);
        assertEq(emittedSymbol, VAULT_SYMBOL);

        // Verify VaultFactory state
        assertEq(vaultFactory.getVaultCount(), 1);
        address[] memory vaults = vaultFactory.getAllVaults();
        assertEq(vaults.length, 1);
        assertEq(vaults[0], vaultAddress);

        // Verify created Vault state
        // 1. Check basic information
        assertEq(vault.name(), VAULT_NAME);
        assertEq(vault.symbol(), VAULT_SYMBOL);
        assertEq(address(vault.asset()), address(testToken));

        // 2. Check role settings
        assertTrue(vault.hasRole(vault.VAULT_MASTER_ROLE(), users.owner));
        assertTrue(vault.hasRole(vault.AGENT_ROLE(), users.agent));
        assertTrue(vault.getRoleAdmin(vault.AGENT_ROLE()) == vault.VAULT_MASTER_ROLE());

        // 3. Check initial state
        assertEq(vault.totalAssets(), 0);
        assertEq(vault.totalSupply(), 0);

        vm.stopPrank();
    }

    function test_RevertWhen_NonOwnerCreatesVault() public {
        vm.startPrank(users.alice);

        vm.expectRevert(abi.encodeWithSignature("OwnableUnauthorizedAccount(address)", users.alice));
        vaultFactory.createVault(IERC20(testToken), users.owner, VAULT_NAME, VAULT_SYMBOL);

        vm.stopPrank();
    }

    function test_RevertWhen_InvalidAssetAddress() public {
        vm.startPrank(users.owner);

        vm.expectRevert("ERC20: invalid contract address");
        vaultFactory.createVault(IERC20(address(0)), users.owner, VAULT_NAME, VAULT_SYMBOL);

        vm.stopPrank();
    }

    function test_RevertWhen_InvalidVaultMaster() public {
        vm.startPrank(users.owner);

        vm.expectRevert("Vault: invalid vault master");
        vaultFactory.createVault(IERC20(testToken), address(0), VAULT_NAME, VAULT_SYMBOL);

        vm.stopPrank();
    }

    function test_CreateMultipleVaults() public {
        vm.startPrank(users.owner);

        // Create multiple vaults
        for (uint i = 0; i < 3; i++) {
            string memory name = string(abi.encodePacked(VAULT_NAME, " ", vm.toString(i)));
            string memory symbol = string(abi.encodePacked(VAULT_SYMBOL, vm.toString(i)));

            vaultFactory.createVault(IERC20(testToken), users.owner, name, symbol);
        }

        // Verify VaultFactory state
        assertEq(vaultFactory.getVaultCount(), 3);
        address[] memory vaults = vaultFactory.getAllVaults();
        assertEq(vaults.length, 3);

        // Verify each created vault
        for (uint i = 0; i < 3; i++) {
            Vault createdVault = Vault(vaults[i]);
            string memory expectedName = string(abi.encodePacked(VAULT_NAME, " ", vm.toString(i)));
            string memory expectedSymbol = string(abi.encodePacked(VAULT_SYMBOL, vm.toString(i)));

            assertEq(createdVault.name(), expectedName);
            assertEq(createdVault.symbol(), expectedSymbol);
            assertTrue(createdVault.hasRole(createdVault.VAULT_MASTER_ROLE(), users.owner));
            assertTrue(createdVault.hasRole(createdVault.AGENT_ROLE(), users.agent));
        }

        vm.stopPrank();
    }
}
