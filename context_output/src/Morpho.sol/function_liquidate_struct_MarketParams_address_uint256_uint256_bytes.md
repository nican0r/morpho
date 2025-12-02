# Function: liquidate(struct MarketParams,address,uint256,uint256,bytes)

**Contract**: [src/Morpho.sol/contract_Morpho.md]

## Metadata

- **Contract**: Morpho
- **Signature**: `liquidate(struct MarketParams,address,uint256,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 12753:3286:35

## Implementation

```solidity
/// @inheritdoc IMorphoBase
function liquidate(MarketParams memory marketParams, address borrower, uint256 seizedAssets, uint256 repaidShares, bytes calldata data) external returns (uint256, uint256) {
    Id id = marketParams.id();
    require(market[id].lastUpdate != 0, ErrorsLib.MARKET_NOT_CREATED);
    require(UtilsLib.exactlyOneZero(seizedAssets, repaidShares), ErrorsLib.INCONSISTENT_INPUT);
    _accrueInterest(marketParams, id);
    {
        uint256 collateralPrice = IOracle(marketParams.oracle).price();
        require(!_isHealthy(marketParams, id, borrower, collateralPrice), ErrorsLib.HEALTHY_POSITION);
        uint256 liquidationIncentiveFactor = UtilsLib.min(MAX_LIQUIDATION_INCENTIVE_FACTOR, WAD.wDivDown(WAD - LIQUIDATION_CURSOR.wMulDown(WAD - marketParams.lltv)));
        if (seizedAssets > 0) {
            uint256 seizedAssetsQuoted = seizedAssets.mulDivUp(collateralPrice, ORACLE_PRICE_SCALE);
            repaidShares = seizedAssetsQuoted.wDivUp(liquidationIncentiveFactor).toSharesUp(market[id].totalBorrowAssets, market[id].totalBorrowShares);
        } else {
            seizedAssets = repaidShares.toAssetsDown(market[id].totalBorrowAssets, market[id].totalBorrowShares).wMulDown(liquidationIncentiveFactor).mulDivDown(ORACLE_PRICE_SCALE, collateralPrice);
        }
    }
    uint256 repaidAssets = repaidShares.toAssetsUp(market[id].totalBorrowAssets, market[id].totalBorrowShares);
    position[id][borrower].borrowShares -= repaidShares.toUint128();
    market[id].totalBorrowShares -= repaidShares.toUint128();
    market[id].totalBorrowAssets = UtilsLib.zeroFloorSub(market[id].totalBorrowAssets, repaidAssets).toUint128();
    position[id][borrower].collateral -= seizedAssets.toUint128();
    uint256 badDebtShares;
    uint256 badDebtAssets;
    if (position[id][borrower].collateral == 0) {
        badDebtShares = position[id][borrower].borrowShares;
        badDebtAssets = UtilsLib.min(market[id].totalBorrowAssets, badDebtShares.toAssetsUp(market[id].totalBorrowAssets, market[id].totalBorrowShares));
        market[id].totalBorrowAssets -= badDebtAssets.toUint128();
        market[id].totalSupplyAssets -= badDebtAssets.toUint128();
        market[id].totalBorrowShares -= badDebtShares.toUint128();
        position[id][borrower].borrowShares = 0;
    }
    emit EventsLib.Liquidate(id, msg.sender, borrower, repaidAssets, repaidShares, seizedAssets, badDebtAssets, badDebtShares);
    IERC20(marketParams.collateralToken).safeTransfer(msg.sender, seizedAssets);
    if (data.length > 0) IMorphoLiquidateCallback(msg.sender).onMorphoLiquidate(repaidAssets, data);
    IERC20(marketParams.loanToken).safeTransferFrom(msg.sender, address(this), repaidAssets);
    return (seizedAssets, repaidAssets);
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

### exactlyOneZero(uint256,uint256)

- **Kind**: internal
- **Source**: 409:156:48
- **Link**: `src/libraries/UtilsLib.sol:UtilsLib:exactlyOneZero(uint256,uint256)`

```solidity
/// @dev Returns true if there is exactly one zero among `x` and `y`.
function exactlyOneZero(uint256 x, uint256 y) internal pure returns (bool z) {
    assembly {
        z := xor(iszero(x), iszero(y))
    }
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

### min(uint256,uint256)

- **Kind**: internal
- **Source**: 616:155:48
- **Link**: `src/libraries/UtilsLib.sol:UtilsLib:min(uint256,uint256)`

```solidity
/// @dev Returns the min of `x` and `y`.
function min(uint256 x, uint256 y) internal pure returns (uint256 z) {
    assembly {
        z := xor(x, mul(xor(x, y), lt(y, x)))
    }
}
```

### wDivDown(uint256,uint256)

- **Kind**: internal
- **Source**: 492:117:45
- **Link**: `src/libraries/MathLib.sol:MathLib:wDivDown(uint256,uint256)`

```solidity
/// @dev Returns (`x` * `WAD`) / `y` rounded down.
function wDivDown(uint256 x, uint256 y) internal pure returns (uint256) {
    return mulDivDown(x, WAD, y);
}
```

### wDivUp(uint256,uint256)

- **Kind**: internal
- **Source**: 668:113:45
- **Link**: `src/libraries/MathLib.sol:MathLib:wDivUp(uint256,uint256)`

```solidity
/// @dev Returns (`x` * `WAD`) / `y` rounded up.
function wDivUp(uint256 x, uint256 y) internal pure returns (uint256) {
    return mulDivUp(x, WAD, y);
}
```

### toSharesUp(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 1856:209:47
- **Link**: `src/libraries/SharesMathLib.sol:SharesMathLib:toSharesUp(uint256,uint256,uint256)`

```solidity
/// @dev Calculates the value of `assets` quoted in shares, rounding up.
function toSharesUp(uint256 assets, uint256 totalAssets, uint256 totalShares) internal pure returns (uint256) {
    return assets.mulDivUp(totalShares + VIRTUAL_SHARES, totalAssets + VIRTUAL_ASSETS);
}
```

### toAssetsDown(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 1560:213:47
- **Link**: `src/libraries/SharesMathLib.sol:SharesMathLib:toAssetsDown(uint256,uint256,uint256)`

```solidity
/// @dev Calculates the value of `shares` quoted in assets, rounding down.
function toAssetsDown(uint256 shares, uint256 totalAssets, uint256 totalShares) internal pure returns (uint256) {
    return shares.mulDivDown(totalAssets + VIRTUAL_ASSETS, totalShares + VIRTUAL_SHARES);
}
```

### zeroFloorSub(uint256,uint256)

- **Kind**: internal
- **Source**: 1037:156:48
- **Link**: `src/libraries/UtilsLib.sol:UtilsLib:zeroFloorSub(uint256,uint256)`

```solidity
/// @dev Returns max(0, x - y).
function zeroFloorSub(uint256 x, uint256 y) internal pure returns (uint256 z) {
    assembly {
        z := mul(gt(x, y), sub(x, y))
    }
}
```

## External Calls

- **IOracle::price()**
- **IERC20::safeTransfer(contract IERC20,address,uint256)**
- **IMorphoLiquidateCallback::onMorphoLiquidate(uint256,bytes)**
- **IERC20::safeTransferFrom(contract IERC20,address,address,uint256)**

## State Variable Reads

- **market** (`mapping(Id => struct Market)`)
- **position** (`mapping(Id => mapping(address => struct Position))`)
- **feeRecipient** (`address`)
- **VIRTUAL_SHARES** (`uint256`)
- **VIRTUAL_ASSETS** (`uint256`)

## State Variable Writes

- **position** (`mapping(Id => mapping(address => struct Position))`)
- **market** (`mapping(Id => struct Market)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Morpho.liquidate(struct MarketParams,address,uint256,uint256,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: MarketParamsLib.id(struct MarketParams) (NodeID: 1)
  │   💬 Args: [marketParams]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: UtilsLib.exactlyOneZero(uint256,uint256) (NodeID: 2)
  │   💬 Args: [seizedAssets, repaidShares]
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
  ├─ [1] ⚙️ FUNCTION: Morpho._isHealthy(struct MarketParams,Id,address,uint256) (NodeID: 16)
  │   💬 Args: [marketParams, id, borrower, collateralPrice]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SharesMathLib.toAssetsUp(uint256,uint256,uint256) (NodeID: 17)
  │ │   💬 Args: [uint256(position[id][borrower].borrowShares), market[id].totalBorrowAssets, market[id].totalBorrowShares]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: MathLib.mulDivUp(uint256,uint256,uint256) (NodeID: 18)
  │ │     💬 Args: [shares, totalAssets + VIRTUAL_ASSETS, totalShares + VIRTUAL_SHARES]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: MathLib.mulDivDown(uint256,uint256,uint256) (NodeID: 19)
  │ │   💬 Args: [uint256(position[id][borrower].collateral), collateralPrice, ORACLE_PRICE_SCALE]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: MathLib.wMulDown(uint256,uint256) (NodeID: 20)
  │     💬 Args: [uint256(position[id][borrower].collateral).mulDivDown(collateralPrice, ORACLE_PRICE_SCALE), marketParams.lltv]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: MathLib.mulDivDown(uint256,uint256,uint256) (NodeID: 21)
  │       💬 Args: [x, y, WAD]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: UtilsLib.min(uint256,uint256) (NodeID: 22)
  │   💬 Args: [MAX_LIQUIDATION_INCENTIVE_FACTOR, WAD.wDivDown(WAD - LIQUIDATION_CURSOR.wMulDown(WAD - marketParams.lltv))]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: MathLib.wDivDown(uint256,uint256) (NodeID: 23)
  │     💬 Args: [WAD, WAD - LIQUIDATION_CURSOR.wMulDown(WAD - marketParams.lltv)]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: MathLib.wMulDown(uint256,uint256) (NodeID: 25)
  │   │   💬 Args: [LIQUIDATION_CURSOR, WAD - marketParams.lltv]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: MathLib.mulDivDown(uint256,uint256,uint256) (NodeID: 26)
  │   │     💬 Args: [x, y, WAD]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: MathLib.mulDivDown(uint256,uint256,uint256) (NodeID: 24)
  │       💬 Args: [x, WAD, y]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: MathLib.mulDivUp(uint256,uint256,uint256) (NodeID: 27)
  │   💬 Args: [seizedAssets, collateralPrice, ORACLE_PRICE_SCALE]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: MathLib.wDivUp(uint256,uint256) (NodeID: 28)
  │   💬 Args: [seizedAssetsQuoted, liquidationIncentiveFactor]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: MathLib.mulDivUp(uint256,uint256,uint256) (NodeID: 29)
  │     💬 Args: [x, WAD, y]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SharesMathLib.toSharesUp(uint256,uint256,uint256) (NodeID: 30)
  │   💬 Args: [seizedAssetsQuoted.wDivUp(liquidationIncentiveFactor), market[id].totalBorrowAssets, market[id].totalBorrowShares]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: MathLib.mulDivUp(uint256,uint256,uint256) (NodeID: 31)
  │     💬 Args: [assets, totalShares + VIRTUAL_SHARES, totalAssets + VIRTUAL_ASSETS]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SharesMathLib.toAssetsDown(uint256,uint256,uint256) (NodeID: 32)
  │   💬 Args: [repaidShares, market[id].totalBorrowAssets, market[id].totalBorrowShares]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: MathLib.mulDivDown(uint256,uint256,uint256) (NodeID: 33)
  │     💬 Args: [shares, totalAssets + VIRTUAL_ASSETS, totalShares + VIRTUAL_SHARES]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: MathLib.wMulDown(uint256,uint256) (NodeID: 34)
  │   💬 Args: [repaidShares.toAssetsDown(market[id].totalBorrowAssets, market[id].totalBorrowShares), liquidationIncentiveFactor]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: MathLib.mulDivDown(uint256,uint256,uint256) (NodeID: 35)
  │     💬 Args: [x, y, WAD]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: MathLib.mulDivDown(uint256,uint256,uint256) (NodeID: 36)
  │   💬 Args: [repaidShares.toAssetsDown(market[id].totalBorrowAssets, market[id].totalBorrowShares).wMulDown(liquidationIncentiveFactor), ORACLE_PRICE_SCALE, collateralPrice]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SharesMathLib.toAssetsUp(uint256,uint256,uint256) (NodeID: 37)
  │   💬 Args: [repaidShares, market[id].totalBorrowAssets, market[id].totalBorrowShares]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: MathLib.mulDivUp(uint256,uint256,uint256) (NodeID: 38)
  │     💬 Args: [shares, totalAssets + VIRTUAL_ASSETS, totalShares + VIRTUAL_SHARES]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: UtilsLib.toUint128(uint256) (NodeID: 39)
  │   💬 Args: [repaidShares]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: UtilsLib.toUint128(uint256) (NodeID: 40)
  │   💬 Args: [repaidShares]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: UtilsLib.zeroFloorSub(uint256,uint256) (NodeID: 41)
  │   💬 Args: [market[id].totalBorrowAssets, repaidAssets]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: UtilsLib.toUint128(uint256) (NodeID: 42)
  │   💬 Args: [UtilsLib.zeroFloorSub(market[id].totalBorrowAssets, repaidAssets)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: UtilsLib.toUint128(uint256) (NodeID: 43)
  │   💬 Args: [seizedAssets]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: UtilsLib.min(uint256,uint256) (NodeID: 44)
  │   💬 Args: [market[id].totalBorrowAssets, badDebtShares.toAssetsUp(market[id].totalBorrowAssets, market[id].totalBorrowShares)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SharesMathLib.toAssetsUp(uint256,uint256,uint256) (NodeID: 45)
  │     💬 Args: [badDebtShares, market[id].totalBorrowAssets, market[id].totalBorrowShares]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: MathLib.mulDivUp(uint256,uint256,uint256) (NodeID: 46)
  │       💬 Args: [shares, totalAssets + VIRTUAL_ASSETS, totalShares + VIRTUAL_SHARES]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: UtilsLib.toUint128(uint256) (NodeID: 47)
  │   💬 Args: [badDebtAssets]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: UtilsLib.toUint128(uint256) (NodeID: 48)
  │   💬 Args: [badDebtAssets]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: UtilsLib.toUint128(uint256) (NodeID: 49)
      💬 Args: [badDebtShares]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IMorphoBase

### Interface Documentation

@notice Liquidates the given `repaidShares` of debt asset or seize the given `seizedAssets` of collateral on the
 given market `marketParams` of the given `borrower`'s position, optionally calling back the caller's
 `onMorphoLiquidate` function with the given `data`.
 @dev Either `seizedAssets` or `repaidShares` should be zero.
 @dev Seizing more than the collateral balance will underflow and revert without any error message.
 @dev Repaying more than the borrow balance will underflow and revert without any error message.
 @dev An attacker can front-run a liquidation with a small repay making the transaction revert for underflow.
 @param marketParams The market of the position.
 @param borrower The owner of the position.
 @param seizedAssets The amount of collateral to seize.
 @param repaidShares The amount of shares to repay.
 @param data Arbitrary data to pass to the `onMorphoLiquidate` callback. Pass empty data if not needed.
 @return The amount of assets seized.
 @return The amount of assets repaid.
