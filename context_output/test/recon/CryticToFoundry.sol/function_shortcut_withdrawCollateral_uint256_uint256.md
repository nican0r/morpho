# Function: shortcut_withdrawCollateral(uint256,uint256)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `shortcut_withdrawCollateral(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 3644:372:63
- **Inherited From**: TargetFunctions

## Implementation

```solidity
function shortcut_withdrawCollateral(uint256 collateralAmount, uint256 withdrawAmount) public {
    morpho_createMarket_clamped();
    morpho_supplyCollateral_clamped(collateralAmount);
    morpho_withdrawCollateral_clamped(withdrawAmount);
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

### morpho_withdrawCollateral_clamped(uint256)

- **Kind**: internal
- **Source**: 5321:379:67
- **Link**: `test/recon/targets/MorphoTargets.sol:MorphoTargets:morpho_withdrawCollateral_clamped(uint256)`

```solidity
function morpho_withdrawCollateral_clamped(uint256 assets_) public asActor() {
    (, , uint128 collateral) = morpho.position(defaultMarketId, _getActor());
    uint256 maxAssets = uint256(collateral);
    uint256 assets = (maxAssets > 0) ? between(assets_, 0, maxAssets) : 0;
    morpho.withdrawCollateral(defaultMarketParams, assets, _getActor(), _getActor());
}
```

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TargetFunctions.shortcut_withdrawCollateral(uint256,uint256) (NodeID: 0)
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
  ├─ [1] ⚙️ FUNCTION: MorphoTargets.morpho_supplyCollateral_clamped(uint256) (NodeID: 4)
  │   💬 Args: [collateralAmount]
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
  └─ [1] ⚙️ FUNCTION: MorphoTargets.morpho_withdrawCollateral_clamped(uint256) (NodeID: 10)
      💬 Args: [withdrawAmount]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 11)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: FoundryAsserts.between(uint256,uint256,uint256) (NodeID: 12)
    │   💬 Args: [assets_, 0, maxAssets]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 13)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 14)
    │   💬 Args: [no args]
    │   👁️  Def: internal
    └─ [2] 🔒 MODIFIER: Setup.asActor() (NodeID: 15)
        💬 Args: [no args]
      └─ [3] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 16)
          💬 Args: [no args]
          👁️  Def: internal
```
