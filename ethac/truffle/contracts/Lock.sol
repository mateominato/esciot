pragma solidity ^0.5.1;

import "./Device.sol";

contract Lock is Device {
    bool private locked;
    
    event test_value(bool value1);
    
    constructor() public {
        locked = true;
    }
    
    function f1() public isOwner isLock {
        //Lock doors
        locked = true;
    }
    
    function f2() public isOwner isLock {
        //Unlock doors
        locked = false;
    }
    
    function fviewbool1() public view isOwner isLock returns(bool) {
        //Return state
        return locked;
    }
    
    function fparamint1(uint256 x) public isOwner isLock {
        //Do nothing
    }
    
    function fviewint1() public view returns(uint256) {
        //Do nothing
    }
    
}