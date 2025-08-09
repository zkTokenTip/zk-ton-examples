# zk-ton-example

This repository is currently under development and testing.
It demonstrates how to integrate zero-knowledge proofs from Circom into the TON blockchain using smart contracts written in **FunC**, **Tolk** and **Tact**.

## Project structure

- `contracts` - source code of all the smart contracts of the project and their dependencies.
- `wrappers` - wrapper classes (implementing `Contract` from ton-core) for the contracts, including any [de]serialization primitives and compilation functions.
- `tests` - tests for the contracts.
- `scripts` - scripts used by the project, mainly the deployment scripts.
- `circuits` - zero-knowledge proof circuits (e.g., written in Circom) along with their build artifacts such as `.r1cs`, `.zkey`, and verification key files.

## How to create

```sh
npm create ton@latest

npm install snarkjs @types/snarkjs
npm install export-ton-verifier@latest
```

## How to use

```sh
cd circuits
mkdir Multiplier

# compile circuit
circom Multiplier.circom --r1cs ./Multiplier/Multiplier.r1cs --wasm ./Multiplier/Multiplier.wasm --prime bls12381 --sym ./Multiplier/Multiplier.sym
cd Multiplier

# trusted setup
snarkjs powersoftau new bls12-381 14 pot14_0000.ptau -v
snarkjs powersoftau contribute pot14_0000.ptau pot14_0001.ptau --name="First contribution" -v -e="some random text"
snarkjs powersoftau prepare phase2 pot14_0001.ptau pot14_final.ptau -v
snarkjs groth16 setup Multiplier.r1cs pot14_final.ptau Multiplier_0000.zkey
snarkjs zkey contribute Multiplier_0000.zkey Multiplier_0001.zkey --name="1st Contributor Name" -v -e="some random text"
snarkjs zkey export verificationkey Multiplier_0001.zkey verification_key.json

cd ../..

# export func contract
npx export-ton-verifier ./circuits/Multiplier/Multiplier_0001.zkey ./contracts/verifier.fc
# export tolk contract
npx export-ton-verifier ./circuits/Multiplier/Multiplier_0001.zkey ./contracts/verifier.tolk --tolk
# export tact contract
npx export-ton-verifier ./circuits/Multiplier/Multiplier_0001.zkey ./contracts/verifier.tact --tact
```
