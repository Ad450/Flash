pragma solidity ^0.8.7;

//SPDX-License-Identifier: MIT

contract Modifiers {
    bool private locked;
    modifier guard() {
        require(!locked, "cannot re-enter function");
        locked = true;
        _;
        locked = false;
    }

    modifier validator(address token, uint256 amount) {
        require(token != address(0), "invalid address");
        require(amount > 0, "invalid amount");
        _;
    }
}
