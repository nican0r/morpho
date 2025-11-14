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
import "src/interfaces/IMorpho.sol";
import {SharesMathLib} from "src/libraries/SharesMathLib.sol";

abstract contract MorphoTargets is BaseTargetFunctions, Properties {
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    function morpho_accrueInterest_clamped() public {
        morpho_accrueInterest(defaultMarketParams);
    }

    function morpho_borrow_clamped(
        uint256 assets,
        uint256 shares,
        address onBehalf,
        address receiver
    ) public {
        assets %= loanToken.balanceOf(_getActor()) + 1;
        (,uint256 totalSupplyShares,,,,) = morpho.market(defaultMarketId);
        shares %= totalSupplyShares + 1;
        onBehalf = _getActor();
        receiver = _getActor();
        
        morpho_borrow(defaultMarketParams, assets, shares, onBehalf, receiver);
    }

    function morpho_createMarket_clamped() public {
        morpho_createMarket(defaultMarketParams);
    }

    function morpho_flashLoan_clamped(uint256 assets, bytes memory data) public {
        assets %= loanToken.balanceOf(address(morpho)) + 1;
        
        morpho_flashLoan(address(loanToken), assets, data);
    }

    function morpho_liquidate_clamped(
        address borrower,
        uint256 seizedAssets,
        uint256 repaidShares,
        bytes memory data
    ) public {
        borrower = _getActor();
        (,,uint128 collateral) = morpho.position(defaultMarketId, _getActor());
        (,uint128 borrowShares,) = morpho.position(defaultMarketId, _getActor());
        seizedAssets %= collateral + 1;
        repaidShares %= borrowShares + 1;
        
        morpho_liquidate(defaultMarketParams, borrower, seizedAssets, repaidShares, data);
    }

    function morpho_repay_clamped(
        uint256 assets,
        uint256 shares,
        address onBehalf,
        bytes memory data
    ) public {
        assets %= loanToken.balanceOf(_getActor()) + 1;
        (,uint128 borrowShares,) = morpho.position(defaultMarketId, _getActor());
        shares %= borrowShares + 1;
        onBehalf = _getActor();
        
        morpho_repay(defaultMarketParams, assets, shares, onBehalf, data);
    }

    function morpho_setAuthorization_clamped(bool newIsAuthorized) public {
        morpho_setAuthorization(_getActor(), newIsAuthorized);
    }

    function morpho_setAuthorizationWithSig_clamped(Signature memory signature) public {
        Authorization memory authorization = Authorization({
            authorizer: _getActor(),
            authorized: _getActor(),
            isAuthorized: true,
            nonce: 0,
            deadline: block.timestamp + 1 days
        });
        
        morpho_setAuthorizationWithSig(authorization, signature);
    }

    function morpho_supply_clamped(
        uint256 assets,
        uint256 shares,
        address onBehalf,
        bytes memory data
    ) public {
        assets %= loanToken.balanceOf(_getActor()) + 1;
        (,uint256 totalSupplyShares,,,,) = morpho.market(defaultMarketId);
        shares %= totalSupplyShares + 1;
        onBehalf = _getActor();
        
        morpho_supply(defaultMarketParams, assets, shares, onBehalf, data);
    }

    function morpho_supplyCollateral_clamped(
        uint256 assets,
        address onBehalf,
        bytes memory data
    ) public {
        assets %= collateralToken.balanceOf(_getActor()) + 1;
        onBehalf = _getActor();
        
        morpho_supplyCollateral(defaultMarketParams, assets, onBehalf, data);
    }

    function morpho_withdraw_clamped(
        uint256 assets,
        uint256 shares,
        address onBehalf,
        address receiver
    ) public {
        (uint256 totalSupplyAssets, uint256 totalSupplyShares,,,,) = morpho.market(defaultMarketId);
        (uint256 supplyShares,,) = morpho.position(defaultMarketId, _getActor());
        assets %= SharesMathLib.toAssetsDown(
            supplyShares,
            totalSupplyAssets,
            totalSupplyShares
        ) + 1;
        shares %= supplyShares + 1;
        onBehalf = _getActor();
        receiver = _getActor();
        
        morpho_withdraw(defaultMarketParams, assets, shares, onBehalf, receiver);
    }

    function morpho_withdrawCollateral_clamped(
        uint256 assets,
        address onBehalf,
        address receiver
    ) public {
        (,,uint128 collateral) = morpho.position(defaultMarketId, _getActor());
        assets %= collateral + 1;
        onBehalf = _getActor();
        receiver = _getActor();
        
        morpho_withdrawCollateral(defaultMarketParams, assets, onBehalf, receiver);
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
