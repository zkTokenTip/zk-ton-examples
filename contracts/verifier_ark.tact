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
const vk_gamma_2: Slice = rawSlice("a604b708bc781ae38a361b93451384c060e8865aff71dbefee8326798aab2bfea23775cc734de87c275c5ff8648ec1300dd0d7c6d60ac00708ff7db2c274f8bcf99c710a010e41a0221d9fa6582f8ab41f299a1daa65cdf007aef54c6f623dde");
const vk_delta_2: Slice = rawSlice("ae3e7a8c90ba5b5e266fea7105f5d374324ad0e72809aeeda144ffba7defff7d45169d6f7e3c781dba158e67256dc98e18b219a74108de96a9519a60d0b71d6edfa740f665e34c84d83ce7d5ca555ae1cc54e5306295df8b9ffbb9f638117fb4");
const vk_alpha_1: Slice = rawSlice("8fda482e4d7d7cfe718413cd03a290e7f48e6d18867caf21e74f594eedeead1ab2ccf6bf0ed52c492f683f27d6c72861");
const vk_beta_2 : Slice = rawSlice("95d2ebb1584d1fc5c7e839cb5a2fdeb0c93da725ab2e89dc9f14d31ec3fd7a54c11b02df84e197ab492c02804b9d68b00a4aafdfdee1356d7089291430753ddc48bbe3dfee5677d9016b14645db6a1a623063b2c2261f53625d3bc80a6839dca");

// IC constants (IC0 — constant term)
const IC0: Slice = rawSlice("a7a00b6865125a6469d37aced19029daa6233e3682c08f4ea8ec74665832d19263dc4ccb179af8794bffe4f1afbebe87");
const IC1: Slice = rawSlice("99d6eb5d63541ac1e4312b4deeb2557f676e69e70b49c9e231f06bb4ab4f8b30d9ab31b9d43c9215a277494106a00eea");

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
