pragma solidity ^0.8.9;

//SPDX-License-Identifier: MIT

interface IFlash {
    function lend(uint256 _amount) external;

    function borrow(uint256 _amount) external;
}
