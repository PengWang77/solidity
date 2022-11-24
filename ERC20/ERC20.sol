// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;
import "./IERC20.sol";

//totalSupply balanceOf transfer allowance approve transferFrom
contract ERC20 is IERC20 {

    mapping(address => uint) public override balanceOf;//对应地址账户的代币数量
    mapping(address => mapping(address => uint)) public override allowance;//对应授权关系及其代币数量

    uint public override totalSupply; //代币总数量

    string public name;//名称
    string public symbol;//符号

    // @dev 在合约部署的时候实现合约的名称和符号
    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    function transfer(address recipient, uint amount) external override returns (bool) {
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint amount) external override returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint amount) external override returns (bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function burn(uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }

    function mint(uint amount) external {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }
}