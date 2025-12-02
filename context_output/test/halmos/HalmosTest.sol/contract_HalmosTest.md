# Contract: HalmosTest

## Metadata

- **Name**: HalmosTest
- **Type**: Contract
- **Path**: test/halmos/HalmosTest.sol
- **Documentation**: @custom:halmos --solver-timeout-assertion 0

## State Variables

### SVM_ADDRESS (inherited from SymTest)

```solidity
address internal constant SVM_ADDRESS = address(uint160(uint256(keccak256("svm cheat code"))))
```

### svm (inherited from SymTest)

```solidity
SVM internal constant svm = SVM(SVM_ADDRESS)
```

**SVM**: [lib/halmos-cheatcodes/src/SVM.sol/interface_SVM.md]

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

### owner

```solidity
address internal owner
```

### morpho

```solidity
IMorpho internal morpho
```

**IMorpho**: [src/interfaces/IMorpho.sol/interface_IMorpho.md]

### loanToken

```solidity
ERC20Mock internal loanToken
```

**ERC20Mock**: [src/mocks/ERC20Mock.sol/contract_ERC20Mock.md]

### collateralToken

```solidity
ERC20Mock internal collateralToken
```

**ERC20Mock**: [src/mocks/ERC20Mock.sol/contract_ERC20Mock.md]

### oracle

```solidity
OracleMock internal oracle
```

**OracleMock**: [src/mocks/OracleMock.sol/contract_OracleMock.md]

### irm

```solidity
IrmMock internal irm
```

**IrmMock**: [src/mocks/IrmMock.sol/contract_IrmMock.md]

### lltv

```solidity
uint256 internal lltv
```

### marketParams

```solidity
MarketParams internal marketParams
```

### otherToken

```solidity
ERC20Mock internal otherToken
```

**ERC20Mock**: [src/mocks/ERC20Mock.sol/contract_ERC20Mock.md]

### flashBorrower

```solidity
FlashBorrowerMock internal flashBorrower
```

**FlashBorrowerMock**: [src/mocks/FlashBorrowerMock.sol/contract_FlashBorrowerMock.md]

## Structs

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
- **Source Range**: 1144:1411:57
- **Details**: [function_setUp.md](./function_setUp.md)

**Signature:**
```solidity
function setUp() virtual public;
```

### check_feeInRange(bytes4,address,Id)

- **Signature**: `check_feeInRange(bytes4,address,Id)`
- **Visibility**: public
- **Source Range**: 4767:210:57
- **Details**: [function_check_feeInRange_bytes4_address_Id.md](./function_check_feeInRange_bytes4_address_Id.md)

**Signature:**
```solidity
function check_feeInRange(bytes4 selector, address caller, Id id) public;
```

### check_borrowLessThanSupply(bytes4,address,Id)

- **Signature**: `check_borrowLessThanSupply(bytes4,address,Id)`
- **Visibility**: public
- **Source Range**: 5056:290:57
- **Details**: [function_check_borrowLessThanSupply_bytes4_address_Id.md](./function_check_borrowLessThanSupply_bytes4_address_Id.md)

**Signature:**
```solidity
function check_borrowLessThanSupply(bytes4 selector, address caller, Id id) public;
```

### check_lastUpdateNonZero(bytes4,address,Id)

- **Signature**: `check_lastUpdateNonZero(bytes4,address,Id)`
- **Visibility**: public
- **Source Range**: 5404:219:57
- **Details**: [function_check_lastUpdateNonZero_bytes4_address_Id.md](./function_check_lastUpdateNonZero_bytes4_address_Id.md)

**Signature:**
```solidity
function check_lastUpdateNonZero(bytes4 selector, address caller, Id id) public;
```

### check_lastUpdateCannotDecrease(bytes4,address,Id)

- **Signature**: `check_lastUpdateCannotDecrease(bytes4,address,Id)`
- **Visibility**: public
- **Source Range**: 5681:303:57
- **Details**: [function_check_lastUpdateCannotDecrease_bytes4_address_Id.md](./function_check_lastUpdateCannotDecrease_bytes4_address_Id.md)

**Signature:**
```solidity
function check_lastUpdateCannotDecrease(bytes4 selector, address caller, Id id) public;
```

### check_lltvSmallerThanWad(bytes4,address,uint256)

- **Signature**: `check_lltvSmallerThanWad(bytes4,address,uint256)`
- **Visibility**: public
- **Source Range**: 6051:264:57
- **Details**: [function_check_lltvSmallerThanWad_bytes4_address_uint256.md](./function_check_lltvSmallerThanWad_bytes4_address_uint256.md)

**Signature:**
```solidity
function check_lltvSmallerThanWad(bytes4 selector, address caller, uint256 _lltv) public;
```

### check_lltvCannotBeDisabled(bytes4,address)

- **Signature**: `check_lltvCannotBeDisabled(bytes4,address)`
- **Visibility**: public
- **Source Range**: 6364:167:57
- **Details**: [function_check_lltvCannotBeDisabled_bytes4_address.md](./function_check_lltvCannotBeDisabled_bytes4_address.md)

**Signature:**
```solidity
function check_lltvCannotBeDisabled(bytes4 selector, address caller) public;
```

### check_irmCannotBeDisabled(bytes4,address)

- **Signature**: `check_irmCannotBeDisabled(bytes4,address)`
- **Visibility**: public
- **Source Range**: 6632:173:57
- **Details**: [function_check_irmCannotBeDisabled_bytes4_address.md](./function_check_irmCannotBeDisabled_bytes4_address.md)

**Signature:**
```solidity
function check_irmCannotBeDisabled(bytes4 selector, address caller) public;
```

### check_nonceCannotDecrease(bytes4,address,address)

- **Signature**: `check_nonceCannotDecrease(bytes4,address,address)`
- **Visibility**: public
- **Source Range**: 6865:312:57
- **Details**: [function_check_nonceCannotDecrease_bytes4_address_address.md](./function_check_nonceCannotDecrease_bytes4_address_address.md)

**Signature:**
```solidity
function check_nonceCannotDecrease(bytes4 selector, address caller, address user) public;
```

### check_idToMarketParamsForCreatedMarketCannotChange(bytes4,address,Id)

- **Signature**: `check_idToMarketParamsForCreatedMarketCannotChange(bytes4,address,Id)`
- **Visibility**: public
- **Source Range**: 7302:367:57
- **Details**: [function_check_idToMarketParamsForCreatedMarketCannotChange_bytes4_address_Id.md](./function_check_idToMarketParamsForCreatedMarketCannotChange_bytes4_address_Id.md)

**Signature:**
```solidity
function check_idToMarketParamsForCreatedMarketCannotChange(bytes4 selector, address caller, Id id) public;
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
