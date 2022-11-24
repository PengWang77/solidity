pragma solidity >=0.7.0 <0.9.0;
 
contract myAuction{
    address payable public beneficiary;        // state variable to capture the address of auctioneer who will finally get the highest bid
    address public highestBidder;              // state variable to capture the address of the highest bidder throughout the auction
    uint public auctionEndTime;                // state variable to decide for how long the auction would be live
    uint public highestBid;                    // the highest bid amount at any instance of the auction till the end
 
    //declare an event, that emits new highest bidder and the new highest bid amount during the auction
    event NewBid(address higestBidder, uint higestBid);
 
    //declare an event, that emits new highest bidder and the new highest bid at the end of the auction
    event WinningBid(address winningBidder, uint winningBid);
 
  
    constructor(uint _auctionTime, address payable _auctioneer){         // Initializing the beneficiary address and the auction time
        beneficiary = _auctioneer;
        auctionEndTime = block.timestamp + _auctionTime;
        highestBid =0;                         
         // setting the initial bid value which may start form zero or a minimum amount as per beneficiary choice
 
    }
 
    modifier onlyBeneficiary{                           // modifier for identifying the beneficiary for withdrawal
        require(msg.sender ==beneficiary);
        _;
 
    }
 
    mapping(address => uint) pendingRefunds;   // mapping pending refunds for failed bids 
 
 
    // function for bidding on the auction till it is open
     function bid() public payable {
        require (block.timestamp < auctionEndTime);
        if (msg.value > highestBid){
          
            // recodting the previous highest bid amount to the previous highest bidder
           
           if (msg.value != 0){
           pendingRefunds[msg.sender] =msg.value;    // mapping the information of the bidders and their bids
           }
 
           highestBid = msg.value;                 // setting up ne highest Bid ot the current msg.value
           highestBidder = msg.sender;             // setting the new bidder is the highest bidder
           emit NewBid(highestBidder, highestBid); // emiting the ne bid increase
        }
        else{
            revert("Your Bid is not higher than the existing highest bid in place!");
        }
     }
 
  
    function withdraw() public payable returns (bool success){
        uint refund =pendingRefunds[msg.sender];
        if (refund < highestBid){                       // TO check if this msg.sender is not the highest bidder, else we cant let them withdraw
           pendingRefunds[msg.sender]=0;               // we set the refund amount to zero before sending the refund  
           payable(msg.sender).send(refund);           // this will send the biding amount refunded to the failed bidder      
        }
 
 
        if(!payable(msg.sender).send(refund)){           // incase send function fails then to safeguard the bidder
            pendingRefunds[msg.sender]=refund;           // we will maintain the record for the failed bidder
        }
 
        return true;
    }
 
 
    function anounceWinningBid() public view returns(uint) {   // for checking the highest bid at the end of the auction
        if (block.timestamp < auctionEndTime){
            revert("Auction is still in process, Wait for the winner!");
        }
        else{
            
            return highestBid;
        }
        
    }
 
    // Beneficiary only can run this function to claim the winning bid only at the end of the auction. 
    function claim() public payable onlyBeneficiary returns (uint){
        require (block.timestamp > auctionEndTime, "You cant claim before time, as the bidding is in process!");
        payable(beneficiary).send(highestBid);
        return highestBid;
 
    }
 
    // Beneficiary only can end the Auction to emit the winning bid and the winning bidder, but only after the closing time of auction
    function endAuction() public onlyBeneficiary{
        require (block.timestamp > auctionEndTime, "You cant End before time, as the bidding is still in process!");
 
        bool ended = true;
        if (ended) revert(" The auction is ended");
        emit WinningBid(highestBidder, highestBid);   // emit the highest Bidder with the highest bid value
    
    }
 
} 