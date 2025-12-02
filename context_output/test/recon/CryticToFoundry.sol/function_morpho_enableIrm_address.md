# Function: morpho_enableIrm(address)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `morpho_enableIrm(address)`
- **Visibility**: public
- **Source Range**: 570:92:64
- **Inherited From**: AdminTargets

## Implementation

```solidity
/// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///
function morpho_enableIrm(address irm) public asAdmin() {
    morpho.enableIrm(irm);
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

- **Morpho::enableIrm(address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.morpho_enableIrm(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

CUSTOM TARGET FUNCTIONS - Add your own target functions here ///
