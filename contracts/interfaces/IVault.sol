// SPDX-License-Identifier: MIT
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// contracts/interfaces/IVault.sol
pragma solidity ^0.6.0;

interface IVault {
    /// @dev for swapper pair 
    function pairs(address pair_) external returns (bool);

    function transfer(address token_, address to_, uint256 amount_) external returns (bool);
    function transferFrom(address token_, address from_, uint256 amount_) external returns (bool);
}