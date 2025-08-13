import { Dictionary } from '@ton/core';
const { g1Compressed, g2Compressed } = require('export-ton-verifier');
// @ts-ignore
import { buildBls12381, utils } from 'ffjavascript';
const { unstringifyBigInts } = utils;

export function dictFromInputList(list: bigint[]): Dictionary<number, bigint> {
    const dict: Dictionary<number, bigint> = Dictionary.empty(Dictionary.Keys.Int(32), Dictionary.Values.BigInt(256));
    for (let i = 0; i < list.length; i++) {
        dict.set(i, list[i]);
    }
    return dict;
}

export async function groth16CompressProof(proof: snarkjs.Groth16Proof, publicSignals: snarkjs.PublicSignals) {
    const curve = await buildBls12381();
    const proofProc = unstringifyBigInts(proof);

    const pi_aS = g1Compressed(curve, proofProc.pi_a);
    const pi_bS = g2Compressed(curve, proofProc.pi_b);
    const pi_cS = g1Compressed(curve, proofProc.pi_c);

    const pi_a = Buffer.from(pi_aS, 'hex');
    const pi_b = Buffer.from(pi_bS, 'hex');
    const pi_c = Buffer.from(pi_cS, 'hex');

    const pubInputs = (publicSignals as string[]).map((s) => BigInt(s));

    return {
        pi_a,
        pi_b,
        pi_c,
        pubInputs,
    };
}
