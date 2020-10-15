// SPDX-License-Identifier: MIT
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// contracts/test/ERC20Test.sol
pragma solidity ^0.6.0; 

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract ERC20Test is ERC20 {
    constructor(
        string memory name_,
        string memory symbol_,
        uint256 supply_
    ) public ERC20(name_, symbol_) {
        _mint(msg.sender, supply_);
    }
}