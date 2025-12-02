# Contract: IrmMock

## Metadata

- **Name**: IrmMock
- **Type**: Contract
- **Path**: src/mocks/IrmMock.sol

## Implements Interfaces

- **IIrm** [src/interfaces/IIrm.sol/interface_IIrm.md]

## Public/External Functions

### borrowRateView(struct MarketParams,struct Market)

- **Signature**: `borrowRateView(struct MarketParams,struct Market)`
- **Visibility**: public
- **Source Range**: 294:426:54
- **Details**: [function_borrowRateView_struct_MarketParams_struct_Market.md](./function_borrowRateView_struct_MarketParams_struct_Market.md)

**Signature:**
```solidity
function borrowRateView(MarketParams memory, Market memory market) public pure returns (uint256);
```

### borrowRate(struct MarketParams,struct Market)

- **Signature**: `borrowRate(struct MarketParams,struct Market)`
- **Visibility**: external
- **Source Range**: 726:168:54
- **Details**: [function_borrowRate_struct_MarketParams_struct_Market.md](./function_borrowRate_struct_MarketParams_struct_Market.md)

**Signature:**
```solidity
function borrowRate(MarketParams memory marketParams, Market memory market) external pure returns (uint256);
```
