# Function: asset_mint(address,uint128)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `asset_mint(address,uint128)`
- **Visibility**: public
- **Source Range**: 1704:126:66
- **Inherited From**: ManagersTargets

## Implementation

```solidity
/// @dev Mint to arbitrary address, uses owner by default, even though MockERC20 doesn't check
function asset_mint(address to, uint128 amt) public updateGhosts() asAdmin() {
    MockERC20(_getAsset()).mint(to, amt);
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

- **MockERC20::mint(address,uint256)**

## State Variable Reads

- **__asset** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ManagersTargets.asset_mint(address,uint128) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AssetManager._getAsset() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
  │   💬 Args: [no args]
  └─ [1] 🔒 MODIFIER: BeforeAfter.updateGhosts() (NodeID: 3)
      💬 Args: [no args]
    ├─ [2] ⚙️ FUNCTION: BeforeAfter.__before() (NodeID: 4)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: BeforeAfter.__after() (NodeID: 5)
        💬 Args: [no args]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Mint to arbitrary address, uses owner by default, even though MockERC20 doesn't check
