// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin-solidity/contracts/utils/math/SafeMath.sol";


contract PlynToken is ERC20, Ownable {
    using SafeMath for uint256;
    address[] internal stakeholders;

    uint256 public rate = 1000;
    uint constant gracePeriod = 2 hours;
    uint constant weekly = 7 days;

    mapping(address => uint256) internal stakes;
    mapping(address => uint256) internal rewards;
    mapping(
        address => uint) public dueDate;
    mapping(address => uint256) internal locked;


    constructor() ERC20("LynnToken", "LTK") {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }

    // Buy tokens
    function buyToken(address buyer) public payable returns (uint256 amount) {
        require (msg.value > 0, "You need money for this transaction");
        amount = msg.value * rate;
        _mint(buyer, amount);
    }

    // Adjust token price
    function modifyTokenBuyPrice(uint256 newRate) public onlyOwner {
        rate = newRate;
    }

    // STAKEHOLDERS
    // Add stakeholder
    function addStakeholder(address staker) private {
        (bool _checkStakeholder, ) = checkStakeholder(staker);
        if(!_checkStakeholder) stakeholders.push(staker);
    }

    // Remove stakeholder
    function removeStakeholder(address staker) private {
        (bool _checkStakeholder, uint256 verified) = checkStakeholder(staker);
        if(_checkStakeholder){
            stakeholders[verified] = stakeholders[stakeholders.length - 1];
            stakeholders.pop();
        }
    }

    // Verify stakeholder
    function checkStakeholder(address stakeholder_address) public view returns(bool, uint256) {
        for (
            uint256 valid;
            valid < stakeholders.length;
            valid++){
                if (stakeholder_address == stakeholders[valid]) return (true, valid);
            }
        return (false, 0);
    }

    // View all stakeholders
    function allStakeholders() public view onlyOwner returns ( address [] memory ) {
        return stakeholders;
    }
    

    // STAKING
    // Add stake
    function createStake(uint256 amountStaked) public {
        require(amountStaked > 0, "Stake Amount cannot be zero");
        amountStaked = amountStaked *1e18;
        _burn(msg.sender, amountStaked);
        if(stakes[msg.sender] == 0) addStakeholder(msg.sender);
        stakes[msg.sender] = stakes[msg.sender].add(amountStaked);
        dueDate[msg.sender] = block.timestamp + weekly;
    }

    // Remove stake
    function removeStake(uint256 amountStaked) public {
        amountStaked = amountStaked *1e18;
        stakes[msg.sender] = stakes[msg.sender].sub(amountStaked);
        if(stakes[msg.sender] == 0) removeStakeholder(msg.sender);
        _mint(msg.sender, amountStaked);
    }

    // Check amount staked
    function stakeOf() public view returns (uint256) {
        return stakes[msg.sender];
    }

    // Total staked
    function combinedStake() public view returns(uint256) {
        uint256 totalStakes;
        for (
            uint256 valid; 
            valid < stakeholders.length; 
            valid += 1){
                totalStakes = totalStakes.add(stakes[stakeholders[valid]]);
            }
        return totalStakes;
    }


    // REWARDS
    // Check reward due date
    function checkRewardDueDate () public view returns (uint) {
        return dueDate[msg.sender];
    }

    modifier checkDueDate () {
        require (block.timestamp >= dueDate[msg.sender], "You are not due for a reward yet");
        _;
    }

    // Reward per stakeholder 
    function calculateReward(address staker) public view returns(uint256) {
        return stakes[staker]/ 100;
    }

    // Withdraw reward
    function claimReward() public checkDueDate {
        if (block.timestamp >= dueDate[msg.sender] + gracePeriod) {
            dueDate[msg.sender] = block.timestamp + weekly;
        } else {
            uint amount = calculateReward(msg.sender);
            dueDate[msg.sender] = block.timestamp + weekly;
            _mint(msg.sender, amount);
        }
    }   
}
