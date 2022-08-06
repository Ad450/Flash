pragma solidity ^0.8.7;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract LenderToken is ERC20 {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {}

    function mintProviderTokens(address provider, uint256 _amount) external {
        _mint(provider, _amount);
    }
}
