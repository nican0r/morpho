# Contracts to Cover

## Core Protocol Contracts
- `Morpho.sol`

## Interface Contracts (Touched via External Calls)
- `src/interfaces/IERC20.sol`
- `src/interfaces/IIrm.sol`
- `src/interfaces/IOracle.sol`
- `src/interfaces/IMorpho.sol`
- `src/interfaces/IMorphoCallbacks.sol`

## Library Contracts (Touched via External Calls)
- `src/libraries/ConstantsLib.sol`
- `src/libraries/UtilsLib.sol`
- `src/libraries/EventsLib.sol`
- `src/libraries/ErrorsLib.sol`
- `src/libraries/MathLib.sol`
- `src/libraries/SharesMathLib.sol`
- `src/libraries/MarketParamsLib.sol`
- `src/libraries/SafeTransferLib.sol`

## Mock Contracts (EXCLUDED from coverage)
- `src/mocks/ERC20Mock.sol` - Mock token for testing
- `src/mocks/OracleMock.sol` - Mock oracle for testing
- `src/mocks/IrmMock.sol` - Mock interest rate model for testing
- `src/mocks/FlashBorrowerMock.sol` - Mock flash borrower for testing