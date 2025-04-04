// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./IStrategy.sol";

/**
 * @title IAgentVaultFactory
 * @notice Interface for the VaultFactory contract that manages vault creation and administration
 */
interface IAgentVaultFactory {
    /**
     * @notice Event emitted when a new vault is created
     */
    event VaultCreated(address indexed vault, address indexed asset, string name, string symbol);

    /**
     * @notice Creates a new AgentVault.
     * @param asset The ERC20 asset address for deposit/withdraw operations.
     * @param strategy The strategy contract address that AgentVault will use.
     * @param vaultMaster The address that will have the VAULT_MASTER_ROLE in the new vault.
     * @param agent The address that will have the AGENT_ROLE in the new vault.
     * @param name The name of the vault token.
     * @param symbol The symbol of the vault token.
     * @return vault The address of the newly deployed AgentVault contract.
     */
    function createVault(
        IERC20 asset,
        IStrategy strategy,
        address vaultMaster,
        address agent,
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
}
