// contracts/DaoFund.sol
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;  

/// @title Fund of Swap.Pet DAO, include assets and settings
/// @notice Manage assets and settings by DAO Governance and Opertator.
/// @dev  Support Allow/Deny list. FOUNDER will shift power to DAO
contract DaoFund { 
    address public weth;
    address public usdt;
    // the orig funder of Swap.Pet DAO, cannot be changed.
    address public founder;
    // Governance is responsible for important decisions of Swap.Pet DAO.
    address public daoGov;
    // Opertator are responsible for routine work of Swap.Pet DAO.
    address public daoOp;
    // white list for contracts of Swap.Pet DAO.
    mapping (address => bool) public allows;
    // black list for contracts of Swap.Pet DAO.
    mapping (address => bool) public denys; 

    // settings of Swap.Pet
    mapping (string => string) public keyvalue;

    constructor(address weth_,address usdt_) public { 
        weth=weth_;
        usdt=usdt_;
        founder = msg.sender;
        daoGov = founder;
        daoOp = founder;
        allows[founder] = true; 
    }  
    modifier onlyDaoGov() {
        require(isDaoGov(msg.sender), "DaoFund: Not daoGov");
        _;
    }
    modifier onlyDaoOp() {
        require(isDaoOp(msg.sender), "DaoFund: Not daoOp");
        _;
    }
    modifier onlyDaoGovOrOp() {
        require(isDaoGov(msg.sender) || isDaoOp(msg.sender) , "DaoFund: Not daoOp or daoGov");
        _;
    }  
    modifier notEmpty(address account_) {
        require(account_ != address(0), "DaoFund: Not be empty");
        _;
    }

    function setDaoGov(address account_) public onlyDaoGov notEmpty(account_){ 
        daoGov = account_;
    }
    function isDaoGov(address account_) public view returns (bool) {
        return account_ == daoGov;
    }
    function setDaoOp(address account_) public onlyDaoGov notEmpty(account_){ 
        daoOp = account_;
    }
    function isDaoOp(address account_) public view returns (bool) {
        return account_ == daoOp;
    } 
    function addAllow(address account_) public onlyDaoGovOrOp notEmpty(account_){ 
        allows[account_] = true; 
    }
    function delAllow(address account_) public onlyDaoGovOrOp notEmpty(account_){ 
        allows[account_] = false; 
    }
    function isAllow(address allow_) public view returns (bool) {
        return allows[allow_];
    }
    function addDeny(address account_) public onlyDaoGovOrOp notEmpty(account_){ 
        denys[account_] = true; 
    }
    function delDeny(address account_) public onlyDaoGovOrOp notEmpty(account_){ 
        denys[account_] = false; 
    }
    function isDeny(address denys_) public view returns (bool) {
        return denys[denys_];
    }

    function addKey(string memory key, string memory value) public onlyDaoGov{
        require(bytes(keyvalue[key]).length == 0);
        keyvalue[key] = value;
    }
    function setKey(string memory key, string memory newValue) public onlyDaoGov{ 
        require(bytes(keyvalue[key]).length != 0, "DaoFund: No the key");
        keyvalue[key] = newValue;
    } 
    function delKey(string memory key) public onlyDaoGov { 
        require(bytes(keyvalue[key]).length != 0, "DaoFund: No the key"); 
        delete keyvalue[key]; 
    } 
    function getKey(string memory key) public view returns (string memory){ 
        require(bytes(keyvalue[key]).length != 0 , "DaoFund: No the key");
        return keyvalue[key];
    } 
}