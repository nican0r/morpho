# Function: approve(address,uint256)

**Contract**: [src/mocks/ERC20Mock.sol/contract_ERC20Mock.md]

## Metadata

- **Contract**: ERC20Mock
- **Signature**: `approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 593:211:52

## Implementation

```solidity
function approve(address spender, uint256 amount) virtual public returns (bool) {
    allowance[msg.sender][spender] = amount;
    emit Approval(msg.sender, spender, amount);
    return true;
}
```

## State Variable Writes

- **allowance** (`mapping(address => mapping(address => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ERC20Mock.approve(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
