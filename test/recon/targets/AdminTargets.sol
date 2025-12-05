// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {BeforeAfter} from "../BeforeAfter.sol";
import {Properties} from "../Properties.sol";
// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

import "src/Morpho.sol";
import {MAX_FEE} from "src/libraries/ConstantsLib.sol";

abstract contract AdminTargets is BaseTargetFunctions, Properties {
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    // Admin-only functions that require owner privileges
    function morpho_enableIrm(address irm) public asAdmin {
        morpho.enableIrm(irm);
    }

    function morpho_enableLltv(uint256 lltv) public asAdmin {
        morpho.enableLltv(lltv);
    }

    function morpho_setFee(MarketParams memory marketParams, uint256 newFee) public asAdmin {
        morpho.setFee(marketParams, newFee);
    }

    function morpho_setFeeRecipient(address newFeeRecipient) public asAdmin {
        morpho.setFeeRecipient(newFeeRecipient);
    }

    function morpho_setOwner(address newOwner) public asAdmin {
        morpho.setOwner(newOwner);
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}
