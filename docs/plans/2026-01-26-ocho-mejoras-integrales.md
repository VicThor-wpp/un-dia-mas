# Ocho Mejoras Integrales - Plan de Implementación

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Implementar 8 mejoras que abarcan narrativa (ecos, vínculo, feedback ambiental, Ixchel, Marcos), infraestructura (auditoría variables, tests narrativos) y UX (detección de tema del sistema).

**Architecture:** Cambios modulares e independientes. Tareas 1-2 son de infraestructura y limpieza (ejecutar primero). Tareas 3-7 son narrativa Ink. Tarea 8 es CSS/JS del runtime web. Cada tarea produce un commit atómico. El orden está diseñado para que las primeras tareas faciliten las siguientes.

**Tech Stack:** Ink (Inkle Studios), inklecate, JavaScript vanilla (browser modules), CSS custom properties, Node.js (scripts de test/lint).

---

## Contexto Clave para el Implementador

### Estructura del proyecto
- **Ink narrativo:** `prototype/ink/` — main.ink incluye todo. Variables centralizadas en `variables.ink`.
- **Runtime web:** `prototype/web/` — game.js orquesta módulos en `modules/`.
- **Configs:** `prototype/web/config/` — JSON para stats, personajes, finales, UI, audio, seguridad.
- **Scripts:** `prototype/scripts/` — build.js, test.js, lint-ink.js, test-narrative.js.
- **Docs:** `docs/` — NARRATIVE-MAP.md, FLOWCHARTS.md, planes.

### Convenciones
- **Variables:** TODAS las `VAR` se declaran en `variables.ink` o `mecanicas/recursos.ink`. Nunca en otros archivos.
- **Tunnels:** Los archivos `dias/*.ink` solo hacen routing con `-> knot ->`. El contenido vive en `ubicaciones/` y `personajes/`.
- **Funciones de recursos:** Usar `subir_conexion(n)`, `bajar_llama(n)`, etc. Nunca manipular variables directamente.
- **Tags especiales:** `# STAT_THRESHOLD`, `# IDEA:`, `# ENDING:`, `# LUNES` (día header).
- **Español uruguayo:** "bondi" (bus), "laburo" (trabajo), "pibe/a" (chico/a), "che" (apelativo), voseo.

### Sistema de transiciones entre días
Cada día termina con un knot `transicion_{dia}_{siguiente}` que:
1. Muestra fragmentos nocturnos
2. Chequea `salud_mental <= 0` → `final_apagado`
3. Chequea `llama <= 0` → `final_sin_llama`
4. Hace `-> {siguiente}_amanecer`

### Finales actuales (evaluar_final en domingo.ink:388-429)
Orden de prioridad: apagado → sin_llama → tejido (Ixchel) → la_llama (oculto) → red → solo → gris → quizás → incierto.
**Problema:** 3 finales definidos en finales.ink (pequeño_cambio, vulnerabilidad_honesta, lucha_colectiva) nunca son evaluados. Las funciones `evaluar_pequeno_cambio()`, `evaluar_vulnerabilidad()`, `evaluar_lucha_colectiva()` existen en `recursos.ink` pero no se llaman desde `evaluar_final`.

### Variables huérfanas conocidas (Fase 2)
Lines 102-135 de `variables.ink` definen flags detallados de NPCs (e.g., `diego_conto_cecosesola`, `elena_hablo_de_chola`) que sí son usados en los personajes pero algunos podrían no tener lectura.

---

## Task 1: Auditoría de Variables Huérfanas

**Files:**
- Create: `prototype/scripts/audit-variables.js`
- Modify: `prototype/package.json` (add script)
- Modify: `prototype/ink/variables.ink` (add comments, remove truly orphaned vars)

**Step 1: Write the audit script**

```javascript
// prototype/scripts/audit-variables.js
// Audits variables.ink to find orphaned VAR declarations
// A variable is orphaned if declared but never READ in any .ink file (outside its declaration)

const fs = require('fs');
const path = require('path');

const INK_DIR = path.join(__dirname, '..', 'ink');
const VARIABLES_FILE = path.join(INK_DIR, 'variables.ink');

// Collect all .ink files recursively
function getInkFiles(dir) {
    let results = [];
    const items = fs.readdirSync(dir, { withFileTypes: true });
    for (const item of items) {
        const fullPath = path.join(dir, item.name);
        if (item.isDirectory()) {
            results = results.concat(getInkFiles(fullPath));
        } else if (item.name.endsWith('.ink')) {
            results.push(fullPath);
        }
    }
    return results;
}

// Extract all VAR declarations from variables.ink
function extractVarDeclarations(filePath) {
    const content = fs.readFileSync(filePath, 'utf-8');
    const vars = [];
    const lines = content.split('\n');
    lines.forEach((line, i) => {
        const match = line.match(/^VAR\s+(\w+)\s*=/);
        if (match) {
            vars.push({ name: match[1], line: i + 1, file: filePath });
        }
    });
    return vars;
}

// Also extract VAR declarations from mecanicas/ files
function extractAllVarDeclarations() {
    const allVars = [];
    const files = getInkFiles(INK_DIR);
    for (const file of files) {
        const content = fs.readFileSync(file, 'utf-8');
        const lines = content.split('\n');
        lines.forEach((line, i) => {
            const match = line.match(/^VAR\s+(\w+)\s*=/);
            if (match) {
                allVars.push({
                    name: match[1],
                    line: i + 1,
                    file: path.relative(path.join(__dirname, '..'), file)
                });
            }
        });
    }
    return allVars;
}

// Search for variable usage (read or write) across all files
function findVariableUsage(varName, files, declarationFile) {
    const reads = [];
    const writes = [];

    for (const file of files) {
        const content = fs.readFileSync(file, 'utf-8');
        const lines = content.split('\n');
        const relPath = path.relative(path.join(__dirname, '..'), file);

        lines.forEach((line, i) => {
            // Skip the VAR declaration line itself
            if (line.match(new RegExp(`^VAR\\s+${varName}\\s*=`))) return;
            // Skip comments
            if (line.trim().startsWith('//')) return;

            // Check for reads: variable used in conditions, expressions, function args
            // Pattern: variable name appears as a word boundary
            const readPattern = new RegExp(`\\b${varName}\\b`);
            if (readPattern.test(line)) {
                // Determine if it's a write (assignment) or read
                const writePattern = new RegExp(`~\\s*${varName}\\s*(=|\\+=|-=)`);
                if (writePattern.test(line)) {
                    writes.push({ file: relPath, line: i + 1 });
                } else {
                    reads.push({ file: relPath, line: i + 1 });
                }
            }
        });
    }

    return { reads, writes };
}

// Main
const allVars = extractAllVarDeclarations();
const allFiles = getInkFiles(INK_DIR);

console.log(`\n[audit] Scanning ${allVars.length} variables across ${allFiles.length} .ink files\n`);

const orphaned = [];     // Declared but never read or written
const writeOnly = [];    // Declared and written but never read
const readOnly = [];     // Declared and read but never written (possible bug)
const healthy = [];      // Both read and written

for (const v of allVars) {
    const usage = findVariableUsage(v.name, allFiles, v.file);

    if (usage.reads.length === 0 && usage.writes.length === 0) {
        orphaned.push({ ...v, usage });
    } else if (usage.reads.length === 0) {
        writeOnly.push({ ...v, usage });
    } else if (usage.writes.length === 0) {
        readOnly.push({ ...v, usage });
    } else {
        healthy.push({ ...v, usage });
    }
}

// Report
console.log(`=== VARIABLE AUDIT REPORT ===\n`);

console.log(`✅ HEALTHY (read + written): ${healthy.length}`);
healthy.forEach(v => {
    console.log(`   ${v.name} (${v.file}:${v.line}) - ${v.usage.reads.length} reads, ${v.usage.writes.length} writes`);
});

console.log(`\n⚠️  WRITE-ONLY (written but never read): ${writeOnly.length}`);
writeOnly.forEach(v => {
    console.log(`   ${v.name} (${v.file}:${v.line}) - 0 reads, ${v.usage.writes.length} writes`);
});

console.log(`\n📖 READ-ONLY (read but never written outside declaration): ${readOnly.length}`);
readOnly.forEach(v => {
    console.log(`   ${v.name} (${v.file}:${v.line}) - ${v.usage.reads.length} reads, 0 writes`);
});

console.log(`\n❌ ORPHANED (never read or written): ${orphaned.length}`);
orphaned.forEach(v => {
    console.log(`   ${v.name} (${v.file}:${v.line})`);
});

console.log(`\n--- SUMMARY ---`);
console.log(`Total variables: ${allVars.length}`);
console.log(`Healthy: ${healthy.length}`);
console.log(`Write-only: ${writeOnly.length}`);
console.log(`Read-only: ${readOnly.length}`);
console.log(`Orphaned: ${orphaned.length}`);

if (orphaned.length > 0) {
    console.log(`\n⚠️  ${orphaned.length} variables can be safely removed or need implementation.`);
}

process.exit(orphaned.length > 10 ? 1 : 0); // Only fail if excessive orphans
```

**Step 2: Add npm script**

In `prototype/package.json`, add to `"scripts"`:
```json
"audit": "node scripts/audit-variables.js"
```

**Step 3: Run the audit**

Run: `cd prototype && npm run audit`
Expected: Report showing categorized variables. Take note of which are orphaned.

**Step 4: Comment orphaned variables in variables.ink**

For each truly orphaned variable (0 reads, 0 writes), add a comment:
```ink
// TODO(fase2): Variable pendiente de implementación
VAR elena_hablo_de_chola = false
```

For any that are genuinely unused AND not planned for Phase 2, remove them entirely.

**IMPORTANT:** Do NOT remove variables that are written in personajes/*.ink files — those are used even if not read yet (they're Phase 2 content flags). The audit will reveal which are truly dead.

**Step 5: Run the existing lint to verify no breakage**

Run: `cd prototype && npm run lint`
Expected: 0 errors

**Step 6: Commit**

```bash
git add prototype/scripts/audit-variables.js prototype/package.json prototype/ink/variables.ink
git commit -m "feat: add variable audit script and annotate orphaned Phase 2 vars"
```

---

## Task 2: Tests Narrativos Automatizados para Finales

**Files:**
- Create: `prototype/scripts/test-endings.js`
- Modify: `prototype/package.json` (add script)

**Step 1: Write the ending reachability test framework**

This script validates the ending routing logic in `domingo.ink` by analyzing the conditional tree. It does NOT run the Ink runtime (which requires a browser). Instead, it does static analysis of `evaluar_final` to ensure:
1. All endings defined in `finales.ink` have routes in `evaluar_final`
2. No ending is unreachable due to prior conditions shadowing it
3. The 3 orphaned endings (pequeño_cambio, vulnerabilidad_honesta, lucha_colectiva) are flagged

```javascript
// prototype/scripts/test-endings.js
// Static analysis of ending reachability

const fs = require('fs');
const path = require('path');

const INK_DIR = path.join(__dirname, '..', 'ink');
let passed = 0;
let failed = 0;
let warnings = 0;

function test(name, condition, detail) {
    if (condition) {
        console.log(`  ✅ ${name}`);
        passed++;
    } else {
        console.log(`  ❌ ${name}`);
        if (detail) console.log(`     ${detail}`);
        failed++;
    }
}

function warn(name, detail) {
    console.log(`  ⚠️  ${name}`);
    if (detail) console.log(`     ${detail}`);
    warnings++;
}

// --- Test 1: All endings defined in finales.ink ---
console.log('\n[1] Endings defined in finales.ink');

const finalesContent = fs.readFileSync(
    path.join(INK_DIR, 'finales', 'finales.ink'), 'utf-8'
);
const definedEndings = [];
const endingPattern = /^===\s*(final_\w+)\s*===/gm;
let match;
while ((match = endingPattern.exec(finalesContent)) !== null) {
    definedEndings.push(match[1]);
}

console.log(`   Found ${definedEndings.length} endings defined:`);
definedEndings.forEach(e => console.log(`   - ${e}`));

test('At least 6 endings defined', definedEndings.length >= 6);
test('final_la_llama exists', definedEndings.includes('final_la_llama'));
test('final_red exists', definedEndings.includes('final_red'));
test('final_solo exists', definedEndings.includes('final_solo'));
test('final_quizas exists', definedEndings.includes('final_quizas'));
test('final_incierto exists', definedEndings.includes('final_incierto'));
test('final_gris exists', definedEndings.includes('final_gris'));
test('final_apagado exists', definedEndings.includes('final_apagado'));
test('final_sin_llama exists', definedEndings.includes('final_sin_llama'));
test('final_tejido exists', definedEndings.includes('final_tejido'));

// --- Test 2: All endings routed from evaluar_final ---
console.log('\n[2] Endings routed from evaluar_final (domingo.ink)');

const domingoContent = fs.readFileSync(
    path.join(INK_DIR, 'dias', 'domingo.ink'), 'utf-8'
);

// Extract evaluar_final section
const evalStart = domingoContent.indexOf('=== evaluar_final ===');
if (evalStart === -1) {
    test('evaluar_final knot exists', false, 'Not found in domingo.ink');
} else {
    test('evaluar_final knot exists', true);

    const evalSection = domingoContent.substring(evalStart);
    const routedEndings = [];
    const routePattern = /-> (final_\w+)/g;
    while ((match = routePattern.exec(evalSection)) !== null) {
        if (!routedEndings.includes(match[1])) {
            routedEndings.push(match[1]);
        }
    }

    console.log(`   Found ${routedEndings.length} endings routed:`);
    routedEndings.forEach(e => console.log(`   - ${e}`));

    // Check each defined ending has a route
    for (const ending of definedEndings) {
        const isRouted = routedEndings.includes(ending);
        if (isRouted) {
            test(`${ending} is routed`, true);
        } else {
            // Check if it's routed from transitions (early game-over)
            const transitionPattern = new RegExp(`-> ${ending}`, 'g');
            let foundElsewhere = false;
            const dayFiles = fs.readdirSync(path.join(INK_DIR, 'dias'))
                .filter(f => f.endsWith('.ink'));

            for (const dayFile of dayFiles) {
                if (dayFile === 'domingo.ink') continue;
                const dayContent = fs.readFileSync(
                    path.join(INK_DIR, 'dias', dayFile), 'utf-8'
                );
                if (transitionPattern.test(dayContent)) {
                    foundElsewhere = true;
                    test(`${ending} is routed (from ${dayFile} transition)`, true);
                    break;
                }
            }

            if (!foundElsewhere) {
                test(`${ending} is routed`, false,
                    `UNREACHABLE: Defined in finales.ink but no route exists`);
            }
        }
    }
}

// --- Test 3: Evaluation functions exist for extended endings ---
console.log('\n[3] Evaluation functions for extended endings');

const recursosContent = fs.readFileSync(
    path.join(INK_DIR, 'mecanicas', 'recursos.ink'), 'utf-8'
);

const evalFunctions = [
    'evaluar_pequeno_cambio',
    'evaluar_vulnerabilidad',
    'evaluar_lucha_colectiva'
];

for (const func of evalFunctions) {
    const exists = recursosContent.includes(`function ${func}()`);
    test(`${func}() defined in recursos.ink`, exists);

    // Check if it's called from domingo.ink
    const called = domingoContent.includes(func);
    if (!called) {
        warn(`${func}() is NOT called from evaluar_final`,
            'Function exists but ending is unreachable');
    }
}

// --- Test 4: Transition checks for early game-overs ---
console.log('\n[4] Early game-over checks in day transitions');

const dayFiles = ['lunes.ink', 'martes.ink', 'miercoles.ink', 'jueves.ink', 'viernes.ink', 'sabado.ink'];

for (const dayFile of dayFiles) {
    const content = fs.readFileSync(path.join(INK_DIR, 'dias', dayFile), 'utf-8');
    const hasApagado = content.includes('final_apagado');
    const hasSinLlama = content.includes('final_sin_llama');

    test(`${dayFile} checks salud_mental (final_apagado)`, hasApagado,
        hasApagado ? '' : 'Missing early game-over check for mental health collapse');
    test(`${dayFile} checks llama (final_sin_llama)`, hasSinLlama,
        hasSinLlama ? '' : 'Missing early game-over check for collective collapse');
}

// --- Test 5: Ending content quality ---
console.log('\n[5] Ending content completeness');

for (const ending of definedEndings) {
    const endingStart = finalesContent.indexOf(`=== ${ending} ===`);
    if (endingStart === -1) continue;

    const nextEnding = finalesContent.indexOf('===', endingStart + 10);
    const endingContent = nextEnding > 0
        ? finalesContent.substring(endingStart, nextEnding)
        : finalesContent.substring(endingStart);

    const lineCount = endingContent.split('\n').length;
    const hasEnd = endingContent.includes('-> END');
    const hasEndingTag = endingContent.includes('# ENDING:') || endingContent.includes('# FINAL:') || endingContent.includes('# FIN');

    test(`${ending} has sufficient content (${lineCount} lines)`, lineCount >= 10,
        lineCount < 10 ? `Only ${lineCount} lines - may be a stub` : '');
    test(`${ending} terminates (-> END)`, hasEnd,
        !hasEnd ? 'Missing -> END termination' : '');
}

// --- Summary ---
console.log(`\n=== ENDING TEST SUMMARY ===`);
console.log(`Passed: ${passed}`);
console.log(`Failed: ${failed}`);
console.log(`Warnings: ${warnings}`);
console.log(`Total endings defined: ${definedEndings.length}`);

process.exit(failed > 0 ? 1 : 0);
```

**Step 2: Add npm script**

In `prototype/package.json`, add to `"scripts"`:
```json
"test:endings": "node scripts/test-endings.js"
```

**Step 3: Run the test**

Run: `cd prototype && npm run test:endings`
Expected: Several FAIL results for the 3 unreachable endings (pequeño_cambio, vulnerabilidad_honesta, lucha_colectiva). This is the baseline — Task 3 (Ixchel) and later tasks will fix some of these.

**Step 4: Commit**

```bash
git add prototype/scripts/test-endings.js prototype/package.json
git commit -m "feat: add ending reachability test suite - baseline with known failures"
```

---

## Task 3: Completar Ixchel como Personaje Pleno

**Files:**
- Modify: `prototype/ink/personajes/ixchel.ink` (add integration scenes)
- Modify: `prototype/ink/dias/jueves.ink` (add Ixchel encounter at olla)
- Modify: `prototype/ink/dias/viernes.ink` (Ixchel in crisis)
- Modify: `prototype/ink/dias/sabado.ink` (Ixchel at assembly)

**Context:** Ixchel already has 905 lines of content with deep backstory (Tomás murder, Mina Marlin, huipil, K'iche' cosmovision). She has her own ending (`final_tejido`). What's missing is **integration into the daily flow** — the player needs chances to encounter and build relationship with her across days to reach `ixchel_relacion >= 4`.

**Step 1: Add Ixchel encounter in jueves at olla**

In `prototype/ink/dias/jueves.ink`, find the section where the player visits the olla (look for a knot like `jueves_olla` or where `fui_a_olla_jueves` is set). Add an Ixchel encounter:

```ink
=== jueves_olla_ixchel ===
// Triggered when player goes to olla on Thursday

En la cocina hay alguien que no conocés.

Una mujer baja, morena, pelo largo recogido.
Pica verduras con una precisión que parece innata.

-> ixchel_primer_encuentro_olla ->

// After tunnel returns, continue with olla activities
-> jueves_olla_actividades
```

**IMPORTANT:** This should use the tunnel `ixchel_primer_encuentro_olla` which already exists in `personajes/ixchel.ink`. Verify the exact knot name exists before writing the divert.

**Step 2: Add Ixchel in viernes crisis**

In `prototype/ink/dias/viernes.ink`, in the olla crisis scene, add Ixchel's presence:

```ink
// Inside the viernes crisis scene, add conditional block:
{ixchel_relacion >= 1:
    Ixchel está en la cocina.
    No dice nada. Pero sigue cocinando.
    Con lo que hay. Con lo que queda.

    "Siempre se puede con menos", murmura.
    "En mi pueblo, con menos se hacía más."

    ~ ixchel_relacion += 1
}
```

**Step 3: Add Ixchel at sabado assembly**

In `prototype/ink/dias/sabado.ink`, in the assembly scene, add:

```ink
// Inside sabado assembly scene, after other NPCs are mentioned:
{ixchel_relacion >= 2:
    Ixchel está al fondo.
    No habla. Pero escucha.

    En un momento, cuando alguien dice "esto se cae",
    ella dice, bajito:

    "En mi comunidad votaron 98% que no.
    Y la mina abrió igual.
    Pero no dejamos de juntarnos."

    Silencio.

    "Juntarse es lo primero. Lo demás viene después."

    ~ ixchel_relacion += 1
    ~ subir_llama(1)
}
```

**Step 4: Verify Ixchel ending path is reachable**

With these 3 new encounters (jueves +1, viernes +1, sabado +1), plus the existing `ixchel_conversacion_profunda` (+2), a player who engages with Ixchel can reach `ixchel_relacion >= 4`. Combined with `ixchel_conto_historia` (set in conversacion_profunda) and `ayude_en_olla`, the `final_tejido` ending becomes achievable.

**Step 5: Compile and verify**

Run: `cd prototype && npm run build`
Expected: No compilation errors

**Step 6: Run ending tests**

Run: `cd prototype && npm run test:endings`
Expected: `final_tejido` should still be routed (it already is in domingo.ink:404)

**Step 7: Commit**

```bash
git add prototype/ink/dias/jueves.ink prototype/ink/dias/viernes.ink prototype/ink/dias/sabado.ink
git commit -m "feat: integrate Ixchel into daily flow - jueves/viernes/sabado encounters"
```

---

## Task 4: Sistema de Ecos Narrativos Entre Días

**Files:**
- Modify: `prototype/ink/dias/martes.ink` (eco from lunes)
- Modify: `prototype/ink/dias/jueves.ink` (eco from miercoles)
- Modify: `prototype/ink/dias/viernes.ink` (eco from jueves)
- Modify: `prototype/ink/dias/sabado.ink` (eco from viernes)
- Modify: `prototype/ink/dias/domingo.ink` (eco from sabado)

**Context:** Currently each day is self-contained. The player's choices affect stat numbers but don't produce visible textual echoes in following days. Adding small conditional blocks at the START of each day (in the `_amanecer` knot, after the day header) creates a sense of continuity.

**Step 1: Add martes echo from lunes choices**

In `prototype/ink/dias/martes.ink`, right after `~ dia_actual = 2` and `~ energia = X` and the `# MARTES` tag, add:

```ink
// --- Ecos del lunes ---
{almorzamos_juntos:
    Juan te saluda de lejos al llegar.
    Ayer almorzaron juntos.
    Hoy hay algo distinto en el saludo. Más cercano.
}
{conozco_al_kiosquero:
    Pasás por el kiosco. El tipo te saluda.
    "¿Lo de siempre?"
    Parece que ya tenés rutina.
}
```

**Step 2: Add jueves echo from miercoles (post-despido)**

In `prototype/ink/dias/jueves.ink`, right after the day setup:

```ink
// --- Ecos del miércoles ---
// This is the first morning without work
{conte_a_alguien:
    El celular tiene un mensaje.
    {vinculo == "sofia": Sofía: "¿Cómo amaneciste?"}
    {vinculo == "elena": Elena: "Pensé en vos anoche. Pasá si querés."}
    {vinculo == "diego": Diego: "Che, cualquier cosa avisá."}
    {vinculo == "marcos": Marcos no escribió. Pero vos sabés que sabe.}
    {vinculo == "ixchel": Ixchel: "Buenos días. Hoy cocino temprano si querés venir."}
}
{not conte_a_alguien:
    Silencio.
    El celular no suena.
    Nadie sabe.
    Nadie va a preguntar.
}
```

**Step 3: Add viernes echo from jueves**

In `prototype/ink/dias/viernes.ink`, right after the day setup:

```ink
// --- Ecos del jueves ---
{fui_a_olla_jueves:
    Te acordás de ayer en la olla.
    Las manos con olor a cebolla.
    Las caras.
    Hoy hay que volver.
}
{ayude_a_diego:
    Diego te mandó un mensaje anoche: "Gracias por la mano, che."
}
```

**Step 4: Add sabado echo from viernes**

In `prototype/ink/dias/sabado.ink`, right after the day setup:

```ink
// --- Ecos del viernes ---
{olla_cerro_viernes:
    Ayer la olla cerró.
    Es sábado y todavía te pesa.
    40 personas que no comieron.
    ¿O sí comieron? ¿Dónde?
}
{not olla_cerro_viernes && ayude_en_olla:
    Ayer la olla funcionó.
    Con lo justo. Pero funcionó.
    Hoy hay asamblea.
}
```

**Step 5: Add domingo echo from sabado**

In `prototype/ink/dias/domingo.ink`, right after the day setup:

```ink
// --- Ecos del sábado ---
{participe_asamblea:
    La asamblea de ayer fue... algo.
    {marcos_vino_a_asamblea: Marcos estaba. No dijiste nada. Pero estaba.}
    Hoy es domingo.
    Último día de la semana.
}
{not participe_asamblea:
    Domingo.
    Ayer no fuiste a nada.
    Hoy tampoco hay nada.
    O capaz que sí, pero no te enteraste.
}
```

**Step 6: Compile and verify**

Run: `cd prototype && npm run build`
Expected: No compilation errors

**Step 7: Commit**

```bash
git add prototype/ink/dias/martes.ink prototype/ink/dias/jueves.ink prototype/ink/dias/viernes.ink prototype/ink/dias/sabado.ink prototype/ink/dias/domingo.ink
git commit -m "feat: add narrative echo system - past choices reflected in following days"
```

---

## Task 5: Preguntas Trigger para Selección de Vínculo

**Files:**
- Modify: `prototype/ink/main.ink` (replace `asignar_vinculo` knot)

**Context:** Currently `asignar_vinculo` (main.ink:190-240) presents a flat list of NPC names with brief descriptions. The user previously requested "preguntas trigger porque no conocemos a esas personas" — the player should choose a SCENE that resonates, not a NAME.

**Step 1: Read the current `asignar_vinculo` implementation**

Current code (main.ink starting ~line 190):
```ink
=== asignar_vinculo ===
# HAY ALGUIEN.
En el barrio hay gente. Saludos, caras conocidas, nombres que recordás a medias.
Pero con alguien tenés algo más.

* [Sofía. La de la olla.]
    ~ vinculo = "sofia"
    ...
* [Elena. La veterana.]
    ~ vinculo = "elena"
    ...
(etc.)
```

**Step 2: Replace with trigger-scene selection**

Replace the ENTIRE `asignar_vinculo` knot (from `=== asignar_vinculo ===` to the last `-> confirmar_inicio` in that section) with:

```ink
=== asignar_vinculo ===

# HAY ALGUIEN.

En el barrio hay gente. Caras conocidas, nombres que recordás a medias.

Pero un momento te vuelve siempre.

* [Un tupper de guiso que apareció en tu puerta. "Sobró", te dijeron. Mentira.]
    ~ vinculo = "sofia"
    Era Sofía. La de la olla popular.
    Sus pibes iban a la misma escuela. O iban.
    Nunca hablaron de ese tupper.
    Pero desde entonces se miran distinto.
    -> confirmar_inicio

* [Un banco de plaza. Una vieja que te dijo "mirá qué grande estás", como si te conociera de siempre.]
    ~ vinculo = "elena"
    Era Elena. La veterana.
    Conoció a tu familia. O vos la ayudaste una vez.
    Te mira como esperando algo.
    No sabés si podés dárselo.
    -> confirmar_inicio

* [Un tipo con una mochila, mirando un papel con una dirección. Le señalaste el camino.]
    ~ vinculo = "diego"
    Era Diego. Había llegado hacía poco.
    Te buscó después. Preguntó cosas. Confió en vos.
    No sabés si merecés esa confianza.
    -> confirmar_inicio

* [Un portón cerrado. Sabés quién vive ahí. Hace rato que no lo ves.]
    ~ vinculo = "marcos"
    Es Marcos. El que se alejó.
    Antes eran cercanos. Antes de que él se quemara.
    Ahora se cruzan y es raro.
    Hay algo ahí que ninguno termina de cerrar.
    -> confirmar_inicio

* [Una mujer en la cocina de la olla. Pica verduras como si rezara. No la conocés todavía.]
    ~ vinculo = "ixchel"
    Es Ixchel. No sabés su nombre todavía.
    Pero algo en sus manos te llamó la atención.
    Una precisión antigua. Un silencio que dice cosas.
    Alguien te contó que vino de lejos.
    -> confirmar_inicio
```

**Step 3: Verify confirmar_inicio still works**

The `confirmar_inicio` knot should follow this section and should still work — it reads the `vinculo` variable. Verify by reading the knot and checking no references to the old format broke.

**Step 4: Compile and verify**

Run: `cd prototype && npm run build`
Expected: No compilation errors

**Step 5: Commit**

```bash
git add prototype/ink/main.ink
git commit -m "feat: replace flat vinculo selection with trigger-scene choices"
```

---

## Task 6: Feedback Visual por Estado del Juego (CSS Ambiental)

**Files:**
- Modify: `prototype/web/style.css` (add/enhance state-dependent styles)
- Modify: `prototype/web/modules/stats-panel.js` (add body class management for new thresholds)

**Context:** The CSS already has threshold effects:
- `body.salud-baja` — desaturates, melancholy vignette
- `body.llama-low` — despair accent color
- `body.conexion-low` — isolation vignette
- `body.trauma-high` — heavy desaturation with red vignette

These are applied by `stats-panel.js` based on config thresholds. We need to:
1. Add positive-state styles (high conexion, high llama)
2. Add `prefers-color-scheme` auto-detection
3. Add `prefers-reduced-motion` support (already partially there)

**Step 1: Read current threshold CSS in style.css**

Find the section with `body.salud-baja`, `body.llama-low`, etc. Note the pattern used.

**Step 2: Add positive state styles to style.css**

After the existing threshold effect blocks, add:

```css
/* --- POSITIVE STATE EFFECTS --- */

/* High connection: the world feels warmer */
body.conexion-high {
    --text-main: #efe6d6;
    --bg-surface: #2d3545;
}

body.conexion-high .story p {
    line-height: calc(var(--line-height-base) + 0.05);
}

/* High llama: collective hope - subtle warm glow */
body.llama-high {
    --accent: #f48c06;
    --accent-glow: rgba(244, 140, 6, 0.5);
}

body.llama-high .story {
    text-shadow: 0 0 40px rgba(244, 140, 6, 0.03);
}

/* Combined crisis: multiple low stats compound */
body.salud-baja.conexion-low {
    filter: saturate(0.3) brightness(0.8);
}

body.salud-baja.conexion-low .story p {
    max-width: 50ch;
    letter-spacing: -0.02em;
}
```

**Step 3: Add prefers-color-scheme auto-detection**

At the END of style.css, add:

```css
/* --- SYSTEM PREFERENCE DETECTION --- */

/* Auto-detect system dark/light preference */
@media (prefers-color-scheme: light) {
    :root:not([data-theme-override]) {
        /* Apply Atardecer theme as default for light-mode users */
        --bg-dark: #f5efe6;
        --bg-light: #ede4d8;
        --bg-surface: #e8dfd0;
        --text-main: #2a2520;
        --text-muted: #6b5e52;
        --text-dim: #9a8f80;
        --accent: #c4501a;
        --accent-dim: rgba(196, 80, 26, 0.2);
        --accent-glow: rgba(196, 80, 26, 0.3);
    }
}

/* Respect reduced motion preference */
@media (prefers-reduced-motion: reduce) {
    *,
    *::before,
    *::after {
        animation-duration: 0.01ms !important;
        animation-iteration-count: 1 !important;
        transition-duration: 0.01ms !important;
        scroll-behavior: auto !important;
    }
}

/* High contrast system preference */
@media (prefers-contrast: more) {
    :root:not([data-theme-override]) {
        --bg-dark: #000000;
        --bg-light: #111111;
        --bg-surface: #1a1a1a;
        --text-main: #ffffff;
        --text-muted: #cccccc;
        --accent: #ffaa00;
        --success: #00ff00;
        --danger: #ff0000;
    }
}
```

**Step 4: Update reading-preferences.js to set data-theme-override**

In `prototype/web/modules/reading-preferences.js`, find the `applyPrefs()` function. When the user manually selects a theme, add:

```javascript
// Inside applyPrefs(), after applying theme class:
document.documentElement.setAttribute('data-theme-override', 'true');
```

And when resetting to defaults:
```javascript
// Inside resetPrefs():
document.documentElement.removeAttribute('data-theme-override');
```

This ensures manual theme selection overrides system auto-detection via the `:not([data-theme-override])` CSS selector.

**Step 5: Update stats-panel.js to add positive threshold classes**

In `prototype/web/modules/stats-panel.js`, find the section that applies body classes based on thresholds (look for `document.body.classList.add`). Add:

```javascript
// After existing threshold checks, add positive states:
const conexionValue = this.getStatValue('conexion');
const llamaValue = this.getStatValue('llama');

if (conexionValue >= 7) {
    document.body.classList.add('conexion-high');
} else {
    document.body.classList.remove('conexion-high');
}

if (llamaValue >= 7) {
    document.body.classList.add('llama-high');
} else {
    document.body.classList.remove('llama-high');
}
```

**Step 6: Update stats config to define new thresholds**

In `prototype/web/config/stats.json`, add to the thresholds section:

```json
{
    "stat": "conexion",
    "condition": ">=",
    "value": 7,
    "bodyClass": "conexion-high",
    "indicator": "Parte del barrio"
},
{
    "stat": "llama",
    "condition": ">=",
    "value": 7,
    "bodyClass": "llama-high",
    "indicator": "Esperanza viva"
}
```

**Step 7: Compile, build, and verify visually**

Run: `cd prototype && npm run build`
Then open `prototype/web/index.html` in browser and verify:
- Default dark theme loads
- If system is in light mode and no manual theme set, Atardecer theme appears
- Threshold effects still work for low stats

**Step 8: Commit**

```bash
git add prototype/web/style.css prototype/web/modules/stats-panel.js prototype/web/modules/reading-preferences.js prototype/web/config/stats.json
git commit -m "feat: add ambient visual feedback for game state + system theme auto-detection"
```

---

## Task 7: Marcos Post-Revelación — Domingo en la Olla

**Files:**
- Modify: `prototype/ink/personajes/marcos.ink` (add domingo scene)
- Modify: `prototype/ink/dias/domingo.ink` (add Marcos encounter)

**Context:** Marcos's arc goes from isolation → revelation (shared firing) → tentative assembly attendance. But after Saturday's assembly, there's no Sunday content for him. If `marcos_vino_a_asamblea == true` and `marcos_relacion >= 4`, Marcos should appear at the olla on Sunday — uncomfortable, out of place, but present. This closes his arc and reinforces the game's theme.

**Step 1: Add Sunday Marcos scene to personajes/marcos.ink**

At the end of `prototype/ink/personajes/marcos.ink`, before any final markers, add:

```ink
// ============================================
// MARCOS - DOMINGO EN LA OLLA
// ============================================

=== marcos_domingo_olla ===
// Triggered from domingo.ink if marcos_vino_a_asamblea && marcos_relacion >= 4

Marcos está en la olla.

No en la puerta. No mirando de lejos.
Adentro.

Tiene las manos en los bolsillos.
La postura de alguien que no sabe dónde ponerse.

{marcos_secreto:
    Te ve.

    "No me mires así."

    "..."

    "Vine. No sé por qué. No me hagas explicar."
}
{not marcos_secreto:
    Te ve. Asiente.

    Algo cambió desde ayer.
    No sabés qué. Pero algo.
}

* [No decir nada. Estar.]
    No decís nada.
    Él tampoco.

    Se quedan así.
    Dos tipos en una olla popular un domingo.

    No es heroico.
    No es revolucionario.

    Pero está ahí.

    ~ marcos_estado = "reconectando"
    ~ marcos_relacion += 1
    ~ subir_conexion(1)
    ~ subir_llama(1)

    ->->

* [Pasarle un mate.]
    Le pasás un mate.

    Lo mira. Lo agarra.

    "Hace rato que no tomaba mate con alguien."

    Pausa.

    "Gracias."

    No es solo por el mate.

    ~ marcos_estado = "reconectando"
    ~ marcos_relacion += 1
    ~ subir_conexion(1)
    ~ subir_llama(1)

    ->->
```

**Step 2: Wire the encounter into domingo.ink**

In `prototype/ink/dias/domingo.ink`, find the section where Sunday encounters happen (likely `domingo_barrio` or `domingo_encuentro_grupo`, around line 135-172). Add a conditional that triggers before or during the group encounter:

```ink
// Add inside domingo_barrio or domingo_manana, where the player can go to barrio:
{marcos_vino_a_asamblea && marcos_relacion >= 4:
    -> marcos_domingo_olla ->
    // Returns here after tunnel
}
```

**Step 3: Compile and verify**

Run: `cd prototype && npm run build`
Expected: No compilation errors

**Step 4: Commit**

```bash
git add prototype/ink/personajes/marcos.ink prototype/ink/dias/domingo.ink
git commit -m "feat: add Marcos post-revelation Sunday scene at olla"
```

---

## Task 8: Conectar Finales Huérfanos al Router de Evaluación

**Files:**
- Modify: `prototype/ink/dias/domingo.ink` (update `evaluar_final`)

**Context:** Three endings exist in `finales.ink` but have no route from `evaluar_final`:
- `final_pequeno_cambio` — small internal shift (requires `evaluar_pequeno_cambio()`)
- `final_vulnerabilidad_honesta` — honest vulnerability (requires `evaluar_vulnerabilidad()`)
- `final_lucha_colectiva` — collective action (requires `evaluar_lucha_colectiva()`)

The evaluation functions already exist in `recursos.ink` (lines 161-180). We just need to add the routing calls.

**Step 1: Read current evaluar_final (domingo.ink:388-429)**

Current priority order:
1. `salud_mental <= 0` → `final_apagado`
2. `llama <= 0` → `final_sin_llama`
3. `vinculo == "ixchel"` + conditions → `final_tejido`
4. Perfection → `final_la_llama`
5. `conexion >= 7 && llama >= 5 && ayude_en_olla` → `final_red`
6. `conexion <= 3 && llama <= 2` → `final_solo`
7. `salud_mental <= 2 && conexion <= 4` → `final_gris`
8. `conexion >= 5` → `final_quizas`
9. Default → `final_incierto`

**Step 2: Insert the 3 new endings in the priority chain**

The new endings should be inserted BETWEEN existing ones based on their narrative weight:
- `lucha_colectiva` is stronger than `red` but less than `la_llama` → insert after `la_llama`, before `red`
- `vulnerabilidad_honesta` is a specific emotional ending → insert after `red`, before `solo`
- `pequeno_cambio` is a mild positive → insert after `gris`, before `quizas`

Replace the `evaluar_final` knot in `domingo.ink` (from line 388 to end of the knot ~line 429) with:

```ink
=== evaluar_final ===

// Evaluamos variables para determinar el final
// Los finales estan definidos en finales/finales.ink

// FINAL MÁS DURO - Colapso mental individual
{salud_mental <= 0:
    -> final_apagado
}

// FINAL DESTRUCCIÓN TEJIDO SOCIAL - Colapso colectivo
{llama <= 0:
    -> final_sin_llama
}

// FINAL IXCHEL - Requiere vínculo con Ixchel
{vinculo == "ixchel" && ixchel_relacion >= 4 && ixchel_conto_historia && ayude_en_olla:
    -> final_tejido
}

// FINAL OCULTO - Requiere perfección
{conexion >= 9 && llama >= 8 && veces_que_ayude >= 3 && participe_asamblea && marcos_vino_a_asamblea && sofia_relacion >= 4 && elena_relacion >= 4 && tiene_todas_ideas():
    -> final_la_llama
}

// FINAL LUCHA COLECTIVA - Participación activa
{evaluar_lucha_colectiva():
    -> final_lucha_colectiva
}

// FINAL RED - Comunidad como red
{conexion >= 7 && llama >= 5 && ayude_en_olla:
    -> final_red
}

// FINAL VULNERABILIDAD - Apertura emocional genuina
{evaluar_vulnerabilidad():
    -> final_vulnerabilidad_honesta
}

// FINAL SOLO - Aislamiento completo
{conexion <= 3 && llama <= 2:
    -> final_solo
}

// FINAL GRIS - Depresión y soledad
{salud_mental <= 2 && conexion <= 4:
    -> final_gris
}

// FINAL PEQUEÑO CAMBIO - Algo movió adentro
{evaluar_pequeno_cambio():
    -> final_pequeno_cambio
}

// Default: segun nivel de conexion
{conexion >= 5:
    -> final_quizas
- else:
    -> final_incierto
}
```

**Step 3: Compile and verify**

Run: `cd prototype && npm run build`
Expected: No compilation errors

**Step 4: Run ending tests**

Run: `cd prototype && npm run test:endings`
Expected: All 12 endings now have routes. The 3 previously unreachable endings should pass.

**Step 5: Commit**

```bash
git add prototype/ink/dias/domingo.ink
git commit -m "feat: connect 3 orphaned endings to evaluation router - all 12 endings reachable"
```

---

## Resumen de Tareas y Orden de Ejecución

| Task | Descripción | Archivos Principales | Tipo | Depende de |
|------|-------------|---------------------|------|-----------|
| 1 | Auditoría variables huérfanas | scripts/audit-variables.js, variables.ink | Infra | — |
| 2 | Tests de finales | scripts/test-endings.js | Infra | — |
| 3 | Completar Ixchel | jueves.ink, viernes.ink, sabado.ink | Narrativa | — |
| 4 | Ecos narrativos entre días | martes-domingo.ink | Narrativa | — |
| 5 | Preguntas trigger vínculo | main.ink | Narrativa | — |
| 6 | Feedback visual por estado | style.css, stats-panel.js, reading-preferences.js | UX/CSS | — |
| 7 | Marcos post-revelación | marcos.ink, domingo.ink | Narrativa | — |
| 8 | Conectar finales huérfanos | domingo.ink | Narrativa | Task 2 (para verificar) |

**Todas las tareas son independientes excepto:** Task 8 se beneficia de Task 2 para verificación.

**Orden recomendado:** 1 → 2 → 5 → 4 → 3 → 7 → 8 → 6

**Verificación final después de todas las tareas:**
```bash
cd prototype
npm run build          # Compilar todo
npm test               # Tests estructurales
npm run lint           # Lint de Ink
npm run test:endings   # Tests de finales
npm run audit          # Auditoría de variables
```

---

## Notas para el Implementador

1. **Compilar después de cada task.** El compilador de Ink detecta diverts rotos, variables no declaradas, y tunnels mal cerrados. Es tu primera línea de defensa.

2. **No declarar VAR fuera de variables.ink o mecanicas/.** Ink no permite duplicación de VAR — el compilador falla.

3. **Los tunnels (`->->`) deben cerrar.** Si usás `-> knot ->` (tunnel), el knot llamado DEBE terminar con `->->`. Si termina con `-> otro_knot`, rompe el stack.

4. **Estilo de escritura:**
   - Frases cortas. Sin puntos finales en líneas sueltas.
   - Voseo uruguayo ("vos tenés", "mirá", "decí")
   - Sin emojis en el texto narrativo (los emojis van en la UI, no en Ink)
   - Nombres en minúscula en diálogos

5. **Tags de Ink:** Los tags `#` son procesados por game.js. Los tags conocidos son: `LUNES`-`DOMINGO`, `STAT_THRESHOLD`, `IDEA:`, `ENDING:`, `AUDIO:`, `PORTRAIT:`, `COSTO:`, `DADOS`, `EFECTO:`, `FALSA`, `TOOLTIP:`, `CONTINUAR:`, `DISABLED`, `MIENTRAS:`.

6. **Variables booleanas de Ixchel:** Para que `final_tejido` funcione, el jugador necesita: `ixchel_relacion >= 4` AND `ixchel_conto_historia == true` AND `ayude_en_olla == true`. La Task 3 asegura que esto sea alcanzable.
