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
const vk_gamma_2: Slice = rawSlice("93e02b6052719f607dacd3a088274f65596bd0d09920b61ab5da61bbdc7f5049334cf11213945d57e5ac7d055d042b7e024aa2b2f08f0a91260805272dc51051c6e47ad4fa403b02b4510b647ae3d1770bac0326a805bbefd48056c8c121bdb8");
const vk_delta_2: Slice = rawSlice("b1cd4f856100b2e044982b35efc1b2b8198563e364a3f8ad04042f1b2863f2390b4eec671127429b2c5e718acd9551cb133c975867cd365d64985736dad6c003628a909f7e5bbf6640152497313e057159086a69c687baca50953a71c7ab0d89");
const vk_alpha_1: Slice = rawSlice("b1b83e55445b659621850963559851270e7f209be2ba8ec89529d0705991aa0e369d315ebb4aedb2b38232d29621789e");
const vk_beta_2 : Slice = rawSlice("90c699a329380ef521a9022f0abb0f06f072bf81efab4b8d15bc10186b558335f81f8588f0a43f751fda31f427f7f9cf0238b10a60115bd4e51fa1baaa4d6e1dd8797804f40baa93451fd46b04a2884b4e75cfdb584f457b51544e7fe687da9f");

// IC constants (IC0 — constant term)
const IC0: Slice = rawSlice("b376d29165d9993a8d552cf15eb0e1171cec3be8510e78fc47beedea5c58bb03bf112338a81d24725f159afb0b46ff8a");
const IC1: Slice = rawSlice("932b7a28b994b701aa1a4c06a4f3f369cbb0b4ddfc37c380679815504757708b5e63936b01f85b1368e7ae328671b499");

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
