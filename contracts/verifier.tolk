const OP_VERIFY = stringCrc32("op::verify");
const P1_SIZE = 48 * 8;
const P2_SIZE = 96 * 8;

const IC0 = stringHexToSlice("ac0e607fb57156f882b798ce3195574278f61cf21828d5f2cf42e55300f108ecd817614e60180867e1f65749f11c71de");
const IC1 = stringHexToSlice("b111848794e58b53a7bbf693850a7b0bff6b07092d91f3696974ea4dda64d27c8a3e8b3894f570e48c4adbe25aec6567");

const vk_gamma_2 = stringHexToSlice("93e02b6052719f607dacd3a088274f65596bd0d09920b61ab5da61bbdc7f5049334cf11213945d57e5ac7d055d042b7e024aa2b2f08f0a91260805272dc51051c6e47ad4fa403b02b4510b647ae3d1770bac0326a805bbefd48056c8c121bdb8");
const vk_delta_2 = stringHexToSlice("804ca21d3c8d9a58e7a63e7fb564fee76892d3f5839571d05b2243e10d848a01db45920feb1f18caef59b60cef77b76700af100aa037c1a30316d6f9341566143f9c1ab4db82677ae29ac147b7d31b9f6c8e17c235b5b3511a20880ad2b9a5e2");
const vk_alpha_1 = stringHexToSlice("b830008ceed707a79fb554918ab9158ea9a9251d9a8333155ef52b0b9d712f03fa1eae9ed8e21f9d2beaea735c8766a9");
const vk_beta_2  = stringHexToSlice("89c29649fd447cedcd7bb3f619f32a3bea8249e928809cc37320a5528c958728c4f43a18d29fe478ee3e1b9ccee362c80cc4144a269e81594665fca33acfe73e97be3089cf02edd226ebeafd104a0de5b21334a82ff12282d040fa1f8191d3a9");

@pure
fun blsG1Add(x: slice, y: slice): slice
    asm "BLS_G1_ADD";
@pure
fun blsG1Neg(x: slice): slice
    asm "BLS_G1_NEG";
@pure
fun blsG1Multiexp(
    x1: slice, y1: int,
    n: int
): slice
    asm "BLS_G1_MULTIEXP";
@pure
fun blsPairing(x1: slice, y1: slice, x2: slice, y2: slice, x3: slice, y3: slice, x4: slice, y4: slice, n: int): int
    asm "BLS_PAIRING";

fun slice.loadP1(mutate self): slice {
    var c: cell = self.loadRef();
    var s: slice = c.beginParse();
    var p1: slice = s.getFirstBits(P1_SIZE);
    s.skipBits(P1_SIZE);
    self = s; return p1;
}

fun slice.loadP2(mutate self): slice {
    var c: cell = self.loadRef();
    var s: slice = c.beginParse();
    var p2: slice = s.getFirstBits(P2_SIZE);
    s.skipBits(P2_SIZE);
    self = s; return p2;
}

fun slice.loadNewint(mutate self): int {
    var c: cell = self.loadRef();
    var s: slice = c.beginParse();
    var x: int = s.loadUint(256);
    self = s; return x;
}

fun groth16Verify(
    piA: slice,
    piB: slice,
    piC: slice,
    pubInput0: int
): int {
    var res: int = 0;
    var cpub: slice = blsG1Multiexp(
        IC1, pubInput0,
        1
    );
    cpub = blsG1Add(cpub, IC0);
    var piANeg: slice = blsG1Neg(piA);
    var a: int = blsPairing(
        cpub,       vk_gamma_2,
        piANeg,     piB,
        piC,        vk_delta_2,
        vk_alpha_1, vk_beta_2,
        4
    );
    if (a == 0) {
        res = 0;
    } else {
        res = 1;
    }
    return res;
}

fun verify(inMsgBody: slice): int {
    var piA: slice = inMsgBody.loadP1();
    var piB: slice = inMsgBody.loadP2();
    var piC: slice = inMsgBody.loadP1();
    var pubInput0: int = inMsgBody.loadNewint();
    return groth16Verify(
        piA,
        piB,
        piC,
        pubInput0
    );
}

fun onInternalMessage(myBalance: int, msgValue: int, inMsgFull: cell, inMsgBody: slice) {
    if (inMsgBody.isEmpty()) {
        return;
    }
    var cs: slice = inMsgFull.beginParse();
    var flags: int = cs.loadUint(4);
    if (flags & 1) {
        return;
    }
    var op: int = inMsgBody.loadUint(32);
    var queryId: int = inMsgBody.loadUint(64);
    if (op == OP_VERIFY) {
        var res: int = verify(inMsgBody);
        return;
    }
    throw 0xffff;
}

get fun get_verify(
    piA: slice,
    piB: slice,
    piC: slice,
    pubInput0: int
): int {
    return groth16Verify(
        piA,
        piB,
        piC,
        pubInput0
    );
}
