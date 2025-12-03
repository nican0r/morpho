# Function: morpho_enableLltv_clamped_08e18()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `morpho_enableLltv_clamped_08e18()`
- **Visibility**: public
- **Source Range**: 907:100:64
- **Inherited From**: AdminTargets

## Implementation

```solidity
function morpho_enableLltv_clamped_08e18() public asAdmin() {
    morpho.enableLltv(0.8e18);
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

- **Morpho::enableLltv(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.morpho_enableLltv_clamped_08e18() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
