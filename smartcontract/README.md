# HARDHAT SETUP FOR BACKEND

## Requirements
#
- Alchemy key
- Metamask key
- Etherscan.io API Url
#
## SET UP
#
- cd into smartcontract
- install hardhat: npm i -D hardhat
- setup basic project: npx hardhat
- install dependencies: npm install --save-dev "hardhat" "@nomiclabs/hardhat-waffle" "ethereum-waffle" "chai" "@nomiclabs/hardhat-ethers" "ethers" "web3 @nomiclabs/hardhat-web3" "@openzeppelin-solidity/contracts" "dotenv" "@nomiclabs/hardhat-etherscan" "@openzeppelin/contracts" 
- write smart contract code
- setup .env file
- retrieve alchemy, metamask & etherscan keys and setup hardhat.config

#
## COMPILE
- compile the smartcontract before deployment: npx hardhat compile
#
## DEPLOY
- To deploy: npx hardhat run scripts/deploy.js --network rinkeby
- To verify smartcontract: npx hardhat verify DEPLOYED_ADDRESS --network rinkeby
#
