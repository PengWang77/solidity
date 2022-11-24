pragma solidity ^0.8.4;


function withdrawFunds(uint amount) public returns(bool success) {
    require(balance[msg.sender] >= amount); // guards upfront
    balance[msg.sender] -= amount; // optomistic accounting 
    msg.sender.transfer(amount); // transfer 
    return true;
}

