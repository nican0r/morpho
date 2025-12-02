# Function: morpho_enableLltv(uint256)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `morpho_enableLltv(uint256)`
- **Visibility**: public
- **Source Range**: 668:96:64
- **Inherited From**: AdminTargets

## Implementation

```solidity
function morpho_enableLltv(uint256 lltv) public asAdmin() {
    morpho.enableLltv(lltv);
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
┌─ [0] ⚙️ FUNCTION: AdminTargets.morpho_enableLltv(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
