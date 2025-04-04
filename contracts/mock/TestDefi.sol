// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./TestToken.sol";

/**
 * @title TestDefi
 * @notice 테스트용 DeFi 프로토콜 컨트랙트
 * - 스테이킹 기능과 수익 발생을 시뮬레이션
 * - 테스트 목적으로 수익률을 조절 가능
 */
contract TestDefi {
    /// @notice 스테이킹 자산 토큰
    IERC20 public immutable stakingToken;

    /// @notice 사용자별 스테이킹된 자산 수량
    mapping(address => uint256) private _stakedBalance;

    /// @notice 총 스테이킹된 자산 수량
    uint256 private _totalStaked;

    /// @notice 수익률 (예: 1000 = 10%)
    uint256 public yieldRate;

    /// @notice 사용자별 마지막 수익 계산 시간
    mapping(address => uint256) public lastYieldTime;

    /**
     * @notice 생성자
     * @param _stakingToken 스테이킹할 토큰 주소
     * @param _yieldRate 연간 수익률 (예: 1000 = 10%)
     */
    constructor(IERC20 _stakingToken, uint256 _yieldRate) {
        stakingToken = _stakingToken;
        yieldRate = _yieldRate;
    }

    /**
     * @notice 수익률 설정
     * @param _yieldRate 새로운 수익률 (예: 1000 = 10%)
     */
    function setYieldRate(uint256 _yieldRate) external {
        yieldRate = _yieldRate;
    }

    /**
     * @notice 토큰 스테이킹 함수
     * @param amount 스테이킹할 토큰 수량
     */
    function stake(uint256 amount) external {
        require(amount > 0, "Cannot stake 0");

        // 먼저 기존 수익 계산
        _calculateYield(msg.sender);

        // 토큰 전송
        stakingToken.transferFrom(msg.sender, address(this), amount);

        // 스테이킹 잔액 업데이트
        _stakedBalance[msg.sender] += amount;
        _totalStaked += amount;

        // 마지막 수익 계산 시간 업데이트
        lastYieldTime[msg.sender] = block.timestamp;
    }

    /**
     * @notice 스테이킹된 토큰 출금 함수
     * @param amount 출금할 토큰 수량
     */
    function unstake(uint256 amount) external {
        require(amount > 0, "Cannot unstake 0");
        require(_stakedBalance[msg.sender] >= amount, "Insufficient staked balance");

        // 먼저 기존 수익 계산
        _calculateYield(msg.sender);

        // 스테이킹 잔액 업데이트
        _stakedBalance[msg.sender] -= amount;
        _totalStaked -= amount;

        // 토큰 전송
        stakingToken.transfer(msg.sender, amount);

        // 마지막 수익 계산 시간 업데이트
        lastYieldTime[msg.sender] = block.timestamp;
    }

    /**
     * @notice 발생한 수익 계산 및 지급
     */
    function harvest() external {
        _calculateYield(msg.sender);
    }

    /**
     * @notice 사용자의 스테이킹된 잔액 조회
     * @param account 조회할 사용자 주소
     * @return 스테이킹된 잔액 (수익 포함)
     */
    function stakedBalanceOf(address account) external view returns (uint256) {
        if (_stakedBalance[account] == 0) {
            return 0;
        }

        uint256 timeElapsed = block.timestamp - lastYieldTime[account];
        uint256 yield = (_stakedBalance[account] * yieldRate * timeElapsed) / (365 days * 10000);

        return _stakedBalance[account] + yield;
    }

    /**
     * @notice 총 스테이킹된 금액 조회
     * @return 총 스테이킹된 금액
     */
    function totalStaked() external view returns (uint256) {
        return _totalStaked;
    }

    /**
     * @notice 내부 함수: 사용자의 수익 계산 및 지급
     * @param account 수익을 계산할 사용자 주소
     */
    function _calculateYield(address account) internal {
        if (_stakedBalance[account] == 0 || lastYieldTime[account] == 0) {
            lastYieldTime[account] = block.timestamp;
            return;
        }

        uint256 timeElapsed = block.timestamp - lastYieldTime[account];
        if (timeElapsed == 0) return;

        uint256 yield = (_stakedBalance[account] * yieldRate * timeElapsed) / (365 days * 10000);

        if (yield > 0) {
            // 테스트 토큰 발행하여 수익으로 지급
            TestToken(address(stakingToken)).mint(address(this), yield);
            _stakedBalance[account] += yield;
            _totalStaked += yield;
        }

        lastYieldTime[account] = block.timestamp;
    }
}
