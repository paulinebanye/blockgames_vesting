const main = async () => {
  const [deployer] = await hre.ethers.getSigners();
  // const accountBalance = await deployer.getBalance();

  console.log("Deploying contracts with account: ", deployer.address);
  // console.log("Account balance: ", accountBalance.toString());

  const PlynTokenFactory = await hre.ethers.getContractFactory(
    "PlynToken"
  );
  const plyncontract = await PlynTokenFactory.deploy();
  await plyncontract.deployed();

  console.log("plyncontract address: ", plyncontract.address);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (err) {
    console.log(err);
    process.exit(1);
  }
};

runMain();