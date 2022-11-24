pragma solidity >= 0.7.0 < 0.9.0;

abstract contract Base {
    string public name = "Base";
    function getAlias() public pure virtual returns (string memory);
}

contract BaseImpl is Base {
    function getAlias() public pure override returns (string memory) {
        return "BaseImp";
    }
}  

