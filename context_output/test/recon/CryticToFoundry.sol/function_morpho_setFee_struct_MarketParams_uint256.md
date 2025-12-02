# Function: morpho_setFee(struct MarketParams,uint256)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `morpho_setFee(struct MarketParams,uint256)`
- **Visibility**: public
- **Source Range**: 770:140:64
- **Inherited From**: AdminTargets

## Implementation

```solidity
function morpho_setFee(MarketParams memory marketParams, uint256 newFee) public asAdmin() {
    morpho.setFee(marketParams, newFee);
}
```

## Related Implementations

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

## External Calls

- **Morpho::setFee(struct MarketParams,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.morpho_setFee(struct MarketParams,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 1)
      💬 Args: [no args]
```
