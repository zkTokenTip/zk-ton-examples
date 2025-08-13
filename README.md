# zk-ton-example

This repository is currently under development and testing.
It demonstrates how to integrate zero-knowledge proofs from Circom into the TON blockchain using smart contracts written in **FunC**, **Tolk** and **Tact**.

Gas cost tests have been performed, and the results are located in the `bench-snapshots` directory.

## Project structure

- `contracts` - source code of all the smart contracts of the project and their dependencies.
- `wrappers` - wrapper classes (implementing `Contract` from ton-core) for the contracts, including any [de]serialization primitives and compilation functions.
- `tests` - tests for the contracts.
- `scripts` - scripts used by the project, mainly the deployment scripts.
- `circuits` - zero-knowledge proof circuits (e.g., written in Circom or Noname) along with their build artifacts such as `.r1cs`, `.zkey`, and verification key files.

## How to create

```sh
npm create ton@latest

npm install snarkjs @types/snarkjs
npm install export-ton-verifier@latest
```

## How to use

### Multiplier (circom) 

```sh
mkdir circuits/Multiplier
cd circuits/Multiplier

# compile circuit
circom Multiplier.circom --r1cs --wasm --sym --prime bls12381

# trusted setup
snarkjs powersoftau new bls12-381 10 pot10_0000.ptau -v
snarkjs powersoftau contribute pot10_0000.ptau pot10_0001.ptau --name="First contribution" -v -e="some random text"
snarkjs powersoftau prepare phase2 pot10_0001.ptau pot10_final.ptau -v
snarkjs groth16 setup Multiplier.r1cs pot10_final.ptau Multiplier_0000.zkey
snarkjs zkey contribute Multiplier_0000.zkey Multiplier_final.zkey --name="1st Contributor Name" -v -e="some random text"
snarkjs zkey export verificationkey Multiplier_final.zkey verification_key.json

cd ../..

# export FunC contract
npx export-ton-verifier ./circuits/Multiplier/Multiplier_final.zkey ./contracts/verifier_multiplier.fc
# export Tolk contract
npx export-ton-verifier ./circuits/Multiplier/Multiplier_final.zkey ./contracts/verifier_multiplier.tolk --tolk
# export Tact contract
npx export-ton-verifier ./circuits/Multiplier/Multiplier_final.zkey ./contracts/verifier_multiplier.tact --tact

# Only copy the TypeScript wrapper
npx export-ton-verifier import-wrapper ./wrappers/Verifier.ts --force
```

### Sudoku (noname)

- [Article about integration with SnarkJS](https://blog.zksecurity.xyz/posts/noname-r1cs/)

```sh

noname check

noname run --backend r1cs-bls12-381 --private-inputs '{"solution": { "inner": ["9", "5", "3", "6", "2", "1", "7", "8", "4", "1", "4", "8", "7", "5", "9", "2", "6", "3", "2", "7", "6", "8", "3", "4", "9", "5", "1", "3", "6", "9", "2", "7", "5", "4", "1", "8", "4", "8", "5", "9", "1", "6", "3", "7", "2", "7", "1", "2", "3", "4", "8", "6", "9", "5", "6", "3", "7", "1", "8", "2", "5", "4", "9", "5", "2", "1", "4", "9", "7", "8", "3", "6", "8", "9", "4", "5", "6", "3", "1", "2", "7"] }}' --public-inputs '{"grid": { "inner": ["0", "5", "3", "6", "2", "1", "7", "8", "4", "0", "4", "8", "7", "5", "9", "2", "6", "3", "2", "7", "6", "8", "3", "4", "9", "5", "1", "3", "6", "9", "2", "7", "0", "4", "1", "8", "4", "8", "5", "9", "1", "6", "3", "7", "2", "0", "1", "2", "3", "4", "8", "6", "9", "5", "6", "3", "0", "1", "8", "2", "5", "4", "9", "5", "2", "1", "4", "9", "0", "8", "3", "6", "8", "9", "4", "5", "6", "3", "1", "2", "7"] }}'

snarkjs powersoftau new bls12-381 14 pot14_0000.ptau -v
snarkjs powersoftau contribute pot14_0000.ptau pot14_0001.ptau --name="First contribution" -v -e="some random text"
snarkjs powersoftau prepare phase2 pot14_0001.ptau pot14_final.ptau -v
snarkjs groth16 setup Sudoku.r1cs pot14_final.ptau Sudoku_0000.zkey
snarkjs zkey contribute Sudoku_0000.zkey Sudoku_final.zkey --name="1st Contributor Name" -v -e="some random text"
snarkjs zkey export verificationkey Sudoku_final.zkey verification_key.json

#Generating a Proof
snarkjs groth16 prove Sudoku_final.zkey Sudoku.wtns proof.json public.json
#Verifying a Proof
snarkjs groth16 verify verification_key.json public.json proof.json

# export FunC contract
npx export-ton-verifier ./circuits/Sudoku/Sudoku_final.zkey ./contracts/verifier_sudoku.fc
# export Tact contract
npx export-ton-verifier ./circuits/Sudoku/Sudoku_final.zkey ./contracts/verifier_sudoku.tact --tact
```

### zkToken (circom)

```sh
cd .\circuits\zkTokenRegistration\

# compile circuit
circom registration.circom --r1cs --wasm --sym --prime bls12381

snarkjs powersoftau new bls12-381 10 pot10_0000.ptau -v
snarkjs powersoftau contribute pot10_0000.ptau pot10_0001.ptau --name="First contribution" -v -e="some random text"
snarkjs powersoftau prepare phase2 pot10_0001.ptau pot10_final.ptau -v
snarkjs groth16 setup registration.r1cs pot10_final.ptau registration_0000.zkey
snarkjs zkey contribute registration_0000.zkey registration_final.zkey --name="1st Contributor Name" -v -e="some random text"
snarkjs zkey export verificationkey registration_final.zkey verification_key.json


# export FunC contract
npx export-ton-verifier ./circuits/zkTokenRegistration/registration_final.zkey ./contracts/verifier_reg.fc
# export Tolk contract
npx export-ton-verifier ./circuits/zkTokenRegistration/registration_final.zkey ./contracts/verifier_reg.tolk --tolk
# export Tact contract
npx export-ton-verifier ./circuits/zkTokenRegistration/registration_final.zkey ./contracts/verifier_reg.tact --tact
```

## Known issues

```sh
# export Tolk contract 
$ npx export-ton-verifier ./circuits/Sudoku/Sudoku_final.zkey ./contracts/verifier_sudoku.tolk --tolk
$ npx blueprint build Verifier_tolk_sudoku

Build script running, compiling Verifier_tolk_sudoku
🔧 Using tolk version 1.0.0...
RangeError: Maximum call stack size exceeded
```