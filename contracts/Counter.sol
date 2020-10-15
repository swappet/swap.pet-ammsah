// SPDX-License-Identifier: MIT
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// contracts/Counter.sol
pragma solidity >=0.4.22 <0.8.0;

contract Counter {
    uint256 public value;

    // function increase() public {
    //   value++;
    // }
      function increase(uint256 amount) public {
        value += amount;
      }
}