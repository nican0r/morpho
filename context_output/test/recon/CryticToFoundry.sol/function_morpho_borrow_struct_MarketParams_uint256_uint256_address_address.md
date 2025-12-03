# Function: morpho_borrow(struct MarketParams,uint256,uint256,address,address)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `morpho_borrow(struct MarketParams,uint256,uint256,address,address)`
- **Visibility**: public
- **Source Range**: 5934:266:67
- **Inherited From**: MorphoTargets

## Implementation

```solidity
function morpho_borrow(MarketParams memory marketParams, uint256 assets, uint256 shares, address onBehalf, address receiver) public asActor() {
    morpho.borrow(marketParams, assets, shares, onBehalf, receiver);
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

- **Morpho::borrow(struct MarketParams,uint256,uint256,address,address)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MorphoTargets.morpho_borrow(struct MarketParams,uint256,uint256,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```
