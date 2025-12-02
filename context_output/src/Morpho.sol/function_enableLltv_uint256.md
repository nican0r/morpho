# Function: enableLltv(uint256)

**Contract**: [src/Morpho.sol/contract_Morpho.md]

## Metadata

- **Contract**: Morpho
- **Signature**: `enableLltv(uint256)`
- **Visibility**: external
- **Source Range**: 3324:259:35

## Implementation

```solidity
/// @inheritdoc IMorphoBase
function enableLltv(uint256 lltv) external onlyOwner() {
    require(!isLltvEnabled[lltv], ErrorsLib.ALREADY_SET);
    require(lltv < WAD, ErrorsLib.MAX_LLTV_EXCEEDED);
    isLltvEnabled[lltv] = true;
    emit EventsLib.EnableLltv(lltv);
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

- **isLltvEnabled** (`mapping(uint256 => bool)`)
- **owner** (`address`)

## State Variable Writes

- **isLltvEnabled** (`mapping(uint256 => bool)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Morpho.enableLltv(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: Morpho.onlyOwner() (NodeID: 1)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

@inheritdoc IMorphoBase

### Interface Documentation

@notice Enables `lltv` as a possible LLTV for market creation.
 @dev Warning: It is not possible to disable a LLTV.
