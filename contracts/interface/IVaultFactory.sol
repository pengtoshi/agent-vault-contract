// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @title IVaultFactory
 * @notice Interface for the VaultFactory contract that manages vault creation and administration
 */
interface IVaultFactory {
    /**
     * @notice Event emitted when a new vault is created
     */
    event VaultCreated(address indexed vault, address indexed asset, string name, string symbol);

    /**
     * @notice Event emitted when default AI Agent is updated
     */
    event DefaultAgentUpdated(address indexed oldAgent, address indexed newAgent);

    /**
     * @notice Updates the default AI Agent address
     * @param newAgent New AI Agent address
     */
    function setDefaultAgent(address newAgent) external;

    /**
     * @notice Creates a new Vault contract
     * @param asset Underlying asset token address
     * @param vaultMaster Address of the vault master
     * @param name Name of the vault token
     * @param symbol Symbol of the vault token
     * @return vault Address of the newly created vault
     */
    function createVault(
        IERC20 asset,
        address vaultMaster,
        string memory name,
        string memory symbol
    ) external returns (address vault);

    /**
     * @notice Returns all deployed vault addresses
     * @return Array of vault addresses
     */
    function getAllVaults() external view returns (address[] memory);

    /**
     * @notice Returns the total number of deployed vaults
     * @return Number of vaults
     */
    function getVaultCount() external view returns (uint256);

    /**
     * @notice Returns the default AI Agent address
     * @return Address of the default AI Agent
     */
    function defaultAgent() external view returns (address);
}
