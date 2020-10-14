// contracts/lib/SignedSafeMath.sol
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0; 

/// @dev Wrappers over arithmetic operations with overflow checks for int256. 
library SignedSafeMath {
    int constant private _INT256_MIN = -2**255;
    function mul(int a, int b) internal pure returns (int) { 
        if (a == 0 || b == 0) {
            return 0;
        }
        require(!(a == -1 && b == _INT256_MIN), "SignedSafeMath: mul overflow");
        int c = a * b;
        require(c / a == b, "SignedSafeMath: mul overflow");
        return c;
    }
    function div(int a, int b) internal pure returns (int) {
        require(b != 0, "SignedSafeMath: div by zero");
        require(!(b == -1 && a == _INT256_MIN), "SignedSafeMath: div overflow");
        int c = a / b;
        return c;
    } 
    function sub(int a, int b) internal pure returns (int) {
        int c = a - b;
        require((b >= 0 && c <= a) || (b < 0 && c > a), "SignedSafeMath: sub overflow");
        return c;
    } 
    function add(int a, int b) internal pure returns (int) {
        int c = a + b;
        require((b >= 0 && c >= a) || (b < 0 && c < a), "SignedSafeMath: add overflow");
        return c;
    }
}
