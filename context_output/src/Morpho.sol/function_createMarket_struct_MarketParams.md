# Function: createMarket(struct MarketParams)

**Contract**: [src/Morpho.sol/contract_Morpho.md]

## Metadata

- **Contract**: Morpho
- **Signature**: `createMarket(struct MarketParams)`
- **Visibility**: external
- **Source Range**: 4543:703:35

## Implementation

```solidity
/// @inheritdoc IMorphoBase
function createMarket(MarketParams memory marketParams) external {
    Id id = marketParams.id();
    require(isIrmEnabled[marketParams.irm], ErrorsLib.IRM_NOT_ENABLED);
    require(isLltvEnabled[marketParams.lltv], ErrorsLib.LLTV_NOT_ENABLED);
    require(market[id].lastUpdate == 0, ErrorsLib.MARKET_ALREADY_CREATED);
    market[id].lastUpdate = uint128(block.timestamp);
    idToMarketParams[id] = marketParams;
    emit EventsLib.CreateMarket(id, marketParams);
    if (marketParams.irm != address(0)) IIrm(marketParams.irm).borrowRate(marketParams, market[id]);
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

## External Calls

- **IIrm::borrowRate(struct MarketParams,struct Market)**

## State Variable Reads

- **isIrmEnabled** (`mapping(address => bool)`)
- **isLltvEnabled** (`mapping(uint256 => bool)`)
- **market** (`mapping(Id => struct Market)`)

## State Variable Writes

- **market** (`mapping(Id => struct Market)`)
- **idToMarketParams** (`mapping(Id => struct MarketParams)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Morpho.createMarket(struct MarketParams) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: MarketParamsLib.id(struct MarketParams) (NodeID: 1)
      💬 Args: [marketParams]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IMorphoBase

### Interface Documentation

@notice Creates the market `marketParams`.
 @dev Here is the list of assumptions on the market's dependencies (tokens, IRM and oracle) that guarantees
 Morpho behaves as expected:
 - The token should be ERC-20 compliant, except that it can omit return values on `transfer` and `transferFrom`.
 - The token balance of Morpho should only decrease on `transfer` and `transferFrom`. In particular, tokens with
 burn functions are not supported.
 - The token should not re-enter Morpho on `transfer` nor `transferFrom`.
 - The token balance of the sender (resp. receiver) should decrease (resp. increase) by exactly the given amount
 on `transfer` and `transferFrom`. In particular, tokens with fees on transfer are not supported.
 - The IRM should not re-enter Morpho.
 - The oracle should return a price with the correct scaling.
 - The oracle price should not be able to change instantly such that the new price is less than the old price
 multiplied by LLTV*LIF. In particular, if the loan asset is a vault that can receive donations, the oracle
 should not price its shares using the AUM.
 @dev Here is a list of assumptions on the market's dependencies which, if broken, could break Morpho's liveness
 properties (funds could get stuck):
 - The token should not revert on `transfer` and `transferFrom` if balances and approvals are right.
 - The amount of assets supplied and borrowed should not be too high (max ~1e32), otherwise the number of shares
 might not fit within 128 bits.
 - The IRM should not revert on `borrowRate`.
 - The IRM should not return a very high borrow rate (otherwise the computation of `interest` in
 `_accrueInterest` can overflow).
 - The oracle should not revert `price`.
 - The oracle should not return a very high price (otherwise the computation of `maxBorrow` in `_isHealthy` or of
 `assetsRepaid` in `liquidate` can overflow).
 @dev The borrow share price of a market with less than 1e4 assets borrowed can be decreased by manipulations, to
 the point where `totalBorrowShares` is very large and borrowing overflows.
