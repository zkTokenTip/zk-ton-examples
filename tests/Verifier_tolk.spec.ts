import { Blockchain, SandboxContract, TreasuryContract } from '@ton/sandbox';
import { Cell, toNano } from '@ton/core';
import { Verifier } from '../wrappers/Verifier';
import '@ton/test-utils';
import { compile } from '@ton/blueprint';

import '@ton/test-utils';
import * as snarkjs from 'snarkjs';
import path from 'path';

// @ts-ignore
import { buildBls12381, utils } from 'ffjavascript';

const { g1Compressed, g2Compressed } = require('export-ton-verifier');

const { unstringifyBigInts } = utils;

const wasmPath = path.join(__dirname, '../circuits/Multiplier', 'Multiplier.wasm');
const zkeyPath = path.join(__dirname, '../circuits/Multiplier', 'Multiplier_0001.zkey');

describe('Verifier_tolk', () => {
    let code: Cell;

    beforeAll(async () => {
        code = await compile('Verifier_tolk');
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

        expect(await verifier.getVerify({ pi_a, pi_b, pi_c, pubInputs })).toBeTruthy();

        const user = await blockchain.treasury('user');
        const verifyResult = await verifier.sendVerify(user.getSender(), {
            pi_a,
            pi_b,
            pi_c,
            pubInputs,
            value: toNano('0.15'),
        });

        expect(verifyResult.transactions).toHaveTransaction({
            from: user.address,
            to: verifier.address,
            success: true,
        });
    });
});
