# Function: oracle_crashPrice()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `oracle_crashPrice()`
- **Visibility**: public
- **Source Range**: 1573:188:65
- **Inherited From**: DoomsdayTargets

## Implementation

```solidity
/// @dev Drastically decrease price to create bad debt scenarios
function oracle_crashPrice() public {
    vm.prank(address(this));
    oracle.setPrice(ORACLE_PRICE_SCALE / 10);
}
```

## External Calls

- **IHevm::prank(address)**
- **OracleMock::setPrice(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DoomsdayTargets.oracle_crashPrice() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@dev Drastically decrease price to create bad debt scenarios
