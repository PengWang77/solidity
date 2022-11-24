pragma solidity >= 0.7.0 < 0.9.0;

contract Test004 {
    
    string greeting = "Hello,\n I\'m the world of king";
    string favoriteColor = "blue";

    function returnGreeting() public view returns(string memory) {
        return greeting;
    }

    function returnColor() public view returns(string memory) {
        return favoriteColor;
    }

    function changeColor(string memory yourFavoriteColor) public {
        favoriteColor = yourFavoriteColor;

    } 

    function returnHowmanyCharactors() public view returns (uint){
        bytes memory bytes001 = bytes(favoriteColor);
        return bytes001.length;
    }
    function returnBytes() public view returns (bytes memory){
        bytes memory bytes001 = bytes(favoriteColor);
        return bytes001;
    }
}



 