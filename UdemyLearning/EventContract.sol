pragma solidity >= 0.7.0 < 0.9.0;

contract Event{
    event Log(address indexed sender, string message);
    event AnotherLog();

    function fireEvent()public {
        emit Log(msg.sender, "EVM");
        emit Log(msg.sender, "damn it");
        emit AnotherLog();
    }
}  

