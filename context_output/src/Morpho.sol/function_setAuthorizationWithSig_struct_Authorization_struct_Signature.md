# Function: setAuthorizationWithSig(struct Authorization,struct Signature)

**Contract**: [src/Morpho.sol/contract_Morpho.md]

## Metadata

- **Contract**: Morpho
- **Signature**: `setAuthorizationWithSig(struct Authorization,struct Signature)`
- **Visibility**: external
- **Source Range**: 16956:1162:35

## Implementation

```solidity
/// @inheritdoc IMorphoBase
function setAuthorizationWithSig(Authorization memory authorization, Signature calldata signature) external {
    /// Do not check whether authorization is already set because the nonce increment is a desired side effect.
    require(block.timestamp <= authorization.deadline, ErrorsLib.SIGNATURE_EXPIRED);
    require(authorization.nonce == (nonce[authorization.authorizer]++), ErrorsLib.INVALID_NONCE);
    bytes32 hashStruct = keccak256(abi.encode(AUTHORIZATION_TYPEHASH, authorization));
    bytes32 digest = keccak256(bytes.concat("\u0019\u0001", DOMAIN_SEPARATOR, hashStruct));
    address signatory = ecrecover(digest, signature.v, signature.r, signature.s);
    require((signatory != address(0)) && (authorization.authorizer == signatory), ErrorsLib.INVALID_SIGNATURE);
    emit EventsLib.IncrementNonce(msg.sender, authorization.authorizer, authorization.nonce);
    isAuthorized[authorization.authorizer][authorization.authorized] = authorization.isAuthorized;
    emit EventsLib.SetAuthorization(msg.sender, authorization.authorizer, authorization.authorized, authorization.isAuthorized);
}
```

## State Variable Reads

- **DOMAIN_SEPARATOR** (`bytes32`)

## State Variable Writes

- **nonce** (`mapping(address => uint256)`)
- **isAuthorized** (`mapping(address => mapping(address => bool))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Morpho.setAuthorizationWithSig(struct Authorization,struct Signature) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IMorphoBase

### Interface Documentation

@notice Sets the authorization for `authorization.authorized` to manage `authorization.authorizer`'s positions.
 @dev Warning: Reverts if the signature has already been submitted.
 @dev The signature is malleable, but it has no impact on the security here.
 @dev The nonce is passed as argument to be able to revert with a different error message.
 @param authorization The `Authorization` struct.
 @param signature The signature.
