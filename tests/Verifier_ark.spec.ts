import '@ton/test-utils';

import * as snarkjs from 'snarkjs';

// npx blueprint test Verifier_ark
describe('Verifier_ark', () => {
    describe('mimc', () => {
        it('mimc BN254', async () => {
            const verificationKey = require('../circuits/Arkworks/mimc/BN254/verification_key.json');
            const proofFile = require('../circuits/Arkworks/mimc/BN254/proof.json');
            const publicSignals: snarkjs.PublicSignals = proofFile.public_signals;

            const isVerify = await snarkjs.groth16.verify(verificationKey, publicSignals, proofFile);
            expect(isVerify).toBe(true);
        });

        it('mimc Bls12-381', async () => {
            const verificationKey = require('../circuits/Arkworks/mimc/Bls12-381/verification_key.json');
            const proofFile = require('../circuits/Arkworks/mimc/Bls12-381/proof.json');
            const publicSignals: snarkjs.PublicSignals = proofFile.public_signals;

            const isVerify = await snarkjs.groth16.verify(verificationKey, publicSignals, proofFile);
            expect(isVerify).toBe(true);
        });
    });

    describe('mul', () => {
        it('mul BN254', async () => {
            const verificationKey = require('../circuits/Arkworks/mul/BN254/verification_key.json');
            const proofFile = require('../circuits/Arkworks/mul/BN254/proof.json');
            const publicSignals: snarkjs.PublicSignals = proofFile.public_signals;

            const isVerify = await snarkjs.groth16.verify(verificationKey, publicSignals, proofFile);
            expect(isVerify).toBe(true);
        });

        it('mul Bls12-381', async () => {
            const verificationKey = require('../circuits/Arkworks/mul/Bls12-381/verification_key.json');
            const proofFile = require('../circuits/Arkworks/mul/Bls12-381/proof.json');
            const publicSignals: snarkjs.PublicSignals = proofFile.public_signals;

            const isVerify = await snarkjs.groth16.verify(verificationKey, publicSignals, proofFile);
            expect(isVerify).toBe(true);
        });
    });

    describe('mulbn254', () => {
        it('mulbn254 BN254', async () => {
            const verificationKey = require('../circuits/Arkworks/mulbn254/verification_key.json');
            const proofFile = require('../circuits/Arkworks/mulbn254/proof.json');
            const publicSignals: snarkjs.PublicSignals = proofFile.public_signals;

            const isVerify = await snarkjs.groth16.verify(verificationKey, publicSignals, proofFile);
            expect(isVerify).toBe(true);
        });
    });
});
