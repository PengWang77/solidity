pragma solidity >= 0.7.0 < 0.9.0;

contract RemoveContract{

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

    function removeValue(uint i) public {
        array1[i] = array1[array1.length - 1];
        array1.pop();
    }

    function addValues() public {
        for (uint i = 1; i <= 4; i++) {
            array1.push(i);
        }
    }

    function getArray1() public view returns (uint[] memory) {
        return array1;
    }
}