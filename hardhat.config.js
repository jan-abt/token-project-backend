require('@nomicfoundation/hardhat-ignition-ethers');

// Read npx hardhat vars (or fallback to process.env)
const { vars } = require("hardhat/config");

const INFURA_API_KEY = vars.get("INFURA_API_KEY"); // INFURA_API_KEY from https://developer.metamask.io/
const HARDHAT_MNEMONIC = vars.get("HARDHAT_MNEMONIC"); 
const SEPOLIA_MNEMONIC = vars.get("SEPOLIA_MNEMONIC"); 

module.exports = {
  solidity: "0.8.30",
  networks: {
    localhost: {
      url: "http://127.0.0.1:8545",
      chainId: 31337,
      accounts: {
        mnemonic: HARDHAT_MNEMONIC, // hardhat mnemonic; pre-funded by default
      },
    },
    sepolia: {
      url: `https://sepolia.infura.io/v3/${INFURA_API_KEY}`,
      chainId: 11155111,
      accounts: {
        mnemonic: SEPOLIA_MNEMONIC, // sepolia-specific mnemonic; for funding, try https://cloud.google.com/application/web3/faucet/ethereum/sepolia
      },
    },
  },
  ignition: {
    requiredConfirmations: 1,
  },
};


// task to verify accounts and balances
// execute with: npx hardhat accounts --network localhost | --network localhost
task("accounts", "Prints accounts and balances", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();
  for (const account of accounts) {
    const balance = await hre.ethers.provider.getBalance(account.address);
    console.log(` - ${account.address}: ${hre.ethers.formatEther(balance)} ETH`);
  }
});