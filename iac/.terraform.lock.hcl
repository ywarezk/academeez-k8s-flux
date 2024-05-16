# This file is maintained automatically by "tofu init".
# Manual edits may be lost in future updates.

provider "registry.opentofu.org/fluxcd/flux" {
  version     = "1.3.0"
  constraints = ">= 1.3.0"
  hashes = [
    "h1:eIiNJd7LdNlJe/Cn1RvyLwP1/RyXat5dwjQEQWsPc+A=",
    "zh:3cd796472b0b3125ae7cd2097e68e9fa2f9abbef8f629326a9138ef9a4607ec3",
    "zh:3efe1aba8bec2dbacd90877245bbdca43455c19883f1cef0c3bc0ed80de399ea",
    "zh:48da143b7f2225a5f0e809ce2918578a8ffac043c72e2f49c7077b6c922b4361",
    "zh:49e2b02a59d70c62ed246760b534b5eca910a0652e2709a9c4889341d84f3cbd",
    "zh:5b1a633bb00a9054d9110775221a3d10a582a1a7d19efe3dc27022d1d7ffd7e0",
    "zh:5e379ae01d86d9ad4db256549d9f0b0752f4fb8b9c5bdd9c1fb499d82bb57aa3",
    "zh:626296b4fa6674d9daab2e274b61f8c3c11e89d315480ec750b06d9addee5d4e",
    "zh:63fbfe3eff24bdb5bb7cb1a690f5baea54945d3bb2b221d4f01f36faa92ad6ef",
    "zh:849b5edbdf4a36ab63e175c4b99866cb691e03c4a6a0749cc8781ccf6d8090e2",
    "zh:a506d18d692575523103c59b9d2ab5b2373580e998ca28bd9665b98e2709126c",
    "zh:a5d1e2126e9ed60cb5968ac7ceba3d423a817eecbefc13d5f144557987ff8cf9",
    "zh:c7618ea66e01138a4e197fc3342f8948e73513b8eb90ad6c2c5e745f40b442b8",
    "zh:e281ce8b034a925f10f7beb2dbc59795a03cf06527be2bba4b432b7a8cd1c8b9",
    "zh:ecb7908d82879a1914f4cbdd54787ba1c3e08f43de8d503b77e2245cb5570294",
  ]
}

provider "registry.opentofu.org/hashicorp/google" {
  version     = "5.29.1"
  constraints = ">= 3.43.0, >= 4.28.0, >= 5.22.0, < 6.0.0"
  hashes = [
    "h1:cE0Za4m1Z81YMEsVS0gKgWJhgT5JMPD48N2qP5HFvwM=",
    "zh:45219cda8a97fa7a3fd065a2b26b6d908bb7716cfc8b367a9b61643a013f8e69",
    "zh:604d5db7e3c1c59e0dcca3bc3e572e802372b259557dff464b184349f4968682",
    "zh:63b23346e6683cbb64699a9ab368747b277924e3df90ecdd8ae9b2ad97e0473f",
    "zh:66658f6bea6e59b8de94c3e538f545d1c3d34b4431c49f36f7681f116835a0cb",
    "zh:695e8f494aa30cb575bd7bac82c8f80820d30c87ced5b196bd61fe5a18a72cff",
    "zh:6a28e3cddb716550e993e1099262da2e2d97564e226728d83e2751427c4933b4",
    "zh:80db18492da9011f80892f2a849a8c9e6b8fdd45d31b33fedcb05133687574b6",
    "zh:a9533e03ca52cfb5d2d02ba3dbaccb895eb614a0b2b0a402ede71c2d0314aa1a",
    "zh:aab0d899a744060d6f2471677705ec99e1fb82e59937fde53b71edf4812b581d",
    "zh:b12d3fe718ea76bb31b9a3cec804263f572f22ce04ede22bd45aadcca3c862d9",
  ]
}

provider "registry.opentofu.org/hashicorp/google-beta" {
  version     = "5.29.1"
  constraints = ">= 3.43.0, >= 4.11.0, >= 5.22.0, < 6.0.0"
  hashes = [
    "h1:a8koQICTEWyXVnWtu4584nLsU8T1k4YUUbAiuGaQa2I=",
    "zh:0ecd137e1727b9357fea3ca76d1067ba17202b2ec2182b1f93d3ee8bf5f1b0e4",
    "zh:314262f99e1b178770c62f69e7c72251e7a551be4355ba5bac3bb24797cc17f2",
    "zh:5cd24a8daaa61e30f0948e648818b7d91d4c15e80225e836707b88936006fb47",
    "zh:6248713ff0213f6d87018dc6df0a2c45b84e771f3e8fcf1674da1b7b5df4f4c3",
    "zh:638a51bcc3f547f2eefd9c75c091c6f3b8655dd2cc414b2fe3ea95a81fcf2441",
    "zh:71f2e4937950ae0530e243b9bf80fd14b07d787b8d3ff2fd14a3a260442de297",
    "zh:96437e57bee70feae9c8b5ae2c2de8398701d89235a77ef688858686ef6251ab",
    "zh:a5d462dff36ab356790edd4b9be066cde875759a4322835cb1843e8a9bb6acd9",
    "zh:b4087f80d853643fdf8e1bd1b52158fc447725ff1c6c991980c8bfeb084dff36",
    "zh:b7ac8b52e16d06f267f6c57dcfd5f16f8bf4d9713a3205d34e3120332681e4db",
  ]
}

provider "registry.opentofu.org/hashicorp/kubernetes" {
  version     = "2.30.0"
  constraints = "~> 2.10"
  hashes = [
    "h1:sJ687Kqu1Res2W9vjpsQGVeISYfPPUObTPzOMT0qNMU=",
    "zh:2657c7430efe9d1eccf6c591cfb89f10afd41e49f50267932d8151c5a85be693",
    "zh:39d01df692eaf774555879e214125dd8d18683cc1f02e68ab01af52f7f141233",
    "zh:45216d047634c5b0368bbe0ffbbb8e435bd5006e4556cc3c225748f719377d5f",
    "zh:4ac77fbd4ebc23bf0396979f1c979822ffacfc2186f341217b7441d7e23fd05f",
    "zh:81904ac6647ed92f010e970115d5146c4fd040538b4800cbef0e995922b11ade",
    "zh:a475199b687691c004a1cdd357a44607b312d191a9a77e0f413dc4d093f0b6bc",
    "zh:aded77afb95bdfd1026cf01e6ed327af5c4b6c26c75b93ca0c4abf6f93158216",
    "zh:d6b404ff010392610e347072d74fc5b8f3a434baca993c8e6cb39ea092b20715",
    "zh:dc063ef5e64f7226302a5335a62ab44c7bb0271ae32b2135db8624b10a304605",
    "zh:e274904e3a512157bda5f3936dcc87b23663a229a368d6a62e06d439b465e594",
  ]
}

provider "registry.opentofu.org/hashicorp/null" {
  version     = "3.2.2"
  constraints = ">= 2.1.0"
  hashes = [
    "h1:P8+KlqxeTE3fNqzngzTxfwXFJaGl2Csw7lYJtFff508=",
    "zh:00e5877d19fb1c1d8c4b3536334a46a5c86f57146fd115c7b7b4b5d2bf2de86d",
    "zh:1755c2999e73e4d73f9de670c145c9a0dc5a373802799dff06a0e9c161354163",
    "zh:2b29d706353bc9c4edda6a2946af3322abe94372ffb421d81fa176f1e57e33be",
    "zh:34f65259c6d2bd51582b6da536e782b181b23725782b181193b965f519fbbacd",
    "zh:370f6eb744475926a1fa7464d82d46ad83c2e1148b4b21681b4cec4d75b97969",
    "zh:5950bdb23b4fcc6431562d7eba3dea37844aa4220c4da2eb898ae3e4d1b64ec4",
    "zh:8f3d5c8d4b9d497fec36953a227f80c76d37fc8431b683a23fb1c42b9cccbf8a",
    "zh:8f6eb5e65c047bf490ad3891efecefc488503b65898d4ee106f474697ba257d7",
    "zh:a7040eed688316fe00379574c72bb8c47dbe2638b038bb705647cbf224de8f72",
    "zh:e561f28df04d9e51b75f33004b7767a53c45ad96e3375d86181ba1363bffbc77",
  ]
}

provider "registry.opentofu.org/hashicorp/random" {
  version     = "3.6.1"
  constraints = ">= 2.2.0"
  hashes = [
    "h1:HLVcY4VsIZMjaHqeIGq1vpXeug1AKH4BYF3IPqYqJqA=",
    "zh:1208af24d1f66e858740812dd5da12e8951b1ca75cc6edb1975ba22bfdeefb1b",
    "zh:19137e9b4d3c15e1d99d2352888b98ec0e69bd5b2e89049150379d7bbd115063",
    "zh:26613834a1a8ac60390c7a4cbd4cb794b01dfe237d2b0c10f132f3e434a21e03",
    "zh:2cbe4425918f3f401609d89e6381f7d120493d637a3d103d827f0c0fd00b1600",
    "zh:44ef27a972540435efa88f323280f96d6ac77934079225e7fcc3560cc28aae59",
    "zh:8c5d4ca7d1ce007f7c055807cde77aad4685eb807ff802c93ffbec8589068f17",
    "zh:9a4fa908d6af48805c862cd4f3a1031d552b96d863a94263e390ac92915d74a9",
    "zh:ba396849f0f6d488784f6039095634e1c84e67e31375f3d17218fcf8ce952cb8",
    "zh:cb695db8798957bd64ce411f061307e39cb2baa69668b4d42ccf010db47d2e39",
    "zh:d02704bf99a93dc0b1ca00bd6051df9c431fbe17cd662a1ab58db1b96264a26f",
  ]
}

provider "registry.opentofu.org/hashicorp/time" {
  version     = "0.11.1"
  constraints = ">= 0.5.0"
  hashes = [
    "h1:jZpXeN0nw4uNakKnWdyB3JgQ1VmkL2hmhnhP8VFAzBQ=",
    "zh:048c56f9f810f67a7460363a26bf3ef939d64f0d7b7342b9e7f24cc85ee1491b",
    "zh:49f949cc5cb50fbb65f7b4578b79fbe02b6bafe9e3f5f1c2936114dd445b84b3",
    "zh:553174a4fa88f6e186800d7ee155a6b5b4c6c81793643f1a20eab26becc7f823",
    "zh:5cae304e21f77091d4b50389c655afd5e4e2e8d4cd9c06de139a31b8e7d343a9",
    "zh:7aae20832bd9885f034831aa44db3a6ffcec034a2d5a2815d92c42c40c14ca1d",
    "zh:93d715610dce777474b5eff1d7dbe797e72ca0b679cd8636efb3aa45d1cb589e",
    "zh:bd29e04645775851eb10e7f3b39104ae57ca3632dec4ae07328d33d4182e7fb5",
    "zh:d6ad6a4d52a6989b8452466f2ec3dbcdb00cc44a96bd1ca618d91a5d74895f49",
    "zh:e68cfad3ec526631410fa9406938d624fd56b9ab065c76525cb3f731d106fbfe",
    "zh:ffee8aa6b7ce56f4b8fdc0c492404be0041137a278388eb1d1180b637fb5b3de",
  ]
}
