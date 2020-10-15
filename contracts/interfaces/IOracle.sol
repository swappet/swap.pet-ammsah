// SPDX-License-Identifier: MIT
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// contracts/interfaces/IOracle.sol
pragma solidity ^0.6.0;

/// @dev Each oracle function left the first parameter to be 'address pair_'
interface IOracle {
    /// @dev  Each oracle should have a set() function. 
    /// Setting should only be allowed ONCE for each pair.
    /// function set(address pair_, address base_, address quote_, uint256 decimals_) public {};

    /// @notice Get the latest exchange rate
    /// @dev if no valid (recent) rate is available, return false
    function get(address pair_) external returns (bool, uint256);

    /// @notice Check the last exchange rate without any state changes
    function peek(address pair_) external view returns (uint256);
}