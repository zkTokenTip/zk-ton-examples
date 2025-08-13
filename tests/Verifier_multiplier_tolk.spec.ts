import { Blockchain, SandboxContract, TreasuryContract } from '@ton/sandbox';
import { compile } from '@ton/blueprint';
import { Cell, toNano } from '@ton/core';
import '@ton/test-utils';

import * as snarkjs from 'snarkjs';
import path from 'path';

import { GasLogAndSave } from './gas-logger';
import { Verifier } from '../wrappers/Verifier';

import { groth16CompressProof } from 'export-ton-verifier';

const wasmPath = path.join(__dirname, '../circuits/Multiplier/Multiplier_js', 'Multiplier.wasm');
const zkeyPath = path.join(__dirname, '../circuits/Multiplier', 'Multiplier_final.zkey');
const verificationKey = require('../circuits/Multiplier/verification_key.json');

// npx blueprint test Verifier_multiplier_tolk
describe('Verifier_multiplier_tolk', () => {
    let code: Cell;
    let GAS_LOG = new GasLogAndSave('Verifier_multiplier_tolk');

    beforeAll(async () => {
        code = await compile('Verifier_multiplier_tolk');
        GAS_LOG.rememberBocSize('Verifier_multiplier_tolk', code);
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
            a: '435',
            b: '32',
        };
        const { proof, publicSignals } = await snarkjs.groth16.fullProve(input, wasmPath, zkeyPath);

        const isVerify = await snarkjs.groth16.verify(verificationKey, publicSignals, proof);
        expect(isVerify).toBe(true);

        const { pi_a, pi_b, pi_c, pubInputs } = await groth16CompressProof(proof, publicSignals);

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
