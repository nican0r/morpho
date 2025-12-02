# Interface: IMorphoRepayCallback

## Metadata

- **Name**: IMorphoRepayCallback
- **Type**: Interface
- **Path**: src/interfaces/IMorphoCallbacks.sol
- **Documentation**: @title IMorphoRepayCallback
   @notice Interface that users willing to use `repay`'s callback must implement.

## Public/External Functions

### onMorphoRepay(uint256,bytes)

- **Signature**: `onMorphoRepay(uint256,bytes)`
- **Visibility**: external
- **Source Range**: 964:69:39

**Signature:**
```solidity
/// @notice Callback called when a repayment occurs.
///  @dev The callback is called only if data is not empty.
///  @param assets The amount of repaid assets.
///  @param data Arbitrary data passed to the `repay` function.
function onMorphoRepay(uint256 assets, bytes calldata data) external;;
```
