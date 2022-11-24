pragma solidity >= 0.7.0 < 0.9.0;

contract DestructuringMultiple{
    uint public val = 7;
    string public tom = "Hi";

    function f() public pure returns(uint, bool, string memory) {
        return (1, true, "Goodbye");
    }

    function g() public {
        (val, , tom) = f();
    } 
}  

