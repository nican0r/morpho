# Function: borrowRate(struct MarketParams,struct Market)

**Contract**: [src/mocks/IrmMock.sol/contract_IrmMock.md]

## Metadata

- **Contract**: IrmMock
- **Signature**: `borrowRate(struct MarketParams,struct Market)`
- **Visibility**: external
- **Source Range**: 726:168:54

## Implementation

```solidity
function borrowRate(MarketParams memory marketParams, Market memory market) external pure returns (uint256) {
    return borrowRateView(marketParams, market);
}
```

## Related Implementations

### borrowRateView(struct MarketParams,struct Market)

- **Kind**: internal
- **Source**: 294:426:54
- **Link**: `src/mocks/IrmMock.sol:IrmMock:borrowRateView(struct MarketParams,struct Market)`

```solidity
function borrowRateView(MarketParams memory, Market memory market) public pure returns (uint256) {
    if (market.totalSupplyAssets == 0) return 0;
    uint256 utilization = market.totalBorrowAssets.wDivDown(market.totalSupplyAssets);
    return utilization / 365 days;
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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: IrmMock.borrowRate(struct MarketParams,struct Market) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: IrmMock.borrowRateView(struct MarketParams,struct Market) (NodeID: 1)
      💬 Args: [marketParams, market]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: MathLib.wDivDown(uint256,uint256) (NodeID: 2)
        💬 Args: [market.totalBorrowAssets, market.totalSupplyAssets]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: MathLib.mulDivDown(uint256,uint256,uint256) (NodeID: 3)
          💬 Args: [x, WAD, y]
          👁️  Def: internal
```

## Documentation

### Interface Documentation

@notice Returns the borrow rate per second (scaled by WAD) of the market `marketParams`.
 @dev Assumes that `market` corresponds to `marketParams`.
