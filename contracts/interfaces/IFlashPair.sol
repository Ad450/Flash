pragma solidity ^0.8.9;

//SPDX-License-Identifier: MIT

interface Pair {
    uint256 internal store;

    function addTokens(address _token1, address _token2) internal;
}
