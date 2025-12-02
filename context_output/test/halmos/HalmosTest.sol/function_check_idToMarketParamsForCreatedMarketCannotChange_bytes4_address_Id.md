# Function: check_idToMarketParamsForCreatedMarketCannotChange(bytes4,address,Id)

**Contract**: [test/halmos/HalmosTest.sol/contract_HalmosTest.md]

## Metadata

- **Contract**: HalmosTest
- **Signature**: `check_idToMarketParamsForCreatedMarketCannotChange(bytes4,address,Id)`
- **Visibility**: public
- **Source Range**: 7302:367:57

## Implementation

```solidity
function check_idToMarketParamsForCreatedMarketCannotChange(bytes4 selector, address caller, Id id) public {
    MarketParams memory itmpBefore = morpho.idToMarketParams(id);
    _callMorpho(selector, caller);
    MarketParams memory itmpAfter = morpho.idToMarketParams(id);
    assert(Id.unwrap(itmpBefore.id()) == Id.unwrap(itmpAfter.id()));
}
```

## Related Implementations

### _callMorpho(bytes4,address)

- **Kind**: internal
- **Source**: 2656:2043:57
- **Link**: `test/halmos/HalmosTest.sol:HalmosTest:_callMorpho(bytes4,address)`

```solidity
function _callMorpho(bytes4 selector, address caller) internal {
    vm.assume(selector != morpho.extSloads.selector);
    vm.assume(selector != morpho.createMarket.selector);
    bytes memory emptyData = hex"";
    uint256 assets = svm.createUint256("assets");
    uint256 shares = svm.createUint256("shares");
    address onBehalf = svm.createAddress("onBehalf");
    address receiver = svm.createAddress("receiver");
    bytes memory args;
    if ((selector == morpho.supply.selector) || (selector == morpho.repay.selector)) {
        args = abi.encode(marketParams, assets, shares, onBehalf, emptyData);
    } else if ((selector == morpho.withdraw.selector) || (selector == morpho.borrow.selector)) {
        args = abi.encode(marketParams, assets, shares, onBehalf, receiver);
    } else if (selector == morpho.supplyCollateral.selector) {
        args = abi.encode(marketParams, assets, onBehalf, emptyData);
    } else if (selector == morpho.withdrawCollateral.selector) {
        args = abi.encode(marketParams, assets, onBehalf, receiver);
    } else if (selector == morpho.liquidate.selector) {
        address borrower = svm.createAddress("borrower");
        args = abi.encode(marketParams, borrower, assets, shares, emptyData);
    } else if (selector == morpho.flashLoan.selector) {
        address token = svm.createAddress("token");
        bytes memory _data = svm.createBytes(1024, "_data");
        args = abi.encode(token, assets, _data);
    } else if (selector == morpho.accrueInterest.selector) {
        args = abi.encode(marketParams);
    } else if (selector == morpho.setFee.selector) {
        uint256 newFee = svm.createUint256("newFee");
        args = abi.encode(marketParams, newFee);
    } else {
        args = svm.createBytes(1024, "data");
    }
    vm.prank(caller);
    (bool success, ) = address(morpho).call(abi.encodePacked(selector, args));
    vm.assume(success);
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

## External Calls

- **IMorpho::idToMarketParams(Id)**

## State Variable Reads

- **morpho** (`contract IMorpho`) [src/interfaces/IMorpho.sol/interface_IMorpho.md]
- **marketParams** (`struct MarketParams`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HalmosTest.check_idToMarketParamsForCreatedMarketCannotChange(bytes4,address,Id) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: HalmosTest._callMorpho(bytes4,address) (NodeID: 1)
  │   💬 Args: [selector, caller]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: MarketParamsLib.id(struct MarketParams) (NodeID: 2)
  │   💬 Args: [itmpAfter]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: MarketParamsLib.id(struct MarketParams) (NodeID: 3)
      💬 Args: [itmpBefore]
      👁️  Def: internal
```
