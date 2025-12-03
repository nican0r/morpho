# Function: morpho_liquidate_clamped(uint256,uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `morpho_liquidate_clamped(uint256,uint256)`
- **Visibility**: public
- **Source Range**: 2020:644:67
- **Inherited From**: MorphoTargets

## Implementation

```solidity
function morpho_liquidate_clamped(uint256 seizedAssets_, uint256 repaidShares_) public asActor() {
    address borrower = _getActor();
    (, uint128 borrowShares, uint128 collateral) = morpho.position(defaultMarketId, borrower);
    uint256 maxSeizedAssets = uint256(collateral);
    uint256 maxRepaidShares = uint256(borrowShares);
    uint256 seizedAssets = (maxSeizedAssets > 0) ? between(seizedAssets_, 0, maxSeizedAssets) : 0;
    uint256 repaidShares = (maxRepaidShares > 0) ? between(repaidShares_, 0, maxRepaidShares) : 0;
    morpho.liquidate(defaultMarketParams, borrower, seizedAssets, repaidShares, "");
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
- **Morpho::liquidate(struct MarketParams,address,uint256,uint256,bytes)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MorphoTargets.morpho_liquidate_clamped(uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: CryticAsserts.between(uint256,uint256,uint256) (NodeID: 2)
  │   💬 Args: [seizedAssets_, 0, maxSeizedAssets]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: CryticAsserts.between(uint256,uint256,uint256) (NodeID: 3)
  │   💬 Args: [repaidShares_, 0, maxRepaidShares]
  │   👁️  Def: internal
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 4)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 5)
        💬 Args: [no args]
        👁️  Def: internal
```
