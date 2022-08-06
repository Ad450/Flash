pragma solidity ^0.8.7;
// SPDX-License-Identifier: MIT
import "./interfaces/IPool.sol";

import "./lender_token.sol";
import "./utils/modifiers.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./price_feeds.sol";

contract Pool is IPool, Modifiers {
    using SafeMath for uint256;

    // pool percentage
    uint256 private _percent = uint256(150) / uint256(100);

    mapping(address => bool) lender;
    LenderToken private _lenderToken;
    PriceFeeds private _priceFeeds;

    constructor() {
        _lenderToken = new LenderToken("Pool Provider Tokens", "PPT");
        _priceFeeds = new PriceFeeds();
    }

    // depositing tokens into pool or staking tokens
    function lend(address _token, uint256 _amount)
        external
        override
        validator(_token, _amount)
        guard
    {
        // check balance of caller
        require(
            IERC20(_token).balanceOf(msg.sender) >= _amount,
            "insufficient balance"
        );

        uint256 _initialPoolBalance = IERC20(_token).balanceOf(address(this));
        // transfer tokens to pool
        IERC20(_token).transfer(address(this), _amount);
        // send pool provider tokens to caller or sender
        require(
            IERC20(_token).balanceOf(address(this)) > _initialPoolBalance,
            "invalid transfer"
        );

        lender[msg.sender] = true;
        // will calculate the amount of PPT to send to caller
        // just using all _amount for now
        _lenderToken.mintProviderTokens(msg.sender, _amount);
    }

    function withdrawTokens(address _token, uint256 _amount)
        external
        override
        validator(_token, _amount)
        guard
    {
        uint256 _initialPoolBalance = IERC20(_token).balanceOf(address(this));
        IERC20(_token).transfer(msg.sender, _amount);
        require(
            IERC20(_token).balanceOf(address(this)) > _initialPoolBalance,
            "invalid transfer"
        );
    }

    function _calculatePPT(address token, uint256 _amount) private {}

    // normal human banking logic
    function getLoan(uint256 _amount) public payable guard {
        // validate sender amount and value
        require(msg.sender != address(0), "invalid address");
        require(msg.value >= 0, "insufficient amount");
        uint256 actualCollateral = msg.value;
        uint256 requiredCollateral = _collateral(_amount);

        require(
            actualCollateral >= requiredCollateral,
            "insufficent collateral"
        );
    }

    function _collateral(uint256 _amount)
        private
        view
        returns (uint256 requiredETH)
    {
        uint256 tradeTokens = _percent.mul(_amount);
        int256 daiPriceInETH = _priceFeeds.getPrice();
        uint256 castedDAIPrice = uint256(daiPriceInETH);
        requiredETH = tradeTokens.mul(castedDAIPrice);

        return requiredETH;
    }
}
