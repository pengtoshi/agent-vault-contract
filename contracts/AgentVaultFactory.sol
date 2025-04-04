// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./AgentVault.sol";
import "./interface/IVaultFactory.sol";

/**
 * @title AgentVaultFactory
 * @notice Factory contract for deploying and managing AgentVault contracts
 */
contract AgentVaultFactory is IVaultFactory, Initializable, OwnableUpgradeable, UUPSUpgradeable {
    /// @notice Default AI Agent address used for all created vaults
    address public defaultAgent;

    /// @notice Array to store all deployed vault addresses
    address[] public vaults;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address initialAgent) public initializer {
        __Ownable_init(msg.sender);
        __UUPSUpgradeable_init();

        defaultAgent = initialAgent;
    }

    /// @inheritdoc IVaultFactory
    function setDefaultAgent(address newAgent) external onlyOwner {
        address oldAgent = defaultAgent;
        defaultAgent = newAgent;
        emit DefaultAgentUpdated(oldAgent, newAgent);
    }

    /// @inheritdoc IVaultFactory
    function createVault(
        IERC20 asset,
        IStrategy strategy,
        address vaultMaster,
        string memory name,
        string memory symbol
    ) external onlyOwner returns (address vault) {
        require(address(asset) != address(0), "ERC20: invalid contract address");
        require(vaultMaster != address(0), "Vault: invalid vault master");

        vault = address(new AgentVault(asset, strategy, vaultMaster, defaultAgent, name, symbol));
        vaults.push(vault);
        emit VaultCreated(vault, address(asset), name, symbol);
    }

    /// @inheritdoc IVaultFactory
    function getAllVaults() external view returns (address[] memory) {
        return vaults;
    }

    /// @inheritdoc IVaultFactory
    function getVaultCount() external view returns (uint256) {
        return vaults.length;
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
}
