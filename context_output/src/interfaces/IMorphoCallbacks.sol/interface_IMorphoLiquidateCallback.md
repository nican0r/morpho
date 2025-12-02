# Interface: IMorphoLiquidateCallback

## Metadata

- **Name**: IMorphoLiquidateCallback
- **Type**: Interface
- **Path**: src/interfaces/IMorphoCallbacks.sol
- **Documentation**: @title IMorphoLiquidateCallback
   @notice Interface that liquidators willing to use `liquidate`'s callback must implement.

## Public/External Functions

### onMorphoLiquidate(uint256,bytes)

- **Signature**: `onMorphoLiquidate(uint256,bytes)`
- **Visibility**: external
- **Source Range**: 491:79:39

**Signature:**
```solidity
/// @notice Callback called when a liquidation occurs.
///  @dev The callback is called only if data is not empty.
///  @param repaidAssets The amount of repaid assets.
///  @param data Arbitrary data passed to the `liquidate` function.
function onMorphoLiquidate(uint256 repaidAssets, bytes calldata data) external;;
```
