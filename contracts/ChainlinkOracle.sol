// SPDX-License-Identifier: MIT
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// contracts/ChainlinkOracle.sol
pragma solidity ^0.6.0;

import "./lib/SafeMath.sol";
import "./Ownable.sol";
import "./interfaces/IOracle.sol";

// ChainLink Aggregator
interface IAggregator {
    function latestRoundData() external view returns (uint80, int256 answer_, uint256, uint256, uint80);
}

contract ChainlinkOracle is Ownable, IOracle {
    using SafeMath for uint256; 

    struct SymbolPair {
        address base;   // The ChainLink price to base by to get rate
        address quote;     // The ChainLink price to quote by to get rate
        uint256 decimals;   // Just pre-calc and store .
        uint256 rate;
    }

    mapping(address => SymbolPair) symbols;

    function set(address pair_, address base_, address quote_, uint256 decimals_) public {
        require(msg.sender == owner, "ChainlinkOracle: not owner");

        // The rate can only be set once. It cannot be changed.
        if (symbols[pair_].decimals == 0) {
            symbols[pair_].base = base_;
            symbols[pair_].quote = quote_;
            symbols[pair_].decimals = decimals_;
        }
    }

    // Get the latest exchange rate and save it.
    function get(address pair_) public override returns (bool, uint256) {
        uint256 price = uint256(1e18);
        SymbolPair storage s = symbols[pair_];
        address base = s.base;
        address quote = s.quote;

        if (base != address(0)) {
            (, int256 priceC,,,) = IAggregator(base).latestRoundData();
            price = price.mul(uint256(priceC));
        } else {
            price = price.mul(1e18);
        }

        if (quote != address(0)) {
            (, int256 priceC,,,) = IAggregator(quote).latestRoundData();
            price = price.div(uint256(priceC));
        }

        if (base != address(0)) {
            price = price.div(1e18);
        }

        price = price.div(s.decimals);
        s.rate = price;
        return (true, price);
    }

    // Check the last exchange rate without any state changes
    function peek(address pair_) public override view returns (uint256) {
        uint256 price = uint256(1e18);
        SymbolPair storage s = symbols[pair_];
        address base = s.base;
        address quote = s.quote;

        if (base != address(0)) {
            (, int256 priceC,,,) = IAggregator(base).latestRoundData();
            price = price.mul(uint256(priceC));
        } else {
            price = price.mul(1e18);
        }

        if (quote != address(0)) {
            (, int256 priceC,,,) = IAggregator(quote).latestRoundData();
            price = price.div(uint256(priceC));
        }

        if (base != address(0)) {
            price = price.div(1e18);
        }

        price = price.div(s.decimals);
        return price;
    }
}