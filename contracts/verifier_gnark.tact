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
const vk_gamma_2: Slice = rawSlice("8bb98092ce0453ef591b9028651bf61e2f5193f0084d3e979fa237c7e122f46cd500d4cfde7c18db30b47cc01f1a866c163ba3e776d32ce8bd5e048c6f92f1a250a69fe1be90f410d5847adde7041250af5ae209af9baadbf3ba509b4aab9f75");
const vk_delta_2: Slice = rawSlice("886076e4f4b3e447875b117388e3a7a26e06db22baa2c097685267dc6e625601e23ac9997fd89b9c33cbfb053378f6c70bf5189a1804f2433be0d39f0d539ba5bafa92e377f9be4351dfc3a320e12144cd5387271fe2e317f65759084e64f5ea");
const vk_alpha_1: Slice = rawSlice("8a9af09beb56d116fbfa5f737297caa9a230c8d9ff75a7461c18a97f7d1d9bcf68756139aa1f97eeafc5e1c4d3515a6e");
const vk_beta_2 : Slice = rawSlice("ac67b88d8fe4a6ba9f52228ab262e111ce020dadabf3fb746459853df9f976257c6aa56df7bf5f7eb409e2d021504f64138e5058b5e16001a77db812cadb8cbb978bf8cbe8f59e43d5439772a2e901b1478f24f0db1381b211a55cb80df004e0");

// IC constants (IC0 — constant term)
const IC0: Slice = rawSlice("a52871ef8d921a7833b121c0592e0994bc22fc6ef4c3d29dd064ae89bf94d00b4afcb398607bcd09dfd1df980b941123");
const IC1: Slice = rawSlice("a8912d3420afb90db6654958527ccff439343569d78f692507d1cb57acce7f06146085b6f255807634b4f32e79552db9");

// Error codes
const ERR_PUBLIC_NOT_PRESENT: Int = 257;
const ERR_TOO_MANY_PUBLICS: Int = 258;
const ERR_INDEX_OUT_OF_RANGE: Int = 259;


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
