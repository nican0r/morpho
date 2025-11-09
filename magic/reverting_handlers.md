# Reverting Handlers Documentation

## Functions with Acceptable Revert Reasons

### morpho_setAuthorizationWithSig
- **Function**: `test_morpho_setAuthorizationWithSig()`
- **Expected Revert**: Invalid signature (v=0, r=0, s=0)
- **Justification**: This test intentionally uses an invalid signature to verify the target function can be called. The revert is expected behavior when testing signature validation functionality.
- **Implementation**: The test wraps the call in a try-catch block to handle the expected revert gracefully.

## Summary
Only one function (`morpho_setAuthorizationWithSig`) has an acceptable revert reason, which is expected behavior for testing signature validation with invalid data. All other functions execute successfully without reverts when called with proper parameters and prerequisites.