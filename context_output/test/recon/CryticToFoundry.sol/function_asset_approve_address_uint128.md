# Function: asset_approve(address,uint128)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `asset_approve(address,uint128)`
- **Visibility**: public
- **Source Range**: 1467:132:66
- **Inherited From**: ManagersTargets

## Implementation

```solidity
/// @dev Approve to arbitrary address, uses Actor by default
///  NOTE: You're almost always better off setting approvals in `Setup`
function asset_approve(address to, uint128 amt) public updateGhosts() asActor() {
    MockERC20(_getAsset()).approve(to, amt);
}
```

## Related Implementations

### _getAsset()

- **Kind**: internal
- **Source**: 938:163:30
- **Link**: `lib/setup-helpers/src/AssetManager.sol:AssetManager:_getAsset()`

```solidity
/// @notice Returns the current active asset
function _getAsset() internal view returns (address) {
    if (__asset == address(0)) {
        revert NotSetup();
    }
    return __asset;
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

### updateGhosts()

- **Kind**: modifier
- **Source**: 335:79:58
- **Link**: `test/recon/BeforeAfter.sol:BeforeAfter:updateGhosts()`

```solidity
modifier updateGhosts() {
    __before();
    _;
    __after();
}
```

### __before()

- **Kind**: internal
- **Source**: 420:37:58
- **Link**: `test/recon/BeforeAfter.sol:BeforeAfter:__before()`

```solidity
function __before() internal {}
```

### __after()

- **Kind**: internal
- **Source**: 463:36:58
- **Link**: `test/recon/BeforeAfter.sol:BeforeAfter:__after()`

```solidity
function __after() internal {}
```

## External Calls

- **MockERC20::approve(address,uint256)**

## State Variable Reads

- **__asset** (`address`)
- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ManagersTargets.asset_approve(address,uint128) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AssetManager._getAsset() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 2)
  │   💬 Args: [no args]
  │ └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
  │     💬 Args: [no args]
  │     👁️  Def: internal
  └─ [1] 🔒 MODIFIER: BeforeAfter.updateGhosts() (NodeID: 4)
      💬 Args: [no args]
    ├─ [2] ⚙️ FUNCTION: BeforeAfter.__before() (NodeID: 5)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BeforeAfter.__after() (NodeID: 6)
        💬 Args: [no args]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Approve to arbitrary address, uses Actor by default
 NOTE: You're almost always better off setting approvals in `Setup`
