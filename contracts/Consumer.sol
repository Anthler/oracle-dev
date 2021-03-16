pragma solidity 0.7.3;

import "./IOracle.sol";

contract Consumer {

    IOracle public oracle;
    //mapping(bytes32 => ) public lastPrices
    constructor(address _oracle){
        oracle = IOracle(_oracle);
    }

    function getData() public view returns(bool, uint, uint){
        bytes32 key = keccak256(abi.encodePacked('BTC/USD'));
        (bool success, uint date, uint payload) = oracle.getData(key);
        require(success, "No data was fetched");
        require(block.timestamp - 2 minutes >= payload, "Price too old");
        // I willl do something with the data
    }
}