# Function: morpho_accrueInterest(struct MarketParams)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `morpho_accrueInterest(struct MarketParams)`
- **Visibility**: public
- **Source Range**: 5796:132:67
- **Inherited From**: MorphoTargets

## Implementation

```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function morpho_accrueInterest(MarketParams memory marketParams) public asActor() {
    morpho.accrueInterest(marketParams);
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

- **Morpho::accrueInterest(struct MarketParams)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MorphoTargets.morpho_accrueInterest(struct MarketParams) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 1)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 2)
        💬 Args: [no args]
        👁️  Def: internal
```

## Documentation

### Function Documentation

AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
