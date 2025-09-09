// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.4.0
pragma solidity ^0.8.27;

import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import {ERC1155Pausable} from "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Pausable.sol";
import {ERC1155Supply} from "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Professor is ERC1155, Ownable, ERC1155Pausable, ERC1155Supply {
    uint256 public publicPrice = 0.001 ether ;
    uint256 public maxSupply = 10 ;

    constructor(address initialOwner)
        ERC1155("ipfs://Qmaa6TuP2s9pSKczHF4rwWhTKUdygrrDs8RmYYqCjP3Hye/")
        Ownable(initialOwner)
    {}

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function mint(uint256 id, uint256 amount)
        public
        payable 
    {
        require(msg.value == publicPrice * amount  , "Not enough money sent !");
        require(id < 10 , "This NFT does not exist !");
        require(totalSupply(id) + amount <= maxSupply , "Sorry we are out of stock :( ");
        _mint(msg.sender, id, amount, "");
    }

    function withdraw(address _address) external onlyOwner{
        uint256 balance = address(this).balance ;
        payable(_address).transfer(balance) ;
    }

    function uri(uint256 _id) public view virtual override returns (string memory) {
        require(exists(_id),"Token with this Id do not exists !");
        return string(abi.encodePacked(super.uri(_id), Strings.toString(_id), ".json"));
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public
        onlyOwner
    {
        _mintBatch(to, ids, amounts, data);
    }

    // The following functions are overrides required by Solidity.

    function _update(address from, address to, uint256[] memory ids, uint256[] memory values)
        internal
        override(ERC1155, ERC1155Pausable, ERC1155Supply)
    {
        super._update(from, to, ids, values);
    }
}
