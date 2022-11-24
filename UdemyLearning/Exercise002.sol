pragma solidity >= 0.7.0 < 0.9.0;

contract Test01 {
    
    function divisorZero(uint a, uint b) public pure returns(uint) {
       return a / b;
    }
    function divideZero2() public view returns(uint) {
        uint c = divisorZero(10,0);
        return c;
    }
}


