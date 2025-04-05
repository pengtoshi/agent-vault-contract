import { ethers } from "hardhat";
import { GAS_LIMIT } from "./common/constants";
import { AgentVault, AgentVaultFactory, TestStrategy, TestToken } from "@typechains";

/* Input */
// TODO: Uncomment if Agent address is set separately
// const agentAddress = "0x0000000000000000000000000000000000000000";
const strategyVaultAddress = "0x1c55A489B09783E7D71a864444D13816705DE2AC";
const altStrategyVaultAddress = "0x6B600892Cc3250AC0a5be99C63Ac6F1e63092F31";

const setAgent = async () => {
  const [developer] = await ethers.getSigners();

  const vaultContract = await ethers.getContractAt<AgentVault>("AgentVault", strategyVaultAddress);
  await (
    await vaultContract.connect(developer).grantAgentRole(developer.address, {
      gasLimit: GAS_LIMIT.BASE_SEPOLIA,
    })
  ).wait();

  // console.log("🚀 Vault - Agent role set to - ", agentAddress);
  console.log("🚀 Vault - Agent role set to ", developer.address);

  const altVaultContract = await ethers.getContractAt<AgentVault>("AgentVault", altStrategyVaultAddress);
  await (
    await altVaultContract.connect(developer).grantAgentRole(developer.address, {
      gasLimit: GAS_LIMIT.BASE_SEPOLIA,
    })
  ).wait();

  // console.log("🚀 Alt Vault - Agent role set to - ", agentAddress);
  console.log("🚀 Alt Vault - Agent role set to ", developer.address);
};

setAgent();
