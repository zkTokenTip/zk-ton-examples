import { Blockchain, SandboxContract, TreasuryContract } from '@ton/sandbox';
import { beginCell, toNano } from '@ton/core';
import { Verifier } from '../build/Verifier_tact/tact_Verifier';
import '@ton/test-utils';

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

describe('Verifier_tact', () => {
    let blockchain: Blockchain;
    let deployer: SandboxContract<TreasuryContract>;
    let verifier: SandboxContract<Verifier>;

    let GAS_LOG = new GasLogAndSave('verifier_tact');

    beforeEach(async () => {
        blockchain = await Blockchain.create();

        verifier = blockchain.openContract(await Verifier.fromInit());

        deployer = await blockchain.treasury('deployer');

        GAS_LOG.rememberBocSize('verifier_tact', verifier.init?.code!);

        const deployResult = await verifier.send(
            deployer.getSender(),
            {
                value: toNano('0.05'),
            },
            { $$type: 'Deploy', queryId: 0n },
        );

        expect(deployResult.transactions).toHaveTransaction({
            from: deployer.address,
            to: verifier.address,
            deploy: true,
            success: true,
        });

        GAS_LOG.rememberGas('Deploy', deployResult.transactions.slice(1));
    });

    afterAll(() => {
        GAS_LOG.saveCurrentRunAfterAll();
    });

    it('should verify', async () => {
        let input = {
            a: '435',
            b: '32',
        };
        let { proof, publicSignals } = await snarkjs.groth16.fullProve(input, wasmPath, zkeyPath);
        console.log(publicSignals);

        let curve = await buildBls12381();
        let proofProc = unstringifyBigInts(proof);

        const pi_aS = g1Compressed(curve, proofProc.pi_a);
        const pi_bS = g2Compressed(curve, proofProc.pi_b);
        const pi_cS = g1Compressed(curve, proofProc.pi_c);

        const pi_a = Buffer.from(pi_aS, 'hex');
        const pi_b = Buffer.from(pi_bS, 'hex');
        const pi_c = Buffer.from(pi_cS, 'hex');

        const pubInputs = (publicSignals as string[]).map((s) => BigInt(s));

        expect(
            await verifier.getVerify(
                beginCell().storeBuffer(pi_a).endCell().asSlice(),
                beginCell().storeBuffer(pi_b).endCell().asSlice(),
                beginCell().storeBuffer(pi_c).endCell().asSlice(),
                pubInputs[0],
            ),
        ).toBeTruthy();

        const user = await blockchain.treasury('user');
        const verifyResult = await verifier.send(
            user.getSender(),
            {
                value: toNano('0.05'),
            },
            {
                $$type: 'Verify',
                piA: beginCell().storeBuffer(pi_a).endCell().asSlice(),
                piB: beginCell().storeBuffer(pi_b).endCell().asSlice(),
                piC: beginCell().storeBuffer(pi_c).endCell().asSlice(),
                pubInput0: pubInputs[0],
            },
        );

        expect(verifyResult.transactions).toHaveTransaction({
            from: user.address,
            to: verifier.address,
            success: true,
        });

        GAS_LOG.rememberGas('Verify', verifyResult.transactions.slice(1));
    });
});
