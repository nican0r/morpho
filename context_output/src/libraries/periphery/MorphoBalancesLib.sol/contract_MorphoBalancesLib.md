# Contract: MorphoBalancesLib

## Metadata

- **Name**: MorphoBalancesLib
- **Type**: Contract
- **Path**: src/libraries/periphery/MorphoBalancesLib.sol
- **Documentation**: @title MorphoBalancesLib
   @author Morpho Labs
   @custom:contact security@morpho.org
   @notice Helper library exposing getters with the expected value after interest accrual.
   @dev This library is not used in Morpho itself and is intended to be used by integrators.
   @dev The getter to retrieve the expected total borrow shares is not exposed because interest accrual does not apply
   to it. The value can be queried directly on Morpho using `totalBorrowShares`.
