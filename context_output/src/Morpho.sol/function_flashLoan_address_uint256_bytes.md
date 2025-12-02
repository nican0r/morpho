# Function: flashLoan(address,uint256,bytes)

**Contract**: [src/Morpho.sol/contract_Morpho.md]

## Metadata

- **Contract**: Morpho
- **Signature**: `flashLoan(address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 16100:414:35

## Implementation

```solidity
/// @inheritdoc IMorphoBase
function flashLoan(address token, uint256 assets, bytes calldata data) external {
    require(assets != 0, ErrorsLib.ZERO_ASSETS);
    emit EventsLib.FlashLoan(msg.sender, token, assets);
    IERC20(token).safeTransfer(msg.sender, assets);
    IMorphoFlashLoanCallback(msg.sender).onMorphoFlashLoan(assets, data);
    IERC20(token).safeTransferFrom(msg.sender, address(this), assets);
}
```

## External Calls

- **IERC20::safeTransfer(contract IERC20,address,uint256)**
- **IMorphoFlashLoanCallback::onMorphoFlashLoan(uint256,bytes)**
- **IERC20::safeTransferFrom(contract IERC20,address,address,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Morpho.flashLoan(address,uint256,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IMorphoBase

### Interface Documentation

@notice Executes a flash loan.
 @dev Flash loans have access to the whole balance of the contract (the liquidity and deposited collateral of all
 markets combined, plus donations).
 @dev Warning: Not ERC-3156 compliant but compatibility is easily reached:
 - `flashFee` is zero.
 - `maxFlashLoan` is the token's balance of this contract.
 - The receiver of `assets` is the caller.
 @param token The token to flash loan.
 @param assets The amount of assets to flash loan.
 @param data Arbitrary data to pass to the `onMorphoFlashLoan` callback.
