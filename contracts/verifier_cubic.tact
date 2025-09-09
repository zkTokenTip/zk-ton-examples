import "@stdlib/deploy";

// ASM intrinsics
asm fun blsG1Add(x: Slice, y: Slice): Slice { BLS_G1_ADD }
asm fun blsG1Neg(x: Slice): Slice { BLS_G1_NEG }
asm fun blsPairing(
  x1: Slice, y1: Slice,
  x2: Slice, y2: Slice,
  x3: Slice, y3: Slice,
  x4: Slice, y4: Slice,
  n: Int
): Int { BLS_PAIRING }


asm fun blsG1Multiexp_1(
  x1: Slice, y1: Int
  , n: Int
): Slice { BLS_G1_MULTIEXP }

// Sizes
const P1_SIZE: Int = 48 * 8;
const P2_SIZE: Int = 96 * 8;

// Verification key constants
const vk_gamma_2: Slice = rawSlice("883db90348422eefcf5b4533663c58fa4d22bb3c33bc02e098ce629b2a818bdb07efe831f3940d0d138eb775d1f30b731273d54d06405b4c2286ee7cd1e4cd6e2285b4351bf5fcfe534032b169244e23d86866e40e16034b84cc3ae82c667119");
const vk_delta_2: Slice = rawSlice("a27ade5cb53cd3062111148f87993c32479424a1ddfb7ef64c111bda40db93a3196f9d41a0c6b093a0c5c19c34f2101b17f9f08eceaa8805d91ef6f7b2202ea671d039810f7f92f22e0ea7a15958eec9a51def97c8e9e54fc4637a8e0afe3f7f");
const vk_alpha_1: Slice = rawSlice("8730d8bce3fc01a778b45cc987da79fe6dc5769b011ab3198a3bc9e59ad44056559122ef5b1d5fec3a80bfe64682ffdd");
const vk_beta_2 : Slice = rawSlice("b9a837cedb35b8f789d2869f46ef16c74d5671710a86d62c6d686f560054fbc2b1417089bf5018457cd031b0db8b55bf0a09b13b270c4321eff2c202f787e8a4d0311a6a107fb017b1ace4ebd8744d4e1f1a7050e34660b77b907b54c0c95421");

// IC constants (IC0 — constant term)
const IC0: Slice = rawSlice("ac679fca56dd1954945e5d72e97f8c35232596926d6a60541173d0e46c0f8449b8e5430eaa2219ad42652ce1a0451be4");
const IC1: Slice = rawSlice("8151fd5b7c8e9051a5a8d82f513fb3478fde4ec5b852c31019a44f07883b8f3d00987561848b9adf062e34e1e7add6f2");

// Error codes
const ERR_PUBLIC_NOT_PRESENT: Int = 257;
const ERR_TOO_MANY_PUBLICS: Int = 258;
const ERR_INDEX_OUT_OF_RANGE: Int = 259;
const ERR_WRONG_PROOF: Int = 260;


// Message definition
message Verify {
  piA: Slice;
  piB: Slice;
  piC: Slice;
  pubInputs: map<Int as uint32, Int>;
}

contract Verifier with Deployable {

  receive(msg: Verify) {
    let res = self.groth16Verify(msg.piA, msg.piB, msg.piC, msg.pubInputs);
    nativeThrowUnless(ERR_WRONG_PROOF, res);
  }

  fun groth16Verify(
    piA: Slice,
    piB: Slice,
    piC: Slice,
    pubInputs: map<Int as uint32, Int>
  ): Bool {
    // Single batch (no loop and no ic())
    let cpub: Slice = blsG1Multiexp_1(
      IC1, pubInputs.get(0)!!
      , 1
    );

    // Add the constant term
    cpub = blsG1Add(cpub, IC0);

    // Check that no extra public inputs exist
    nativeThrowIf(ERR_TOO_MANY_PUBLICS, pubInputs.exists(1));

    // Perform pairing check
    let piANeg: Slice = blsG1Neg(piA);
    let ok: Int = blsPairing(
      cpub,       vk_gamma_2,
      piANeg,     piB,
      piC,        vk_delta_2,
      vk_alpha_1, vk_beta_2,
      4
    );
    return ok != 0;
  }

  get fun verify(
    piA: Slice,
    piB: Slice,
    piC: Slice,
    pubInputs: map<Int as uint32, Int>
  ): Bool {
    return self.groth16Verify(piA, piB, piC, pubInputs);
  }
}
