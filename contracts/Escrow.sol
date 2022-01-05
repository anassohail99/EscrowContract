// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

import "./interfaces/IEscrow.sol";

contract Escrow is IEscrow {
    using SafeMath for uint256;

    fallback() external payable {
        emit Log("Fallback", msg.sender, msg.value, msg.data);
    }

    receive() external payable {
        emit Log2("Receiver", msg.sender, msg.value);
    }

    address public agent;
    address public owner;
    mapping(address => uint256) public deposits;

    constructor(address _agent) {
        agent = _agent;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "NO");
        _;
    }

    function deposit(address _receiver) external payable onlyOwner {
        uint256 amount = msg.value;
        if (deposits[_receiver] != 0) {
            deposits[_receiver] = deposits[_receiver] + amount;
        }
        deposits[_receiver] = amount;
    }

    function withdraw(address payable _receiver) external payable onlyOwner {
        uint256 payment = deposits[_receiver];
        deposits[_receiver] = 0;
        bool sent = _receiver.send(payment);
        require(sent, "Failed to send ethers");
        // _receiver.transfer(payment);
    }
}
