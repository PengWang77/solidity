pragma solidity >= 0.7.0 < 0.9.0;

contract EnumsContract{

    struct Movie {
        string name;
        string dirctor;
        uint id;
    }

    Movie movie;
    Movie comedymovie;

    function setMovie() public {
        movie = Movie("superman", "NON", 1 );
    }

    function getMovieId() public view returns (uint) {
        return movie.id;
    }
}