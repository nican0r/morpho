# Function: constructor(address)

**Contract**: [src/Morpho.sol/contract_Morpho.md]

## Metadata

- **Contract**: Morpho
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 2345:270:35

## Implementation

```solidity
/// @param newOwner The new owner of the contract.
constructor(address newOwner) {
    require(newOwner != address(0), ErrorsLib.ZERO_ADDRESS);
    DOMAIN_SEPARATOR = keccak256(abi.encode(DOMAIN_TYPEHASH, block.chainid, address(this)));
    owner = newOwner;
    emit EventsLib.SetOwner(newOwner);
}
```

## State Variable Writes

- **DOMAIN_SEPARATOR** (`bytes32`)
- **owner** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: Morpho.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: Morpho
```

## Documentation

### Function Documentation

@param newOwner The new owner of the contract.
