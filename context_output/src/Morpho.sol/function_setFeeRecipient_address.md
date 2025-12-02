# Function: setFeeRecipient(address)

**Contract**: [src/Morpho.sol/contract_Morpho.md]

## Metadata

- **Contract**: Morpho
- **Signature**: `setFeeRecipient(address)`
- **Visibility**: external
- **Source Range**: 4230:248:35

## Implementation

```solidity
/// @inheritdoc IMorphoBase
function setFeeRecipient(address newFeeRecipient) external onlyOwner() {
    require(newFeeRecipient != feeRecipient, ErrorsLib.ALREADY_SET);
    feeRecipient = newFeeRecipient;
    emit EventsLib.SetFeeRecipient(newFeeRecipient);
}
```

## Related Implementations

### onlyOwner()

- **Kind**: modifier
- **Source**: 2695:98:35
- **Link**: `src/Morpho.sol:Morpho:onlyOwner()`

```solidity
/// @dev Reverts if the caller is not the owner.
modifier onlyOwner() {
    require(msg.sender == owner, ErrorsLib.NOT_OWNER);
    _;
}
```

## State Variable Reads

- **feeRecipient** (`address`)
- **owner** (`address`)

## State Variable Writes

- **feeRecipient** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Morpho.setFeeRecipient(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: Morpho.onlyOwner() (NodeID: 1)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

@inheritdoc IMorphoBase

### Interface Documentation

@notice Sets `newFeeRecipient` as `feeRecipient` of the fee.
 @dev Warning: If the fee recipient is set to the zero address, fees will accrue there and will be lost.
 @dev Modifying the fee recipient will allow the new recipient to claim any pending fees not yet accrued. To
 ensure that the current recipient receives all due fees, accrue interest manually prior to making any changes.
