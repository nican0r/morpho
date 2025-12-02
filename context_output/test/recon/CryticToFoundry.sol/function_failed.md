# Function: failed()

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `failed()`
- **Visibility**: public
- **Source Range**: 1819:584:7
- **Inherited From**: DSTest

## Implementation

```solidity
function failed() public returns (bool) {
    if (_failed) {
        return _failed;
    } else {
        bool globalFailed = false;
        if (hasHEVMContext()) {
            (, bytes memory retdata) = HEVM_ADDRESS.call(abi.encodePacked(bytes4(keccak256("load(address,bytes32)")), abi.encode(HEVM_ADDRESS, bytes32("failed"))));
            globalFailed = abi.decode(retdata, (bool));
        }
        return globalFailed;
    }
}
```

## Related Implementations

### hasHEVMContext()

- **Kind**: internal
- **Source**: 2847:242:7
- **Link**: `lib/forge-std/lib/ds-test/src/test.sol:DSTest:hasHEVMContext()`

```solidity
function hasHEVMContext() internal view returns (bool) {
    uint256 hevmCodeSize = 0;
    assembly {
        hevmCodeSize := extcodesize(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D)
    }
    return hevmCodeSize > 0;
}
```

## External Calls

- **address::call(bytes memory)**

## Native Transfers

- **HEVM_ADDRESS** (computed)

## State Variable Reads

- **_failed** (`bool`)
- **HEVM_ADDRESS** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: DSTest.failed() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: DSTest.hasHEVMContext() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```
