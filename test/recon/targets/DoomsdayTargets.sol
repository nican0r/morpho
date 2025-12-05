// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {BeforeAfter} from "../BeforeAfter.sol";
import {Properties} from "../Properties.sol";
// Chimera deps
import {vm} from "@chimera/Hevm.sol";

// Helpers
import {Panic} from "@recon/Panic.sol";
import {ORACLE_PRICE_SCALE} from "src/libraries/ConstantsLib.sol";

abstract contract DoomsdayTargets is
    BaseTargetFunctions,
    Properties
{
    /// CUSTOM TARGET FUNCTIONS - Add your own target functions here ///
    
    /// @dev Manipulate oracle price to make positions unhealthy (enables liquidation)
    function oracle_decreasePrice(uint256 priceDropPercentage) public {
        // Clamp price drop to 1-99% to avoid zero price
        priceDropPercentage = (priceDropPercentage % 99) + 1;
        
        // Calculate new price (e.g., 50% drop = ORACLE_PRICE_SCALE * 50 / 100)
        uint256 newPrice = ORACLE_PRICE_SCALE * (100 - priceDropPercentage) / 100;
        
        // Ensure price is never zero
        if (newPrice == 0) newPrice = 1;
        
        vm.prank(address(this));
        oracle.setPrice(newPrice);
    }
    
    /// @dev Set oracle price to a specific value
    function oracle_setPrice(uint256 price) public {
        // Clamp price to reasonable range (1 to 10x ORACLE_PRICE_SCALE)
        price = (price % (ORACLE_PRICE_SCALE * 10)) + 1;
        
        vm.prank(address(this));
        oracle.setPrice(price);
    }
    
    /// @dev Drastically decrease price to create bad debt scenarios
    function oracle_crashPrice() public {
        // Set price to 10% of ORACLE_PRICE_SCALE (90% crash)
        vm.prank(address(this));
        oracle.setPrice(ORACLE_PRICE_SCALE / 10);
    }
    
    /// @dev Increase oracle price (makes positions healthier)
    function oracle_increasePrice(uint256 priceIncreasePercentage) public {
        // Clamp price increase to 1-100%
        priceIncreasePercentage = (priceIncreasePercentage % 100) + 1;
        
        // Calculate new price (e.g., 50% increase = ORACLE_PRICE_SCALE * 150 / 100)
        uint256 newPrice = ORACLE_PRICE_SCALE * (100 + priceIncreasePercentage) / 100;
        
        vm.prank(address(this));
        oracle.setPrice(newPrice);
    }

    /// Makes a handler have no side effects
    /// The fuzzer will call this anyway, and because it reverts it will be removed from shrinking
    /// Replace the "withGhosts" with "stateless" to make the code clean
    modifier stateless() {
        _;
        revert("stateless");
    }
}