// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;


import "./PriceConvertor.sol";

contract fundme{

      using PriceConvertor for uint256;
      uint256 public minimumUsd = 50 * 1e18;
      address[] public funders;
      address public owner;
      mapping(address=>uint256) public addressToAmountFunded;

      constructor(){
            owner = msg.sender;
      }

     function fund() public payable{
         require(msg.value.getConversionRate()>=minimumUsd, "did'nt send enough");
         funders.push(msg.sender);
         addressToAmountFunded[msg.sender]+=msg.value;
      }

      function withdraw() public onlyOwner{
            for(uint256 funderIndex=0; funderIndex<funders.length;funderIndex++){
                  address funder = funders[funderIndex];
                  addressToAmountFunded[funder]=0;
            }

            payable(msg.sender).transfer(address(this).balance);
      }

      modifier onlyOwner(){
            require(msg.sender==owner, "You are not owner");
            _;
      }


}





