// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "openzeppelin-solidity/contracts/utils/math/SafeMath.sol";


contract PlynToken is ERC20, Ownable {
    using SafeMath for uint256;
    address[] internal stakeholders;

    mapping(address => uint256) internal stakes;
   
    constructor(address _owner, uint256 _supply) ERC20("LynnToken", "LTK") {
        _mint(_owner, _supply);
    }

    function isStakeholder(address _address)
        public view returns(bool, uint256) {
        for (
            uint256 stakers = 0;
            stakers < stakeholders.length;
            stakers += 1
            ){
                if (_address == stakeholders[stakers]) return (true, stakers);
            }
        return (false, 0);
    }
    
    function addStakeholder(address _stakeholder)
        public {
        (bool _isStakeholder, ) = isStakeholder(_stakeholder);
        if(!_isStakeholder) stakeholders.push(_stakeholder);
    }

    function removeStakeholder(address _stakeholder) public {
        (bool _isStakeholder, uint256 stakers) = isStakeholder(_stakeholder);
        if(_isStakeholder){
            stakeholders[stakers] = stakeholders[stakeholders.length - 1];
            stakeholders.pop();
        }
    }

    function stakeOf(address _stakeholder) public view returns(uint256){
        return stakes[_stakeholder];
    }

    function totalStakes() public view returns(uint256){
        uint256 _totalStakes = 0;
        for (
            uint256 stakers = 0; 
            stakers < stakeholders.length; 
            stakers += 1){
            _totalStakes = _totalStakes.add(stakes[stakeholders[stakers]]);
        }
        return _totalStakes;
    }

    function createStake(uint256 _stake) public {
        _burn(msg.sender, _stake);
        
    }
}