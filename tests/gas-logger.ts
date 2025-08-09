// Original source:
// https://github.com/ton-blockchain/tolk-bench/blob/master/tests/gas-logger.ts
// License: MIT

import { Cell, Transaction } from '@ton/core';
import * as fs from 'node:fs';
import * as path from 'node:path';

const ROOT_DIR = path.resolve(__dirname, '..', 'bench-snapshots');

function calculateCellsAndBits(root: Cell, visited = new Set<string>()) {
    const hash = root.hash().toString('hex');
    if (visited.has(hash)) {
        return { nBits: 0, nCells: 0 };
    }
    visited.add(hash);

    let nBits = root.bits.length;
    let nCells = 1;
    for (const ref of root.refs) {
        const childRes = calculateCellsAndBits(ref, visited);
        nBits += childRes.nBits;
        nCells += childRes.nCells;
    }
    return { nBits, nCells };
}

export class GasLogAndSave {
    private readonly numericFolder: string;

    private gasLogs: { [name: string]: number } = {};
    private codeSize: { [key: string]: number } = {};

    constructor(numericFolder: string) {
        this.numericFolder = numericFolder;
    }

    private ensureDirExists() {
        fs.mkdirSync(ROOT_DIR, { recursive: true });
    }

    private extractGasFromTransaction(t: Transaction) {
        if (t.description.type === 'generic' && t.description.computePhase.type === 'vm') {
            return Number(t.description.computePhase.gasUsed);
        }
        return 0;
    }

    rememberGas(stepName: string, transaction: Transaction | Transaction[]) {
        let gasUsed = 0;
        if (Array.isArray(transaction)) {
            transaction.forEach((tx) => {
                gasUsed += this.extractGasFromTransaction(tx);
            });
        } else {
            gasUsed = this.extractGasFromTransaction(transaction);
        }
        this.gasLogs[stepName] = gasUsed;
    }

    rememberBocSize(contractName: string, code: Cell) {
        const { nBits, nCells } = calculateCellsAndBits(code);
        this.codeSize[`${contractName} bits`] = nBits;
        this.codeSize[`${contractName} cells`] = nCells;
    }

    saveCurrentRunAfterAll() {
        this.ensureDirExists();
        const fileName = path.join(ROOT_DIR, `${this.numericFolder}.last.json`);

        const obj = {
            gas: this.gasLogs,
            codeSize: this.codeSize,
        };
        fs.writeFileSync(fileName, JSON.stringify(obj, null, 2), 'utf8');
    }
}
