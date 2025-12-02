# Function: switchActor(uint256)

**Contract**: [test/recon/CryticTester.sol/contract_CryticTester.md]

## Metadata

- **Contract**: CryticTester
- **Signature**: `switchActor(uint256)`
- **Visibility**: public
- **Source Range**: 680:83:66
- **Inherited From**: ManagersTargets

## Implementation

```solidity
/// @dev Start acting as another actor
function switchActor(uint256 entropy) public {
    _switchActor(entropy);
}
```

## Related Implementations

### _switchActor(uint256)

- **Kind**: internal
- **Source**: 2547:143:29
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_switchActor(uint256)`

```solidity
/// @dev Expose this in the `TargetFunctions` contract to let the fuzzer switch actors
///    NOTE: We revert if the entropy is greater than the number of actors, for Halmos compatibility
///  @dev This may reduce fuzzing performance if using multiple actors, if so add explicitly clamped handlers to ManagersTargets using the index of all added actors
///  @notice Switches the current actor based on the entropy
///  @param entropy The entropy to choose a random actor in the array for switching
///  @return target The new active actor
function _switchActor(uint256 entropy) internal returns (address target) {
    target = _actors.at(entropy);
    _actor = target;
}
```

### at(struct EnumerableSet.AddressSet,uint256)

- **Kind**: internal
- **Source**: 9563:156:31
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:at(struct EnumerableSet.AddressSet,uint256)`

```solidity
///  @dev Returns the value stored at position `index` in the set. O(1).
///  Note that there are no guarantees on the ordering of values inside the
///  array, and it may change when more values are added or removed.
///  Requirements:
///  - `index` must be strictly less than {length}.
function at(AddressSet storage set, uint256 index) internal view returns (address) {
    return address(uint160(uint256(_at(set._inner, index))));
}
```

### _at(struct EnumerableSet.Set,uint256)

- **Kind**: internal
- **Source**: 4912:118:31
- **Link**: `lib/setup-helpers/src/EnumerableSet.sol:EnumerableSet:_at(struct EnumerableSet.Set,uint256)`

```solidity
///  @dev Returns the value stored at position `index` in the set. O(1).
///  Note that there are no guarantees on the ordering of values inside the
///  array, and it may change when more values are added or removed.
///  Requirements:
///  - `index` must be strictly less than {length}.
function _at(Set storage set, uint256 index) private view returns (bytes32) {
    return set._values[index];
}
```

## State Variable Reads

- **_actors** (`struct EnumerableSet.AddressSet`)

## State Variable Writes

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ManagersTargets.switchActor(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ActorManager._switchActor(uint256) (NodeID: 1)
      💬 Args: [entropy]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: EnumerableSet.at(struct EnumerableSet.AddressSet,uint256) (NodeID: 2)
        💬 Args: [_actors, entropy]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: EnumerableSet._at(struct EnumerableSet.Set,uint256) (NodeID: 3)
          💬 Args: [set._inner, index]
          👁️  Def: private
```

## Documentation

### Function Documentation

@dev Start acting as another actor
