// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

// Morpho constants
import {ORACLE_PRICE_SCALE} from "src/libraries/ConstantsLib.sol";

// Targets
// NOTE: Always import and apply them in alphabetical order, so much easier to debug!
import {AdminTargets} from "./targets/AdminTargets.sol";
import {DoomsdayTargets} from "./targets/DoomsdayTargets.sol";
import {ManagersTargets} from "./targets/ManagersTargets.sol";
import {MorphoTargets} from "./targets/MorphoTargets.sol";

abstract contract TargetFunctions is AdminTargets, DoomsdayTargets, ManagersTargets, MorphoTargets {
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    /// @dev Shortcut to enable borrowing by setting up market, liquidity, and collateral
    function shortcut_borrow(uint256 supplyAssets, uint256 collateralAssets, uint256 borrowAssets, uint256 borrowShares) public {
        // Create market (already done in setup, but calling clamped version is safe)
        morpho_createMarket_clamped();
        
        // Actor 0: Supply liquidity to enable borrowing
        switchActor(0);
        morpho_supply_clamped(supplyAssets, 0, "");
        
        // Actor 1: Supply collateral and borrow
        switchActor(1);
        morpho_supplyCollateral_clamped(collateralAssets, "");
        morpho_borrow_clamped(borrowAssets, borrowShares);
    }

    /// @dev Shortcut to enable liquidation by creating an unhealthy position
    function shortcut_liquidate(uint256 supplyAssets, uint256 collateralAssets, uint256 borrowAssets, uint256 seizedAssets, uint256 repaidShares) public {
        // Create market
        morpho_createMarket_clamped();
        
        // Actor 0: Supply liquidity for borrowing
        switchActor(0);
        morpho_supply_clamped(supplyAssets, 0, "");
        
        // Actor 1: Supply collateral and borrow (will become liquidatable)
        switchActor(1);
        morpho_supplyCollateral_clamped(collateralAssets, "");
        morpho_borrow_clamped(borrowAssets, 0);
        
        // Manipulate oracle price to make position unhealthy
        // Price decrease makes collateral worth less, position becomes liquidatable
        vm.prank(address(this));
        oracle.setPrice(ORACLE_PRICE_SCALE / 2); // 50% price drop
        
        // Actor 0: Liquidate the unhealthy position
        switchActor(0);
        morpho_liquidate_clamped(seizedAssets, repaidShares, "");
    }

    /// @dev Shortcut to enable withdrawal by first supplying
    function shortcut_withdraw(uint256 supplyAssets, uint256 supplyShares, uint256 withdrawAssets, uint256 withdrawShares) public {
        // Create market
        morpho_createMarket_clamped();
        
        // Supply first
        morpho_supply_clamped(supplyAssets, supplyShares, "");
        
        // Then withdraw
        morpho_withdraw_clamped(withdrawAssets, withdrawShares);
    }

    /// @dev Shortcut to enable collateral withdrawal by first supplying collateral
    function shortcut_withdrawCollateral(uint256 supplyCollateralAssets, uint256 withdrawCollateralAssets) public {
        // Create market
        morpho_createMarket_clamped();
        
        // Supply collateral first
        morpho_supplyCollateral_clamped(supplyCollateralAssets, "");
        
        // Then withdraw collateral
        morpho_withdrawCollateral_clamped(withdrawCollateralAssets);
    }

    /// @dev Shortcut to enable repayment by first creating a borrow position
    function shortcut_repay(uint256 supplyAssets, uint256 collateralAssets, uint256 borrowAssets, uint256 repayAssets, uint256 repayShares) public {
        // Create market
        morpho_createMarket_clamped();
        
        // Actor 0: Supply liquidity
        switchActor(0);
        morpho_supply_clamped(supplyAssets, 0, "");
        
        // Actor 1: Supply collateral and borrow
        switchActor(1);
        morpho_supplyCollateral_clamped(collateralAssets, "");
        morpho_borrow_clamped(borrowAssets, 0);
        
        // Actor 1: Repay the borrowed amount
        morpho_repay_clamped(repayAssets, repayShares, "");
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}
