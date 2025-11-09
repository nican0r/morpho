# Functions to Cover

## Core Protocol Functions (Morpho.sol)

### Public-facing Functions Called via TargetFunctions

#### Supply Management
- `supply(MarketParams,uint256,uint256,address,bytes)` - Core supply function
- `withdraw(MarketParams,uint256,uint256,address,address)` - Core withdraw function

#### Borrow Management  
- `borrow(MarketParams,uint256,uint256,address,address)` - Core borrow function
- `repay(MarketParams,uint256,uint256,address,bytes)` - Core repay function

#### Collateral Management
- `supplyCollateral(MarketParams,uint256,address,bytes)` - Supply collateral
- `withdrawCollateral(MarketParams,uint256,address,address)` - Withdraw collateral

#### Liquidation
- `liquidate(MarketParams,address,uint256,uint256,bytes)` - Liquidate unhealthy positions

#### Flash Loans
- `flashLoan(address,uint256,bytes)` - Flash loan functionality

#### Authorization
- `setAuthorization(address,bool)` - Set authorization for address
- `setAuthorizationWithSig(Authorization,Signature)` - Set authorization with signature

#### Market Creation
- `createMarket(MarketParams)` - Create new market

#### Interest Management
- `accrueInterest(MarketParams)` - Accrue interest for market

#### Admin Functions (Owner-only)
- `setOwner(address)` - Change contract owner
- `enableIrm(address)` - Enable interest rate model
- `enableLltv(uint256)` - Enable loan-to-value ratio
- `setFee(MarketParams,uint256)` - Set market fee
- `setFeeRecipient(address)` - Set fee recipient

### Internal Functions Called by Public Functions
- `_accrueInterest(MarketParams,Id)` - Internal interest accrual
- `_isSenderAuthorized(address)` - Authorization check
- `_isHealthy(MarketParams,Id,address)` - Health check without price
- `_isHealthy(MarketParams,Id,address,uint256)` - Health check with price

## Interface Functions (Touched via External Calls)

### IERC20.sol
- `transfer(address,uint256)` - Token transfers
- `transferFrom(address,address,uint256)` - Token transfers from
- `balanceOf(address)` - Balance queries
- `approve(address,uint256)` - Approve spending

### IIrm.sol  
- `borrowRate(MarketParams,Market)` - Get borrow rate from IRM

### IOracle.sol
- `price()` - Get price from oracle

### IMorphoCallbacks.sol
- `onMorphoSupply(uint256,bytes)` - Supply callback
- `onMorphoRepay(uint256,bytes)` - Repay callback  
- `onMorphoSupplyCollateral(uint256,bytes)` - Supply collateral callback
- `onMorphoLiquidate(uint256,bytes)` - Liquidate callback
- `onMorphoFlashLoan(uint256,bytes)` - Flash loan callback

## Library Functions (Touched via External Calls)

### ConstantsLib.sol
- `WAD` - Constant for decimal precision
- `MAX_FEE` - Maximum fee constant
- `ORACLE_PRICE_SCALE` - Oracle price scaling
- `LIQUIDATION_CURSOR` - Liquidation cursor
- `MAX_LIQUIDATION_INCENTIVE_FACTOR` - Max liquidation incentive
- `DOMAIN_TYPEHASH` - Domain separator type hash
- `AUTHORIZATION_TYPEHASH` - Authorization type hash

### UtilsLib.sol
- `exactlyOneZero(uint256,uint256)` - Check exactly one is zero
- `zeroFloorSub(uint256,uint256)` - Subtraction with zero floor
- `min(uint256,uint256)` - Minimum function

### EventsLib.sol
- All event definitions (emitted throughout protocol)

### ErrorsLib.sol
- All error definitions (used throughout protocol)

### MathLib.sol
- `wMulDown(uint256,uint256)` - Weighted multiplication down
- `wDivDown(uint256,uint256)` - Weighted division down
- `wMulUp(uint256,uint256)` - Weighted multiplication up
- `wTaylorCompounded(uint256)` - Taylor compound calculation
- `mulDivDown(uint256,uint256,uint256)` - Multiply-divide down
- `mulDivUp(uint256,uint256,uint256)` - Multiply-divide up

### SharesMathLib.sol
- `toSharesDown(uint256,uint256,uint256)` - Convert to shares down
- `toAssetsUp(uint256,uint256,uint256)` - Convert to assets up
- `toSharesUp(uint256,uint256,uint256)` - Convert to shares up
- `toAssetsDown(uint256,uint256,uint256)` - Convert to assets down

### MarketParamsLib.sol
- `id()` - Generate market ID from parameters

### SafeTransferLib.sol
- `safeTransfer(address,uint256)` - Safe token transfer
- `safeTransferFrom(address,address,uint256)` - Safe transfer from

## Notes
- Mock contracts (ERC20Mock, OracleMock, IrmMock, FlashBorrowerMock) are excluded from coverage requirements
- Coverage focuses on functions actually called by the TargetFunctions contract during fuzzing
- Internal functions are included when they are called by the public-facing functions above