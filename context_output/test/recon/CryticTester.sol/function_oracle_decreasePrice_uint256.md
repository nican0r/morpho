# Function: oracle_decreasePrice(uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `oracle_decreasePrice(uint256)`
- **Visibility**: public
- **Source Range**: 647:529:65
- **Inherited From**: DoomsdayTargets

## Implementation

```solidity
/// @dev Manipulate oracle price to make positions unhealthy (enables liquidation)
function oracle_decreasePrice(uint256 priceDropPercentage) public {
    priceDropPercentage = (priceDropPercentage % 99) + 1;
    uint256 newPrice = (ORACLE_PRICE_SCALE * (100 - priceDropPercentage)) / 100;
    if (newPrice == 0) newPrice = 1;
    vm.prank(address(this));
    oracle.setPrice(newPrice);
}
```

## External Calls

- **IHevm::prank(address)**
- **OracleMock::setPrice(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DoomsdayTargets.oracle_decreasePrice(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@dev Manipulate oracle price to make positions unhealthy (enables liquidation)
