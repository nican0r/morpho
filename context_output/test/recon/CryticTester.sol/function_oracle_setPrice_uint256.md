# Function: oracle_setPrice(uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `oracle_setPrice(uint256)`
- **Visibility**: public
- **Source Range**: 1236:258:65
- **Inherited From**: DoomsdayTargets

## Implementation

```solidity
/// @dev Set oracle price to a specific value
function oracle_setPrice(uint256 price) public {
    price = (price % (ORACLE_PRICE_SCALE * 10)) + 1;
    vm.prank(address(this));
    oracle.setPrice(price);
}
```

## External Calls

- **IHevm::prank(address)**
- **OracleMock::setPrice(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DoomsdayTargets.oracle_setPrice(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@dev Set oracle price to a specific value
