// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/crowdsale/Crowdsale.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Capped.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";

contract SlabICO is
    Crowdsale,
    Ownable
{
    // crowdsale stages
    enum SlabICOStage {preSale, seedSale, finalSale}

    // default stage
    SlabICOStage public stage = SlabICOStage.preSale;

    constructor(
        uint256 rate,
        address payable wallet,
        IERC20 token
    ) public Crowdsale(rate, wallet, token) {}

    // function to update crowdsale stage
    function setSlabICOStage(uint256 _stage) public onlyOwner {
        if (uint256(SlabICOStage.preSale) == _stage) {
            stage = SlabICOStage.preSale;
            _rate = 215700; // for one ether we get 215700 tokens till 30M tokens ($0.01/token)
        } else if (uint256(SlabICOStage.seedSale) == _stage) {
            stage = SlabICOStage.seedSale;
            _rate = 107850; // for one ether we get 107850 tokens for next 50M tokens ($0.02/token)
        } else if (uint256(SlabICOStage.finalSale) == _stage) {
            stage = SlabICOStage.finalSale;
        }        
    }

    // function to set rate
    function setRate(uint256 rate) public onlyOwner {
        require(
            stage == SlabICOStage.finalSale,
            "rate cannot be modified for other stages"
        );
        _rate = rate;
    }
}
