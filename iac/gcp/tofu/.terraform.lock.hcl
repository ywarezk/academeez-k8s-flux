# This file is maintained automatically by "tofu init".
# Manual edits may be lost in future updates.

provider "registry.opentofu.org/fluxcd/flux" {
  version     = "1.4.0"
  constraints = "~> 1.4"
  hashes = [
    "h1:Kob2mpoVc5Ni10aTNY+NkFZV5JO/lERZIPP0EfAU9pk=",
    "zh:03f84a2b61760160a91abd369e2f641992bdb81a13aa1f1dd3e370f43c7b8e90",
    "zh:0a4d44f6e93f28124d1a8138a19e54d5dcc527de3e700946481b9af9ce61e843",
    "zh:193af19c01abc6aa1ef01ad016e5717c4275ed529fbaa3ce1f6a922ba24f17f1",
    "zh:1c4be3504c359f35b9ee60451cf6a9bc225df66920f555caca45d2b62f79c459",
    "zh:32ea8a44fdd065cd9dbbdafd5eba348729a7791ee2f47bdb280734a8a1762231",
    "zh:42dcf34cb072ece2370bb438020d7b098d9f0f4f22f7420c058c87cb1b67c02b",
    "zh:48625dc5df70b78a638e0df395d64fce35f1befcdd632449a40f963f4b11c68f",
    "zh:534fb73b113c9b5fc9f1714c3c0cdf2f9a0c46fa312b5ee75d9a3197efaf3800",
    "zh:8f47b4dd487a2f68ce56833f175777d02035e91bee6fa75f9eee25b6c90d9e56",
    "zh:b6a67c1643ecee042ffdae2975e5d2b19edf781d30110f6d373713f7e604959e",
    "zh:bc808070a11ff32c0323b92c61356685dc5ce9d0f27367aa864c5ba26ad4e512",
    "zh:ce3b32cc8ef094c19cd34f64985f5ea72c24a77ee20fa844e516b8ab0f3b2062",
    "zh:da1e4ef7ac3e0fbccd4f12dfe50a34e69a2e6d46d4f82bf1a9c3897936332630",
    "zh:f343d6ebb06e1ebdb04d8cb5ad1271134664f6be6f092ec8ca2b9d1502a0f69c",
  ]
}

provider "registry.opentofu.org/hashicorp/google" {
  version     = "6.8.0"
  constraints = "~> 6.8"
  hashes = [
    "h1:iNrCvileo2XwA4RJoIFbXCCwLt4BPefbwATjQkINMvw=",
    "zh:06a80f46f4f49d30c7cdb07f5d0715b8398497f1d86acda43b32817cb99c0cfd",
    "zh:073b406305aa675e8b367224485270ed1f18de86cc7afdaa202bbd8562dc32a7",
    "zh:11c2e9f0de6eda72a4ba646a25cceeb489cfe7a39c26f48ff20421b3289b8fa7",
    "zh:39d0db53e543d50eb267c56a6461039db4b08d0c99fbe5cd5b9beb3d0efe296e",
    "zh:4bbbbaf241eb91fc7ba575c6b85706299c7a42b700dc74fd12dfa9f93d3c0102",
    "zh:582332cf741c265f5e72cb35984598b7130aaf5580b243b5529fda30bdf12129",
    "zh:881dc8c132273991941b018f8012a977b4a7ebb32f0fb99c7b5f5757dfb96b06",
    "zh:96d2258f074b237ef735023be038f818f3ea975f4175e7598ac2b477d12df8f8",
    "zh:b3cc4e99128a97ad640c12e7dc39299b52c4205f0201e53f9a674c0dfb623d49",
    "zh:eaf2fc5acc3cba9c756da51295ad0e45d1f024f84490b920d989357c52c98562",
  ]
}

provider "registry.opentofu.org/hashicorp/google-beta" {
  version     = "6.8.0"
  constraints = ">= 3.43.0, >= 4.11.0, >= 5.41.0, < 7.0.0"
  hashes = [
    "h1:7kWD+eB/NHj/Upmj2ht0hueX1luenH+JnadkkNbsIvM=",
    "zh:14de9bfa6333a3801d8629597a72f0c36c3d4415651e8efaacf235604aa45304",
    "zh:16014cb3cb226b45d1f5b8a1acbb3de525241603fddcfa317da95ac3cc673bc8",
    "zh:4256153107e9bf37c4953e2f8e49726ce4fe8a9d47af77f32844bdf5b5fe4fce",
    "zh:5ee3d5ddab41e9b43dd998e1d82956512364a77ff6cb47d0a245f57b3ca9aa8a",
    "zh:996edfe37def4c8ac4774b22e60ce4d54b62554603ee1ff91c838ba2f16ef11a",
    "zh:9fdaf16da36c166d0d077a315a8311a0fcd210fc00f8c856b4d4b185cde96001",
    "zh:a2abe550082353f7e29a82d2d46c99bbf9fc0fc25349f7b975922eeef97fd237",
    "zh:cac158a671b7f4025ac879f21ae5d7ecac0ffec2133f7b6f3c800d96405092ec",
    "zh:cd2d0b54865388b74333e07e755c81293600f2b41a5c64be4be3ad117a2702ca",
    "zh:dbdc73825d67e446707e3532f823af48f36967589f7522e9e5a4bff617d3364b",
  ]
}

provider "registry.opentofu.org/hashicorp/kubernetes" {
  version     = "2.33.0"
  constraints = "~> 2.10"
  hashes = [
    "h1:8RUoM8nH/mgoqZ1rz6QKcUdiNMz/zZ7Hx3kaVn5uv/g=",
    "zh:00aed83f28880460431f70e5a057c9324d1228b3f76e6554199700632ca62361",
    "zh:4aac46187fd23bdabd801290070fa718609a2064ed5c876c4ab61fdf6e46ea04",
    "zh:676dd70c2ff3df25a962bae4b11a2896d4313b0fd39132ec78ae3418bb1b2ef5",
    "zh:6a01808157d2c9b415b49ea1d294cd19262a89b3b02e0de8d1db6cdc393dffa9",
    "zh:941a0ef4b851ad37cff9ef9d38849529b5fb0c6b3ad149a6c2457d50b7964adf",
    "zh:9a7b0ec7d84a481d9c7544056e0639d240e1373a1d61d4aebce049cc9673a6a6",
    "zh:a6c68f47f72089f426b9a9040cc8a9fcb98d362b5b35d26028781f9fec3f0293",
    "zh:a6ccb8f33dd52ceaca754cb51aea667fc9a8e3bfd5a192002005b7cfece65ee5",
    "zh:e63a6fb4a72a0634f2fb0c261d5dea0182f13b5f9f0cd1560344602cc7482b68",
    "zh:f0b79ba3c5f28b688b802ef0f052b6b4f99aa45a70e8d4efe21fd824f7a69c6c",
  ]
}

provider "registry.opentofu.org/hashicorp/null" {
  version     = "3.2.3"
  constraints = ">= 2.1.0"
  hashes = [
    "h1:nNa5j1vTtxcpdC2i61O2tRkZjdkBNsxzYXYIx0VNsjc=",
    "zh:1d57d25084effd3fdfd902eca00020b34b1fb020253b84d7dd471301606015ac",
    "zh:65b7f9799b88464d9c2ec529713b7f52ea744275b61a8dc86cdedab1b2dcb933",
    "zh:80d3e9c95b7b4ae7c54005cd127cae82e5c53d2b7023ef24c147337bac9dadd9",
    "zh:841b60c07683e4bf456799ccd718896fdafdcc2c49252ae09967f2e74d8c8a03",
    "zh:8fa1c592a9c78222e35713c6edb3f1f818a4c6f3524a30a209f0a7e919827b68",
    "zh:bb795cc1429e09466840c09d39a28edf1db5070b1ec76822fc1173906a264572",
    "zh:da1784818a89bea29dfe660632f0060a7a843e4e564d74435fbeca002b0f7d2a",
    "zh:f409bf21b1cdaa6dac47cd79806f3d93f67e9507fe4dbf33b0165335f53bc2e1",
    "zh:fbea7a1ff84b430ba9594698e93196d81d03e4036de3d1cafccb2a96d5b38581",
    "zh:fbf0c84663a7e85881388d7d71ac862184f05fbf2d17ecf76bc5d3d7503ea260",
  ]
}

provider "registry.opentofu.org/hashicorp/random" {
  version     = "3.6.3"
  constraints = ">= 2.2.0"
  hashes = [
    "h1:ohM08k4QVd81oVSJnFI53wJjPcH23XlYG4WslS9og2Q=",
    "zh:1bfd2e54b4eee8c761a40b6d99d45880b3a71abc18a9a7a5319204da9c8363b2",
    "zh:21a15ac74adb8ba499aab989a4248321b51946e5431219b56fc827e565776714",
    "zh:221acfac3f7a5bcd6cb49f79a1fca99da7679bde01017334bad1f951a12d85ba",
    "zh:3026fcdc0c1258e32ab519df878579160b1050b141d6f7883b39438244e08954",
    "zh:50d07a7066ea46873b289548000229556908c3be746059969ab0d694e053ee4c",
    "zh:54280cdac041f2c2986a585f62e102bc59ef412cad5f4ebf7387c2b3a357f6c0",
    "zh:632adf40f1f63b0c5707182853c10ae23124c00869ffff05f310aef2ed26fcf3",
    "zh:b8c2876cce9a38501d14880a47e59a5182ee98732ad7e576e9a9ce686a46d8f5",
    "zh:f27e6995e1e9fe3914a2654791fc8d67cdce44f17bf06e614ead7dfd2b13d3ae",
    "zh:f423f2b7e5c814799ad7580b5c8ae23359d8d342264902f821c357ff2b3c6d3d",
  ]
}

provider "registry.opentofu.org/hashicorp/time" {
  version     = "0.12.1"
  constraints = ">= 0.5.0"
  hashes = [
    "h1:BeB0tURFcd5MQIjLdqpZSFYAXpj3WBI8qstoCHW0WYA=",
    "zh:50a9b67d5f5f42adbdb7712f67858aa64b5670070f6710751239b535fb48a4df",
    "zh:5a846fae035e363aed75b966d64a56f3489a38083e8407aaa656730437f53ed7",
    "zh:6767f1fc8a679b48eaa4cd114da0d8185fb3546375f3a0fb3728f10fa3dbc551",
    "zh:85d3da407c828bf057cbc0e86c75ef3d0f9f74a73c4ea1b4aef18e33f41092b1",
    "zh:9180721325139431112c638f5382a740ff219782f81d6346cdff5bccc418a43f",
    "zh:9ba9989f905a64db1409a9a57649549c89c7aedfb55ae399a7fa9411aafaadac",
    "zh:b3d9e7afb6a742e9be0541bc434b00d849fdfab0b4b859ceb0296c26c541af15",
    "zh:c87da712d718acd9dd03f544b020c320699cb29df197be4f74783e3c3d80fc17",
    "zh:cb1abe07638ef6d7b41d0e86dfb12d60a513aca3395a5da7191947f7459821dd",
    "zh:ecff2e823ef49eda03663fa8ee8bdc17d27cd419dbdacbf1719f38812dbf417e",
  ]
}
