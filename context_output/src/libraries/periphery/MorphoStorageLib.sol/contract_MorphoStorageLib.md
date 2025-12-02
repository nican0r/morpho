# Contract: MorphoStorageLib

## Metadata

- **Name**: MorphoStorageLib
- **Type**: Contract
- **Path**: src/libraries/periphery/MorphoStorageLib.sol
- **Documentation**: @title MorphoStorageLib
   @author Morpho Labs
   @custom:contact security@morpho.org
   @notice Helper library exposing getters to access Morpho storage variables' slot.
   @dev This library is not used in Morpho itself and is intended to be used by integrators.

## State Variables

### OWNER_SLOT

```solidity
uint256 internal constant OWNER_SLOT = 0
```

### FEE_RECIPIENT_SLOT

```solidity
uint256 internal constant FEE_RECIPIENT_SLOT = 1
```

### POSITION_SLOT

```solidity
uint256 internal constant POSITION_SLOT = 2
```

### MARKET_SLOT

```solidity
uint256 internal constant MARKET_SLOT = 3
```

### IS_IRM_ENABLED_SLOT

```solidity
uint256 internal constant IS_IRM_ENABLED_SLOT = 4
```

### IS_LLTV_ENABLED_SLOT

```solidity
uint256 internal constant IS_LLTV_ENABLED_SLOT = 5
```

### IS_AUTHORIZED_SLOT

```solidity
uint256 internal constant IS_AUTHORIZED_SLOT = 6
```

### NONCE_SLOT

```solidity
uint256 internal constant NONCE_SLOT = 7
```

### ID_TO_MARKET_PARAMS_SLOT

```solidity
uint256 internal constant ID_TO_MARKET_PARAMS_SLOT = 8
```

### LOAN_TOKEN_OFFSET

```solidity
uint256 internal constant LOAN_TOKEN_OFFSET = 0
```

### COLLATERAL_TOKEN_OFFSET

```solidity
uint256 internal constant COLLATERAL_TOKEN_OFFSET = 1
```

### ORACLE_OFFSET

```solidity
uint256 internal constant ORACLE_OFFSET = 2
```

### IRM_OFFSET

```solidity
uint256 internal constant IRM_OFFSET = 3
```

### LLTV_OFFSET

```solidity
uint256 internal constant LLTV_OFFSET = 4
```

### SUPPLY_SHARES_OFFSET

```solidity
uint256 internal constant SUPPLY_SHARES_OFFSET = 0
```

### BORROW_SHARES_AND_COLLATERAL_OFFSET

```solidity
uint256 internal constant BORROW_SHARES_AND_COLLATERAL_OFFSET = 1
```

### TOTAL_SUPPLY_ASSETS_AND_SHARES_OFFSET

```solidity
uint256 internal constant TOTAL_SUPPLY_ASSETS_AND_SHARES_OFFSET = 0
```

### TOTAL_BORROW_ASSETS_AND_SHARES_OFFSET

```solidity
uint256 internal constant TOTAL_BORROW_ASSETS_AND_SHARES_OFFSET = 1
```

### LAST_UPDATE_AND_FEE_OFFSET

```solidity
uint256 internal constant LAST_UPDATE_AND_FEE_OFFSET = 2
```
