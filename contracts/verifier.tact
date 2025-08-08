import "@stdlib/deploy";

asm fun blsG1Add(x: Slice, y: Slice): Slice {
  BLS_G1_ADD
}

asm fun blsG1Neg(x: Slice): Slice {
  BLS_G1_NEG
}

asm fun blsG1Multiexp(x1: Slice, y1: Int, n: Int): Slice {
  BLS_G1_MULTIEXP
}

asm fun blsPairing(
  x1: Slice, y1: Slice,
  x2: Slice, y2: Slice,
  x3: Slice, y3: Slice,
  x4: Slice, y4: Slice,
  n: Int
): Int {
  BLS_PAIRING
}

asm fun getFirstBits(s: Slice, len: Int): Slice { SDCUTFIRST }

message Verify {
    piA: Slice;
    piB: Slice;
    piC: Slice;
    pubInput0: Int;
}

contract Verifier with Deployable {
    const OP_VERIFY: Int = 0;
    const P1_SIZE: Int = 48 * 8;
    const P2_SIZE: Int = 96 * 8;
    const IC0: String = "b2eb46aa34e33e47c34c8f902c0237fe15e3b053c2af936f4989a98b08484d9c7ffd5c2ce401d385b599c0fde655a142";
    const IC1: String = "b6597f374fc6e14acc27412668e75fbcd0a2be626992e87e883fa2a9a7450a10ccd55c1c660c7eda1a554b7193a26ef2";
    const vk_gamma_2: String = "93e02b6052719f607dacd3a088274f65596bd0d09920b61ab5da61bbdc7f5049334cf11213945d57e5ac7d055d042b7e024aa2b2f08f0a91260805272dc51051c6e47ad4fa403b02b4510b647ae3d1770bac0326a805bbefd48056c8c121bdb8";
    const vk_delta_2: String = "b7d8dfbd24e100e145ba815b133c77182aaef34c8a319c9a7f12a1cd6071d539ac44a081d54ef1fdb31780219bd259dd0d4415248583355304810e130139ed017081c417973204211aaf59ef822caa07ba4b34a2836b8ddeed42f2c00a15ff47";
    const vk_alpha_1: String = "992c654968a7e37ffdb3b43cd1c88adb6824e315a781179688457d9a39ba362147045159225789ec35f274ed0c9f8b7a";
    const vk_beta_2: String = "a8cd76691240c8de423e591b8bf5a23ef88d2317ccda39bebbe3e9b85bfd28bf4663817174cc7cf7ecedb006cf9cdd4002c6c4afda47638d70bfecba5f0c4656975d6da656b93631aeee22015abb2dd70bcfb3634508700947f626decdc3e3b7";
    res: Bool = false;

    receive(msg: Verify){
        self.res = self.groth16Verify(
            getFirstBits(msg.piA, self.P1_SIZE),
            getFirstBits(msg.piB, self.P2_SIZE),
            getFirstBits(msg.piC, self.P1_SIZE),
            msg.pubInput0
        );
    }

    fun groth16Verify(piA: Slice, piB: Slice, piC: Slice, pubInput0: Int): Bool {
        let res: Bool = false;
        // cpub = sum_{i=1..nPublic} IC_i * pubInput(i-1)  +  IC_0
        let cpub: Slice = blsG1Multiexp(self.IC1.asSlice(), pubInput0, 1);
        cpub = blsG1Add(cpub, self.IC0.asSlice());
        let piANeg: Slice = blsG1Neg(piA);
        let a: Int = blsPairing(cpub,
            self.vk_gamma_2.asSlice(),
            piANeg,
            piB,
            piC,
            self.vk_delta_2.asSlice(),
            self.vk_alpha_1.asSlice(),
            self.vk_beta_2.asSlice(),
            4
        );
        if (a == 0) {
            res = false;
        } else {
            res = true;
        }
        return res;
    }

    get fun verify(piA: Slice, piB: Slice, piC: Slice, pubInput0: Int): Bool {
        return self.groth16Verify(piA, piB, piC, pubInput0);
    }

    get fun res(): Bool {
        return self.res;
    }
}