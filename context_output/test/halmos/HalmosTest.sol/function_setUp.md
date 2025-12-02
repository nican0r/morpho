# Function: setUp()

**Contract**: [test/halmos/HalmosTest.sol/contract_HalmosTest.md]

## Metadata

- **Contract**: HalmosTest
- **Signature**: `setUp()`
- **Visibility**: public
- **Source Range**: 1144:1411:57

## Implementation

```solidity
function setUp() virtual public {
    owner = svm.createAddress("owner");
    morpho = IMorpho(address(new Morpho(owner)));
    loanToken = new ERC20Mock();
    collateralToken = new ERC20Mock();
    oracle = new OracleMock();
    oracle.setPrice(ORACLE_PRICE_SCALE);
    irm = new IrmMock();
    lltv = svm.createUint256("lltv");
    marketParams = MarketParams(address(loanToken), address(collateralToken), address(oracle), address(irm), lltv);
    vm.startPrank(owner);
    morpho.enableIrm(address(irm));
    morpho.enableLltv(lltv);
    morpho.createMarket(marketParams);
    vm.stopPrank();
    otherToken = new ERC20Mock();
    flashBorrower = new FlashBorrowerMock(morpho);
    svm.enableSymbolicStorage(address(this));
    svm.enableSymbolicStorage(address(morpho));
    svm.enableSymbolicStorage(address(loanToken));
    svm.enableSymbolicStorage(address(collateralToken));
    svm.enableSymbolicStorage(address(oracle));
    svm.enableSymbolicStorage(address(irm));
    svm.enableSymbolicStorage(address(otherToken));
    svm.enableSymbolicStorage(address(flashBorrower));
    vm.roll(svm.createUint(64, "block.number"));
    vm.warp(svm.createUint(64, "block.timestamp"));
}
```

## External Calls

- **SVM::createAddress(string)**
- **OracleMock::setPrice(uint256)**
- **SVM::createUint256(string)**
- **Vm::startPrank(address)**
- **IMorpho::enableIrm(address)**
- **IMorpho::enableLltv(uint256)**
- **IMorpho::createMarket(struct MarketParams)**
- **Vm::stopPrank()**
- **SVM::enableSymbolicStorage(address)**
- **Vm::roll(uint256)**
- **SVM::createUint(uint256,string)**
- **Vm::warp(uint256)**

## State Variable Reads

- **owner** (`address`)
- **oracle** (`contract OracleMock`) [src/mocks/OracleMock.sol/contract_OracleMock.md]
- **loanToken** (`contract ERC20Mock`) [src/mocks/ERC20Mock.sol/contract_ERC20Mock.md]
- **collateralToken** (`contract ERC20Mock`) [src/mocks/ERC20Mock.sol/contract_ERC20Mock.md]
- **irm** (`contract IrmMock`) [src/mocks/IrmMock.sol/contract_IrmMock.md]
- **lltv** (`uint256`)
- **morpho** (`contract IMorpho`) [src/interfaces/IMorpho.sol/interface_IMorpho.md]
- **marketParams** (`struct MarketParams`)
- **otherToken** (`contract ERC20Mock`) [src/mocks/ERC20Mock.sol/contract_ERC20Mock.md]
- **flashBorrower** (`contract FlashBorrowerMock`) [src/mocks/FlashBorrowerMock.sol/contract_FlashBorrowerMock.md]

## State Variable Writes

- **owner** (`address`)
- **morpho** (`contract IMorpho`) [src/interfaces/IMorpho.sol/interface_IMorpho.md]
- **loanToken** (`contract ERC20Mock`) [src/mocks/ERC20Mock.sol/contract_ERC20Mock.md]
- **collateralToken** (`contract ERC20Mock`) [src/mocks/ERC20Mock.sol/contract_ERC20Mock.md]
- **oracle** (`contract OracleMock`) [src/mocks/OracleMock.sol/contract_OracleMock.md]
- **irm** (`contract IrmMock`) [src/mocks/IrmMock.sol/contract_IrmMock.md]
- **lltv** (`uint256`)
- **marketParams** (`struct MarketParams`)
- **otherToken** (`contract ERC20Mock`) [src/mocks/ERC20Mock.sol/contract_ERC20Mock.md]
- **flashBorrower** (`contract FlashBorrowerMock`) [src/mocks/FlashBorrowerMock.sol/contract_FlashBorrowerMock.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HalmosTest.setUp() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
