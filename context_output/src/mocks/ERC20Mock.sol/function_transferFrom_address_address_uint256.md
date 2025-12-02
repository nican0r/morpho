# Function: transferFrom(address,address,uint256)

**Contract**: [src/mocks/ERC20Mock.sol/contract_ERC20Mock.md]

## Metadata

- **Contract**: ERC20Mock
- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 1118:433:52

## Implementation

```solidity
function transferFrom(address from, address to, uint256 amount) virtual public returns (bool) {
    require(allowance[from][msg.sender] >= amount, "insufficient allowance");
    allowance[from][msg.sender] -= amount;
    require(balanceOf[from] >= amount, "insufficient balance");
    balanceOf[from] -= amount;
    balanceOf[to] += amount;
    emit Transfer(from, to, amount);
    return true;
}
```

## State Variable Reads

- **allowance** (`mapping(address => mapping(address => uint256))`)
- **balanceOf** (`mapping(address => uint256)`)

## State Variable Writes

- **allowance** (`mapping(address => mapping(address => uint256))`)
- **balanceOf** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20Mock.transferFrom(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
