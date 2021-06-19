const SlabToken = artifacts.require("SlabToken.sol");
const SlabICO = artifacts.require("SlabICO.sol");

module.exports = async function (deployer, network, accounts) {
  const _name = "Slab Token";
  const _symbol = "SLAB";
  const _decimals = 18;
  const _cap = 1000000000; // 100M upper cap
  const _rate = 215700; // $0.01 per token
  const _wallet = accounts[0];
  await deployer.deploy(SlabToken, _name, _symbol, _decimals, _cap);
  const deployedToken = await SlabToken.deployed();
  await deployer.deploy(SlabICO, _rate, _wallet, deployedToken.address);
  return true;
};
