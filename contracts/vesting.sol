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

    // set purchase rate working
    function modifyTokenBuyPrice(uint256 newRate) public onlyOwner {
        rate = newRate;
    }
    
    // purchase tokens working
    // function buyToken(address buyer, uint256 amount) public payable {
    function buyToken(address buyer) public payable returns (uint256 amount) {
        require (msg.value > 0, "You need money for this transaction");
        amount = msg.value * rate;
        _mint(buyer, amount);
    }


    // to verify stakeholder working
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
    

    // to add a stakeholder working
    // _stakeholder = staker
    function addStakeholder(address staker) public {
        (bool _isStakeholder, ) = isStakeholder(staker);
        if(!_isStakeholder) stakeholders.push(staker);
    }

    // to remove a stakeholder working
    function removeStakeholder(address staker) public {
        (bool _isStakeholder, uint256 verified) = isStakeholder(staker);
        if(_isStakeholder){
            stakeholders[verified] = stakeholders[stakeholders.length - 1];
            stakeholders.pop();
        }
    }

    // view list of stakeholders
    function viewStakeholder(address staker) public {
        (bool _isStakeholder,) = isStakeholder(staker);
        if(!_isStakeholder) stakeholders.push(staker);
    }

    
    // check amount staked by a stakeholder working
    function stakeOf(address staker) public view returns (uint256) {
        return stakes[staker];
    }


    // check total of all stakes working
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


    // for stakeholder to add a stake working
    function createStake(address staker, uint256 _stake) public {
        _burn(staker, _stake);
        if(stakes[staker] == 0) addStakeholder(staker);
        stakes[staker] = stakes[staker].add(_stake);
    }


    // for stakeholder to remove a stake working
    function removeStake(address staker, uint256 _stake) public {
        stakes[staker] = stakes[staker].sub(_stake);
        if(stakes[staker] == 0) removeStakeholder(staker);
        _mint(staker, _stake);
    }

    // 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    // 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
    // 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
    // 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB
    // 0xe7150d315F8930f040Bc9d3AC40162cA78FcfaA1
    // 0x583031D1113aD414F02576BD6afaBfb302140225


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


    // // calculate reward per stakeholder
    // function calculateReward(address staker) public view returns(uint256) {
    //     return stakes[staker] * 1/100;
    // }


    // calculate reward per stakeholder
    function calculateReward(address staker) public view returns(uint256) {
        return stakes[staker] /100;
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