pragma solidity ^0.8.7;
// SPDX-License-Identifier: MIT

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract PoolProviderTokens is ERC20 {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {}

    function mintProviderTokens(address provider, uint256 _amount) internal {
        _mint(provider, _amount);
    }
}
