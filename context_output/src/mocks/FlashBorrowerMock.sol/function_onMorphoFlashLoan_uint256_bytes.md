# Function: onMorphoFlashLoan(uint256,bytes)

**Contract**: [src/mocks/FlashBorrowerMock.sol/contract_FlashBorrowerMock.md]

## Metadata

- **Contract**: FlashBorrowerMock
- **Signature**: `onMorphoFlashLoan(uint256,bytes)`
- **Visibility**: external
- **Source Range**: 559:237:53

## Implementation

```solidity
function onMorphoFlashLoan(uint256 assets, bytes calldata data) external {
    require(msg.sender == address(MORPHO));
    address token = abi.decode(data, (address));
    IERC20(token).approve(address(MORPHO), assets);
}
```

## External Calls

- **IERC20::approve(address,uint256)**

## State Variable Reads

- **MORPHO** (`contract IMorpho`) [src/interfaces/IMorpho.sol/interface_IMorpho.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: FlashBorrowerMock.onMorphoFlashLoan(uint256,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

@notice Callback called when a flash loan occurs.
 @dev The callback is called only if data is not empty.
 @param assets The amount of assets that was flash loaned.
 @param data Arbitrary data passed to the `flashLoan` function.
