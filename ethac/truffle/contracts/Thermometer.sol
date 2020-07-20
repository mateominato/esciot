pragma solidity ^0.5.1;

import "./Device.sol";

contract Thermometer is Device {
    uint256 private temp;
    constructor() public {}
    
    function f1() public isOwner isLock {
        //Do nothing
    }
    
    function f2() public isOwner isLock {
        //Do nothing
    }
    
    function fviewbool1() public view isOwner isLock returns(bool) {
        //Do nothing
    }
    
    function fparamint1(uint256 x) public isOwner isLock {
        //Set temperature
        temp = x;
    }
    
    function fviewint1() public view returns(uint256) {
        //Return state
        return temp;
    }
}