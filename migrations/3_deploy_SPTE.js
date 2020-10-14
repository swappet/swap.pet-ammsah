// migrations/2_deploy_SPTE.js
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// SPDX-License-Identifier: MIT

const SPTE = artifacts.require("SPTE"); 

const ERC20Detail = [
    "Swap.Pet Token of Eggs",   // name
    "SPTE",              // symbol 
    '100000000'              // totalSupply
];
module.exports = function(deployer) {
    deployer.deploy(SPTE,...ERC20Detail);
};