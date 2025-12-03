# Function: shortcut_withdraw(uint256,uint256,uint256)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `shortcut_withdraw(uint256,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 3161:382:63
- **Inherited From**: TargetFunctions

## Implementation

```solidity
function shortcut_withdraw(uint256 supplyAmount, uint256 withdrawAssets, uint256 withdrawShares) public {
    morpho_createMarket_clamped();
    morpho_supply_clamped(supplyAmount);
    morpho_withdraw_clamped(withdrawAssets, withdrawShares);
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

### morpho_withdraw_clamped(uint256,uint256)

- **Kind**: internal
- **Source**: 4683:586:67
- **Link**: `test/recon/targets/MorphoTargets.sol:MorphoTargets:morpho_withdraw_clamped(uint256,uint256)`

```solidity
function morpho_withdraw_clamped(uint256 assets_, uint256 shares_) public asActor() {
    (uint128 totalSupplyAssets, , , , , ) = morpho.market(defaultMarketId);
    (uint256 supplyShares, , ) = morpho.position(defaultMarketId, _getActor());
    uint256 maxAssets = uint256(totalSupplyAssets);
    uint256 maxShares = supplyShares;
    uint256 assets = (maxAssets > 0) ? between(assets_, 0, maxAssets) : 0;
    uint256 shares = (maxShares > 0) ? between(shares_, 0, maxShares) : 0;
    morpho.withdraw(defaultMarketParams, assets, shares, _getActor(), _getActor());
}
```

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TargetFunctions.shortcut_withdraw(uint256,uint256,uint256) (NodeID: 0)
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
  └─ [1] ⚙️ FUNCTION: MorphoTargets.morpho_withdraw_clamped(uint256,uint256) (NodeID: 10)
      💬 Args: [withdrawAssets, withdrawShares]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 11)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: FoundryAsserts.between(uint256,uint256,uint256) (NodeID: 12)
    │   💬 Args: [assets_, 0, maxAssets]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: FoundryAsserts.between(uint256,uint256,uint256) (NodeID: 13)
    │   💬 Args: [shares_, 0, maxShares]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 14)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 15)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 16)
        💬 Args: [no args]
      └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 17)
          💬 Args: [no args]
          👁️  Def: internal
```
