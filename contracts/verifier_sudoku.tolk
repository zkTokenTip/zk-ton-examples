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
const `verifier::err::index_out_of_range` = 259

// BLS intrinsics
@pure 
  fun blsG1Add(x: slice, y: slice): slice 
    asm "BLS_G1_ADD";
@pure 
  fun blsG1Neg(x: slice): slice       
    asm "BLS_G1_NEG";
@pure 
  fun blsPairing(
    x1: slice, y1: slice,
    x2: slice, y2: slice,
    x3: slice, y3: slice,
    x4: slice, y4: slice,
    n: int
  ): int asm "BLS_PAIRING";


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
): slice asm "BLS_G1_MULTIEXP";
@pure
fun blsG1Multiexp_4(
  x1: slice, y1: int,
  x2: slice, y2: int,
  x3: slice, y3: int,
  x4: slice, y4: int
  , n: int
): slice asm "BLS_G1_MULTIEXP";

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

// IC selector for runtime index: 1 -> IC1, 2 -> IC2, ...
fun ic(idx: int): slice {
  if (idx == 1) { return `verifier::IC1`; }
  if (idx == 2) { return `verifier::IC2`; }
  if (idx == 3) { return `verifier::IC3`; }
  if (idx == 4) { return `verifier::IC4`; }
  if (idx == 5) { return `verifier::IC5`; }
  if (idx == 6) { return `verifier::IC6`; }
  if (idx == 7) { return `verifier::IC7`; }
  if (idx == 8) { return `verifier::IC8`; }
  if (idx == 9) { return `verifier::IC9`; }
  if (idx == 10) { return `verifier::IC10`; }
  if (idx == 11) { return `verifier::IC11`; }
  if (idx == 12) { return `verifier::IC12`; }
  if (idx == 13) { return `verifier::IC13`; }
  if (idx == 14) { return `verifier::IC14`; }
  if (idx == 15) { return `verifier::IC15`; }
  if (idx == 16) { return `verifier::IC16`; }
  if (idx == 17) { return `verifier::IC17`; }
  if (idx == 18) { return `verifier::IC18`; }
  if (idx == 19) { return `verifier::IC19`; }
  if (idx == 20) { return `verifier::IC20`; }
  if (idx == 21) { return `verifier::IC21`; }
  if (idx == 22) { return `verifier::IC22`; }
  if (idx == 23) { return `verifier::IC23`; }
  if (idx == 24) { return `verifier::IC24`; }
  if (idx == 25) { return `verifier::IC25`; }
  if (idx == 26) { return `verifier::IC26`; }
  if (idx == 27) { return `verifier::IC27`; }
  if (idx == 28) { return `verifier::IC28`; }
  if (idx == 29) { return `verifier::IC29`; }
  if (idx == 30) { return `verifier::IC30`; }
  if (idx == 31) { return `verifier::IC31`; }
  if (idx == 32) { return `verifier::IC32`; }
  if (idx == 33) { return `verifier::IC33`; }
  if (idx == 34) { return `verifier::IC34`; }
  if (idx == 35) { return `verifier::IC35`; }
  if (idx == 36) { return `verifier::IC36`; }
  if (idx == 37) { return `verifier::IC37`; }
  if (idx == 38) { return `verifier::IC38`; }
  if (idx == 39) { return `verifier::IC39`; }
  if (idx == 40) { return `verifier::IC40`; }
  if (idx == 41) { return `verifier::IC41`; }
  if (idx == 42) { return `verifier::IC42`; }
  if (idx == 43) { return `verifier::IC43`; }
  if (idx == 44) { return `verifier::IC44`; }
  if (idx == 45) { return `verifier::IC45`; }
  if (idx == 46) { return `verifier::IC46`; }
  if (idx == 47) { return `verifier::IC47`; }
  if (idx == 48) { return `verifier::IC48`; }
  if (idx == 49) { return `verifier::IC49`; }
  if (idx == 50) { return `verifier::IC50`; }
  if (idx == 51) { return `verifier::IC51`; }
  if (idx == 52) { return `verifier::IC52`; }
  if (idx == 53) { return `verifier::IC53`; }
  if (idx == 54) { return `verifier::IC54`; }
  if (idx == 55) { return `verifier::IC55`; }
  if (idx == 56) { return `verifier::IC56`; }
  if (idx == 57) { return `verifier::IC57`; }
  if (idx == 58) { return `verifier::IC58`; }
  if (idx == 59) { return `verifier::IC59`; }
  if (idx == 60) { return `verifier::IC60`; }
  if (idx == 61) { return `verifier::IC61`; }
  if (idx == 62) { return `verifier::IC62`; }
  if (idx == 63) { return `verifier::IC63`; }
  if (idx == 64) { return `verifier::IC64`; }
  if (idx == 65) { return `verifier::IC65`; }
  if (idx == 66) { return `verifier::IC66`; }
  if (idx == 67) { return `verifier::IC67`; }
  if (idx == 68) { return `verifier::IC68`; }
  if (idx == 69) { return `verifier::IC69`; }
  if (idx == 70) { return `verifier::IC70`; }
  if (idx == 71) { return `verifier::IC71`; }
  if (idx == 72) { return `verifier::IC72`; }
  if (idx == 73) { return `verifier::IC73`; }
  if (idx == 74) { return `verifier::IC74`; }
  if (idx == 75) { return `verifier::IC75`; }
  if (idx == 76) { return `verifier::IC76`; }
  if (idx == 77) { return `verifier::IC77`; }
  if (idx == 78) { return `verifier::IC78`; }
  if (idx == 79) { return `verifier::IC79`; }
  if (idx == 80) { return `verifier::IC80`; }
  if (idx == 81) { return `verifier::IC81`; }
  throw(`verifier::err::index_out_of_range`);
}

fun groth16Verify(
  piA: slice,
  piB: slice,
  piC: slice,
  pubInputs: dict
): int {
  var res: int = 0;

  // loop over full 7-sized batches using uDictGet (non-destructive)
  var done: int = 0;
  var full: int = `verifier::nPublic` / 7;
  var rem:  int = `verifier::nPublic` % 7;

  var haveCpub: bool = false;
  var cpub: slice = `verifier::IC0`; // replaced on first batch

  while (full > 0) {
    var in0: slice?; var ok0: bool; var v0: int;
    var in1: slice?; var ok1: bool; var v1: int;
    var in2: slice?; var ok2: bool; var v2: int;
    var in3: slice?; var ok3: bool; var v3: int;
    var in4: slice?; var ok4: bool; var v4: int;
    var in5: slice?; var ok5: bool; var v5: int;
    var in6: slice?; var ok6: bool; var v6: int;

    (in0, ok0) = pubInputs.uDictGet(`verifier::publicInputKeyLen`, done + 0); assert(ok0) throw `verifier::err::public_not_present`; v0 = in0!.loadUint(256);
    (in1, ok1) = pubInputs.uDictGet(`verifier::publicInputKeyLen`, done + 1); assert(ok1) throw `verifier::err::public_not_present`; v1 = in1!.loadUint(256);
    (in2, ok2) = pubInputs.uDictGet(`verifier::publicInputKeyLen`, done + 2); assert(ok2) throw `verifier::err::public_not_present`; v2 = in2!.loadUint(256);
    (in3, ok3) = pubInputs.uDictGet(`verifier::publicInputKeyLen`, done + 3); assert(ok3) throw `verifier::err::public_not_present`; v3 = in3!.loadUint(256);
    (in4, ok4) = pubInputs.uDictGet(`verifier::publicInputKeyLen`, done + 4); assert(ok4) throw `verifier::err::public_not_present`; v4 = in4!.loadUint(256);
    (in5, ok5) = pubInputs.uDictGet(`verifier::publicInputKeyLen`, done + 5); assert(ok5) throw `verifier::err::public_not_present`; v5 = in5!.loadUint(256);
    (in6, ok6) = pubInputs.uDictGet(`verifier::publicInputKeyLen`, done + 6); assert(ok6) throw `verifier::err::public_not_present`; v6 = in6!.loadUint(256);

    var tmp: slice = blsG1Multiexp_7(
      ic(done + 1), v0,
      ic(done + 2), v1,
      ic(done + 3), v2,
      ic(done + 4), v3,
      ic(done + 5), v4,
      ic(done + 6), v5,
      ic(done + 7), v6,
      7
    );
    if (!haveCpub) {
      cpub = tmp;
      haveCpub = true;
    } else {
      cpub = blsG1Add(cpub, tmp);
    }
    done += 7;
    full -= 1;
  }

    // tail batch (exact remainder handling)
    if (rem == 4) {
        var inT0: slice?; var okT0: bool; var vT0: int;
    (inT0, okT0) = pubInputs.uDictGet(`verifier::publicInputKeyLen`, done + 0);
    assert(okT0) throw `verifier::err::public_not_present`;
    vT0 = inT0!.loadUint(256);
        var inT1: slice?; var okT1: bool; var vT1: int;
    (inT1, okT1) = pubInputs.uDictGet(`verifier::publicInputKeyLen`, done + 1);
    assert(okT1) throw `verifier::err::public_not_present`;
    vT1 = inT1!.loadUint(256);
        var inT2: slice?; var okT2: bool; var vT2: int;
    (inT2, okT2) = pubInputs.uDictGet(`verifier::publicInputKeyLen`, done + 2);
    assert(okT2) throw `verifier::err::public_not_present`;
    vT2 = inT2!.loadUint(256);
        var inT3: slice?; var okT3: bool; var vT3: int;
    (inT3, okT3) = pubInputs.uDictGet(`verifier::publicInputKeyLen`, done + 3);
    assert(okT3) throw `verifier::err::public_not_present`;
    vT3 = inT3!.loadUint(256);
        var tail: slice = blsG1Multiexp_4(
            ic(done + 1), vT0,
            ic(done + 2), vT1,
            ic(done + 3), vT2,
            ic(done + 4), vT3
            , 4
    );
    if (!haveCpub) {
      cpub = tail;
      haveCpub = true;
    } else {
      cpub = blsG1Add(cpub, tail);
    }
    done += 4;
  }
    
  // add constant term
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

  res = (a == 0) ? 0 : 1;
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
x