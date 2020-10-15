// SPDX-License-Identifier: MIT
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// contracts/lib/SignedSafeMath.sol
pragma solidity ^0.6.0; 

/// @dev Wrappers over arithmetic operations with overflow checks for int256. 
library SignedSafeMath {
    int constant private _INT256_MIN = -2**255;
    function mul(int a_, int b_) internal pure returns (int) { 
        if (a_ == 0 || b_ == 0) {
            return 0;
        }
        require(!(a_ == -1 && b_ == _INT256_MIN), "SignedSafeMath: mul overflow");
        int c_ = a_ * b_;
        require(c_ / a_ == b_, "SignedSafeMath: mul overflow");
        return c_;
    }
    function div(int a_, int b_) internal pure returns (int) {
        require(b_ != 0, "SignedSafeMath: div by zero");
        require(!(b_ == -1 && a_ == _INT256_MIN), "SignedSafeMath: div overflow");
        int c_ = a_ / b_;
        return c_;
    } 
    function sub(int a_, int b_) internal pure returns (int) {
        int c_ = a_ - b_;
        require((b_ >= 0 && c_ <= a_) || (b_ < 0 && c_ > a_), "SignedSafeMath: sub overflow");
        return c_;
    } 
    function add(int a_, int b_) internal pure returns (int) {
        int c_ = a_ + b_;
        require((b_ >= 0 && c_ >= a_) || (b_ < 0 && c_ < a_), "SignedSafeMath: add overflow");
        return c_;
    }
}