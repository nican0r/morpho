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

    /// @dev Shortcut to enable borrowing by setting up market, liquidity, and collateral
    function shortcut_borrow(uint256 supplyAssets, uint256 collateralAssets, uint256 borrowAssets) public {
        // Ensure market is created (using clamped handler)
        morpho_createMarket_clamped();
        
        // Actor 0 supplies loan tokens to provide liquidity for borrows
        morpho_supply_clamped(supplyAssets, 0, "");
        
        // Switch to Actor 1 to supply collateral and borrow
        switchActor(1);
        morpho_supplyCollateral_clamped(collateralAssets, "");
        morpho_borrow_clamped(borrowAssets, 0);
        
        // Switch back to Actor 0
        switchActor(0);
    }

    /// @dev Shortcut to enable liquidation by creating an unhealthy position
    function shortcut_liquidate(uint256 supplyAssets, uint256 collateralAssets, uint256 borrowAssets, uint256 newPrice, uint256 seizedAssets) public {
        // Ensure market is created
        morpho_createMarket_clamped();
        
        // Actor 0 supplies loan tokens to provide liquidity
        morpho_supply_clamped(supplyAssets, 0, "");
        
        // Switch to Actor 1 to create a borrowing position
        switchActor(1);
        morpho_supplyCollateral_clamped(collateralAssets, "");
        morpho_borrow_clamped(borrowAssets, 0);
        
        // Change oracle price to make position liquidatable
        // Price increase makes collateral worth less relative to debt
        vm.prank(address(this));
        oracle.setPrice(newPrice);
        
        // Switch to Actor 0 to liquidate Actor 1's position
        switchActor(0);
        morpho_liquidate_clamped(seizedAssets, 0, "");
    }

    /// @dev Shortcut to enable withdrawal by first supplying
    function shortcut_withdraw(uint256 supplyAssets, uint256 withdrawAssets) public {
        // Ensure market is created
        morpho_createMarket_clamped();
        
        // Supply assets first
        morpho_supply_clamped(supplyAssets, 0, "");
        
        // Then withdraw
        morpho_withdraw_clamped(withdrawAssets, 0);
    }

    /// @dev Shortcut to enable collateral withdrawal by first supplying collateral
    function shortcut_withdrawCollateral(uint256 supplyCollateralAssets, uint256 withdrawAssets) public {
        // Ensure market is created
        morpho_createMarket_clamped();
        
        // Supply collateral first
        morpho_supplyCollateral_clamped(supplyCollateralAssets, "");
        
        // Then withdraw collateral
        morpho_withdrawCollateral_clamped(withdrawAssets);
    }

    /// @dev Shortcut to enable repayment by first borrowing
    function shortcut_repay(uint256 supplyAssets, uint256 collateralAssets, uint256 borrowAssets, uint256 repayAssets) public {
        // Ensure market is created
        morpho_createMarket_clamped();
        
        // Actor 0 supplies loan tokens to provide liquidity
        morpho_supply_clamped(supplyAssets, 0, "");
        
        // Switch to Actor 1 to borrow
        switchActor(1);
        morpho_supplyCollateral_clamped(collateralAssets, "");
        morpho_borrow_clamped(borrowAssets, 0);
        
        // Repay the borrowed amount
        morpho_repay_clamped(repayAssets, 0, "");
        
        // Switch back to Actor 0
        switchActor(0);
    }

    /// @dev Shortcut for flash loan to ensure market has liquidity
    function shortcut_flashLoan(uint256 supplyAssets, uint256 flashAssets, bytes memory data) public {
        // Ensure market is created
        morpho_createMarket_clamped();
        
        // Supply loan tokens to provide liquidity for flash loan
        morpho_supply_clamped(supplyAssets, 0, "");
        
        // Execute flash loan
        morpho_flashLoan_clamped(flashAssets, data);
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}
