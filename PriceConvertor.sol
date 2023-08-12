// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConvertor{
     function getPrice() internal view returns(uint256) {
            AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
             (,int256 answer,,,) = priceFeed.latestRoundData();
             // eth in terms of usd
             return uint256(answer*1e10);
      }

      function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
            // address 0x694AA1769357215DE4FAC081bf1f309aDC325306
            uint256 ethPrice = getPrice();
            uint256 ethAmountinUSD = (ethPrice*ethAmount)/1e18;
            return ethAmountinUSD;

      }

}