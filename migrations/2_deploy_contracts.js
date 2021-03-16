const Consumer = artifacts.require("Consumer");
const Oracle = artifacts.require("Oracle")

module.exports = async function (deployer, _network, accounts) {
    const [admin, reporter, _] = accounts;
    await deployer.deploy(Oracle, {from: admin});
    const oracle = await Oracle.deployed();
    await oracle.updateReporter(reporter,true,  {from: admin});
    await deployer.deploy(Consumer, oracle.address);
    const consumer = await Consumer.deployed();
    
};
