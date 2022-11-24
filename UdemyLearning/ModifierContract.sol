pragma solidity >= 0.7.0 < 0.9.0;

contract M01{
    uint val;
    address add;

    constructor() public {
        add = msg.sender;
    }
    modifier overValue(uint _price) {
        require(msg.value >= _price);
        _;
    }
    modifier onlyUser {
        require(msg.sender == add );
        _;
    }
}  

contract M02 is M01 {

    uint price;
    mapping(address => bool) registerAddress;

    constructor(uint initPrice) public {
        price = initPrice;
    }

    function register() public payable overValue(price){
        registerAddress[msg.sender] = true;
    }
    function changePrice(uint _price) public onlyUser {
        price = _price;
    }
}