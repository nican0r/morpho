# Function: flashLoan(address,uint256,bytes)

**Contract**: [src/mocks/FlashBorrowerMock.sol/contract_FlashBorrowerMock.md]

## Metadata

- **Contract**: FlashBorrowerMock
- **Signature**: `flashLoan(address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 419:134:53

## Implementation

```solidity
function flashLoan(address token, uint256 assets, bytes calldata data) external {
    MORPHO.flashLoan(token, assets, data);
}
```

## External Calls

- **IMorpho::flashLoan(address,uint256,bytes)**

## State Variable Reads

- **MORPHO** (`contract IMorpho`) [src/interfaces/IMorpho.sol/interface_IMorpho.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: FlashBorrowerMock.flashLoan(address,uint256,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
