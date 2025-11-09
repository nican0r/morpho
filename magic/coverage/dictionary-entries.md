# Dictionary Entries for Clamped Handlers

## Handler: morpho_withdraw

**Parameter:** assets (uint256)

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| 0 | Implicit | Zero value | N/A | Edge case for zero withdraw |
| 1 | Implicit | Minimum non-zero value | N/A | Smallest possible withdraw |
| type(uint88).max | Setup | Initial actor token balance | Setup.sol:96 | Full balance withdraw scenario |
| loanToken.balanceOf(_getActor()) | Runtime | Actor's current loan token balance | N/A | Dynamic maximum withdraw |
| market[defaultMarketId].totalSupplyAssets | Runtime | Current total supply assets | N/A | Market's total supplied assets |
| market[defaultMarketId].totalSupplyAssets + 1 | Boundary | One above total supply | N/A | Tests insufficient liquidity revert |
| position[defaultMarketId][_getActor()].supplyShares | Runtime | Actor's supply shares | N/A | User's supply position |

**Parameter:** shares (uint256)

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| 0 | Implicit | Zero value | N/A | Edge case for zero shares |
| 1 | Implicit | Minimum non-zero value | N/A | Smallest possible shares |
| position[defaultMarketId][_getActor()].supplyShares | Runtime | Actor's supply shares | N/A | Full shares withdraw |
| position[defaultMarketId][_getActor()].supplyShares + 1 | Boundary | One above user shares | N/A | Tests insufficient shares revert |

**Parameter:** onBehalf (address)

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| _getActor() | Setup | Actor from ActorManager | Setup.sol:45 | Tracked test actor |
| address(this) | Implicit | Current contract address | N/A | Self-withdraw edge case |
| address(0) | Implicit | Zero address | N/A | Invalid address test |

**Parameter:** receiver (address)

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| _getActor() | Setup | Actor from ActorManager | Setup.sol:45 | Tracked test actor |
| address(this) | Implicit | Current contract address | N/A | Contract as receiver |
| address(0) | Implicit | Zero address | N/A | Invalid receiver test |

## Handler: morpho_borrow

**Parameter:** assets (uint256)

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| 0 | Implicit | Zero value | N/A | Edge case for zero borrow |
| 1 | Implicit | Minimum non-zero value | N/A | Smallest possible borrow |
| market[defaultMarketId].totalSupplyAssets | Runtime | Available liquidity | N/A | Maximum borrowable assets |
| market[defaultMarketId].totalSupplyAssets - market[defaultMarketId].totalBorrowAssets | Runtime | Available liquidity | N/A | Current available liquidity |
| loanToken.balanceOf(_getActor()) | Runtime | Actor's token balance | Setup.sol:102 | Actor's current balance |

**Parameter:** shares (uint256)

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| 0 | Implicit | Zero value | N/A | Edge case for zero shares |
| 1 | Implicit | Minimum non-zero value | N/A | Smallest possible shares |
| market[defaultMarketId].totalSupplyShares | Runtime | Total supply shares | N/A | Maximum possible shares |

**Parameter:** onBehalf (address)

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| _getActor() | Setup | Actor from ActorManager | Setup.sol:45 | Tracked test actor |
| address(this) | Implicit | Current contract address | N/A | Self-borrow edge case |

**Parameter:** receiver (address)

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| _getActor() | Setup | Actor from ActorManager | Setup.sol:45 | Tracked test actor |
| address(this) | Implicit | Current contract address | N/A | Contract as receiver |
| address(0) | Implicit | Zero address | N/A | Invalid receiver test |

## Handler: morpho_repay

**Parameter:** assets (uint256)

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| 0 | Implicit | Zero value | N/A | Edge case for zero repay |
| 1 | Implicit | Minimum non-zero value | N/A | Smallest possible repay |
| position[defaultMarketId][_getActor()].borrowShares | Runtime | Actor's borrow shares | N/A | Full position repay |
| market[defaultMarketId].totalBorrowAssets | Runtime | Total borrow assets | N/A | Market's total borrowed assets |
| loanToken.balanceOf(_getActor()) | Runtime | Actor's token balance | Setup.sol:102 | Available balance for repay |

**Parameter:** shares (uint256)

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| 0 | Implicit | Zero value | N/A | Edge case for zero shares |
| 1 | Implicit | Minimum non-zero value | N/A | Smallest possible shares |
| position[defaultMarketId][_getActor()].borrowShares | Runtime | Actor's borrow shares | N/A | Full shares repay |
| position[defaultMarketId][_getActor()].borrowShares + 1 | Boundary | One above user shares | N/A | Tests insufficient shares revert |

**Parameter:** onBehalf (address)

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| _getActor() | Setup | Actor from ActorManager | Setup.sol:45 | Tracked test actor |
| address(this) | Implicit | Current contract address | N/A | Self-repay edge case |
| address(0) | Implicit | Zero address | N/A | Invalid address test |

## Handler: morpho_liquidate

**Parameter:** seizedAssets (uint256)

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| 0 | Implicit | Zero value | N/A | Edge case for zero seized |
| 1 | Implicit | Minimum non-zero value | N/A | Smallest possible seizure |
| position[defaultMarketId][_getActor()].collateral | Runtime | Full collateral position | Morpho.sol:388 | Seize entire position to reach bad debt |
| position[defaultMarketId][_getActor()].collateral - 1 | Boundary | One below full collateral | N/A | Almost full liquidation |
| type(uint88).max | Setup | Initial token balance | Setup.sol:96 | Maximum possible balance |

**Parameter:** repaidShares (uint256)

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| 0 | Implicit | Zero value | N/A | Edge case for zero shares |
| 1 | Implicit | Minimum non-zero value | N/A | Smallest possible shares |
| position[defaultMarketId][_getActor()].borrowShares | Runtime | Full borrow position | Morpho.sol:384 | Repay entire position |
| position[defaultMarketId][_getActor()].borrowShares + 1 | Boundary | One above user shares | N/A | Tests insufficient shares revert |
| market[defaultMarketId].totalBorrowShares | Runtime | Market total borrow shares | Morpho.sol:385 | Market-wide borrow shares |

**Parameter:** borrower (address)

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| _getActor() | Setup | Actor from ActorManager | Setup.sol:45 | Tracked test actor |
| address(0x100) | Setup | Specific actor address | Setup.sol:45 | Actor 1 address |
| address(0x200) | Setup | Specific actor address | Setup.sol:46 | Actor 2 address |
| address(this) | Implicit | Current contract address | N/A | Self as borrower edge case |
| address(0) | Implicit | Zero address | N/A | Invalid borrower test |

## Special Values for Bad Debt Coverage (Lines 392-403)

The missing coverage is for bad debt scenarios where `position[id][borrower].collateral == 0` and the borrower has remaining borrow shares.

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| position[defaultMarketId][borrower].collateral | Runtime | Full collateral amount | Morpho.sol:388 | To reduce collateral to 0 |
| position[defaultMarketId][borrower].borrowShares | Runtime | Full borrow shares | Morpho.sol:384 | Remaining debt after liquidation |
| 0.8e18 | Setup | LLTV from default market | Setup.sol:87 | Loan-to-value ratio |
| 1.15e18 | Constants | Max liquidation incentive | ConstantsLib.sol:14 | Liquidation incentive factor |
| 0.3e18 | Constants | Liquidation cursor | ConstantsLib.sol:11 | Liquidation calculation factor |
| ORACLE_PRICE_SCALE | Constants | Oracle price scale | ConstantsLib.sol:8 | Price normalization factor |

## Handler: morpho_setAuthorizationWithSig

**Parameter:** authorization (Authorization)

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| _getActor() | Setup | Actor from ActorManager | Setup.sol:45 | Authorizer actor |
| address(this) | Implicit | Current contract | N/A | Contract as authorizer |
| block.timestamp | Runtime | Current timestamp | N/A | Valid deadline |
| block.timestamp + 1 | Runtime | Future timestamp | N/A | Valid future deadline |
| block.timestamp - 1 | Runtime | Past timestamp | N/A | Expired deadline test |
| 0 | Implicit | Zero nonce | N/A | Initial nonce value |
| nonce[_getActor()] | Runtime | Current nonce | N/A | Valid nonce value |

**Parameter:** signature (Signature)

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| 27 | Implicit | Valid v value | N/A | Standard v value |
| 28 | Implicit | Valid v value | N/A | Alternative v value |
| bytes32(0) | Implicit | Zero r/s | N/A | Invalid signature test |
| type(uint256).max | Implicit | Max value | N/A | Extreme signature test |

## Handler: morpho_accrueInterest

**Parameter:** marketParams (MarketParams)

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| defaultMarketParams | Setup | Default market configuration | Setup.sol:82-88 | Valid created market |
| address(loanToken) | Setup | Loan token address | Setup.sol:52 | Market loan token |
| address(collateralToken) | Setup | Collateral token address | Setup.sol:53 | Market collateral token |
| address(oracle) | Setup | Oracle address | Setup.sol:60 | Market oracle |
| address(irm) | Setup | IRM address | Setup.sol:64 | Market IRM |
| 0.8e18 | Setup | LLTV value | Setup.sol:87 | Market LLTV |

## Handler: morpho_extSloads

**Parameter:** slots (bytes32[])

| Dictionary Value | Source Category | Specific Source | Line Reference | Notes |
|-----------------|-----------------|-----------------|----------------|-------|
| bytes32(0) | Implicit | Zero slot | N/A | First storage slot |
| bytes32(1) | Implicit | Slot 1 | N/A | Second storage slot |
| keccak256("market") | Runtime | Market storage slot | N/A | Market mapping slot |
| keccak256("position") | Runtime | Position storage slot | N/A | Position mapping slot |
| keccak256("isAuthorized") | Runtime | Authorization storage slot | N/A | Authorization mapping slot |
| keccak256("nonce") | Runtime | Nonce storage slot | N/A | Nonce mapping slot |