# Function: oracle_increasePrice(uint256)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `oracle_increasePrice(uint256)`
- **Visibility**: public
- **Source Range**: 1834:448:65
- **Inherited From**: DoomsdayTargets

## Implementation

```solidity
/// @dev Increase oracle price (makes positions healthier)
function oracle_increasePrice(uint256 priceIncreasePercentage) public {
    priceIncreasePercentage = (priceIncreasePercentage % 100) + 1;
    uint256 newPrice = (ORACLE_PRICE_SCALE * (100 + priceIncreasePercentage)) / 100;
    vm.prank(address(this));
    oracle.setPrice(newPrice);
}
```

## External Calls

- **IHevm::prank(address)**
- **OracleMock::setPrice(uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DoomsdayTargets.oracle_increasePrice(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@dev Increase oracle price (makes positions healthier)
