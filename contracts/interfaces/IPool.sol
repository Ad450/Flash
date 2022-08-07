pragma solidity ^0.8.7;

//SPDX-License-Identifier: MIT

interface IPool {
    // depositing tokens into pool
    function deposit(address _token, uint256 _amount) external;

    function withdraw(address _token, uint256 _amount) external payable;
}
