# Function: morpho_setOwner_clamped()

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `morpho_setOwner_clamped()`
- **Visibility**: public
- **Source Range**: 1354:95:64
- **Inherited From**: AdminTargets

## Implementation

```solidity
function morpho_setOwner_clamped() public asAdmin() {
    morpho_setOwner(_getActor());
}
```

## Related Implementations

### morpho_setOwner(address)

- **Kind**: internal
- **Source**: 1993:100:64
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:morpho_setOwner(address)`

```solidity
function morpho_setOwner(address newOwner) public asAdmin() {
    morpho.setOwner(newOwner);
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
┌─ [0] ⚙️ FUNCTION: AdminTargets.morpho_setOwner_clamped() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AdminTargets.morpho_setOwner(address) (NodeID: 1)
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
