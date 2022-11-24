pragma solidity >= 0.7.0 < 0.9.0;

contract A {
    uint innerVal = 100;

    function innerAddTen(uint val) public pure returns(uint) {
        return val + 10;
    }

}

contract B is A {
   
   function outerAddTen(uint val) public pure returns(uint) {
       return innerAddTen(val);
   }

   function getInnerVal() public view returns(uint) {
       return innerVal;
   }
}