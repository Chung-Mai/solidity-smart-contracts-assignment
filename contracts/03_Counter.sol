// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title Counter - bounded counter in range [0, MAX]
contract Counter {
    uint256 public count;
    uint256 public constant MAX = 100;

    event Incremented(address indexed by, uint256 newCount);
    event Decremented(address indexed by, uint256 newCount);
    event Reset(address indexed by);

    constructor(uint256 _start) {
        require(_start <= MAX, "Start exceeds max");
        count = _start;
    }

    function increment() public {
        require(count < MAX, "Max limit reached");
        count += 1;
        emit Incremented(msg.sender, count);
    }

    function decrement() public {
        require(count > 0, "Count is zero");
        count -= 1;
        emit Decremented(msg.sender, count);
    }

    function reset() public {
        count = 0;
        emit Reset(msg.sender);
    }
}