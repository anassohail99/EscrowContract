// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

interface IEscrow {
    event Log(string _message, address sender, uint256 value, bytes data);
    event Log2(string _message, address sender, uint256 value);

    // function deposit(address _receiver) external payable;

    // function withdraw(address _receiver) external payable;
}
