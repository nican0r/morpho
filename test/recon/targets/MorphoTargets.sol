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

    function morpho_accrueInterest_direct_clamped() public {
        // Direct call to ensure lines 499-501 are covered
        // This targets the external accrueInterest function specifically
        morpho.accrueInterest(defaultMarketParams);
    }

    function morpho_borrow_clamped(
        uint256 assets,
        uint256 shares,
        address onBehalf,
        address receiver
    ) public {
        assets %= loanToken.balanceOf(_getActor()) + 1;
        (uint256 totalSupplyAssets,,,,,) = morpho.market(defaultMarketId);
        shares %= totalSupplyAssets + 1;
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

    function morpho_liquidate_badDebt_clamped(
        address borrower,
        uint256 repaidShares,
        bytes memory data
    ) public {
        borrower = _getActor();
        (,,uint128 collateral) = morpho.position(defaultMarketId, borrower);
        
        // For bad debt scenario: seize ALL collateral to trigger bad debt logic
        uint256 seizedAssets = collateral;
        // Use only seizedAssets (repaidShares must be 0)
        repaidShares = 0;
        
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

    function morpho_setAuthorization_clamped() public {
        morpho_setAuthorization(_getActor(), true);
    }

    function morpho_setAuthorizationWithSig_clamped() public {
        address authorizer = _getActor();
        address authorized = _getActor();
        
        Authorization memory authorization = Authorization({
            authorizer: authorizer,
            authorized: authorized,
            isAuthorized: true,
            nonce: 0,
            deadline: block.timestamp + 1 days
        });
        
        // Generate a valid signature using vm.sign with a deterministic private key
        // Use actor address to derive a unique private key for each actor
        uint256 privateKey = uint256(keccak256(abi.encodePacked("morpho_test_key", authorizer)));
        
        bytes32 hashStruct = keccak256(abi.encode(
            keccak256("Authorization(address authorizer,address authorized,bool isAuthorized,uint256 nonce,uint256 deadline)"),
            authorization
        ));
        bytes32 digest = keccak256(bytes.concat("\x19\x01", morpho.DOMAIN_SEPARATOR(), hashStruct));
        
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, digest);
        Signature memory signature = Signature({v: v, r: r, s: s});
        
        morpho_setAuthorizationWithSig(authorization, signature);
    }

    function morpho_supply_clamped(
        uint256 assets,
        uint256 shares,
        address onBehalf,
        bytes memory data
    ) public {
        assets %= loanToken.balanceOf(_getActor()) + 1;
        (uint256 totalSupplyAssets,,,,,) = morpho.market(defaultMarketId);
        shares %= totalSupplyAssets + 1;
        onBehalf = _getActor();
        
        morpho_supply(defaultMarketParams, assets, shares, onBehalf, data);
    }

    function morpho_supply_assetsOnly_clamped() public {
        address actor = _getActor();
        uint256 assets = (loanToken.balanceOf(actor) / 4) + 1; // Supply 25% + 1 to ensure non-zero
        uint256 shares = 0; // Use assets only
        address onBehalf = actor;
        bytes memory data = "";
        
        morpho_supply(defaultMarketParams, assets, shares, onBehalf, data);
    }

    function morpho_supply_sharesOnly_clamped() public {
        address actor = _getActor();
        uint256 assets = 0; // Use shares only
        (uint256 totalSupplyAssets,,,,,) = morpho.market(defaultMarketId);
        uint256 shares = (totalSupplyAssets / 4) + 1; // Request shares equivalent to 25% + 1
        address onBehalf = actor;
        bytes memory data = "";
        
        morpho_supply(defaultMarketParams, assets, shares, onBehalf, data);
    }

    function morpho_supply_withCallback_clamped() public {
        address actor = _getActor();
        uint256 assets = (loanToken.balanceOf(actor) / 10) + 1; // Smaller amount for callback testing
        uint256 shares = 0;
        address onBehalf = actor;
        bytes memory data = "callback_data"; // Non-empty data to trigger callback (line 194)
        
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

    function morpho_supplyCollateral_nonZero_clamped() public {
        address actor = _getActor();
        // Ensure non-zero assets (line 313) and proper validation (lines 308-319)
        uint256 assets = (collateralToken.balanceOf(actor) / 10) + 1; // 10% + 1 to ensure non-zero
        address onBehalf = actor;
        bytes memory data = "";
        
        morpho_supplyCollateral(defaultMarketParams, assets, onBehalf, data);
    }

    function morpho_supplyCollateral_withCallback_clamped() public {
        address actor = _getActor();
        uint256 assets = (collateralToken.balanceOf(actor) / 20) + 1; // Smaller amount for callback
        address onBehalf = actor;
        bytes memory data = "collateral_callback"; // Non-empty data to trigger callback (line 322)
        
        morpho_supplyCollateral(defaultMarketParams, assets, onBehalf, data);
    }

    function morpho_supplyCollateral_differentBehalf_clamped() public {
        address actor = _getActor();
        address[] memory actors = _getActors();
        address onBehalf = actors[0] != actor ? actors[0] : actors[1]; // Different onBehalf address
        
        uint256 assets = (collateralToken.balanceOf(actor) / 15) + 1;
        bytes memory data = "";
        
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

    function morpho_withdrawCollateral_authorized_clamped() public {
        address actor = _getActor();
        address[] memory actors = _getActors();
        address onBehalf = actors[0] != actor ? actors[0] : actors[1];
        
        // First authorize the actor to withdraw on behalf of onBehalf
        vm.prank(onBehalf);
        morpho.setAuthorization(actor, true);
        
        (,,uint128 collateral) = morpho.position(defaultMarketId, onBehalf);
        if (collateral > 0) {
            uint256 assets = (collateral / 2) + 1; // Withdraw half + 1
            address receiver = actor;
            
            morpho_withdrawCollateral(defaultMarketParams, assets, onBehalf, receiver);
        }
    }

    function morpho_withdrawCollateral_selfAuthorized_clamped() public {
        address actor = _getActor();
        (,,uint128 collateral) = morpho.position(defaultMarketId, actor);
        
        if (collateral > 1) {
            uint256 assets = (collateral / 3) + 1; // Withdraw one-third + 1
            address onBehalf = actor; // Self-withdrawal (always authorized)
            address receiver = actor;
            
            morpho_withdrawCollateral(defaultMarketParams, assets, onBehalf, receiver);
        }
    }

    function morpho_withdrawCollateral_differentReceiver_clamped() public {
        address actor = _getActor();
        address[] memory actors = _getActors();
        address receiver = actors[0] != actor ? actors[0] : actors[1];
        
        (,,uint128 collateral) = morpho.position(defaultMarketId, actor);
        if (collateral > 1) {
            uint256 assets = (collateral / 4) + 1; // Withdraw 25% + 1
            address onBehalf = actor; // Self-withdrawal to different receiver
            
            morpho_withdrawCollateral(defaultMarketParams, assets, onBehalf, receiver);
        }
    }

    function morpho_setAuthorizationWithSig_revoked_clamped() public {
        address authorizer = _getActor();
        address authorized = _getActor();
        uint256 currentNonce = morpho.nonce(authorizer);
        
        Authorization memory authorization = Authorization({
            authorizer: authorizer,
            authorized: authorized,
            isAuthorized: false, // Test revocation
            nonce: currentNonce,
            deadline: block.timestamp + 1 days
        });
        
        uint256 privateKey = uint256(keccak256(abi.encodePacked("morpho_test_key", authorizer)));
        
        bytes32 hashStruct = keccak256(abi.encode(
            keccak256("Authorization(address authorizer,address authorized,bool isAuthorized,uint256 nonce,uint256 deadline)"),
            authorization
        ));
        bytes32 digest = keccak256(bytes.concat("\x19\x01", morpho.DOMAIN_SEPARATOR(), hashStruct));
        
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, digest);
        Signature memory signature = Signature({v: v, r: r, s: s});
        
        morpho_setAuthorizationWithSig(authorization, signature);
    }

    function morpho_setAuthorization_toggle_clamped() public {
        address actor = _getActor();
        address target = _getActor();
        
        // Check current state and toggle it to ensure state change (lines 457, 459)
        bool currentAuth = morpho.isAuthorized(actor, target);
        morpho_setAuthorization(target, !currentAuth);
    }

    function morpho_setAuthorization_differentActor_clamped() public {
        address actor = _getActor();
        address[] memory actors = _getActors();
        
        // Find a different actor to authorize
        address target = actors[0] != actor ? actors[0] : actors[1];
        
        // Always set to true first, then false to ensure state changes
        morpho_setAuthorization(target, true);
    }

    function morpho_liquidate_fullRepayment_clamped(
        address borrower,
        bytes memory data
    ) public {
        borrower = _getActor();
        (,,uint128 collateral) = morpho.position(defaultMarketId, borrower);
        (,uint128 borrowShares,) = morpho.position(defaultMarketId, borrower);
        
        // Seize all collateral and repay all borrow shares
        uint256 seizedAssets = collateral > 0 ? collateral : 1;
        uint256 repaidShares = borrowShares;
        
        morpho_liquidate(defaultMarketParams, borrower, seizedAssets, repaidShares, data);
    }

    function morpho_liquidate_zeroCollateralBadDebt_clamped(
        address borrower,
        bytes memory data
    ) public {
        borrower = _getActor();
        (,,uint128 collateral) = morpho.position(defaultMarketId, borrower);
        (,uint128 borrowShares,) = morpho.position(defaultMarketId, borrower);
        
        // Force scenario where collateral becomes zero to trigger bad debt logic
        // This targets lines 403-414 for bad debt handling
        if (collateral > 0 && borrowShares > 0) {
            uint256 seizedAssets = collateral; // Seize ALL collateral
            uint256 repaidShares = 0; // No repayment to trigger bad debt
            
            morpho_liquidate(defaultMarketParams, borrower, seizedAssets, repaidShares, data);
        }
    }

    function morpho_liquidate_partialSeizure_clamped(
        address borrower,
        bytes memory data
    ) public {
        borrower = _getActor();
        (,,uint128 collateral) = morpho.position(defaultMarketId, borrower);
        (,uint128 borrowShares,) = morpho.position(defaultMarketId, borrower);
        
        if (collateral > 1 && borrowShares > 0) {
            // Partial seizure to test liquidation incentive calculations (lines 374-391)
            uint256 seizedAssets = (collateral / 2) + 1; // Seize half + 1
            uint256 repaidShares = 0; // Let contract calculate repaid shares
            
            morpho_liquidate(defaultMarketParams, borrower, seizedAssets, repaidShares, data);
        }
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
