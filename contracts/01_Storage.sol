// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
///@title Storage - store and update a single uint256 on-chain
contract Storage {
    uint256 private storedData;

    event ValueSet(address indexed who, uint256 newValue);

    constructor(uint256 _init) {
        storedData = _init;
    }

    function set(uint256 _value) public {
        storedData = _value;
        emit ValueSet(msg.sender, _value);
    }

    function get() public view returns (uint256) {
        return storedData;
    }
}