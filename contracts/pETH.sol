// SPDX-License-Identifier: MIT
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// contracts/pETH.sol
// pragma solidity ^0.6.0;

// // Import base Initializable contract
// // import "@openzeppelin/upgrades/contracts/Initializable.sol";

// // Import the IERC20 interface and and SafeMath library
// import "@openzeppelin/contracts-ethereum-package/contracts/access/AccessControl.sol";
// import "@openzeppelin/contracts-ethereum-package/contracts/GSN/Context.sol";
// import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/ERC20.sol";
// import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/ERC20Burnable.sol";
// import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/ERC20Pausable.sol";
// import "@openzeppelin/contracts-ethereum-package/contracts/Initializable.sol";
// import "./interfaces/IWETH9.sol";
// import "./interfaces/IPETH.sol";
// /**
//  * @dev {ERC20} token, including:
//  *
//  *  - ability for holders to burn (destroy) their tokens
//  *  - a minter role that allows for token minting (creation)
//  *  - a pauser role that allows to stop all token transfers
//  *
//  * This contract uses {AccessControl} to lock permissioned functions using the
//  * different roles - head to its documentation for details.
//  *
//  * The account that deploys the contract will be granted the minter and pauser
//  * roles, as well as the default admin role, which will let it grant both minter
//  * and pauser roles to aother accounts
//  */
// contract pETH is Initializable, ContextUpgradeSafe, AccessControlUpgradeSafe, ERC20BurnableUpgradeSafe, ERC20PausableUpgradeSafe,IPETH{
//     using SafeMath for uint256;
//     // using SafeMath8 for uint8;
//     // Contract state: exchange rate and token
//     string public name     = "Pegged ETH/WETH";
//     string public symbol   = "pETH";
//     uint8  public decimals = 18;
//     bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
//     bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
//     uint256 public rate; // rate/1000

//     // WETH contact address:
//     // mainnet: 0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2
//     // Kovan: 0xd0a1e359811322d97991e03f863a0c30c2cf029c
//     // Ropsten: 0xc778417e063141139fce010982780140aa0cd5ab
//     // Rinkeby: 0xc778417e063141139fce010982780140aa0cd5ab
//     // goerli: 0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6
//     // ganache: deploy local with WETH9.sol
//     address payable public override immutable weth;

//     event  Approval(address indexed src, address indexed guy, uint wad);
//     event  Transfer(address indexed src, address indexed dst, uint wad);
//     event  Deposit(address indexed dst, uint wad);
//     event  Withdrawal(address indexed src, uint wad);

//     mapping (address => uint)                       public  balanceOf;
//     mapping (address => mapping (address => uint))  public  allowance;

//     /**
//     // Initializer function (replaces constructor)
//      * @dev Grants `DEFAULT_ADMIN_ROLE`, `MINTER_ROLE` and `PAUSER_ROLE` to the
//      * account that deploys the contract.
//      *
//      * See {ERC20-constructor}.
//      */

//     function initialize(address payable weth_, uint256 _rate) public {
//         rate = _rate;
//         weth = weth_;
//         __ERC20PresetMinterPauser_init(name, symbol);
//     }

//     // ================= pETH:ETH start =====================
//     // direct transfer ETH into this contact to get PETH 
//     function() public payable {
//         deposit();
//     }

//     function deposit() public payable {
//         balanceOf[_msgSender()] = balanceOf[_msgSender()].add(msg.value);
//         Deposit(_msgSender(), msg.value);
//     }

//     // get back ETH with PETH 
//     function withdraw(uint wad) public {
//         balanceOf[_msgSender()] = balanceOf[_msgSender()].sub(wad);
//         _msgSender().transfer(wad); 
//         Withdrawal(_msgSender(), wad);
//     }

//     function totalSupply() public view returns (uint) {
//         return this.balance; // ETH:pETH=1:1 and WETH auto convert to ETH/pETH
//     }

//     function approve(address guy, uint wad) public returns (bool) {
//         allowance[_msgSender()][guy] = wad;
//         Approval(_msgSender(), guy, wad);
//         return true;
//     }

//     function transfer(address dst, uint wad) public returns (bool) {
//         return transferFrom(_msgSender(), dst, wad);
//     }

//     function transferFrom(address src, address dst, uint wad)
//         public
//         returns (bool)
//     {
//         require(balanceOf[src] >= wad);

//         if (src != _msgSender() && allowance[src][_msgSender()] != uint(-1)) {
//             allowance[src][_msgSender()] = allowance[src][_msgSender()].sub(wad);
//         }

//         balanceOf[src] = balanceOf[src].sub(wad);
//         balanceOf[dst] = balanceOf[dst].add(wad);

//         Transfer(src, dst, wad);

//         return true;
//     }
//     // ================= pETH:ETH end =====================
    

//     function __ERC20PresetMinterPauser_init(string memory name, string memory symbol) internal initializer {
//         __Context_init_unchained();
//         __AccessControl_init_unchained();
//         __ERC20_init_unchained(name, symbol);
//         __ERC20Burnable_init_unchained();
//         __Pausable_init_unchained();
//         __ERC20Pausable_init_unchained();
//         __ERC20PresetMinterPauser_init_unchained(name, symbol);
//     }

//     function __ERC20PresetMinterPauser_init_unchained(string memory name, string memory symbol) internal initializer {


//         _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());

//         _setupRole(MINTER_ROLE, _msgSender());
//         _setupRole(PAUSER_ROLE, _msgSender());

//     }

//     /**
//      * @dev Creates `amount` new tokens for `to`.
//      *
//      * See {ERC20-_mint}.
//      *
//      * Requirements:
//      *
//      * - the caller must have the `MINTER_ROLE`.
//      */
//     function mint(address to, uint256 amount) public {
//         require(hasRole(MINTER_ROLE, _msgSender()), "pETH: must have minter role to mint");
//         _mint(to, amount);
//     }

//     /**
//      * @dev Pauses all token transfers.
//      *
//      * See {ERC20Pausable} and {Pausable-_pause}.
//      *
//      * Requirements:
//      *
//      * - the caller must have the `PAUSER_ROLE`.
//      */
//     function pause() public {
//         require(hasRole(PAUSER_ROLE, _msgSender()), "pETH: must have pauser role to pause");
//         _pause();
//     }

//     /**
//      * @dev Unpauses all token transfers.
//      *
//      * See {ERC20Pausable} and {Pausable-_unpause}.
//      *
//      * Requirements:
//      *
//      * - the caller must have the `PAUSER_ROLE`.
//      */
//     function unpause() public {
//         require(hasRole(PAUSER_ROLE, _msgSender()), "pETH: must have pauser role to unpause");
//         _unpause();
//     }

//     function _beforeTokenTransfer(address from, address to, uint256 amount) internal override(ERC20UpgradeSafe, ERC20PausableUpgradeSafe) {
//         super._beforeTokenTransfer(from, to, amount);
//     }

//     // See interface for documentation.
//     function depositAndTransferFromThenCall(uint amount, address to, bytes calldata data) external override payable {
//         if (msg.value > 0) {
//             IWETH9(weth).deposit{value: msg.value}();
//         }
//         if (amount > 0) {
//             IWETH9(weth).transferFrom(msg.sender, address(this), amount);
//         }
//         uint total = msg.value + amount;
//         require(total >= msg.value, 'OVERFLOW'); // nobody should be this rich.
//         require(total > 0, 'ZERO_INPUTS');
//         IWETH9(weth).approve(to, total);
//         (bool success,) = to.call(data);
//         require(success, 'TO_CALL_FAILED');
//         // unwrap and refund any unspent WETH.
//         withdrawTo(msg.sender);
//     }

//     // See interface for documentation.
//     function withdrawTo(address payable to) public override {
//         uint wethBalance = IWETH9(weth).balanceOf(address(this));
//         if (wethBalance > 0) {
//             IWETH9(weth).withdraw(wethBalance);
//             (bool success,) = to.call{value: wethBalance}('');
//             require(success, 'WITHDRAW_TO_CALL_FAILED');
//         }
//     }

//     // Only the WETH contract may send ETH via a call to withdraw.
//     receive() payable external { require(msg.sender == weth, 'WETH_ONLY'); }

//     // Send tokens back to the sender using predefined exchange rate
//     receive() external payable {
//         // token.transfer(_msgSender(), msg.value);
//         uint256 tokens = msg.value.mul(rate).div(1000);
//         // require((msg.value<2e17), "pETH: must more than 0.2 ETH/WETH");
//         _mint(_msgSender(), tokens);
//     }

//     uint256[50] private __gap;
// }
