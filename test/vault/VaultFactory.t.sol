// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "../common/BaseFixture.sol";

contract VaultFactoryTest is BaseFixture {
    function setUp() public virtual override {
        super.setUp();
    }

    function test_InitialState() public {
        assertEq(vaultFactory.owner(), users.owner);
        assertEq(vaultFactory.defaultAgent(), users.agent);
        assertEq(vaultFactory.getVaultCount(), 0);

        address[] memory vaults = vaultFactory.getAllVaults();
        assertEq(vaults.length, 0);
    }
}
