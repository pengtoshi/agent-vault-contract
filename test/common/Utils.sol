// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "forge-std/Test.sol";
import {TestToken} from "contracts/mock/TestToken.sol";

abstract contract Utils is Test {
    function mintTestTokens(address user, TestToken token, uint256 amount) internal {
        vm.startPrank(user);
        token.mint(user, amount);
        vm.stopPrank();
    }
}
