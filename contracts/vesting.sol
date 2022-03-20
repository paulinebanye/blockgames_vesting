// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin-solidity/contracts/utils/math/SafeMath.sol";


contract PlynToken is ERC20, Ownable {
    using SafeMath for uint256;
    address[] internal stakeholders;
    uint256 public rate = 1000;

    mapping(address => uint256) internal stakes;
    mapping(address => uint256) internal rewards;
    
   
    constructor() ERC20("LynnToken", "LTK") {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }

    // set purchase rate
    function setRate(uint256 newRate) public onlyOwner {
        rate = newRate;
    }
    
    // purchase tokens
    // function buyToken(address buyer, uint256 amount) public payable {
    function buyToken(address buyer) public payable returns (uint256 amount) {
        require (msg.value > 0, "You need money for this transaction");
        amount = msg.value * rate;
        _mint(buyer, amount);
    }


    // to verify stakeholder
    // s = verified
    //  _address = stakeholder_address
    function isStakeholder(address stakeholder_address) public view returns(bool, uint256) {
        for (
            uint256 verified = 0;
            verified < stakeholders.length;
            verified += 1){
                if (stakeholder_address == stakeholders[verified]) return (true, verified);
            }
        return (false, 0);
    }
    

    // to add new & remove a stakeholder
    // _stakeholder = staker
    function addStakeholder(address staker) public {
        (bool _isStakeholder, ) = isStakeholder(staker);
        if(!_isStakeholder) stakeholders.push(staker);
    }

    function removeStakeholder(address staker) public {
        (bool _isStakeholder, uint256 verified) = isStakeholder(staker);
        if(_isStakeholder){
            stakeholders[verified] = stakeholders[stakeholders.length - 1];
            stakeholders.pop();
        }
    }

    
    // check amount staked by a stakeholder
    function stakeOf(address staker) public view returns (uint256) {
        return stakes[staker];
    }


    // check total of all stakes
    function combinedStake() public view returns(uint256) {
        uint256 totalStakes = 0;
        for (
            uint256 verified = 0; 
            verified < stakeholders.length; 
            verified += 1){
                totalStakes = totalStakes.add(stakes[stakeholders[verified]]);
            }
        return totalStakes;
    }

    // for stakeholder to add and remove a stake
    function createStake(uint256 _stake)
       public
    {
        _burn(msg.sender, _stake);
        if(stakes[msg.sender] == 0) addStakeholder(msg.sender);
        stakes[msg.sender] = stakes[msg.sender].add(_stake);
    }

    function removeStake(uint256 _stake) public {
        stakes[msg.sender] = stakes[msg.sender].sub(_stake);
        if(stakes[msg.sender] == 0) removeStakeholder(msg.sender);
        _mint(msg.sender, _stake);
    }


    // check stakeholder reward
    function rewardOf(address staker) public view returns(uint256) {
        return rewards[staker];
    }

    // check all stakeholder rewards
    function combinedRewards() public view returns(uint256) {
        uint256 totalRewards = 0;
        for (
            uint256 verified = 0; 
            verified < stakeholders.length; 
            verified += 1){
                totalRewards = totalRewards.add(rewards[stakeholders[verified]]);
            }
        return totalRewards;
    }


    // calculate reward per stakeholder
    function calculateReward(address _stakeholder) public view returns(uint256) {
        return stakes[_stakeholder] / 100;
    }

    // share rewards to stakeholders
    function distributeRewards() public onlyOwner {
        for (
            uint256 verified = 0;
            verified < stakeholders.length;
            verified += 1){
                address stakeholder = stakeholders[verified];
                uint256 reward = calculateReward(stakeholder);
                rewards[stakeholder] = rewards[stakeholder].add(reward);
            }
        }
    }