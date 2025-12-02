# Function: setAuthorization(address,bool)

**Contract**: [src/Morpho.sol/contract_Morpho.md]

## Metadata

- **Contract**: Morpho
- **Signature**: `setAuthorization(address,bool)`
- **Visibility**: external
- **Source Range**: 16577:341:35

## Implementation

```solidity
/// @inheritdoc IMorphoBase
function setAuthorization(address authorized, bool newIsAuthorized) external {
    require(newIsAuthorized != isAuthorized[msg.sender][authorized], ErrorsLib.ALREADY_SET);
    isAuthorized[msg.sender][authorized] = newIsAuthorized;
    emit EventsLib.SetAuthorization(msg.sender, msg.sender, authorized, newIsAuthorized);
}
```

## State Variable Reads

- **isAuthorized** (`mapping(address => mapping(address => bool))`)

## State Variable Writes

- **isAuthorized** (`mapping(address => mapping(address => bool))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Morpho.setAuthorization(address,bool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IMorphoBase

### Interface Documentation

@notice Sets the authorization for `authorized` to manage `msg.sender`'s positions.
 @param authorized The authorized address.
 @param newIsAuthorized The new authorization status.
