pragma solidity >= 0.7.0 < 0.8.0;

contract Geoblock is Ownable {
	
	uint32 isSetterLevel = 5;

	struct UserCacheLink {
		uint cacheId;
		address userAddress;
	}
	
	struct User {
		uint128 experience;
		uint32 level;
		string name;
		//bool isHunter; // Everyone is Hunter
		/***
     * Computed Values
     ********************
		 * list started_caches
		 * list finished_caches
		 * list isSetter
		 ***/
	};

	struct Cache {
		string latitude;
		string longitude;
		string salt;
		bytes32 hash;
		string difficultyDescription;
		bool enabled;
		address creator;
		uint256 attempts;
		uint256 successfulAttempts;
	};

	// Check whether the user is a high enough level to be a setter
	function _isSetter(address _address) internal view returns (bool) {
		return addressToUser[_address].level >= isSetterLevel;
	}

	// gets all enabled caches. Accessible to anyone
	function getEnabledCaches() external view returns(uint[]){
		uint[] memory result;
		for(uint i = 0; i < caches.length; i++) {
			if(caches[i].enabled) {
				result.push(i);
			}
		}
		return result;
	}

	// gets all caches that the "Setter" has created
	function getCreatedCaches() external view returns(uint[]) {
		require(_isSetter(msg.sender));
		uint[] memory result;
		for(uint i = 0; i < caches.length; i++) {
			if(caches[i].creator == msg.sender) {
				result.push(i);
			}
		}
		return result;
	}

	// gets all the caches that the "Hunter" has started
	function getStartedCaches() external view returns(uint[]) {
		//require(_isHunter(msg.sender)); // all users are hunters.
		uint[] memory result;
		for(uint i = 0; i < startedCacheLink.length; i++) {
			if(startedCacheLink[i].userAddress == msg.sender) {
				result.push(startedCacheLink[i].cacheId);
			}
		}
		return result;
	}

	function getFinishedCaches() external view returns(uint[]) {
		//require(_isHunter(msg.sender)); // all users are hunters.
		uint[] memory result;
		for(uint i = 0; i < finishedCacheLink.length; i++) {
			if(finishedCacheLink[i].userAddress == msg.sender) {
				result.push(finishedCacheLink[i].cacheId);
			}
		}
		return result;
	}
	
	Cache[] public caches;
	UserCacheLink[] public startedCacheLink;
	UserCacheLink[] public finishedCacheLink;

	mapping(address => User) public addressToUser;
	
	function getUser(address userAddress) public view returns {
		return users[userAddress];
	}
	
}
