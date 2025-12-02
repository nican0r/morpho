# Contract: Morpho

## Metadata

- **Name**: Morpho
- **Type**: Contract
- **Path**: src/Morpho.sol
- **Documentation**: @title Morpho
   @author Morpho Labs
   @custom:contact security@morpho.org
   @notice The Morpho contract.

## Implements Interfaces

- **IMorphoStaticTyping** [src/interfaces/IMorpho.sol/interface_IMorphoStaticTyping.md]
- **IMorphoBase** [src/interfaces/IMorpho.sol/interface_IMorphoBase.md]

## State Variables

### DOMAIN_SEPARATOR

```solidity
/// @inheritdoc IMorphoBase
bytes32 public immutable DOMAIN_SEPARATOR
```

### owner

```solidity
/// @inheritdoc IMorphoBase
address public owner
```

### feeRecipient

```solidity
/// @inheritdoc IMorphoBase
address public feeRecipient
```

### position

```solidity
/// @inheritdoc IMorphoStaticTyping
mapping(Id => mapping(address => Position)) public position
```

### market

```solidity
/// @inheritdoc IMorphoStaticTyping
mapping(Id => Market) public market
```

### isIrmEnabled

```solidity
/// @inheritdoc IMorphoBase
mapping(address => bool) public isIrmEnabled
```

### isLltvEnabled

```solidity
/// @inheritdoc IMorphoBase
mapping(uint256 => bool) public isLltvEnabled
```

### isAuthorized

```solidity
/// @inheritdoc IMorphoBase
mapping(address => mapping(address => bool)) public isAuthorized
```

### nonce

```solidity
/// @inheritdoc IMorphoBase
mapping(address => uint256) public nonce
```

### idToMarketParams

```solidity
/// @inheritdoc IMorphoStaticTyping
mapping(Id => MarketParams) public idToMarketParams
```

## Public/External Functions

### constructor(address)

- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 2345:270:35
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
/// @param newOwner The new owner of the contract.
constructor(address newOwner);
```

### setOwner(address)

- **Signature**: `setOwner(address)`
- **Visibility**: external
- **Source Range**: 2863:192:35
- **Details**: [function_setOwner_address.md](./function_setOwner_address.md)

**Signature:**
```solidity
/// @inheritdoc IMorphoBase
function setOwner(address newOwner) external onlyOwner();
```

### enableIrm(address)

- **Signature**: `enableIrm(address)`
- **Visibility**: external
- **Source Range**: 3093:193:35
- **Details**: [function_enableIrm_address.md](./function_enableIrm_address.md)

**Signature:**
```solidity
/// @inheritdoc IMorphoBase
function enableIrm(address irm) external onlyOwner();
```

### enableLltv(uint256)

- **Signature**: `enableLltv(uint256)`
- **Visibility**: external
- **Source Range**: 3324:259:35
- **Details**: [function_enableLltv_uint256.md](./function_enableLltv_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IMorphoBase
function enableLltv(uint256 lltv) external onlyOwner();
```

### setFee(struct MarketParams,uint256)

- **Signature**: `setFee(struct MarketParams,uint256)`
- **Visibility**: external
- **Source Range**: 3621:571:35
- **Details**: [function_setFee_struct_MarketParams_uint256.md](./function_setFee_struct_MarketParams_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IMorphoBase
function setFee(MarketParams memory marketParams, uint256 newFee) external onlyOwner();
```

### setFeeRecipient(address)

- **Signature**: `setFeeRecipient(address)`
- **Visibility**: external
- **Source Range**: 4230:248:35
- **Details**: [function_setFeeRecipient_address.md](./function_setFeeRecipient_address.md)

**Signature:**
```solidity
/// @inheritdoc IMorphoBase
function setFeeRecipient(address newFeeRecipient) external onlyOwner();
```

### createMarket(struct MarketParams)

- **Signature**: `createMarket(struct MarketParams)`
- **Visibility**: external
- **Source Range**: 4543:703:35
- **Details**: [function_createMarket_struct_MarketParams.md](./function_createMarket_struct_MarketParams.md)

**Signature:**
```solidity
/// @inheritdoc IMorphoBase
function createMarket(MarketParams memory marketParams) external;
```

### supply(struct MarketParams,uint256,uint256,address,bytes)

- **Signature**: `supply(struct MarketParams,uint256,uint256,address,bytes)`
- **Visibility**: external
- **Source Range**: 5313:1204:35
- **Details**: [function_supply_struct_MarketParams_uint256_uint256_address_bytes.md](./function_supply_struct_MarketParams_uint256_uint256_address_bytes.md)

**Signature:**
```solidity
/// @inheritdoc IMorphoBase
function supply(MarketParams memory marketParams, uint256 assets, uint256 shares, address onBehalf, bytes calldata data) external returns (uint256, uint256);
```

### withdraw(struct MarketParams,uint256,uint256,address,address)

- **Signature**: `withdraw(struct MarketParams,uint256,uint256,address,address)`
- **Visibility**: external
- **Source Range**: 6555:1388:35
- **Details**: [function_withdraw_struct_MarketParams_uint256_uint256_address_address.md](./function_withdraw_struct_MarketParams_uint256_uint256_address_address.md)

**Signature:**
```solidity
/// @inheritdoc IMorphoBase
function withdraw(MarketParams memory marketParams, uint256 assets, uint256 shares, address onBehalf, address receiver) external returns (uint256, uint256);
```

### borrow(struct MarketParams,uint256,uint256,address,address)

- **Signature**: `borrow(struct MarketParams,uint256,uint256,address,address)`
- **Visibility**: external
- **Source Range**: 8010:1488:35
- **Details**: [function_borrow_struct_MarketParams_uint256_uint256_address_address.md](./function_borrow_struct_MarketParams_uint256_uint256_address_address.md)

**Signature:**
```solidity
/// @inheritdoc IMorphoBase
function borrow(MarketParams memory marketParams, uint256 assets, uint256 shares, address onBehalf, address receiver) external returns (uint256, uint256);
```

### repay(struct MarketParams,uint256,uint256,address,bytes)

- **Signature**: `repay(struct MarketParams,uint256,uint256,address,bytes)`
- **Visibility**: external
- **Source Range**: 9536:1330:35
- **Details**: [function_repay_struct_MarketParams_uint256_uint256_address_bytes.md](./function_repay_struct_MarketParams_uint256_uint256_address_bytes.md)

**Signature:**
```solidity
/// @inheritdoc IMorphoBase
function repay(MarketParams memory marketParams, uint256 assets, uint256 shares, address onBehalf, bytes calldata data) external returns (uint256, uint256);
```

### supplyCollateral(struct MarketParams,uint256,address,bytes)

- **Signature**: `supplyCollateral(struct MarketParams,uint256,address,bytes)`
- **Visibility**: external
- **Source Range**: 10937:804:35
- **Details**: [function_supplyCollateral_struct_MarketParams_uint256_address_bytes.md](./function_supplyCollateral_struct_MarketParams_uint256_address_bytes.md)

**Signature:**
```solidity
/// @inheritdoc IMorphoBase
function supplyCollateral(MarketParams memory marketParams, uint256 assets, address onBehalf, bytes calldata data) external;
```

### withdrawCollateral(struct MarketParams,uint256,address,address)

- **Signature**: `withdrawCollateral(struct MarketParams,uint256,address,address)`
- **Visibility**: external
- **Source Range**: 11779:913:35
- **Details**: [function_withdrawCollateral_struct_MarketParams_uint256_address_address.md](./function_withdrawCollateral_struct_MarketParams_uint256_address_address.md)

**Signature:**
```solidity
/// @inheritdoc IMorphoBase
function withdrawCollateral(MarketParams memory marketParams, uint256 assets, address onBehalf, address receiver) external;
```

### liquidate(struct MarketParams,address,uint256,uint256,bytes)

- **Signature**: `liquidate(struct MarketParams,address,uint256,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 12753:3286:35
- **Details**: [function_liquidate_struct_MarketParams_address_uint256_uint256_bytes.md](./function_liquidate_struct_MarketParams_address_uint256_uint256_bytes.md)

**Signature:**
```solidity
/// @inheritdoc IMorphoBase
function liquidate(MarketParams memory marketParams, address borrower, uint256 seizedAssets, uint256 repaidShares, bytes calldata data) external returns (uint256, uint256);
```

### flashLoan(address,uint256,bytes)

- **Signature**: `flashLoan(address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 16100:414:35
- **Details**: [function_flashLoan_address_uint256_bytes.md](./function_flashLoan_address_uint256_bytes.md)

**Signature:**
```solidity
/// @inheritdoc IMorphoBase
function flashLoan(address token, uint256 assets, bytes calldata data) external;
```

### setAuthorization(address,bool)

- **Signature**: `setAuthorization(address,bool)`
- **Visibility**: external
- **Source Range**: 16577:341:35
- **Details**: [function_setAuthorization_address_bool.md](./function_setAuthorization_address_bool.md)

**Signature:**
```solidity
/// @inheritdoc IMorphoBase
function setAuthorization(address authorized, bool newIsAuthorized) external;
```

### setAuthorizationWithSig(struct Authorization,struct Signature)

- **Signature**: `setAuthorizationWithSig(struct Authorization,struct Signature)`
- **Visibility**: external
- **Source Range**: 16956:1162:35
- **Details**: [function_setAuthorizationWithSig_struct_Authorization_struct_Signature.md](./function_setAuthorizationWithSig_struct_Authorization_struct_Signature.md)

**Signature:**
```solidity
/// @inheritdoc IMorphoBase
function setAuthorizationWithSig(Authorization memory authorization, Signature calldata signature) external;
```

### accrueInterest(struct MarketParams)

- **Signature**: `accrueInterest(struct MarketParams)`
- **Visibility**: external
- **Source Range**: 18441:228:35
- **Details**: [function_accrueInterest_struct_MarketParams.md](./function_accrueInterest_struct_MarketParams.md)

**Signature:**
```solidity
/// @inheritdoc IMorphoBase
function accrueInterest(MarketParams memory marketParams) external;
```

### extSloads(bytes32[])

- **Signature**: `extSloads(bytes32[])`
- **Visibility**: external
- **Source Range**: 21687:375:35
- **Details**: [function_extSloads_bytes32[].md](./function_extSloads_bytes32[].md)

**Signature:**
```solidity
/// @inheritdoc IMorphoBase
function extSloads(bytes32[] calldata slots) external view returns (bytes32[] memory res);
```
