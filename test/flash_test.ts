import { Contract } from "ethers";
import { ethers } from "hardhat";
import { expect } from "chai";
import { Flash } from "../typechain-types";

describe("Flash test", () => {
  let flash: Contract;
  const DAI_ADDRESS: string = "0xc7AD46e0b8a400Bb3C915120d284AafbA8fc4735";
  const testDAIAmount: number = 50;
  //ganache address
  const SENDER_ADDRESS: string = "0x1B359b62CB683aB501a2Dd8bF92310BFB6c824c6";

  it("should deploy contract", async () => {
    const FlashFactory = await ethers.getContractFactory("Flash");
    flash = await FlashFactory.deploy();
    await flash.deployed();

    expect(flash.address).is.not.null;
  });

  // borrow
  it("should borrow", async () => {
    const result = await flash.borrow(
      DAI_ADDRESS,
      ethers.utils.parseUnits("50"),
      {
        from: SENDER_ADDRESS,
        value: ethers.utils.parseEther("1000000000000000000"),
      }
    );
    console.log(result);
  });
});
