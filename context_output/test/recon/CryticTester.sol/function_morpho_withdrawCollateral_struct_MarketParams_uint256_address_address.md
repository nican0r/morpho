# Function: morpho_withdrawCollateral(struct MarketParams,uint256,address,address)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `morpho_withdrawCollateral(struct MarketParams,uint256,address,address)`
- **Visibility**: public
- **Source Range**: 8244:258:67
- **Inherited From**: MorphoTargets

## Implementation

```solidity
function morpho_withdrawCollateral(MarketParams memory marketParams, uint256 assets, address onBehalf, address receiver) public asActor() {
    morpho.withdrawCollateral(marketParams, assets, onBehalf, receiver);
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

- **Morpho::withdrawCollateral(struct MarketParams,uint256,address,address)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MorphoTargets.morpho_withdrawCollateral(struct MarketParams,uint256,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```
