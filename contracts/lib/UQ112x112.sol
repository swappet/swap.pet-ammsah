// SPDX-License-Identifier: MIT
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// contracts/lib/UQ112x112.sol 
pragma solidity ^0.6.0; 

// a library for handling binary fixed point numbers (https://en.wikipedia.org/wiki/Q_(number_format))

// range: [0, 2**112 - 1]
// resolution: 1 / 2**112

library UQ112x112 {
    uint224 constant Q112 = 2**112;

    // encode a uint112 as a UQ112x112
    function encode(uint112 y_) internal pure returns (uint224 z_) {
        z_ = uint224(y_) * Q112; // never overflows
    }

    // divide a UQ112x112 by a uint112, returning a UQ112x112
    function uqdiv(uint224 x_, uint112 y_) internal pure returns (uint224 z_) {
        z_ = x_ / uint224(y_);
    }
}