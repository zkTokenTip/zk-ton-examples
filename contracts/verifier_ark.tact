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
const vk_gamma_2: Slice = rawSlice("a768825179517ea266a56f40ad4c603808909b4400597209665035cade84c43580f3ae7836171ab0bbda2252ad1ccc3e12a3e33c1afe9bc5622481ab9ff1c13f606bd5861cfc3a21d3080b9b24b0cdb5c7db068504d57c13b3a66e232844212a");
const vk_delta_2: Slice = rawSlice("a325d1dc8ef796869ec8971886c75a055c776e3a544daea1855c61c02e2d0fe80c7cf9f4b4f8d6b3a45f3296097542fd1499a1397d12b27322de9ffd22eb9fb8e0935cf408042c9f1f6906b79f50177c4e06fab78c7887c419578704e59a279f");
const vk_alpha_1: Slice = rawSlice("ab1322fd60b3f6104855ef19f6065893a756acf4c0f9f539c411b8e2b69265fb7da5ad86cabc2f9afdc9318fa85e3738");
const vk_beta_2 : Slice = rawSlice("966c85d38f05adf72f60c3732d15dda5b144d87adb91d54704e5c94efc84bf4b604e45dc36798773bc2b261cce185e35125438cc6eb233b465ace0016a21499a66aef2369d79ebc5b34a162f7b75d883b0a06c3914dbbaa273f69419f1449ce2");

// IC constants (IC0 — constant term)
const IC0: Slice = rawSlice("82efbc09ddbad598dce0b52e5134a677700edba16844ba7dbf72b8bd1e6bf7500cac5dcd597c5adba53dc038c759a2d3");
const IC1: Slice = rawSlice("8527afc06195e2575169494b078124183c4e77c7469fa35a484b5b3f5566647270ab72f9c9ab61d9d56986c20bc03a23");

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
