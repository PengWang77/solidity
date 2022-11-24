pragma solidity >= 0.7.0 < 0.9.0;

contract Oracle{
    
    address admin;
    uint public rand;
    uint public xxx= 111;//合约作为对象调用时，使用oracle.xxx()调用

    constructor () public {
        admin = msg.sender;
    }

    function feedRand(uint _rand) external {
        require(msg.sender == admin);
        rand = _rand;
    }

}  

contract GenerateRandomNumber {
    Oracle oracle;

    constructor( address oracleAddress) {
        oracle = Oracle(oracleAddress);
    }
    function getRand() public view returns(uint) {
        return oracle.xxx();
    }

    function randMod(uint range) external view returns(uint) {
        
        return uint(keccak256(abi.encodePacked(oracle.rand(), block.timestamp, block.difficulty,msg.sender))) % range;
    }
}
