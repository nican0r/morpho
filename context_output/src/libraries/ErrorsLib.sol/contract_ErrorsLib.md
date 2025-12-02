# Contract: ErrorsLib

## Metadata

- **Name**: ErrorsLib
- **Type**: Contract
- **Path**: src/libraries/ErrorsLib.sol
- **Documentation**: @title ErrorsLib
   @author Morpho Labs
   @custom:contact security@morpho.org
   @notice Library exposing error messages.

## State Variables

### NOT_OWNER

```solidity
/// @notice Thrown when the caller is not the owner.
string internal constant NOT_OWNER = "not owner"
```

### MAX_LLTV_EXCEEDED

```solidity
/// @notice Thrown when the LLTV to enable exceeds the maximum LLTV.
string internal constant MAX_LLTV_EXCEEDED = "max LLTV exceeded"
```

### MAX_FEE_EXCEEDED

```solidity
/// @notice Thrown when the fee to set exceeds the maximum fee.
string internal constant MAX_FEE_EXCEEDED = "max fee exceeded"
```

### ALREADY_SET

```solidity
/// @notice Thrown when the value is already set.
string internal constant ALREADY_SET = "already set"
```

### IRM_NOT_ENABLED

```solidity
/// @notice Thrown when the IRM is not enabled at market creation.
string internal constant IRM_NOT_ENABLED = "IRM not enabled"
```

### LLTV_NOT_ENABLED

```solidity
/// @notice Thrown when the LLTV is not enabled at market creation.
string internal constant LLTV_NOT_ENABLED = "LLTV not enabled"
```

### MARKET_ALREADY_CREATED

```solidity
/// @notice Thrown when the market is already created.
string internal constant MARKET_ALREADY_CREATED = "market already created"
```

### NO_CODE

```solidity
/// @notice Thrown when a token to transfer doesn't have code.
string internal constant NO_CODE = "no code"
```

### MARKET_NOT_CREATED

```solidity
/// @notice Thrown when the market is not created.
string internal constant MARKET_NOT_CREATED = "market not created"
```

### INCONSISTENT_INPUT

```solidity
/// @notice Thrown when not exactly one of the input amount is zero.
string internal constant INCONSISTENT_INPUT = "inconsistent input"
```

### ZERO_ASSETS

```solidity
/// @notice Thrown when zero assets is passed as input.
string internal constant ZERO_ASSETS = "zero assets"
```

### ZERO_ADDRESS

```solidity
/// @notice Thrown when a zero address is passed as input.
string internal constant ZERO_ADDRESS = "zero address"
```

### UNAUTHORIZED

```solidity
/// @notice Thrown when the caller is not authorized to conduct an action.
string internal constant UNAUTHORIZED = "unauthorized"
```

### INSUFFICIENT_COLLATERAL

```solidity
/// @notice Thrown when the collateral is insufficient to `borrow` or `withdrawCollateral`.
string internal constant INSUFFICIENT_COLLATERAL = "insufficient collateral"
```

### INSUFFICIENT_LIQUIDITY

```solidity
/// @notice Thrown when the liquidity is insufficient to `withdraw` or `borrow`.
string internal constant INSUFFICIENT_LIQUIDITY = "insufficient liquidity"
```

### HEALTHY_POSITION

```solidity
/// @notice Thrown when the position to liquidate is healthy.
string internal constant HEALTHY_POSITION = "position is healthy"
```

### INVALID_SIGNATURE

```solidity
/// @notice Thrown when the authorization signature is invalid.
string internal constant INVALID_SIGNATURE = "invalid signature"
```

### SIGNATURE_EXPIRED

```solidity
/// @notice Thrown when the authorization signature is expired.
string internal constant SIGNATURE_EXPIRED = "signature expired"
```

### INVALID_NONCE

```solidity
/// @notice Thrown when the nonce is invalid.
string internal constant INVALID_NONCE = "invalid nonce"
```

### TRANSFER_REVERTED

```solidity
/// @notice Thrown when a token transfer reverted.
string internal constant TRANSFER_REVERTED = "transfer reverted"
```

### TRANSFER_RETURNED_FALSE

```solidity
/// @notice Thrown when a token transfer returned false.
string internal constant TRANSFER_RETURNED_FALSE = "transfer returned false"
```

### TRANSFER_FROM_REVERTED

```solidity
/// @notice Thrown when a token transferFrom reverted.
string internal constant TRANSFER_FROM_REVERTED = "transferFrom reverted"
```

### TRANSFER_FROM_RETURNED_FALSE

```solidity
/// @notice Thrown when a token transferFrom returned false
string internal constant TRANSFER_FROM_RETURNED_FALSE = "transferFrom returned false"
```

### MAX_UINT128_EXCEEDED

```solidity
/// @notice Thrown when the maximum uint128 is exceeded.
string internal constant MAX_UINT128_EXCEEDED = "max uint128 exceeded"
```
