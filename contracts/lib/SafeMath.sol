// SPDX-License-Identifier: MIT
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// contracts/lib/SafeMath.sol
pragma solidity ^0.6.0; 

/// @dev Wrappers over arithmetic operations with overflow checks for uint256. 
library SafeMath {  
    function max(uint a_, uint b_) internal pure returns (uint) {
        return a_ >= b_ ? a_ : b_;
    } 
    function min(uint a_, uint b_) internal pure returns (uint) {
        return a_ < b_ ? a_ : b_;
    }
    /// @dev Returns the sort of two numbers with(small,big). 
    function twins(uint a_, uint b_) internal pure returns (uint[2] memory) {
        return a_ < b_ ? [a_,b_] : [b_,a_];
    }
    function average(uint a_, uint b_) internal pure returns (uint) {
        return (a_ / 2) + (b_ / 2) + ((a_ % 2 + b_ % 2) / 2);
    }
    function add(uint a_, uint b_) internal pure returns (uint c_) {
        require((c_ = a_ + b_) >= a_, 'SafeMath: add overflow');
    }
    function sub(uint a_, uint b_) internal pure returns (uint) {
        return sub(a_, b_, "SafeMath: sub overflow");
    }
    function sub(uint a_, uint b_, string memory errMsg_) internal pure returns (uint c_) {
        require((c_ = a_ - b_) <= a_, errMsg_);
    } 
    function mul(uint a_, uint b_) internal pure returns (uint c_) {
        require(a_ == 0 || b_ == 0 || (c_ = a_ * b_) / b_ == a_, 'SafeMath: mul overflow');
    }
    function div(uint a_, uint b_) internal pure returns (uint) {
        return div(a_, b_, "SafeMath: div by zero");
    } 
    function div(uint a_, uint b_, string memory errMsg_) internal pure returns (uint c_) {
        require( a_ == 0 || (b_ > 0 && ( c_ = a_ / b_ ) >= 0), errMsg_);
    }
    function mod(uint a_, uint b_) internal pure returns (uint) {
        return mod(a_, b_, "SafeMath: mod by zero");
    }
    function mod(uint a_, uint b_, string memory errMsg_) internal pure returns (uint) {
        require(b_ != 0, errMsg_);
        return a_ % b_;
    } 
    function sqrt(uint a_) internal pure returns (uint b_) {
        if (a_ > 3) {
            b_ = a_;
            uint t = a_ / 2 + 1;
            while (t < b_) {
                b_ = t;
                t = (a_ / t + t) / 2;
            }
        } else if (a_ != 0) {
            b_ = 1;
        }
    }
}
