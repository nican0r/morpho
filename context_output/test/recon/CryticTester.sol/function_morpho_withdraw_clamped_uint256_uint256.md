# Function: morpho_withdraw_clamped(uint256,uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `morpho_withdraw_clamped(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 4683:586:67
- **Inherited From**: MorphoTargets

## Implementation

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

- **Morpho::market(Id)**
- **Morpho::position(Id,address)**
- **Morpho::withdraw(struct MarketParams,uint256,uint256,address,address)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MorphoTargets.morpho_withdraw_clamped(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: CryticAsserts.between(uint256,uint256,uint256) (NodeID: 2)
  │   💬 Args: [assets_, 0, maxAssets]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: CryticAsserts.between(uint256,uint256,uint256) (NodeID: 3)
  │   💬 Args: [shares_, 0, maxShares]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 4)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 5)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 6)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 7)
        💬 Args: [no args]
        👁️  Def: internal
```
