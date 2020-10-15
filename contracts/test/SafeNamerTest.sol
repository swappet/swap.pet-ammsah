// SPDX-License-Identifier: MIT
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// contracts/test/SafeNamerTest.sol
pragma solidity ^0.6.0; 

import '../lib/SafeNamer.sol';

/// @dev contract using SafeNamer library
contract PairNamerTest {
    function pairName(string calldata prefix_, address token0_, address token1_, string calldata suffix_) external view returns (string memory) {
        return SafeNamer.pairName(prefix_, token0_, token1_, suffix_);
    }

    function pairSymbol(string calldata prefix_, address token0_, address token1_, string calldata suffix_) external view returns (string memory) {
        return SafeNamer.pairSymbol(prefix_, token0_, token1_, suffix_);
    }
}

contract MixNamerTest {
    function mixName(string calldata prefix_, address[] memory tokens, address tokenBase, string calldata suffix_) external view returns (string memory) {
        return SafeNamer.mixName(prefix_,tokens, tokenBase,  suffix_);
    }

    function mixSymbol(string calldata prefix_, address[] memory tokens, address tokenBase, string calldata suffix_) external view returns (string memory) {
        return SafeNamer.mixSymbol(prefix_,tokens, tokenBase, suffix_);
    }
}

/// @dev test token with name()/symbol()
contract FakeToken {
    string public name;
    string public symbol;
    constructor(string memory name_, string memory symbol_) public {
        name = name_;
        symbol = symbol_;
    }
}

