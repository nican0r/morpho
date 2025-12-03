# Function: shortcut_repay(uint256,uint256,uint256,uint256,uint256)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `shortcut_repay(uint256,uint256,uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 2403:681:63
- **Inherited From**: TargetFunctions

## Implementation

```solidity
function shortcut_repay(uint256 supplyAmount, uint256 collateralAmount, uint256 borrowAmount, uint256 repayAssets, uint256 repayShares) public {
    morpho_createMarket_clamped();
    morpho_supply_clamped(supplyAmount);
    switchActor(1);
    morpho_supplyCollateral_clamped(collateralAmount);
    morpho_borrow_clamped(borrowAmount);
    morpho_repay_clamped(repayAssets, repayShares);
    switchActor(0);
}
```

## Related Implementations

### morpho_createMarket_clamped()

- **Kind**: internal
- **Source**: 1158:111:67
- **Link**: `test/recon/targets/MorphoTargets.sol:MorphoTargets:morpho_createMarket_clamped()`

```solidity
function morpho_createMarket_clamped() public asActor() {
    morpho.createMarket(defaultMarketParams);
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

### morpho_supply_clamped(uint256)

- **Kind**: internal
- **Source**: 4006:281:67
- **Link**: `test/recon/targets/MorphoTargets.sol:MorphoTargets:morpho_supply_clamped(uint256)`

```solidity
function morpho_supply_clamped(uint256 assets_) public asActor() {
    uint256 maxAssets = loanToken.balanceOf(_getActor());
    uint256 assets = (maxAssets > 0) ? between(assets_, 0, maxAssets) : 0;
    morpho.supply(defaultMarketParams, assets, 0, _getActor(), "");
}
```

### between(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 933:269:5
- **Link**: `lib/chimera/src/FoundryAsserts.sol:FoundryAsserts:between(uint256,uint256,uint256)`

```solidity
function between(uint256 value, uint256 low, uint256 high) virtual override internal returns (uint256) {
    if ((value < low) || (value > high)) {
        uint256 ans = low + (value % ((high - low) + 1));
        return ans;
    }
    return value;
}
```

### switchActor(uint256)

- **Kind**: internal
- **Source**: 680:83:66
- **Link**: `test/recon/targets/ManagersTargets.sol:ManagersTargets:switchActor(uint256)`

```solidity
/// @dev Start acting as another actor
function switchActor(uint256 entropy) public {
    _switchActor(entropy);
}
```

### _switchActor(uint256)

- **Kind**: internal
- **Source**: 2547:143:29
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_switchActor(uint256)`

```solidity
/// @dev Expose this in the `TargetFunctions` contract to let the fuzzer switch actors
///    NOTE: We revert if the entropy is greater than the number of actors, for Halmos compatibility
///  @dev This may reduce fuzzing performance if using multiple actors, if so add explicitly clamped handlers to ManagersTargets using the index of all added actors
///  @notice Switches the current actor based on the entropy
///  @param entropy The entropy to choose a random actor in the array for switching
///  @return target The new active actor
function _switchActor(uint256 entropy) internal returns (address target) {
    target = _actors.at(entropy);
    _actor = target;
}
```

### at(struct EnumerableSet.AddressSet,uint256)

- **Kind**: internal
- **Source**: 9563:156:31
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:at(struct EnumerableSet.AddressSet,uint256)`

```solidity
///  @dev Returns the value stored at position `index` in the set. O(1).
///  Note that there are no guarantees on the ordering of values inside the
///  array, and it may change when more values are added or removed.
///  Requirements:
///  - `index` must be strictly less than {length}.
function at(AddressSet storage set, uint256 index) internal view returns (address) {
    return address(uint160(uint256(_at(set._inner, index))));
}
```

### _at(struct EnumerableSet.Set,uint256)

- **Kind**: internal
- **Source**: 4912:118:31
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_at(struct EnumerableSet.Set,uint256)`

```solidity
///  @dev Returns the value stored at position `index` in the set. O(1).
///  Note that there are no guarantees on the ordering of values inside the
///  array, and it may change when more values are added or removed.
///  Requirements:
///  - `index` must be strictly less than {length}.
function _at(Set storage set, uint256 index) private view returns (bytes32) {
    return set._values[index];
}
```

### morpho_supplyCollateral_clamped(uint256)

- **Kind**: internal
- **Source**: 4337:304:67
- **Link**: `test/recon/targets/MorphoTargets.sol:MorphoTargets:morpho_supplyCollateral_clamped(uint256)`

```solidity
function morpho_supplyCollateral_clamped(uint256 assets_) public asActor() {
    uint256 maxAssets = collateralToken.balanceOf(_getActor());
    uint256 assets = (maxAssets > 0) ? between(assets_, 0, maxAssets) : 0;
    morpho.supplyCollateral(defaultMarketParams, assets, _getActor(), "");
}
```

### morpho_borrow_clamped(uint256)

- **Kind**: internal
- **Source**: 753:359:67
- **Link**: `test/recon/targets/MorphoTargets.sol:MorphoTargets:morpho_borrow_clamped(uint256)`

```solidity
function morpho_borrow_clamped(uint256 assets_) public asActor() {
    (uint128 totalSupplyAssets, , , , , ) = morpho.market(defaultMarketId);
    uint256 maxAssets = uint256(totalSupplyAssets);
    uint256 assets = (maxAssets > 0) ? between(assets_, 0, maxAssets) : 0;
    morpho.borrow(defaultMarketParams, assets, 0, _getActor(), _getActor());
}
```

### morpho_repay_clamped(uint256,uint256)

- **Kind**: internal
- **Source**: 2703:512:67
- **Link**: `test/recon/targets/MorphoTargets.sol:MorphoTargets:morpho_repay_clamped(uint256,uint256)`

```solidity
function morpho_repay_clamped(uint256 assets_, uint256 shares_) public asActor() {
    (, uint128 borrowShares, ) = morpho.position(defaultMarketId, _getActor());
    uint256 maxAssets = loanToken.balanceOf(_getActor());
    uint256 maxShares = uint256(borrowShares);
    uint256 assets = (maxAssets > 0) ? between(assets_, 0, maxAssets) : 0;
    uint256 shares = (maxShares > 0) ? between(shares_, 0, maxShares) : 0;
    morpho.repay(defaultMarketParams, assets, shares, _getActor(), "");
}
```

## State Variable Reads

- **_actor** (`address`)
- **_actors** (`struct EnumerableSet.AddressSet`)

## State Variable Writes

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TargetFunctions.shortcut_repay(uint256,uint256,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: MorphoTargets.morpho_createMarket_clamped() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: public
  │ └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 2)
  │     💬 Args: [no args]
  │   └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: MorphoTargets.morpho_supply_clamped(uint256) (NodeID: 4)
  │   💬 Args: [supplyAmount]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 5)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: FoundryAsserts.between(uint256,uint256,uint256) (NodeID: 6)
  │ │   💬 Args: [assets_, 0, maxAssets]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 7)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 8)
  │     💬 Args: [no args]
  │   └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 9)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ManagersTargets.switchActor(uint256) (NodeID: 10)
  │   💬 Args: [1]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: ActorManager._switchActor(uint256) (NodeID: 11)
  │     💬 Args: [entropy]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: EnumerableSet.at(struct EnumerableSet.AddressSet,uint256) (NodeID: 12)
  │       💬 Args: [_actors, entropy]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: EnumerableSet._at(struct EnumerableSet.Set,uint256) (NodeID: 13)
  │         💬 Args: [set._inner, index]
  │         👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: MorphoTargets.morpho_supplyCollateral_clamped(uint256) (NodeID: 14)
  │   💬 Args: [collateralAmount]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 15)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: FoundryAsserts.between(uint256,uint256,uint256) (NodeID: 16)
  │ │   💬 Args: [assets_, 0, maxAssets]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 17)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 18)
  │     💬 Args: [no args]
  │   └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 19)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: MorphoTargets.morpho_borrow_clamped(uint256) (NodeID: 20)
  │   💬 Args: [borrowAmount]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: FoundryAsserts.between(uint256,uint256,uint256) (NodeID: 21)
  │ │   💬 Args: [assets_, 0, maxAssets]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 22)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 23)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 24)
  │     💬 Args: [no args]
  │   └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 25)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: MorphoTargets.morpho_repay_clamped(uint256,uint256) (NodeID: 26)
  │   💬 Args: [repayAssets, repayShares]
  │   👁️  Def: public
  │ ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 27)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 28)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: FoundryAsserts.between(uint256,uint256,uint256) (NodeID: 29)
  │ │   💬 Args: [assets_, 0, maxAssets]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: FoundryAsserts.between(uint256,uint256,uint256) (NodeID: 30)
  │ │   💬 Args: [shares_, 0, maxShares]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 31)
  │ │   💬 Args: [no args]
  │ │   👁️  Def: internal
  │ └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 32)
  │     💬 Args: [no args]
  │   └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 33)
  │       💬 Args: [no args]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ManagersTargets.switchActor(uint256) (NodeID: 34)
      💬 Args: [0]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: ActorManager._switchActor(uint256) (NodeID: 35)
        💬 Args: [entropy]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: EnumerableSet.at(struct EnumerableSet.AddressSet,uint256) (NodeID: 36)
          💬 Args: [_actors, entropy]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: EnumerableSet._at(struct EnumerableSet.Set,uint256) (NodeID: 37)
            💬 Args: [set._inner, index]
            👁️  Def: private
```
