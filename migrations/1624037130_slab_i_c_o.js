const SlabToken = artifacts.require("./SlabToken.sol");
const SlabICO = artifacts.require("./SlabICO.sol");

module.exports = async function (deployer, network, accounts) {
  const _name = "Slab Token";
  const _symbol = "SLAB";
  const _decimals = 18;
  const _rate = 215700;
  const _goal = 100000000000000000000000000;
  const _wallet = accounts[0];
  await deployer.deploy(SlabToken, _name, _symbol, _decimals);
  const deployedToken = SlabToken.deployed();
  await deployer.deploy(SlabICO, _rate, _wallet,  _goal);
};
