// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

/// @title Constants
/// @notice A contract that contains constants for the test suite
abstract contract Constants {
    uint256 public constant TOKEN_1 = 1e18;
    uint256 public constant USDC_1 = 1e6;

    // Common test amounts
    uint256 public constant INITIAL_BALANCE = 1000 * TOKEN_1;
    uint256 public constant DEFAULT_AMOUNT = 100 * TOKEN_1;

    uint256 public constant AGENT_INITIAL_FUND = 0.1 ether;

    // NOTE: Add constants below
}
