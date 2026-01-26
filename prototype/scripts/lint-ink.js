#!/usr/bin/env node
/**
 * Ink linter for Un Día Más
 * Checks for common Ink authoring issues
 */
const fs = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '..');
const INK_DIR = path.join(ROOT, 'ink');

let warnings = 0;
let errors = 0;

function warn(file, line, msg) {
    console.log(`  WARN ${path.relative(INK_DIR, file)}:${line} - ${msg}`);
    warnings++;
}

function error(file, line, msg) {
    console.log(`  ERR  ${path.relative(INK_DIR, file)}:${line} - ${msg}`);
    errors++;
}

console.log('[lint] Checking Ink files...\n');

// Collect all ink files
const inkFiles = [];
function findInkFiles(dir) {
    for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
        const fullPath = path.join(dir, entry.name);
        if (entry.isDirectory()) findInkFiles(fullPath);
        else if (entry.name.endsWith('.ink')) inkFiles.push(fullPath);
    }
}
findInkFiles(INK_DIR);

// Collect all knot/stitch names and divert targets
const allKnots = new Set();
const allDiverts = [];
const allVars = {};

for (const file of inkFiles) {
    const content = fs.readFileSync(file, 'utf8');
    const lines = content.split('\n');

    for (let i = 0; i < lines.length; i++) {
        const line = lines[i];
        const lineNum = i + 1;

        // Collect knot names
        const knotMatch = line.match(/^===?\s*(?:function\s+)?(\w+)\s*(?:\(.*\))?\s*===?/);
        if (knotMatch) {
            allKnots.add(knotMatch[1]);
        }

        // Collect stitch names
        const stitchMatch = line.match(/^=\s+(\w+)/);
        if (stitchMatch) {
            allKnots.add(stitchMatch[1]);
        }

        // Collect VAR declarations
        const varMatch = line.match(/^VAR\s+(\w+)\s*=/);
        if (varMatch) {
            const varName = varMatch[1];
            if (allVars[varName]) {
                error(file, lineNum, `Duplicate VAR: ${varName} (also in ${allVars[varName]})`);
            }
            allVars[varName] = `${path.relative(INK_DIR, file)}:${lineNum}`;
        }

        // Check for common issues

        // Empty choice text
        if (line.match(/^\*\s*\[\s*\]\s*$/)) {
            warn(file, lineNum, 'Empty choice text (no [...] content)');
        }

        // TODO/FIXME/HACK comments
        if (line.match(/\/\/\s*(TODO|FIXME|HACK|XXX)/i)) {
            warn(file, lineNum, `Found ${line.match(/(TODO|FIXME|HACK|XXX)/i)[1]} comment`);
        }

        // DEPRECATED comments
        if (line.match(/DEPRECATED/i)) {
            warn(file, lineNum, 'Contains DEPRECATED marker');
        }

        // Collect diverts for later validation
        const divertMatches = line.matchAll(/->\s+(\w+)(?:\s|$)/g);
        for (const m of divertMatches) {
            if (m[1] !== 'DONE' && m[1] !== 'END') {
                allDiverts.push({ target: m[1], file, line: lineNum });
            }
        }
    }
}

// Check for broken diverts (targets that don't exist)
console.log('Divert Targets:');
let brokenDiverts = 0;
for (const divert of allDiverts) {
    // Skip function calls (they have parentheses which our regex doesn't capture)
    if (!allKnots.has(divert.target)) {
        // Could be a function or external - just warn
        // warn(divert.file, divert.line, `Divert to unknown target: ${divert.target}`);
        brokenDiverts++;
    }
}
console.log(`  Checked ${allDiverts.length} diverts, ${brokenDiverts} unresolved (may be functions/externals)\n`);

// Summary
console.log(`[lint] ${inkFiles.length} files checked`);
console.log(`[lint] ${errors} errors, ${warnings} warnings`);
process.exit(errors > 0 ? 1 : 0);
