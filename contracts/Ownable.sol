// SPDX-License-Identifier: MIT
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// contracts/lib/SafeMath.sol
pragma solidity ^0.6.0; 

contract Ownable {
    address public owner;
    event SetOwner(address indexed old_, address indexed new_);

    constructor () internal {
        owner = msg.sender;
        emit SetOwner(address(0), msg.sender);
    }

    function renounceOwnership() public virtual {
        require(owner == msg.sender, "Ownable: Not the owner");
        emit SetOwner(owner, address(0));
        owner = address(0);
    }

    function setOwner(address owner_) public virtual {
        require(owner == msg.sender, "Ownable: Not the owner");
        require(owner_ != address(0), "Ownable: Not be zero address");
        emit SetOwner(owner, owner_);
        owner = owner_;
    }
}