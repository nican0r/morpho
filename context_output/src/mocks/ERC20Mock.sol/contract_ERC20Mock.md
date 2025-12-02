# Contract: ERC20Mock

## Metadata

- **Name**: ERC20Mock
- **Type**: Contract
- **Path**: src/mocks/ERC20Mock.sol

## Implements Interfaces

- **IERC20** [src/mocks/interfaces/IERC20.sol/interface_IERC20.md]

## State Variables

### totalSupply

```solidity
uint256 public totalSupply
```

### balanceOf

```solidity
mapping(address => uint256) public balanceOf
```

### allowance

```solidity
mapping(address => mapping(address => uint256)) public allowance
```

## Events

### Transfer (inherited from IERC20)

```solidity
event Transfer(address indexed from, address indexed to, uint256 value);
```

### Approval (inherited from IERC20)

```solidity
event Approval(address indexed owner, address indexed spender, uint256 value);
```

## Public/External Functions

### setBalance(address,uint256)

- **Signature**: `setBalance(address,uint256)`
- **Visibility**: public
- **Source Range**: 332:255:52
- **Details**: [function_setBalance_address_uint256.md](./function_setBalance_address_uint256.md)

**Signature:**
```solidity
function setBalance(address account, uint256 amount) virtual public;
```

### approve(address,uint256)

- **Signature**: `approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 593:211:52
- **Details**: [function_approve_address_uint256.md](./function_approve_address_uint256.md)

**Signature:**
```solidity
function approve(address spender, uint256 amount) virtual public returns (bool);
```

### transfer(address,uint256)

- **Signature**: `transfer(address,uint256)`
- **Visibility**: public
- **Source Range**: 810:302:52
- **Details**: [function_transfer_address_uint256.md](./function_transfer_address_uint256.md)

**Signature:**
```solidity
function transfer(address to, uint256 amount) virtual public returns (bool);
```

### transferFrom(address,address,uint256)

- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 1118:433:52
- **Details**: [function_transferFrom_address_address_uint256.md](./function_transferFrom_address_address_uint256.md)

**Signature:**
```solidity
function transferFrom(address from, address to, uint256 amount) virtual public returns (bool);
```
