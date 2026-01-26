#!/usr/bin/env node
/**
 * Build script for Un Día Más
 * Compiles Ink source to JSON and wraps for web runtime
 */
const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '..');
const INK_ENTRY = path.join(ROOT, 'ink', 'main.ink');
const JSON_OUT = path.join(ROOT, 'web', 'un_dia_mas.json');
const JS_OUT = path.join(ROOT, 'web', 'un_dia_mas.js');

function findInklecate() {
    // Try local node_modules first
    const localBin = path.join(ROOT, 'node_modules', '.bin', 'inklecate');
    if (fs.existsSync(localBin) || fs.existsSync(localBin + '.cmd')) {
        return localBin;
    }
    // Try npx
    return 'npx inklecate';
}

function build() {
    const startTime = Date.now();
    console.log('[build] Compiling Ink...');
    console.log(`[build] Entry: ${INK_ENTRY}`);

    const inklecate = findInklecate();

    try {
        // Compile Ink to JSON
        const cmd = `"${inklecate}" -o "${JSON_OUT}" "${INK_ENTRY}"`;
        let output = '';
        let warnings = '';
        try {
            output = execSync(cmd, { encoding: 'utf8', cwd: ROOT, stdio: 'pipe', shell: true });
        } catch (execErr) {
            // inklecate exits non-zero on warnings — check if JSON was still produced
            warnings = (execErr.stderr || '').toString();
            output = (execErr.stdout || '').toString();
            const hasErrors = /^ERROR:/m.test(warnings) || /^ERROR:/m.test(output);
            if (hasErrors || !fs.existsSync(JSON_OUT)) {
                throw execErr;
            }
        }

        // Print warnings (non-fatal)
        const allOutput = (warnings + '\n' + output).trim();
        const warningLines = allOutput.split('\n').filter(l => /^WARNING:/.test(l.trim()));
        if (warningLines.length > 0) {
            console.log(`[build] ${warningLines.length} warnings (non-fatal)`);
        }

        // Verify JSON output
        if (!fs.existsSync(JSON_OUT)) {
            console.error('[build] ERROR: JSON output not created');
            process.exit(1);
        }

        let jsonContent = fs.readFileSync(JSON_OUT, 'utf8');
        // Strip UTF-8 BOM if present (inklecate on Windows)
        if (jsonContent.charCodeAt(0) === 0xFEFF) {
            jsonContent = jsonContent.slice(1);
            fs.writeFileSync(JSON_OUT, jsonContent, 'utf8');
        }
        // Validate it's valid JSON
        JSON.parse(jsonContent);

        // Create JS wrapper
        const jsContent = `var storyContent = ${jsonContent};`;
        fs.writeFileSync(JS_OUT, jsContent, 'utf8');

        const elapsed = Date.now() - startTime;
        const jsonSize = (fs.statSync(JSON_OUT).size / 1024).toFixed(1);
        const jsSize = (fs.statSync(JS_OUT).size / 1024).toFixed(1);

        console.log(`[build] OK - JSON: ${jsonSize}KB, JS: ${jsSize}KB (${elapsed}ms)`);
    } catch (err) {
        console.error('[build] COMPILATION ERROR:');
        if (err.stderr) console.error(err.stderr.toString());
        if (err.stdout) console.error(err.stdout.toString());
        process.exit(1);
    }
}

// Watch mode
if (process.argv.includes('--watch')) {
    console.log('[build] Watch mode - monitoring ink/ for changes...');
    build();

    const inkDir = path.join(ROOT, 'ink');
    let debounce = null;

    fs.watch(inkDir, { recursive: true }, (event, filename) => {
        if (!filename || !filename.endsWith('.ink')) return;
        if (debounce) clearTimeout(debounce);
        debounce = setTimeout(() => {
            console.log(`\n[build] Changed: ${filename}`);
            build();
        }, 500);
    });
} else {
    build();
}
