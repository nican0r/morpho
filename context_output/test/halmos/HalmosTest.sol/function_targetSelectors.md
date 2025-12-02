# Function: targetSelectors()

**Contract**: [test/halmos/HalmosTest.sol/contract_HalmosTest.md]

## Metadata

- **Contract**: HalmosTest
- **Signature**: `targetSelectors()`
- **Visibility**: public
- **Source Range**: 3069:146:13
- **Inherited From**: StdInvariant

## Implementation

```solidity
function targetSelectors() public view returns (FuzzSelector[] memory targetedSelectors_) {
    targetedSelectors_ = _targetedSelectors;
}
```

## State Variable Reads

- **_targetedSelectors** (`struct StdInvariant.FuzzSelector[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.targetSelectors() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
