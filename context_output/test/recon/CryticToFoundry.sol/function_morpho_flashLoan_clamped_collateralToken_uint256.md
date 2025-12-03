# Function: morpho_flashLoan_clamped_collateralToken(uint256)

**Contract**: [test/recon/CryticToFoundry.sol/contract_CryticToFoundry.md]

## Metadata

- **Contract**: CryticToFoundry
- **Signature**: `morpho_flashLoan_clamped_collateralToken(uint256)`
- **Visibility**: public
- **Source Range**: 1675:302:67
- **Inherited From**: MorphoTargets

## Implementation

```solidity
function morpho_flashLoan_clamped_collateralToken(uint256 assets_) public asActor() {
    uint256 maxAssets = collateralToken.balanceOf(address(morpho));
    uint256 assets = (maxAssets > 0) ? between(assets_, 0, maxAssets) : 0;
    morpho.flashLoan(address(collateralToken), assets, "");
}
```

## Related Implementations

### between(uint256,uint256,uint256)

- **Kind**: internal
- **Source**: 933:269:5
- **Link**: `lib/chimera/src/FoundryAsserts.sol:FoundryAsserts:between(uint256,uint256,uint256)`

```solidity
function between(uint256 value, uint256 low, uint256 high) virtual override internal returns (uint256) {
    if ((value < low) || (value > high)) {
        uint256 ans = low + (value % ((high - low) + 1));
        return ans;
    }
    return value;
}
```

### asActor()

- **Kind**: modifier
- **Source**: 3899:75:62
- **Link**: `test/recon/Setup.sol:Setup:asActor()`

```solidity
modifier asActor() {
    vm.prank(address(_getActor()));
    _;
}
```

### _getActor()

- **Kind**: internal
- **Source**: 1115:83:29
- **Link**: `lib/setup-helpers/src/ActorManager.sol:ActorManager:_getActor()`

```solidity
/// @notice Returns the current active actor
function _getActor() internal view returns (address) {
    return _actor;
}
```

## External Calls

- **ERC20Mock::balanceOf(address)**
- **Morpho::flashLoan(address,uint256,bytes)**

## State Variable Reads

- **_actor** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: MorphoTargets.morpho_flashLoan_clamped_collateralToken(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: FoundryAsserts.between(uint256,uint256,uint256) (NodeID: 1)
  │   💬 Args: [assets_, 0, maxAssets]
  │   👁️  Def: internal
  └─ [1] 🔒 MODIFIER: Setup.asActor() (NodeID: 2)
      💬 Args: [no args]
    └─ [2] ⚙️ FUNCTION: ActorManager._getActor() (NodeID: 3)
        💬 Args: [no args]
        👁️  Def: internal
```
