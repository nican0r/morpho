// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

// Targets
// NOTE: Always import and apply them in alphabetical order, so much easier to debug!
import { AdminTargets } from "./targets/AdminTargets.sol";
import { DoomsdayTargets } from "./targets/DoomsdayTargets.sol";
import { ManagersTargets } from "./targets/ManagersTargets.sol";
import { MorphoTargets } from "./targets/MorphoTargets.sol";

abstract contract TargetFunctions is
    AdminTargets,
    DoomsdayTargets,
    ManagersTargets,
    MorphoTargets
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    function shortcut_borrow(uint256 supplyAmount, uint256 collateralAmount, uint256 borrowAmount) public {
        // Create market first
        morpho_createMarket_clamped();
        
        // Supply liquidity with default actor
        morpho_supply_clamped(supplyAmount, 0, _getActor(), "");
        
        // Switch to different actor to supply collateral and borrow
        switchActor(1);
        morpho_supplyCollateral_clamped(collateralAmount, _getActor(), "");
        morpho_borrow_clamped(borrowAmount, 0, _getActor(), _getActor());
    }

    function shortcut_liquidate(uint256 supplyAmount, uint256 collateralAmount, uint256 borrowAmount, uint256 liquidateAmount) public {
        // Create market first
        morpho_createMarket_clamped();
        
        // Supply liquidity with default actor
        morpho_supply_clamped(supplyAmount, 0, _getActor(), "");
        
        // Switch to different actor to supply collateral and borrow
        switchActor(1);
        morpho_supplyCollateral_clamped(collateralAmount, _getActor(), "");
        morpho_borrow_clamped(borrowAmount, 0, _getActor(), _getActor());
        
        // Switch back to default actor to liquidate
        switchActor(0);
        morpho_liquidate_clamped(_getActor(1), liquidateAmount, 0, "");
    }

    function shortcut_accrueInterest(uint256 supplyAmount, uint256 borrowAmount) public {
        // Create market first
        morpho_createMarket_clamped();
        
        // Supply liquidity with default actor
        morpho_supply_clamped(supplyAmount, 0, _getActor(), "");
        
        // Switch to different actor to borrow
        switchActor(1);
        morpho_borrow_clamped(borrowAmount, 0, _getActor(), _getActor());
        
        // Switch back to default actor to accrue interest
        switchActor(0);
        morpho_accrueInterest_clamped();
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}
