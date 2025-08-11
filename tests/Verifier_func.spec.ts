import { Blockchain, SandboxContract, TreasuryContract } from '@ton/sandbox';
import { Cell, toNano } from '@ton/core';
import { Verifier } from '../wrappers/Verifier';
import '@ton/test-utils';
import { compile } from '@ton/blueprint';

import { GasLogAndSave } from './gas-logger';

import '@ton/test-utils';
import * as snarkjs from 'snarkjs';
import path from 'path';

// @ts-ignore
import { buildBls12381, utils } from 'ffjavascript';

const { g1Compressed, g2Compressed } = require('export-ton-verifier');

const { unstringifyBigInts } = utils;

const wasmPath = path.join(__dirname, '../circuits/Multiplier', 'Multiplier.wasm');
const zkeyPath = path.join(__dirname, '../circuits/Multiplier', 'Multiplier_0001.zkey');
const verificationKey = require('../circuits/Multiplier/verification_key.json');

describe('Verifier_func', () => {
    let code: Cell;
    let GAS_LOG = new GasLogAndSave('verifier_func');

    beforeAll(async () => {
        code = await compile('Verifier_func');
        GAS_LOG.rememberBocSize('verifier_func', code);
    });

    afterAll(() => {
        GAS_LOG.saveCurrentRunAfterAll();
    });

    let blockchain: Blockchain;
    let deployer: SandboxContract<TreasuryContract>;
    let verifier: SandboxContract<Verifier>;

    beforeEach(async () => {
        blockchain = await Blockchain.create();

        verifier = blockchain.openContract(Verifier.createFromConfig({}, code));

        deployer = await blockchain.treasury('deployer');

        const deployResult = await verifier.sendDeploy(deployer.getSender(), toNano('0.05'));

        expect(deployResult.transactions).toHaveTransaction({
            from: deployer.address,
            to: verifier.address,
            deploy: true,
            success: true,
        });

        GAS_LOG.rememberGas('Deploy', deployResult.transactions.slice(1));
    });

    it('should verify', async () => {
        const input = {
            a: '342',
            b: '1245',
        };
        const { proof, publicSignals } = await snarkjs.groth16.fullProve(input, wasmPath, zkeyPath);
        console.log('Public Signals:', publicSignals);

        const isVerify = await snarkjs.groth16.verify(verificationKey, publicSignals, proof);
        expect(isVerify).toBe(true);

        const curve = await buildBls12381();
        const proofProc = unstringifyBigInts(proof);

        const pi_aS = g1Compressed(curve, proofProc.pi_a);
        const pi_bS = g2Compressed(curve, proofProc.pi_b);
        const pi_cS = g1Compressed(curve, proofProc.pi_c);

        const pi_a = Buffer.from(pi_aS, 'hex');
        const pi_b = Buffer.from(pi_bS, 'hex');
        const pi_c = Buffer.from(pi_cS, 'hex');

        const pubInputs = (publicSignals as string[]).map((s) => BigInt(s));

        expect(await verifier.getVerify({ pi_a, pi_b, pi_c, pubInputs })).toBe(true);

        const verifyResult = await verifier.sendVerify(deployer.getSender(), {
            pi_a,
            pi_b,
            pi_c,
            pubInputs,
            value: toNano('0.15'),
        });

        expect(verifyResult.transactions).toHaveTransaction({
            from: deployer.address,
            to: verifier.address,
            success: true,
        });

        GAS_LOG.rememberGas('Verify', verifyResult.transactions.slice(1));
    });
});
