NFT-Based Ticketing System
Overview-
The NFT-Based Ticketing System is a smart contract that issues event tickets as NFTs (ERC-721). This ensures:
•	Transparent ownership transfers
•	Prevention of scalping with resale price caps
•	Secure and verifiable ticket ownership
Features-
•	Issue event tickets as NFTs (ERC-721 standard)
•	Secure ownership transfer of tickets
•	Maximum resale price to prevent ticket scalping
•	Blockchain-based and fully decentralized
•	Uses OpenZeppelin’s ERC-721 & Ownable for security
Smart Contract-
Contract Name: NFT Ticket System
Dependencies
The contract imports OpenZeppelin libraries:
•	ERC721URIStorage → Enables NFT minting with metadata
•	Ownable → Restricts ticket issuance to the contract owner
Prerequisites-
Ensure you have the following installed:
•	Node.js
•	Hardhat
•	MetaMask
•	Solidity compiler (solc)
Setup-
1.	Clone the Repository:
2.	git clone https://github.com/your-repo/nft-ticket-system.git
3.	cd nft-ticket-system
4.	Install Dependencies:
5.	npm install
Deployment Using Hardhat
1.	Compile the Contract:
2.	npx hardhat compile
3.	Deploy to a Local Testnet:
4.	npx hardhat node
5.	npx hardhat run scripts/deploy.js --network localhost
6.	Deploy to a Public Testnet (e.g., Sepolia):
7.	npx hardhat run scripts/deploy.js --network sepolia

Usage Issuing a Ticket (Admin Only)
issueTicket(address _to, uint256 _eventId, uint256 _price, string memory _tokenURI);
•	_to: Address of the ticket recipient
•	_eventId: Unique ID of the event
•	_price: Ticket price (capped to prevent scalping)
•	_tokenURI: Metadata URL for the NFT ticket
Transferring a Ticket
transferTicket(address _to, uint256 _ticketId, uint256 _resalePrice);
•	_to: New owner of the ticket
•	_ticketId: NFT ID of the ticket
•	_resalePrice: Resale price (must be within the allowed limit)
Checking Ticket Details
getTicketDetails(uint256 _ticketId);
•	Returns (eventId, price, isResold)
License
This project is licensed under the GPL-3.0 License.
________________________________________ 

