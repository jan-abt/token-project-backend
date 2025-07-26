// backend/scripts/deploy.js - Script to deploy MyToken contract

const hre = require("hardhat");

async function main() {
  // Get the contract factory for MyToken
  const MyToken = await hre.ethers.getContractFactory("MyToken");
  // Deploy the contract
  const myToken = await MyToken.deploy();
  // Wait for deployment to complete
  await myToken.waitForDeployment();
  // Log the deployed address
  console.log(`MyToken deployed to: ${await myToken.getAddress()}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});