# Contract: CryticTester

## Metadata

- **Name**: CryticTester
- **Type**: Contract
- **Path**: test/recon/CryticTester.sol

## State Variables

### _actor (inherited from ActorManager)

```solidity
/// @notice The current actor being used
address private _actor
```

### _actors (inherited from ActorManager)

```solidity
/// @notice The list of all actors being used
EnumerableSet.AddressSet private _actors
```

### __asset (inherited from AssetManager)

```solidity
/// @notice The current target for this set of variables
address private __asset
```

### _assets (inherited from AssetManager)

```solidity
/// @notice The list of all assets being used
EnumerableSet.AddressSet private _assets
```

### DECIMALS (inherited from Setup)

```solidity
uint256 internal constant DECIMALS = 18
```

### morpho (inherited from Setup)

```solidity
Morpho internal morpho
```

**Morpho**: [src/Morpho.sol/contract_Morpho.md]

### loanToken (inherited from Setup)

```solidity
ERC20Mock internal loanToken
```

**ERC20Mock**: [src/mocks/ERC20Mock.sol/contract_ERC20Mock.md]

### collateralToken (inherited from Setup)

```solidity
ERC20Mock internal collateralToken
```

**ERC20Mock**: [src/mocks/ERC20Mock.sol/contract_ERC20Mock.md]

### oracle (inherited from Setup)

```solidity
OracleMock internal oracle
```

**OracleMock**: [src/mocks/OracleMock.sol/contract_OracleMock.md]

### irm (inherited from Setup)

```solidity
IrmMock internal irm
```

**IrmMock**: [src/mocks/IrmMock.sol/contract_IrmMock.md]

### defaultMarketParams (inherited from Setup)

```solidity
MarketParams internal defaultMarketParams
```

### defaultMarketId (inherited from Setup)

```solidity
Id internal defaultMarketId
```

### _before (inherited from BeforeAfter)

```solidity
Vars internal _before
```

### _after (inherited from BeforeAfter)

```solidity
Vars internal _after
```

## Structs

### Vars (inherited from BeforeAfter)

```solidity
struct Vars {
    uint256 __ignore__;
}
```

## Errors

### ActorNotSetup (inherited from ActorManager)

```solidity
error ActorNotSetup();
```

### ActorExists (inherited from ActorManager)

```solidity
error ActorExists();
```

### ActorNotAdded (inherited from ActorManager)

```solidity
error ActorNotAdded();
```

### DefaultActor (inherited from ActorManager)

```solidity
error DefaultActor();
```

### NotSetup (inherited from AssetManager)

```solidity
error NotSetup();
```

### Exists (inherited from AssetManager)

```solidity
error Exists();
```

### NotAdded (inherited from AssetManager)

```solidity
error NotAdded();
```

## Events

### Log (inherited from CryticAsserts)

```solidity
event Log(string);
```

## Public/External Functions

### constructor()

- **Signature**: `constructor()`
- **Visibility**: public
- **Source Range**: 360:46:59
- **Details**: [function_constructor.md](./function_constructor.md)

**Signature:**
```solidity
constructor() payable;
```

### morpho_enableIrm(address) (inherited from AdminTargets)

- **Signature**: `morpho_enableIrm(address)`
- **Visibility**: public
- **Source Range**: 570:92:64
- **Details**: [function_morpho_enableIrm_address.md](./function_morpho_enableIrm_address.md)

**Signature:**
```solidity
/// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///
function morpho_enableIrm(address irm) public asAdmin();
```

### morpho_enableLltv(uint256) (inherited from AdminTargets)

- **Signature**: `morpho_enableLltv(uint256)`
- **Visibility**: public
- **Source Range**: 668:96:64
- **Details**: [function_morpho_enableLltv_uint256.md](./function_morpho_enableLltv_uint256.md)

**Signature:**
```solidity
function morpho_enableLltv(uint256 lltv) public asAdmin();
```

### morpho_setFee(struct MarketParams,uint256) (inherited from AdminTargets)

- **Signature**: `morpho_setFee(struct MarketParams,uint256)`
- **Visibility**: public
- **Source Range**: 770:140:64
- **Details**: [function_morpho_setFee_struct_MarketParams_uint256.md](./function_morpho_setFee_struct_MarketParams_uint256.md)

**Signature:**
```solidity
function morpho_setFee(MarketParams memory marketParams, uint256 newFee) public asAdmin();
```

### morpho_setFeeRecipient(address) (inherited from AdminTargets)

- **Signature**: `morpho_setFeeRecipient(address)`
- **Visibility**: public
- **Source Range**: 916:128:64
- **Details**: [function_morpho_setFeeRecipient_address.md](./function_morpho_setFeeRecipient_address.md)

**Signature:**
```solidity
function morpho_setFeeRecipient(address newFeeRecipient) public asAdmin();
```

### morpho_setOwner(address) (inherited from AdminTargets)

- **Signature**: `morpho_setOwner(address)`
- **Visibility**: public
- **Source Range**: 1050:100:64
- **Details**: [function_morpho_setOwner_address.md](./function_morpho_setOwner_address.md)

**Signature:**
```solidity
function morpho_setOwner(address newOwner) public asAdmin();
```

### switchActor(uint256) (inherited from ManagersTargets)

- **Signature**: `switchActor(uint256)`
- **Visibility**: public
- **Source Range**: 680:83:66
- **Details**: [function_switchActor_uint256.md](./function_switchActor_uint256.md)

**Signature:**
```solidity
/// @dev Start acting as another actor
function switchActor(uint256 entropy) public;
```

### switch_asset(uint256) (inherited from ManagersTargets)

- **Signature**: `switch_asset(uint256)`
- **Visibility**: public
- **Source Range**: 808:84:66
- **Details**: [function_switch_asset_uint256.md](./function_switch_asset_uint256.md)

**Signature:**
```solidity
/// @dev Starts using a new asset
function switch_asset(uint256 entropy) public;
```

### add_new_asset(uint8) (inherited from ManagersTargets)

- **Signature**: `add_new_asset(uint8)`
- **Visibility**: public
- **Source Range**: 997:144:66
- **Details**: [function_add_new_asset_uint8.md](./function_add_new_asset_uint8.md)

**Signature:**
```solidity
/// @dev Deploy a new token and add it to the list of assets, then set it as the current asset
function add_new_asset(uint8 decimals) public returns (address);
```

### asset_approve(address,uint128) (inherited from ManagersTargets)

- **Signature**: `asset_approve(address,uint128)`
- **Visibility**: public
- **Source Range**: 1467:132:66
- **Details**: [function_asset_approve_address_uint128.md](./function_asset_approve_address_uint128.md)

**Signature:**
```solidity
/// @dev Approve to arbitrary address, uses Actor by default
///  NOTE: You're almost always better off setting approvals in `Setup`
function asset_approve(address to, uint128 amt) public updateGhosts() asActor();
```

### asset_mint(address,uint128) (inherited from ManagersTargets)

- **Signature**: `asset_mint(address,uint128)`
- **Visibility**: public
- **Source Range**: 1704:126:66
- **Details**: [function_asset_mint_address_uint128.md](./function_asset_mint_address_uint128.md)

**Signature:**
```solidity
/// @dev Mint to arbitrary address, uses owner by default, even though MockERC20 doesn't check
function asset_mint(address to, uint128 amt) public updateGhosts() asAdmin();
```

### morpho_accrueInterest(struct MarketParams) (inherited from MorphoTargets)

- **Signature**: `morpho_accrueInterest(struct MarketParams)`
- **Visibility**: public
- **Source Range**: 595:132:67
- **Details**: [function_morpho_accrueInterest_struct_MarketParams.md](./function_morpho_accrueInterest_struct_MarketParams.md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function morpho_accrueInterest(MarketParams memory marketParams) public asActor();
```

### morpho_borrow(struct MarketParams,uint256,uint256,address,address) (inherited from MorphoTargets)

- **Signature**: `morpho_borrow(struct MarketParams,uint256,uint256,address,address)`
- **Visibility**: public
- **Source Range**: 733:266:67
- **Details**: [function_morpho_borrow_struct_MarketParams_uint256_uint256_address_address.md](./function_morpho_borrow_struct_MarketParams_uint256_uint256_address_address.md)

**Signature:**
```solidity
function morpho_borrow(MarketParams memory marketParams, uint256 assets, uint256 shares, address onBehalf, address receiver) public asActor();
```

### morpho_createMarket(struct MarketParams) (inherited from MorphoTargets)

- **Signature**: `morpho_createMarket(struct MarketParams)`
- **Visibility**: public
- **Source Range**: 1005:128:67
- **Details**: [function_morpho_createMarket_struct_MarketParams.md](./function_morpho_createMarket_struct_MarketParams.md)

**Signature:**
```solidity
function morpho_createMarket(MarketParams memory marketParams) public asActor();
```

### morpho_flashLoan(address,uint256,bytes) (inherited from MorphoTargets)

- **Signature**: `morpho_flashLoan(address,uint256,bytes)`
- **Visibility**: public
- **Source Range**: 1139:145:67
- **Details**: [function_morpho_flashLoan_address_uint256_bytes.md](./function_morpho_flashLoan_address_uint256_bytes.md)

**Signature:**
```solidity
function morpho_flashLoan(address token, uint256 assets, bytes memory data) public asActor();
```

### morpho_liquidate(struct MarketParams,address,uint256,uint256,bytes) (inherited from MorphoTargets)

- **Signature**: `morpho_liquidate(struct MarketParams,address,uint256,uint256,bytes)`
- **Visibility**: public
- **Source Range**: 1290:293:67
- **Details**: [function_morpho_liquidate_struct_MarketParams_address_uint256_uint256_bytes.md](./function_morpho_liquidate_struct_MarketParams_address_uint256_uint256_bytes.md)

**Signature:**
```solidity
function morpho_liquidate(MarketParams memory marketParams, address borrower, uint256 seizedAssets, uint256 repaidShares, bytes memory data) public asActor();
```

### morpho_repay(struct MarketParams,uint256,uint256,address,bytes) (inherited from MorphoTargets)

- **Signature**: `morpho_repay(struct MarketParams,uint256,uint256,address,bytes)`
- **Visibility**: public
- **Source Range**: 1589:261:67
- **Details**: [function_morpho_repay_struct_MarketParams_uint256_uint256_address_bytes.md](./function_morpho_repay_struct_MarketParams_uint256_uint256_address_bytes.md)

**Signature:**
```solidity
function morpho_repay(MarketParams memory marketParams, uint256 assets, uint256 shares, address onBehalf, bytes memory data) public asActor();
```

### morpho_setAuthorization(address,bool) (inherited from MorphoTargets)

- **Signature**: `morpho_setAuthorization(address,bool)`
- **Visibility**: public
- **Source Range**: 1856:159:67
- **Details**: [function_morpho_setAuthorization_address_bool.md](./function_morpho_setAuthorization_address_bool.md)

**Signature:**
```solidity
function morpho_setAuthorization(address authorized, bool newIsAuthorized) public asActor();
```

### morpho_setAuthorizationWithSig(struct Authorization,struct Signature) (inherited from MorphoTargets)

- **Signature**: `morpho_setAuthorizationWithSig(struct Authorization,struct Signature)`
- **Visibility**: public
- **Source Range**: 2021:214:67
- **Details**: [function_morpho_setAuthorizationWithSig_struct_Authorization_struct_Signature.md](./function_morpho_setAuthorizationWithSig_struct_Authorization_struct_Signature.md)

**Signature:**
```solidity
function morpho_setAuthorizationWithSig(Authorization memory authorization, Signature memory signature) public asActor();
```

### morpho_supply(struct MarketParams,uint256,uint256,address,bytes) (inherited from MorphoTargets)

- **Signature**: `morpho_supply(struct MarketParams,uint256,uint256,address,bytes)`
- **Visibility**: public
- **Source Range**: 2241:263:67
- **Details**: [function_morpho_supply_struct_MarketParams_uint256_uint256_address_bytes.md](./function_morpho_supply_struct_MarketParams_uint256_uint256_address_bytes.md)

**Signature:**
```solidity
function morpho_supply(MarketParams memory marketParams, uint256 assets, uint256 shares, address onBehalf, bytes memory data) public asActor();
```

### morpho_supplyCollateral(struct MarketParams,uint256,address,bytes) (inherited from MorphoTargets)

- **Signature**: `morpho_supplyCollateral(struct MarketParams,uint256,address,bytes)`
- **Visibility**: public
- **Source Range**: 2510:251:67
- **Details**: [function_morpho_supplyCollateral_struct_MarketParams_uint256_address_bytes.md](./function_morpho_supplyCollateral_struct_MarketParams_uint256_address_bytes.md)

**Signature:**
```solidity
function morpho_supplyCollateral(MarketParams memory marketParams, uint256 assets, address onBehalf, bytes memory data) public asActor();
```

### morpho_withdraw(struct MarketParams,uint256,uint256,address,address) (inherited from MorphoTargets)

- **Signature**: `morpho_withdraw(struct MarketParams,uint256,uint256,address,address)`
- **Visibility**: public
- **Source Range**: 2767:270:67
- **Details**: [function_morpho_withdraw_struct_MarketParams_uint256_uint256_address_address.md](./function_morpho_withdraw_struct_MarketParams_uint256_uint256_address_address.md)

**Signature:**
```solidity
function morpho_withdraw(MarketParams memory marketParams, uint256 assets, uint256 shares, address onBehalf, address receiver) public asActor();
```

### morpho_withdrawCollateral(struct MarketParams,uint256,address,address) (inherited from MorphoTargets)

- **Signature**: `morpho_withdrawCollateral(struct MarketParams,uint256,address,address)`
- **Visibility**: public
- **Source Range**: 3043:258:67
- **Details**: [function_morpho_withdrawCollateral_struct_MarketParams_uint256_address_address.md](./function_morpho_withdrawCollateral_struct_MarketParams_uint256_address_address.md)

**Signature:**
```solidity
function morpho_withdrawCollateral(MarketParams memory marketParams, uint256 assets, address onBehalf, address receiver) public asActor();
```
