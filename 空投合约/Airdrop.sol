// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;
import "./IERC20.sol";

//空投合约指的是一种币圈营销策略，项目方将代币免费发放给特定用户群体。为了拿到空投资格，用户通常需要完成一些任务，如测试产品、分享新闻、介绍朋友等。
//项目方可以通过空投获得种子用户，用户可以获得一笔财富。
//每次接受空投的用户很多。项目方不可能一笔一笔的转账。利用智能合约批量发放ERC20代币，可以显著提高空头效率。
contract Airdrop {

    //向多个地址转账ERC20代币，使用前需先授权
    function multiTransferToken(
        address _token,//代币合约地址
        address[] calldata _addresses,//空投代币的地址数组
        uint[] calldata _amounts//对应地址空投代币数量
    ) external {

        //判断地址长度是否与对应数量数组相等
        require( _addresses.length == _amounts.length, "Length of addresses and amounts not equal");

        //声明IERC合约变量
        IERC20 token = IERC20(_token);

        //计算空投代币数量
        uint _amountSum = getSum(_amounts);

        //判断授权代币数量大于或者等于空投大笔总量，利用allowance函数获取授权代币数量
        require(token.allowance(msg.sender, address(this)) >= _amountSum, "Donot have enough ERC20 token");

        //for循环，利用transferFrom函数发送空投
        for(uint i = 0; i < _addresses.length; i++ ) {
            token.transferFrom(msg.sender, _addresses[i], _amounts[i]);
        }
    }

    //向多个地址转账ETH
    function multiTransferETH(
        address payable[] calldata _addresses,//领取ETH的地址数组
        uint[] calldata _amounts//对应地址的ETH数组
    ) public payable {

        //判断地址数组是否与对应ETH数组长度一致
        require(_addresses.length == _amounts.length, "Length of addresses and amounts not equal");

        //计算空投ETH数量
        uint _amountSum = getSum(_amounts);

        //判断转入ETH是否等于空投ETH总量
        require(msg.value == _amountSum, "Donot have enough ETH");

        //for循环，利用transfer函数发送ETH
        for(uint i = 0; i < _addresses.length; i++ ) {
            _addresses[i].transfer(_amounts[i]);
        }
    }

    //数组求和函数
    function getSum(uint[] calldata _arr) public pure returns(uint sum) {
        for(uint i = 0; i < _arr.length; i++) {
            sum += _arr[i];
        }
    }
}


// ERC20代币合约
contract ERC20 is IERC20 {

    mapping(address => uint256) public override balanceOf;

    mapping(address => mapping(address => uint256)) public override allowance;

    uint256 public override totalSupply;   // 代币总供给

    string public name;   // 名称
    string public symbol;  // 符号
    
    uint8 public decimals = 18; // 小数位数

    constructor(string memory name_, string memory symbol_){
        name = name_;
        symbol = symbol_;
    }

    // @dev 实现`transfer`函数，代币转账逻辑
    function transfer(address recipient, uint amount) external override returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    // @dev 实现 `approve` 函数, 代币授权逻辑
    function approve(address spender, uint amount) external override returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    // @dev 实现`transferFrom`函数，代币授权转账逻辑
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external override returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    // @dev 铸造代币，从 `0` 地址转账给 调用者地址
    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    // @dev 销毁代币，从 调用者地址 转账给  `0` 地址
    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }

}