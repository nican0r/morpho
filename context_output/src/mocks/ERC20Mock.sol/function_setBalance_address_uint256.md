# Function: setBalance(address,uint256)

**Contract**: [src/mocks/ERC20Mock.sol/contract_ERC20Mock.md]

## Metadata

- **Contract**: ERC20Mock
- **Signature**: `setBalance(address,uint256)`
- **Visibility**: public
- **Source Range**: 332:255:52

## Implementation

```solidity
function setBalance(address account, uint256 amount) virtual public {
    if (amount > balanceOf[account]) totalSupply += amount - balanceOf[account]; else totalSupply -= balanceOf[account] - amount;
    balanceOf[account] = amount;
}
```

## State Variable Reads

- **balanceOf** (`mapping(address => uint256)`)

## State Variable Writes

- **totalSupply** (`uint256`)
- **balanceOf** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20Mock.setBalance(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
