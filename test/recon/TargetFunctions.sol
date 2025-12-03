// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";

// Targets
// NOTE: Always import and apply them in alphabetical order, so much easier to debug!
import {AdminTargets} from "./targets/AdminTargets.sol";
import {DoomsdayTargets} from "./targets/DoomsdayTargets.sol";
import {ManagersTargets} from "./targets/ManagersTargets.sol";
import {MorphoTargets} from "./targets/MorphoTargets.sol";

abstract contract TargetFunctions is AdminTargets, DoomsdayTargets, ManagersTargets, MorphoTargets {
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    // Shortcut for borrow: Creates market if needed, supplies liquidity, supplies collateral, then borrows
    function shortcut_borrow(uint256 supplyAmount, uint256 collateralAmount, uint256 borrowAmount) public {
        // Ensure market is created
        morpho_createMarket_clamped();
        
        // Supply liquidity with actor 0 (default actor)
        morpho_supply_clamped(supplyAmount);
        
        // Switch to actor 1 to supply collateral and borrow
        switchActor(1);
        morpho_supplyCollateral_clamped(collateralAmount);
        morpho_borrow_clamped(borrowAmount);
        
        // Switch back to default actor
        switchActor(0);
    }

    // Shortcut for liquidate: Creates market, supplies liquidity, supplies collateral, borrows, makes position unhealthy, then liquidates
    function shortcut_liquidate(uint256 supplyAmount, uint256 collateralAmount, uint256 borrowAmount, uint256 seizedAssets, uint256 repaidShares) public {
        // Ensure market is created
        morpho_createMarket_clamped();
        
        // Supply liquidity with actor 0
        morpho_supply_clamped(supplyAmount);
        
        // Switch to actor 1 to create a borrowing position
        switchActor(1);
        morpho_supplyCollateral_clamped(collateralAmount);
        morpho_borrow_clamped(borrowAmount);
        
        // Accrue interest to potentially make position unhealthy
        morpho_accrueInterest_clamped();
        
        // Switch to actor 0 to attempt liquidation
        switchActor(0);
        morpho_liquidate_clamped(seizedAssets, repaidShares);
    }

    // Shortcut for repay: Creates market, supplies liquidity, supplies collateral, borrows, then repays
    function shortcut_repay(uint256 supplyAmount, uint256 collateralAmount, uint256 borrowAmount, uint256 repayAssets, uint256 repayShares) public {
        // Ensure market is created
        morpho_createMarket_clamped();
        
        // Supply liquidity with actor 0
        morpho_supply_clamped(supplyAmount);
        
        // Switch to actor 1 to create a borrowing position
        switchActor(1);
        morpho_supplyCollateral_clamped(collateralAmount);
        morpho_borrow_clamped(borrowAmount);
        
        // Repay the loan
        morpho_repay_clamped(repayAssets, repayShares);
        
        // Switch back to default actor
        switchActor(0);
    }

    // Shortcut for withdraw: Creates market, supplies, then withdraws
    function shortcut_withdraw(uint256 supplyAmount, uint256 withdrawAssets, uint256 withdrawShares) public {
        // Ensure market is created
        morpho_createMarket_clamped();
        
        // Supply to the market
        morpho_supply_clamped(supplyAmount);
        
        // Withdraw from the market
        morpho_withdraw_clamped(withdrawAssets, withdrawShares);
    }

    // Shortcut for withdrawCollateral: Creates market, supplies collateral, then withdraws it
    function shortcut_withdrawCollateral(uint256 collateralAmount, uint256 withdrawAmount) public {
        // Ensure market is created
        morpho_createMarket_clamped();
        
        // Supply collateral
        morpho_supplyCollateral_clamped(collateralAmount);
        
        // Withdraw collateral
        morpho_withdrawCollateral_clamped(withdrawAmount);
    }

    // Shortcut for flashLoan with loanToken: Creates market, supplies liquidity, then executes flash loan
    function shortcut_flashLoan_loanToken(uint256 supplyAmount, uint256 flashLoanAmount) public {
        // Ensure market is created
        morpho_createMarket_clamped();
        
        // Supply liquidity to enable flash loans
        morpho_supply_clamped(supplyAmount);
        
        // Execute flash loan with loanToken
        morpho_flashLoan_clamped_loanToken(flashLoanAmount);
    }

    // Shortcut for flashLoan with collateralToken: Creates market, supplies collateral, then executes flash loan
    function shortcut_flashLoan_collateralToken(uint256 collateralAmount, uint256 flashLoanAmount) public {
        // Ensure market is created
        morpho_createMarket_clamped();
        
        // Supply collateral to enable flash loans
        morpho_supplyCollateral_clamped(collateralAmount);
        
        // Execute flash loan with collateralToken
        morpho_flashLoan_clamped_collateralToken(flashLoanAmount);
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}
