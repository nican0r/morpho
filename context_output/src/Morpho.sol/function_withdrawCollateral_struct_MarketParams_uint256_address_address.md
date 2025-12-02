# Function: withdrawCollateral(struct MarketParams,uint256,address,address)

**Contract**: [src/Morpho.sol/contract_Morpho.md]

## Metadata

- **Contract**: Morpho
- **Signature**: `withdrawCollateral(struct MarketParams,uint256,address,address)`
- **Visibility**: external
- **Source Range**: 11779:913:35

## Implementation

```solidity
/// @inheritdoc IMorphoBase
function withdrawCollateral(MarketParams memory marketParams, uint256 assets, address onBehalf, address receiver) external {
    Id id = marketParams.id();
    require(market[id].lastUpdate != 0, ErrorsLib.MARKET_NOT_CREATED);
    require(assets != 0, ErrorsLib.ZERO_ASSETS);
    require(receiver != address(0), ErrorsLib.ZERO_ADDRESS);
    require(_isSenderAuthorized(onBehalf), ErrorsLib.UNAUTHORIZED);
    _accrueInterest(marketParams, id);
    position[id][onBehalf].collateral -= assets.toUint128();
    require(_isHealthy(marketParams, id, onBehalf), ErrorsLib.INSUFFICIENT_COLLATERAL);
    emit EventsLib.WithdrawCollateral(id, msg.sender, onBehalf, receiver, assets);
    IERC20(marketParams.collateralToken).safeTransfer(receiver, assets);
}
```

## Related Implementations

### id(struct MarketParams)

- **Kind**: internal
- **Source**: 598:222:44
- **Link**: `src/libraries/MarketParamsLib.sol:MarketParamsLib:id(struct MarketParams)`

```solidity
/// @notice Returns the id of the market `marketParams`.
function id(MarketParams memory marketParams) internal pure returns (Id marketParamsId) {
    assembly ("memory-safe") {
        marketParamsId := keccak256(marketParams, MARKET_PARAMS_BYTES_LENGTH)
    }
}
```

### _isSenderAuthorized(address)

- **Kind**: internal
- **Source**: 18212:160:35
- **Link**: `src/Morpho.sol:Morpho:_isSenderAuthorized(address)`

```solidity
/// @dev Returns whether the sender is authorized to manage `onBehalf`'s positions.
function _isSenderAuthorized(address onBehalf) internal view returns (bool) {
    return (msg.sender == onBehalf) || isAuthorized[onBehalf][msg.sender];
}
```

### _accrueInterest(struct MarketParams,Id)

- **Kind**: internal
- **Source**: 18810:1414:35
- **Link**: `src/Morpho.sol:Morpho:_accrueInterest(struct MarketParams,Id)`

```solidity
/// @dev Accrues interest for the given market `marketParams`.
///  @dev Assumes that the inputs `marketParams` and `id` match.
function _accrueInterest(MarketParams memory marketParams, Id id) internal {
    uint256 elapsed = block.timestamp - market[id].lastUpdate;
    if (elapsed == 0) return;
    if (marketParams.irm != address(0)) {
        uint256 borrowRate = IIrm(marketParams.irm).borrowRate(marketParams, market[id]);
        uint256 interest = market[id].totalBorrowAssets.wMulDown(borrowRate.wTaylorCompounded(elapsed));
        market[id].totalBorrowAssets += interest.toUint128();
        market[id].totalSupplyAssets += interest.toUint128();
        uint256 feeShares;
        if (market[id].fee != 0) {
            uint256 feeAmount = interest.wMulDown(market[id].fee);
            feeShares = feeAmount.toSharesDown(market[id].totalSupplyAssets - feeAmount, market[id].totalSupplyShares);
            position[id][feeRecipient].supplyShares += feeShares;
            market[id].totalSupplyShares += feeShares.toUint128();
        }
        emit EventsLib.AccrueInterest(id, borrowRate, interest, feeShares);
    }
    market[id].lastUpdate = uint128(block.timestamp);
}
```

### wMulDown(uint256,uint256)

- **Kind**: internal
- **Source**: 314:117:45
- **Link**: `src/libraries/MathLib.sol:MathLib:wMulDown(uint256,uint256)`

```solidity
/// @dev Returns (`x` * `y`) / `WAD` rounded down.
function wMulDown(uint256 x, uint256 y) internal pure returns (uint256) {
    return mulDivDown(x, y, WAD);
}
```

### wTaylorCompounded(uint256,uint256)

- **Kind**: internal
- **Source**: 1311:319:45
- **Link**: `src/libraries/MathLib.sol:MathLib:wTaylorCompounded(uint256,uint256)`

```solidity
/// @dev Returns the sum of the first three non-zero terms of a Taylor expansion of e^(nx) - 1, to approximate a
///  continuous compound interest rate.
function wTaylorCompounded(uint256 x, uint256 n) internal pure returns (uint256) {
    uint256 firstTerm = x * n;
    uint256 secondTerm = mulDivDown(firstTerm, firstTerm, 2 * WAD);
    uint256 thirdTerm = mulDivDown(secondTerm, firstTerm, 3 * WAD);
    return (firstTerm + secondTerm) + thirdTerm;
}
```

### mulDivDown(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 840:120:45
- **Link**: `src/libraries/MathLib.sol:MathLib:mulDivDown(uint256,uint256,uint256)`

```solidity
/// @dev Returns (`x` * `y`) / `d` rounded down.
function mulDivDown(uint256 x, uint256 y, uint256 d) internal pure returns (uint256) {
    return (x * y) / d;
}
```

### toUint128(uint256)

- **Kind**: internal
- **Source**: 826:169:48
- **Link**: `src/libraries/UtilsLib.sol:UtilsLib:toUint128(uint256)`

```solidity
/// @dev Returns `x` safely cast to uint128.
function toUint128(uint256 x) internal pure returns (uint128) {
    require(x <= type(uint128).max, ErrorsLib.MAX_UINT128_EXCEEDED);
    return uint128(x);
}
```

### toSharesDown(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 1262:213:47
- **Link**: `src/libraries/SharesMathLib.sol:SharesMathLib:toSharesDown(uint256,uint256,uint256)`

```solidity
/// @dev Calculates the value of `assets` quoted in shares, rounding down.
function toSharesDown(uint256 assets, uint256 totalAssets, uint256 totalShares) internal pure returns (uint256) {
    return assets.mulDivDown(totalShares + VIRTUAL_SHARES, totalAssets + VIRTUAL_ASSETS);
}
```

### _isHealthy(struct MarketParams,Id,address)

- **Kind**: internal
- **Source**: 20425:328:35
- **Link**: `src/Morpho.sol:Morpho:_isHealthy(struct MarketParams,Id,address)`

```solidity
/// @dev Returns whether the position of `borrower` in the given market `marketParams` is healthy.
///  @dev Assumes that the inputs `marketParams` and `id` match.
function _isHealthy(MarketParams memory marketParams, Id id, address borrower) internal view returns (bool) {
    if (position[id][borrower].borrowShares == 0) return true;
    uint256 collateralPrice = IOracle(marketParams.oracle).price();
    return _isHealthy(marketParams, id, borrower, collateralPrice);
}
```

### _isHealthy(struct MarketParams,Id,address,uint256)

- **Kind**: internal
- **Source**: 21091:534:35
- **Link**: `src/Morpho.sol:Morpho:_isHealthy(struct MarketParams,Id,address,uint256)`

```solidity
/// @dev Returns whether the position of `borrower` in the given market `marketParams` with the given
///  `collateralPrice` is healthy.
///  @dev Assumes that the inputs `marketParams` and `id` match.
///  @dev Rounds in favor of the protocol, so one might not be able to borrow exactly `maxBorrow` but one unit less.
function _isHealthy(MarketParams memory marketParams, Id id, address borrower, uint256 collateralPrice) internal view returns (bool) {
    uint256 borrowed = uint256(position[id][borrower].borrowShares).toAssetsUp(market[id].totalBorrowAssets, market[id].totalBorrowShares);
    uint256 maxBorrow = uint256(position[id][borrower].collateral).mulDivDown(collateralPrice, ORACLE_PRICE_SCALE).wMulDown(marketParams.lltv);
    return maxBorrow >= borrowed;
}
```

### toAssetsUp(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 2148:209:47
- **Link**: `src/libraries/SharesMathLib.sol:SharesMathLib:toAssetsUp(uint256,uint256,uint256)`

```solidity
/// @dev Calculates the value of `shares` quoted in assets, rounding up.
function toAssetsUp(uint256 shares, uint256 totalAssets, uint256 totalShares) internal pure returns (uint256) {
    return shares.mulDivUp(totalAssets + VIRTUAL_ASSETS, totalShares + VIRTUAL_SHARES);
}
```

### mulDivUp(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 1017:128:45
- **Link**: `src/libraries/MathLib.sol:MathLib:mulDivUp(uint256,uint256,uint256)`

```solidity
/// @dev Returns (`x` * `y`) / `d` rounded up.
function mulDivUp(uint256 x, uint256 y, uint256 d) internal pure returns (uint256) {
    return ((x * y) + (d - 1)) / d;
}
```

## External Calls

- **IERC20::safeTransfer(contract IERC20,address,uint256)**

## State Variable Reads

- **market** (`mapping(Id => struct Market)`)
- **isAuthorized** (`mapping(address => mapping(address => bool))`)
- **feeRecipient** (`address`)
- **VIRTUAL_SHARES** (`uint256`)
- **VIRTUAL_ASSETS** (`uint256`)
- **position** (`mapping(Id => mapping(address => struct Position))`)

## State Variable Writes

- **position** (`mapping(Id => mapping(address => struct Position))`)
- **market** (`mapping(Id => struct Market)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Morpho.withdrawCollateral(struct MarketParams,uint256,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: MarketParamsLib.id(struct MarketParams) (NodeID: 1)
  │   💬 Args: [marketParams]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Morpho._isSenderAuthorized(address) (NodeID: 2)
  │   💬 Args: [onBehalf]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: Morpho._accrueInterest(struct MarketParams,Id) (NodeID: 3)
  │   💬 Args: [marketParams, id]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MathLib.wMulDown(uint256,uint256) (NodeID: 4)
  │ │   💬 Args: [market[id].totalBorrowAssets, borrowRate.wTaylorCompounded(elapsed)]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: MathLib.wTaylorCompounded(uint256,uint256) (NodeID: 6)
  │ │ │   💬 Args: [borrowRate, elapsed]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: MathLib.mulDivDown(uint256,uint256,uint256) (NodeID: 7)
  │ │ │ │   💬 Args: [firstTerm, firstTerm, 2 * WAD]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: MathLib.mulDivDown(uint256,uint256,uint256) (NodeID: 8)
  │ │ │     💬 Args: [secondTerm, firstTerm, 3 * WAD]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: MathLib.mulDivDown(uint256,uint256,uint256) (NodeID: 5)
  │ │     💬 Args: [x, y, WAD]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: UtilsLib.toUint128(uint256) (NodeID: 9)
  │ │   💬 Args: [interest]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: UtilsLib.toUint128(uint256) (NodeID: 10)
  │ │   💬 Args: [interest]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MathLib.wMulDown(uint256,uint256) (NodeID: 11)
  │ │   💬 Args: [interest, market[id].fee]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: MathLib.mulDivDown(uint256,uint256,uint256) (NodeID: 12)
  │ │     💬 Args: [x, y, WAD]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SharesMathLib.toSharesDown(uint256,uint256,uint256) (NodeID: 13)
  │ │   💬 Args: [feeAmount, market[id].totalSupplyAssets - feeAmount, market[id].totalSupplyShares]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: MathLib.mulDivDown(uint256,uint256,uint256) (NodeID: 14)
  │ │     💬 Args: [assets, totalShares + VIRTUAL_SHARES, totalAssets + VIRTUAL_ASSETS]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: UtilsLib.toUint128(uint256) (NodeID: 15)
  │     💬 Args: [feeShares]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: UtilsLib.toUint128(uint256) (NodeID: 16)
  │   💬 Args: [assets]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: Morpho._isHealthy(struct MarketParams,Id,address) (NodeID: 17)
      💬 Args: [marketParams, id, onBehalf]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: Morpho._isHealthy(struct MarketParams,Id,address,uint256) (NodeID: 18)
        💬 Args: [marketParams, id, borrower, collateralPrice]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: SharesMathLib.toAssetsUp(uint256,uint256,uint256) (NodeID: 19)
      │   💬 Args: [uint256(position[id][borrower].borrowShares), market[id].totalBorrowAssets, market[id].totalBorrowShares]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: MathLib.mulDivUp(uint256,uint256,uint256) (NodeID: 20)
      │     💬 Args: [shares, totalAssets + VIRTUAL_ASSETS, totalShares + VIRTUAL_SHARES]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: MathLib.mulDivDown(uint256,uint256,uint256) (NodeID: 21)
      │   💬 Args: [uint256(position[id][borrower].collateral), collateralPrice, ORACLE_PRICE_SCALE]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: MathLib.wMulDown(uint256,uint256) (NodeID: 22)
          💬 Args: [uint256(position[id][borrower].collateral).mulDivDown(collateralPrice, ORACLE_PRICE_SCALE), marketParams.lltv]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: MathLib.mulDivDown(uint256,uint256,uint256) (NodeID: 23)
            💬 Args: [x, y, WAD]
            👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IMorphoBase

### Interface Documentation

@notice Withdraws `assets` of collateral on behalf of `onBehalf` and sends the assets to `receiver`.
 @dev `msg.sender` must be authorized to manage `onBehalf`'s positions.
 @dev Withdrawing an amount corresponding to more collateral than supplied will revert for underflow.
 @param marketParams The market to withdraw collateral from.
 @param assets The amount of collateral to withdraw.
 @param onBehalf The address of the owner of the collateral position.
 @param receiver The address that will receive the collateral assets.
