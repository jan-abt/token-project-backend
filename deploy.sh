#!/bin/bash

########################################
#  * Dynamic deployment script for development (dev) or production (prod) environments.
#  * Usage: ./deploy.sh [dev|prod]
#  * - dev: Starts local Hardhat node and deploys to localhost (chain ID 31337).
#  * - prod: Deploys to Sepolia testnet (chain ID 11155111) without starting a local node.
#  * Defaults to dev if no argument provided.
########################################

# Exit script if any command fails
set -e

# set -x  # Uncomment for debugging: print commands before execution

# Get the environment argument (dev or prod), default to dev
ENV=${1:-dev}

printf "\nDeployment environment: $ENV\n"

if [ "$ENV" = "hardhat" ]; then
  # Start Hardhat node for dev environment

  printf "\nStarting Hardhat node..."

  # Check and/or kill process using port 8545
  # get PID using port 8545 (don't fail if empty)
  PID=$(lsof -ti tcp:8545 || true)
  if [ -n "$PID" ]; then
    printf "\n🔓  Port 8545 is in use by PID $PID."
    printf "\n    (Find PID manually via lsof -wni tcp:8545)"
    printf "\n Killing it ..."
    if kill -9 "$PID"; then
      printf "\n 💀 Process $PID has been killed.\n"
    else
      printf "\n⚠️  Failed to kill PID $PID. Continuing anyway..."
    fi
  fi

  npx hardhat node > node.log 2>&1 &
  printf "\nStarted Hardhat node with PID $!\n"

  printf "\n⏳ Waiting for 5 seconds...\n\n"
  sleep 5

  # Deploy to localhost in dev mode
  npx hardhat ignition deploy ./ignition/modules/MyToken.js --network localhost

elif [ "$ENV" = "sepolia" ]; then

  # Deploy to Sepolia
  npx hardhat ignition deploy ./ignition/modules/MyToken.js --network sepolia

else
  printf "\n⚠️  Invalid environment: $ENV. Use 'hardhat' or 'sepolia'.\n"
  exit 1
fi

printf "\n👍 Run script ran successfully for $ENV environment.\n\n"