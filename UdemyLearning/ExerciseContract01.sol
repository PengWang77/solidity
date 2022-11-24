pragma solidity >= 0.7.0 < 0.9.0;

contract TestContract {
    //state 默认internal
   string name = "aaa";
   uint  age = 1;

   constructor( string memory _name, uint _age) public {
        name = _name;
        age = _age;
   }

}

abstract contract TestContract2 is TestContract//("jack", 20) //01硬编码的形式 使用结构体
{
    //02动态输入
    //constructor (string memory _n, uint _a)TestContract(_n, _a) public {}

    function getName() public view returns(string memory) {
       return name;
    }
}
    




 