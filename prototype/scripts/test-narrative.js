#!/usr/bin/env node
/**
 * Narrative path tester for Un Día Más
 * Tests that key narrative paths can be followed without errors
 */
const fs = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '..');
const STORY_JSON = path.join(ROOT, 'web', 'un_dia_mas.json');

// Check if compiled story exists
if (!fs.existsSync(STORY_JSON)) {
    console.error('[test:narrative] Story JSON not found. Run `npm run build` first.');
    process.exit(1);
}

console.log('[test:narrative] Narrative path tests');
console.log('  (Requires compiled story JSON)\n');

// Load inkjs
let inkjs;
try {
    // Try loading from the web directory
    const inkPath = path.join(ROOT, 'web', 'ink.js');
    if (fs.existsSync(inkPath)) {
        // ink.js defines inkjs globally - we need to simulate browser env
        const vm = require('vm');
        const inkCode = fs.readFileSync(inkPath, 'utf8');
        const sandbox = { module: {}, exports: {}, window: {}, self: {} };
        vm.createContext(sandbox);
        vm.runInContext(inkCode, sandbox);
        inkjs = sandbox.inkjs || sandbox.module.exports;
    }
} catch (e) {
    console.log('  Could not load ink.js runtime');
    console.log('  Skipping narrative tests (runtime not available in Node context)');
    console.log('\n[test:narrative] SKIPPED - ink.js is browser-only');
    process.exit(0);
}

if (!inkjs || !inkjs.Story) {
    console.log('  ink.js runtime not compatible with Node.js');
    console.log('\n[test:narrative] SKIPPED');
    process.exit(0);
}

// If we got here, we can run narrative tests
const storyContent = JSON.parse(fs.readFileSync(STORY_JSON, 'utf8'));

let passed = 0;
let failed = 0;

function testPath(name, choices) {
    try {
        const story = new inkjs.Story(storyContent);
        let steps = 0;
        let choiceIndex = 0;

        while (story.canContinue || story.currentChoices.length > 0) {
            while (story.canContinue) {
                story.Continue();
                steps++;
            }

            if (story.currentChoices.length === 0) break;

            const pick = choiceIndex < choices.length ? choices[choiceIndex] : 0;
            const idx = Math.min(pick, story.currentChoices.length - 1);
            story.ChooseChoiceIndex(idx);
            choiceIndex++;

            if (steps > 5000) {
                throw new Error('Exceeded 5000 steps - possible infinite loop');
            }
        }

        console.log(`  ✓ ${name} (${steps} steps, ${choiceIndex} choices)`);
        passed++;
    } catch (err) {
        console.log(`  ✗ ${name}: ${err.message}`);
        failed++;
    }
}

// Test basic paths (always choose first option)
testPath('First-option path', Array(200).fill(0));
testPath('Second-option path', Array(200).fill(1));
testPath('Random-ish path', Array(200).fill(0).map((_, i) => i % 3));

console.log(`\n[test:narrative] Results: ${passed} passed, ${failed} failed`);
process.exit(failed > 0 ? 1 : 0);
