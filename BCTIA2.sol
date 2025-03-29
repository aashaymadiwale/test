// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTTicketSystem is ERC721URIStorage, Ownable {
    uint256 public nextTicketId;
    uint256 public maxResalePrice; // Set price cap for reselling

    struct Ticket {
        uint256 eventId;
        uint256 price;
        bool isResold;
    }

    mapping(uint256 => Ticket) public tickets;

    event TicketIssued(address indexed owner, uint256 indexed ticketId, uint256 eventId, uint256 price);
    event TicketTransferred(address indexed from, address indexed to, uint256 indexed ticketId, uint256 price);

    // ✅ Fix: Pass msg.sender to the Ownable constructor
    constructor(uint256 _maxResalePrice) ERC721("NFTTicket", "NTIX") Ownable(msg.sender) {
        maxResalePrice = _maxResalePrice;
    }

    function issueTicket(address _to, uint256 _eventId, uint256 _price, string memory _tokenURI) public onlyOwner {
        require(_price <= maxResalePrice, "Ticket price exceeds max limit");

        uint256 ticketId = nextTicketId;
        _mint(_to, ticketId);
        _setTokenURI(ticketId, _tokenURI);

        tickets[ticketId] = Ticket(_eventId, _price, false);
        nextTicketId++;

        emit TicketIssued(_to, ticketId, _eventId, _price);
    }

    function transferTicket(address _to, uint256 _ticketId, uint256 _resalePrice) public {
        require(ownerOf(_ticketId) == msg.sender, "You are not the ticket owner");
        require(_resalePrice <= maxResalePrice, "Resale price exceeds max limit");

        _transfer(msg.sender, _to, _ticketId);
        tickets[_ticketId].isResold = true;
        tickets[_ticketId].price = _resalePrice;

        emit TicketTransferred(msg.sender, _to, _ticketId, _resalePrice);
    }

    function getTicketDetails(uint256 _ticketId) public view returns (uint256, uint256, bool) {
        Ticket memory ticket = tickets[_ticketId];
        return (ticket.eventId, ticket.price, ticket.isResold);
    }
}
