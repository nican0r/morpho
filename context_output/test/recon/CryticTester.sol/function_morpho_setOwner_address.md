# Function: morpho_setOwner(address)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `morpho_setOwner(address)`
- **Visibility**: public
- **Source Range**: 1050:100:64
- **Inherited From**: AdminTargets

## Implementation

```solidity
function morpho_setOwner(address newOwner) public asAdmin() {
    morpho.setOwner(newOwner);
}
```

## Related Implementations

### asAdmin()

- **Kind**: modifier
- **Source**: 3825:68:62
- **Link**: `test/recon/Setup.sol:Setup:asAdmin()`

```solidity
/// === MODIFIERS === ///
///  Prank admin and actor
modifier asAdmin() {
    vm.prank(address(this));
    _;
}
```

## External Calls

- **Morpho::setOwner(address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.morpho_setOwner(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
