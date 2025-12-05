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
import {ERC20Mock} from "src/mocks/ERC20Mock.sol";

abstract contract MorphoTargets is BaseTargetFunctions, Properties {
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    // Clamped handler for accrueInterest
    function morpho_accrueInterest_clamped() public asActor {
        morpho_accrueInterest(defaultMarketParams);
    }

    // Clamped handler for borrow
    function morpho_borrow_clamped(uint256 assets, uint256 shares) public asActor {
        assets %= loanToken.balanceOf(address(morpho)) + 1;
        morpho_borrow(defaultMarketParams, assets, shares, _getActor(), _getActor());
    }

    // Clamped handler for createMarket
    function morpho_createMarket_clamped() public asActor {
        morpho_createMarket(defaultMarketParams);
    }

    // Clamped handlers for flashLoan with loanToken
    function morpho_flashLoan_loanToken_clamped(uint256 assets, bytes memory data) public asActor {
        assets %= loanToken.balanceOf(address(morpho)) + 1;
        morpho_flashLoan(address(loanToken), assets, data);
    }

    // Clamped handlers for flashLoan with collateralToken
    function morpho_flashLoan_collateralToken_clamped(uint256 assets, bytes memory data) public asActor {
        assets %= collateralToken.balanceOf(address(morpho)) + 1;
        morpho_flashLoan(address(collateralToken), assets, data);
    }

    // Clamped handler for liquidate - exploring seizedAssets > 0 path
    function morpho_liquidate_clamped_seizeAssets(uint256 seizedAssets, bytes memory data) public asActor {
        // Get a random borrower actor to liquidate
        address borrower = _getActor();
        
        // Get borrower's collateral to clamp seizedAssets properly
        Id id = defaultMarketParams.id();
        uint256 borrowerCollateral = morpho.position(id, borrower).collateral;
        
        // Clamp seizedAssets to borrower's available collateral to ensure we can seize
        if (borrowerCollateral > 0) {
            seizedAssets = (seizedAssets % borrowerCollateral) + 1;
        }
        
        // Call liquidate with seizedAssets specified (repaidShares = 0)
        morpho_liquidate(defaultMarketParams, borrower, seizedAssets, 0, data);
    }
    
    // Clamped handler for liquidate - exploring repaidShares > 0 path
    function morpho_liquidate_clamped_repayShares(uint256 repaidShares, bytes memory data) public asActor {
        // Get a random borrower actor to liquidate
        address borrower = _getActor();
        
        // Call liquidate with repaidShares specified (seizedAssets = 0)
        morpho_liquidate(defaultMarketParams, borrower, 0, repaidShares, data);
    }
    
    // Clamped handler for liquidate - fully seizing collateral to trigger bad debt path
    function morpho_liquidate_clamped_badDebt(bytes memory data) public asActor {
        // Get a random borrower actor to liquidate
        address borrower = _getActor();
        
        // Get borrower's collateral to fully seize it
        Id id = defaultMarketParams.id();
        uint256 borrowerCollateral = morpho.position(id, borrower).collateral;
        
        // Seize ALL collateral to trigger the bad debt handling at line 392
        if (borrowerCollateral > 0) {
            morpho_liquidate(defaultMarketParams, borrower, borrowerCollateral, 0, data);
        }
    }

    // Original clamped handler for liquidate
    function morpho_liquidate_clamped(uint256 seizedAssets, uint256 repaidShares, bytes memory data) public asActor {
        morpho_liquidate(defaultMarketParams, _getActor(), seizedAssets, repaidShares, data);
    }

    // Clamped handler for repay
    function morpho_repay_clamped(uint256 assets, uint256 shares, bytes memory data) public asActor {
        assets %= loanToken.balanceOf(_getActor()) + 1;
        morpho_repay(defaultMarketParams, assets, shares, _getActor(), data);
    }
    
    // Clamped handler for repay without callback data to avoid reverts
    function morpho_repay_clamped_noCallback(uint256 assets, uint256 shares) public asActor {
        assets %= loanToken.balanceOf(_getActor()) + 1;
        morpho_repay(defaultMarketParams, assets, shares, _getActor(), "");
    }

    // Clamped handler for setAuthorization
    function morpho_setAuthorization_clamped(bool newIsAuthorized) public asActor {
        morpho_setAuthorization(_getActor(), newIsAuthorized);
    }

    // Clamped handler for supply
    function morpho_supply_clamped(uint256 assets, uint256 shares, bytes memory data) public asActor {
        assets %= loanToken.balanceOf(_getActor()) + 1;
        morpho_supply(defaultMarketParams, assets, shares, _getActor(), data);
    }

    // Clamped handler for supplyCollateral
    function morpho_supplyCollateral_clamped(uint256 assets, bytes memory data) public asActor {
        assets %= collateralToken.balanceOf(_getActor()) + 1;
        morpho_supplyCollateral(defaultMarketParams, assets, _getActor(), data);
    }

    // Clamped handler for withdraw
    function morpho_withdraw_clamped(uint256 assets, uint256 shares) public asActor {
        morpho_withdraw(defaultMarketParams, assets, shares, _getActor(), _getActor());
    }

    // Clamped handler for withdrawCollateral
    function morpho_withdrawCollateral_clamped(uint256 assets) public asActor {
        morpho_withdrawCollateral(defaultMarketParams, assets, _getActor(), _getActor());
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function morpho_accrueInterest(MarketParams memory marketParams) public asActor {
        morpho.accrueInterest(marketParams);
    }

    function morpho_borrow(
        MarketParams memory marketParams,
        uint256 assets,
        uint256 shares,
        address onBehalf,
        address receiver
    ) public asActor {
        morpho.borrow(marketParams, assets, shares, onBehalf, receiver);
    }

    function morpho_createMarket(MarketParams memory marketParams) public asActor {
        morpho.createMarket(marketParams);
    }

    function morpho_flashLoan(address token, uint256 assets, bytes memory data) public asActor {
        morpho.flashLoan(token, assets, data);
    }

    function morpho_liquidate(
        MarketParams memory marketParams,
        address borrower,
        uint256 seizedAssets,
        uint256 repaidShares,
        bytes memory data
    ) public asActor {
        morpho.liquidate(marketParams, borrower, seizedAssets, repaidShares, data);
    }

    function morpho_repay(
        MarketParams memory marketParams,
        uint256 assets,
        uint256 shares,
        address onBehalf,
        bytes memory data
    ) public asActor {
        morpho.repay(marketParams, assets, shares, onBehalf, data);
    }

    function morpho_setAuthorization(address authorized, bool newIsAuthorized) public asActor {
        morpho.setAuthorization(authorized, newIsAuthorized);
    }

    function morpho_setAuthorizationWithSig(
        Authorization memory authorization,
        Signature memory signature
    ) public asActor {
        morpho.setAuthorizationWithSig(authorization, signature);
    }

    function morpho_supply(
        MarketParams memory marketParams,
        uint256 assets,
        uint256 shares,
        address onBehalf,
        bytes memory data
    ) public asActor {
        morpho.supply(marketParams, assets, shares, onBehalf, data);
    }

    function morpho_supplyCollateral(
        MarketParams memory marketParams,
        uint256 assets,
        address onBehalf,
        bytes memory data
    ) public asActor {
        morpho.supplyCollateral(marketParams, assets, onBehalf, data);
    }

    function morpho_withdraw(
        MarketParams memory marketParams,
        uint256 assets,
        uint256 shares,
        address onBehalf,
        address receiver
    ) public asActor {
        morpho.withdraw(marketParams, assets, shares, onBehalf, receiver);
    }

    function morpho_withdrawCollateral(
        MarketParams memory marketParams,
        uint256 assets,
        address onBehalf,
        address receiver
    ) public asActor {
        morpho.withdrawCollateral(marketParams, assets, onBehalf, receiver);
    }
}
