# Function: morpho_setFee_clamped(uint256)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `morpho_setFee_clamped(uint256)`
- **Visibility**: public
- **Source Range**: 1047:177:64
- **Inherited From**: AdminTargets

## Implementation

```solidity
function morpho_setFee_clamped(uint256 newFee_) public asAdmin() {
    uint256 newFee = between(newFee_, 0, MAX_FEE);
    morpho.setFee(defaultMarketParams, newFee);
}
```

## Related Implementations

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
┌─ [0] ⚙️ FUNCTION: AdminTargets.morpho_setFee_clamped(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: FoundryAsserts.between(uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [newFee_, 0, MAX_FEE]
  │   👁️  Def: internal
  └─ [1] 🔒 MODIFIER: Setup.asAdmin() (NodeID: 2)
      💬 Args: [no args]
```
