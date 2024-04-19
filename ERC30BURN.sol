// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyToken is ERC20 {
    using Counters for Counters.Counter;

    Counters.Counter private _totalSupply;
    uint256 public burnStartTime;

    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        _totalSupply.increment(1000 * 10**18); // Initialize total supply (e.g., 1000 tokens)
        _mint(msg.sender, 1000 * 10**18); // Mint initial tokens to the contract deployer
        burnStartTime = block.timestamp + 30 days; // Set burn start time 30 days from deployment
    }

    function burnTokens() external {
        require(block.timestamp >= burnStartTime, "Burning not initiated yet");
        uint256 balance = balanceOf(address(this));
        _burn(address(this), balance);
    }

    function purchaseTokens(uint256 amount) external {
        _totalSupply.increment(amount);
        _mint(msg.sender, amount);
    }
}
