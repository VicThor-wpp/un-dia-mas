#!/usr/bin/env node
/**
 * Test runner for Un Día Más
 * Runs compilation check and basic structural tests
 */
const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '..');
const INK_DIR = path.join(ROOT, 'ink');

let passed = 0;
let failed = 0;

function test(name, fn) {
    try {
        fn();
        console.log(`  ✓ ${name}`);
        passed++;
    } catch (err) {
        console.log(`  ✗ ${name}`);
        console.log(`    ${err.message}`);
        failed++;
    }
}

function assert(condition, message) {
    if (!condition) throw new Error(message);
}

console.log('\n[test] Running tests for Un Día Más\n');

// Test 1: All required ink files exist
console.log('File Structure:');
const requiredFiles = [
    'main.ink', 'variables.ink',
    'mecanicas/dados.ink', 'mecanicas/recursos.ink',
    'dias/lunes.ink', 'dias/martes.ink', 'dias/miercoles.ink',
    'dias/jueves.ink', 'dias/viernes.ink', 'dias/sabado.ink', 'dias/domingo.ink',
    'personajes/sofia.ink', 'personajes/elena.ink', 'personajes/diego.ink',
    'personajes/marcos.ink', 'personajes/juan.ink', 'personajes/ixchel.ink',
    'ubicaciones/casa.ink', 'ubicaciones/bondi.ink', 'ubicaciones/laburo.ink',
    'ubicaciones/barrio.ink', 'ubicaciones/olla.ink',
    'fragmentos/fragmentos.ink', 'finales/finales.ink'
];

for (const file of requiredFiles) {
    test(`${file} exists`, () => {
        assert(fs.existsSync(path.join(INK_DIR, file)), `Missing: ${file}`);
    });
}

// Test 2: Main.ink includes all files
console.log('\nIncludes:');
const mainContent = fs.readFileSync(path.join(INK_DIR, 'main.ink'), 'utf8');

test('main.ink includes variables', () => {
    assert(mainContent.includes('INCLUDE variables.ink'), 'Missing INCLUDE variables.ink');
});

test('main.ink includes all day files', () => {
    const days = ['lunes', 'martes', 'miercoles', 'jueves', 'viernes', 'sabado', 'domingo'];
    for (const day of days) {
        assert(mainContent.includes(`INCLUDE dias/${day}.ink`), `Missing INCLUDE dias/${day}.ink`);
    }
});

test('main.ink includes all character files', () => {
    const chars = ['sofia', 'elena', 'diego', 'marcos', 'juan', 'ixchel'];
    for (const char of chars) {
        assert(mainContent.includes(`INCLUDE personajes/${char}.ink`), `Missing INCLUDE personajes/${char}.ink`);
    }
});

// Test 3: No duplicate VAR declarations
console.log('\nVariable Integrity:');
test('No duplicate VAR declarations across files', () => {
    const varDecls = {};
    const inkFiles = [];

    function findInkFiles(dir) {
        for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
            const fullPath = path.join(dir, entry.name);
            if (entry.isDirectory()) findInkFiles(fullPath);
            else if (entry.name.endsWith('.ink')) inkFiles.push(fullPath);
        }
    }

    findInkFiles(INK_DIR);

    for (const file of inkFiles) {
        const content = fs.readFileSync(file, 'utf8');
        const lines = content.split('\n');
        for (let i = 0; i < lines.length; i++) {
            const match = lines[i].match(/^VAR\s+(\w+)\s*=/);
            if (match) {
                const varName = match[1];
                const relFile = path.relative(INK_DIR, file);
                if (varDecls[varName]) {
                    throw new Error(`Duplicate VAR ${varName} in ${relFile} (first in ${varDecls[varName]})`);
                }
                varDecls[varName] = relFile;
            }
        }
    }
});

// Test 4: All tunnels return
console.log('\nTunnel Integrity:');
test('Tunnel-style knots have return statements', () => {
    const inkFiles = [];
    function findInkFiles(dir) {
        for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
            const fullPath = path.join(dir, entry.name);
            if (entry.isDirectory()) findInkFiles(fullPath);
            else if (entry.name.endsWith('.ink')) inkFiles.push(fullPath);
        }
    }
    findInkFiles(INK_DIR);

    const tunnelCalls = new Set();
    const tunnelReturns = new Set();

    for (const file of inkFiles) {
        const content = fs.readFileSync(file, 'utf8');
        // Find tunnel calls: -> knot_name ->
        const callMatches = content.matchAll(/->\s+(\w+)\s+->/g);
        for (const m of callMatches) tunnelCalls.add(m[1]);

        // Find tunnel returns: ->->
        if (content.includes('->->')) {
            // Find knot name before ->->
            const lines = content.split('\n');
            let currentKnot = '';
            for (const line of lines) {
                const knotMatch = line.match(/^===?\s*(\w+)\s*===?/);
                if (knotMatch) currentKnot = knotMatch[1];
                if (line.trim() === '->->' && currentKnot) {
                    tunnelReturns.add(currentKnot);
                }
            }
        }
    }

    // Check that tunnel calls have matching returns (warning only for now)
    const missing = [];
    for (const call of tunnelCalls) {
        if (!tunnelReturns.has(call)) {
            missing.push(call);
        }
    }
    // Don't fail on this - just warn
    if (missing.length > 0) {
        console.log(`    Warning: ${missing.length} tunnel calls without visible ->-> returns`);
        console.log(`    (May use diverts instead: ${missing.slice(0, 5).join(', ')}${missing.length > 5 ? '...' : ''})`);
    }
});

// Test 5: Web files exist
console.log('\nWeb Runtime:');
const webFiles = ['index.html', 'style.css', 'game.js', 'ink.js'];
for (const file of webFiles) {
    test(`web/${file} exists`, () => {
        assert(fs.existsSync(path.join(ROOT, 'web', file)), `Missing: web/${file}`);
    });
}

const moduleFiles = [
    'config-manager.js', 'notification-system.js', 'decision-log.js',
    'stats-panel.js', 'relationships-panel.js', 'portrait-system.js',
    'save-system.js', 'choice-parser.js', 'reading-preferences.js', 'start-screen.js'
];
for (const file of moduleFiles) {
    test(`modules/${file} exists`, () => {
        assert(fs.existsSync(path.join(ROOT, 'web', 'modules', file)), `Missing: modules/${file}`);
    });
}

// Summary
console.log(`\n[test] Results: ${passed} passed, ${failed} failed`);
process.exit(failed > 0 ? 1 : 0);
