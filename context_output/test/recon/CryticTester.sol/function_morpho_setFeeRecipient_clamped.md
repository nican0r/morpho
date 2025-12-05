# Function: morpho_setFeeRecipient_clamped()

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `morpho_setFeeRecipient_clamped()`
- **Visibility**: public
- **Source Range**: 1203:109:64
- **Inherited From**: AdminTargets

## Implementation

```solidity
function morpho_setFeeRecipient_clamped() public asAdmin() {
    morpho_setFeeRecipient(_getActor());
}
```

## Related Implementations

### morpho_setFeeRecipient(address)

- **Kind**: internal
- **Source**: 1859:128:64
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:morpho_setFeeRecipient(address)`

```solidity
function morpho_setFeeRecipient(address newFeeRecipient) public asAdmin() {
    morpho.setFeeRecipient(newFeeRecipient);
}
```

### _getActor()

- **Kind**: internal
- **Source**: 1115:83:29
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_getActor()`

```solidity
/// @notice Returns the current active actor
function _getActor() internal view returns (address) {
    return _actor;
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

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.morpho_setFeeRecipient_clamped() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AdminTargets.morpho_setFeeRecipient(address) (NodeID: 1)
  │   💬 Args: [_getActor()]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
  │     💬 Args: [no args]
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 4)
      💬 Args: [no args]
```
