# swap.pet-ammsah


stake LP(liquidity Provide) token of token pair in AMM-SAH pool for farming((Liquidity Mining))

# LP farming
swap blockchain assets and farming with Automated Market Maker based on Split, Arbitrage and Hedging.

## init project with truffle and openzeppelin 
### install LTS Node with nvm
```
$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash
$ source ~/.bash_profile
$ command -v nvm 
$ nvm -v                
0.36.0
$ nvm ls-remote 
<!-- $ nvm install node # "node" is an alias for the latest version(--lts) -->
$ nvm install --lts
$ node --version
v12.18.4
$ npm -v
6.14.6
$ npx -v
6.14.6
$ nvm reinstall-packages
```

### truffle and ganache-cli
```
$ npm i -g truffle
$ npm i -g ganache-cli
$ mkdir ammsah
$ cd ammsah
$ npm init
$ npm install
$ truffle init
```

### openzeppelin CLI 
init ammsah project with openzeppelin CLI：
```
<!-- $ npm install --save-dev @openzeppelin/cli -->
$ npm install @openzeppelin/cli
$ npx openzeppelin init
OR
$ npx oz init
```

### use openzeppelin CEP for upgradeable
replace `@openzeppelin/contracts` with `@openzeppelin/contracts-ethereum-package` for upgradeable:
`$ npx oz link @openzeppelin/contracts-ethereum-package`
**Note**: Do not use 'selfdestruct' or 'delegatecall' in upgradeable contracts,and Do NOT change the order in which the contract state variables are declared, nor their type. 

## deploy in test
open anothrer terminal:
`$ npx ganache-cli --deterministic`
deploy PETH as ERC20: 
```
$ npx oz deploy
No contracts found to compile.
? Choose the kind of deployment upgradeable
? Pick a network development
? Pick a contract to deploy @openzeppelin/contracts-ethereum-package/ERC20PresetMinterPauserUpgradeSafe
✓ Deploying @openzeppelin/contracts-ethereum-package dependency to network dev-1601800815305
All implementations are up to date
? Call a function to initialize the instance after creating it? Yes
? Select which function initialize(name: string, symbol: string)
? name: string: Swap.Pet pegging ETH/WETH
? symbol: string: pETH
✓ Setting everything up to create contract instances
✓ Instance created at 0x59d3631c86BbE35EF041872d502F218A39FBa150
To upgrade this instance run 'oz upgrade'
0x59d3631c86BbE35EF041872d502F218A39FBa150
```
install OpenZeppelin Upgrades:
`$ npm install @openzeppelin/upgrades`