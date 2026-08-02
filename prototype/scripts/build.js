#!/usr/bin/env node
/**
 * Build script for Un Día Más
 * Compiles Ink source to JSON and wraps for web runtime
 */
const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '..');
const REPO_ROOT = path.resolve(ROOT, '..');
const INK_ENTRY = path.join(ROOT, 'ink', 'main.ink');
const JSON_OUT = path.join(ROOT, 'web', 'un_dia_mas.json');
const JS_OUT = path.join(ROOT, 'web', 'un_dia_mas.js');

function isExecutable(file) {
    try {
        fs.accessSync(file, fs.constants.X_OK);
        return true;
    } catch (e) {
        return false;
    }
}

function findInklecate() {
    // Native binary bundled with the repo — the only one guaranteed to run
    // on this platform. The npm package ships a Windows .exe that fails with
    // EACCES on Linux/macOS, so it is a last resort, not the first choice.
    const bundled = path.join(REPO_ROOT, 'bin', 'inklecate');
    if (isExecutable(bundled)) {
        return bundled;
    }
    const localBin = path.join(ROOT, 'node_modules', '.bin', 'inklecate');
    if (isExecutable(localBin) || fs.existsSync(localBin + '.cmd')) {
        return localBin;
    }
    return 'npx inklecate';
}

function build() {
    const startTime = Date.now();
    console.log('[build] Compiling Ink...');
    console.log(`[build] Entry: ${INK_ENTRY}`);

    const inklecate = findInklecate();
    console.log(`[build] Compiler: ${inklecate}`);

    // Remove any previous output first. Otherwise a compiler that never ran
    // (missing binary, wrong platform) leaves a stale JSON behind and the
    // build reports success while shipping last week's story.
    try { fs.unlinkSync(JSON_OUT); } catch (e) {}

    try {
        // Compile Ink to JSON
        const cmd = `"${inklecate}" -o "${JSON_OUT}" "${INK_ENTRY}"`;
        let output = '';
        let warnings = '';
        try {
            output = execSync(cmd, { encoding: 'utf8', cwd: ROOT, stdio: 'pipe', shell: true });
        } catch (execErr) {
            // inklecate exits non-zero on warnings too, so only bail out when
            // it actually reported errors or failed to produce the JSON.
            warnings = (execErr.stderr || '').toString();
            output = (execErr.stdout || '').toString();
            const hasErrors = /^ERROR:/m.test(warnings) || /^ERROR:/m.test(output);
            if (hasErrors || !fs.existsSync(JSON_OUT)) {
                throw execErr;
            }
        }

        // Compilation errors are reported on stdout with a zero exit code in
        // some inklecate builds — check the output regardless of exit status.
        const allOutput = (warnings + '\n' + output).trim();
        const errorLines = allOutput.split('\n').filter(l => /^ERROR:/.test(l.trim()));
        if (errorLines.length > 0) {
            console.error(`[build] COMPILATION ERROR: ${errorLines.length} error(s)`);
            errorLines.forEach(l => console.error('  ' + l.trim()));
            process.exit(1);
        }

        // Print warnings (non-fatal)
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
