pragma solidity 0.7.3;

contract Oracle {

    address public admin;
    mapping(address => bool) public reporters;
    mapping(bytes32 => Data) public data;

    struct Data{
        uint date;
        uint payload;
    }

    constructor(){
        admin  = msg.sender;
    }

    function updateReporter(address newReporter, bool isReporter) external {
        require(msg.sender == admin);
        reporters[newReporter] = isReporter;
    }

    function updateData(bytes32 key, uint payload) external {
        require(reporters[msg.sender]);
        data[key] = Data(block.timestamp,payload);
    }

    function getData(bytes32 key) external view returns(bool success, uint timestamp, uint payload){
        if(data[key].date == 0){
            success = false;
            timestamp = 0;
            payload = 0;
        }
            success = true;
            timestamp = data[key].date;
            payload = data[key].payload;
    }

}