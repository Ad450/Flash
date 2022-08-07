pragma solidity ^0.8.7;
//SPDX-License-Identifier:MIT
import "./interfaces/IFlash.sol";
import "./pool.sol";

contract Flash is IFlash {
    Pool private _pool;

    constructor() {
        _pool = new Pool();
    }

    function lend(address token, uint256 _amount) external override {
        _pool.deposit(token, _amount);
    }

    function borrow(address token, uint256 _amount) external override {
        _pool.withdraw(token, _amount);
    }
}
