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
const vk_gamma_2: Slice = rawSlice("89ccb9658618401117d0e194f6992c7c2304d227ca486ba7af26a58a9c37196a1d0ebdb0d0178e3a13e3f4966431d5c1068eefe492304a581b03b7abdcb36c12e37da48870db345ccef11759d63b33a0e239785ab04a353e621317744531616b");
const vk_delta_2: Slice = rawSlice("b0f907ec664e6330230fee6780e633bdd95c94bb2d801260aadbd4978ddffce4e0980e25631828d63d5b9697cc0ea59c0a1525eb75daf7448c19cc6a14edb199ee30e6f44ca3e2845724035c8a9b0b020a2253cfb38937359f7ecf96f798371c");
const vk_alpha_1: Slice = rawSlice("856df167b7982a1a40d69e5a13cdbd8082e9bd0152aa35d4d6dbec7653be51d879cd681dadb92e8bf5fc838f1775517d");
const vk_beta_2 : Slice = rawSlice("913731312241715ba175a70a79f0c9a5972afd1efa402e1e3ae183c52bd5df9d432c93e237175028fe78527e724f4d761150f2cce78e9b6de5d11c6442acc28d8d56a0e744c60981f59f7d1bc8e011e007cd82a0cfdb5173ed64145e832fd341");

// IC constants (IC0 — constant term)
const IC0: Slice = rawSlice("a4f24e15a91593e50210d97e6cd4d12053fcc3fe456bc0f38b8f8b8a53432f1550507ca07cd2756cc54eedae828fb43c");
const IC1: Slice = rawSlice("995284b7b8e690cfcf2a50edbbcd71758066af19871c0e85b8ef6bb68762fc404e60f2777dd97aa0dec706972990be8a");

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
