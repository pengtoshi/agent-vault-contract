import { ethers, upgrades } from "hardhat";
import { DeployFunction, DeploymentSubmission } from "hardhat-deploy/types";
import { HardhatRuntimeEnvironment } from "hardhat/types";

// Change values by network
const AGENT_INITIAL_FUND = ethers.utils.parseEther("0.01"); // 0.01 ETH

const func: DeployFunction = async (hre: HardhatRuntimeEnvironment) => {
  const { deployments } = hre;
  const { save } = deployments;

  const [developer] = await ethers.getSigners();

  const network = process.env.NETWORK;
  if (network !== "base_sepolia") {
    throw new Error(`😇 This script is only for base sepolia.`);
  }
  console.log("🪴 Deploy started with wallet: ", developer.address);

  // Deploy AgentVaultFactory
  const AgentVaultFactoryContract = await ethers.getContractFactory("AgentVaultFactory");
  const agentVaultFactory = await upgrades.deployProxy(AgentVaultFactoryContract, [AGENT_INITIAL_FUND], {
    kind: "uups",
  });
  console.log("🚀 AgentVaultFactory deployed at", agentVaultFactory.address);

  const agentVaultFactoryArtifact = await deployments.getExtendedArtifact("AgentVaultFactory");
  const agentVaultFactoryDeployments: DeploymentSubmission = {
    address: agentVaultFactory.address,
    ...agentVaultFactoryArtifact,
  };
  await save("AgentVaultFactory", agentVaultFactoryDeployments);
};

export default func;
func.tags = ["001_deploy_agent_vault_factory"];
