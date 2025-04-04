import { ethers } from "hardhat";
import { GAS_LIMIT } from "./common/constants";
import { AgentVault, AgentVaultFactory, TestStrategy, TestToken } from "@typechains";

/* Input */
const agentAddress = "0x0000000000000000000000000000000000000000";
const vaultAddress = "0x0000000000000000000000000000000000000000";

const setAgent = async () => {
  const [developer] = await ethers.getSigners();

  const vaultContract = await ethers.getContract<AgentVault>("AgentVault", vaultAddress);
  await (
    await vaultContract.connect(developer).grantAgentRole(developer.address, {
      gasLimit: GAS_LIMIT.BASE_SEPOLIA,
    })
  ).wait();

  console.log("🚀 Agent role set to - ", agentAddress);
};

setAgent();
