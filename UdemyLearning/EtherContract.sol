pragma solidity >= 0.7.0 < 0.9.0;

contract EtherExercise{
    function test()public {
        assert(1000000000000000000 wei == 1 ether);
        assert(1 wei == 1);
        assert(1 ether == 1e18);
    }
    function exercise() public {
        assert(1 weeks == 7 days);
        assert(1 days == 24 hours);
        assert(1 hours == 60 minutes);
        assert(1 minutes == 60 seconds);

        assert(10 == 8 + 2);
    }
} 