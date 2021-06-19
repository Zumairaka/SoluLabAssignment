// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/crowdsale/Crowdsale.sol";
import "@openzeppelin/contracts/crowdsale/distribution/FinalizableCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/distribution/RefundableCrowdsale.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Pausable.sol";

contract SlabICO is Crowdsale, RefundableCrowdsale, FinalizableCrowdsale {
    // crowdsale stages
    enum SlabICOStage {preSale, seedSale, finalSale}

    // default stage
    SlabICOStage public _stage = SlabICOStage.preSale;

    constructor(
        uint256 rate,
        address payable wallet,
        IERC20 token,
        uint256 goal
    ) public Crowdsale(rate, wallet, token) RefundableCrowdsale(goal) {}

    // function to update crowdsale stage
    function setSlabICOStage(uint256 stage) public onlyOwner {
        if (uint256(SlabICOStage.preSale) == stage) {
            _stage = SlabICOStage.preSale;
            _rate = 215700; // for one ether we get 215700 tokens till 30M tokens ($0.01/token)
        } else if (uint256(SlabICOStage.seedSale) == stage) {
            _stage = SlabICOStage.seedSale;
            _rate = 107850; // for one ether we get 107850 tokens for next 50M tokens ($0.02/token)
        } else if (uint256(SlabICOStage.finalSale) == stage) {
            _stage = SlabICOStage.finalSale;
        }
    }

    // function to set rate
    function setRate(uint256 rate) public onlyOwner {
        require(
            _stage == SlabICOStage.finalSale,
            "rate cannot be modified for other stages"
        );
        _rate = rate;
    }

    // function for finalizing the crowd sale
    function _finalization() internal {
        if (goalReached()) {
            ERC20Pausable _ERC20PausableToken = ERC20Pausable(token);
            _ERC20PausableToken.unpause(); // unpause the token when goal is reached
            _ERC20PausableToken.transferOwnership(_wallet); // transfer ownership to individuals for transaction using the tokens
        }
        super._finalization();
    }
}
