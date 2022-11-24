pragma solidity >= 0.7.0 < 0.9.0;

contract Test003 {
    
    string greeting = "Hello";

    function changeGreeting(string memory _change) public {
        greeting = _change;
    }

    function test01(string memory test1) public view returns(uint) {
        string storage test2 = test1;
        string test3;
    }
}



 