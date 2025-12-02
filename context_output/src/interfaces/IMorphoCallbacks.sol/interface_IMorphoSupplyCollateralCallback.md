# Interface: IMorphoSupplyCollateralCallback

## Metadata

- **Name**: IMorphoSupplyCollateralCallback
- **Type**: Interface
- **Path**: src/interfaces/IMorphoCallbacks.sol
- **Documentation**: @title IMorphoSupplyCollateralCallback
   @notice Interface that users willing to use `supplyCollateral`'s callback must implement.

## Public/External Functions

### onMorphoSupplyCollateral(uint256,bytes)

- **Signature**: `onMorphoSupplyCollateral(uint256,bytes)`
- **Visibility**: external
- **Source Range**: 1955:80:39

**Signature:**
```solidity
/// @notice Callback called when a supply of collateral occurs.
///  @dev The callback is called only if data is not empty.
///  @param assets The amount of supplied collateral.
///  @param data Arbitrary data passed to the `supplyCollateral` function.
function onMorphoSupplyCollateral(uint256 assets, bytes calldata data) external;;
```
