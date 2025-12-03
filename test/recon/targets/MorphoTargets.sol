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
        morpho.accrueInterest(defaultMarketParams);
    }

    // Clamped handler for borrow
    function morpho_borrow_clamped(uint256 assets_) public asActor {
        (uint128 totalSupplyAssets,,,,,) = morpho.market(defaultMarketId);
        uint256 maxAssets = uint256(totalSupplyAssets);
        uint256 assets = maxAssets > 0 ? between(assets_, 0, maxAssets) : 0;
        morpho.borrow(defaultMarketParams, assets, 0, _getActor(), _getActor());
    }

    // Clamped handler for createMarket
    function morpho_createMarket_clamped() public asActor {
        morpho.createMarket(defaultMarketParams);
    }

    // Clamped handler for flashLoan with loanToken
    function morpho_flashLoan_clamped_loanToken(uint256 assets_) public asActor {
        uint256 maxAssets = loanToken.balanceOf(address(morpho));
        uint256 assets = maxAssets > 0 ? between(assets_, 0, maxAssets) : 0;
        morpho.flashLoan(address(loanToken), assets, "");
    }

    // Clamped handler for flashLoan with collateralToken
    function morpho_flashLoan_clamped_collateralToken(uint256 assets_) public asActor {
        uint256 maxAssets = collateralToken.balanceOf(address(morpho));
        uint256 assets = maxAssets > 0 ? between(assets_, 0, maxAssets) : 0;
        morpho.flashLoan(address(collateralToken), assets, "");
    }

    // Clamped handler for liquidate
    function morpho_liquidate_clamped(uint256 seizedAssets_, uint256 repaidShares_) public asActor {
        address borrower = _getActor();
        (, uint128 borrowShares, uint128 collateral) = morpho.position(defaultMarketId, borrower);
        uint256 maxSeizedAssets = uint256(collateral);
        uint256 maxRepaidShares = uint256(borrowShares);
        uint256 seizedAssets = maxSeizedAssets > 0 ? between(seizedAssets_, 0, maxSeizedAssets) : 0;
        uint256 repaidShares = maxRepaidShares > 0 ? between(repaidShares_, 0, maxRepaidShares) : 0;
        morpho.liquidate(defaultMarketParams, borrower, seizedAssets, repaidShares, "");
    }

    // Clamped handler for repay
    function morpho_repay_clamped(uint256 assets_, uint256 shares_) public asActor {
        (, uint128 borrowShares,) = morpho.position(defaultMarketId, _getActor());
        uint256 maxAssets = loanToken.balanceOf(_getActor());
        uint256 maxShares = uint256(borrowShares);
        uint256 assets = maxAssets > 0 ? between(assets_, 0, maxAssets) : 0;
        uint256 shares = maxShares > 0 ? between(shares_, 0, maxShares) : 0;
        morpho.repay(defaultMarketParams, assets, shares, _getActor(), "");
    }

    // Clamped handler for setAuthorization
    function morpho_setAuthorization_clamped(bool newIsAuthorized) public asActor {
        morpho.setAuthorization(_getActor(), newIsAuthorized);
    }

    // Clamped handler for setAuthorizationWithSig
    function morpho_setAuthorizationWithSig_clamped() public asActor {
        Authorization memory authorization = Authorization({
            authorizer: _getActor(),
            authorized: _getActor(),
            isAuthorized: true,
            nonce: morpho.nonce(_getActor()),
            deadline: block.timestamp + 1 days
        });
        Signature memory signature = Signature({v: 0, r: bytes32(0), s: bytes32(0)});
        morpho.setAuthorizationWithSig(authorization, signature);
    }

    // Clamped handler for supply
    function morpho_supply_clamped(uint256 assets_) public asActor {
        uint256 maxAssets = loanToken.balanceOf(_getActor());
        uint256 assets = maxAssets > 0 ? between(assets_, 0, maxAssets) : 0;
        morpho.supply(defaultMarketParams, assets, 0, _getActor(), "");
    }

    // Clamped handler for supplyCollateral
    function morpho_supplyCollateral_clamped(uint256 assets_) public asActor {
        uint256 maxAssets = collateralToken.balanceOf(_getActor());
        uint256 assets = maxAssets > 0 ? between(assets_, 0, maxAssets) : 0;
        morpho.supplyCollateral(defaultMarketParams, assets, _getActor(), "");
    }

    // Clamped handler for withdraw
    function morpho_withdraw_clamped(uint256 assets_, uint256 shares_) public asActor {
        (uint128 totalSupplyAssets,,,,,) = morpho.market(defaultMarketId);
        (uint256 supplyShares,,) = morpho.position(defaultMarketId, _getActor());
        uint256 maxAssets = uint256(totalSupplyAssets);
        uint256 maxShares = supplyShares;
        uint256 assets = maxAssets > 0 ? between(assets_, 0, maxAssets) : 0;
        uint256 shares = maxShares > 0 ? between(shares_, 0, maxShares) : 0;
        morpho.withdraw(defaultMarketParams, assets, shares, _getActor(), _getActor());
    }

    // Clamped handler for withdrawCollateral
    function morpho_withdrawCollateral_clamped(uint256 assets_) public asActor {
        (,, uint128 collateral) = morpho.position(defaultMarketId, _getActor());
        uint256 maxAssets = uint256(collateral);
        uint256 assets = maxAssets > 0 ? between(assets_, 0, maxAssets) : 0;
        morpho.withdrawCollateral(defaultMarketParams, assets, _getActor(), _getActor());
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
