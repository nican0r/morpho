# Interface: IERC20

## Metadata

- **Name**: IERC20
- **Type**: Interface
- **Path**: src/mocks/interfaces/IERC20.sol

## Events

### Transfer

```solidity
event Transfer(address indexed from, address indexed to, uint256 value);
```

### Approval

```solidity
event Approval(address indexed owner, address indexed spender, uint256 value);
```

## Public/External Functions

### totalSupply()

- **Signature**: `totalSupply()`
- **Visibility**: external
- **Source Range**: 294:55:56

**Signature:**
```solidity
function totalSupply() external view returns (uint256);;
```

### balanceOf(address)

- **Signature**: `balanceOf(address)`
- **Visibility**: external
- **Source Range**: 355:68:56

**Signature:**
```solidity
function balanceOf(address account) external view returns (uint256);;
```

### transfer(address,uint256)

- **Signature**: `transfer(address,uint256)`
- **Visibility**: external
- **Source Range**: 429:69:56

**Signature:**
```solidity
function transfer(address to, uint256 value) external returns (bool);;
```

### allowance(address,address)

- **Signature**: `allowance(address,address)`
- **Visibility**: external
- **Source Range**: 504:83:56

**Signature:**
```solidity
function allowance(address owner, address spender) external view returns (uint256);;
```

### approve(address,uint256)

- **Signature**: `approve(address,uint256)`
- **Visibility**: external
- **Source Range**: 593:73:56

**Signature:**
```solidity
function approve(address spender, uint256 value) external returns (bool);;
```

### transferFrom(address,address,uint256)

- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 672:87:56

**Signature:**
```solidity
function transferFrom(address from, address to, uint256 value) external returns (bool);;
```
