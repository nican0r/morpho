# Function: targetArtifactSelectors()

**Contract**: [test/halmos/HalmosTest.sol/contract_HalmosTest.md]

## Metadata

- **Contract**: HalmosTest
- **Signature**: `targetArtifactSelectors()`
- **Visibility**: public
- **Source Range**: 2738:178:13
- **Inherited From**: StdInvariant

## Implementation

```solidity
function targetArtifactSelectors() public view returns (FuzzSelector[] memory targetedArtifactSelectors_) {
    targetedArtifactSelectors_ = _targetedArtifactSelectors;
}
```

## State Variable Reads

- **_targetedArtifactSelectors** (`struct StdInvariant.FuzzSelector[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.targetArtifactSelectors() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
