#!/usr/bin/env node
//
// sudre.js - Solve a sudoku in two PCRE substitutions
//
// Written in 2017 by Aron Griffis <aron@n01se.net>
// and released into the public domain.

"use strict";

const fs = require('fs');

const regex = fs.readFileSync('regex.txt', 'utf8')
                .replace(/\n/g, '')
                .replace('\\A', '^')
                .replace('\\Z', '$');

process.stdin.setEncoding('utf-8');

var puz = '';

process.stdin.on('data', chunk => puz += chunk);
process.stdin.on('end', () => {
    process.stdout.write(`INPUT:\n${puz}\n`);

    const input = puz.replace(/\d/g, d => (
        d === '0' ? '123456789' : `${d}        `
    ));

    const output = input.replace(
        new RegExp(regex),
        '$1 $2 $3 $4 $5 $6 $7 $8 $9\n' +
        '$10 $11 $12 $13 $14 $15 $16 $17 $18\n' +
        '$19 $20 $21 $22 $23 $24 $25 $26 $27\n' +
        '$28 $29 $30 $31 $32 $33 $34 $35 $36\n' +
        '$37 $38 $39 $40 $41 $42 $43 $44 $45\n' +
        '$46 $47 $48 $49 $50 $51 $52 $53 $54\n' +
        '$55 $56 $57 $58 $59 $60 $61 $62 $63\n' +
        '$64 $65 $66 $67 $68 $69 $70 $71 $72\n' +
        '$73 $74 $75 $76 $77 $78 $79 $80 $81\n'
    );

    process.stdout.write(`OUTPUT:\n${output}`);
});
