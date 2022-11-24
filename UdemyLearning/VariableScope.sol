pragma solidity >= 0.7.0 < 0.9.0;

contract C {
    uint  data = 10;
    uint public test;

    function x() private pure returns(uint)  {
        uint data1 = 11;
        return data1;
    }

    function y() public pure returns(uint) {
        return x();
    }
    
}
