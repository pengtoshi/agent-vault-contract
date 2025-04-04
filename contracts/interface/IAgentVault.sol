// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/interfaces/IERC4626.sol";
import "./IStrategy.sol";

/**
 * @title IAgentVault
 * @notice Interface for the AgentVault contract that follows ERC-4626 standard
 */
interface IAgentVault is IERC4626 {
    /**
     * @notice Event emitted when Strategy is changed
     */
    event StrategyChanged(address indexed newStrategy);

    /**
     * @notice Current Strategy contract connected to the Vault
     */
    function strategy() external view returns (IStrategy);

    /**
     * @notice Total assets = Vault balance + Assets deposited in Strategy
     */
    function totalAssets() external view returns (uint256);

    /**
     * @notice Deposits all assets in Vault to Strategy for management
     */
    function earn() external;

    /**
     * @notice User deposit function (Override of ERC4626's deposit)
     * - Calls Strategy.beforeDeposit() before deposit
     * - After deposit, calls earn() to manage Vault balance through Strategy
     * @param assets Amount of assets to deposit
     * @param receiver Address to receive Vault tokens
     * @return shares Number of Vault tokens minted (ERC4626 standard)
     */
    function deposit(uint256 assets, address receiver) external returns (uint256 shares);

    /**
     * @notice User redemption function (Override of ERC4626's redeem)
     * - If Vault balance is insufficient, withdraws funds from Strategy
     * @param shares Amount of shares to redeem
     * @param receiver Address to receive assets
     * @param owner Address of Vault token owner
     * @return assets Number of assets returned to receiver (ERC4626 standard)
     */
    function redeem(uint256 shares, address receiver, address owner) external returns (uint256 assets);

    /**
     * @notice Convenience function: Deposits all assets of msg.sender to Vault
     */
    function depositAll() external returns (uint256 shares);

    /**
     * @notice Convenience function: Withdraws all assets using msg.sender's Vault tokens
     */
    function redeemAll() external returns (uint256 shares);

    /**
     * @notice Function for AI Agent or Vault Master to change Strategy
     * - Calls retireStrategy() on existing Strategy to recover funds
     * - New Strategy's want() must match current Vault's asset
     * - Calls earn() after change to deposit Vault balance to new Strategy
     * @param newStrategy Address of new Strategy contract
     */
    function setStrategy(IStrategy newStrategy) external;

    /**
     * @notice Function for Vault Master to grant AI Agent role
     */
    function grantAgentRole(address agent) external;

    /**
     * @notice Function for Vault Master to revoke AI Agent role
     */
    function revokeAgentRole(address agent) external;
}
