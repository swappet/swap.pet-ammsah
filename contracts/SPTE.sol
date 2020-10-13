// contracts/SPTE.sol
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0; 
 
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Snapshot.sol";
import "@openzeppelin/contracts/utils/Address.sol";

/**
 * @dev inherit from the ERC20Snapshot contract for supporting snapshot
 *      inherit from the Ownable contract for make snapshot controll
 */
contract SPTE is ERC20Snapshot, Ownable {
    using SafeMath for uint256; 
    uint256 private value;

    constructor(
        string memory name,  
        string memory symbol, 
        uint256 totalSupply  
    ) public ERC20(name, symbol) {
        _mint(msg.sender, totalSupply * (10**uint256(decimals()))); 
        // _mint(address(this), totalSupply * (10**uint256(decimals())));  
    } 

    // The onlyOwner modifier restricts who can call the snapshot function
    function snapshot() public onlyOwner {
        _snapshot();
    }
}