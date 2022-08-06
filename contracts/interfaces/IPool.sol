pragma solidity ^0.8.7;

//SPDX-License-Identifier: MIT

interface IPool {
    // depositing tokens into pool
    function lend(address _token, uint256 _amount) external;

    function withdrawTokens(address _token, uint256 _amount) external;
}
