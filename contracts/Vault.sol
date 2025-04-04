// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC4626.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "./interface/IVault.sol";

/**
 * @title Vault
 * @notice ERC-4626 Tokenized Vault with additional yield injection functionality.
 *
 * Manages Vault Master and AI Agent roles using AccessControl.
 * Vault Master acts as an admin role, and AI Agent role performs yield addition functionality.
 */
contract Vault is ERC4626, AccessControl, IVault {
    bytes32 public constant VAULT_MASTER_ROLE = keccak256("VAULT_MASTER_ROLE");
    bytes32 public constant AGENT_ROLE = keccak256("AGENT_ROLE");

    /// @dev Internal asset tracking to prevent inflation attacks
    /// @dev https://blog.openzeppelin.com/a-novel-defense-against-erc4626-inflation-attacks
    uint256 private _internalTotalAssets;

    /// @dev Error for zero assets
    error ZeroAssets();

    /// @notice Constructor
    /// @param asset ERC-20 underlying asset token address (e.g., USDC)
    /// @param vaultMaster Address of the vault master
    /// @param agent Address of the AI agent
    /// @param name Name of the vault token
    /// @param symbol Symbol of the vault token
    constructor(
        IERC20 asset,
        address vaultMaster,
        address agent,
        string memory name,
        string memory symbol
    ) ERC4626(asset) ERC20(name, symbol) {
        _grantRole(VAULT_MASTER_ROLE, vaultMaster);
        _setRoleAdmin(AGENT_ROLE, VAULT_MASTER_ROLE);
        if (agent != address(0)) {
            _grantRole(AGENT_ROLE, agent);
        }
    }

    /// @inheritdoc IVault
    function grantAgentRole(address agent) external onlyVaultMaster {
        grantRole(AGENT_ROLE, agent);
    }

    /// @inheritdoc IVault
    function revokeAgentRole(address agent) external onlyVaultMaster {
        revokeRole(AGENT_ROLE, agent);
    }

    /**
     * @dev Modifier to check Vault Master role
     */
    modifier onlyVaultMaster() {
        require(hasRole(VAULT_MASTER_ROLE, msg.sender), "Vault: Caller is not a vault master");
        _;
    }

    /// @inheritdoc IVault
    function addYield(uint256 yieldAmount) external {
        require(hasRole(AGENT_ROLE, msg.sender), "Vault: Caller is not an AI Agent");
        require(yieldAmount > 0, "Vault: yield amount must be > 0");

        bool success = IERC20(asset()).transferFrom(msg.sender, address(this), yieldAmount);
        require(success, "Vault: yield transfer failed");

        _internalTotalAssets += yieldAmount;
        emit YieldAdded(yieldAmount, totalAssets());
    }

    /// @dev Override _deposit to handle zero assets check and internal asset tracking
    function _deposit(address caller, address receiver, uint256 assets, uint256 shares) internal virtual override {
        if (assets == 0) revert ZeroAssets();

        // Call parent implementation first
        super._deposit(caller, receiver, assets, shares);

        // Update internal asset tracking
        _internalTotalAssets += assets;
    }

    /// @dev Override _withdraw to handle zero assets check and internal asset tracking
    function _withdraw(
        address caller,
        address receiver,
        address owner,
        uint256 assets,
        uint256 shares
    ) internal virtual override {
        if (assets == 0) revert ZeroAssets();

        // Call parent implementation first
        super._withdraw(caller, receiver, owner, assets, shares);

        // Update internal asset tracking
        _internalTotalAssets -= assets;
    }

    /// @dev Override totalAssets to use internal tracking instead of direct balance check
    function totalAssets() public view virtual override(ERC4626, IERC4626) returns (uint256) {
        return _internalTotalAssets;
    }
}
