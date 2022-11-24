pragma solidity >= 0.7.0 < 0.9.0;

contract ViewPure{
    uint val = 1;

    function multiply() public pure returns(uint) {
        return 3 * 7;
    }

    function valuePlusThree() public view returns(uint) {
        return val + 7;
    } 
}  

