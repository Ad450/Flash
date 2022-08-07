pragma solidity ^0.8.7;

//SPDX-License-Identifier: MIT

interface IFlash {
    function lend(address token, uint256 _amount) external;

    function borrow(address token, uint256 _amount) external;
}
