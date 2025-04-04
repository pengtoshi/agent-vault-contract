// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "contracts/interface/IStrategy.sol";
import "./TestDefi.sol";

/**
 * @title TestStrategy
 * @notice 테스트용 Strategy 컨트랙트
 * - TestDefi 프로토콜과 상호작용하는 전략 컨트랙트
 * - AgentVault와 TestDefi 사이의 중개 역할 수행
 */
contract TestStrategy is IStrategy {
    /// @notice 관리하는 자산 토큰
    IERC20 public immutable want;

    /// @notice 상호작용할 TestDefi 컨트랙트 인스턴스
    TestDefi public immutable defi;

    /**
     * @notice 생성자
     * @param _want 관리할 자산 토큰 주소
     * @param _defi TestDefi 컨트랙트 주소
     */
    constructor(IERC20 _want, TestDefi _defi) {
        want = _want;
        defi = _defi;

        // TestDefi에 자산 토큰 사용 권한 부여
        want.approve(address(_defi), type(uint256).max);
    }

    /**
     * @notice TestDefi의 수익률 설정 (필요한 경우 사용)
     * @param _yieldRate 새로운 수익률 (예: 1000 = 10%)
     */
    function setYieldRate(uint256 _yieldRate) external {
        defi.setYieldRate(_yieldRate);
    }

    /// @inheritdoc IStrategy
    function deposit() external override {
        uint256 balance = want.balanceOf(address(this));
        if (balance > 0) {
            defi.stake(balance);
        }
    }

    /// @inheritdoc IStrategy
    function withdraw(uint256 amount) external override {
        // 현재 TestDefi에 스테이킹된 잔액 확인
        uint256 stakedBalance = defi.stakedBalanceOf(address(this));
        require(amount <= stakedBalance, "Strategy: insufficient staked amount");

        // TestDefi에서 자산 출금
        defi.unstake(amount);

        // 요청자(AgentVault)에게 자산 전송
        want.transfer(msg.sender, amount);
    }

    /// @inheritdoc IStrategy
    function beforeDeposit() external override {
        // TestDefi에서 수익 수확
        defi.harvest();
    }

    /// @inheritdoc IStrategy
    function retireStrategy() external override {
        // TestDefi에서 모든 자산 출금
        uint256 stakedBalance = defi.stakedBalanceOf(address(this));
        if (stakedBalance > 0) {
            defi.unstake(stakedBalance);
        }

        // 모든 자산을 Vault로 반환
        uint256 balance = want.balanceOf(address(this));
        if (balance > 0) {
            want.transfer(msg.sender, balance);
        }
    }

    /// @inheritdoc IStrategy
    function balanceOf() external view override returns (uint256) {
        // TestDefi에 스테이킹된 자산 + 이 컨트랙트가 보유한 자산
        return defi.stakedBalanceOf(address(this)) + want.balanceOf(address(this));
    }
}
