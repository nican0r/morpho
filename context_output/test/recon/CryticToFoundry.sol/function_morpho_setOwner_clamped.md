# Function: morpho_setOwner_clamped()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `morpho_setOwner_clamped()`
- **Visibility**: public
- **Source Range**: 1424:95:64
- **Inherited From**: AdminTargets

## Implementation

```solidity
function morpho_setOwner_clamped() public asAdmin() {
    morpho.setOwner(_getActor());
}
```

## Related Implementations

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

## External Calls

- **Morpho::setOwner(address)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.morpho_setOwner_clamped() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
      💬 Args: [no args]
```
