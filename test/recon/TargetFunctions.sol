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
    /// Prerequisite functions: morpho_createMarket, morpho_supply, morpho_supplyCollateral
    function shortcut_borrow(uint256 supplyAmount, uint256 supplyShares, uint256 collateralAmount, uint256 borrowAmount, uint256 borrowShares) public {
        // Create market
        morpho_createMarket_clamped();
        
        // Supply liquidity with default actor
        morpho_supply_clamped(supplyAmount, supplyShares, "");
        
        // Switch to different actor to supply collateral and borrow
        switchActor(1);
        morpho_supplyCollateral_clamped(collateralAmount, "");
        morpho_borrow_clamped(borrowAmount, borrowShares);
        
        // Switch back to default actor
        switchActor(0);
    }
    
    /// @dev Shortcut to enable liquidation by setting up market, liquidity, collateral, borrow, and price crash
    /// Prerequisite functions: morpho_createMarket, morpho_supply, morpho_supplyCollateral, morpho_borrow, oracle_decreasePrice
    function shortcut_liquidate(uint256 supplyAmount, uint256 collateralAmount, uint256 borrowAmount, uint256 seizedAssets, uint256 repaidShares) public {
        // Create market
        morpho_createMarket_clamped();
        
        // Supply liquidity with default actor
        morpho_supply_clamped(supplyAmount, 0, "");
        
        // Switch to different actor to supply collateral and borrow
        switchActor(1);
        morpho_supplyCollateral_clamped(collateralAmount, "");
        morpho_borrow_clamped(borrowAmount, 0);
        
        // Accrue interest
        morpho_accrueInterest_clamped();
        
        // Crash price to make position liquidatable
        oracle_decreasePrice(50);
        
        // Switch back to default actor to execute liquidation
        switchActor(0);
        morpho_liquidate_clamped(seizedAssets, repaidShares, "");
    }
    
    /// @dev Shortcut to enable repayment by setting up market, liquidity, collateral, and borrow
    /// Prerequisite functions: morpho_createMarket, morpho_supply, morpho_supplyCollateral, morpho_borrow
    function shortcut_repay(uint256 supplyAmount, uint256 collateralAmount, uint256 borrowAmount, uint256 repayAssets, uint256 repayShares) public {
        // Create market
        morpho_createMarket_clamped();
        
        // Supply liquidity with default actor
        morpho_supply_clamped(supplyAmount, 0, "");
        
        // Switch to different actor to supply collateral and borrow
        switchActor(1);
        morpho_supplyCollateral_clamped(collateralAmount, "");
        morpho_borrow_clamped(borrowAmount, 0);
        
        // Repay the borrowed amount
        morpho_repay_clamped(repayAssets, repayShares, "");
        
        // Switch back to default actor
        switchActor(0);
    }
    
    /// @dev Shortcut to enable withdrawal by setting up market and supply
    /// Prerequisite functions: morpho_createMarket, morpho_supply, morpho_withdraw
    function shortcut_withdraw(uint256 supplyAmount, uint256 withdrawAssets, uint256 withdrawShares) public {
        // Create market
        morpho_createMarket_clamped();
        
        // Supply liquidity
        morpho_supply_clamped(supplyAmount, 0, "");
        
        // Withdraw the supplied amount
        morpho_withdraw_clamped(withdrawAssets, withdrawShares);
    }
    
    /// @dev Shortcut to enable flash loan with sufficient liquidity
    /// Prerequisite functions: morpho_createMarket, morpho_supply, morpho_flashLoan
    function shortcut_flashLoan_loanToken(uint256 supplyAmount, uint256 loanAmount) public {
        // Create market
        morpho_createMarket_clamped();
        
        // Supply liquidity to enable flash loan
        morpho_supply_clamped(supplyAmount, 0, "");
        
        // Execute flash loan on loan token
        morpho_flashLoan_loanToken_clamped(loanAmount, "");
    }
    
    /// @dev Shortcut to enable flash loan with sufficient collateral liquidity
    /// Prerequisite functions: morpho_createMarket, morpho_supplyCollateral, morpho_flashLoan
    function shortcut_flashLoan_collateralToken(uint256 collateralAmount, uint256 loanAmount) public {
        // Create market
        morpho_createMarket_clamped();
        
        // Supply collateral to enable flash loan
        morpho_supplyCollateral_clamped(collateralAmount, "");
        
        // Execute flash loan on collateral token
        morpho_flashLoan_collateralToken_clamped(loanAmount, "");
    }
    
    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
}
