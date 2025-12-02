# Interface: IIrm

## Metadata

- **Name**: IIrm
- **Type**: Interface
- **Path**: src/interfaces/IIrm.sol
- **Documentation**: @title IIrm
   @author Morpho Labs
   @custom:contact security@morpho.org
   @notice Interface that Interest Rate Models (IRMs) used by Morpho must implement.

## Public/External Functions

### borrowRate(struct MarketParams,struct Market)

- **Signature**: `borrowRate(struct MarketParams,struct Market)`
- **Visibility**: external
- **Source Range**: 474:103:37

**Signature:**
```solidity
/// @notice Returns the borrow rate per second (scaled by WAD) of the market `marketParams`.
///  @dev Assumes that `market` corresponds to `marketParams`.
function borrowRate(MarketParams memory marketParams, Market memory market) external returns (uint256);;
```

### borrowRateView(struct MarketParams,struct Market)

- **Signature**: `borrowRateView(struct MarketParams,struct Market)`
- **Visibility**: external
- **Source Range**: 784:112:37

**Signature:**
```solidity
/// @notice Returns the borrow rate per second (scaled by WAD) of the market `marketParams` without modifying any
///  storage.
///  @dev Assumes that `market` corresponds to `marketParams`.
function borrowRateView(MarketParams memory marketParams, Market memory market) external view returns (uint256);;
```
