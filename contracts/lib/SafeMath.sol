// contracts/lib/SafeMath.sol
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0; 

/// @dev Wrappers over arithmetic operations with overflow checks for uint256. 
library SafeMath {  
    function max(uint a, uint b) internal pure returns (uint) {
        return a >= b ? a : b;
    } 
    function min(uint a, uint b) internal pure returns (uint) {
        return a < b ? a : b;
    }
    /// @dev Returns the sort of two numbers with(small,big). 
    function twins(uint a, uint b) internal pure returns (uint,uint) {
        return a < b ? (a,b) : (b,a);
    }
    function average(uint a, uint b) internal pure returns (uint) {
        return (a / 2) + (b / 2) + ((a % 2 + b % 2) / 2);
    }
    function add(uint a, uint b) internal pure returns (uint c) {
        require((c = a + b) >= a, 'SafeMath: add overflow');
    }
    function sub(uint a, uint b) internal pure returns (uint) {
        return sub(a, b, "SafeMath: sub overflow");
    }
    function sub(uint a, uint b, string memory errMsg) internal pure returns (uint c) {
        require((c = a - b) <= a, errMsg);
    } 
    function mul(uint a, uint b) internal pure returns (uint c) {
        require((c = b) == 0 || (c = a * b) / b == a, 'SafeMath: mul overflow');
    }
    function div(uint a, uint b) internal pure returns (uint) {
        return div(a, b, "SafeMath: div by zero");
    } 
    function div(uint a, uint b, string memory errMsg) internal pure returns (uint) {
        require(b > 0, errMsg);
        uint c = a / b;
        return c;
    }
    function mod(uint a, uint b) internal pure returns (uint) {
        return mod(a, b, "SafeMath: mod by zero");
    }
    function mod(uint a, uint b, string memory errMsg) internal pure returns (uint) {
        require(b != 0, errMsg);
        return a % b;
    } 
    function sqrt(uint a) internal pure returns (uint b) {
        if (a > 3) {
            b = a;
            uint t = a / 2 + 1;
            while (t < b) {
                b = t;
                t = (a / t + t) / 2;
            }
        } else if (a != 0) {
            b = 1;
        }
    }
}
