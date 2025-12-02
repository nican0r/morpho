# Interface: IMorphoFlashLoanCallback

## Metadata

- **Name**: IMorphoFlashLoanCallback
- **Type**: Interface
- **Path**: src/interfaces/IMorphoCallbacks.sol
- **Documentation**: @title IMorphoFlashLoanCallback
   @notice Interface that users willing to use `flashLoan`'s callback must implement.

## Public/External Functions

### onMorphoFlashLoan(uint256,bytes)

- **Signature**: `onMorphoFlashLoan(uint256,bytes)`
- **Visibility**: external
- **Source Range**: 2461:73:39

**Signature:**
```solidity
/// @notice Callback called when a flash loan occurs.
///  @dev The callback is called only if data is not empty.
///  @param assets The amount of assets that was flash loaned.
///  @param data Arbitrary data passed to the `flashLoan` function.
function onMorphoFlashLoan(uint256 assets, bytes calldata data) external;;
```
