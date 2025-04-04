// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC4626} from "@openzeppelin/contracts/token/ERC20/extensions/ERC4626.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {IHello} from "contracts/interface/IHello.sol";
import {Hello} from "contracts/Hello.sol";
import {HelloUpgradeable} from "contracts/HelloUpgradeable.sol";
import {IVaultFactory} from "contracts/interface/IVaultFactory.sol";
import {VaultFactory} from "contracts/VaultFactory.sol";
import {Constants} from "./Constants.sol";
import {Users} from "./Users.sol";

/// @title BaseFixture
/// @notice A base fixture for all test suites
abstract contract BaseFixture is Test, Constants {
    Users internal users;
    IHello internal hello;
    IHello internal helloUpgradeable;
    VaultFactory internal vaultFactory;

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
        /* deploy normal contracts */
        hello = IHello(new Hello("Pengtoshi Nakamoto"));

        /* deploy upgradeable contracts */
        address helloUpgradeableImplementation = address(new HelloUpgradeable());
        bytes memory helloUpgradeableInitData = abi.encodeCall(HelloUpgradeable.initialize, ("Pengtoshi Nakamoto"));
        address helloProxy = address(new ERC1967Proxy(helloUpgradeableImplementation, helloUpgradeableInitData));
        helloUpgradeable = IHello(helloProxy);

        /* deploy vault factory */
        address vaultFactoryImplementation = address(new VaultFactory());
        bytes memory vaultFactoryInitData = abi.encodeCall(VaultFactory.initialize, (users.agent));
        address vaultFactoryProxy = address(new ERC1967Proxy(vaultFactoryImplementation, vaultFactoryInitData));
        vaultFactory = VaultFactory(vaultFactoryProxy);
    }

    function createUser(string memory name) internal returns (address payable user) {
        user = payable(makeAddr({name: name}));
        // NOTE: Add common user setup here
    }
}
