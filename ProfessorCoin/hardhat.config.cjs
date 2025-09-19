require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

const { ALCHEMY_API_KEY, INFURA_API_KEY, PRIVATE_KEY } = process.env;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.28",
    settings: {
      optimizer: { enabled: true, runs: 200 },
      evmVersion: "paris",
    },
  },
  networks: {
    hardhat: { chainId: 31337 },
    sepolia: {
      url:
        (ALCHEMY_API_KEY && `https://eth-sepolia.g.alchemy.com/v2/${ALCHEMY_API_KEY}`) ||
        (INFURA_API_KEY && `https://sepolia.infura.io/v3/${INFURA_API_KEY}`) ||
        "https://ethereum-sepolia-rpc.publicnode.com",
      accounts: PRIVATE_KEY ? [PRIVATE_KEY] : [],
    }
  },
  mocha: { timeout: 60000 },
};
