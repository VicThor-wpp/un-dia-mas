/**
 * test-endings.js - Static analysis tests for narrative endings
 *
 * Verifies that all endings defined in finales/finales.ink are:
 * 1. Properly defined as knots
 * 2. Routed from evaluar_final (domingo.ink) or day transition checks
 * 3. Supported by evaluation functions in recursos.ink
 * 4. Protected by early game-over checks in each day file
 * 5. Have sufficient content and proper termination
 *
 * Usage: node scripts/test-endings.js
 * Exit code: 0 if all pass, 1 if any failures
 */

const fs = require('fs');
const path = require('path');

const INK_DIR = path.join(__dirname, '..', 'ink');
let passed = 0, failed = 0, warnings = 0;

function test(name, condition, detail) {
    if (condition) {
        console.log(`  \u2705 ${name}`);
        passed++;
    } else {
        console.log(`  \u274C ${name}`);
        if (detail) console.log(`     ${detail}`);
        failed++;
    }
}

function warn(name, detail) {
    console.log(`  \u26A0\uFE0F  ${name}`);
    if (detail) console.log(`     ${detail}`);
    warnings++;
}

function readFile(relativePath) {
    const fullPath = path.join(INK_DIR, relativePath);
    try {
        return fs.readFileSync(fullPath, 'utf-8');
    } catch (e) {
        console.error(`  ERROR: Could not read ${fullPath}: ${e.message}`);
        return null;
    }
}

// =============================================================
// Section 1: Endings Defined
// =============================================================
console.log('\n=== 1. Endings Defined in finales.ink ===\n');

const finalesContent = readFile(path.join('finales', 'finales.ink'));
const endingKnotPattern = /^===\s+(final_\w+)\s+===/gm;
const definedEndings = [];

if (finalesContent) {
    let match;
    while ((match = endingKnotPattern.exec(finalesContent)) !== null) {
        definedEndings.push(match[1]);
    }

    test(
        `Found ending definitions in finales.ink`,
        definedEndings.length > 0,
        'No === final_* === knots found'
    );

    console.log(`  Found ${definedEndings.length} endings: ${definedEndings.join(', ')}`);

    // Verify known expected endings
    const expectedEndings = [
        'final_la_llama',
        'final_red',
        'final_solo',
        'final_quizas',
        'final_incierto',
        'final_sin_llama',
        'final_apagado',
        'final_tejido',
        'final_gris',
        'final_pequeno_cambio',
        'final_vulnerabilidad_honesta',
        'final_lucha_colectiva'
    ];

    for (const ending of expectedEndings) {
        test(
            `Ending "${ending}" is defined`,
            definedEndings.includes(ending),
            `Missing knot === ${ending} === in finales.ink`
        );
    }
} else {
    test('finales.ink readable', false, 'Could not read finales/finales.ink');
}

// =============================================================
// Section 2: Endings Routed from evaluar_final
// =============================================================
console.log('\n=== 2. Endings Routed from evaluar_final (domingo.ink) ===\n');

const domingoContent = readFile(path.join('dias', 'domingo.ink'));
const routedEndings = [];

if (domingoContent) {
    // Extract the evaluar_final section (from === evaluar_final === to end of file or next ===)
    const evalFinalMatch = domingoContent.match(/===\s*evaluar_final\s*===([\s\S]*?)(?:===\s*\w+\s*===|$)/);

    if (evalFinalMatch) {
        const evalFinalSection = evalFinalMatch[1];
        const routePattern = /->\s*(final_\w+)/g;
        let routeMatch;
        while ((routeMatch = routePattern.exec(evalFinalSection)) !== null) {
            if (!routedEndings.includes(routeMatch[1])) {
                routedEndings.push(routeMatch[1]);
            }
        }

        test(
            `evaluar_final section found in domingo.ink`,
            true
        );

        console.log(`  Routed from evaluar_final: ${routedEndings.join(', ')}`);

        // Also check day transition files for early game-over routes
        const dayFiles = ['lunes.ink', 'martes.ink', 'miercoles.ink', 'jueves.ink', 'viernes.ink', 'sabado.ink'];
        const transitionRouted = [];

        for (const dayFile of dayFiles) {
            const dayContent = readFile(path.join('dias', dayFile));
            if (dayContent) {
                // Look for -> final_* in transition knots
                const transitionPattern = /->\s*(final_\w+)/g;
                let tMatch;
                while ((tMatch = transitionPattern.exec(dayContent)) !== null) {
                    if (!transitionRouted.includes(tMatch[1])) {
                        transitionRouted.push(tMatch[1]);
                    }
                }
            }
        }

        if (transitionRouted.length > 0) {
            console.log(`  Routed from day transitions: ${transitionRouted.join(', ')}`);
        }

        // Combine all routes
        const allRouted = [...new Set([...routedEndings, ...transitionRouted])];

        // Check each defined ending is reachable
        for (const ending of definedEndings) {
            const isRouted = allRouted.includes(ending);
            if (isRouted) {
                test(
                    `Ending "${ending}" is reachable`,
                    true
                );
            } else {
                test(
                    `Ending "${ending}" is reachable`,
                    false,
                    `Not found in evaluar_final or day transitions`
                );
            }
        }
    } else {
        test('evaluar_final section found', false, 'Could not find === evaluar_final === in domingo.ink');
    }
} else {
    test('domingo.ink readable', false, 'Could not read dias/domingo.ink');
}

// =============================================================
// Section 3: Evaluation Functions Called
// =============================================================
console.log('\n=== 3. Evaluation Functions in evaluar_final ===\n');

const recursosContent = readFile(path.join('mecanicas', 'recursos.ink'));

if (recursosContent && domingoContent) {
    // Check that the 3 evaluation functions exist in recursos.ink
    const evalFunctions = [
        'evaluar_pequeno_cambio',
        'evaluar_vulnerabilidad',
        'evaluar_lucha_colectiva'
    ];

    for (const func of evalFunctions) {
        const funcDefined = recursosContent.includes(`=== function ${func}()`);
        test(
            `Function "${func}" defined in recursos.ink`,
            funcDefined,
            `Missing function definition in mecanicas/recursos.ink`
        );
    }

    // Check that they are called from evaluar_final
    const evalFinalMatch = domingoContent.match(/===\s*evaluar_final\s*===([\s\S]*?)(?:===\s*\w+\s*===|$)/);
    const evalFinalSection = evalFinalMatch ? evalFinalMatch[1] : '';

    for (const func of evalFunctions) {
        const isCalled = evalFinalSection.includes(func);
        test(
            `Function "${func}" called from evaluar_final`,
            isCalled,
            `Not called in evaluar_final section of domingo.ink`
        );
    }
} else {
    if (!recursosContent) test('recursos.ink readable', false, 'Could not read mecanicas/recursos.ink');
    if (!domingoContent) test('domingo.ink readable', false, 'Could not read dias/domingo.ink');
}

// =============================================================
// Section 4: Early Game-Over Checks in Day Transitions
// =============================================================
console.log('\n=== 4. Early Game-Over Checks in Day Transitions ===\n');

const dayFiles = [
    { file: 'lunes.ink', transitionKnot: 'transicion_lunes_martes' },
    { file: 'martes.ink', transitionKnot: 'transicion_martes_miercoles' },
    { file: 'miercoles.ink', transitionKnot: 'transicion_miercoles_jueves' },
    { file: 'jueves.ink', transitionKnot: 'transicion_jueves_viernes' },
    { file: 'viernes.ink', transitionKnot: 'transicion_viernes_sabado' },
    { file: 'sabado.ink', transitionKnot: 'transicion_sabado_domingo' }
];

for (const { file, transitionKnot } of dayFiles) {
    const content = readFile(path.join('dias', file));
    if (content) {
        // Check for final_apagado reference
        const hasApagado = content.includes('final_apagado');
        test(
            `${file}: checks for final_apagado (mental collapse)`,
            hasApagado,
            `No reference to final_apagado found in ${file}`
        );

        // Check for final_sin_llama reference
        const hasSinLlama = content.includes('final_sin_llama');
        test(
            `${file}: checks for final_sin_llama (social collapse)`,
            hasSinLlama,
            `No reference to final_sin_llama found in ${file}`
        );

        // Verify the transition knot exists
        const hasTransition = content.includes(`=== ${transitionKnot} ===`);
        if (hasTransition) {
            test(
                `${file}: transition knot "${transitionKnot}" exists`,
                true
            );
        } else {
            warn(
                `${file}: transition knot "${transitionKnot}" not found`,
                `Expected === ${transitionKnot} === in ${file}`
            );
        }
    } else {
        test(`${file} readable`, false, `Could not read dias/${file}`);
    }
}

// =============================================================
// Section 5: Content Quality per Ending
// =============================================================
console.log('\n=== 5. Content Quality per Ending ===\n');

if (finalesContent) {
    for (const ending of definedEndings) {
        // Extract content between this knot and the next knot (or end of file)
        const knotPattern = new RegExp(
            `===\\s*${ending}\\s*===([\\s\\S]*?)(?:===\\s*\\w+\\s*===|$)`
        );
        const knotMatch = finalesContent.match(knotPattern);

        if (knotMatch) {
            const knotContent = knotMatch[1];

            // Count non-empty, non-comment lines
            const lines = knotContent.split('\n').filter(line => {
                const trimmed = line.trim();
                return trimmed.length > 0 && !trimmed.startsWith('//');
            });

            const lineCount = lines.length;
            const hasEnd = knotContent.includes('-> END');

            test(
                `"${ending}" has >= 10 content lines (found ${lineCount})`,
                lineCount >= 10,
                `Only ${lineCount} non-empty/non-comment lines`
            );

            test(
                `"${ending}" terminates with -> END`,
                hasEnd,
                `Missing -> END in ending knot`
            );
        } else {
            test(
                `"${ending}" content extractable`,
                false,
                `Could not extract knot content`
            );
        }
    }
} else {
    test('finales.ink readable for quality check', false, 'Could not read finales/finales.ink');
}

// =============================================================
// Summary
// =============================================================
console.log('\n' + '='.repeat(50));
console.log(`\nResults: ${passed} passed, ${failed} failed, ${warnings} warnings`);
console.log('');

if (failed > 0) {
    console.log('FAILED - Some tests did not pass.');
    process.exit(1);
} else if (warnings > 0) {
    console.log('PASSED with warnings.');
    process.exit(0);
} else {
    console.log('ALL PASSED.');
    process.exit(0);
}
