import { ethers } from "hardhat";
import { GAS_LIMIT } from "./common/constants";
import { AgentVaultFactory, TestStrategy, TestToken } from "@typechains";

const createTestVault = async () => {
  const [developer] = await ethers.getSigners();

  const testToken = await ethers.getContract<TestToken>("TestToken");
  const testStrategy = await ethers.getContract<TestStrategy>("TestStrategy");
  const altTestStrategy = await ethers.getContract<TestStrategy>("AltTestStrategy");
  const agentVaultFactory = await ethers.getContract<AgentVaultFactory>("AgentVaultFactory");

  await (
    await agentVaultFactory
      .connect(developer)
      .createVault(testToken.address, testStrategy.address, developer.address, developer.address, "AIVault1", "AIV1", {
        gasLimit: GAS_LIMIT.BASE_SEPOLIA_CONTRACT_DEPLOYMENT,
      })
  ).wait();

  await (
    await agentVaultFactory
      .connect(developer)
      .createVault(
        testToken.address,
        altTestStrategy.address,
        developer.address,
        developer.address,
        "AIVault2",
        "AIV2",
        {
          gasLimit: GAS_LIMIT.BASE_SEPOLIA_CONTRACT_DEPLOYMENT,
        },
      )
  ).wait();

  const vaultList = await agentVaultFactory.getAllVaults();
  console.log("Vault list: \n", vaultList.map((vault) => vault.toString()).join("\n"));
};

createTestVault();
