import { ethers } from "hardhat";

async function main() {
  const Flash = ethers.getContractFactory("Flash");
  const flash = await (await Flash).deploy();

  flash.deployed();
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
