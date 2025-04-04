// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC4626} from "@openzeppelin/contracts/token/ERC20/extensions/ERC4626.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {AgentVaultFactory} from "contracts/AgentVaultFactory.sol";
import {Constants} from "./Constants.sol";
import {Utils} from "./Utils.sol";
import {Users} from "./Users.sol";

/// @title BaseFixture
/// @notice A base fixture for all test suites
abstract contract BaseFixture is Test, Constants, Utils {
    Users internal users;
    AgentVaultFactory internal vaultFactory;

    function setUp() public virtual {
        users = Users({
            owner: createUser("Owner"),
            alice: createUser("Alice"),
            bob: createUser("Bob"),
            charlie: createUser("Charlie"),
            agent: createUser("Agent")
        });

        vm.startPrank(users.owner);
        deployDependencies();
        vm.stopPrank();
    }

    function deployDependencies() public virtual {
        /* deploy vault factory */
        address vaultFactoryImplementation = address(new AgentVaultFactory());
        bytes memory vaultFactoryInitData = abi.encodeCall(AgentVaultFactory.initialize, ());
        address vaultFactoryProxy = address(new ERC1967Proxy(vaultFactoryImplementation, vaultFactoryInitData));
        vaultFactory = AgentVaultFactory(vaultFactoryProxy);
    }

    function createUser(string memory name) internal returns (address payable user) {
        user = payable(makeAddr({name: name}));
        // NOTE: Add common user setup here
    }
}
