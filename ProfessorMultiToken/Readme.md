# ProfessorNFT

A Solidity smart contract for a mintable and pausable **ERC-1155 NFT collection** with both **public minting** and **allowlist minting** functionality.  

Built with **OpenZeppelin Contracts v5.4**.  

---

## ✨ Features
- 🎨 ERC-1155 multi-token standard  
- ⛔ Pausable contract controls (owner can pause/unpause)  
- ✅ Allowlist minting (0.0005 ETH per NFT)  
- 🌍 Public minting (0.001 ETH per NFT)  
- 📦 Max supply capped at **10 per token ID**  
- 👥 Max **5 NFTs per wallet**  
- 💸 Automatic revenue sharing via **PaymentSplitter**  
- 🗂️ Metadata hosted on IPFS  

---

## 📝 Contract Details

- **Name:** Professor  
- **Standard:** ERC-1155  
- **Max Supply:** 10 per token ID  
- **Base URI:** `ipfs://Qmaa6TuP2s9pSKczHF4rwWhTKUdygrrDs8RmYYqCjP3Hye/`  

### Functions
- `publicMint(uint256 id, uint256 amount)` → Mint NFTs during public sale (0.001 ETH each)  
- `allowListMint(uint256 id, uint256 amount)` → Mint NFTs if allowlisted (0.0005 ETH each)  
- `addAllowList(address[] calldata addresses)` → Add addresses to allowlist  
- `setMintWindows(bool publicOpen, bool allowListOpen)` → Toggle minting phases  
- `pause()` / `unpause()` → Pause/unpause contract  
- `mintBatch(address to, uint256[] ids, uint256[] amounts, bytes data)` → Batch mint (owner only)  
- `withdraw(address recipient)` → Withdraw all ETH from contract  
- `uri(uint256 id)` → Returns token metadata URI  

---

## 🔒 Security

Only the **contract owner** can:  
- Withdraw funds  
- Pause/unpause minting  
- Manage allowlist  
- Perform batch minting  

Other security measures:  
- Minting requires exact ETH payment  
- Max 5 NFTs per wallet  
- Max 10 NFTs per token ID ensures scarcity  
- Contract is pausable in emergencies  
