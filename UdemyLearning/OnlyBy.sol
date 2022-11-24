pragma solidity >= 0.7.0 < 0.9.0;

contract OnlyBy{
    address public owner = msg.sender;
    uint public creatTime = block.timestamp;

    modifier onlyBy(address _account) {
        require(msg.sender == _account,
            "Sender not authorized"
        );
        _;
    }

    modifier onlyAfter(uint _time) {
        require(block.timestamp >= _time,
            "function is called too early"
        );
        _;
    }

    function changeOwnerAddress(address _newAddress)public onlyBy(owner) {
        owner = _newAddress;
    }
    function disown() onlyBy(owner) onlyAfter(creatTime + 1 seconds) public {
        delete owner;
    }

    modifier costs(uint _amount) {
        require( msg.value >= _amount,
        "Not hava enough value"
        );
        _;
    }

    function forceOwnerChange(address _newOwner) payable public costs(1 ether) {
        owner = _newOwner;
    }
}  

