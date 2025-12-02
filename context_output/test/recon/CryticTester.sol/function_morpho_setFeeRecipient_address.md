# Function: morpho_setFeeRecipient(address)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `morpho_setFeeRecipient(address)`
- **Visibility**: public
- **Source Range**: 916:128:64
- **Inherited From**: AdminTargets

## Implementation

```solidity
function morpho_setFeeRecipient(address newFeeRecipient) public asAdmin() {
    morpho.setFeeRecipient(newFeeRecipient);
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

- **Morpho::setFeeRecipient(address)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.morpho_setFeeRecipient(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
