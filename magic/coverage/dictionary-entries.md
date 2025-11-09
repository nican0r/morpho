# Dictionary Entries for Clamped Handlers

This document identifies dictionary values for implementing clamped handlers to improve coverage of uncovered functions.

## Handler: morpho_setFee_clamped

**Parameter:** newFee (uint256)

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| 0 | Implicit | Zero value | N/A | Edge case for zero fee |
| 1 | Implicit | Minimum non-zero value | N/A | Smallest possible fee |
| 100 | Literals | Fee basis points | Morpho.sol:125 | Typical fee percentage |
| 1000 | Literals | Fee basis points | Morpho.sol:125 | Higher fee percentage |
| market[id].fee | Runtime | Current market fee | N/A | Triggers ALREADY_SET error |
| market[id].fee + 1 | Boundary | Above current fee | N/A | Valid fee change |
| market[id].fee - 1 | Boundary | Below current fee | N/A | Valid fee change |
| type(uint256).max | Implicit | Maximum uint256 | N/A | Extreme value test |

## Handler: morpho_borrow_sharesBased_clamped

**Parameter:** shares (uint256)

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| 0 | Implicit | Zero value | N/A | Edge case for zero shares |
| 1 | Implicit | Minimum non-zero value | N/A | Smallest possible borrow |
| position[id][actor].borrowShares | Runtime | Current borrow shares | N/A | Maximum available shares |
| position[id][actor].borrowShares + 1 | Boundary | Above available shares | N/A | Tests insufficient shares |
| market[id].totalBorrowShares | Runtime | Market total borrow shares | N/A | Market-level constraint |
| market[id].totalBorrowAssets | Runtime | Market total borrow assets | N/A | Used in shares calculation |
| collateral * 0.8e18 / ORACLE_PRICE_SCALE | Runtime | Max borrow based on collateral | N/A | Health limit calculation |

## Handler: morpho_liquidate_badDebt_clamped

**Parameter:** borrower (address)

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| _getActor() | Setup | Actor from ActorManager | Setup.sol:45 | Tracked test actor |
| address(0) | Implicit | Zero address | N/A | Invalid borrower test |
| address(this) | Implicit | Current contract address | N/A | Self as borrower |
| actors[0] | Setup | First actor | Setup.sol:45 | Specific actor targeting |
| actors[1] | Setup | Second actor | Setup.sol:46 | Specific actor targeting |

**Parameter:** repaidShares (uint256)

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| 0 | Implicit | Zero value | N/A | Edge case for zero repayment |
| 1 | Implicit | Minimum non-zero value | N/A | Smallest possible repayment |
| position[id][borrower].borrowShares | Runtime | Full debt amount | N/A | Complete liquidation |
| position[id][borrower].borrowShares / 2 | Runtime | Half debt amount | N/A | Partial liquidation |
| market[id].totalBorrowShares | Runtime | Market total shares | N/A | Market constraint |

## Handler: morpho_setAuthorizationWithSig_clamped

**Parameter:** authorization.authorizer (address)

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|----------------------------------|----------------|-------|
| _getActor() | Setup | Actor from ActorManager | Setup.sol:45 | Tracked test actor |
| address(this) | Implicit | Current contract address | N/A | Self as authorizer |
| address(0) | Implicit | Zero address | N/A | Invalid authorizer test |
| actors[0] | Setup | First actor | Setup.sol:45 | Specific actor targeting |

**Parameter:** authorization.authorized (address)

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| _getActor() | Setup | Actor from ActorManager | Setup.sol:45 | Tracked test actor |
| address(this) | Implicit | Current contract address | N/A | Self as authorized |
| address(0) | Implicit | Zero address | N/A | Invalid authorized test |
| actors[1] | Setup | Second actor | Setup.sol:46 | Different actor |

**Parameter:** authorization.nonce (uint256)

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| 0 | Implicit | Zero nonce | N/A | Initial nonce value |
| 1 | Implicit | First nonce | N/A | After first use |
| currentNonce + 1 | Runtime | Next valid nonce | N/A | Valid nonce increment |
| type(uint256).max | Implicit | Maximum nonce | N/A | Extreme value test |

**Parameter:** authorization.deadline (uint256)

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| 0 | Implicit | Past deadline | N/A | Expired signature |
| block.timestamp + 1 | Runtime | Future deadline | N/A | Valid future deadline |
| block.timestamp + 3600 | Runtime | 1 hour future | N/A | Extended deadline |
| block.timestamp - 1 | Runtime | Just past | N/A | Recently expired |

## Handler: morpho_accrueInterest_withFees_clamped

**Parameter:** marketParams (MarketParams)

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| defaultMarketParams | Setup | Default market configuration | Setup.sol:82-88 | Base market with fees |
| marketParams with fee > 0 | State Variables | Market with non-zero fee | Morpho.sol:125 | Triggers fee distribution |

## Handler: morpho_extSloads_clamped

**Parameter:** slots (bytes32[])

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| [bytes32(0)] | Implicit | Zero slot | N/A | First storage slot |
| [bytes32(1)] | Implicit | Second slot | N/A | Second storage slot |
| [defaultMarketId] | Setup | Market ID slot | Setup.sol:90 | Market storage slot |
| [bytes32(uint256(keccak256("position")))] | Literals | Position mapping slot | N/A | Position storage slot |
| [bytes32(uint256(keccak256("market")))] | Literals | Market mapping slot | N/A | Market storage slot |

## Market Configuration Values

**Parameter:** fee (uint256) for market creation

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| 0 | Implicit | Zero fee | N/A | Current default |
| 100 | Literals | 1% fee | Morpho.sol:125 | Triggers fee distribution |
| 1000 | Literals | 10% fee | Morpho.sol:125 | High fee scenario |
| 10000 | Literals | 100% fee | Morpho.sol:125 | Maximum fee scenario |

## Derived Values for Bad Debt Scenarios

**Parameter:** collateral manipulation values

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| 0 | Implicit | Zero collateral | N/A | Triggers bad debt condition |
| 1 | Implicit | Minimal collateral | N/A | Near-zero collateral |
| collateral - 1 | Boundary | Below current collateral | N/A | Reduce to zero |
| ORACLE_PRICE_SCALE | State Variables | Oracle price scale | ConstantsLib.sol:5 | Price manipulation |

## Signature Generation Values

**Parameter:** signature components

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| 0 | Implicit | Zero v value | N/A | Invalid signature |
| 27 | Implicit | Valid v value | N/A | Standard signature v |
| 28 | Implicit | Valid v value | N/A | Alternative signature v |
| bytes32(0) | Implicit | Zero r/s | N/A | Invalid signature component |
| keccak256("test") | Literals | Test hash | N/A | Valid hash for r/s |