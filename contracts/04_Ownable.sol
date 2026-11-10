// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title Ownable - reusable ownership base contract
contract Ownable {
    address public owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() {
        owner = msg.sender;
        emit OwnershipTransferred(address(0), msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "New owner is zero address");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }
}

/// @title ProtectedVault - inherits Ownable, anyone deposits, only owner withdraws
contract ProtectedVault is Ownable {
    uint256 private treasure;

    event Deposited(address indexed from, uint256 amount);
    event Withdrawn(address indexed to, uint256 amount);

    function deposit() public payable {
        require(msg.value > 0, "Deposit must be > 0");
        treasure += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    function withdraw(address to, uint256 amt) public onlyOwner {
        require(to != address(0), "Invalid address");
        require(amt <= treasure, "Insufficient balance");
        treasure -= amt; // effects before interaction
        (bool ok, ) = payable(to).call{value: amt}("");
        require(ok, "Transfer failed");
        emit Withdrawn(to, amt);
    }

    function contractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}