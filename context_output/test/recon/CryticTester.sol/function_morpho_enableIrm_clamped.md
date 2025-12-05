# Function: morpho_enableIrm_clamped()

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `morpho_enableIrm_clamped()`
- **Visibility**: public
- **Source Range**: 597:98:64
- **Inherited From**: AdminTargets

## Implementation

```solidity
/// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///
function morpho_enableIrm_clamped() public asAdmin() {
    morpho_enableIrm(address(irm));
}
```

## Related Implementations

### morpho_enableIrm(address)

- **Kind**: internal
- **Source**: 1513:92:64
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:morpho_enableIrm(address)`

```solidity
function morpho_enableIrm(address irm) public asAdmin() {
    morpho.enableIrm(irm);
}
```

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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.morpho_enableIrm_clamped() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AdminTargets.morpho_enableIrm(address) (NodeID: 1)
  │   💬 Args: [address(irm)]
  │   👁️  Def: public
  │ └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
  │     💬 Args: [no args]
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 3)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

CUSTOM TARGET FUNCTIONS - Add your own target functions here ///
