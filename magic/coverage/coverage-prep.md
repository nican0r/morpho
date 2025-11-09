# Coverage Preparation Information

## Build Info Path
- **Build Info File**: `/Users/nelsonpereira/Documents/GitHub/Auditing/Fuzzing/Recon_Fuzzing/Morpho_Fresh/morpho/out/build-info/b0af3eb34716fb74.json`
- **Context Output Directory**: `/Users/nelsonpereira/Documents/GitHub/Auditing/Fuzzing/Recon_Fuzzing/Morpho_Fresh/morpho/context_output/`

## External Calls Analysis

### Primary Contract: Morpho.sol

#### External Interface Calls
1. **IIrm Interface**
   - Function: `borrowRate(MarketParams, Market)`
   - Purpose: Get current borrow rate from interest rate model
   - Called in: `_accrueInterest()`

2. **IOracle Interface** 
   - Function: `price()`
   - Purpose: Get price feed for collateral valuation
   - Called in: `liquidate()`

3. **IERC20 Interface**
   - Functions: `safeTransferFrom()`, `safeTransfer()`
   - Purpose: Handle token transfers for supply/withdraw/borrow/repay/liquidate
   - Called in: `supply()`, `withdraw()`, `borrow()`, `repay()`, `liquidate()`, `flashLoan()`

4. **Callback Interfaces**
   - `IMorphoSupplyCallback.onMorphoSupply()`
   - `IMorphoLiquidateCallback.onMorphoLiquidate()`
   - `IMorphoFlashLoanCallback.onMorphoFlashLoan()`
   - Purpose: Optional callbacks for DeFi composability

### Library Dependencies
- **ConstantsLib**: System constants and parameters
- **UtilsLib**: Utility functions for validation and type conversion
- **EventsLib**: Event definitions for logging
- **ErrorsLib**: Error definitions
- **MathLib**: Mathematical operations (WAD math, mulDiv, etc.)
- **SharesMathLib**: Share-to-asset conversions
- **MarketParamsLib**: Market parameter utilities and ID generation
- **SafeTransferLib**: Safe token transfer utilities

## Contract Dependencies
Based on external calls analysis, the following contracts are touched:
- Core: `Morpho.sol`
- Interfaces: All callback interfaces and standard interfaces (IERC20, IIrm, IOracle)
- Libraries: All imported libraries (8 total libraries)

## Mock Contracts (Excluded from Coverage)
- `ERC20Mock.sol` - Test token mock
- `OracleMock.sol` - Test oracle mock  
- `IrmMock.sol` - Test interest rate model mock

## Setup Contract Analysis
The Setup contract deploys:
1. `Morpho` - Main protocol contract (INCLUDE)
2. `ERC20Mock` instances - Mock tokens (EXCLUDE)
3. `OracleMock` - Mock oracle (EXCLUDE)  
4. `IrmMock` - Mock IRM (EXCLUDE)