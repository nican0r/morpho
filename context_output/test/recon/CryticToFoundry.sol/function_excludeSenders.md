# Function: excludeSenders()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `excludeSenders()`
- **Visibility**: public
- **Source Range**: 2452:134:13
- **Inherited From**: StdInvariant

## Implementation

```solidity
function excludeSenders() public view returns (address[] memory excludedSenders_) {
    excludedSenders_ = _excludedSenders;
}
```

## State Variable Reads

- **_excludedSenders** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.excludeSenders() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
