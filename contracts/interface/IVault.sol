// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/interfaces/IERC4626.sol";
import "@openzeppelin/contracts/access/IAccessControl.sol";

/**
 * @title IVault
 * @notice Interface for the Vault contract that implements ERC4626 with yield injection functionality
 */
interface IVault is IERC4626, IAccessControl {
    /**
     * @notice Event emitted when yield is added to the vault
     */
    event YieldAdded(uint256 yieldAmount, uint256 newTotalAssets);

    /**
     * @notice Function for Vault Master to grant AI Agent role
     * @param agent Address to be granted AI Agent role
     */
    function grantAgentRole(address agent) external;

    /**
     * @notice Function for Vault Master to revoke AI Agent role
     * @param agent Address to revoke AI Agent role from
     */
    function revokeAgentRole(address agent) external;

    /**
     * @notice Function for AI Agent to add yield assets to the vault
     * @param yieldAmount Amount of yield to add
     */
    function addYield(uint256 yieldAmount) external;

    /**
     * @notice Returns the VAULT_MASTER_ROLE identifier
     * @return bytes32 representing the role
     */
    function VAULT_MASTER_ROLE() external view returns (bytes32);

    /**
     * @notice Returns the AGENT_ROLE identifier
     * @return bytes32 representing the role
     */
    function AGENT_ROLE() external view returns (bytes32);
}
