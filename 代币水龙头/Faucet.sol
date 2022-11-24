//SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;
import "./IERC20.sol";//导入IERC20协议方便后续不同合约使用（六大函数）

//水龙头合约可以免费给申请者一定量的代币进行宣传
contract Faucet {

    //定义每次申请的额度是100
    uint256 public amountAllowed = 100;

    //定义水龙头对应的代币合约地址
    address public tokenContract;

    //储存所有已经申请过后的地址并打标
    mapping(address => bool) public requestedAddress;

    //定义事件，方便后续释放事件
    event sendToken(address indexed Receiver, uint256 indexed Amount);

    //初始化时，输入想要做水龙头的合约地址
    constructor(address _tokenAddress) {
        tokenContract = _tokenAddress;
    }

    //申请代币的函数
    function requestTokens() external {

        //判断申请者是否已经申请过，如果是就revert 然后提示信息
        require(requestedAddress[msg.sender] == false, "Cannot request twice for tokens");

        //使用代币地址的IERC20对象，方便后续使用接口功能
        IERC20 token = IERC20(tokenContract);

        //判断水龙头合约的代币数量是否满足发一次代币，如果不行就revert 然后提示信息
        require(token.balanceOf(address(this)) >= amountAllowed, "Donot have enough tokens");

        //执行IERC20接口的函数
        token.transfer(msg.sender, amountAllowed);

        //给申请者打标，并以后不能再申请
        requestedAddress[msg.sender] = true;

        //释放事件
        emit sendToken(msg.sender, amountAllowed);
    }

}