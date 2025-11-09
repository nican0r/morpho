# Coverage Preparation Information

## Build Info Path
The build info file is located at: `out/build-info/a0c1b72b6631da7c.json`

## Context Generation
Context information was generated using `sol-expand --extract-context out/build-info/a0c1b72b6631da7c.json`

The context output is available in the `context_output/` directory and contains detailed analysis of all contracts and their external calls.

## External Calls Analysis

Based on the context analysis, the Morpho contract makes external calls to the following interface types:

### Core External Interfaces
1. **IERC20** - For token operations (transfer, transferFrom, safeTransfer, safeTransferFrom)
2. **IOracle** - For price feeds (price() function)
3. **IIrm** - For interest rate models (borrowRate() function)

### Callback Interfaces
1. **IMorphoSupplyCallback** - onMorphoSupply() callback
2. **IMorphoLiquidateCallback** - onMorphoLiquidate() callback  
3. **IMorphoFlashLoanCallback** - onMorphoFlashLoan() callback
4. **IMorphoRepayCallback** - onMorphoRepay() callback
5. **IMorphoSupplyCollateralCallback** - onMorphoSupplyCollateral() callback

## Key Functions with External Calls

### Supply Function
- `IMorphoSupplyCallback::onMorphoSupply(uint256,bytes)`
- `IERC20::safeTransferFrom(contract IERC20,address,address,uint256)`

### Flash Loan Function  
- `IERC20::safeTransfer(contract IERC20,address,uint256)`
- `IMorphoFlashLoanCallback::onMorphoFlashLoan(uint256,bytes)`
- `IERC20::safeTransferFrom(contract IERC20,address,address,uint256)`

### Liquidate Function
- `IOracle::price()`
- `IERC20::safeTransfer(contract IERC20,address,uint256)`
- `IMorphoLiquidateCallback::onMorphoLiquidate(uint256,bytes)`
- `IERC20::safeTransferFrom(contract IERC20,address,address,uint256)`

### Accrue Interest Function
- `IIrm::borrowRate(struct MarketParams,struct Market)` (when irm != address(0))

## Library Dependencies
The Morpho contract also extensively uses internal libraries:
- MarketParamsLib
- MathLib  
- SharesMathLib
- UtilsLib
- ErrorsLib
- EventsLib
- ConstantsLib

These libraries are compiled into the Morpho contract and don't represent separate external contracts for fuzzing purposes.