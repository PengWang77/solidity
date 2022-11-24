pragma solidity >= 0.7.0 < 0.9.0;

contract MappingContract{

    mapping(address => uint) myMap;

    function get(address _add)public view returns(uint) {
        return myMap[_add];
    }

    function set(address _add, uint _i) public {
        myMap[_add] = _i;
    }

    function remove(address _add) public {
        delete myMap[_add];
    }
}