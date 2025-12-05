# Function: morpho_setFee_clamped(uint256)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `morpho_setFee_clamped(uint256)`
- **Visibility**: public
- **Source Range**: 1002:152:64
- **Inherited From**: AdminTargets

## Implementation

```solidity
function morpho_setFee_clamped(uint256 newFee) public asAdmin() {
    newFee %= MAX_FEE + 1;
    morpho_setFee(defaultMarketParams, newFee);
}
```

## Related Implementations

### morpho_setFee(struct MarketParams,uint256)

- **Kind**: internal
- **Source**: 1713:140:64
- **Link**: `test/recon/targets/AdminTargets.sol:AdminTargets:morpho_setFee(struct MarketParams,uint256)`

```solidity
function morpho_setFee(MarketParams memory marketParams, uint256 newFee) public asAdmin() {
    morpho.setFee(marketParams, newFee);
}
```

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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: AdminTargets.morpho_setFee_clamped(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AdminTargets.morpho_setFee(struct MarketParams,uint256) (NodeID: 1)
  │   💬 Args: [defaultMarketParams, newFee]
  │   👁️  Def: public
  │ └─ [2] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
  │     💬 Args: [no args]
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 3)
      💬 Args: [no args]
```
