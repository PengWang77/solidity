pragma solidity >= 0.7.0 < 0.9.0;

contract ArrayContract{

    uint[] array1 ;

    function push(uint num1) public {
        array1.push(num1);
    }

    function pop() public {
        array1.pop(); 
    }

    function length() public view returns (uint) {
        return array1.length;
    }
}