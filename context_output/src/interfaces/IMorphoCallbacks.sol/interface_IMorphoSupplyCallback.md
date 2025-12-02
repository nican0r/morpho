# Interface: IMorphoSupplyCallback

## Metadata

- **Name**: IMorphoSupplyCallback
- **Type**: Interface
- **Path**: src/interfaces/IMorphoCallbacks.sol
- **Documentation**: @title IMorphoSupplyCallback
   @notice Interface that users willing to use `supply`'s callback must implement.

## Public/External Functions

### onMorphoSupply(uint256,bytes)

- **Signature**: `onMorphoSupply(uint256,bytes)`
- **Visibility**: external
- **Source Range**: 1430:70:39

**Signature:**
```solidity
/// @notice Callback called when a supply occurs.
///  @dev The callback is called only if data is not empty.
///  @param assets The amount of supplied assets.
///  @param data Arbitrary data passed to the `supply` function.
function onMorphoSupply(uint256 assets, bytes calldata data) external;;
```
