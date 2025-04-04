// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC4626.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "./interface/IStrategy.sol";
import "./interface/IAgentVault.sol";

/**
 * @title AgentVault
 * @notice Implementation of IAgentVault interface
 * - Users can deposit/withdraw assets
 * - On deposit, Vault calls Strategy.beforeDeposit() and then uses Strategy.deposit() to manage accumulated funds
 * - On withdrawal, if Vault balance is insufficient, it calls Strategy.withdraw() to secure funds
 * - AI Agent (or Vault Master) can change Strategy using setStrategy()
 * - Can be created/deployed by AgentVaultFactory
 */
contract AgentVault is IAgentVault, ERC4626, AccessControl, ReentrancyGuard {
    bytes32 public constant VAULT_MASTER_ROLE = keccak256("VAULT_MASTER_ROLE");
    bytes32 public constant AGENT_ROLE = keccak256("AGENT_ROLE");

    /// @inheritdoc IAgentVault
    IStrategy public override strategy;

    /**
     * @notice Constructor for AgentVault
     * @param asset_ ERC20 asset address for deposits/withdrawals
     * @param _strategy Initial Strategy contract address (its want() must match asset_)
     * @param vaultMaster Vault Master address
     * @param agent AI Agent address
     * @param name Vault token name
     * @param symbol Vault token symbol
     */
    constructor(
        IERC20 asset_,
        IStrategy _strategy,
        address vaultMaster,
        address agent,
        string memory name,
        string memory symbol
    ) ERC20(name, symbol) ERC4626(asset_) {
        require(address(asset_) == address(_strategy.want()), "Vault: asset mismatch with strategy");
        strategy = _strategy;
        // Pre-approve strategy to use vault's assets (maximum amount)
        IERC20(asset_).approve(address(strategy), type(uint256).max);

        // Set roles
        _grantRole(VAULT_MASTER_ROLE, vaultMaster);
        _setRoleAdmin(AGENT_ROLE, VAULT_MASTER_ROLE);
        if (agent != address(0)) {
            _grantRole(AGENT_ROLE, agent);
        }
    }

    /// @inheritdoc IAgentVault
    function totalAssets() public view override(ERC4626, IAgentVault) returns (uint256) {
        return IERC20(asset()).balanceOf(address(this)) + strategy.balanceOf();
    }

    /// @inheritdoc IAgentVault
    function earn() public {
        uint256 available = IERC20(asset()).balanceOf(address(this));
        if (available > 0) {
            IERC20(asset()).transfer(address(strategy), available);
            strategy.deposit();
        }
    }

    /// @inheritdoc IAgentVault
    function deposit(
        uint256 assets,
        address receiver
    ) public override(ERC4626, IAgentVault) nonReentrant returns (uint256 shares) {
        // Pre-work related to strategy (e.g., harvest)
        strategy.beforeDeposit();
        shares = super.deposit(assets, receiver);
        earn();
        return shares;
    }

    /// @inheritdoc IAgentVault
    function withdraw(
        uint256 assets,
        address receiver,
        address owner
    ) public override(ERC4626, IAgentVault) nonReentrant returns (uint256 shares) {
        uint256 currentBalance = IERC20(asset()).balanceOf(address(this));
        if (currentBalance < assets) {
            uint256 needed = assets - currentBalance;
            strategy.withdraw(needed);
        }
        shares = super.withdraw(assets, receiver, owner);
        return shares;
    }

    /// @inheritdoc IAgentVault
    function depositAll() external returns (uint256 shares) {
        uint256 balance = IERC20(asset()).balanceOf(msg.sender);
        return deposit(balance, msg.sender);
    }

    /// @inheritdoc IAgentVault
    function withdrawAll() external returns (uint256 shares) {
        return withdraw(balanceOf(msg.sender), msg.sender, msg.sender);
    }

    /// @inheritdoc IAgentVault
    function setStrategy(IStrategy newStrategy) external {
        require(hasRole(VAULT_MASTER_ROLE, msg.sender) || hasRole(AGENT_ROLE, msg.sender), "Caller is not authorized");
        require(address(asset()) == address(newStrategy.want()), "Vault: new strategy asset mismatch");

        strategy.retireStrategy();
        strategy = newStrategy;
        // Pre-approve new strategy to use vault's assets
        IERC20(asset()).approve(address(newStrategy), type(uint256).max);
        earn();
        emit StrategyChanged(address(newStrategy));
    }

    /// @inheritdoc IAgentVault
    function grantAgentRole(address agent) external {
        require(hasRole(VAULT_MASTER_ROLE, msg.sender), "Caller is not a vault master");
        grantRole(AGENT_ROLE, agent);
    }

    /// @inheritdoc IAgentVault
    function revokeAgentRole(address agent) external {
        require(hasRole(VAULT_MASTER_ROLE, msg.sender), "Caller is not a vault master");
        revokeRole(AGENT_ROLE, agent);
    }
}
