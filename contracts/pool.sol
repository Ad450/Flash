pragma solidity ^0.8.7;
// SPDX-License-Identifier: MIT
import "./interfaces/IPool.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";

contract Pool is IPool {
    bool locked;

    modifier guard() {
        require(!locked, "function locked");
        locked = true;
        _;
        locked = false;
    }

    // depositing tokens into pool or staking tokens
    function addTokens(address _token, uint256 _amount)
        external
        override
        guard
    {
        // check balance of caller
        require(
            IERC20(_token).balanceOf(msg.sender) >= _amount,
            "insufficient balance"
        );

        // transfer tokens to pool
        IERC20(_token).transfer(address(this), _amount);

        // send pool provider tokens to caller or sender
    }

    function withdrawTokens(address _token, uint256 _amount)
        external
        override
        guard
    {}
}
