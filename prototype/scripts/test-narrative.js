#!/usr/bin/env node
/**
 * Narrative path tester for Un Día Más
 * Plays the compiled story and fails on any Ink runtime error.
 */
const fs = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '..');
const STORY_JSON = path.join(ROOT, 'web', 'un_dia_mas.json');
const INK_RUNTIME = path.join(ROOT, 'web', 'ink.js');

const FUZZ_RUNS = Number(process.env.FUZZ_RUNS || 200);
const MAX_STEPS = 20000;

if (!fs.existsSync(STORY_JSON)) {
    console.error('[test:narrative] Story JSON not found. Run `npm run build` first.');
    process.exit(1);
}

// ink.js is a UMD bundle: it exports cleanly under Node, no browser shim needed.
let inkjs;
try {
    inkjs = require(INK_RUNTIME);
} catch (e) {
    console.error('[test:narrative] Could not load ink.js runtime:', e.message);
    process.exit(1);
}
if (!inkjs || !inkjs.Story) {
    console.error('[test:narrative] ink.js loaded but exports no Story class.');
    process.exit(1);
}

console.log('[test:narrative] Narrative path tests\n');

const storyContent = JSON.parse(fs.readFileSync(STORY_JSON, 'utf8'));

// Deterministic RNG so a failing run can be replayed from its seed.
function rng(seed) {
    let s = seed >>> 0;
    return () => {
        s = (s * 1664525 + 1013904223) >>> 0;
        return s / 4294967296;
    };
}

/**
 * Play one full story until it ends or errors.
 * `pick(choices, turn)` returns the index to choose.
 */
function play(pick, trace, seed) {
    const story = new inkjs.Story(storyContent);
    // Ink seeds its own RNG (d6, RANDOM) randomly per Story. Pin it so a
    // failing seed replays identically instead of drifting every run.
    if (seed !== undefined) story.state.storySeed = seed;
    let error = null;
    let errorPath = '';
    story.onError = (msg) => {
        if (error) return;
        error = msg;
        // Where the flow actually died — the last knot that emitted text can be
        // several diverts upstream of it.
        try { errorPath = story.state.currentPathString || ''; } catch (e) {}
    };

    let lines = 0;
    let turns = 0;
    let lastPath = '';

    while (turns < MAX_STEPS) {
        while (story.canContinue) {
            const at = story.state.currentPathString;
            const text = story.Continue();
            lines++;
            if (trace && text.trim()) trace.push(`[${at}] ${text.trim()}`);
            if (error) break;
            if (at) lastPath = at;
        }
        if (error) break;
        if (story.currentChoices.length === 0) {
            if (trace) trace.push('### fin del flujo (sin opciones)');
            break;
        }
        const chosen = pick(story.currentChoices, turns);
        if (trace) {
            const opts = story.currentChoices.map(c => c.text).join(' | ');
            trace.push(`   >>> [${opts}] -> ${story.currentChoices[chosen].text}`);
        }
        story.ChooseChoiceIndex(chosen);
        turns++;
    }

    let dia = null;
    try { dia = story.variablesState['dia_actual']; } catch (e) {}

    return { error, lines, turns, dia, lastPath, errorPath };
}

let passed = 0;
let failed = 0;

function testPath(name, pick) {
    let result;
    try {
        result = play(pick, null, 0);
    } catch (err) {
        console.log(`  ✗ ${name}: ${err.message}`);
        failed++;
        return;
    }
    if (result.error) {
        console.log(`  ✗ ${name}: ${result.error}`);
        console.log(`      murió en: ${result.errorPath || '(fin de flujo)'} — último texto en ${result.lastPath} (día ${result.dia})`);
        failed++;
        return;
    }
    console.log(`  ✓ ${name} (${result.lines} líneas, ${result.turns} decisiones, día ${result.dia})`);
    passed++;
}

// --- Single-seed trace (debugging aid) --------------------------------------
// TRACE_SEED=42 npm run test:narrative  → prints that playthrough's transcript.

if (process.env.TRACE_SEED) {
    const seed = Number(process.env.TRACE_SEED);
    const rand = rng(seed);
    const trace = [];
    const result = play((choices) => Math.floor(rand() * choices.length), trace, seed);
    const tail = Number(process.env.TRACE_LINES || 30);
    console.log(trace.slice(-tail).join('\n'));
    console.log(`\n[seed ${seed}] ${result.error || 'sin error'} — día ${result.dia}, ${result.lines} líneas`);
    process.exit(result.error ? 1 : 0);
}

// --- Fixed strategies -------------------------------------------------------

console.log('Recorridos fijos:');
testPath('Siempre la primera opción', () => 0);
testPath('Siempre la última opción', (choices) => choices.length - 1);
testPath('Alternando opciones', (choices, turn) => turn % choices.length);

// --- Fuzz -------------------------------------------------------------------

console.log(`\nFuzz (${FUZZ_RUNS} partidas aleatorias):`);

const crashes = [];
const diasAlcanzados = {};

for (let seed = 1; seed <= FUZZ_RUNS; seed++) {
    const rand = rng(seed);
    let result;
    try {
        result = play((choices) => Math.floor(rand() * choices.length), null, seed);
    } catch (err) {
        crashes.push({ seed, error: err.message, lastPath: '?' });
        continue;
    }
    diasAlcanzados[result.dia] = (diasAlcanzados[result.dia] || 0) + 1;
    if (result.error) {
        crashes.push({ seed, error: result.error, lastPath: result.errorPath || result.lastPath });
    }
}

const dias = Object.keys(diasAlcanzados).sort((a, b) => a - b)
    .map(d => `día ${d}: ${diasAlcanzados[d]}`).join(', ');
console.log(`  Días alcanzados — ${dias}`);

if (crashes.length === 0) {
    console.log(`  ✓ ${FUZZ_RUNS} partidas sin errores de runtime`);
    passed++;
} else {
    console.log(`  ✗ ${crashes.length}/${FUZZ_RUNS} partidas con error de runtime`);
    const porKnot = {};
    crashes.forEach(c => {
        const knot = String(c.lastPath).split('.')[0];
        porKnot[knot] = porKnot[knot] || { count: 0, seed: c.seed, error: c.error };
        porKnot[knot].count++;
    });
    Object.entries(porKnot)
        .sort((a, b) => b[1].count - a[1].count)
        .slice(0, 10)
        .forEach(([knot, info]) => {
            console.log(`      ${info.count}x en "${knot}" (repetir con seed ${info.seed})`);
            console.log(`         ${info.error}`);
        });
    failed++;
}

console.log(`\n[test:narrative] Results: ${passed} passed, ${failed} failed`);
process.exit(failed > 0 ? 1 : 0);
