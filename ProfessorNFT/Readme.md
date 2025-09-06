# ProfessorNFT

A Solidity smart contract for a mintable and pausable ERC-721 NFT collection with both **public minting** and **allowlist minting** functionality.  

Built with **OpenZeppelin Contracts v5.4**.  

---

## ✨ Features
- 🎨 ERC-721 NFTs with enumerable support  
- ⛔ Pausable contract controls (owner can pause/unpause)  
- ✅ Allowlist minting (0.001 ETH per mint)  
- 🌍 Public minting (0.01 ETH per mint)  
- 📦 Max supply capped at 1000 NFTs  
- 💸 Owner-only fund withdrawal  
- 🗂️ Metadata hosted on IPFS  

---

## 📝 Contract Details

- **Name:** Professor  
- **Symbol:** PF  
- **Max Supply:** 1000  
- **Base URI:** `ipfs://QmY5rPqGTN1rZxMQg2ApiSZc7JiBNs1ryDzXPZpQhC1ibm/`  

### Functions
- `publicMint()` → Mint an NFT (0.01 ETH)  
- `allowListMint()` → Mint an NFT if allowlisted (0.001 ETH)  
- `setAllowList(addresses[])` → Add addresses to allowlist  
- `pause()` / `unpause()` → Pause/unpause contract  
- `withdraw(address)` → Withdraw all ETH to owner address  
- `editMintOpen(bool publicMint, bool allowListMint)` → Toggle minting phases  

---

## 🔒 Security

Only the **contract owner** can:  
- Withdraw funds  
- Pause/unpause  
- Manage allowlist  

Other security measures:  
- Minting requires correct ETH payment  
- Max supply ensures scarcity  
