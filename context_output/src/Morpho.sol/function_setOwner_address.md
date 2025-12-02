# Function: setOwner(address)

**Contract**: [src/Morpho.sol/contract_Morpho.md]

## Metadata

- **Contract**: Morpho
- **Signature**: `setOwner(address)`
- **Visibility**: external
- **Source Range**: 2863:192:35

## Implementation

```solidity
/// @inheritdoc IMorphoBase
function setOwner(address newOwner) external onlyOwner() {
    require(newOwner != owner, ErrorsLib.ALREADY_SET);
    owner = newOwner;
    emit EventsLib.SetOwner(newOwner);
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

- **owner** (`address`)

## State Variable Writes

- **owner** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Morpho.setOwner(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: Morpho.onlyOwner() (NodeID: 1)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

@inheritdoc IMorphoBase

### Interface Documentation

@notice Sets `newOwner` as `owner` of the contract.
 @dev Warning: No two-step transfer ownership.
 @dev Warning: The owner can be set to the zero address.
