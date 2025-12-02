# Function: constructor()

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `constructor()`
- **Visibility**: public
- **Source Range**: 360:46:59

## Implementation

```solidity
constructor() payable {
    setup();
}
```

## Related Implementations

### setup()

- **Kind**: internal
- **Source**: 1259:2499:62
- **Link**: `test/recon/Setup.sol:Setup:setup()`

```solidity
/// === Setup === ///
///  This contains all calls to be performed in the tester constructor, both for Echidna and Foundry
function setup() virtual override internal {
    _addActor(address(0x100));
    _addActor(address(0x200));
    morpho = new Morpho(address(this));
    loanToken = new ERC20Mock();
    collateralToken = new ERC20Mock();
    _addAsset(address(loanToken));
    _addAsset(address(collateralToken));
    oracle = new OracleMock();
    oracle.setPrice(ORACLE_PRICE_SCALE);
    irm = new IrmMock();
    morpho.enableIrm(address(0));
    morpho.enableIrm(address(irm));
    morpho.enableLltv(0);
    morpho.enableLltv(0.5e18);
    morpho.enableLltv(0.8e18);
    morpho.setFeeRecipient(address(this));
    defaultMarketParams = MarketParams({loanToken: address(loanToken), collateralToken: address(collateralToken), oracle: address(oracle), irm: address(irm), lltv: 0.8e18});
    defaultMarketId = defaultMarketParams.id();
    morpho.createMarket(defaultMarketParams);
    address[] memory actors = _getActors();
    uint256 initialBalance = type(uint88).max;
    for (uint256 i = 0; i < actors.length; i++) {
        address actor = actors[i];
        loanToken.setBalance(actor, initialBalance);
        collateralToken.setBalance(actor, initialBalance);
        vm.prank(actor);
        loanToken.approve(address(morpho), type(uint256).max);
        vm.prank(actor);
        collateralToken.approve(address(morpho), type(uint256).max);
    }
}
```

### _addActor(address)

- **Kind**: internal
- **Source**: 1411:250:29
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_addActor(address)`

```solidity
/// @notice Adds an actor to the list of actors
function _addActor(address target) internal {
    if (_actors.contains(target)) {
        revert ActorExists();
    }
    if (target == address(this)) {
        revert DefaultActor();
    }
    _actors.add(target);
}
```

### contains(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 8860:165:31
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:contains(struct EnumerableSet.AddressSet,address)`

```solidity
///  @dev Returns true if the value is in the set. O(1).
function contains(AddressSet storage set, address value) internal view returns (bool) {
    return _contains(set._inner, bytes32(uint256(uint160(value))));
}
```

### _contains(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 4255:127:31
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_contains(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Returns true if the value is in the set. O(1).
function _contains(Set storage set, bytes32 value) private view returns (bool) {
    return set._indexes[value] != 0;
}
```

### add(struct EnumerableSet.AddressSet,address)

- **Kind**: internal
- **Source**: 8305:150:31
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:add(struct EnumerableSet.AddressSet,address)`

```solidity
///  @dev Add a value to a set. O(1).
///  Returns true if the value was added to the set, that is if it was not
///  already present.
function add(AddressSet storage set, address value) internal returns (bool) {
    return _add(set._inner, bytes32(uint256(uint160(value))));
}
```

### _add(struct EnumerableSet.Set,bytes32)

- **Kind**: internal
- **Source**: 2214:404:31
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_add(struct EnumerableSet.Set,bytes32)`

```solidity
///  @dev Add a value to a set. O(1).
///  Returns true if the value was added to the set, that is if it was not
///  already present.
function _add(Set storage set, bytes32 value) private returns (bool) {
    if (!_contains(set, value)) {
        set._values.push(value);
        set._indexes[value] = set._values.length;
        return true;
    } else {
        return false;
    }
}
```

### _addAsset(address)

- **Kind**: internal
- **Source**: 1878:160:30
- **Link**: `lib/setup-helpers/src/AssetManager.sol:AssetManager:_addAsset(address)`

```solidity
/// @notice Adds an asset to the list of assets
///  @param target The address of the asset to add
function _addAsset(address target) internal {
    if (_assets.contains(target)) {
        revert Exists();
    }
    _assets.add(target);
}
```

### id(struct MarketParams)

- **Kind**: internal
- **Source**: 598:222:44
- **Link**: `src/libraries/MarketParamsLib.sol:MarketParamsLib:id(struct MarketParams)`

```solidity
/// @notice Returns the id of the market `marketParams`.
function id(MarketParams memory marketParams) internal pure returns (Id marketParamsId) {
    assembly ("memory-safe") {
        marketParamsId := keccak256(marketParams, MARKET_PARAMS_BYTES_LENGTH)
    }
}
```

### _getActors()

- **Kind**: internal
- **Source**: 1250:103:29
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_getActors()`

```solidity
/// @notice Returns all actors being used
function _getActors() internal view returns (address[] memory) {
    return _actors.values();
}
```

### values(struct EnumerableSet.AddressSet)

- **Kind**: internal
- **Source**: 10259:300:31
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:values(struct EnumerableSet.AddressSet)`

```solidity
///  @dev Return the entire set in an array
///  WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
///  to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
///  this function has an unbounded cost, and using it as part of a state-changing function may render the function
///  uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
function values(AddressSet storage set) internal view returns (address[] memory) {
    bytes32[] memory store = _values(set._inner);
    address[] memory result;
    /// @solidity memory-safe-assembly
    assembly {
        result := store
    }
    return result;
}
```

### _values(struct EnumerableSet.Set)

- **Kind**: internal
- **Source**: 5570:109:31
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_values(struct EnumerableSet.Set)`

```solidity
///  @dev Return the entire set in an array
///  WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
///  to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
///  this function has an unbounded cost, and using it as part of a state-changing function may render the function
///  uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
function _values(Set storage set) private view returns (bytes32[] memory) {
    return set._values;
}
```

## State Variable Reads

- **loanToken** (`contract ERC20Mock`) [src/mocks/ERC20Mock.sol/contract_ERC20Mock.md]
- **collateralToken** (`contract ERC20Mock`) [src/mocks/ERC20Mock.sol/contract_ERC20Mock.md]
- **oracle** (`contract OracleMock`) [src/mocks/OracleMock.sol/contract_OracleMock.md]
- **morpho** (`contract Morpho`) [src/Morpho.sol/contract_Morpho.md]
- **irm** (`contract IrmMock`) [src/mocks/IrmMock.sol/contract_IrmMock.md]
- **defaultMarketParams** (`struct MarketParams`)
- **_actors** (`struct EnumerableSet.AddressSet`)
- **_assets** (`struct EnumerableSet.AddressSet`)

## State Variable Writes

- **morpho** (`contract Morpho`) [src/Morpho.sol/contract_Morpho.md]
- **loanToken** (`contract ERC20Mock`) [src/mocks/ERC20Mock.sol/contract_ERC20Mock.md]
- **collateralToken** (`contract ERC20Mock`) [src/mocks/ERC20Mock.sol/contract_ERC20Mock.md]
- **oracle** (`contract OracleMock`) [src/mocks/OracleMock.sol/contract_OracleMock.md]
- **irm** (`contract IrmMock`) [src/mocks/IrmMock.sol/contract_IrmMock.md]
- **defaultMarketParams** (`struct MarketParams`)
- **defaultMarketId** (`Id`)
- **_actors** (`struct EnumerableSet.AddressSet`)
- **_assets** (`struct EnumerableSet.AddressSet`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: CryticTester.constructor() (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: CryticTester
  └─ [1] ⚙️ FUNCTION: Setup.setup() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ActorManager._addActor(address) (NodeID: 2)
    │   💬 Args: [address(0x100)]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 3)
    │ │   💬 Args: [_actors, target]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 4)
    │ │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │ │     👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 5)
    │     💬 Args: [_actors, target]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 6)
    │       💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │       👁️  Def: private
    │     └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 7)
    │         💬 Args: [set, value]
    │         👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: ActorManager._addActor(address) (NodeID: 8)
    │   💬 Args: [address(0x200)]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 9)
    │ │   💬 Args: [_actors, target]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 10)
    │ │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │ │     👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 11)
    │     💬 Args: [_actors, target]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 12)
    │       💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │       👁️  Def: private
    │     └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 13)
    │         💬 Args: [set, value]
    │         👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: AssetManager._addAsset(address) (NodeID: 14)
    │   💬 Args: [address(loanToken)]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 15)
    │ │   💬 Args: [_assets, target]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 16)
    │ │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │ │     👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 17)
    │     💬 Args: [_assets, target]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 18)
    │       💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │       👁️  Def: private
    │     └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 19)
    │         💬 Args: [set, value]
    │         👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: AssetManager._addAsset(address) (NodeID: 20)
    │   💬 Args: [address(collateralToken)]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: EnumerableSet.contains(struct EnumerableSet.AddressSet,address) (NodeID: 21)
    │ │   💬 Args: [_assets, target]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 22)
    │ │     💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │ │     👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: EnumerableSet.add(struct EnumerableSet.AddressSet,address) (NodeID: 23)
    │     💬 Args: [_assets, target]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: EnumerableSet._add(struct EnumerableSet.Set,bytes32) (NodeID: 24)
    │       💬 Args: [set._inner, bytes32(uint256(uint160(value)))]
    │       👁️  Def: private
    │     └─ [5] ⚙️ FUNCTION: EnumerableSet._contains(struct EnumerableSet.Set,bytes32) (NodeID: 25)
    │         💬 Args: [set, value]
    │         👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: MarketParamsLib.id(struct MarketParams) (NodeID: 26)
    │   💬 Args: [defaultMarketParams]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ActorManager._getActors() (NodeID: 27)
        💬 Args: [no args]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: EnumerableSet.values(struct EnumerableSet.AddressSet) (NodeID: 28)
          💬 Args: [_actors]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: EnumerableSet._values(struct EnumerableSet.Set) (NodeID: 29)
            💬 Args: [set._inner]
            👁️  Def: private
```
