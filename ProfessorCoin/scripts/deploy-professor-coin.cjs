/* eslint-disable no-console */
const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  console.log("Deployer:", deployer.address);

  const ProfessorCoin = await hre.ethers.getContractFactory("ProfessorCoin");
  const coin = await ProfessorCoin.deploy(deployer.address);
  await coin.waitForDeployment();

  const address = await coin.getAddress();
  console.log("ProfessorCoin deployed to:", address);

  const balance = await coin.balanceOf(deployer.address);
  console.log("Initial balance minted to deployer:", balance.toString());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});


