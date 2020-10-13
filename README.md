# swap.pet-ammsah


stake LP(liquidity Provide) token of token pair in AMM-SAH pool for farming((Liquidity Mining))

# LP farming
swap blockchain assets and farming with Automated Market Maker based on Split, Arbitrage and Hedging.

## Split
1. AmountSplit:big amount swap will be split to many small amount.
2. GridSplit:set lp at diffrent grid price(swap rate).

## Arbitrage

## Hedging

# todo
1. WETH9
2. AdvancedWETH
3. pETH


# usage
add in project:`$ npm i swap.pet-lib`

# create
## install LTS Node with nvm
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
$ mkdir ~/ammsah
$ cd ~/ammsah
$ npx npm init
$ npx npm install
```

## init project with truffle and ganache-cli
```
$ npm i -g truffle
$ npm i -g ganache-cli
$ cd ~/ammsah
$ npx truffle init
// open new terminal
$ npx ganache-cli --deterministic
```

edit `truffle-config.js`:
```
module.exports = {
  networks: {
    development: {
     host: "127.0.0.1",     // Localhost (default: none)
     port: 8545,            // Standard Ethereum port (default: none)
     network_id: "*",       // Any network (default: none)
    },
  }, 
  compilers: {
    solc: {
      // version: "0.5.1",    // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      settings: {          // See the solidity docs for advice about optimization and evmVersion
       optimizer: {
         enabled: true,
         runs: 200
       },
       // evmVersion: "byzantium"  // default:istanbul
      }
    },
  },
};
```

edit `.gitignore`:
```
# truffle 
.secret
```

edit `.secret`:
```
$ cp .secret.sample .secret
$ vi .secret
```

## init project with openzeppelin CLI
```
<!-- $ npm install --save-dev @openzeppelin/cli -->
$ npm install -g @openzeppelin/cli
$ npx openzeppelin --version
2.8.2
OR 
$ npx oz --version 
$ npx oz accounts
$ npx oz balance
$ npx oz init
$ npx npm install @openzeppelin/contracts
```

edit `.gitignore`:
```
# openzeppelin
.openzeppelin/.session
.openzeppelin/dev-*.json
.openzeppelin/unknown-*.json
build/
```

## Automated Smart Contract Tests
edit sol file in dir of `contracts`

add test file `test/SafeNamer.js`
```
```

add test tool:
```
$ npm i --save-dev @openzeppelin/test-helpers @openzeppelin/test-environment mocha chai 
$ npm i @truffle/debug-utils 
```

edit 'package.json':
```
"scripts": {
  "test": "oz compile && mocha --exit --recursive"
}
```

run oz test:
```
$ npm test
or
$ npm run test
<!-- cause Mocha to stop immediately on the first failing test -->
$ npm test -- --bail
```
