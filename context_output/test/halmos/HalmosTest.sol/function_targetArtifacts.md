# Function: targetArtifacts()

**Contract**: [test/halmos/HalmosTest.sol/contract_HalmosTest.md]

## Metadata

- **Contract**: HalmosTest
- **Signature**: `targetArtifacts()`
- **Visibility**: public
- **Source Range**: 2592:140:13
- **Inherited From**: StdInvariant

## Implementation

```solidity
function targetArtifacts() public view returns (string[] memory targetedArtifacts_) {
    targetedArtifacts_ = _targetedArtifacts;
}
```

## State Variable Reads

- **_targetedArtifacts** (`string[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.targetArtifacts() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
