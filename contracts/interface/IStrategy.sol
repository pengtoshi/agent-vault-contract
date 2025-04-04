// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @title IStrategy
 * @notice Interface that defines the functions that Strategy contracts must implement to interact with the Vault
 */
interface IStrategy {
    /// @notice Returns the address of the asset (ERC20) managed by the Vault
    function want() external view returns (IERC20);

    /// @notice Returns the total amount of assets currently managed by the Strategy (including deposits and interest)
    function balanceOf() external view returns (uint256);

    /// @notice Called when funds are deposited from the Vault - implements logic to deposit funds into the actual DeFi protocol
    function deposit() external;

    /// @notice Called when withdrawal is requested from the Vault - implements logic to return funds to the Vault
    function withdraw(uint256 amount) external;

    /// @notice Called before Vault deposits - performs necessary preliminary work (e.g., harvest)
    function beforeDeposit() external;

    /// @notice Function to withdraw funds from the current Strategy when switching strategies
    function retireStrategy() external;
}
