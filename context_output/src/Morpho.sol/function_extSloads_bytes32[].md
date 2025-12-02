# Function: extSloads(bytes32[])

**Contract**: [src/Morpho.sol/contract_Morpho.md]

## Metadata

- **Contract**: Morpho
- **Signature**: `extSloads(bytes32[])`
- **Visibility**: external
- **Source Range**: 21687:375:35

## Implementation

```solidity
/// @inheritdoc IMorphoBase
function extSloads(bytes32[] calldata slots) external view returns (bytes32[] memory res) {
    uint256 nSlots = slots.length;
    res = new bytes32[](nSlots);
    for (uint256 i; i < nSlots; ) {
        bytes32 slot = slots[i++];
        assembly ("memory-safe") {
            mstore(add(res, mul(i, 32)), sload(slot))
        }
    }
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Morpho.extSloads(bytes32[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IMorphoBase

### Interface Documentation

@notice Returns the data stored on the different `slots`.
