# Function: morpho_withdrawCollateral_clamped(uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `morpho_withdrawCollateral_clamped(uint256)`
- **Visibility**: public
- **Source Range**: 5321:379:67
- **Inherited From**: MorphoTargets

## Implementation

```solidity
function morpho_withdrawCollateral_clamped(uint256 assets_) public asActor() {
    (, , uint128 collateral) = morpho.position(defaultMarketId, _getActor());
    uint256 maxAssets = uint256(collateral);
    uint256 assets = (maxAssets > 0) ? between(assets_, 0, maxAssets) : 0;
    morpho.withdrawCollateral(defaultMarketParams, assets, _getActor(), _getActor());
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

### between(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 1261:269:4
- **Link**: `lib/chimera/src/CryticAsserts.sol:CryticAsserts:between(uint256,uint256,uint256)`

```solidity
function between(uint256 value, uint256 low, uint256 high) virtual override internal returns (uint256) {
    if ((value < low) || (value > high)) {
        uint256 ans = low + (value % ((high - low) + 1));
        return ans;
    }
    return value;
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

- **Morpho::position(Id,address)**
- **Morpho::withdrawCollateral(struct MarketParams,uint256,address,address)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MorphoTargets.morpho_withdrawCollateral_clamped(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: CryticAsserts.between(uint256,uint256,uint256) (NodeID: 2)
  │   💬 Args: [assets_, 0, maxAssets]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 4)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 5)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 6)
        💬 Args: [no args]
        👁️  Def: internal
```
