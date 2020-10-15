// SPDX-License-Identifier: MIT
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// contracts/lib/SafeNamer.sol
pragma solidity ^0.6.0;

/// @dev Interface of the token with name()/symbol(). 
interface ITokenNamer {
    function name() external view returns (string memory);

    function symbol() external view returns (string memory);
}

/// @dev this library produce a string symbol to represent pair/mix token
library SafeNamer {
    
    string private constant _PREFIX = '🐔';
    string private constant _SPLITER = ':';
    string private constant _SEPARATOR = '-';
    string private constant _SUFFIX = '🥚';

    /// @notice produce pair name:`${prefix}${token0}-${token1}${suffix}`
    function pairName(string memory prefix_,address token0_, address token1_,  string memory suffix_) internal view returns (string memory) {
        return string(
            abi.encodePacked(
                bytes(prefix_).length == 0?_PREFIX:prefix_,
                ITokenNamer(token0_).name(),
                _SEPARATOR,
                ITokenNamer(token1_).name(),
                bytes(suffix_).length == 0 ?_SUFFIX:suffix_
            )
        );
    }
    /// @notice produce pair symbol:`${prefix}${token0}-${token1}${suffix}`
    function pairSymbol(string memory prefix_,address token0_, address token1_, string memory suffix_) internal view returns (string memory) {
        return string(
            abi.encodePacked(
                bytes(prefix_).length == 0?_PREFIX:prefix_,
                ITokenNamer(token0_).symbol(),
                _SEPARATOR,
                ITokenNamer(token1_).symbol(),
                bytes(suffix_).length == 0 ?_SUFFIX:suffix_
            )
        );
    }
    /// @notice produce mix name:`${prefix}${token0:...:N}-${tokenBase}${suffix}`
    function mixName(string memory prefix_,address[] memory tokens_, address tokenBase_,  string memory suffix_) internal view returns (string memory) {
        require(tokens_.length > 1 && tokens_.length < 9, 'SafeNamer: token num err');
        string memory symMix = ITokenNamer(tokens_[0]).name();
        for (uint i=1; i < tokens_.length; i++) {
            symMix = string(abi.encodePacked(symMix,_SPLITER,ITokenNamer(tokens_[i]).name()));
        }
        return string(
            abi.encodePacked(
                bytes(prefix_).length == 0?_PREFIX:prefix_,
                symMix,
                _SEPARATOR,
                ITokenNamer(tokenBase_).name(),
                bytes(suffix_).length == 0 ?_SUFFIX:suffix_
            )
        );
    }
    /// @notice produce mix symbol:`${prefix}${token0:...:N}-${tokenBase}${suffix}`
    function mixSymbol(string memory prefix_,address[] memory tokens_, address tokenBase_, string memory suffix_) internal view returns (string memory) {
        require(tokens_.length > 1 && tokens_.length < 9, 'SafeNamer: token num err');
        string memory symMix = ITokenNamer(tokens_[0]).symbol();
        for (uint i=1; i < tokens_.length; i++) {
            symMix = string(abi.encodePacked(symMix,_SPLITER,ITokenNamer(tokens_[i]).symbol()));
        }
        return string(
            abi.encodePacked(
                bytes(prefix_).length == 0?_PREFIX:prefix_,
                symMix,
                _SEPARATOR,
                ITokenNamer(tokenBase_).symbol(),
                bytes(suffix_).length == 0 ?_SUFFIX:suffix_
            )
        );
    }
}
