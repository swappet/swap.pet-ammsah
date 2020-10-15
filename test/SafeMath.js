// test/SafeMath.js
// Copyright (C) 2020, 2021, 2022 Swap.Pet@pm.me
// SPDX-License-Identifier: MIT
const assert = require('assert');
const { contract  } = require('@openzeppelin/test-environment');

const { expect } = require('chai'); 

const {  BN,  expectRevert } = require('@openzeppelin/test-helpers'); 

const SafeMathTest = contract.fromArtifact("SafeMathTest"); 
 
const MaxUint256 = (new BN(2)).pow(new BN(256)).sub(new BN(1))
const a = new BN('18');
const b = new BN('58'); 
const a2 = new BN('324');   // a^2
const a25 = new BN('329'); // a^2+5
 
describe("SafeMath test", function () {     
    beforeEach(async function() {
        safeMathTest = await SafeMathTest.new();
    });
    it('max(a,b)', async function () {
        assert.equal(b.toString(), await safeMathTest.max(a,b));
    });
    it('max(b,a)', async function () {
        assert.equal(b.toString(), await safeMathTest.max(b,a));
    });
    it('min(a,b)', async function () {
        assert.equal(a.toString(), await safeMathTest.min(a,b));
    });
    it('min(b,a)', async function () {
        assert.equal(a.toString(), await safeMathTest.min(b,a));
    });
    it('twins(a,b)', async function () {
        twins = await safeMathTest.twins(a,b)
        assert.equal(a.toString(),twins[0] );
        assert.equal(b.toString(),twins[1] );
    });
    it('twins(b,a)', async function () {
        twins = await safeMathTest.twins(b,a)
        assert.equal(a.toString(),twins[0] );
        assert.equal(b.toString(),twins[1] );
    });
    it('avg(a,MaxUint256)', async function () {
        assert.equal((MaxUint256.add(a).div(new BN(2))).toString(), await safeMathTest.avg(a,MaxUint256));
    });
    it('add(a,b)', async function () {
        assert.equal(a.add(b).toString(), await safeMathTest.add(a,b));
    });
    it('add(a,MaxUint256) overflow', async function () { 
        await expectRevert(safeMathTest.add(a,MaxUint256),
          'SafeMath: add overflow',
        );
    });
    it('sub(MaxUint256,a)', async function () {
        assert.equal(MaxUint256.sub(a).toString(), await safeMathTest.sub(MaxUint256,a));
    });
    it('sub(a,MaxUint256) overflow', async function () { 
        await expectRevert(safeMathTest.sub(a,MaxUint256),
          'SafeMath: sub overflow',
        );
    });
    it('mul(a,b)', async function () {
        assert.equal(a.mul(b).toString(), await safeMathTest.mul(a,b));
    });
    it('mul(0,b)', async function () {
        assert.equal('0', await safeMathTest.mul(0,b));
    });
    it('mul(a,0)', async function () {
        assert.equal('0', await safeMathTest.mul(a,0));
    });
    it('mul(a,MaxUint256) overflow', async function () { 
        await expectRevert(safeMathTest.mul(a,MaxUint256),
          'SafeMath: mul overflow',
        );
    });
    it('div(a,b)', async function () {
        assert.equal(a.div(b).toString(), await safeMathTest.div(a,b));
    });
    it('div(b,a)', async function () {
        assert.equal(b.div(a).toString(), await safeMathTest.div(b,a));
    });
    it('div(0,b)', async function () {
        assert.equal('0', await safeMathTest.div(0,b));
    });
    it('div(a,0)', async function () {
        await expectRevert(safeMathTest.div(a,0),
          'SafeMath: div by zero',
        );
    });
    it('mod(a,b)', async function () {
        assert.equal(a.mod(b).toString(), await safeMathTest.mod(a,b));
    });
    it('mod(b,a)', async function () {
        assert.equal(b.mod(a).toString(), await safeMathTest.mod(b,a));
    });
    it('mod(0,b)', async function () {
        assert.equal('0', await safeMathTest.mod(0,b));
    });
    it('mod(a,0)', async function () {
        await expectRevert(safeMathTest.mod(a,0),
          'SafeMath: mod by zero',
        );
    });
    it('sqrt(0)', async function () {
        assert.equal('0', await safeMathTest.sqrt(0));
    });
    it('sqrt(1)', async function () {
        assert.equal('1', await safeMathTest.sqrt(1));
    });
    it('sqrt(2)', async function () {
        assert.equal('1', await safeMathTest.sqrt(2));
    });
    it('sqrt(3)', async function () {
        assert.equal('1', await safeMathTest.sqrt(3));
    });
    it('sqrt(4)', async function () {
        assert.equal('2', await safeMathTest.sqrt(4));
    });
    it('sqrt(a2)', async function () {
        assert.equal(a.toString(), await safeMathTest.sqrt(a2));
    });
    it('sqrt(a25)', async function () {
        assert.equal(a.toString(), await safeMathTest.sqrt(a25));
    });
});