# BLOCKGAMES INTERNSHIP TASK 5 - STAKING AND VESTING APP

## BRIEF
Create a simple user UI/Frontend that interacts with a staking/vesting contract
#
## OBECTIVES
- Extend an ERC20 to support staking and rewards. 
- Users can stake some of their tokens. When users stake their tokens, they are effectively locked and can't be transferred or spent.
- Make your contract Ownable and assign the owner 1000 tokens initially. Create a function modifyTokenBuyPrice and restrict access only to the owner.
- Create a function buyToken that can be called publicly to buy/mint new tokens.
- Create a Rewards System, where users can earn 1% of their stake. 
- They will be able to call a function to claim rewards which will increment their balance. 
- They will only be eligible to claim rewards every week.
- Users who don't claim their rewards effectively lose them for that week.
- Create a basic User Interface that makes use of web3.js or ethers.js to interact with your smart contract. 
- User UI should show Users the number of tokens staked.
- User UI should give them the ability to stake tokens.
- User UI should give them the ability to view their token balance.
- User UI shouldgive them the ability to transfer tokens.

## VERIFIED CONTRACT ADDRESSES
- Vesting contract: https://rinkeby.etherscan.io/address/0x2E6f309334dBDf065c9B39Aa63cdF69870B7A365#code
- Hosted domain: https://lynntoken-ui.vercel.app/