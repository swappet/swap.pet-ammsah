// SPDX-License-Identifier: MIT
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// contracts/ChainlinkOracle.sol
pragma solidity ^0.6.0;

// import './interfaces/ISPTERC20.sol';
import './lib/SafeMath.sol';

/// @dev ERC20 of Swap.Pet Tokens(SPTERC20), compatible with OpenZeppelin ERC20
contract SPTERC20{
    using SafeMath for uint;

    // keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");
    bytes32 public constant PERMIT_TYPEHASH = 0x6e71edae12b1b97f4d1f60370fef10105fa2faae0126114a169c64845d6126c9;

    string private _name;
    string private _symbol;
    uint private _totalSupply;
    uint8 private _decimals;
    bytes32 public DOMAIN_SEPARATOR;

    mapping (address => uint) private _balances;
    mapping (address => mapping (address => uint)) private _allowances;
    mapping(address => uint) public nonces;

    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    constructor(string memory name_, string memory symbol_) public {
        uint chainId;
        assembly {
            chainId := chainid()
        }
        _name = name_;
        _symbol = symbol_;
        _decimals = 18; 
        DOMAIN_SEPARATOR = keccak256(
            abi.encode(
                keccak256('EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)'),
                keccak256(bytes(name_)),
                keccak256(bytes('1')),
                chainId,
                address(this)
            )
        );
    }
    function name() public view returns (string memory) {
        return _name;
    }
    function symbol() public view returns (string memory) {
        return _symbol;
    }
    function decimals() public view returns (uint8) {
        return _decimals;
    }
    function totalSupply() public view returns (uint) {
        return _totalSupply;
    }
    function balanceOf(address account_) public view returns (uint) {
        return _balances[account_];
    }
    function transfer(address to_, uint256 amount_) public virtual returns (bool) {
        _transfer(msg.sender, to_, amount_);
        return true;
    }
     function allowance(address owner_, address spender_) public view virtual returns (uint256) {
        return _allowances[owner_][spender_];
    }
    function approve(address spender_, uint256 amount_) public virtual returns (bool) {
        _approve(msg.sender, spender_, amount_);
        return true;
    }
    function transferFrom(address from_, address to_, uint256 amount_) public virtual returns (bool) {
        _transfer(from_, to_, amount_);
        _approve(from_, msg.sender, _allowances[from_][msg.sender].sub(amount_, "SPTERC20: transfer amount exceeds allowance"));
        return true;
    }
    function increaseAllowance(address spender_, uint256 amount_) public virtual returns (bool) {
        _approve(msg.sender, spender_, _allowances[msg.sender][spender_].add(amount_));
        return true;
    }
    function decreaseAllowance(address spender_, uint256 amount_) public virtual returns (bool) {
        _approve(msg.sender, spender_, _allowances[msg.sender][spender_].sub(amount_, "SPTERC20: decreased allowance below zero"));
        return true;
    }
    function _transfer(address from_, address to_, uint256 amount_) internal virtual {
        require(from_ != address(0), "SPTERC20: transfer from the zero address");
        require(to_ != address(0), "SPTERC20: transfer to the zero address");


        _balances[from_] = _balances[from_].sub(amount_, "SPTERC20: transfer amount_ exceeds balance");
        _balances[to_] = _balances[to_].add(amount_);
        emit Transfer(from_, to_, amount_);
    }
    function _mint(address to_, uint256 amount_) internal virtual {
        require(to_ != address(0), "SPTERC20: mint to the zero address");  
        _totalSupply = _totalSupply.add(amount_);
        _balances[to_] = _balances[to_].add(amount_);
        emit Transfer(address(0), to_, amount_);
    }
    function _burn(address from_, uint256 amount_) internal virtual {
        require(from_ != address(0), "SPTERC20: burn from the zero address"); 

        _balances[from_] = _balances[from_].sub(amount_, "SPTERC20: burn amount_ exceeds balance");
        _totalSupply = _totalSupply.sub(amount_);
        emit Transfer(from_, address(0), amount_);
    } 
    function _approve(address owner_, address spender_, uint256 amount_) internal virtual {
        require(owner_ != address(0), "SPTERC20: approve from the zero address");
        require(spender_ != address(0), "SPTERC20: approve to the zero address"); 

        _allowances[owner_][spender_] = amount_;
        emit Approval(owner_, spender_, amount_);
    }
    function _setupDecimals(uint8 decimals_) internal {
        _decimals = decimals_;
    } 

    /// @dev plus function for ERC20 of OpenZeppelin
    function permit(address owner_, address spender_, uint amount_, uint deadline_, uint8 v_, bytes32 r_, bytes32 s_) external {
        require(deadline_ >= block.timestamp, 'SPTERC20: permit expired!');
        bytes32 digest = keccak256(
            abi.encodePacked(
                '\x19\x01',
                DOMAIN_SEPARATOR,
                keccak256(abi.encode(PERMIT_TYPEHASH, owner_, spender_, amount_, nonces[owner_]++, deadline_))
            )
        );
        address recoveredAddress = ecrecover(digest, v_, r_, s_);
        require(recoveredAddress != address(0) && recoveredAddress == owner_, 'SPTERC20: invalid signature!');
        _approve(owner_, spender_, amount_);
    }
}
