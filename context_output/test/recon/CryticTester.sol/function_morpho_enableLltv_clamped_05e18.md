# Function: morpho_enableLltv_clamped_05e18()

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `morpho_enableLltv_clamped_05e18()`
- **Visibility**: public
- **Source Range**: 751:100:64
- **Inherited From**: AdminTargets

## Implementation

```solidity
function morpho_enableLltv_clamped_05e18() public asAdmin() {
    morpho.enableLltv(0.5e18);
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
┌─ [0] ⚙️ FUNCTION: AdminTargets.morpho_enableLltv_clamped_05e18() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
