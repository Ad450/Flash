pragma solidity ^0.8.7;
//SPDX-License-Identifier:MIT
import "./interfaces/IFlash.sol";

contract Flash is IFlash {
    function lend(address token, uint256 _amount) external override {}

    function borrow(address token, uint256 _amount) external override {}
}
