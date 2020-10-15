// test/DaoFund.js
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// SPDX-License-Identifier: MIT
const assert = require('assert');
const { contract, accounts,web3 } = require('@openzeppelin/test-environment');

const { expect } = require('chai');

const {constants,expectRevert,expectEvent} = require('@openzeppelin/test-helpers');

// Loads the built artifact from build/contracts/DaoFund.json
// const DaoFund = artifacts.require('DaoFund'); // truffle style
const DaoFund = contract.fromArtifact("DaoFund"); 
const ERC20Test = contract.fromArtifact("ERC20Test"); 

// get account from accounts array
[founder, owner, sender, receiver, buyer, daoGov, daoOp] = accounts;
 
// contract('DaoFund test', function (accounts) { //  truffle style
describe("DaoFund test", function () {     
    beforeEach(async function() {
        weth = await ERC20Test.new('WETH', 'WETH', '100000000', { from: founder });
        usdt = await ERC20Test.new('USDT', 'USDT', '100000000', { from: founder });
        daoFund = await DaoFund.new(owner,weth.address,usdt.address,{ from: founder }); 
        assert.equal(await daoFund.emergency(), owner);
        assert.equal(await daoFund.weth(), weth.address);
        assert.equal(await daoFund.usdt(), usdt.address);
        assert.equal(await daoFund.founder(), founder);
        assert.equal(await daoFund.daoGov(), founder);
        assert.equal(await daoFund.daoOp(), founder);

        let receipt = await daoFund.setEmergency(receiver, { from: founder });
        expectEvent(receipt, 'SetEmergency', {
            old_: owner,new_: receiver
        });
        receipt = await daoFund.setDaoGov(daoGov, { from: founder });
        expectEvent(receipt, 'SetDaoGov', {
            old_: founder,new_: daoGov
        });
        receipt = await daoFund.setDaoOp(daoOp,{ from: daoGov});
        expectEvent(receipt, 'SetDaoOp', {
            old_: founder,new_: daoOp
        });
    });
    it('set new emergency', async function () { 
        assert.equal(await daoFund.emergency(), receiver);
    });
    it('set new daoGov', async function () { 
        assert.equal(await daoFund.daoGov(), daoGov);
    }); 
    it('set new daoOp', async function () {
        assert.equal(await daoFund.daoOp(), daoOp);
    });
    it('new owner() at 0', async function () { 
        await expectRevert(
            daoFund.setDaoGov(constants.ZERO_ADDRESS,{ from: await daoFund.daoGov() }),
            'DaoFund: Not be empty',
        );
    });
    it('daoOp() attact setDaoGov()', async function () { 
        await daoFund.setDaoOp(daoOp,{ from: await daoFund.daoGov() });
        await expectRevert(
            daoFund.setDaoGov(sender,{ from: await daoFund.daoOp() }),
            'DaoFund: Not daoGov',
        );
    });
    it('daoOp() attact setDaoOp()', async function () { 
        await daoFund.setDaoOp(daoOp,{ from: await daoFund.daoGov() });
        await expectRevert(
            daoFund.setDaoOp(sender,{ from: await daoFund.daoOp() }),
            'DaoFund: Not daoGov',
        );
    }); 
 
    it('founder in ALLOWS', async function () { 
        assert.ok(daoFund.isAllow(founder));
    });
    it('founder not in DENYS', async function () {  
        assert.equal(false,await daoFund.isDeny(founder));
    });

    it('founder cannot add buyer to daoOp() without power', async function () {
        await daoFund.setDaoOp(daoGov,{ from: await daoFund.daoGov() }); 
        await expectRevert(
            daoFund.setDaoOp(buyer,{ from: founder }),
            'DaoFund: Not daoGov',
        );
    });
    it('daoGov control settings key-value', async function () {  
        key = "RewardToken";
        await expectRevert(daoFund.getKey(key),
          'DaoFund: No the key'
        );
        daoFund.addKey(key,"SPTE",{from: daoGov});
        assert.equal("SPTE",await daoFund.getKey(key));
        daoFund.setKey(key,"SPTE2",{from: daoGov});
        assert.equal("SPTE2",await daoFund.getKey(key));
        daoFund.delKey(key,{from: daoGov});
        await expectRevert(daoFund.getKey(key),
          'DaoFund: No the key',
        );
    });
    it('buyer can not control settings key-value', async function () {
        await expectRevert(daoFund.getKey("RewardToken2"),
          'DaoFund: No the key',
        );
        await expectRevert(daoFund.addKey("RewardToken2","SPTE",{from: buyer}),
          'DaoFund: Not daoGov',
        );
        daoFund.addKey("RewardToken2","SPTE",{from: daoGov});
        assert.equal(await daoFund.getKey("RewardToken2"), "SPTE");
        await expectRevert(daoFund.setKey("RewardToken2","SPTE2",{from: buyer}),
          'DaoFund: Not daoGov',
        );
        await expectRevert(daoFund.delKey("RewardToken2",{from: buyer}),
          'DaoFund: Not daoGov',
        );
    }); 

    it('daoGov add/del sender in ALLOWS', async function () {
        assert.equal(false,await daoFund.isAllow(sender));
        await daoFund.addAllow(sender,{ from: daoGov });
        assert.ok(daoFund.isAllow(sender));
        await daoFund.delAllow(sender,{ from: daoGov });
        assert.equal(false,await daoFund.isAllow(sender));
    });
    it('daoGov add/del receiver in DENYS', async function () {
        assert.equal(false,await daoFund.isDeny(sender));
        await daoFund.addDeny(sender,{ from: daoGov });
        assert.ok(daoFund.isDeny(sender));
        await daoFund.delDeny(sender,{ from: daoGov });
        assert.equal(false,await daoFund.isDeny(sender));
    });

    it('daoOp add/del sender in ALLOWS', async function () {
        assert.equal(false,await daoFund.isAllow(sender));
        await daoFund.addAllow(sender,{ from: daoOp });
        assert.ok(daoFund.isAllow(sender));
        await daoFund.delAllow(sender,{ from: daoOp });
        assert.equal(false,await daoFund.isAllow(sender));
    });
    it('daoOp add/del receiver in DENYS', async function () {
        assert.equal(false,await daoFund.isDeny(sender));
        await daoFund.addDeny(sender,{ from: daoOp });
        assert.ok(daoFund.isDeny(sender));
        await daoFund.delDeny(sender,{ from: daoOp });
        assert.equal(false,await daoFund.isDeny(sender));
    });

    it('buyer add/del sender in Allow', async function () {
        assert.equal(false,await daoFund.isAllow(sender)); 
        await expectRevert(
            daoFund.addAllow(sender,{ from: buyer }),
            'DaoFund: Not daoOp or daoGov',
        );
        await daoFund.addAllow(sender,{ from: daoOp });
        assert.ok(daoFund.isAllow(sender));
        await expectRevert(
            daoFund.delAllow(sender,{ from: buyer }),
            'DaoFund: Not daoOp or daoGov',
        ); 
    });
    it('buyer add/del sender in Deny', async function () {
        assert.equal(false,await daoFund.isDeny(sender)); 
        await expectRevert(
            daoFund.addDeny(sender,{ from: buyer }),
            'DaoFund: Not daoOp or daoGov',
        );
        await daoFund.addDeny(sender,{ from: daoOp });
        assert.ok(daoFund.isDeny(sender));
        await expectRevert(
            daoFund.delDeny(sender,{ from: buyer }),
            'DaoFund: Not daoOp or daoGov',
        ); 
    });  
});