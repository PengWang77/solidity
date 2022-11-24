pragma solidity >= 0.7.0 < 0.9.0;

contract TestCall{
    string public message;
    uint public x;

    event Log(string message);

    fallback() external payable {
        emit Log("fallback was called");
    }
    receive() external payable {
        emit Log("receive was called");
    }

    function foo(string memory _message, uint _x) external payable returns (bool, uint) {
        message = _message;
        x = _x;
        emit Log("foo was called");
        return (true, 999);
    }
}  

contract Call {
    bytes  public data;
    event Log(address _add);
    function callFoo(address _test) external payable {
        (bool success, bytes memory _data) = _test.call{value: 2 wei}("");
        require(success, "call failed");
        data = _data;
        emit Log(msg.sender);
    }

    function call(address _test) external payable {
        (bool success, bytes memory _data) = _test.call(abi.encodeWithSignature( ""));
        require(success, "call failed");
        data = _data;
        emit Log(msg.sender);
    }

    function callDoesNotExit(address _test) external {
        (bool success, ) = _test.call(abi.encodeWithSignature( "doesNotExist()"));
        require(success, "call failed");
    }
}


