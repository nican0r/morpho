# Function: morpho_setAuthorizationWithSig_clamped()

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `morpho_setAuthorizationWithSig_clamped()`
- **Visibility**: public
- **Source Range**: 3470:496:67
- **Inherited From**: MorphoTargets

## Implementation

```solidity
function morpho_setAuthorizationWithSig_clamped() public asActor() {
    Authorization memory authorization = Authorization({authorizer: _getActor(), authorized: _getActor(), isAuthorized: true, nonce: morpho.nonce(_getActor()), deadline: block.timestamp + 1 days});
    Signature memory signature = Signature({v: 0, r: bytes32(0), s: bytes32(0)});
    morpho.setAuthorizationWithSig(authorization, signature);
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

## External Calls

- **Morpho::nonce(address)**
- **Morpho::setAuthorizationWithSig(struct Authorization,struct Signature)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MorphoTargets.morpho_setAuthorizationWithSig_clamped() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 4)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 5)
        💬 Args: [no args]
        👁️  Def: internal
```
