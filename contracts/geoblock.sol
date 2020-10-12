pragma solidity >= 0.7.0 < 0.8.0;

contract Geoblock {
	struct User {
		int32 level;
		string name;
	};

	struct GeoCache {
		string latitude;
		string longitude;
		string salt;e
		bytes32 hash;
	};

	mapping(address => User) public users;
	mapping(uint => address) public erc721ToOwner;
	
	function getUser(address userAddress) public view returns {
		return users[userAddress];
	}

	function getErc721(address userAddress) {
		
	}

	
}
