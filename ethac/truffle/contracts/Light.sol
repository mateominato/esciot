pragma solidity ^0.5.1;

import "./Device.sol";

contract Light is Device {
    bool private on;
    constructor() public {}
    
    function f1() public isOwner isLock {
        //turnOnLights
        on = true;
    }
    
    function f2() public isOwner isLock {
        //turnOffLights
        on = false;
    }
    
    function fviewbool1() public view isOwner isLock returns(bool) {
        //return light state
        return on;
    }
    
    function fparamint1(uint256 x) public isOwner isLock {
        //Do nothing
    }
    
    function fviewint1() public view returns(uint256) {
        //Do nothing
    }
}