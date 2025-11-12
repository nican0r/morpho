// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {FoundryAsserts} from "@chimera/FoundryAsserts.sol";

import "forge-std/console2.sol";

import {Test} from "forge-std/Test.sol";
import {TargetFunctions} from "./TargetFunctions.sol";
import {Authorization, Signature, Position, MarketParams, Id} from "src/interfaces/IMorpho.sol";
import {ORACLE_PRICE_SCALE} from "src/libraries/ConstantsLib.sol";
import {IMorphoFlashLoanCallback} from "src/interfaces/IMorphoCallbacks.sol";

// forge test --match-contract CryticToFoundry -vv
contract CryticToFoundry is Test, TargetFunctions, FoundryAsserts, IMorphoFlashLoanCallback {
    function setUp() public {
        setup();

        targetContract(address(this));
    }

    // forge test --match-test test_crytic -vvv
    function test_crytic() public {
        // TODO: add failing property tests here for debugging
    }
}
