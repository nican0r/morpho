# Contract: CryticToFoundry

## Metadata

- **Name**: CryticToFoundry
- **Type**: Contract
- **Path**: test/recon/CryticToFoundry.sol

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

### VM_ADDRESS (inherited from CommonBase)

```solidity
address internal constant VM_ADDRESS = address(uint160(uint256(keccak256("hevm cheat code"))))
```

### CONSOLE (inherited from CommonBase)

```solidity
address internal constant CONSOLE = 0x000000000000000000636F6e736F6c652e6c6f67
```

### CREATE2_FACTORY (inherited from CommonBase)

```solidity
address internal constant CREATE2_FACTORY = 0x4e59b44847b379578588920cA78FbF26c0B4956C
```

### DEFAULT_SENDER (inherited from CommonBase)

```solidity
address internal constant DEFAULT_SENDER = address(uint160(uint256(keccak256("foundry default caller"))))
```

### DEFAULT_TEST_CONTRACT (inherited from CommonBase)

```solidity
address internal constant DEFAULT_TEST_CONTRACT = 0x5615dEB798BB3E4dFa0139dFa1b3D433Cc23b72f
```

### MULTICALL3_ADDRESS (inherited from CommonBase)

```solidity
address internal constant MULTICALL3_ADDRESS = 0xcA11bde05977b3631167028862bE2a173976CA11
```

### SECP256K1_ORDER (inherited from CommonBase)

```solidity
uint256 internal constant SECP256K1_ORDER = 115792089237316195423570985008687907852837564279074904382605163141518161494337
```

### UINT256_MAX (inherited from CommonBase)

```solidity
uint256 internal constant UINT256_MAX = 115792089237316195423570985008687907853269984665640564039457584007913129639935
```

### vm (inherited from CommonBase)

```solidity
Vm internal constant vm = Vm(VM_ADDRESS)
```

**Vm**: [lib/forge-std/src/Vm.sol/interface_Vm.md]

### stdstore (inherited from CommonBase)

```solidity
StdStorage internal stdstore
```

### IS_TEST (inherited from DSTest)

```solidity
bool public IS_TEST = true
```

### _failed (inherited from DSTest)

```solidity
bool private _failed
```

### HEVM_ADDRESS (inherited from DSTest)

```solidity
address internal constant HEVM_ADDRESS = address(bytes20(uint160(uint256(keccak256("hevm cheat code")))))
```

### vm (inherited from StdChains)

```solidity
VmSafe private constant vm = VmSafe(address(uint160(uint256(keccak256("hevm cheat code")))))
```

**VmSafe**: [lib/forge-std/src/Vm.sol/interface_VmSafe.md]

### stdChainsInitialized (inherited from StdChains)

```solidity
bool private stdChainsInitialized
```

### chains (inherited from StdChains)

```solidity
mapping(string => Chain) private chains
```

### defaultRpcUrls (inherited from StdChains)

```solidity
mapping(string => string) private defaultRpcUrls
```

### idToAlias (inherited from StdChains)

```solidity
mapping(uint256 => string) private idToAlias
```

### fallbackToDefaultRpcUrls (inherited from StdChains)

```solidity
bool private fallbackToDefaultRpcUrls = true
```

### vm (inherited from StdCheatsSafe)

```solidity
Vm private constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))))
```

**Vm**: [lib/forge-std/src/Vm.sol/interface_Vm.md]

### UINT256_MAX (inherited from StdCheatsSafe)

```solidity
uint256 private constant UINT256_MAX = 115792089237316195423570985008687907853269984665640564039457584007913129639935
```

### gasMeteringOff (inherited from StdCheatsSafe)

```solidity
bool private gasMeteringOff
```

### stdstore (inherited from StdCheats)

```solidity
StdStorage private stdstore
```

### vm (inherited from StdCheats)

```solidity
Vm private constant vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))))
```

**Vm**: [lib/forge-std/src/Vm.sol/interface_Vm.md]

### CONSOLE2_ADDRESS (inherited from StdCheats)

```solidity
address private constant CONSOLE2_ADDRESS = 0x000000000000000000636F6e736F6c652e6c6f67
```

### _excludedContracts (inherited from StdInvariant)

```solidity
address[] private _excludedContracts
```

### _excludedSenders (inherited from StdInvariant)

```solidity
address[] private _excludedSenders
```

### _targetedContracts (inherited from StdInvariant)

```solidity
address[] private _targetedContracts
```

### _targetedSenders (inherited from StdInvariant)

```solidity
address[] private _targetedSenders
```

### _excludedArtifacts (inherited from StdInvariant)

```solidity
string[] private _excludedArtifacts
```

### _targetedArtifacts (inherited from StdInvariant)

```solidity
string[] private _targetedArtifacts
```

### _targetedArtifactSelectors (inherited from StdInvariant)

```solidity
FuzzSelector[] private _targetedArtifactSelectors
```

### _targetedSelectors (inherited from StdInvariant)

```solidity
FuzzSelector[] private _targetedSelectors
```

### _targetedInterfaces (inherited from StdInvariant)

```solidity
FuzzInterface[] private _targetedInterfaces
```

### multicall (inherited from StdUtils)

```solidity
IMulticall3 private constant multicall = IMulticall3(0xcA11bde05977b3631167028862bE2a173976CA11)
```

**IMulticall3**: [lib/forge-std/src/interfaces/IMulticall3.sol/interface_IMulticall3.md]

### vm (inherited from StdUtils)

```solidity
VmSafe private constant vm = VmSafe(address(uint160(uint256(keccak256("hevm cheat code")))))
```

**VmSafe**: [lib/forge-std/src/Vm.sol/interface_VmSafe.md]

### CONSOLE2_ADDRESS (inherited from StdUtils)

```solidity
address private constant CONSOLE2_ADDRESS = 0x000000000000000000636F6e736F6c652e6c6f67
```

### INT256_MIN_ABS (inherited from StdUtils)

```solidity
uint256 private constant INT256_MIN_ABS = 57896044618658097711785492504343953926634992332820282019728792003956564819968
```

### SECP256K1_ORDER (inherited from StdUtils)

```solidity
uint256 private constant SECP256K1_ORDER = 115792089237316195423570985008687907852837564279074904382605163141518161494337
```

### UINT256_MAX (inherited from StdUtils)

```solidity
uint256 private constant UINT256_MAX = 115792089237316195423570985008687907853269984665640564039457584007913129639935
```

### CREATE2_FACTORY (inherited from StdUtils)

```solidity
address private constant CREATE2_FACTORY = 0x4e59b44847b379578588920cA78FbF26c0B4956C
```

## Structs

### Vars (inherited from BeforeAfter)

```solidity
struct Vars {
    uint256 __ignore__;
}
```

### ChainData (inherited from StdChains)

```solidity
struct ChainData {
    string name;
    uint256 chainId;
    string rpcUrl;
}
```

### Chain (inherited from StdChains)

```solidity
struct Chain {
    string name;
    uint256 chainId;
    string chainAlias;
    string rpcUrl;
}
```

### RawTx1559 (inherited from StdCheatsSafe)

```solidity
struct RawTx1559 {
    string[] arguments;
    address contractAddress;
    string contractName;
    string functionSig;
    bytes32 hash;
    RawTx1559Detail txDetail;
    string opcode;
}
```

### RawTx1559Detail (inherited from StdCheatsSafe)

```solidity
struct RawTx1559Detail {
    AccessList[] accessList;
    bytes data;
    address from;
    bytes gas;
    bytes nonce;
    address to;
    bytes txType;
    bytes value;
}
```

### Tx1559 (inherited from StdCheatsSafe)

```solidity
struct Tx1559 {
    string[] arguments;
    address contractAddress;
    string contractName;
    string functionSig;
    bytes32 hash;
    Tx1559Detail txDetail;
    string opcode;
}
```

### Tx1559Detail (inherited from StdCheatsSafe)

```solidity
struct Tx1559Detail {
    AccessList[] accessList;
    bytes data;
    address from;
    uint256 gas;
    uint256 nonce;
    address to;
    uint256 txType;
    uint256 value;
}
```

### TxLegacy (inherited from StdCheatsSafe)

```solidity
struct TxLegacy {
    string[] arguments;
    address contractAddress;
    string contractName;
    string functionSig;
    string hash;
    string opcode;
    TxDetailLegacy transaction;
}
```

### TxDetailLegacy (inherited from StdCheatsSafe)

```solidity
struct TxDetailLegacy {
    AccessList[] accessList;
    uint256 chainId;
    bytes data;
    address from;
    uint256 gas;
    uint256 gasPrice;
    bytes32 hash;
    uint256 nonce;
    bytes1 opcode;
    bytes32 r;
    bytes32 s;
    uint256 txType;
    address to;
    uint8 v;
    uint256 value;
}
```

### AccessList (inherited from StdCheatsSafe)

```solidity
struct AccessList {
    address accessAddress;
    bytes32[] storageKeys;
}
```

### RawReceipt (inherited from StdCheatsSafe)

```solidity
struct RawReceipt {
    bytes32 blockHash;
    bytes blockNumber;
    address contractAddress;
    bytes cumulativeGasUsed;
    bytes effectiveGasPrice;
    address from;
    bytes gasUsed;
    RawReceiptLog[] logs;
    bytes logsBloom;
    bytes status;
    address to;
    bytes32 transactionHash;
    bytes transactionIndex;
}
```

### Receipt (inherited from StdCheatsSafe)

```solidity
struct Receipt {
    bytes32 blockHash;
    uint256 blockNumber;
    address contractAddress;
    uint256 cumulativeGasUsed;
    uint256 effectiveGasPrice;
    address from;
    uint256 gasUsed;
    ReceiptLog[] logs;
    bytes logsBloom;
    uint256 status;
    address to;
    bytes32 transactionHash;
    uint256 transactionIndex;
}
```

### EIP1559ScriptArtifact (inherited from StdCheatsSafe)

```solidity
struct EIP1559ScriptArtifact {
    string[] libraries;
    string path;
    string[] pending;
    Receipt[] receipts;
    uint256 timestamp;
    Tx1559[] transactions;
    TxReturn[] txReturns;
}
```

### RawEIP1559ScriptArtifact (inherited from StdCheatsSafe)

```solidity
struct RawEIP1559ScriptArtifact {
    string[] libraries;
    string path;
    string[] pending;
    RawReceipt[] receipts;
    TxReturn[] txReturns;
    uint256 timestamp;
    RawTx1559[] transactions;
}
```

### RawReceiptLog (inherited from StdCheatsSafe)

```solidity
struct RawReceiptLog {
    address logAddress;
    bytes32 blockHash;
    bytes blockNumber;
    bytes data;
    bytes logIndex;
    bool removed;
    bytes32[] topics;
    bytes32 transactionHash;
    bytes transactionIndex;
    bytes transactionLogIndex;
}
```

### ReceiptLog (inherited from StdCheatsSafe)

```solidity
struct ReceiptLog {
    address logAddress;
    bytes32 blockHash;
    uint256 blockNumber;
    bytes data;
    uint256 logIndex;
    bytes32[] topics;
    uint256 transactionIndex;
    uint256 transactionLogIndex;
    bool removed;
}
```

### TxReturn (inherited from StdCheatsSafe)

```solidity
struct TxReturn {
    string internalType;
    string value;
}
```

### Account (inherited from StdCheatsSafe)

```solidity
struct Account {
    address addr;
    uint256 key;
}
```

### FuzzSelector (inherited from StdInvariant)

```solidity
struct FuzzSelector {
    address addr;
    bytes4[] selectors;
}
```

### FuzzInterface (inherited from StdInvariant)

```solidity
struct FuzzInterface {
    address addr;
    string[] artifacts;
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

### log (inherited from DSTest)

```solidity
event log(string);
```

### logs (inherited from DSTest)

```solidity
event logs(bytes);
```

### log_address (inherited from DSTest)

```solidity
event log_address(address);
```

### log_bytes32 (inherited from DSTest)

```solidity
event log_bytes32(bytes32);
```

### log_int (inherited from DSTest)

```solidity
event log_int(int);
```

### log_uint (inherited from DSTest)

```solidity
event log_uint(uint);
```

### log_bytes (inherited from DSTest)

```solidity
event log_bytes(bytes);
```

### log_string (inherited from DSTest)

```solidity
event log_string(string);
```

### log_named_address (inherited from DSTest)

```solidity
event log_named_address(string key, address val);
```

### log_named_bytes32 (inherited from DSTest)

```solidity
event log_named_bytes32(string key, bytes32 val);
```

### log_named_decimal_int (inherited from DSTest)

```solidity
event log_named_decimal_int(string key, int val, uint decimals);
```

### log_named_decimal_uint (inherited from DSTest)

```solidity
event log_named_decimal_uint(string key, uint val, uint decimals);
```

### log_named_int (inherited from DSTest)

```solidity
event log_named_int(string key, int val);
```

### log_named_uint (inherited from DSTest)

```solidity
event log_named_uint(string key, uint val);
```

### log_named_bytes (inherited from DSTest)

```solidity
event log_named_bytes(string key, bytes val);
```

### log_named_string (inherited from DSTest)

```solidity
event log_named_string(string key, string val);
```

### log_array (inherited from StdAssertions)

```solidity
event log_array(uint256[] val);
```

### log_array (inherited from StdAssertions)

```solidity
event log_array(int256[] val);
```

### log_array (inherited from StdAssertions)

```solidity
event log_array(address[] val);
```

### log_named_array (inherited from StdAssertions)

```solidity
event log_named_array(string key, uint256[] val);
```

### log_named_array (inherited from StdAssertions)

```solidity
event log_named_array(string key, int256[] val);
```

### log_named_array (inherited from StdAssertions)

```solidity
event log_named_array(string key, address[] val);
```

## Enums

### AddressType (inherited from StdCheatsSafe)

```solidity
enum AddressType {
    Payable,
    NonPayable,
    ZeroAddress,
    Precompile,
    ForgeAddress
}
```

## Public/External Functions

### setUp()

- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 618:88:60
- **Details**: [function_setUp.md](./function_setUp.md)

**Signature:**
```solidity
function setUp() public;
```

### test_crytic()

- **Signature**: `test_crytic()`
- **Visibility**: public
- **Source Range**: 760:100:60
- **Details**: [function_test_crytic.md](./function_test_crytic.md)

**Signature:**
```solidity
function test_crytic() public;
```

### failed() (inherited from DSTest)

- **Signature**: `failed()`
- **Visibility**: public
- **Source Range**: 1819:584:7
- **Details**: [function_failed.md](./function_failed.md)

**Signature:**
```solidity
function failed() public returns (bool);
```

### excludeArtifacts() (inherited from StdInvariant)

- **Signature**: `excludeArtifacts()`
- **Visibility**: public
- **Source Range**: 2157:141:13
- **Details**: [function_excludeArtifacts.md](./function_excludeArtifacts.md)

**Signature:**
```solidity
function excludeArtifacts() public view returns (string[] memory excludedArtifacts_);
```

### excludeContracts() (inherited from StdInvariant)

- **Signature**: `excludeContracts()`
- **Visibility**: public
- **Source Range**: 2304:142:13
- **Details**: [function_excludeContracts.md](./function_excludeContracts.md)

**Signature:**
```solidity
function excludeContracts() public view returns (address[] memory excludedContracts_);
```

### excludeSenders() (inherited from StdInvariant)

- **Signature**: `excludeSenders()`
- **Visibility**: public
- **Source Range**: 2452:134:13
- **Details**: [function_excludeSenders.md](./function_excludeSenders.md)

**Signature:**
```solidity
function excludeSenders() public view returns (address[] memory excludedSenders_);
```

### targetArtifacts() (inherited from StdInvariant)

- **Signature**: `targetArtifacts()`
- **Visibility**: public
- **Source Range**: 2592:140:13
- **Details**: [function_targetArtifacts.md](./function_targetArtifacts.md)

**Signature:**
```solidity
function targetArtifacts() public view returns (string[] memory targetedArtifacts_);
```

### targetArtifactSelectors() (inherited from StdInvariant)

- **Signature**: `targetArtifactSelectors()`
- **Visibility**: public
- **Source Range**: 2738:178:13
- **Details**: [function_targetArtifactSelectors.md](./function_targetArtifactSelectors.md)

**Signature:**
```solidity
function targetArtifactSelectors() public view returns (FuzzSelector[] memory targetedArtifactSelectors_);
```

### targetContracts() (inherited from StdInvariant)

- **Signature**: `targetContracts()`
- **Visibility**: public
- **Source Range**: 2922:141:13
- **Details**: [function_targetContracts.md](./function_targetContracts.md)

**Signature:**
```solidity
function targetContracts() public view returns (address[] memory targetedContracts_);
```

### targetSelectors() (inherited from StdInvariant)

- **Signature**: `targetSelectors()`
- **Visibility**: public
- **Source Range**: 3069:146:13
- **Details**: [function_targetSelectors.md](./function_targetSelectors.md)

**Signature:**
```solidity
function targetSelectors() public view returns (FuzzSelector[] memory targetedSelectors_);
```

### targetSenders() (inherited from StdInvariant)

- **Signature**: `targetSenders()`
- **Visibility**: public
- **Source Range**: 3221:133:13
- **Details**: [function_targetSenders.md](./function_targetSenders.md)

**Signature:**
```solidity
function targetSenders() public view returns (address[] memory targetedSenders_);
```

### targetInterfaces() (inherited from StdInvariant)

- **Signature**: `targetInterfaces()`
- **Visibility**: public
- **Source Range**: 3360:151:13
- **Details**: [function_targetInterfaces.md](./function_targetInterfaces.md)

**Signature:**
```solidity
function targetInterfaces() public view returns (FuzzInterface[] memory targetedInterfaces_);
```

### morpho_enableIrm(address) (inherited from AdminTargets)

- **Signature**: `morpho_enableIrm(address)`
- **Visibility**: public
- **Source Range**: 618:92:64
- **Details**: [function_morpho_enableIrm_address.md](./function_morpho_enableIrm_address.md)

**Signature:**
```solidity
/// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///
function morpho_enableIrm(address irm) public asAdmin();
```

### morpho_enableLltv(uint256) (inherited from AdminTargets)

- **Signature**: `morpho_enableLltv(uint256)`
- **Visibility**: public
- **Source Range**: 716:96:64
- **Details**: [function_morpho_enableLltv_uint256.md](./function_morpho_enableLltv_uint256.md)

**Signature:**
```solidity
function morpho_enableLltv(uint256 lltv) public asAdmin();
```

### morpho_setFee(struct MarketParams,uint256) (inherited from AdminTargets)

- **Signature**: `morpho_setFee(struct MarketParams,uint256)`
- **Visibility**: public
- **Source Range**: 818:140:64
- **Details**: [function_morpho_setFee_struct_MarketParams_uint256.md](./function_morpho_setFee_struct_MarketParams_uint256.md)

**Signature:**
```solidity
function morpho_setFee(MarketParams memory marketParams, uint256 newFee) public asAdmin();
```

### morpho_setFeeRecipient(address) (inherited from AdminTargets)

- **Signature**: `morpho_setFeeRecipient(address)`
- **Visibility**: public
- **Source Range**: 964:128:64
- **Details**: [function_morpho_setFeeRecipient_address.md](./function_morpho_setFeeRecipient_address.md)

**Signature:**
```solidity
function morpho_setFeeRecipient(address newFeeRecipient) public asAdmin();
```

### morpho_setOwner(address) (inherited from AdminTargets)

- **Signature**: `morpho_setOwner(address)`
- **Visibility**: public
- **Source Range**: 1098:100:64
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
- **Source Range**: 646:132:67
- **Details**: [function_morpho_accrueInterest_struct_MarketParams.md](./function_morpho_accrueInterest_struct_MarketParams.md)

**Signature:**
```solidity
/// AUTO GENERATED TARGET FUNCTIONS - WARNING: DO NOT DELETE OR MODIFY THIS LINE ///
function morpho_accrueInterest(MarketParams memory marketParams) public asActor();
```

### morpho_borrow(struct MarketParams,uint256,uint256,address,address) (inherited from MorphoTargets)

- **Signature**: `morpho_borrow(struct MarketParams,uint256,uint256,address,address)`
- **Visibility**: public
- **Source Range**: 784:266:67
- **Details**: [function_morpho_borrow_struct_MarketParams_uint256_uint256_address_address.md](./function_morpho_borrow_struct_MarketParams_uint256_uint256_address_address.md)

**Signature:**
```solidity
function morpho_borrow(MarketParams memory marketParams, uint256 assets, uint256 shares, address onBehalf, address receiver) public asActor();
```

### morpho_createMarket(struct MarketParams) (inherited from MorphoTargets)

- **Signature**: `morpho_createMarket(struct MarketParams)`
- **Visibility**: public
- **Source Range**: 1056:128:67
- **Details**: [function_morpho_createMarket_struct_MarketParams.md](./function_morpho_createMarket_struct_MarketParams.md)

**Signature:**
```solidity
function morpho_createMarket(MarketParams memory marketParams) public asActor();
```

### morpho_flashLoan(address,uint256,bytes) (inherited from MorphoTargets)

- **Signature**: `morpho_flashLoan(address,uint256,bytes)`
- **Visibility**: public
- **Source Range**: 1190:145:67
- **Details**: [function_morpho_flashLoan_address_uint256_bytes.md](./function_morpho_flashLoan_address_uint256_bytes.md)

**Signature:**
```solidity
function morpho_flashLoan(address token, uint256 assets, bytes memory data) public asActor();
```

### morpho_liquidate(struct MarketParams,address,uint256,uint256,bytes) (inherited from MorphoTargets)

- **Signature**: `morpho_liquidate(struct MarketParams,address,uint256,uint256,bytes)`
- **Visibility**: public
- **Source Range**: 1341:293:67
- **Details**: [function_morpho_liquidate_struct_MarketParams_address_uint256_uint256_bytes.md](./function_morpho_liquidate_struct_MarketParams_address_uint256_uint256_bytes.md)

**Signature:**
```solidity
function morpho_liquidate(MarketParams memory marketParams, address borrower, uint256 seizedAssets, uint256 repaidShares, bytes memory data) public asActor();
```

### morpho_repay(struct MarketParams,uint256,uint256,address,bytes) (inherited from MorphoTargets)

- **Signature**: `morpho_repay(struct MarketParams,uint256,uint256,address,bytes)`
- **Visibility**: public
- **Source Range**: 1640:261:67
- **Details**: [function_morpho_repay_struct_MarketParams_uint256_uint256_address_bytes.md](./function_morpho_repay_struct_MarketParams_uint256_uint256_address_bytes.md)

**Signature:**
```solidity
function morpho_repay(MarketParams memory marketParams, uint256 assets, uint256 shares, address onBehalf, bytes memory data) public asActor();
```

### morpho_setAuthorization(address,bool) (inherited from MorphoTargets)

- **Signature**: `morpho_setAuthorization(address,bool)`
- **Visibility**: public
- **Source Range**: 1907:159:67
- **Details**: [function_morpho_setAuthorization_address_bool.md](./function_morpho_setAuthorization_address_bool.md)

**Signature:**
```solidity
function morpho_setAuthorization(address authorized, bool newIsAuthorized) public asActor();
```

### morpho_setAuthorizationWithSig(struct Authorization,struct Signature) (inherited from MorphoTargets)

- **Signature**: `morpho_setAuthorizationWithSig(struct Authorization,struct Signature)`
- **Visibility**: public
- **Source Range**: 2072:214:67
- **Details**: [function_morpho_setAuthorizationWithSig_struct_Authorization_struct_Signature.md](./function_morpho_setAuthorizationWithSig_struct_Authorization_struct_Signature.md)

**Signature:**
```solidity
function morpho_setAuthorizationWithSig(Authorization memory authorization, Signature memory signature) public asActor();
```

### morpho_supply(struct MarketParams,uint256,uint256,address,bytes) (inherited from MorphoTargets)

- **Signature**: `morpho_supply(struct MarketParams,uint256,uint256,address,bytes)`
- **Visibility**: public
- **Source Range**: 2292:263:67
- **Details**: [function_morpho_supply_struct_MarketParams_uint256_uint256_address_bytes.md](./function_morpho_supply_struct_MarketParams_uint256_uint256_address_bytes.md)

**Signature:**
```solidity
function morpho_supply(MarketParams memory marketParams, uint256 assets, uint256 shares, address onBehalf, bytes memory data) public asActor();
```

### morpho_supplyCollateral(struct MarketParams,uint256,address,bytes) (inherited from MorphoTargets)

- **Signature**: `morpho_supplyCollateral(struct MarketParams,uint256,address,bytes)`
- **Visibility**: public
- **Source Range**: 2561:251:67
- **Details**: [function_morpho_supplyCollateral_struct_MarketParams_uint256_address_bytes.md](./function_morpho_supplyCollateral_struct_MarketParams_uint256_address_bytes.md)

**Signature:**
```solidity
function morpho_supplyCollateral(MarketParams memory marketParams, uint256 assets, address onBehalf, bytes memory data) public asActor();
```

### morpho_withdraw(struct MarketParams,uint256,uint256,address,address) (inherited from MorphoTargets)

- **Signature**: `morpho_withdraw(struct MarketParams,uint256,uint256,address,address)`
- **Visibility**: public
- **Source Range**: 2818:270:67
- **Details**: [function_morpho_withdraw_struct_MarketParams_uint256_uint256_address_address.md](./function_morpho_withdraw_struct_MarketParams_uint256_uint256_address_address.md)

**Signature:**
```solidity
function morpho_withdraw(MarketParams memory marketParams, uint256 assets, uint256 shares, address onBehalf, address receiver) public asActor();
```

### morpho_withdrawCollateral(struct MarketParams,uint256,address,address) (inherited from MorphoTargets)

- **Signature**: `morpho_withdrawCollateral(struct MarketParams,uint256,address,address)`
- **Visibility**: public
- **Source Range**: 3094:258:67
- **Details**: [function_morpho_withdrawCollateral_struct_MarketParams_uint256_address_address.md](./function_morpho_withdrawCollateral_struct_MarketParams_uint256_address_address.md)

**Signature:**
```solidity
function morpho_withdrawCollateral(MarketParams memory marketParams, uint256 assets, address onBehalf, address receiver) public asActor();
```
