pragma solidity >= 0.7.0 < 0.9.0;

contract MappingExercise{

    
    mapping(address => mapping(address => uint)) myMovie;

    function addMyMovie(address _addrOwner, address _addrSpender, uint _i) public {
        myMovie[_addrOwner][_addrSpender] = _i;
    }

    function getMyMovie(address _addrOwner, address _addrSpender)public view returns (uint) {
        return myMovie[_addrOwner][_addrSpender];
    }

    function remove(address _addrOwner, address _addrSpender) public {
        delete myMovie[_addrOwner][_addrSpender];
    }

}