// const WETH9 = artifacts.require("WETH9");

// // module.exports = async function(deployer) {
// //     const weth = await WETH9.deployed();
// //     // await weth.increase(10);
// // };
// const { scripts, ConfigManager } = require('@openzeppelin/cli');
// const { add, push, create } = scripts;

// async function deploy(options) {
//   add({ contractsData: [{ name: 'PETH', alias: 'PETH' }] });
//   await push(options);
//   await create(Object.assign({ contractAlias: 'PETH' }, options));
// }

// module.exports = function(deployer, networkName, accounts) {
//   deployer.then(async () => {
//     const { network, txParams } = await ConfigManager.initNetworkConfiguration({ network: networkName, from: accounts[0] })
//     const weth = await WETH9.deployed();
//     await deploy({ network, txParams })
//   })
// }