// test/SPTE.js
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// SPDX-License-Identifier: MIT
const assert = require('assert');
const { expect } = require('chai'); 
const { contract, accounts,web3 } = require('@openzeppelin/test-environment');

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
    send,time } = require('@openzeppelin/test-helpers'); 
// time tool
// await time.advanceBlock();
// await time.advanceBlockTo(target)
// await time.latest()
// await time.latestBlock()
// await time.increase(duration)
// await time.increaseTo(target)
// await time.increase(time.duration.years(2));

// Loads a compiled artifact from build/contracts/SPTE.json 
// const TestContract = artifacts.require('SPTE'); // truffle style 
const TestContract = contract.fromArtifact("SPTE");
const ERC20 = require('./lib/ERC20');
const decimals = 18 // default for ERC20
const ERC20Detail = [
    "Swap.Pet Token of Eggs",   // name
    "SPTE",              // symbol 
    '100000000'              // totalSupply
];
// get account from accounts array
[owner, sender, receiver, purchaser, beneficiary] = accounts; 


describe("check test balance", function () {  
    it('check sender balance after send', async function () {
        ownerBalance = await web3.eth.getBalance(owner);
        send.ether(owner, receiver, ether('10'))
        assert.equal(ether('90').toString(),(await web3.eth.getBalance(owner)).toString());
    });
    it('check receiver balance after send ', async function () {
        assert.equal(ether('110').toString(),(await web3.eth.getBalance(receiver)).toString());
    });
}); 

describe("deploy contract", function () {
    it('deploy contract', async function () { 
        ERC20Ins = await TestContract.new(...ERC20Detail, { from: owner });
    });
});

describe("test basic detail of ERC20", function () {
    ERC20.detail(ERC20Detail);
    ERC20.decimals(decimals);
    it('deployer is owner', async function () { 
        expect(await ERC20Ins.owner()).to.equal(owner);
    });
});

tEther = '100'; // ether unit

let balanceBefore = [];

describe("first transfers to accounts", function () {
    ERC20.transfer(owner, constants.ZERO_ADDRESS, tEther, 'error rejects:transfer() to zero',true,/ERC20: transfer to the zero address/);
    
    it('reverts when transferring tokens to the zero address', async function () {
        // Conditions that trigger a require statement can be precisely tested
        await expectRevert(
          ERC20Ins.transfer(constants.ZERO_ADDRESS, ether(tEther), { from: owner }),
          'ERC20: transfer to the zero address',
        );
      });
    ERC20.transfer(owner, sender, (tEther * 1).toString(), 'to sender');
    ERC20.transfer(owner, receiver, (tEther * 2).toString(), 'to receiver');
    ERC20.transfer(owner, purchaser, (tEther * 3).toString(), 'to purchaser');
    ERC20.transfer(owner, beneficiary, (tEther * 4).toString(), 'to beneficiary');
    it('balance before first snapshot: balanceOf()', async function () {
        balanceBefore[owner] = await ERC20Ins.balanceOf(owner);
        balanceBefore[sender] = await ERC20Ins.balanceOf(sender);
        balanceBefore[receiver] = await ERC20Ins.balanceOf(receiver);
        balanceBefore[purchaser] = await ERC20Ins.balanceOf(purchaser);
        balanceBefore[beneficiary] = await ERC20Ins.balanceOf(beneficiary);
    });
});

describe("make first snapshot", async function () { 
    ERC20.snapshot (owner, 'owner make first snapshot')
    ERC20.snapshot (sender, 'sender make snapshot', true, /Ownable: caller is not the owner/)
    it('reverts when non-owner address make snapshot', async function () {
        // Conditions that trigger a require statement can be precisely tested
        await expectRevert(
          ERC20Ins.snapshot({ from: sender }),
          'Ownable: caller is not the owner',
        );
      });
});

describe("second transfers to accounts", function () {
    ERC20.transfer(owner, sender, (tEther * 10).toString(), 'to sender');
    ERC20.transfer(owner, receiver, (tEther * 20).toString(), 'to receiver');
    ERC20.transfer(owner, purchaser, (tEther * 30).toString(), 'to purchaser');
    ERC20.transfer(owner, beneficiary, (tEther * 40).toString(), 'to beneficiary');
});
describe("check first snapshot", async function () {
    it('check first snapshot:balanceOfAt()', async function () {
        assert.equal(balanceBefore[owner].toString(), (await ERC20Ins.balanceOfAt(owner, snapshotId)).toString());
        assert.equal(balanceBefore[sender].toString(), (await ERC20Ins.balanceOfAt(sender, snapshotId)).toString());
        assert.equal(balanceBefore[receiver].toString(), (await ERC20Ins.balanceOfAt(receiver, snapshotId)).toString());
        assert.equal(balanceBefore[purchaser].toString(), (await ERC20Ins.balanceOfAt(purchaser, snapshotId)).toString());
        assert.equal(balanceBefore[beneficiary].toString(), (await ERC20Ins.balanceOfAt(beneficiary, snapshotId)).toString());
    });
    it('check first snapshot for totalSupply: totalSupplyAt()', async function () {
        assert.equal(ether(ERC20Detail[2].toString()).toString(), (await ERC20Ins.totalSupplyAt(snapshotId)).toString());
    });
});

describe("balances before first snapshot", function () {
    it('before first snapshot:balanceOf()', async function () {
        balanceBefore[owner] = await ERC20Ins.balanceOf(owner);
        balanceBefore[sender] = await ERC20Ins.balanceOf(sender);
        balanceBefore[receiver] = await ERC20Ins.balanceOf(receiver);
        balanceBefore[purchaser] = await ERC20Ins.balanceOf(purchaser);
        balanceBefore[beneficiary] = await ERC20Ins.balanceOf(beneficiary);
    });
});
describe("make second snapshot", async function () {
     ERC20.snapshot (owner, 'owner make second snapshot')
});

describe("check first snapshot", async function () {
    it('check first snapshot::balanceOfAt()', async function () {
        assert.equal(balanceBefore[owner].toString(), (await ERC20Ins.balanceOfAt(owner, snapshotId)).toString());
        assert.equal(balanceBefore[sender].toString(), (await ERC20Ins.balanceOfAt(sender, snapshotId)).toString());
        assert.equal(balanceBefore[receiver].toString(), (await ERC20Ins.balanceOfAt(receiver, snapshotId)).toString());
        assert.equal(balanceBefore[purchaser].toString(), (await ERC20Ins.balanceOfAt(purchaser, snapshotId)).toString());
        assert.equal(balanceBefore[beneficiary].toString(), (await ERC20Ins.balanceOfAt(beneficiary, snapshotId)).toString());
    });
    it('check first snapshot for totalSupply:totalSupplyAt()', async function () {
        assert.equal(ether(ERC20Detail[2].toString()).toString(), (await ERC20Ins.totalSupplyAt(snapshotId)).toString());
    });
});