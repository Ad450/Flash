import { Contract } from "ethers";
import { ethers } from "hardhat";
import { expect } from "chai";

describe("Flash test", () => {
  let flash: Contract;

  it("should deploy contract", async () => {
    const FlashFactory = await ethers.getContractFactory("Flash");
    flash = await FlashFactory.deploy();
    await flash.deployed();

    expect(flash.address).is.not.null;
  });

  // borrow
});
