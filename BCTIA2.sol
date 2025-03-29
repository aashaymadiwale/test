// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.24;

contract TicketSystem {
    enum TicketType {Regular, VIP}

    struct Ticket {
        address owner;
        uint eventId;
        TicketType ticketType;
    }

    Ticket[] public issuedTickets;
    mapping(address => mapping(uint => bool)) public validTickets;

    // Payable constructor (in case you want to accept ETH)
    constructor() payable {}

    function issueTicket(uint _eventId, TicketType _ticketType) public {
        issuedTickets.push(Ticket({
            owner: msg.sender,
            eventId: _eventId,
            ticketType: _ticketType
        }));

        validTickets[msg.sender][_eventId] = true;
    }

    function isTicketValid(address _owner, uint _eventId) public view returns (bool) {
        return validTickets[_owner][_eventId];
    }

    function ticketOwnershipTransfer(uint _ticketIndex, address _newOwner) public {
        require(_ticketIndex < issuedTickets.length, "Invalid Ticket Index");

        Ticket storage tic = issuedTickets[_ticketIndex];
        require(msg.sender == tic.owner, "Only the owner can call this function");
        require(_newOwner != address(0), "New owner address is invalid");

        tic.owner = _newOwner;
        validTickets[_newOwner][tic.eventId] = true;
        validTickets[msg.sender][tic.eventId] = false;
    }
}
