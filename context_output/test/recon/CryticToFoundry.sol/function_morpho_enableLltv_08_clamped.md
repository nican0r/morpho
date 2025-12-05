# Function: morpho_enableLltv_08_clamped()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `morpho_enableLltv_08_clamped()`
- **Visibility**: public
- **Source Range**: 865:97:64
- **Inherited From**: AdminTargets

## Implementation

```solidity
function morpho_enableLltv_08_clamped() public asAdmin() {
    morpho_enableLltv(0.8e18);
}
```

## Related Implementations

### morpho_enableLltv(uint256)

- **Kind**: internal
- **Source**: 1611:96:64
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:morpho_enableLltv(uint256)`

```solidity
function morpho_enableLltv(uint256 lltv) public asAdmin() {
    morpho.enableLltv(lltv);
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
┌─ [0] ⚙️ FUNCTION: AdminTargets.morpho_enableLltv_08_clamped() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AdminTargets.morpho_enableLltv(uint256) (NodeID: 1)
  │   💬 Args: [0.8e18]
  │   👁️  Def: public
  │ └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
  │     💬 Args: [no args]
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 3)
      💬 Args: [no args]
```
