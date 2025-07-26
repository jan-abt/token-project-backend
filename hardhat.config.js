require('@nomicfoundation/hardhat-ignition-ethers');


const { vars } = require("hardhat/config");

// developer api keys can be attained here: https://developer.metamask.io/
const INFURA_API_KEY = vars.get("INFURA_API_KEY");
const SEPOLIA_TEST_ACCOUNT_1_PRIVATE_KEY = vars.get("SEPOLIA_TEST_ACCOUNT_1_PRIVATE_KEY");


module.exports = {
  solidity: "0.8.30", // Updated Solidity version as you mentioned
  networks: {
    localhost: {
      url: "http://127.0.0.1:8545",
      chainId: 31337,
    },
    sepolia: {
      url: `https://sepolia.infura.io/v3/${INFURA_API_KEY}`, 
      accounts: [SEPOLIA_TEST_ACCOUNT_1_PRIVATE_KEY], // Exported from MetaMask
      chainId: 11155111,
    },
  },
  // Ignition configuration (default settings are fine for local use)
  ignition: {
    requiredConfirmations: 1, // For local network, 1 confirmation is sufficient
  },
};