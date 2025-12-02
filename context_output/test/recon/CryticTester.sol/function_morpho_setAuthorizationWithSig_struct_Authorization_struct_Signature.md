# Function: morpho_setAuthorizationWithSig(struct Authorization,struct Signature)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `morpho_setAuthorizationWithSig(struct Authorization,struct Signature)`
- **Visibility**: public
- **Source Range**: 2021:214:67
- **Inherited From**: MorphoTargets

## Implementation

```solidity
function morpho_setAuthorizationWithSig(Authorization memory authorization, Signature memory signature) public asActor() {
    morpho.setAuthorizationWithSig(authorization, signature);
}
```

## Related Implementations

### asActor()

- **Kind**: modifier
- **Source**: 3899:75:62
- **Link**: `test/recon/Setup.sol:Setup:asActor()`

```solidity
modifier asActor() {
    vm.prank(address(_getActor()));
    _;
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

## External Calls

- **Morpho::setAuthorizationWithSig(struct Authorization,struct Signature)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MorphoTargets.morpho_setAuthorizationWithSig(struct Authorization,struct Signature) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```
