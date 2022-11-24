pragma solidity >= 0.7.0 < 0.9.0;

contract C {
    uint private data = 1; 
    uint public info;

    constructor () {
        info = 10;
    }

    function increment(uint a ) private pure returns (uint) { return a + 1; }
    function updateData(uint a ) public { data = a; } 
    function getData() public view returns (uint) { return data;}//访问不了隐私变量data 但是可以通过公共函数调用
    function compute(uint a, uint b) internal pure returns(uint) { return a + b; }
    function changeInfo() public { info = 20 ;}
    //remix测试 private internal的函数只能内部用 不会显示在测试小面板上

}

contract D {
    C c = new C();
    function readInfo() public view returns(uint) {return c.info();} 
    
}

//为什么有的是实例化合约 有的是继承 有什么区别吗？ 继承使用 和 新立门户的区别
contract E is C {
    uint private result;
    C private c = new C();
    //?     为什么需要在这里构造函数实例化？ 合约初始化先执行构造函数 没有就继承c的构造函数
    constructor() {
        info = 30;
    }
    //为什么函数直接调用 变量需要加合约名称？ 继承使用 和 新立门户的区别
    //实例化的合约调用不了 私有和内部
    function getComputedResult() public {
        result = compute(23, 5);
    }

    function getResult() public view returns (uint) {
        return result;
    }

    function getNewInfo() public view returns (uint) {
        return info;
    }

    function readInfo() public view returns(uint) {return c.info();} 

}