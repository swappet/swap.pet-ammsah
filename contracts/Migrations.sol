// SPDX-License-Identifier: MIT
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// contracts/DaoFund.sol
pragma solidity ^0.6.0;

contract Migrations { 
  address public owner;
  uint public last_completed_migration;

  constructor() public {
    owner = msg.sender;
  } 

  modifier onlyOwner() {
    if (msg.sender == owner) _;
  }

  function setCompleted(uint completed_) public onlyOwner {
    last_completed_migration = completed_;
  }

  function upgrade(address newAddress_) public onlyOwner {
    Migrations upgraded = Migrations(newAddress_);
    upgraded.setCompleted(last_completed_migration);
  } 
}