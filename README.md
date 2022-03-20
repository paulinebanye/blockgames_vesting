# BLOCKGAMES INTERNSHIP TASK 5 - STAKING & VESTING

## BRIEF
Create a simple user UI/Frontend that interacts with a staking/vesting contract

#
## OBECTIVES
- Extend an ERC20 to support staking and rewards. Users can stake some of their tokens. When users stake their tokens, they are effectively locked and can't be transferred or spent.
- Make your contract Ownable and assign the owner 1000 tokens initially. Create a function modifyTokenBuyPrice and restrict access only to the owner.
- Create a function buyToken that can be called publicly to buy/mint new tokens.
- Create a Rewards System, where users can earn 1% of their stake. They will be able to call a function to claim rewards which will increment their balance. They will only be eligible to claim rewards every week, and users who don't claim their rewards effectively lose them for that week.
- Create a basic User Interface that makes use of web3.js or ethers.js to interact with your smart contract. User UI should show Users the number of tokens staked, give them the ability to stake tokens, give them the ability to view their token balance, and give them the ability to transfer tokens.
- Create a simple ERC20 and ERC721 tokens that make use of inheritance and imported libraries, using any framework of your choice(remix, hardhat or truffle).

#

## VERIFIED CONTRACT ADDRESSES


#
## Basic Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts.

Try running some of the following tasks:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
node scripts/sample-script.js
npx hardhat help
```
