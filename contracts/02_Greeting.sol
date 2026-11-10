// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title Greeting - owner-only greeting message, anyone can read
contract Greeting {
    string private greeting;
    address public owner;

    string private constant DEFAULT_GREETING = "Hello, World!";

    event GreetingChanged(address changer, string newGreeting);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can change greeting");
        _;
    }

    constructor(string memory _g) {
        owner = msg.sender;
        greeting = _g;
        emit GreetingChanged(msg.sender, _g);
    }

    function setGreeting(string memory _g) public onlyOwner {
        greeting = _g;
        emit GreetingChanged(msg.sender, _g);
    }

    function greet() public view returns (string memory) {
        return greeting;
    }

    function resetGreeting() public onlyOwner {
        greeting = DEFAULT_GREETING;
        emit GreetingChanged(msg.sender, DEFAULT_GREETING);
    }
}