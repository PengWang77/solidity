pragma solidity >= 0.7.0 < 0.9.0;

contract Overload{
    
    function x(bool x1)public pure returns(bool) {
        bool x2 = true;
        return x2;

    }
    function x(uint x3)public pure returns(uint ){
        return x3;
    }
    function x1()public pure returns(bool){
        
        bool y = x(true);
        return y;
    }
}  