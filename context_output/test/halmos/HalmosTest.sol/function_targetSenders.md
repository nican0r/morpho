# Function: targetSenders()

**Contract**: [test/halmos/HalmosTest.sol/contract_HalmosTest.md]

## Metadata

- **Contract**: HalmosTest
- **Signature**: `targetSenders()`
- **Visibility**: public
- **Source Range**: 3221:133:13
- **Inherited From**: StdInvariant

## Implementation

```solidity
function targetSenders() public view returns (address[] memory targetedSenders_) {
    targetedSenders_ = _targetedSenders;
}
```

## State Variable Reads

- **_targetedSenders** (`address[]`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: StdInvariant.targetSenders() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
