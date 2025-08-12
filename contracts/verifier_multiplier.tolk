import "@stdlib/tvm-dicts"

// ops
const OP_VERIFY = stringCrc32("op::verify")

// sizes
const `verifier::P1_SIZE` = 48 * 8
const `verifier::P2_SIZE` = 96 * 8

// input constants (IC0 is the base term)
const `verifier::IC0` = stringHexToSlice("b376d29165d9993a8d552cf15eb0e1171cec3be8510e78fc47beedea5c58bb03bf112338a81d24725f159afb0b46ff8a")
const `verifier::IC1` = stringHexToSlice("932b7a28b994b701aa1a4c06a4f3f369cbb0b4ddfc37c380679815504757708b5e63936b01f85b1368e7ae328671b499")

// vk constants
const `verifier::vk_gamma_2` = stringHexToSlice("93e02b6052719f607dacd3a088274f65596bd0d09920b61ab5da61bbdc7f5049334cf11213945d57e5ac7d055d042b7e024aa2b2f08f0a91260805272dc51051c6e47ad4fa403b02b4510b647ae3d1770bac0326a805bbefd48056c8c121bdb8")
const `verifier::vk_delta_2` = stringHexToSlice("b1cd4f856100b2e044982b35efc1b2b8198563e364a3f8ad04042f1b2863f2390b4eec671127429b2c5e718acd9551cb133c975867cd365d64985736dad6c003628a909f7e5bbf6640152497313e057159086a69c687baca50953a71c7ab0d89")
const `verifier::vk_alpha_1` = stringHexToSlice("b1b83e55445b659621850963559851270e7f209be2ba8ec89529d0705991aa0e369d315ebb4aedb2b38232d29621789e")
const `verifier::vk_beta_2`  = stringHexToSlice("90c699a329380ef521a9022f0abb0f06f072bf81efab4b8d15bc10186b558335f81f8588f0a43f751fda31f427f7f9cf0238b10a60115bd4e51fa1baaa4d6e1dd8797804f40baa93451fd46b04a2884b4e75cfdb584f457b51544e7fe687da9f")

// public input dict settings
const `verifier::publicInputKeyLen` = 32
const `verifier::nPublic` = 1

// error codes
const `verifier::err::public_not_present` = 257
const `verifier::err::too_many_publics` = 258

// bls intrinsics
@pure
fun blsG1Add(x: slice, y: slice): slice
    asm "BLS_G1_ADD";
@pure
fun blsG1Neg(x: slice): slice
    asm "BLS_G1_NEG";
@pure
fun blsPairing(x1: slice, y1: slice, x2: slice, y2: slice, x3: slice, y3: slice, x4: slice, y4: slice, n: int): int
    asm "BLS_PAIRING";


@pure
fun blsG1Multiexp_1(
    x1: slice, y1: int
    , n: int
): slice
    asm "BLS_G1_MULTIEXP";

// slice helpers
fun slice.loadP1(mutate self): slice {
    var c: cell = self.loadRef();
    var s: slice = c.beginParse();
    var p1: slice = s.getFirstBits(`verifier::P1_SIZE`);
    s.skipBits(`verifier::P1_SIZE`);
    self = s; return p1;
}

fun slice.loadP2(mutate self): slice {
    var c: cell = self.loadRef();
    var s: slice = c.beginParse();
    var p2: slice = s.getFirstBits(`verifier::P2_SIZE`);
    s.skipBits(`verifier::P2_SIZE`);
    self = s; return p2;
}

fun groth16Verify(
    piA: slice,
    piB: slice,
    piC: slice,
    pubInputs: dict
): int {
    var res: int = 0;

    // извлекаем публичные входы по ключам 0..nPublic-1
    var (input0: slice?, ok0: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 0);
    assert(ok0) throw `verifier::err::public_not_present`;
    var val0: int = input0!.loadUint(256);

    // убеждаемся, что в dict ничего не осталось
    assert((pubInputs == null)) throw `verifier::err::too_many_publics`;

    // собираем cpub через batched MULTIEXP и суммирование
    var cpub: slice = blsG1Multiexp_1(
        `verifier::IC1`, val0
        , 1
    );

    // добавляем свободный член IC0
    cpub = blsG1Add(cpub, `verifier::IC0`);

    // pairing check
    var piANeg: slice = blsG1Neg(piA);
    var a: int = blsPairing(
        cpub,                 `verifier::vk_gamma_2`,
        piANeg,               piB,
        piC,                  `verifier::vk_delta_2`,
        `verifier::vk_alpha_1`, `verifier::vk_beta_2`,
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
    var pubInputs = inMsgBody.loadDict();

    return groth16Verify(piA, piB, piC, pubInputs);
}

// in the future, use: fun onInternalMessage(in: InMessage)
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
    pubInputs: slice
): int {
    return groth16Verify(
        piA,
        piB,
        piC,
        pubInputs.loadDict()
    );
}
