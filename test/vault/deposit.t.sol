// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "./AgentVault.t.sol";

contract DepositTest is AgentVaultTest {
    function setUp() public override {
        super.setUp();

        // Mint initial tokens to users
        mintTestTokens(users.alice, testToken, INITIAL_BALANCE);
        mintTestTokens(users.bob, testToken, INITIAL_BALANCE);
    }

    function test_Deposit() public {
        // 테스트 준비
        vm.startPrank(users.alice);

        // 예치 전 상태 기록
        uint256 preUserBalance = testToken.balanceOf(users.alice);
        uint256 preVaultBalance = testToken.balanceOf(address(vault));
        uint256 preStrategyBalance = strategy.balanceOf();
        uint256 preTotalAssets = vault.totalAssets();

        // 토큰 승인
        testToken.approve(address(vault), DEFAULT_AMOUNT);

        // 로그 기록 시작
        vm.recordLogs();

        // 예치 실행
        uint256 shares = vault.deposit(DEFAULT_AMOUNT, users.alice);

        // 예치 후 상태 확인
        uint256 postUserBalance = testToken.balanceOf(users.alice);
        uint256 postVaultBalance = testToken.balanceOf(address(vault));
        uint256 postStrategyBalance = strategy.balanceOf();
        uint256 postTotalAssets = vault.totalAssets();

        // 검증: 사용자 토큰이 정확히 차감되었는지
        assertEq(preUserBalance - postUserBalance, DEFAULT_AMOUNT);

        // 검증: 토큰이 전략에 전달되었는지 (vault.deposit 이후 earn()이 호출됨)
        assertEq(postStrategyBalance - preStrategyBalance, DEFAULT_AMOUNT);

        // 검증: Vault의 총 자산이 정확히 증가했는지
        assertEq(postTotalAssets - preTotalAssets, DEFAULT_AMOUNT);

        // 검증: 적절한 수의 shares가 발행되었는지
        assertEq(vault.balanceOf(users.alice), shares);

        // 검증: 이벤트가 제대로 발생했는지
        Vm.Log[] memory entries = vm.getRecordedLogs();
        bool foundDepositEvent = false;

        for (uint i = 0; i < entries.length; i++) {
            // ERC4626의 Deposit 이벤트: event Deposit(address indexed caller, address indexed owner, uint256 assets, uint256 shares);
            if (entries[i].topics[0] == keccak256("Deposit(address,address,uint256,uint256)")) {
                foundDepositEvent = true;
                break;
            }
        }

        assertTrue(foundDepositEvent);

        vm.stopPrank();
    }

    function test_MultipleDeposits() public {
        // Alice 예치
        vm.startPrank(users.alice);
        testToken.approve(address(vault), DEFAULT_AMOUNT);
        vault.deposit(DEFAULT_AMOUNT, users.alice);
        vm.stopPrank();

        // Bob 예치
        vm.startPrank(users.bob);
        testToken.approve(address(vault), DEFAULT_AMOUNT);
        vault.deposit(DEFAULT_AMOUNT, users.bob);
        vm.stopPrank();

        // 검증: 두 사용자 모두 정확한 shares를 받았는지
        assertEq(vault.balanceOf(users.alice), vault.balanceOf(users.bob));

        // 검증: 총 자산이 정확히 증가했는지
        assertEq(vault.totalAssets(), DEFAULT_AMOUNT * 2);
    }
}
