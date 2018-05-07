pragma solidity ^0.4.11;

import './MirailaEnergyBase.sol';

contract MirailaDiamondBase {
    
    mapping (address => uint256) public diamondOf; 
    mapping (address => bool) accessAllowed;

    uint256 public allDiamond = 1200000000*10**18;
    uint256 public leaveDiamond = 840000000*10**18;
    uint256 private headstoneDiamond = 120000000*10**18;
    uint256 private angelDiamond = 120000000*10**18;
    uint256 private mirailaDiamond = 120000000*10**18;
    
    uint256 private currentDiamond = 60000000*10**18;
    uint256 private _leaveDiamond;
    uint256 private poolDiamond;
    uint256 private _start;
    uint256 private _mouth = 1;
    
    
    
    // function init
    function MirailaDiamondBase(address headstone, address angel, address miraila) {
        diamondOf[headstone] = headstoneDiamond;
        diamondOf[angel] = angelDiamond;
        diamondOf[miraila] = mirailaDiamond;
        _start = now;
    }
 
 
    modifier platform() {
        require(accessAllowed[msg.sender] == true);
        _;
    }  
    
    function allowAccess(address _addr) platform public {
        accessAllowed[_addr] = true;
    }
    
    function denyAccess(address _addr) platform public {
        accessAllowed[_addr] = false;
    }
    
    
    function getAlldiamond() returns (uint256){
        return allDiamond;
    }
    
    function getLeavediamond() returns (uint256){
        return leaveDiamond;
    }
    
    // function countLeavediamond(uint256 value) returns (uint256) {
    //     return leaveDiamond -= value;
    // }
    
    function setdiamond(address _address, uint256 _value) platform {
        if (now >= _start + 30 * 1 days && _mouth <=14) { 
            currentDiamond = 60000000*10**18;
            _start = now;
            poolDiamond += _leaveDiamond;
            leaveDiamond -= currentDiamond;
            _mouth += 1;
        }
        if (now >= _start + 30 * 1 days && _mouth > 14){
            currentDiamond = 10000000*10**18;
            _start = now;
            poolDiamond += _leaveDiamond;
            _mouth += 1;
        }
        require(currentDiamond >= _value);
        diamondOf[_address] = _value;
        currentDiamond -= _value;
        _leaveDiamond = currentDiamond;
    }

    
    // function setdiamond(address _address, uint256 _value) public {
    //     require(leaveDiamond >= _value);
    //     diamondOf[_address] = _value;
    //     leaveDiamond -= _value;
    // }

}