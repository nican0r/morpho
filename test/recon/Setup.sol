// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

// Chimera deps
import {BaseSetup} from "@chimera/BaseSetup.sol";
import {vm} from "@chimera/Hevm.sol";

// Managers
import {ActorManager} from "@recon/ActorManager.sol";
import {AssetManager} from "@recon/AssetManager.sol";

// Helpers
import {Utils} from "@recon/Utils.sol";

// Your deps
import "src/Morpho.sol";
import "src/interfaces/IMorpho.sol";
import {ERC20Mock} from "src/mocks/ERC20Mock.sol";
import {OracleMock} from "src/mocks/OracleMock.sol";
import {IrmMock} from "src/mocks/IrmMock.sol";
import {ORACLE_PRICE_SCALE} from "src/libraries/ConstantsLib.sol";
import {MarketParamsLib} from "src/libraries/MarketParamsLib.sol";

abstract contract Setup is BaseSetup, ActorManager, AssetManager, Utils {
    using MarketParamsLib for MarketParams;

    // Configuration constants
    uint256 internal constant DECIMALS = 18;

    // Core contracts
    Morpho public morpho;
    ERC20Mock public loanToken;
    ERC20Mock public collateralToken;
    OracleMock public oracle;
    IrmMock public irm;

    // Market configuration
    MarketParams defaultMarketParams;
    Id defaultMarketId;

    /// === Setup === ///
    /// This contains all calls to be performed in the tester constructor, both for Echidna and Foundry
    function setup() internal virtual override {
        // 1. Add additional actors (2 actors as required)
        _addActor(address(0x100)); // Actor 1
        _addActor(address(0x200)); // Actor 2

        // 2. Deploy Morpho with address(this) as owner
        morpho = new Morpho(address(this));

        // 3. Deploy ERC20Mock tokens (loanToken and collateralToken)
        loanToken = new ERC20Mock();
        collateralToken = new ERC20Mock();

        // Add both tokens to AssetManager for tracking
        _addAsset(address(loanToken));
        _addAsset(address(collateralToken));

        // 4. Deploy OracleMock and set price to ORACLE_PRICE_SCALE (1e36)
        oracle = new OracleMock();
        oracle.setPrice(ORACLE_PRICE_SCALE);

        // 5. Deploy IrmMock
        irm = new IrmMock();

        // 6. Configure Morpho as owner (address(this))
        // Enable IRM: address(0) for zero interest
        morpho.enableIrm(address(0));

        // Enable IRM: address(irm) for the mock IRM
        morpho.enableIrm(address(irm));

        // Enable LLTVs: 0, 0.5e18, 0.8e18
        morpho.enableLltv(0);
        morpho.enableLltv(0.5e18);
        morpho.enableLltv(0.8e18);

        // Set fee recipient to address(this)
        morpho.setFeeRecipient(address(this));

        // 7. Create default market with valid parameters (LLTV = 0.8e18)
        defaultMarketParams = MarketParams({
            loanToken: address(loanToken),
            collateralToken: address(collateralToken),
            oracle: address(oracle),
            irm: address(irm),
            lltv: 0.8e18
        });

        defaultMarketId = defaultMarketParams.id();
        morpho.createMarket(defaultMarketParams);

        // 8. Set up initial balances and approvals for actors
        // ERC20Mock uses setBalance instead of mint, so we manually configure actors
        address[] memory actors = _getActors();
        uint256 initialBalance = type(uint88).max;

        for (uint256 i = 0; i < actors.length; i++) {
            address actor = actors[i];

            // Set initial balances for both tokens
            loanToken.setBalance(actor, initialBalance);
            collateralToken.setBalance(actor, initialBalance);

            // Set up approvals for Morpho from each actor
            vm.prank(actor);
            loanToken.approve(address(morpho), type(uint256).max);

            vm.prank(actor);
            collateralToken.approve(address(morpho), type(uint256).max);
        }
    }

    /// === MODIFIERS === ///
    /// Prank admin and actor

    modifier asAdmin() {
        vm.prank(address(this));
        _;
    }

    modifier asActor() {
        vm.prank(address(_getActor()));
        _;
    }
}
