// contracts/SafeNamer.sol
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

/**
 * @dev Interface of the token with name()/symbol().
 */
interface ITokenNamer {
    function name() external view returns (string memory);

    function symbol() external view returns (string memory);
}
// produces token descriptors from inconsistent or absent ERC20 symbol implementations that can return string or bytes32
// this library will always produce a string symbol to represent the token
library SafeNamer {
    
    string private constant _PREFIX = '🐔';
    string private constant _SPLITER = ':';
    string private constant _SEPARATOR = '-';
    string private constant _SUFFIX = '🥚';

    // produces a pair name descriptor in the format of `${prefix}${name0}-${name1}${suffix}`
    function pairName(string memory prefix,address token0, address token1,  string memory suffix) internal view returns (string memory) {
        return string(
            abi.encodePacked(
                bytes(prefix).length == 0?_PREFIX:prefix,
                ITokenNamer(token0).name(),
                _SEPARATOR,
                ITokenNamer(token1).name(),
                bytes(suffix).length == 0 ?_SUFFIX:suffix
            )
        );
    }
    // produces a pair symbol in the format of `${prefix}${name0}-${name1}${suffix}`
    function pairSymbol(string memory prefix,address token0, address token1, string memory suffix) internal view returns (string memory) {
        return string(
            abi.encodePacked(
                bytes(prefix).length == 0?_PREFIX:prefix,
                ITokenNamer(token0).symbol(),
                _SEPARATOR,
                ITokenNamer(token1).symbol(),
                bytes(suffix).length == 0 ?_SUFFIX:suffix
            )
        );
    }
    // produces a mix name descriptor in the format of `${prefix}${name0:...:nameN}-${nameBase}${suffix}`
    function mixName(string memory prefix,address[] memory tokens, address nameBase,  string memory suffix) internal view returns (string memory) {
        require(tokens.length >= 2, 'SafeNamer: INVALID_TOKEN_NUM');
        string memory symMix = ITokenNamer(tokens[0]).name();
        for (uint i=1; i < tokens.length; i++) {
            symMix = string(abi.encodePacked(symMix,_SPLITER,ITokenNamer(tokens[i]).name()));
        }
        return string(
            abi.encodePacked(
                bytes(prefix).length == 0?_PREFIX:prefix,
                symMix,
                _SEPARATOR,
                ITokenNamer(nameBase).name(),
                bytes(suffix).length == 0 ?_SUFFIX:suffix
            )
        );
    }
    // produces a mix symbol in the format of `${prefix}${name0:...:nameN}-${nameBase}${suffix}`
    function mixSymbol(string memory prefix,address[] memory tokens, address nameBase, string memory suffix) internal view returns (string memory) {
        require(tokens.length >= 2, 'SafeNamer: INVALID_TOKEN_NUM');
        string memory symMix = ITokenNamer(tokens[0]).symbol();
        for (uint i=1; i < tokens.length; i++) {
            symMix = string(abi.encodePacked(symMix,_SPLITER,ITokenNamer(tokens[i]).symbol()));
        }
        return string(
            abi.encodePacked(
                bytes(prefix).length == 0?_PREFIX:prefix,
                symMix,
                _SEPARATOR,
                ITokenNamer(nameBase).symbol(),
                bytes(suffix).length == 0 ?_SUFFIX:suffix
            )
        );
    }
}
