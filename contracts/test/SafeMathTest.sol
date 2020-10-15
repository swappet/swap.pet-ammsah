// contracts/test/SafeMathTest.sol
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0; 

import '../lib/SafeMath.sol';

/// @dev contract using SafeMath library
contract SafeMathTest {
    using SafeMath for uint256;
    using SafeMath for uint;
    function max(uint a_, uint b_) public pure returns (uint) {
        return a_.max(b_);
    } 
    function min(uint a_, uint b_) public pure returns (uint) {
        return a_.min(b_);
    } 
    function twins(uint a_, uint b_) public pure returns (uint[2] memory) {
        return a_.twins(b_);
    }
    function average(uint a_, uint b_) public pure returns (uint) {
        return a_.average(b_);
    }
    function add(uint a_, uint b_) public pure returns (uint) { 
        return a_.add(b_);
    }
    function sub(uint a_, uint b_) public pure returns (uint) {
        return a_.sub(b_);
    }
    function mul(uint a_, uint b_) public pure returns (uint) {
        return a_.mul(b_);
    }
    function div(uint a_, uint b_) public pure returns (uint) {
        return a_.div(b_);
    }  
    function mod(uint a_, uint b_) public pure returns (uint) {
        return a_.mod(b_);
    } 
    function sqrt(uint a_) public pure returns (uint) {
        return a_.sqrt();
    }
}