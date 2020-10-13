// contracts/test/SafeNamerTest.sol
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// SPDX-License-Identifier: MIT
const assert = require('assert');
const { contract, accounts,web3 } = require('@openzeppelin/test-environment');

const { expect } = require('chai');

// require('@openzeppelin/test-helpers/configure')({
//   provider: 'http://localhost:8545',  
//   // provider: web3.currentProvider,
//   singletons: {
//     abstraction: 'web3',
//     // abstraction: 'truffle',
//     defaultGas: 6e6,
//     defaultSender: '0x90F8bf6A479f320ead074411a4B0e7944Ea8c9C1',
//   },
// });

const { 
    BN,           // Big Number support
    constants,    // Common constants, like the zero address and largest integers
    ether,          // ether('1')=>1e18=>1000000000000000000
    expectEvent,    // Assertions for emitted events
    expectRevert,   // Assertions for transactions that should fail
    send,time } = require('@openzeppelin/test-helpers');//测试助手
// time tool
// await time.advanceBlock();
// await time.advanceBlockTo(target)
// await time.latest()
// await time.latestBlock()
// await time.increase(duration)
// await time.increaseTo(target)
// await time.increase(time.duration.years(2));

// Loads the built artifact from build/contracts/SPTC.json
// const ERC20 = artifacts.require('ERC20'); // truffle style
const FakeToken = contract.fromArtifact("FakeToken"); 
const PairNamerTest = contract.fromArtifact("PairNamerTest"); 
const MixNamerTest = contract.fromArtifact("MixNamerTest"); 

// get account from accounts array
[owner, sender, receiver, purchaser, beneficiary] = accounts;
const bnValue = new BN('18');

describe("test balance", function () { 
    it('check sender balance after send', async function () {
        ownerBalance = await web3.eth.getBalance(owner);
        send.ether(owner, receiver, ether('10'))
        assert.equal(ether('90').toString(),(await web3.eth.getBalance(owner)).toString());
    });
    it('check receiver balance after send ', async function () {
        assert.equal(ether('110').toString(),(await web3.eth.getBalance(receiver)).toString());
    });
});

// contract('ERC20', function (accounts) { //  truffle style
describe("SafeNamer test", function () {     
    beforeEach(async function() {
        pairNamer = await PairNamerTest.new({ from: owner });
        mixNamer = await MixNamerTest.new({ from: owner });
        tBaseNamer = [
            "SwapPetTokenBase",   // name
            "SPTB"              // symbol
        ];
        tokenBase = await FakeToken.new(...tBaseNamer, { from: owner });
        token1 = await FakeToken.new('tokenName1','TS1', { from: owner });
        token2 = await FakeToken.new('tokenName2','TS2', { from: owner });
        token3 = await FakeToken.new('tokenName3','TS3', { from: owner });
        token4 = await FakeToken.new('tokenName4','TS4', { from: owner });
        token5 = await FakeToken.new('tokenName5','TS5', { from: owner });
    });
    it('name()', async function () {
        assert.equal(tBaseNamer[0], await tokenBase.name());
    });
    it('symbol()', async function () {
        assert.equal(tBaseNamer[1], await tokenBase.symbol());
    });

    it('pairName for pre and suf', async function () {
        expect(await pairNamer.pairName( 'Swap.Pet Pre ', token1.address, tokenBase.address,'.')).to.equal('Swap.Pet Pre tokenName1-SwapPetTokenBase.');
    });
    it('pairName for defualt pre and suf', async function () {
        expect(await pairNamer.pairName("", token1.address, tokenBase.address,"")).to.equal('🐔tokenName1-SwapPetTokenBase🥚');
    });
    it('pairSymbol for pre and suf', async function () {
        expect(await pairNamer.pairSymbol( 'Swap.Pet Pre ', token1.address, tokenBase.address,'.')).to.equal('Swap.Pet Pre TS1-SPTB.');
    });
    it('pairSymbol for defualt pre and suf', async function () {
        expect(await pairNamer.pairSymbol("", token1.address, tokenBase.address,"")).to.equal('🐔TS1-SPTB🥚');
    });
    it('mixName for pre and suf', async function () {
        expect(await mixNamer.mixName( 'Swap.Pet Pre ', [token1.address,token2.address,token3.address], tokenBase.address,'.')).to.equal('Swap.Pet Pre tokenName1:tokenName2:tokenName3-SwapPetTokenBase.');
    });
    it('mixName for defualt pre and suf', async function () {
        expect(await mixNamer.mixName("", [token1.address,token2.address,token3.address], tokenBase.address,"")).to.equal('🐔tokenName1:tokenName2:tokenName3-SwapPetTokenBase🥚');
    });
    it('mixSymbol for pre and suf', async function () {
        expect(await mixNamer.mixSymbol( 'Swap.Pet Pre ', [token1.address,token2.address,token3.address], tokenBase.address,'.')).to.equal('Swap.Pet Pre TS1:TS2:TS3-SPTB.');
    });
    it('mixSymbol for defualt pre and suf', async function () {
        expect(await mixNamer.mixSymbol("", [token1.address,token2.address,token3.address], tokenBase.address,"")).to.equal('🐔TS1:TS2:TS3-SPTB🥚');
    });
});