pragma solidity ^0.5.1;

import "./Device.sol";
import "./Lock.sol";
import "./Light.sol";
import "./Thermometer.sol";

contract Authority {
	address owner;

	enum Authorization { Admin, Write, Read, None }

	struct User {
		address userAddr;
		Authorization auth;
		bool isOwner;
		bool isValue;
	}
	
	mapping(address => User) users;
	mapping(string => address) devNames;
	
	struct DeviceFrame {
	    Device device;
	    string dname;
	    bool isValue;
	}
	
	mapping(address => DeviceFrame) devices;

	constructor() public {
		owner = msg.sender;
		users[msg.sender] = User(msg.sender, Authorization.Admin, true, true);
	}

	modifier onlyAdmin() {
		require(users[msg.sender].isValue == true && users[msg.sender].auth == Authorization.Admin, testAuth());
		_;
	}
	
	modifier writeOrHigher() {
	    require(users[msg.sender].isValue == true && ((users[msg.sender].auth == Authorization.Admin) || (users[msg.sender].auth == Authorization.Write)), testAuth());
	    _;
	}
	
	modifier readOrHigher() {
	    require(users[msg.sender].isValue == true && users[msg.sender].auth != Authorization.None, testAuth());
	    _;
	}
	
	modifier deviceExists(string memory dname) {
	    require(devices[getDeviceByName(dname)].isValue == true, "This device does not exist.");
        _;
	}
	
	function addDevice(string memory dname, Device.DeviceType dtype) public onlyAdmin {
	    require(devices[getDeviceByName(dname)].isValue == false, "This device exists; please choose a new name");
	    Device newDevice;
	    if (dtype == Device.DeviceType.Lock) {
	        newDevice = new Lock();
	    } else if (dtype == Device.DeviceType.Light) {
	        newDevice = new Light();
	    } else if (dtype == Device.DeviceType.Thermometer) {
	        newDevice = new Thermometer();
	    }
	    address devAddr = newDevice.returnAddr();
	    devices[devAddr] = DeviceFrame(Device(newDevice), dname, true);
	    devices[devAddr].device.changeDeviceType(dtype);
	    devNames[dname] = devAddr;
	}
	
	function getDeviceByName(string memory dname) private view onlyAdmin returns(address) {
	    return devNames[dname];
	}

	function addUser(address newUser) public onlyAdmin {
	    users[newUser] = User(newUser, Authorization.Admin, true, true);
	}
	
	function testAuth() public view returns(string memory) {
	    if (users[msg.sender].isValue == true) {
	        if (users[msg.sender].auth == Authorization.Admin) {
	            return "User has admin access.";
	        } else if (users[msg.sender].auth == Authorization.Write) {
	            return "User has read/write permissions only.";
	        } else if (users[msg.sender].auth == Authorization.Read) {
	            return "User has read permissions only.";
	        }
	        return "User is recognized, but has no permissions.";
	    }
	    return "User is not recognized.";
	}
	
	function deviceTypeCheck(string memory dname) public view deviceExists(dname) returns(Device.DeviceType) {
	    return devices[getDeviceByName(dname)].device.returnDeviceType();
	}
	
	//Lock functions
	function lockDoors(string memory dname) public writeOrHigher deviceExists(dname) {
	    devices[getDeviceByName(dname)].device.f1();
	}
	function unlockDoors(string memory dname) public writeOrHigher deviceExists(dname) {
	    devices[getDeviceByName(dname)].device.f2();
	}
    function doorState(string memory dname) public view readOrHigher deviceExists(dname) returns(bool) {
        return devices[getDeviceByName(dname)].device.fviewbool1();
    }
    
    //Light functions
    function turnOnLights(string memory dname) public writeOrHigher deviceExists(dname) {
        devices[getDeviceByName(dname)].device.f1();
    }
    function turnOffLights(string memory dname) public writeOrHigher deviceExists(dname) {
        devices[getDeviceByName(dname)].device.f2();
    }
    function lightState(string memory dname) public view readOrHigher deviceExists(dname) returns(bool) {
        return devices[getDeviceByName(dname)].device.fviewbool1();
    }
    
    //Thermo functions
    function setTemperature(string memory dname, uint256 x) public writeOrHigher deviceExists(dname) {
        devices[getDeviceByName(dname)].device.fparamint1(x);
    }
    function thermoState(string memory dname) public view readOrHigher deviceExists(dname) returns(uint256) {
        return devices[getDeviceByName(dname)].device.fviewint1();
    }
}