pragma solidity ^0.5.1;

contract Device {
    address private authority; //treat the authority as the owner
    
    enum DeviceType { Lock, Light, Thermometer }
    
    DeviceType dtype;
    
    constructor() public {
        authority = msg.sender;
    }
    
    //modifier to check if caller is owner
    modifier isOwner() {
        require(msg.sender == authority, "Caller is not owner");
        _;
    }
    
    modifier isLock() {
        require(dtype == DeviceType.Lock, "This device is not a lock.");
        _;
    }
    
    modifier isLight() {
        require(dtype == DeviceType.Light, "This device is not a light.");
        _;
    }
    
    modifier isThermo() {
        require(dtype == DeviceType.Thermometer, "This device is not a thermometer.");
        _;
    }
    
    function returnAddr() public view isOwner returns(address) {
        return address(this);
    }
    
    function changeDeviceType(DeviceType x) public isOwner {
        dtype = x;
    }
    
    function returnDeviceType() view public isOwner returns(DeviceType) {
        return dtype;
    }
    
    function auth() public view returns(address) {
        return authority;
    }
    
    function f1() public;
    function f2() public;
    function fparamint1(uint256 x) public;
    function fviewbool1() public view returns(bool);
    function fviewint1() public view returns(uint256);
}