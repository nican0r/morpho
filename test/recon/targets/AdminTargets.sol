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

    // Clamped handler for enableIrm
    function morpho_enableIrm_clamped() public asAdmin {
        morpho.enableIrm(address(irm));
    }

    // Clamped handler for enableLltv with 0.5e18
    function morpho_enableLltv_clamped_05e18() public asAdmin {
        morpho.enableLltv(0.5e18);
    }

    // Clamped handler for enableLltv with 0.8e18
    function morpho_enableLltv_clamped_08e18() public asAdmin {
        morpho.enableLltv(0.8e18);
    }

    // Clamped handler for setFee
    function morpho_setFee_clamped(uint256 newFee_) public asAdmin {
        uint256 newFee = between(newFee_, 0, MAX_FEE);
        morpho.setFee(defaultMarketParams, newFee);
    }

    // Clamped handler for setFeeRecipient
    function morpho_setFeeRecipient_clamped() public asAdmin {
        morpho.setFeeRecipient(_getActor());
    }

    // Clamped handler for setOwner
    function morpho_setOwner_clamped() public asAdmin {
        morpho.setOwner(_getActor());
    }

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
