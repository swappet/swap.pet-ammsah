const Storage = artifacts.require("DaoFund");

module.exports = function (deployer) {
  deployer.deploy(DaoFund);
};
