# Contract: FlashBorrowerMock

## Metadata

- **Name**: FlashBorrowerMock
- **Type**: Contract
- **Path**: src/mocks/FlashBorrowerMock.sol

## Implements Interfaces

- **IMorphoFlashLoanCallback** [src/interfaces/IMorphoCallbacks.sol/interface_IMorphoFlashLoanCallback.md]

## State Variables

### MORPHO

```solidity
IMorpho private immutable MORPHO
```

**IMorpho**: [src/interfaces/IMorpho.sol/interface_IMorpho.md]

## Public/External Functions

### constructor(contract IMorpho)

- **Signature**: `constructor(contract IMorpho)`
- **Visibility**: public
- **Source Range**: 347:66:53
- **Details**: [function_constructor_contract_IMorpho.md](./function_constructor_contract_IMorpho.md)

**Signature:**
```solidity
constructor(IMorpho newMorpho);
```

### flashLoan(address,uint256,bytes)

- **Signature**: `flashLoan(address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 419:134:53
- **Details**: [function_flashLoan_address_uint256_bytes.md](./function_flashLoan_address_uint256_bytes.md)

**Signature:**
```solidity
function flashLoan(address token, uint256 assets, bytes calldata data) external;
```

### onMorphoFlashLoan(uint256,bytes)

- **Signature**: `onMorphoFlashLoan(uint256,bytes)`
- **Visibility**: external
- **Source Range**: 559:237:53
- **Details**: [function_onMorphoFlashLoan_uint256_bytes.md](./function_onMorphoFlashLoan_uint256_bytes.md)

**Signature:**
```solidity
function onMorphoFlashLoan(uint256 assets, bytes calldata data) external;
```
