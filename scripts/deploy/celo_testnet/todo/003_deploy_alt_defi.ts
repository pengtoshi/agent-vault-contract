import { ethers } from "hardhat";
import { DeployFunction } from "hardhat-deploy/types";
import { HardhatRuntimeEnvironment } from "hardhat/types";
import { TestToken } from "@typechains";

const func: DeployFunction = async (hre: HardhatRuntimeEnvironment) => {
  const { deployments } = hre;
  const { deploy } = deployments;

  const [developer] = await ethers.getSigners();

  const network = process.env.NETWORK;
  if (network !== "celo_testnet") {
    throw new Error(`😇 This script is only for celo testnet.`);
  }
  console.log("🪴 Deploy started with wallet: ", developer.address);

  const testToken = await ethers.getContract<TestToken>("TestToken");

  // Deploy AltTestDefi (2000% yield rate)
  const YIELD_RATE = 200000; // 2000%
  const altTestDefi = await deploy("AltTestDefi", {
    from: developer.address,
    contract: "TestDefi",
    args: [testToken.address, YIELD_RATE],
    log: true,
    autoMine: true,
  });
  console.log("🚀 AltTestDefi deployed at", altTestDefi.address);

  // Deploy AltTestStrategy
  const altTestStrategy = await deploy("AltTestStrategy", {
    from: developer.address,
    contract: "TestStrategy",
    args: [testToken.address, altTestDefi.address],
    log: true,
    autoMine: true,
  });
  console.log("🚀 AltTestStrategy deployed at", altTestStrategy.address);
};

export default func;
func.tags = ["003_deploy_alt_defi"];
