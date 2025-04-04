// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "../common/BaseFixture.sol";
import {TestToken} from "contracts/mock/TestToken.sol";
import {TestDefi} from "contracts/mock/TestDefi.sol";
import {TestStrategy} from "contracts/mock/TestStrategy.sol";
import {AgentVault} from "contracts/AgentVault.sol";
import {IStrategy} from "contracts/interface/IStrategy.sol";

contract AgentVaultFactoryTest is BaseFixture {
    TestToken internal testToken;
    TestStrategy internal testStrategy;
    TestDefi internal testDefi;

    string constant VAULT_NAME = "Test Agent Vault Token";
    string constant VAULT_SYMBOL = "aVTEST";

    event VaultCreated(address indexed vault, address indexed asset, string name, string symbol);

    function setUp() public virtual override {
        super.setUp();

        // 테스트 토큰 배포
        testToken = new TestToken("Test Token", "TEST");

        // 테스트 Defi 및 전략 배포 (10% 수익률)
        testDefi = new TestDefi(IERC20(testToken), 1000);
        testStrategy = new TestStrategy(IERC20(testToken), testDefi);
    }

    function test_Initialize() public {
        assertEq(vaultFactory.owner(), users.owner);
        assertEq(vaultFactory.getVaultCount(), 0);

        address[] memory vaults = vaultFactory.getAllVaults();
        assertEq(vaults.length, 0);
    }

    function test_CreateVault() public {
        vm.startPrank(users.owner);

        // Vault 생성
        vm.recordLogs();
        address vaultAddress = vaultFactory.createVault(
            IERC20(testToken),
            IStrategy(testStrategy),
            users.owner,
            users.agent,
            VAULT_NAME,
            VAULT_SYMBOL
        );
        AgentVault vault = AgentVault(vaultAddress);

        // 이벤트 검증
        Vm.Log[] memory entries = vm.getRecordedLogs();
        assertEq(entries.length, 5); // 3 AccessControl 이벤트 + 1 ERC4626 이벤트 + 1 VaultCreated 이벤트

        // VaultCreated 이벤트는 마지막에 발생
        Vm.Log memory vaultCreatedLog = entries[4];
        assertEq(vaultCreatedLog.topics[0], keccak256("VaultCreated(address,address,string,string)"));
        assertEq(vaultCreatedLog.topics[1], bytes32(uint256(uint160(vaultAddress))));
        assertEq(vaultCreatedLog.topics[2], bytes32(uint256(uint160(address(testToken)))));

        (string memory emittedName, string memory emittedSymbol) = abi.decode(vaultCreatedLog.data, (string, string));
        assertEq(emittedName, VAULT_NAME);
        assertEq(emittedSymbol, VAULT_SYMBOL);

        // VaultFactory 상태 검증
        assertEq(vaultFactory.getVaultCount(), 1);
        address[] memory vaults = vaultFactory.getAllVaults();
        assertEq(vaults.length, 1);
        assertEq(vaults[0], vaultAddress);

        // 생성된 Vault 상태 검증
        assertEq(vault.name(), VAULT_NAME);
        assertEq(vault.symbol(), VAULT_SYMBOL);
        assertEq(address(vault.asset()), address(testToken));
        assertEq(address(vault.strategy()), address(testStrategy));

        // 권한 설정 검증
        assertTrue(vault.hasRole(vault.VAULT_MASTER_ROLE(), users.owner));
        assertTrue(vault.hasRole(vault.AGENT_ROLE(), users.agent));
        assertTrue(vault.getRoleAdmin(vault.AGENT_ROLE()) == vault.VAULT_MASTER_ROLE());

        // 초기 상태 검증
        assertEq(vault.totalAssets(), 0);
        assertEq(vault.totalSupply(), 0);

        vm.stopPrank();
    }

    function test_RevertWhen_InvalidAssetAddress() public {
        vm.startPrank(users.owner);

        vm.expectRevert("ERC20: invalid contract address");
        vaultFactory.createVault(
            IERC20(address(0)),
            IStrategy(testStrategy),
            users.owner,
            users.agent,
            VAULT_NAME,
            VAULT_SYMBOL
        );

        vm.stopPrank();
    }

    function test_RevertWhen_InvalidVaultMaster() public {
        vm.startPrank(users.owner);

        vm.expectRevert("Vault: invalid vault master");
        vaultFactory.createVault(
            IERC20(testToken),
            IStrategy(testStrategy),
            address(0),
            users.agent,
            VAULT_NAME,
            VAULT_SYMBOL
        );

        vm.stopPrank();
    }
}
