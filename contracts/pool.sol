pragma solidity ^0.8.7;
// SPDX-License-Identifier: MIT
import "./interfaces/IPool.sol";

import "./pool_provider_token.sol";
import "./utils/modifiers.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Pool is IPool, Modifiers {
    mapping(address => bool) provider;
    PoolProviderTokens private _providerTokens;

    constructor() {
        _providerTokens = new PoolProviderTokens("Pool Provider Tokens", "PPT");
    }

    // depositing tokens into pool or staking tokens
    function addTokens(address _token, uint256 _amount)
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

        uint256 _initialPoolBalance = IERC20(_token).balanceOf(
            address(_providerTokens)
        );
        // transfer tokens to pool
        IERC20(_token).transfer(address(this), _amount);
        // send pool provider tokens to caller or sender
        require(
            IERC20(_token).balanceOf(address(_providerTokens)) >
                _initialPoolBalance,
            "invalid transfer"
        );
        provider[msg.sender] = true;
        // will calculate the amount of PPT to send to caller
        // just using all _amount for now
        _providerTokens.mintProviderTokens(msg.sender, _amount);
    }

    function withdrawTokens(address _token, uint256 _amount)
        external
        override
        validator(_token, _amount)
        guard
    {
        uint256 _initialPoolBalance = IERC20(_token).balanceOf(
            address(_providerTokens)
        );
        IERC20(_token).transfer(msg.sender, _amount);
        require(
            _initialPoolBalance >
                IERC20(_token).balanceOf(address(_providerTokens)),
            "invalid transfer"
        );
    }

    function _calculatePPT(address token, uint256 _amount) private {}
}
