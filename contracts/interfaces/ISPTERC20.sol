// SPDX-License-Identifier: MIT
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// contracts/interfaces/ISPTERC20.sol
pragma solidity ^0.6.0;

/// @dev ERC20 of Swap.Pet Tokens(SPTERC20), compatible with OpenZeppelin ERC20
interface ISPTERC20 {
    event Approval(address indexed owner, address indexed spender, uint amount);
    event Transfer(address indexed from, address indexed to, uint amount);

    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner_) external view returns (uint);
    function allowance(address owner_, address spender_) external view returns (uint);

    function approve(address spender_, uint amount_) external returns (bool);
    function transfer(address to_, uint amount_) external returns (bool);
    function transferFrom(address from_, address to_, uint amount_) external returns (bool);   

    /// @dev plus function for ERC20 of OpenZeppelin
    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner_) external view returns (uint); 
    function permit(address owner_, address spender_, uint amount_, uint deadline_, uint8 v_, bytes32 r_, bytes32 s_) external;
}
