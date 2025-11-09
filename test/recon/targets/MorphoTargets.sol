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
import {ORACLE_PRICE_SCALE, DOMAIN_TYPEHASH, AUTHORIZATION_TYPEHASH} from "src/libraries/ConstantsLib.sol";
import {ERC20Mock} from "src/mocks/ERC20Mock.sol";
import {OracleMock} from "src/mocks/OracleMock.sol";
import {IrmMock} from "src/mocks/IrmMock.sol";

abstract contract MorphoTargets is
    BaseTargetFunctions,
    Properties
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///

    // Use token balances for clamping instead of hardcoded values

    /// === CLAMPED SUPPLY HANDLERS ===

    /// @notice Clamped supply function - constrains amounts to valid ranges
    function morpho_supply_clamped(uint256 assets, uint256 shares) public asActor {
        // Clamp amounts to actor's token balance
        uint256 maxAssets = loanToken.balanceOf(_getActor());
        uint256 maxShares = maxAssets; // Approximate shares as assets for clamping
        
        // Ensure exactly one is zero as required by Morpho
        assets = (assets % (maxAssets + 1));
        shares = (shares % (maxShares + 1));
        
        // Set one to zero based on modulo to ensure exactly one is non-zero
        if ((assets + shares) % 2 == 0) {
            shares = 0;
        } else {
            assets = 0;
        }

        morpho_supply(defaultMarketParams, assets, shares, _getActor(), hex"");
    }

    /// @notice Supply pure assets (no shares) with clamped market
    function morpho_supply_clamped_assetsOnly(uint256 assets) public asActor {
        assets = assets % (loanToken.balanceOf(_getActor()) + 1);
        morpho_supply(defaultMarketParams, assets, 0, _getActor(), hex"");
    }

    /// === CLAMPED WITHDRAW HANDLERS ===

    /// @notice Clamped withdraw function - only withdraws what was supplied
    function morpho_withdraw_clamped(uint256 assets, uint256 shares) public asActor {
        address actor = _getActor();
        (uint256 supplyShares, , ) = morpho.position(defaultMarketId, actor);

        // Clamp to available supply (use shares-based withdrawal to avoid rounding issues)
        shares = shares % (supplyShares + 1);
        assets = 0;

        morpho_withdraw(defaultMarketParams, assets, shares, actor, actor);
    }

    /// === CLAMPED COLLATERAL HANDLERS ===

    /// @notice Clamped supply collateral function
    function morpho_supplyCollateral_clamped(uint256 assets) public asActor {
        // Clamp to actor's collateral token balance
        assets = assets % (collateralToken.balanceOf(_getActor()) + 1);

        morpho_supplyCollateral(defaultMarketParams, assets, _getActor(), hex"");
    }

    /// @notice Clamped withdraw collateral - only withdraws safe amounts
    function morpho_withdrawCollateral_clamped(uint256 assets) public asActor {
        address actor = _getActor();
        (, uint256 borrowShares, uint256 collateral) = morpho.position(defaultMarketId, actor);

        // Clamp to available collateral
        assets = assets % (collateral + 1);

        morpho_withdrawCollateral(defaultMarketParams, assets, actor, actor);
    }

    /// === CLAMPED BORROW HANDLERS ===

    /// @notice Clamped borrow function - ensures sufficient collateral first
    function morpho_borrow_clamped(uint256 assets, uint256 shares) public asActor {
        address actor = _getActor();
        (, uint256 borrowShares, uint256 collateral) = morpho.position(defaultMarketId, actor);

        // Clamp borrow amounts to reasonable values based on collateral
        uint256 maxBorrow = collateral > 0 ? collateral : 1;
        assets = assets % (maxBorrow + 1);
        shares = shares % (maxBorrow + 1);

        // Ensure exactly one is zero as required by Morpho
        if ((assets + shares) % 2 == 0) {
            shares = 0;
        } else {
            assets = 0;
        }

        morpho_borrow(defaultMarketParams, assets, shares, actor, actor);
    }

    /// === CLAMPED REPAY HANDLERS ===

    /// @notice Clamped repay function - only repays existing debt
    function morpho_repay_clamped(uint256 assets, uint256 shares) public asActor {
        address actor = _getActor();
        (, uint256 borrowShares, ) = morpho.position(defaultMarketId, actor);

        // Clamp to existing borrow shares
        shares = shares % (borrowShares + 1);
        assets = 0;

        morpho_repay(defaultMarketParams, assets, shares, actor, hex"");
    }

    /// === CLAMPED LIQUIDATE HANDLERS ===

    /// @notice Clamped liquidate - attempts to create and liquidate unhealthy positions
    function morpho_liquidate_clamped(address borrower, uint256 seizedAssets, uint256 repaidShares) public asActor {
        // Pick a borrower from actors
        address[] memory actors = _getActors();
        borrower = actors[uint256(uint160(borrower)) % actors.length];

        (, uint256 borrowShares, uint256 collateral) = morpho.position(defaultMarketId, borrower);

        // Clamp to available collateral and borrow shares
        seizedAssets = seizedAssets % (collateral + 1);
        repaidShares = repaidShares % (borrowShares + 1);

        morpho_liquidate(defaultMarketParams, borrower, seizedAssets, repaidShares, hex"");
    }

    /// === CLAMPED FLASHLOAN HANDLERS ===

    /// @notice Clamped flashloan - only borrows available liquidity
    function morpho_flashLoan_clamped(uint256 assets) public asActor {
        // Use loan token and clamp to available liquidity
        uint256 available = loanToken.balanceOf(address(morpho));
        assets = assets % (available + 1);

        morpho_flashLoan(address(loanToken), assets, hex"");
    }

    /// === CLAMPED AUTHORIZATION HANDLERS ===

    /// @notice Clamped authorization - uses valid addresses
    function morpho_setAuthorization_clamped(address authorized, bool newIsAuthorized) public asActor {
        // Pick from actors
        address[] memory actors = _getActors();
        authorized = actors[uint256(uint160(authorized)) % actors.length];

        morpho_setAuthorization(authorized, newIsAuthorized);
    }

    /// === CLAMPED ACCRUE INTEREST ===

    /// @notice Clamped accrue interest - always uses default market
    function morpho_accrueInterest_clamped() public {
        morpho_accrueInterest(defaultMarketParams);
    }

    /// === WORKFLOW SHORTCUT HANDLERS ===

    /// @notice Complete supply-borrow workflow with clamped values
    function workflow_supplyCollateralAndBorrow_clamped(uint256 collateralAmt, uint256 borrowAmt) public asActor {
        address actor = _getActor();

        // Clamp collateral to actor's balance
        collateralAmt = collateralAmt % (collateralToken.balanceOf(actor) + 1);

        // Supply collateral
        morpho.supplyCollateral(defaultMarketParams, collateralAmt, actor, hex"");

        // Clamp borrow to collateral amount
        borrowAmt = borrowAmt % (collateralAmt + 1);

        // Borrow
        morpho.borrow(defaultMarketParams, borrowAmt, 0, actor, actor);
    }

    /// @notice Supply loan tokens workflow
    function workflow_supplyLoan_clamped(uint256 assets) public asActor {
        assets = assets % (loanToken.balanceOf(_getActor()) + 1);
        morpho.supply(defaultMarketParams, assets, 0, _getActor(), hex"");
    }

    /// === COVERAGE TARGETING HANDLERS ===

    /// @notice Refined clamped setFee to trigger ALREADY_SET error (Line 126)
    function morpho_setFee_errorPath_clamped(uint256 newFee) public asAdmin {
        // Get current fee to trigger the error path
        (, , , , , uint128 currentFee) = morpho.market(defaultMarketId);
        
        // 80% chance to trigger the error path for better coverage
        if (newFee % 5 != 0) {
            newFee = uint256(currentFee); // This will trigger the ALREADY_SET error on line 126
        } else {
            // Use dictionary values for valid different fees (100, 1000 from dictionary)
            uint256[2] memory feeOptions = [uint256(100), uint256(1000)];
            newFee = feeOptions[newFee % 2]; // Select from dictionary fee values
        }
        
        morpho.setFee(defaultMarketParams, newFee);
    }

    /// @notice Refined clamped borrow using shares-based path (Line 252)
    function morpho_borrow_sharesBased_clamped(uint256 shares) public asActor {
        address actor = _getActor();
        (, uint256 existingBorrowShares, uint256 collateral) = morpho.position(defaultMarketId, actor);
        
        // Ensure we have some collateral to enable borrowing
        if (collateral == 0) {
            // Supply minimal collateral first
            uint256 collateralAmount = 1;
            morpho.supplyCollateral(defaultMarketParams, collateralAmount, actor, hex"");
        }
        
        // Force shares-based borrowing by setting assets=0 
        // Use meaningful share values to reach line 252
        if (existingBorrowShares > 0) {
            // Use existing borrow shares as range
            shares = shares % (existingBorrowShares + 1);
        } else {
            // If no existing shares, use small values to create new borrow
            shares = (shares % 10) + 1;
        }
        
        morpho.borrow(defaultMarketParams, 0, shares, actor, actor);
    }

    /// @notice Advanced bad debt scenario creation for liquidation (Lines 393-402)
    function morpho_liquidate_badDebt_clamped(uint256 scenario) public asActor {
        address[] memory actors = _getActors();
        address borrower = actors[scenario % actors.length];
        
        (, uint256 borrowShares, uint256 collateral) = morpho.position(defaultMarketId, borrower);
        
        // Multiple scenarios to trigger bad debt handling lines 393-402
        if (borrowShares > 0) {
            if (scenario % 3 == 0 && collateral > 0) {
                // Scenario 1: Withdraw all collateral first, then liquidate
                vm.prank(borrower);
                morpho.withdrawCollateral(defaultMarketParams, collateral, borrower, borrower);
                
                // Now liquidate with zero collateral - triggers bad debt path
                morpho.liquidate(defaultMarketParams, borrower, 0, borrowShares, hex"");
                
            } else if (scenario % 3 == 1) {
                // Scenario 2: Create position with minimal collateral, then borrow max
                if (collateral == 0) {
                    // Supply minimal collateral first
                    vm.prank(borrower);
                    morpho.supplyCollateral(defaultMarketParams, 1, borrower, hex"");
                }
                
                // Borrow maximum possible to create unhealthy position
                vm.prank(borrower);
                morpho.borrow(defaultMarketParams, borrowShares > 0 ? borrowShares : 1, 0, borrower, borrower);
                
                // Liquidate the unhealthy position
                morpho.liquidate(defaultMarketParams, borrower, 0, 1, hex"");
                
            } else {
                // Scenario 3: Direct liquidation attempt on zero collateral position
                if (collateral == 0) {
                    // This should directly trigger bad debt handling
                    morpho.liquidate(defaultMarketParams, borrower, 0, 1, hex"");
                }
            }
        }
    }

    /// @notice Advanced signature-based authorization to reach lines 457, 459
    function morpho_setAuthorizationWithSig_clamped(uint256 scenario) public asActor {
        address[] memory actors = _getActors();
        address authorizer = actors[scenario % actors.length];
        address authorized = actors[(scenario + 1) % actors.length];
        
        // Use dictionary values for nonce and deadline
        uint256 nonce;
        if (scenario % 4 == 0) nonce = 0;
        else if (scenario % 4 == 1) nonce = 1;
        else if (scenario % 4 == 2) nonce = 5;
        else nonce = 10;
        
        // Ensure deadline is valid (future)
        uint256 deadline;
        if (scenario % 3 == 0) deadline = block.timestamp + 60;    // 1 minute
        else if (scenario % 3 == 1) deadline = block.timestamp + 3600;  // 1 hour  
        else deadline = block.timestamp + 86400;   // 1 day
        
        // Vary authorization state to trigger different paths
        bool isAuthorized = (scenario % 3 != 0); // 2/3 chance of true
        
        // Create authorization structure
        Authorization memory authorization = Authorization({
            authorizer: authorizer,
            authorized: authorized,
            isAuthorized: isAuthorized,
            nonce: nonce,
            deadline: deadline
        });
        
        // Create multiple signature scenarios to reach lines 457, 459
        if (scenario % 4 == 0) {
            // Scenario 1: Valid signature structure using actual signing
            uint256 privateKey = uint256(keccak256(abi.encodePacked(authorizer, nonce)));
            (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, keccak256(abi.encodePacked(
                "\x19\x01",
                keccak256(abi.encode(DOMAIN_TYPEHASH, block.chainid, address(morpho))),
                keccak256(abi.encode(
                    AUTHORIZATION_TYPEHASH,
                    authorizer,
                    authorized,
                    isAuthorized,
                    nonce,
                    deadline
                ))
            )));
            
            Signature memory signature = Signature({v: v, r: r, s: s});
            morpho.setAuthorizationWithSig(authorization, signature);
            
        } else if (scenario % 4 == 1) {
            // Scenario 2: Invalid signature but valid structure
            Signature memory signature = Signature({
                v: 27,
                r: bytes32(uint256(1)),
                s: bytes32(uint256(1))
            });
            morpho.setAuthorizationWithSig(authorization, signature);
            
        } else if (scenario % 4 == 2) {
            // Scenario 3: Expired deadline
            authorization.deadline = block.timestamp - 1;
            Signature memory signature = Signature({
                v: 28,
                r: bytes32(uint256(2)),
                s: bytes32(uint256(2))
            });
            morpho.setAuthorizationWithSig(authorization, signature);
            
        } else {
            // Scenario 4: Replay protection (same nonce)
            // First call
            Signature memory signature1 = Signature({
                v: 27,
                r: bytes32(uint256(3)),
                s: bytes32(uint256(3))
            });
            morpho.setAuthorizationWithSig(authorization, signature1);
            
            // Second call with same nonce (should trigger nonce increment)
            morpho.setAuthorizationWithSig(authorization, signature1);
        }
    }

    /// @notice Simplified market creation with non-zero fees for fee distribution (Lines 499-501)
    function morpho_createMarket_withFees_clamped(uint256 fee) public asAdmin {
        // Force non-zero fees 90% of time to trigger fee distribution
        if (fee % 10 == 0) {
            fee = 0; // 10% chance for zero fee
        } else {
            // Use dictionary values for non-zero fees (100, 1000, 10000 from dictionary)
            uint256[3] memory feeOptions = [uint256(100), uint256(1000), uint256(10000)];
            fee = feeOptions[fee % 3]; // Select from dictionary fee values
        }
        
        // Create new market with non-zero fee
        ERC20Mock newLoanToken = new ERC20Mock();
        ERC20Mock newCollateralToken = new ERC20Mock();
        OracleMock newOracle = new OracleMock();
        IrmMock newIrm = new IrmMock();
        
        newOracle.setPrice(ORACLE_PRICE_SCALE);
        
        // Enable the new IRM and LLTV
        morpho.enableIrm(address(newIrm));
        morpho.enableLltv(0.8e18);
        
        MarketParams memory marketWithFees = MarketParams({
            loanToken: address(newLoanToken),
            collateralToken: address(newCollateralToken),
            oracle: address(newOracle),
            irm: address(newIrm),
            lltv: 0.8e18
        });
        
        morpho.createMarket(marketWithFees);
        morpho.setFee(marketWithFees, fee);
        
        // Simple liquidity setup to trigger fee distribution
        if (fee > 0) {
            newLoanToken.setBalance(address(this), 1000e18);
            newLoanToken.approve(address(morpho), 1000e18);
            morpho.supply(marketWithFees, 100e18, 0, address(this), hex"");
            morpho.accrueInterest(marketWithFees);
        }
    }

    /// @notice Enhanced extSloads utility testing for lines 549-552
    function morpho_extSloads_clamped(uint256 slotIndex) public {
        // Create larger arrays to ensure loop execution (lines 549-552)
        // Use meaningful array sizes from dictionary storage slot patterns
        uint256[3] memory sizeOptions = [uint256(3), uint256(5), uint256(7)];
        uint256 arraySize = sizeOptions[slotIndex % 3]; // Select from meaningful sizes
        bytes32[] memory slots = new bytes32[](arraySize);
        
        // Fill with meaningful storage slots to ensure loop runs
        for (uint256 i = 0; i < arraySize; i++) {
            if (i == 0) {
                slots[i] = bytes32(0); // Zero slot
            } else if (i == 1) {
                slots[i] = Id.unwrap(defaultMarketId); // Market ID slot
            } else if (i == 2) {
                slots[i] = bytes32(uint256(keccak256("position"))); // Position mapping slot
            } else if (i == 3) {
                slots[i] = bytes32(uint256(keccak256("market"))); // Market mapping slot
            } else {
                slots[i] = bytes32(uint256(slotIndex + i)); // Dynamic slots
            }
        }
        
        morpho.extSloads(slots);
    }

    /// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///

    function morpho_accrueInterest(MarketParams memory marketParams) public asActor {
        morpho.accrueInterest(marketParams);
    }

    function morpho_borrow(MarketParams memory marketParams, uint256 assets, uint256 shares, address onBehalf, address receiver) public asActor {
        morpho.borrow(marketParams, assets, shares, onBehalf, receiver);
    }

    function morpho_createMarket(MarketParams memory marketParams) public asActor {
        morpho.createMarket(marketParams);
    }

    function morpho_flashLoan(address token, uint256 assets, bytes memory data) public asActor {
        morpho.flashLoan(token, assets, data);
    }

    function morpho_liquidate(MarketParams memory marketParams, address borrower, uint256 seizedAssets, uint256 repaidShares, bytes memory data) public asActor {
        morpho.liquidate(marketParams, borrower, seizedAssets, repaidShares, data);
    }

    function morpho_repay(MarketParams memory marketParams, uint256 assets, uint256 shares, address onBehalf, bytes memory data) public asActor {
        morpho.repay(marketParams, assets, shares, onBehalf, data);
    }

    function morpho_setAuthorization(address authorized, bool newIsAuthorized) public asActor {
        morpho.setAuthorization(authorized, newIsAuthorized);
    }

    function morpho_setAuthorizationWithSig(Authorization memory authorization, Signature memory signature) public asActor {
        morpho.setAuthorizationWithSig(authorization, signature);
    }

    function morpho_supply(MarketParams memory marketParams, uint256 assets, uint256 shares, address onBehalf, bytes memory data) public asActor {
        morpho.supply(marketParams, assets, shares, onBehalf, data);
    }

    function morpho_supplyCollateral(MarketParams memory marketParams, uint256 assets, address onBehalf, bytes memory data) public asActor {
        morpho.supplyCollateral(marketParams, assets, onBehalf, data);
    }

    function morpho_withdraw(MarketParams memory marketParams, uint256 assets, uint256 shares, address onBehalf, address receiver) public asActor {
        morpho.withdraw(marketParams, assets, shares, onBehalf, receiver);
    }

    function morpho_withdrawCollateral(MarketParams memory marketParams, uint256 assets, address onBehalf, address receiver) public asActor {
        morpho.withdrawCollateral(marketParams, assets, onBehalf, receiver);
    }
}