// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @title TestToken
 * @notice 테스트용 ERC20 토큰 컨트랙트
 * - 테스트 목적으로 특정 주소에 토큰을 mint할 수 있음
 */
contract TestToken is ERC20 {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {}

    /**
     * @notice 특정 주소에 토큰을 mint
     * @param to 토큰을 받을 주소
     * @param amount mint할 토큰 수량
     */
    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }

    /**
     * @notice 특정 주소의 토큰을 burn
     * @param from 토큰을 burn할 주소
     * @param amount burn할 토큰 수량
     */
    function burn(address from, uint256 amount) external {
        _burn(from, amount);
    }
}
