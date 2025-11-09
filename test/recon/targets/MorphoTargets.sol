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

abstract contract MorphoTargets is BaseTargetFunctions, Properties {
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    function morpho_withdraw_clamped(uint256 assets, uint256 shares, address onBehalf, address receiver) public asActor {
        // Clamp assets to reasonable bounds
        uint256 maxAssets = loanToken.balanceOf(_getActor());
        if (maxAssets > 0) {
            assets %= (maxAssets + 1);
        }
        
        // Clamp shares to user's supply shares
        (uint256 userSupplyShares,,) = morpho.position(defaultMarketId, _getActor());
        if (userSupplyShares > 0) {
            shares %= (userSupplyShares + 1);
        }
        
        // Use current actor for onBehalf and receiver to ensure authorization
        onBehalf = _getActor();
        receiver = _getActor();
        
        morpho_withdraw(defaultMarketParams, assets, shares, onBehalf, receiver);
    }

    function morpho_borrow_clamped(uint256 assets, uint256 shares, address onBehalf, address receiver) public asActor {
        // Get available liquidity
        (uint128 totalSupplyAssets, uint128 totalSupplyShares, uint128 totalBorrowAssets, uint128 totalBorrowShares,,) = morpho.market(defaultMarketId);
        uint256 availableLiquidity = totalSupplyAssets > totalBorrowAssets ? totalSupplyAssets - totalBorrowAssets : 0;
        
        // Clamp assets to available liquidity
        if (availableLiquidity > 0) {
            assets %= (availableLiquidity + 1);
        }
        
        // Clamp shares to total supply shares
        if (totalSupplyShares > 0) {
            shares %= (totalSupplyShares + 1);
        }
        
        // Use current actor for onBehalf and receiver
        onBehalf = _getActor();
        receiver = _getActor();
        
        morpho_borrow(defaultMarketParams, assets, shares, onBehalf, receiver);
    }

    function morpho_repay_clamped(uint256 assets, uint256 shares, address onBehalf, bytes memory data) public asActor {
        // Get user's borrow position
        (,uint128 borrowShares,) = morpho.position(defaultMarketId, _getActor());
        
        // Clamp assets to user's balance and borrow position
        uint256 maxAssets = loanToken.balanceOf(_getActor());
        if (maxAssets > 0) {
            assets %= (maxAssets + 1);
        }
        
        // Clamp shares to user's borrow shares
        if (borrowShares > 0) {
            shares %= (borrowShares + 1);
        }
        
        // Use current actor for onBehalf
        onBehalf = _getActor();
        
        morpho_repay(defaultMarketParams, assets, shares, onBehalf, data);
    }

    function morpho_liquidate_clamped(uint256 seizedAssets, uint256 repaidShares, address borrower, bytes memory data) public asActor {
        // Get borrower's position
        (uint256 supplyShares, uint128 borrowShares, uint128 collateral) = morpho.position(defaultMarketId, borrower);
        
        // Clamp seizedAssets to borrower's collateral
        if (collateral > 0) {
            seizedAssets %= (collateral + 1);
        }
        
        // Clamp repaidShares to borrower's borrow shares
        if (borrowShares > 0) {
            repaidShares %= (borrowShares + 1);
        }
        
        morpho_liquidate(defaultMarketParams, borrower, seizedAssets, repaidShares, data);
    }

    function morpho_liquidate_full_clamped(address borrower, bytes memory data) public asActor {
        // Get borrower's position for full liquidation
        (uint256 supplyShares, uint128 borrowShares, uint128 collateral) = morpho.position(defaultMarketId, borrower);
        
        morpho_liquidate(defaultMarketParams, borrower, collateral, borrowShares, data);
    }

    function morpho_liquidate_baddebt_clamped(address borrower, bytes memory data) public asActor {
        // Get borrower's position for bad debt scenario
        (uint256 supplyShares, uint128 borrowShares, uint128 collateral) = morpho.position(defaultMarketId, borrower);
        
        // Only proceed if borrower has both collateral and borrow shares
        if (collateral > 0 && borrowShares > 0) {
            // Seize all collateral to trigger collateral == 0 condition
            // Set repaidShares to 0 to satisfy exactlyOneZero requirement
            // The function will calculate the corresponding repaidShares
            uint256 seizedAssets = collateral;
            uint256 repaidShares = 0;
            
            morpho_liquidate(defaultMarketParams, borrower, seizedAssets, repaidShares, data);
        }
    }

    function morpho_setAuthorizationWithSig_clamped() public asActor {
        // Create authorization with current timestamp + 1 hour as deadline
        Authorization memory authorization = Authorization({
            authorizer: _getActor(),
            authorized: _getActor(),
            isAuthorized: true,
            nonce: morpho.nonce(_getActor()),
            deadline: block.timestamp + 3600
        });
        
        // Create a mock signature (this will be invalid but tests the validation logic)
        Signature memory signature = Signature({
            v: 27,
            r: bytes32(uint256(1)),
            s: bytes32(uint256(1))
        });
        
        morpho_setAuthorizationWithSig(authorization, signature);
    }

    function morpho_setAuthorizationWithSig_expired_clamped() public asActor {
        // Create authorization with past deadline to test expiration
        Authorization memory authorization = Authorization({
            authorizer: _getActor(),
            authorized: _getActor(),
            isAuthorized: true,
            nonce: morpho.nonce(_getActor()),
            deadline: block.timestamp - 1 // Expired
        });
        
        Signature memory signature = Signature({
            v: 27,
            r: bytes32(uint256(1)),
            s: bytes32(uint256(1))
        });
        
        morpho_setAuthorizationWithSig(authorization, signature);
    }

    function morpho_accrueInterest_clamped() public asActor {
        morpho_accrueInterest(defaultMarketParams);
    }

    function morpho_extSloads_clamped() public asActor {
        // Test various storage slots that are likely to exist
        bytes32[] memory slots = new bytes32[](6);
        slots[0] = bytes32(uint256(0)); // First storage slot
        slots[1] = bytes32(uint256(1)); // Second storage slot
        slots[2] = keccak256(abi.encode(defaultMarketId, uint256(0))); // Market storage slot
        slots[3] = keccak256(abi.encode(_getActor(), defaultMarketId, uint256(1))); // Position storage slot
        slots[4] = keccak256(abi.encode(_getActor(), _getActor(), uint256(2))); // Authorization storage slot
        slots[5] = keccak256(abi.encode(_getActor(), uint256(3))); // Nonce storage slot
        
        morpho.extSloads(slots);
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
