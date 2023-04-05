pragma solidity ^0.5.0;

import "./Token.sol";

contract EthSwap {
	string public name = "EthSwap Instant Exchange";
	Token  public token;
	uint   public rate = 100;

	address payable owner;

	event TokensPurchased(
		address account,
		address token,
		uint amount,
		uint rate
	);

	event TokensSold(
		address account,
		address token,
		uint amount,
		uint rate
	);

	constructor(Token _token) public {
		token = _token;



	}

    /* Returns the exchange rate */
    function getrate() public view returns (uint) {
      return rate;
    }

    /* Updates the exchange rate */
    function changerate(uint _rate) public payable {
      rate = _rate;
    }

	function buyTokens() public payable {
		// Redemption rate: No of tokens recieved for 1 ETH
		// Calculate number of tokens to buy
		uint tokenAmount = msg.value * rate;

		require(token.balanceOf(address(this)) >= tokenAmount);

		token.transfer(msg.sender, tokenAmount);

		emit TokensPurchased(msg.sender, address(token), tokenAmount, rate);
    }

   function sellTokens(uint _amount) public {
		// User cannot sell more tokens than they have
		require(token.balanceOf(msg.sender) >= _amount);

		// Calculate ether amount to redeem
		uint etherAmount = _amount / rate;

		require(address(this).balance >= etherAmount);

		// Perform sale
		token.transferFrom(msg.sender, address(this), _amount);
		msg.sender.transfer(etherAmount);

		emit TokensSold(msg.sender, address(token), _amount, rate);
    }  
}