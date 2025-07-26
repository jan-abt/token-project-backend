// backend/ignition/modules/MyToken.js - Ignition module for deploying MyToken contract

const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

// Export the module using buildModule
module.exports = buildModule("MyTokenModule", (m) => {
  // Get the contract factory for MyToken (assumes MyToken.sol is in contracts/)
  const myToken = m.contract("MyToken");

  // Return the deployed contract instance for artifact generation
  return { myToken };
});