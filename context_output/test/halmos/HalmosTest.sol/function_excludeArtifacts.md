# Function: excludeArtifacts()

**Contract**: [test/halmos/HalmosTest.sol/contract_HalmosTest.md]

## Metadata

- **Contract**: HalmosTest
- **Signature**: `excludeArtifacts()`
- **Visibility**: public
- **Source Range**: 2157:141:13
- **Inherited From**: StdInvariant

## Implementation

```solidity
function excludeArtifacts() public view returns (string[] memory excludedArtifacts_) {
    excludedArtifacts_ = _excludedArtifacts;
}
```

## State Variable Reads

- **_excludedArtifacts** (`string[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.excludeArtifacts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
