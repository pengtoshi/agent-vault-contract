// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "./AgentVault.t.sol";

contract RedeemTest is AgentVaultTest {
    function setUp() public override {
        super.setUp();

        // Mint initial tokens to users
        mintTestTokens(users.alice, testToken, INITIAL_BALANCE);
        mintTestTokens(users.bob, testToken, INITIAL_BALANCE);

        // Alice, Bob 예치
        vm.startPrank(users.alice);
        testToken.approve(address(vault), DEFAULT_AMOUNT);
        vault.deposit(DEFAULT_AMOUNT, users.alice);
        vm.stopPrank();

        vm.startPrank(users.bob);
        testToken.approve(address(vault), DEFAULT_AMOUNT);
        vault.deposit(DEFAULT_AMOUNT, users.bob);
        vm.stopPrank();

        // 1년 후로 시간 변경
        vm.warp(block.timestamp + 365 days);
    }

    function test_Withdraw() public {
        // 테스트 준비
        vm.startPrank(users.alice);

        // 인출 전 상태 기록
        uint256 preUserBalance = testToken.balanceOf(users.alice);
        uint256 preTotalAssets = vault.totalAssets();
        uint256 preShareBalance = vault.balanceOf(users.alice);
        uint256 totalSupply = vault.totalSupply();

        // 예상 인출 자산 계산 (ERC4626 공식 사용)
        uint256 expectedAssets = (preShareBalance * preTotalAssets) / totalSupply;

        // 쉐어 기반 인출로 변경
        uint256 assets = vault.redeem(preShareBalance, users.alice, users.alice);

        // 인출 후 상태 확인
        uint256 postUserBalance = testToken.balanceOf(users.alice);
        uint256 postShareBalance = vault.balanceOf(users.alice);

        // 정확한 값 또는 근사치 검증
        assertApproxEqAbs(assets, expectedAssets, 1e8);
        assertApproxEqAbs(postUserBalance, preUserBalance + expectedAssets, 1e8);
        assertEq(postShareBalance, 0);
    }

    function test_WithdrawPartial() public {
        // 테스트 준비
        vm.startPrank(users.alice);

        uint256 preUserBalance = testToken.balanceOf(users.alice);
        uint256 preShareBalance = vault.balanceOf(users.alice);
        uint256 preTotalAssets = vault.totalAssets();
        uint256 totalSupply = vault.totalSupply();
        uint256 withdrawShares = preShareBalance / 2;

        // 예상 인출 자산 계산 (ERC4626 공식 사용)
        uint256 expectedAssets = (withdrawShares * preTotalAssets) / totalSupply;

        // 쉐어 기반 인출로 변경
        uint256 assets = vault.redeem(withdrawShares, users.alice, users.alice);

        // 검증
        uint256 postUserBalance = testToken.balanceOf(users.alice);
        uint256 postShareBalance = vault.balanceOf(users.alice);

        // 정확한 값 또는 근사치 검증
        assertApproxEqAbs(assets, expectedAssets, 1e8);
        assertApproxEqAbs(postUserBalance, preUserBalance + expectedAssets, 1e8);
        assertEq(postShareBalance, preShareBalance - withdrawShares);
    }
}
