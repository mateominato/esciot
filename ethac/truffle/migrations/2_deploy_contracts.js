var Device = artifacts.require("./Device.sol");
var Lock = artifacts.require("./Lock.sol");
var Light = artifacts.require("./Light.sol");
var Thermo = artifacts.require("./Thermometer.sol");
var Authority = artifacts.require("./Authority.sol");

module.exports = function(deployer) {
	deployer.deploy(Authority);
	//deployer.deploy(Device);
	//deployer.deploy(Lock);
	//deployer.deploy(Light);
	//deployer.deploy(Thermo);
};