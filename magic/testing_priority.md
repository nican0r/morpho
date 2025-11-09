These functions are ranked in order of how they should be implemented in unit tests. When creating unit tests for `CryticToFoundry` test each of the functions in this order.

1. `morpho_createMarket`
   - no prerequisite
2. `morpho_setAuthorization`
   - no prerequisite
3. `morpho_setAuthorizationWithSig`
   - no prerequisite
4. `morpho_flashLoan`
   - no prerequisite
5. `morpho_supplyCollateral`
   - createMarket must be called first
6. `morpho_supply`
   - createMarket must be called first
7. `morpho_accrueInterest`
   - createMarket must be called first
8. `morpho_withdraw`
   - createMarket and supply must be called first
9. `morpho_withdrawCollateral`
   - createMarket and supplyCollateral must be called first
10. `morpho_borrow`
    - createMarket, supply, and supplyCollateral must be called first
11. `morpho_repay`
    - createMarket and borrow must be called first
12. `morpho_liquidate`
    - createMarket, supply, supplyCollateral, and borrow must be called first, plus borrower must be unhealthy