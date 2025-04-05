import { ethers } from "hardhat";
import { DeployFunction } from "hardhat-deploy/types";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import { TestToken } from "@typechains";
import { GAS_LIMIT } from "../../../common/constants";

const func: DeployFunction = async (hre: HardhatRuntimeEnvironment) => {
  const { deployments } = hre;
  const { deploy } = deployments;

  const [developer] = await ethers.getSigners();

  const network = process.env.NETWORK;
  if (network !== "flow_testnet") {
    throw new Error(`😇 This script is only for flow testnet.`);
  }
  console.log("🪴 Deploy started with wallet: ", developer.address);

  // Deploy TestToken
  const testToken = await deploy("TestToken", {
    from: developer.address,
    args: ["Test Token", "TEST"], // 이름, 심볼, 초기 공급량
    log: true,
    autoMine: true,
  });
  console.log("🚀 TestToken deployed at", testToken.address);

  // TestToken Mint
  const testTokenContract = await ethers.getContract<TestToken>("TestToken");
  await (
    await testTokenContract.mint(developer.address, ethers.utils.parseEther("1000000"), {
      gasLimit: GAS_LIMIT.FLOW_TESTNET,
    })
  ).wait();
  console.log(`🚀 TestToken minted to ${developer.address}`);

  // Deploy TestDefi (1000% yield rate)
  const YIELD_RATE = 100000; // 1000%
  const testDefi = await deploy("TestDefi", {
    from: developer.address,
    args: [testToken.address, YIELD_RATE],
    log: true,
    autoMine: true,
  });
  console.log("🚀 TestDefi deployed at", testDefi.address);

  // Deploy TestStrategy
  const testStrategy = await deploy("TestStrategy", {
    from: developer.address,
    args: [testToken.address, testDefi.address],
    log: true,
    autoMine: true,
  });
  console.log("🚀 TestStrategy deployed at", testStrategy.address);
};

export default func;
func.tags = ["002_deploy_test_contracts"];
