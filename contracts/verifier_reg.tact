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


asm fun blsG1Multiexp_4(
  x1: Slice, y1: Int,
  x2: Slice, y2: Int,
  x3: Slice, y3: Int,
  x4: Slice, y4: Int
  , n: Int
): Slice { BLS_G1_MULTIEXP }

// Sizes
const P1_SIZE: Int = 48 * 8;
const P2_SIZE: Int = 96 * 8;

// Verification key constants
const vk_gamma_2: Slice = rawSlice("93e02b6052719f607dacd3a088274f65596bd0d09920b61ab5da61bbdc7f5049334cf11213945d57e5ac7d055d042b7e024aa2b2f08f0a91260805272dc51051c6e47ad4fa403b02b4510b647ae3d1770bac0326a805bbefd48056c8c121bdb8");
const vk_delta_2: Slice = rawSlice("8f3adc9e0fa3a35c2ebf1d27c198bab02a3db8398acb8e5325b9451db8f63d91f8811e11b69baa6b72c56477a03c87f608b06379c6af8ba1be8fa0299105e779a48c859d04823c7d2a94d566648b4a2820b7b0a8f6d3fd60eabaaffaa7bea81c");
const vk_alpha_1: Slice = rawSlice("a17990f89065b14789afb45e694421892af16214804f076ee2f67fccbbf84cb36369535b3c8dc539c296912ac6ce9d9e");
const vk_beta_2 : Slice = rawSlice("8ec17bd211918e392b9de61d87c8870cf8cd11a964dd0f96d82ecca0a9afeb39d47d40b014543915a929767ae8424db00795d7aba2cda85110b172220ab593a15d98387aca38a815717bd80ea46f3a8af3c67f387849ee5419cd091fa03a2fab");

// IC constants (IC0 — constant term)
const IC0: Slice = rawSlice("b10f3e3b77aee4b0f5741e8ef9770b4af060132e77e986c752fcd68ab252b13b61802d0152308f6b84b83ca2d42df373");
const IC1: Slice = rawSlice("b3db5bd42a4f298e716bb6506d9f83dd73f8899f02116655c638e629889df34238eee4278c6e1bb77abf433b68940225");
const IC2: Slice = rawSlice("b619df88e8cef7596bf20c0e71b788d0ff2b1775ccf9c00cd6c90e97144ca12406dff8073684cafaeda5fca9d2f52ac5");
const IC3: Slice = rawSlice("b14fb488ab8eba64e108c523d0ca906db543dca6455014bec82941e39dc975948b682d68b2073a38674fd39b4e80eb24");
const IC4: Slice = rawSlice("a77c1f4ef3e9dbdfa9d59e78a618c2d49d5e891cb3b19b80ea6c67a3867b93c2207fac6284e9e719f1f5114698a78648");

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
    let cpub: Slice = blsG1Multiexp_4(
      IC1, pubInputs.get(0)!!,
      IC2, pubInputs.get(1)!!,
      IC3, pubInputs.get(2)!!,
      IC4, pubInputs.get(3)!!
      , 4
    );

    // Add the constant term
    cpub = blsG1Add(cpub, IC0);

    // Check that no extra public inputs exist
    nativeThrowIf(ERR_TOO_MANY_PUBLICS, pubInputs.exists(4));

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
