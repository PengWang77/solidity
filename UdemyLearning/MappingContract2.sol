pragma solidity >= 0.7.0 < 0.9.0;

contract MappingContract2{

    struct Movie {
        string title;
        string dirctor;
    }

    mapping(uint => Movie) movie;
    mapping(address => mapping(uint => Movie)) myMovie;

    function addMovie(uint id, string memory title, string memory dirctor) public {
        movie[id] = Movie(title, dirctor);
    }

    function addMyMovie(uint id, string memory title, string memory dirctor) public {
        myMovie[msg.sender][id] = Movie(title, dirctor);
    }

}