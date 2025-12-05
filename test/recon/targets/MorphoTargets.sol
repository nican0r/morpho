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
import {AUTHORIZATION_TYPEHASH} from "src/libraries/ConstantsLib.sol";

abstract contract MorphoTargets is BaseTargetFunctions, Properties {
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    // Clamped handler for accrueInterest
    function morpho_accrueInterest_clamped() public {
        morpho_accrueInterest(defaultMarketParams);
    }

    // Clamped handler for borrow
    function morpho_borrow_clamped(uint256 assets, uint256 shares) public {
        assets %= ERC20Mock(defaultMarketParams.loanToken).balanceOf(address(morpho)) + 1;
        morpho_borrow(defaultMarketParams, assets, shares, _getActor(), _getActor());
    }

    // Clamped handler for createMarket
    function morpho_createMarket_clamped() public {
        morpho_createMarket(defaultMarketParams);
    }

    // Clamped handler for flashLoan with loanToken
    function morpho_flashLoan_loanToken_clamped(uint256 assets, bytes memory data) public {
        assets %= ERC20Mock(address(loanToken)).balanceOf(address(morpho)) + 1;
        morpho_flashLoan(address(loanToken), assets, data);
    }

    // Clamped handler for flashLoan with collateralToken
    function morpho_flashLoan_collateralToken_clamped(uint256 assets, bytes memory data) public {
        assets %= ERC20Mock(address(collateralToken)).balanceOf(address(morpho)) + 1;
        morpho_flashLoan(address(collateralToken), assets, data);
    }

    // Clamped handler for liquidate
    function morpho_liquidate_clamped(uint256 seizedAssets, uint256 repaidShares, bytes memory data) public {
        address borrower = _getActor();
        (, uint128 borrowerBorrowShares, uint128 borrowerCollateral) = morpho.position(defaultMarketId, borrower);
        seizedAssets %= borrowerCollateral + 1;
        repaidShares %= borrowerBorrowShares + 1;
        morpho_liquidate(defaultMarketParams, borrower, seizedAssets, repaidShares, data);
    }

    // Clamped handler for liquidate - seize all collateral to trigger bad debt branch
    function morpho_liquidate_full_seizure_clamped(uint256 repaidShares, bytes memory data) public {
        address borrower = _getActor();
        (, uint128 borrowerBorrowShares, uint128 borrowerCollateral) = morpho.position(defaultMarketId, borrower);
        // Seize exactly all collateral to trigger the bad debt handling at line 392
        uint256 seizedAssets = borrowerCollateral;
        repaidShares %= borrowerBorrowShares + 1;
        morpho_liquidate(defaultMarketParams, borrower, seizedAssets, repaidShares, data);
    }

    // Clamped handler for repay
    function morpho_repay_clamped(uint256 assets, uint256 shares, bytes memory data) public {
        address onBehalf = _getActor();
        (, uint128 borrowShares, ) = morpho.position(defaultMarketId, onBehalf);
        assets %= ERC20Mock(defaultMarketParams.loanToken).balanceOf(_getActor()) + 1;
        shares %= borrowShares + 1;
        morpho_repay(defaultMarketParams, assets, shares, onBehalf, data);
    }

    // Clamped handler for repay without callback - to cover line 295
    function morpho_repay_no_callback_clamped(uint256 assets, uint256 shares) public {
        address onBehalf = _getActor();
        (, uint128 borrowShares, ) = morpho.position(defaultMarketId, onBehalf);
        assets %= ERC20Mock(defaultMarketParams.loanToken).balanceOf(_getActor()) + 1;
        shares %= borrowShares + 1;
        // Pass empty data to skip callback and hit line 295 directly
        morpho_repay(defaultMarketParams, assets, shares, onBehalf, "");
    }

    // Clamped handler for setAuthorization
    function morpho_setAuthorization_clamped(bool newIsAuthorized) public {
        morpho_setAuthorization(_getActor(), newIsAuthorized);
    }

    // Clamped handler for setAuthorizationWithSig
    function morpho_setAuthorizationWithSig_clamped(bool isAuthorized, uint256 deadline, Signature memory signature) public {
        address authorizer = _getActor();
        address authorized = _getActor();
        uint256 nonce = morpho.nonce(authorizer);
        Authorization memory authorization = Authorization({
            authorizer: authorizer,
            authorized: authorized,
            isAuthorized: isAuthorized,
            nonce: nonce,
            deadline: deadline
        });
        morpho_setAuthorizationWithSig(authorization, signature);
    }

    // Clamped handler for setAuthorizationWithSig with valid signature
    function morpho_setAuthorizationWithSig_valid_clamped(bool isAuthorized, uint256 privateKeyIndex) public {
        // Use a deterministic private key based on actor index
        // privateKey must be in range [1, secp256k1 curve order)
        uint256 privateKey = 1 + (privateKeyIndex % 10); // Use keys 1-10
        address authorizer = vm.addr(privateKey);
        address authorized = _getActor();
        uint256 nonce = morpho.nonce(authorizer);
        
        // Clamp deadline to be valid (current block timestamp or later)
        uint256 deadline = block.timestamp + 1 hours;
        
        Authorization memory authorization = Authorization({
            authorizer: authorizer,
            authorized: authorized,
            isAuthorized: isAuthorized,
            nonce: nonce,
            deadline: deadline
        });

        // Generate valid signature
        bytes32 hashStruct = keccak256(abi.encode(
            AUTHORIZATION_TYPEHASH,
            authorization
        ));
        bytes32 digest = keccak256(bytes.concat("\x19\x01", morpho.DOMAIN_SEPARATOR(), hashStruct));
        
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, digest);
        Signature memory signature = Signature({v: v, r: r, s: s});

        // Execute without prank since we need msg.sender to be anyone, authorizer is in the signature
        morpho.setAuthorizationWithSig(authorization, signature);
    }

    // Clamped handler for supply
    function morpho_supply_clamped(uint256 assets, uint256 shares, bytes memory data) public {
        address onBehalf = _getActor();
        (uint256 supplyShares, , ) = morpho.position(defaultMarketId, onBehalf);
        assets %= ERC20Mock(defaultMarketParams.loanToken).balanceOf(_getActor()) + 1;
        shares %= supplyShares + 1;
        morpho_supply(defaultMarketParams, assets, shares, onBehalf, data);
    }

    // Clamped handler for supplyCollateral
    function morpho_supplyCollateral_clamped(uint256 assets, bytes memory data) public {
        address onBehalf = _getActor();
        assets %= ERC20Mock(defaultMarketParams.collateralToken).balanceOf(_getActor()) + 1;
        morpho_supplyCollateral(defaultMarketParams, assets, onBehalf, data);
    }

    // Clamped handler for withdraw
    function morpho_withdraw_clamped(uint256 assets, uint256 shares) public {
        address onBehalf = _getActor();
        (uint256 supplyShares, , ) = morpho.position(defaultMarketId, onBehalf);
        assets %= supplyShares + 1;
        shares %= supplyShares + 1;
        morpho_withdraw(defaultMarketParams, assets, shares, onBehalf, _getActor());
    }

    // Clamped handler for withdrawCollateral
    function morpho_withdrawCollateral_clamped(uint256 assets) public {
        address onBehalf = _getActor();
        (, , uint128 collateral) = morpho.position(defaultMarketId, onBehalf);
        assets %= collateral + 1;
        morpho_withdrawCollateral(defaultMarketParams, assets, onBehalf, _getActor());
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
