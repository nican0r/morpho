# Justified Reverting Handlers

This document lists functions that have acceptable revert reasons in the unit tests.

## Functions with Justified Reverts

### morpho_setAuthorizationWithSig
- **Test**: `test_morpho_setAuthorizationWithSig()`
- **Expected Behavior**: The test intentionally uses an invalid signature (all zeros) to test that the function can be called
- **Justification**: According to the natspec and implementation, this function requires a valid EIP-712 signature. Using an invalid signature is expected to revert, which is the intended behavior being tested
- **Revert Reason**: Invalid signature (expected)

## Summary

Total functions with justified reverts: 1

All other functions in the testing priority list are designed to pass without reverting.