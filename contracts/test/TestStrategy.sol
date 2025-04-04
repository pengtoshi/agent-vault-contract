// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../interface/IStrategy.sol";
import "./TestToken.sol";

/**
 * @title TestStrategy
 * @notice 테스트용 Strategy 컨트랙트
 * - 스테이킹 수익을 모킹하는 간단한 구현
 * - 테스트 목적으로 수익률을 조절 가능
 */
contract TestStrategy is IStrategy {
    /// @notice 관리하는 자산 토큰
    IERC20 public immutable want;

    /// @notice 현재 스테이킹된 자산 수량
    uint256 private _stakedAmount;

    /// @notice 수익률 (예: 1000 = 10%)
    uint256 public yieldRate;

    /// @notice 마지막 수익 계산 시간
    uint256 public lastYieldTime;

    /**
     * @notice 생성자
     * @param _want 관리할 자산 토큰 주소
     * @param _yieldRate 연간 수익률 (예: 1000 = 10%)
     */
    constructor(IERC20 _want, uint256 _yieldRate) {
        want = _want;
        yieldRate = _yieldRate;
        lastYieldTime = block.timestamp;
    }

    /**
     * @notice 수익률 설정
     * @param _yieldRate 새로운 수익률 (예: 1000 = 10%)
     */
    function setYieldRate(uint256 _yieldRate) external {
        yieldRate = _yieldRate;
    }

    /// @inheritdoc IStrategy
    function deposit() external override {
        uint256 balance = IERC20(want).balanceOf(address(this));
        if (balance > 0) {
            _stakedAmount += balance;
            lastYieldTime = block.timestamp;
        }
    }

    /// @inheritdoc IStrategy
    function withdraw(uint256 amount) external override {
        require(amount <= _stakedAmount, "Strategy: insufficient staked amount");
        _stakedAmount -= amount;
        lastYieldTime = block.timestamp;
    }

    /// @inheritdoc IStrategy
    function beforeDeposit() external override {
        // 수익 계산 및 자산 증가
        if (_stakedAmount > 0) {
            uint256 timeElapsed = block.timestamp - lastYieldTime;
            uint256 yield = (_stakedAmount * yieldRate * timeElapsed) / (365 days * 10000);
            if (yield > 0) {
                TestToken(address(want)).mint(address(this), yield);
                _stakedAmount += yield;
            }
        }
    }

    /// @inheritdoc IStrategy
    function retireStrategy() external override {
        // 모든 자산을 Vault로 반환
        uint256 balance = IERC20(want).balanceOf(address(this));
        if (balance > 0) {
            IERC20(want).transfer(msg.sender, balance);
        }
        _stakedAmount = 0;
    }

    /// @inheritdoc IStrategy
    function balanceOf() external view override returns (uint256) {
        return _stakedAmount;
    }
}
