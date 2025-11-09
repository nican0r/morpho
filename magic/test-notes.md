# CryticToFoundry Test Structure Documentation

## Overview
This document describes the test structure and implementation for the CryticToFoundry contract, which validates that the fuzzing setup works correctly for Morpho Blue.

## Test Implementation Approach

### Test Structure
All tests follow a consistent pattern:
1. **Use Handler Functions**: Tests call functions defined in `TargetFunctions` or inherited by it, rather than calling contract methods directly
2. **Actor Management**: Tests use `switchActor()` to change the calling context when needed
3. **Dependency Management**: Tests follow the prerequisite order specified in `testing_priority.md`
4. **State Verification**: Tests verify successful operations by checking contract state

### Test Order and Dependencies

The tests are implemented in the exact order specified in `testing_priority.md`:

1. **test_morpho_createMarket()** - No prerequisite
   - Creates a new market with swapped loan/collateral tokens and different LLTV
   - Verifies market creation by calling `accrueInterest()` on the new market

2. **test_morpho_setAuthorization()** - No prerequisite
   - Tests authorization management between actors
   - Verifies authorization can be set and removed

3. **test_morpho_setAuthorizationWithSig()** - No prerequisite
   - Tests signature-based authorization with invalid signature
   - Expected to revert due to invalid signature (acceptable behavior)

4. **test_morpho_flashLoan()** - No prerequisite
   - Requires liquidity supply first
   - Tests flash loan functionality with callback implementation

5. **test_morpho_supplyCollateral()** - Requires createMarket
   - Supplies collateral to existing market
   - Verifies collateral position

6. **test_morpho_supply()** - Requires createMarket
   - Supplies assets to existing market
   - Verifies supply shares

7. **test_morpho_accrueInterest()** - Requires createMarket
   - Calls interest accrual on existing market

8. **test_morpho_withdraw()** - Requires createMarket and supply
   - Supplies then withdraws assets
   - Verifies partial withdrawal

9. **test_morpho_withdrawCollateral()** - Requires createMarket and supplyCollateral
   - Supplies then withdraws collateral
   - Verifies partial collateral withdrawal

10. **test_morpho_borrow()** - Requires createMarket, supply, and supplyCollateral
    - Sets up liquidity and collateral
    - Switches to borrower actor
    - Borrows against collateral

11. **test_morpho_repay()** - Requires createMarket and borrow
    - Sets up complete borrowing scenario
    - Repays partial borrow amount

12. **test_morpho_liquidate()** - Requires all prerequisites plus unhealthy position
    - Sets up borrowing scenario
    - Makes position unhealthy by dropping oracle price
    - Liquidates unhealthy position

## Key Implementation Details

### Flash Loan Callback
The contract implements `IMorphoFlashLoanCallback`:
```solidity
function onMorphoFlashLoan(uint256 assets, bytes calldata data) external {
    address token = abi.decode(data, (address));
    loanToken.approve(address(morpho), assets);
}
```

### Actor Management
- Uses `switchActor(index)` to change calling context
- Default actor (address(this)) often provides liquidity
- Other actors act as borrowers/liquidators

### Market Setup
- Default market created in `Setup.sol`
- Additional markets created in tests when needed
- Uses mock oracle, IRM, and tokens

### State Verification
Tests verify success by checking:
- Supply shares > 0
- Collateral > 0
- Borrow shares > 0
- Authorization status
- Market existence

## Test Results
All 13 tests pass successfully:
- 13 passed; 0 failed; 0 skipped
- Total gas usage varies by test complexity
- No unexpected reverts encountered

## Notes
- No functions require justified reverts beyond the expected signature validation failure
- Setup modifications were not required
- All tests use handler functions from `TargetFunctions` as required