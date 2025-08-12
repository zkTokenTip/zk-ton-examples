import "@stdlib/tvm-dicts"

// ops
const OP_VERIFY = stringCrc32("op::verify")

// sizes
const `verifier::P1_SIZE` = 48 * 8
const `verifier::P2_SIZE` = 96 * 8

// input constants (IC0 is the base term)
const `verifier::IC0` = stringHexToSlice("aca8a097ec4d0973419a55635d08f7106191e32faad59ef23aeef583a0cd33cc4f5d155c669dacaefb77c49a67d4dcbc")
const `verifier::IC1` = stringHexToSlice("976baa064a70d9739778564bf95c53832b24e6b5affcbbb729f0b1651d54c53e736b76b7a821b24743d9ba9dc67d8634")
const `verifier::IC2` = stringHexToSlice("81ec65333b05e0e8fc0b1f7ff075a4b31a1df9e4a2f5081c86c4f728ad0358df08809ead7c439fd2e4f42d9885db2b65")
const `verifier::IC3` = stringHexToSlice("b91325f74de4e3a9076fdf2c7aad54654a49d9a33379437ae4dfaa32b56c86806cfccd6b612a52e57fabe87e3e403132")
const `verifier::IC4` = stringHexToSlice("8e45aea2a480a2db346f8f4075fbe1b8f8e1508266cf818554dfd9173f1f90186361919bbb4b18685bf279f67fb5a329")
const `verifier::IC5` = stringHexToSlice("b712910775c62abe64345b8a0717d31d87593f1e1dee0dbc9177cffc6c610f0cd014d6c2fc22b8867031ef7491968475")
const `verifier::IC6` = stringHexToSlice("af60d2ee85eac32e322df0f2bde65f6762e6e5b3e9fcd587292ad5df94bcfdfbcbbbf1429697d61236d9f28f218a8f71")
const `verifier::IC7` = stringHexToSlice("95cbccf5b961d08d1f53c7cc40c6539c51af25a31cca929301d691973aec4b3d51646c5a04a81fa5dcb5f904ce46021e")
const `verifier::IC8` = stringHexToSlice("b2b755e7c9b99a2cc63015e1fae70174ab42c643e0c00939799b3e25554cbb375906857b80d999046d988760e8d329ba")
const `verifier::IC9` = stringHexToSlice("a46f0e916234c2178ebbaa67c68d1ebc6b86b6e16826b99ee07fcbf01d07d0281f05b8262f139c6af7bd43c5ac51014b")
const `verifier::IC10` = stringHexToSlice("a0d52931e327398417676c4468b1f18e60e906f57f35c2bb667d2e6da65c2ddf817a8204ce4aa25dc58ca35ae2b9558e")
const `verifier::IC11` = stringHexToSlice("ace3886e7bce3b28fb715b9d77c727f9f9feb2c995c8bb646739e1427bd1f8b826631e7a3c5291d7cc8b967861ecb174")
const `verifier::IC12` = stringHexToSlice("997bc97737e1435daf392690c955d2ba28d9c4a3734b6887d0efa7eaa069538c3330d713679518f2f119205c4f346b51")
const `verifier::IC13` = stringHexToSlice("957b705a124df713f0350cbdfb5b9c07f2228539d590c5248d9a6ce81dff6953622d5e089b5501fda391ccfbaf68cb91")
const `verifier::IC14` = stringHexToSlice("90977ad2e28d641357c5f7d5981070e3b69d79e01a7d3f083b9323700ff95eff68493c035461f27833ab141b848531cd")
const `verifier::IC15` = stringHexToSlice("99cfc34aa49360571f6def9e8da017d66fb1ea9c478adf469ce0cb5b7c8dca84450440ab259e0bc5d23d1dd903547816")
const `verifier::IC16` = stringHexToSlice("a81f50f05431b5fbcaf2efd03dc0d344f751bda4e07ef2e4d7495a3fa246e8d56e12131ded6f3195826e125cfbb874f4")
const `verifier::IC17` = stringHexToSlice("802341c0e7db2159a6e9d25ca1ee4536d36b5e1d47e28e85afdb63fd6ec906278da833f8cac869139b9085332e9fc65e")
const `verifier::IC18` = stringHexToSlice("9080f602ccc26aec80eba57d13b757718d2cb848024ea48ea4fb67fd14f0a5f44ada406ef5e86745471b3e54d5b7ca06")
const `verifier::IC19` = stringHexToSlice("802b60c978a7a3d790f75236cd1e3bcf52d0ee86cfd14dc40b40fb7315fd8fdc65ebfa1b402a8af9d54608901435721c")
const `verifier::IC20` = stringHexToSlice("814db519c3fa6948c77714e2eb057c8eaf976b5ea2eeb3f472833da5020b193fd786d45dc1bc4ee57d040b080809b9a9")
const `verifier::IC21` = stringHexToSlice("b2625bf9cd11bb25f51b71957196df0bc4d78a4e20bf875c406fe5a6a626b12eaea8c2c611b581da91cbcfac1cf78869")
const `verifier::IC22` = stringHexToSlice("85a9743c6b5778351fbf6d87b9907d20b3c1d997b4cb677386c35c75bed813ab1ea02fac9178d5cdc49991aec2d997a0")
const `verifier::IC23` = stringHexToSlice("94623adadcfeb8e7616387004f336e4ad9135dd705c600e5f6b8c7a4115aa79f2fee37d3760093aab7673dc1887ae0e5")
const `verifier::IC24` = stringHexToSlice("a6ed94e52b25ea05aa45febe3c75b725d3e1cdffc867a58230d5f3d3f5ec7c5cadc19fab149c2176736b70b4ff65cc8c")
const `verifier::IC25` = stringHexToSlice("8f367a97cf76a0824f2ce86a52d63df4a8d175ccf72770c987ac2b3863098600bea2ade59316bd1350d3ad8cf3c6b3fa")
const `verifier::IC26` = stringHexToSlice("a7780af8695fb5b385a3fd7f94f0dcd199734b0b531141f78c8246ace9386c83dc29f05e8f9390de2b3fbe893bece88e")
const `verifier::IC27` = stringHexToSlice("9938ff18c4cdb5a177e8a0e1871d41110986ff7f3be1e22e3d8e86e8852b5d585415279b8597db52990e2d4aa0ef6eb5")
const `verifier::IC28` = stringHexToSlice("a8eaca01b52fda755d9614595c6b3c3315cbf67be8e89eaf09318cbea0f063a3a674318a12027d6d9d03da12b5caf4e2")
const `verifier::IC29` = stringHexToSlice("b960f17ed88e350edcc216c241e2b403a1894059c1fe102063b01163a4cd54f59a705beb674d049b37f54e3b285b0871")
const `verifier::IC30` = stringHexToSlice("b11c46058e31ae6bca54be8dacc7e6c10af610f25e78abcc5455eda57be203524357c18a5d2e25bce7f63334a7afb5bf")
const `verifier::IC31` = stringHexToSlice("8803694435ea179fa0bd1bf738ee4c63c9b6ab8ac36bd42235aaa0a9ba19b9cc20c01c191caa2898d046158b5a2d418e")
const `verifier::IC32` = stringHexToSlice("836b4df8c3d1caf65b6ad1cb56ac640fe9464a7c28e766206fb89efacecfa403bac548c6078f0e62ef284b7d6de8a95f")
const `verifier::IC33` = stringHexToSlice("a80351b881e28778b4fabc61ae4aa6b2a0f95188f87e42c1e501d92f73686d40a39ad0469f1444769386def86ef7f5ed")
const `verifier::IC34` = stringHexToSlice("943bf06b9532ba6a222e0ee489b2aae690e5c2ee8f1bc4aac5dccd84ef257eb485114fcad1e7b81a00b192b87a99f6cd")
const `verifier::IC35` = stringHexToSlice("aee9836d96c26f3e53f354d39c73f2969797fa075c9b5af9d22fccd87f0f705090538a5a9b4df2d10eeede5ba8da6637")
const `verifier::IC36` = stringHexToSlice("a7f55f609e5c7d80036baf53226d178da8b1b3bcfa1927a808ed450540515ef7c8e8aba0649981c1a5042153391346b2")
const `verifier::IC37` = stringHexToSlice("b2759eb2ae408a8192be5d08d6303120518133c1aa1d385097905b639955b099c2da82ea370e5abc5cba1c5db35f19c7")
const `verifier::IC38` = stringHexToSlice("a452c5c78ea55372a7b818e402eb8cfbae37741d42dbd16e9578c11e7e14cdf919749bce9eb055decd279d6214fa643d")
const `verifier::IC39` = stringHexToSlice("b34b6eebe948e690baf3c0c056a523365d8b650baddbdca44a8c4c1350ee0d5965495f7a9346726e84ac4c43101e9793")
const `verifier::IC40` = stringHexToSlice("998851b70c85f1ddad5ef5beeeb95db26dd406af1b6538ee2751d7a1e3520bad6607c6ef16a65304c81dd795cdcce3fa")
const `verifier::IC41` = stringHexToSlice("8252064a73217b47e2492be12e1cffad5b1c558dd7e2f43b5371fce87a49841692ab8da9165b4d42b3c117211785cc14")
const `verifier::IC42` = stringHexToSlice("92d6b47a377841b06de62b2bde97d51027e5b6afb3bd3966ba02a93eaec662a3ffe79bc902dbf41bb57fae0979a31e3d")
const `verifier::IC43` = stringHexToSlice("9269a40a656b6c8f34e457c4c6cccd8eae76b954a09f631673c40b9ee097f5a59fd76491b82ca9678b75ed9a2579ea0a")
const `verifier::IC44` = stringHexToSlice("989bc14fc9bcb038ced69fd62b4771bf345f1cc69410574a9414f342a4bd5f0b260c8903e47d0520b7e5b3a9f88ff739")
const `verifier::IC45` = stringHexToSlice("88546ee67810b305708d0110d53b95b5043be19c750b84b6122bdca90331012799d7b538f72541c0763e8a7834f83b20")
const `verifier::IC46` = stringHexToSlice("b074a89a679f38a14c3f4019c6b213922d34e4fae578943e4e72aa5cc33c1769ff00ba41611b6d85c3944529a3fed8b6")
const `verifier::IC47` = stringHexToSlice("b850f9e5e42ee62651968fbfbf2883b962dd8cd033469da3b16dd6e880c9ff66e0057040affc801a496b3d014f20e1ed")
const `verifier::IC48` = stringHexToSlice("966fa4a274dd8729b1cd09d2bea328b2f18a528ed753b4d19a3f9c5526e37820c545441677a805a462694b3892ef64dd")
const `verifier::IC49` = stringHexToSlice("8314e5e3bbf1cb4ba94e893b631578564e8f36d12277293508e4bbad260d9aaeaa9e3b3c31727451742e84214fd05029")
const `verifier::IC50` = stringHexToSlice("93cd7cd8a80521266326fddc5a4a108027ee1e6df185be7ec583a2c4951cd787f27c4069a19ba06002fb18a3bd49d094")
const `verifier::IC51` = stringHexToSlice("93574dceb60dfdf37e971487faaf0ae41f9794b3c8ac7065e41d9fcbacd7d9a642333aca9d836a9a4ca25d2e7a5fd8d3")
const `verifier::IC52` = stringHexToSlice("86f3034f81e7dfeb48d5070ea28504de951ca69b7f1e9abd64bdb4ac0cbe28f29b8a41dfa04979e77c76659a5ccdf56c")
const `verifier::IC53` = stringHexToSlice("983bb972e097108bc05274f91a2c073acdff14be43624fde38ac0cc4cdcca1fbf8d67d6bbe95e0c3a9f9fec736bb1289")
const `verifier::IC54` = stringHexToSlice("862270c5a328665c32ac193c84163f36030114b007ee86cdf7957072e15469f24137d9067a698f6965c51762dd208b51")
const `verifier::IC55` = stringHexToSlice("a38f9398fca6751a9b1e8f3b57292fbdeadddf88817127478a7a814abc05a7a8b4c3154a61b389fdbf77b372747a2c94")
const `verifier::IC56` = stringHexToSlice("966b4f9766495d96d8f6225af927e87e34d8a5fafadd98a61bfb5ce73354cacdb7a858d1325aa99ec799060bc0a5e6dc")
const `verifier::IC57` = stringHexToSlice("95f933cbaa7cc6103a756a0b539f226ec39efbb4674e136e1411fe397623f910eb8b3e84d126afc010f2d6a5e0ca66f6")
const `verifier::IC58` = stringHexToSlice("a7413cb4581c635f61fef145f5607a9056ba43ea22e0d003dcb8cf97b52f141ba1f0adba210f2b1cf5fcc0dffe6521d0")
const `verifier::IC59` = stringHexToSlice("a2cbb24c04c60ea96ca5f89afa193ec1938fcade9b337217afe27e87561a0821eed88d32cdfdf0fd70d68ab73493f2f8")
const `verifier::IC60` = stringHexToSlice("a0c2302e00aa21af66aece8eab3f2f9adebe6437a070d91588736e9f564429a138db94dee22219d4d555d5850e7b0c07")
const `verifier::IC61` = stringHexToSlice("881046800d22522b8aba23d4f63e99ed5b8098776dcd661952bb6f15ccd1c333f0f3183863c2928bcb5f617dcfbe1ed3")
const `verifier::IC62` = stringHexToSlice("8d5d60ccabddf7dcfd12ff8ccd10bd8f8454174aba08106c66fcb4283e05a7a1ece7a4a5dd38ddef3f195273f9bafb2e")
const `verifier::IC63` = stringHexToSlice("aecda997d0bd2b700f758a6dc35c824ff896f54a4bd50cb35a42a9fb446f6bf3fc0dcb04f5119fad14c75e76dffb6907")
const `verifier::IC64` = stringHexToSlice("aa59219189adecb90e16f78e67a0273c4c74801db0672ca8cd54cde2ebbb8f2795ca1fe7e7cc1e22d715d5a105aa6b3d")
const `verifier::IC65` = stringHexToSlice("8d2905820f98ff9c12fbb162634887702363251bd3e3e5f0f12c633ad9783b2770d8c9937ec81503e1205fb8edfff2f4")
const `verifier::IC66` = stringHexToSlice("b9faefe85f41955ce6eef7ecf04d820a99ccc8ed148a8c7c343a110f7460291fd2b5c2ce0b283df307930f41d0d0e119")
const `verifier::IC67` = stringHexToSlice("aecc8ad7b1a539bb40792b83583fb2ee6a415feee10ac0c634c6b4b364c1fb003d8262737974ef10ce2e51d6263a73bc")
const `verifier::IC68` = stringHexToSlice("946caa40c1d6ddd6878ffd72ded7986cc3d085ec49745fcfa8d5845f2151fbc9c02a1aade138354ac62ccab7af6f2a0d")
const `verifier::IC69` = stringHexToSlice("817d7ecada163d5494bcf53aeebb14ffda36c7322d7837f3ad770c083ab763ccd7f623f497bd65c0fad1445691979930")
const `verifier::IC70` = stringHexToSlice("8869b57fdf48cd877b90f9e432a6b0545a5adffbedb36aa9646e6e2f54af8dedfa2037b71047734f6279c27afe6ea5f4")
const `verifier::IC71` = stringHexToSlice("85ad0ba6f0a7fea69dcbb5dca9cd61b12a78ca076e198b00be7b4fbc58519408cfc509e071d68238f63110c9aa05460a")
const `verifier::IC72` = stringHexToSlice("a5a481231754c2d2e48e2086bf2142fa1a61cb11fbf3327df7f67723bc4163bb732f1a3ad520f2ec636c35e134a1ae2a")
const `verifier::IC73` = stringHexToSlice("b51542bfba778d5f33b8b4a91562a9f984d214f8b90535d3bb0ae0bcb481b8719d527a5f91d38e6f0d0a615e4becee5e")
const `verifier::IC74` = stringHexToSlice("a7c19ee710385103c1bd7896c6df0a17fbe95e7257f191981ce03775884d90a7218cdd7045e243483f3de5242bafb58e")
const `verifier::IC75` = stringHexToSlice("986ff95eaf7a0b36c2e5ab1ead3cbe355b27ab7572fba07cbd955c284d5c6ab24e101fd2041833375e1d24aa681ef60a")
const `verifier::IC76` = stringHexToSlice("80d613c316ed2e5802bb5ae71b82ec24bb0e9a47f24673ad70d350be3fc71e6ecd18c162cbfd9e3a1811bbb8958eca6a")
const `verifier::IC77` = stringHexToSlice("a1dac091995874082a8563fe74bc3d6e0d0a58c70cc5f112711cd77553b12477e8b114587c2ae35545c6d128f53e0fdb")
const `verifier::IC78` = stringHexToSlice("a7f19006fd70db36a44a608062df569652c5d4ff5be92a76d3a0b247f6487b8fc7fe2d2574dd931757171ac4d75a857d")
const `verifier::IC79` = stringHexToSlice("8cf6aae27323e7a429725f6f795ae6eb596970522485c7ca49a5f5c91150331317a0029ab44eb4dc8d8d5a4f77b6cf7d")
const `verifier::IC80` = stringHexToSlice("85c2eec96d675bcbda9afb452de8b2b89b8b41d97e65d61a2cae601342af618a42b7fe3654e62de18d017dbd1a4ba556")
const `verifier::IC81` = stringHexToSlice("aadc70ebe1233452b44683fc90c5823bc014d4ae880a947a5dbeac8db8fc73f45694d96fccc35840d048df9be0893da5")

// vk constants
const `verifier::vk_gamma_2` = stringHexToSlice("93e02b6052719f607dacd3a088274f65596bd0d09920b61ab5da61bbdc7f5049334cf11213945d57e5ac7d055d042b7e024aa2b2f08f0a91260805272dc51051c6e47ad4fa403b02b4510b647ae3d1770bac0326a805bbefd48056c8c121bdb8")
const `verifier::vk_delta_2` = stringHexToSlice("aecc523f51e16184d52b69af614f9346a8fa9dcdb3ccb9459ef81b9282e3108449e4bbfbd0f896d41b1d17935bd7f077185863c2a883653e5187a80cd04552bf5c978a3b476b0e382aeb4cff75424787b7edfc34bd31df0f7f336053ed6318cd")
const `verifier::vk_alpha_1` = stringHexToSlice("93a3f95cbc299feeb9e9056dd15fdbaaf2015236573479597994dbf08b251c54829152d3fb818e56b1bcb289315d9304")
const `verifier::vk_beta_2`  = stringHexToSlice("86a610cf5d228d04dc0ba37791497053bbff0c2a341925dfce424cffb3b9a5b8bdae8a316764626c80f910344532a0ed0919b9b76da74745b2175160fcdad651e16dc9d92579802925c299b4ffb4d8c7419cb9dc8e76223be3a571d85fb27533")

// public input dict settings
const `verifier::publicInputKeyLen` = 32
const `verifier::nPublic` = 81

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
fun blsG1Multiexp_7(
    x1: slice, y1: int,
    x2: slice, y2: int,
    x3: slice, y3: int,
    x4: slice, y4: int,
    x5: slice, y5: int,
    x6: slice, y6: int,
    x7: slice, y7: int
    , n: int
): slice
    asm "BLS_G1_MULTIEXP";
@pure
fun blsG1Multiexp_4(
    x1: slice, y1: int,
    x2: slice, y2: int,
    x3: slice, y3: int,
    x4: slice, y4: int
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
    var (input1: slice?, ok1: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 1);
    assert(ok1) throw `verifier::err::public_not_present`;
    var val1: int = input1!.loadUint(256);
    var (input2: slice?, ok2: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 2);
    assert(ok2) throw `verifier::err::public_not_present`;
    var val2: int = input2!.loadUint(256);
    var (input3: slice?, ok3: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 3);
    assert(ok3) throw `verifier::err::public_not_present`;
    var val3: int = input3!.loadUint(256);
    var (input4: slice?, ok4: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 4);
    assert(ok4) throw `verifier::err::public_not_present`;
    var val4: int = input4!.loadUint(256);
    var (input5: slice?, ok5: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 5);
    assert(ok5) throw `verifier::err::public_not_present`;
    var val5: int = input5!.loadUint(256);
    var (input6: slice?, ok6: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 6);
    assert(ok6) throw `verifier::err::public_not_present`;
    var val6: int = input6!.loadUint(256);
    var (input7: slice?, ok7: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 7);
    assert(ok7) throw `verifier::err::public_not_present`;
    var val7: int = input7!.loadUint(256);
    var (input8: slice?, ok8: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 8);
    assert(ok8) throw `verifier::err::public_not_present`;
    var val8: int = input8!.loadUint(256);
    var (input9: slice?, ok9: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 9);
    assert(ok9) throw `verifier::err::public_not_present`;
    var val9: int = input9!.loadUint(256);
    var (input10: slice?, ok10: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 10);
    assert(ok10) throw `verifier::err::public_not_present`;
    var val10: int = input10!.loadUint(256);
    var (input11: slice?, ok11: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 11);
    assert(ok11) throw `verifier::err::public_not_present`;
    var val11: int = input11!.loadUint(256);
    var (input12: slice?, ok12: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 12);
    assert(ok12) throw `verifier::err::public_not_present`;
    var val12: int = input12!.loadUint(256);
    var (input13: slice?, ok13: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 13);
    assert(ok13) throw `verifier::err::public_not_present`;
    var val13: int = input13!.loadUint(256);
    var (input14: slice?, ok14: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 14);
    assert(ok14) throw `verifier::err::public_not_present`;
    var val14: int = input14!.loadUint(256);
    var (input15: slice?, ok15: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 15);
    assert(ok15) throw `verifier::err::public_not_present`;
    var val15: int = input15!.loadUint(256);
    var (input16: slice?, ok16: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 16);
    assert(ok16) throw `verifier::err::public_not_present`;
    var val16: int = input16!.loadUint(256);
    var (input17: slice?, ok17: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 17);
    assert(ok17) throw `verifier::err::public_not_present`;
    var val17: int = input17!.loadUint(256);
    var (input18: slice?, ok18: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 18);
    assert(ok18) throw `verifier::err::public_not_present`;
    var val18: int = input18!.loadUint(256);
    var (input19: slice?, ok19: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 19);
    assert(ok19) throw `verifier::err::public_not_present`;
    var val19: int = input19!.loadUint(256);
    var (input20: slice?, ok20: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 20);
    assert(ok20) throw `verifier::err::public_not_present`;
    var val20: int = input20!.loadUint(256);
    var (input21: slice?, ok21: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 21);
    assert(ok21) throw `verifier::err::public_not_present`;
    var val21: int = input21!.loadUint(256);
    var (input22: slice?, ok22: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 22);
    assert(ok22) throw `verifier::err::public_not_present`;
    var val22: int = input22!.loadUint(256);
    var (input23: slice?, ok23: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 23);
    assert(ok23) throw `verifier::err::public_not_present`;
    var val23: int = input23!.loadUint(256);
    var (input24: slice?, ok24: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 24);
    assert(ok24) throw `verifier::err::public_not_present`;
    var val24: int = input24!.loadUint(256);
    var (input25: slice?, ok25: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 25);
    assert(ok25) throw `verifier::err::public_not_present`;
    var val25: int = input25!.loadUint(256);
    var (input26: slice?, ok26: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 26);
    assert(ok26) throw `verifier::err::public_not_present`;
    var val26: int = input26!.loadUint(256);
    var (input27: slice?, ok27: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 27);
    assert(ok27) throw `verifier::err::public_not_present`;
    var val27: int = input27!.loadUint(256);
    var (input28: slice?, ok28: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 28);
    assert(ok28) throw `verifier::err::public_not_present`;
    var val28: int = input28!.loadUint(256);
    var (input29: slice?, ok29: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 29);
    assert(ok29) throw `verifier::err::public_not_present`;
    var val29: int = input29!.loadUint(256);
    var (input30: slice?, ok30: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 30);
    assert(ok30) throw `verifier::err::public_not_present`;
    var val30: int = input30!.loadUint(256);
    var (input31: slice?, ok31: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 31);
    assert(ok31) throw `verifier::err::public_not_present`;
    var val31: int = input31!.loadUint(256);
    var (input32: slice?, ok32: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 32);
    assert(ok32) throw `verifier::err::public_not_present`;
    var val32: int = input32!.loadUint(256);
    var (input33: slice?, ok33: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 33);
    assert(ok33) throw `verifier::err::public_not_present`;
    var val33: int = input33!.loadUint(256);
    var (input34: slice?, ok34: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 34);
    assert(ok34) throw `verifier::err::public_not_present`;
    var val34: int = input34!.loadUint(256);
    var (input35: slice?, ok35: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 35);
    assert(ok35) throw `verifier::err::public_not_present`;
    var val35: int = input35!.loadUint(256);
    var (input36: slice?, ok36: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 36);
    assert(ok36) throw `verifier::err::public_not_present`;
    var val36: int = input36!.loadUint(256);
    var (input37: slice?, ok37: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 37);
    assert(ok37) throw `verifier::err::public_not_present`;
    var val37: int = input37!.loadUint(256);
    var (input38: slice?, ok38: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 38);
    assert(ok38) throw `verifier::err::public_not_present`;
    var val38: int = input38!.loadUint(256);
    var (input39: slice?, ok39: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 39);
    assert(ok39) throw `verifier::err::public_not_present`;
    var val39: int = input39!.loadUint(256);
    var (input40: slice?, ok40: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 40);
    assert(ok40) throw `verifier::err::public_not_present`;
    var val40: int = input40!.loadUint(256);
    var (input41: slice?, ok41: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 41);
    assert(ok41) throw `verifier::err::public_not_present`;
    var val41: int = input41!.loadUint(256);
    var (input42: slice?, ok42: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 42);
    assert(ok42) throw `verifier::err::public_not_present`;
    var val42: int = input42!.loadUint(256);
    var (input43: slice?, ok43: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 43);
    assert(ok43) throw `verifier::err::public_not_present`;
    var val43: int = input43!.loadUint(256);
    var (input44: slice?, ok44: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 44);
    assert(ok44) throw `verifier::err::public_not_present`;
    var val44: int = input44!.loadUint(256);
    var (input45: slice?, ok45: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 45);
    assert(ok45) throw `verifier::err::public_not_present`;
    var val45: int = input45!.loadUint(256);
    var (input46: slice?, ok46: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 46);
    assert(ok46) throw `verifier::err::public_not_present`;
    var val46: int = input46!.loadUint(256);
    var (input47: slice?, ok47: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 47);
    assert(ok47) throw `verifier::err::public_not_present`;
    var val47: int = input47!.loadUint(256);
    var (input48: slice?, ok48: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 48);
    assert(ok48) throw `verifier::err::public_not_present`;
    var val48: int = input48!.loadUint(256);
    var (input49: slice?, ok49: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 49);
    assert(ok49) throw `verifier::err::public_not_present`;
    var val49: int = input49!.loadUint(256);
    var (input50: slice?, ok50: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 50);
    assert(ok50) throw `verifier::err::public_not_present`;
    var val50: int = input50!.loadUint(256);
    var (input51: slice?, ok51: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 51);
    assert(ok51) throw `verifier::err::public_not_present`;
    var val51: int = input51!.loadUint(256);
    var (input52: slice?, ok52: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 52);
    assert(ok52) throw `verifier::err::public_not_present`;
    var val52: int = input52!.loadUint(256);
    var (input53: slice?, ok53: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 53);
    assert(ok53) throw `verifier::err::public_not_present`;
    var val53: int = input53!.loadUint(256);
    var (input54: slice?, ok54: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 54);
    assert(ok54) throw `verifier::err::public_not_present`;
    var val54: int = input54!.loadUint(256);
    var (input55: slice?, ok55: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 55);
    assert(ok55) throw `verifier::err::public_not_present`;
    var val55: int = input55!.loadUint(256);
    var (input56: slice?, ok56: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 56);
    assert(ok56) throw `verifier::err::public_not_present`;
    var val56: int = input56!.loadUint(256);
    var (input57: slice?, ok57: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 57);
    assert(ok57) throw `verifier::err::public_not_present`;
    var val57: int = input57!.loadUint(256);
    var (input58: slice?, ok58: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 58);
    assert(ok58) throw `verifier::err::public_not_present`;
    var val58: int = input58!.loadUint(256);
    var (input59: slice?, ok59: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 59);
    assert(ok59) throw `verifier::err::public_not_present`;
    var val59: int = input59!.loadUint(256);
    var (input60: slice?, ok60: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 60);
    assert(ok60) throw `verifier::err::public_not_present`;
    var val60: int = input60!.loadUint(256);
    var (input61: slice?, ok61: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 61);
    assert(ok61) throw `verifier::err::public_not_present`;
    var val61: int = input61!.loadUint(256);
    var (input62: slice?, ok62: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 62);
    assert(ok62) throw `verifier::err::public_not_present`;
    var val62: int = input62!.loadUint(256);
    var (input63: slice?, ok63: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 63);
    assert(ok63) throw `verifier::err::public_not_present`;
    var val63: int = input63!.loadUint(256);
    var (input64: slice?, ok64: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 64);
    assert(ok64) throw `verifier::err::public_not_present`;
    var val64: int = input64!.loadUint(256);
    var (input65: slice?, ok65: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 65);
    assert(ok65) throw `verifier::err::public_not_present`;
    var val65: int = input65!.loadUint(256);
    var (input66: slice?, ok66: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 66);
    assert(ok66) throw `verifier::err::public_not_present`;
    var val66: int = input66!.loadUint(256);
    var (input67: slice?, ok67: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 67);
    assert(ok67) throw `verifier::err::public_not_present`;
    var val67: int = input67!.loadUint(256);
    var (input68: slice?, ok68: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 68);
    assert(ok68) throw `verifier::err::public_not_present`;
    var val68: int = input68!.loadUint(256);
    var (input69: slice?, ok69: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 69);
    assert(ok69) throw `verifier::err::public_not_present`;
    var val69: int = input69!.loadUint(256);
    var (input70: slice?, ok70: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 70);
    assert(ok70) throw `verifier::err::public_not_present`;
    var val70: int = input70!.loadUint(256);
    var (input71: slice?, ok71: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 71);
    assert(ok71) throw `verifier::err::public_not_present`;
    var val71: int = input71!.loadUint(256);
    var (input72: slice?, ok72: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 72);
    assert(ok72) throw `verifier::err::public_not_present`;
    var val72: int = input72!.loadUint(256);
    var (input73: slice?, ok73: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 73);
    assert(ok73) throw `verifier::err::public_not_present`;
    var val73: int = input73!.loadUint(256);
    var (input74: slice?, ok74: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 74);
    assert(ok74) throw `verifier::err::public_not_present`;
    var val74: int = input74!.loadUint(256);
    var (input75: slice?, ok75: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 75);
    assert(ok75) throw `verifier::err::public_not_present`;
    var val75: int = input75!.loadUint(256);
    var (input76: slice?, ok76: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 76);
    assert(ok76) throw `verifier::err::public_not_present`;
    var val76: int = input76!.loadUint(256);
    var (input77: slice?, ok77: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 77);
    assert(ok77) throw `verifier::err::public_not_present`;
    var val77: int = input77!.loadUint(256);
    var (input78: slice?, ok78: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 78);
    assert(ok78) throw `verifier::err::public_not_present`;
    var val78: int = input78!.loadUint(256);
    var (input79: slice?, ok79: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 79);
    assert(ok79) throw `verifier::err::public_not_present`;
    var val79: int = input79!.loadUint(256);
    var (input80: slice?, ok80: bool) = pubInputs.uDictDeleteAndGet(`verifier::publicInputKeyLen`, 80);
    assert(ok80) throw `verifier::err::public_not_present`;
    var val80: int = input80!.loadUint(256);

    // убеждаемся, что в dict ничего не осталось
    assert((pubInputs == null)) throw `verifier::err::too_many_publics`;

    // собираем cpub через batched MULTIEXP и суммирование
    var cpub: slice = blsG1Multiexp_7(
        `verifier::IC1`, val0,
        `verifier::IC2`, val1,
        `verifier::IC3`, val2,
        `verifier::IC4`, val3,
        `verifier::IC5`, val4,
        `verifier::IC6`, val5,
        `verifier::IC7`, val6
        , 7
    );
    cpub = blsG1Add(cpub, blsG1Multiexp_7(
        `verifier::IC8`, val7,
        `verifier::IC9`, val8,
        `verifier::IC10`, val9,
        `verifier::IC11`, val10,
        `verifier::IC12`, val11,
        `verifier::IC13`, val12,
        `verifier::IC14`, val13
        , 7
    ));
    cpub = blsG1Add(cpub, blsG1Multiexp_7(
        `verifier::IC15`, val14,
        `verifier::IC16`, val15,
        `verifier::IC17`, val16,
        `verifier::IC18`, val17,
        `verifier::IC19`, val18,
        `verifier::IC20`, val19,
        `verifier::IC21`, val20
        , 7
    ));
    cpub = blsG1Add(cpub, blsG1Multiexp_7(
        `verifier::IC22`, val21,
        `verifier::IC23`, val22,
        `verifier::IC24`, val23,
        `verifier::IC25`, val24,
        `verifier::IC26`, val25,
        `verifier::IC27`, val26,
        `verifier::IC28`, val27
        , 7
    ));
    cpub = blsG1Add(cpub, blsG1Multiexp_7(
        `verifier::IC29`, val28,
        `verifier::IC30`, val29,
        `verifier::IC31`, val30,
        `verifier::IC32`, val31,
        `verifier::IC33`, val32,
        `verifier::IC34`, val33,
        `verifier::IC35`, val34
        , 7
    ));
    cpub = blsG1Add(cpub, blsG1Multiexp_7(
        `verifier::IC36`, val35,
        `verifier::IC37`, val36,
        `verifier::IC38`, val37,
        `verifier::IC39`, val38,
        `verifier::IC40`, val39,
        `verifier::IC41`, val40,
        `verifier::IC42`, val41
        , 7
    ));
    cpub = blsG1Add(cpub, blsG1Multiexp_7(
        `verifier::IC43`, val42,
        `verifier::IC44`, val43,
        `verifier::IC45`, val44,
        `verifier::IC46`, val45,
        `verifier::IC47`, val46,
        `verifier::IC48`, val47,
        `verifier::IC49`, val48
        , 7
    ));
    cpub = blsG1Add(cpub, blsG1Multiexp_7(
        `verifier::IC50`, val49,
        `verifier::IC51`, val50,
        `verifier::IC52`, val51,
        `verifier::IC53`, val52,
        `verifier::IC54`, val53,
        `verifier::IC55`, val54,
        `verifier::IC56`, val55
        , 7
    ));
    cpub = blsG1Add(cpub, blsG1Multiexp_7(
        `verifier::IC57`, val56,
        `verifier::IC58`, val57,
        `verifier::IC59`, val58,
        `verifier::IC60`, val59,
        `verifier::IC61`, val60,
        `verifier::IC62`, val61,
        `verifier::IC63`, val62
        , 7
    ));
    cpub = blsG1Add(cpub, blsG1Multiexp_7(
        `verifier::IC64`, val63,
        `verifier::IC65`, val64,
        `verifier::IC66`, val65,
        `verifier::IC67`, val66,
        `verifier::IC68`, val67,
        `verifier::IC69`, val68,
        `verifier::IC70`, val69
        , 7
    ));
    cpub = blsG1Add(cpub, blsG1Multiexp_7(
        `verifier::IC71`, val70,
        `verifier::IC72`, val71,
        `verifier::IC73`, val72,
        `verifier::IC74`, val73,
        `verifier::IC75`, val74,
        `verifier::IC76`, val75,
        `verifier::IC77`, val76
        , 7
    ));
    cpub = blsG1Add(cpub, blsG1Multiexp_4(
        `verifier::IC78`, val77,
        `verifier::IC79`, val78,
        `verifier::IC80`, val79,
        `verifier::IC81`, val80
        , 4
    ));

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
