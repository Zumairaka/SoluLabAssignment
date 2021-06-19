// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";

contract SlabToken is ERC20, ERC20Capped, ERC20Detailed{
    constructor(
        string memory name,
        string memory symbol,
        uint8 decimals,
        uint256 cap
    ) public ERC20Capped(cap) ERC20Detailed(name, symbol, decimals) {}
}
