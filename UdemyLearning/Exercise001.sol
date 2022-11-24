pragma solidity >= 0.7.0 < 0.9.0;

contract MultiplyCalculator {
    
    function calculator(uint a, uint b) public pure returns(uint) {
        uint abc = a + b;
        return abc;
    }
}

contract FinalExercise {
    uint a = 300; 
    uint b = 12;
    uint f = 47;
    function finalize() public view returns(uint) {
        uint d = 23;
        if ( a >= b && b < f ) {
            return (d *= d) - b;
        } else {
            return 23;
        }
        
    }
}

