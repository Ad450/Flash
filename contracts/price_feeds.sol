//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract PriceFeeds {
    AggregatorV3Interface private priceFeed;
    // Aggregator is DAI/ETH
    address private constant rinkebyTestnet =
        0x74825DbC8BF76CC4e9494d0ecB210f676Efa001D;

    constructor() {
        priceFeed = AggregatorV3Interface(rinkebyTestnet);
    }

    function getPrice() public view returns (int256 price) {
        (
            ,
            /*uint80 roundID*/
            price,
            /*uint startedAt*/
            /*uint timeStamp*/
            /*uint80 answeredInRound*/
            ,
            ,

        ) = priceFeed.latestRoundData();
        return price;
    }
}
