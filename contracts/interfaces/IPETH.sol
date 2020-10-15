// SPDX-License-Identifier: MIT
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// Copyright (C) 2020, 2021, 2022 Swap.Pet

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

pragma solidity >=0.4.0;

/// @title Pegging WETH Interface of Swap.Pet
/// @author Swap.Pet
/// @notice Unlocks additional features for Wrapped Ether/WETH to interact with 
///     contracts that use WETH transparently as ETH. Approve this contract 
///     to spend  WETH to use.
/// @dev The assumption is that user wants to use ETH and avoid unnecessary
///     approvals, but ERC20 is required to interact with many protocols. 
///     This contract enables user to interact with protocols consuming ERC20 
///     without additional approvals.
interface IPETH {
    /// @notice Returns the WETH contract that this PETH contract uses.
    /// @dev Returns the WETH contract that this PETH contract uses.
    /// @return the WETH contract used by this contract.
    function weth() external view returns (address payable);

    /// @notice Deposits ETH sent to the contract, and transfers additional WETH from the caller,
    ///     and then approves and calls another contract `to` with data `data`.
    /// @dev Use this method to spend a combination of ETH and WETH as WETH. Refunds any unspent WETH to the caller as
    ///     ETH. Note that either `amount`(ETH) or `msg.value`(WETH) may be 0, but not both.
    /// @param amount The amount to transfer from the caller to this contract and approve for the `to` address, or 0.
    /// @param to The address to approve and call after minting PETH
    /// @param data The data to forward to the contract after minting PETH
    function depositAndTransferFromThenCall(uint amount, address to, bytes calldata data) external payable;

    /// @notice Unwrap and forward all WETH held by the contract to the given address. This should never be called
    ///     directly, but rather as a callback from a contract call that results in sending WETH to this contract.
    /// @dev Use this method as a callback from other contracts to unwrap WETH before forwarding to the user.
    /// @param to The address that should receive the unwrapped ETH.
    function withdrawTo(address payable to) external;
}
