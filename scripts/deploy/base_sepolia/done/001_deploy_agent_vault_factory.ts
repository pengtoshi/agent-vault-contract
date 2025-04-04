import { ethers, upgrades } from "hardhat";
import { DeployFunction, DeploymentSubmission } from "hardhat-deploy/types";
import { HardhatRuntimeEnvironment } from "hardhat/types";

const func: DeployFunction = async (hre: HardhatRuntimeEnvironment) => {
  const { deployments } = hre;
  const { save } = deployments;

  const [developer] = await ethers.getSigners();

  const network = process.env.NETWORK;
  if (network !== "base_sepolia") {
    throw new Error(`😇 This script is only for base sepolia.`);
  }
  console.log("🪴 Deploy started with wallet: ", developer.address);

  // AgentVaultFactory 배포
  const AgentVaultFactoryContract = await ethers.getContractFactory("AgentVaultFactory");
  const agentVaultFactory = await upgrades.deployProxy(AgentVaultFactoryContract, [], {
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
