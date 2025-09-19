import { loadFixture } from "@nomicfoundation/hardhat-toolbox/network-helpers.js";
import chai from "chai";

const { expect } = chai;

describe("ProfessorCoin", function () {
  async function deployFixture() {
    const [owner] = await ethers.getSigners();
    const ProfessorCoin = await ethers.getContractFactory("ProfessorCoin");
    const coin = await ProfessorCoin.deploy(owner.address);
    return { coin, owner };
  }

  it("mints 100 tokens to recipient", async function () {
    const { coin, owner } = await loadFixture(deployFixture);
    const decimals = await coin.decimals();
    const expected = 100n * 10n ** BigInt(decimals);
    const balance = await coin.balanceOf(owner.address);
    expect(balance).to.equal(expected);
  });
});


