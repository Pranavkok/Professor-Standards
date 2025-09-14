// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.4.0
pragma solidity ^0.8.27;

import {ERC1155} from "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import {ERC1155Pausable} from "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Pausable.sol";
import {ERC1155Supply} from "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/finance/PaymentSplitter.sol";

contract Professor is ERC1155, Ownable, ERC1155Pausable, ERC1155Supply , PaymentSplitter {
    uint256 public publicPrice = 0.001 ether ;
    uint256 public allowListPrice = 0.0005 ether ;
    uint256 public maxSupply = 10 ;

    bool public publicMintOpen = false ;
    bool public allowListMintOpen = false ;

    mapping ( address => bool ) public allowList ;
    mapping ( address => uint256 ) public mintCount ;

    constructor(address initialOwner,address[] memory _payees,
        uint256[] memory _shares)
        ERC1155("ipfs://Qmaa6TuP2s9pSKczHF4rwWhTKUdygrrDs8RmYYqCjP3Hye/")
        Ownable(initialOwner)
        PaymentSplitter(_payees, _shares)
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

    function setMintWindows(bool _public , bool _allowList) external onlyOwner{
        publicMintOpen = _public ;
        allowListMintOpen = _allowList ;
    }

    function addAllowList(address[] memory _address)external onlyOwner{
        for(uint i = 0 ; i < _address.length ; i++){
            allowList[_address[i]] = true ;
        }
    }

    function publicMint(uint256 id, uint256 amount)
        public
        payable 
    {   
        require(publicMintOpen , "public minting in close");
        require(mintCount[msg.sender] + amount <= 5 , "You can not mint more than 5 NFTs");
        require(msg.value == publicPrice * amount  , "Not enough money sent !");
        require(id < 10 , "This NFT does not exist !");
        require(totalSupply(id) + amount <= maxSupply , "Sorry we are out of stock :( ");
        _mint(msg.sender, id, amount, "");
        mintCount[msg.sender] += amount ;
    }

    function allowListMint(uint256 id , uint256 amount)public payable{
        require(allowListMintOpen , "allow list minting in close");
        require(mintCount[msg.sender] + amount <= 5 , "You can not mint more than 5 NFTs");
        require(allowList[msg.sender] , "You are not in the allow list !");
        require(msg.value == allowListPrice * amount  , "Not enough money sent !");
        require(id < 10 , "This NFT does not exist !");
        require(totalSupply(id) + amount <= maxSupply , "Sorry we are out of stock :( ");
        _mint(msg.sender, id, amount, "");
        mintCount[msg.sender] += amount ;
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
