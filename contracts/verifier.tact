import "@stdlib/deploy";

asm fun blsG1Add(x: Slice, y: Slice): Slice { BLS_G1_ADD }
asm fun blsG1Neg(x: Slice): Slice { BLS_G1_NEG }
asm fun blsG1Multiexp(
  x1: Slice, y1: Int,
  n: Int
): Slice { BLS_G1_MULTIEXP }
asm fun blsPairing(
  x1: Slice, y1: Slice,
  x2: Slice, y2: Slice,
  x3: Slice, y3: Slice,
  x4: Slice, y4: Slice,
  n: Int
): Int { BLS_PAIRING }

const P1_SIZE: Int = 48 * 8;
const P2_SIZE: Int = 96 * 8;

const vk_gamma_2: Slice = rawSlice("93e02b6052719f607dacd3a088274f65596bd0d09920b61ab5da61bbdc7f5049334cf11213945d57e5ac7d055d042b7e024aa2b2f08f0a91260805272dc51051c6e47ad4fa403b02b4510b647ae3d1770bac0326a805bbefd48056c8c121bdb8");
const vk_delta_2: Slice = rawSlice("804ca21d3c8d9a58e7a63e7fb564fee76892d3f5839571d05b2243e10d848a01db45920feb1f18caef59b60cef77b76700af100aa037c1a30316d6f9341566143f9c1ab4db82677ae29ac147b7d31b9f6c8e17c235b5b3511a20880ad2b9a5e2");
const vk_alpha_1: Slice = rawSlice("b830008ceed707a79fb554918ab9158ea9a9251d9a8333155ef52b0b9d712f03fa1eae9ed8e21f9d2beaea735c8766a9");
const vk_beta_2 : Slice = rawSlice("89c29649fd447cedcd7bb3f619f32a3bea8249e928809cc37320a5528c958728c4f43a18d29fe478ee3e1b9ccee362c80cc4144a269e81594665fca33acfe73e97be3089cf02edd226ebeafd104a0de5b21334a82ff12282d040fa1f8191d3a9");

const IC0: Slice = rawSlice("ac0e607fb57156f882b798ce3195574278f61cf21828d5f2cf42e55300f108ecd817614e60180867e1f65749f11c71de");
const IC1: Slice = rawSlice("b111848794e58b53a7bbf693850a7b0bff6b07092d91f3696974ea4dda64d27c8a3e8b3894f570e48c4adbe25aec6567");

message Verify {
  piA: Slice;
  piB: Slice;
  piC: Slice;
  pubInput0: Int;
}

contract Verifier with Deployable {
  res: Bool = false;

  receive(msg: Verify) {
    self.res = self.groth16Verify(
      msg.piA,
      msg.piB,
      msg.piC,
      msg.pubInput0
    );
  }

  fun groth16Verify(
    piA: Slice,
    piB: Slice,
    piC: Slice,
    pubInput0: Int
  ): Bool {
    let cpub: Slice = blsG1Multiexp(
      IC1, pubInput0,
      1
    );
    cpub = blsG1Add(cpub, IC0);
    let piANeg: Slice = blsG1Neg(piA);
    let ok: Int = blsPairing(
      cpub,        vk_gamma_2,
      piANeg,      piB,
      piC,         vk_delta_2,
      vk_alpha_1,  vk_beta_2,
      4
    );
    return ok != 0;
  }

  get fun verify(
    piA: Slice,
    piB: Slice,
    piC: Slice,
    pubInput0: Int
  ): Bool {
    return self.groth16Verify(
      piA, piB, piC,
      pubInput0
    );
  }

  get fun res(): Bool { return self.res; }
}
