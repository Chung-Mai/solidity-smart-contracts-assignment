// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title SimpleBank - per-user ETH balances, safe against re-entrancy
contract SimpleBank {
    mapping(address => uint256) private balances;

    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    function deposit() public payable {
        require(msg.value > 0, "Deposit must be > 0");
        balances[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) public {
        // Checks
        require(amount > 0, "Amount must be > 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        // Effects (update state BEFORE sending ETH)
        balances[msg.sender] -= amount;

        // Interactions
        (bool ok, ) = payable(msg.sender).call{value: amount}("");
        require(ok, "Transfer failed");

        emit Withdrawn(msg.sender, amount);
    }

    function myBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    function bankTotal() public view returns (uint256) {
        return address(this).balance;
    }
}