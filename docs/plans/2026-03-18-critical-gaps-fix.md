# Critical Gaps Fix - Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Fix the four critical gaps identified in the project audit: vínculo system underutilization, dignidad invisible feedback, XSS vulnerabilities in web runtime, and vínculo rescue parity for Juan/Ixchel.

**Architecture:** Each gap is addressed as an independent task group. Ink narrative changes follow existing patterns (threshold feedback in recursos.ink, conditional branching in dias/). Web security fixes refactor innerHTML usage to DOM construction and harden SecurityValidator. All changes maintain backward compatibility with existing save data.

**Tech Stack:** Ink (Inkle), vanilla JavaScript (IIFE modules), CSS, inklecate compiler

---

## Task Group 1: Dignidad Threshold Feedback

**Problem:** Dignidad is the only core resource (0-10) without narrative threshold feedback. Conexión has text at ≥5, ≥7, ≤2. Llama has text at ≥5, ≥7, ≤2. Inercia has STAT_THRESHOLD tags at ≥5, ≥8, ≤2. Dignidad has nothing — changes are invisible to the player.

### Task 1.1: Add threshold feedback to subir_dignidad()

**Files:**
- Modify: `prototype/ink/mecanicas/recursos.ink:89-90`

**Step 1: Add threshold text to subir_dignidad**

Replace the current silent function:

```ink
=== function subir_dignidad(cantidad) ===
    ~ ajustar(dignidad, cantidad, 0, 10)
```

With threshold-aware version (follows exact pattern of subir_conexion at line 61):

```ink
=== function subir_dignidad(cantidad) ===
    ~ temp dignidad_antes = dignidad
    ~ ajustar(dignidad, cantidad, 0, 10)
    // Feedback narrativo en thresholds
    {
    - dignidad >= 8 && dignidad_antes < 8:
        # STAT_THRESHOLD
        Algo vuelve.
        No es orgullo. Es algo más tranquilo.
        Te reconocés.
    - dignidad >= 5 && dignidad_antes < 5:
        # STAT_THRESHOLD
        Todavía estás acá.
        Eso ya es algo.
    }
```

**Step 2: Compile and verify**

Run: `cd /home/victor/Exp/un-dia-mas/prototype && npm run build`
Expected: Compiles without errors

**Step 3: Run tests**

Run: `cd /home/victor/Exp/un-dia-mas/prototype && npm test`
Expected: All 43 tests pass

**Step 4: Commit**

```bash
git add prototype/ink/mecanicas/recursos.ink
git commit -m "feat(ink): add threshold feedback to subir_dignidad()"
```

### Task 1.2: Add threshold feedback to bajar_dignidad()

**Files:**
- Modify: `prototype/ink/mecanicas/recursos.ink:92-93`

**Step 1: Add threshold text to bajar_dignidad**

Replace:

```ink
=== function bajar_dignidad(cantidad) ===
    ~ ajustar(dignidad, -cantidad, 0, 10)
```

With (follows pattern of bajar_conexion at line 77):

```ink
=== function bajar_dignidad(cantidad) ===
    ~ temp dignidad_antes = dignidad
    ~ ajustar(dignidad, -cantidad, 0, 10)
    // Feedback narrativo en thresholds críticos
    {
    - dignidad <= 2 && dignidad_antes > 2:
        # STAT_THRESHOLD
        Algo se rompe adentro.
        No es que no valés. Es que empezás a creerlo.
    }
```

**Step 2: Compile and verify**

Run: `cd /home/victor/Exp/un-dia-mas/prototype && npm run build`
Expected: Compiles without errors

**Step 3: Run tests**

Run: `cd /home/victor/Exp/un-dia-mas/prototype && npm test`
Expected: All tests pass

**Step 4: Commit**

```bash
git add prototype/ink/mecanicas/recursos.ink
git commit -m "feat(ink): add threshold feedback to bajar_dignidad()"
```

### Task 1.3: Add evaluar_dignidad_nocturna narrative feedback

**Files:**
- Modify: `prototype/ink/mecanicas/recursos.ink:264-272`

**Step 1: Add player-visible text to nightly dignity evaluation**

The current function silently modifies inercia. Add narrative context so the player understands WHY inercia changed:

Replace:

```ink
=== function evaluar_dignidad_nocturna() ===
    // Baja dignidad aumenta inercia (si no tiene idea protectora)
    { dignidad <= 2 && not idea_pedir_no_debilidad:
        ~ aumentar_inercia(1)
    }
    // Alta dignidad reduce inercia
    { dignidad >= 8:
        ~ disminuir_inercia(1)
    }
```

With:

```ink
=== function evaluar_dignidad_nocturna() ===
    // Baja dignidad aumenta inercia (si no tiene idea protectora)
    { dignidad <= 2 && not idea_pedir_no_debilidad:
        ~ aumentar_inercia(1)
        # NOTIFICATION:negative:La vergüenza pesa
    }
    // Alta dignidad reduce inercia
    { dignidad >= 8:
        ~ disminuir_inercia(1)
        # NOTIFICATION:positive:Dormís más tranquilo
    }
```

**Step 2: Compile and test**

Run: `cd /home/victor/Exp/un-dia-mas/prototype && npm run build && npm test`
Expected: Build succeeds, all tests pass

**Step 3: Commit**

```bash
git add prototype/ink/mecanicas/recursos.ink
git commit -m "feat(ink): add notifications to evaluar_dignidad_nocturna()"
```

---

## Task Group 2: XSS Vulnerability Fixes

**Problem:** `parseGlosa()` in text-presenter.js builds HTML via regex string replacement without escaping. 33 innerHTML usages across modules. SecurityValidator has fallback paths that skip sanitization. No CSP header.

### Task 2.1: Create escapeHTML utility in SecurityValidator

**Files:**
- Modify: `prototype/web/modules/security-validator.js`

**Step 1: Add escapeHTML and escapeAttr functions**

Add before the `return` statement (before line 136):

```javascript
    /**
     * Escape string for safe use in HTML attributes
     * @param {string} str - Raw string
     * @returns {string} Escaped string safe for attribute values
     */
    function escapeAttr(str) {
        if (typeof str !== 'string') return '';
        return str
            .replace(/&/g, '&amp;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#39;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;');
    }

    /**
     * Escape string for safe use as HTML text content
     * @param {string} str - Raw string
     * @returns {string} Escaped string safe for text content
     */
    function escapeHTML(str) {
        if (typeof str !== 'string') return '';
        return str
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;');
    }
```

Update the public API return to include the new functions:

```javascript
    return {
        sanitizeHTML,
        sanitizeText,
        escapeAttr,
        escapeHTML,
        validateSaveData,
        checkStorageQuota,
        safeJSONParse
    };
```

**Step 2: Verify module loads**

Open the game in browser, check console for errors. Verify `SecurityValidator.escapeAttr('"test"')` returns `&quot;test&quot;`.

**Step 3: Commit**

```bash
git add prototype/web/modules/security-validator.js
git commit -m "feat(security): add escapeAttr and escapeHTML to SecurityValidator"
```

### Task 2.2: Fix parseGlosa XSS vulnerability

**Files:**
- Modify: `prototype/web/modules/text-presenter.js:121-126`

**Step 1: Refactor parseGlosa to use DOM-safe construction**

Replace the current `parseGlosa` function:

```javascript
    function parseGlosa(text) {
        if (!text) return '';
        return text.replace(/\[(.*?)\|(.*?)\]/g, (match, term, def) => {
            return `<span class="glossary-term" tabindex="0" aria-label="${def}">${term}<span class="glossary-tooltip">${def}</span></span>`;
        });
    }
```

With escaped version:

```javascript
    function parseGlosa(text) {
        if (!text) return '';
        // Sanitize the base text first
        const safeText = typeof SecurityValidator !== 'undefined'
            ? SecurityValidator.sanitizeHTML(text)
            : text;
        // Then process glossary markup with escaped values
        return safeText.replace(/\[(.*?)\|(.*?)\]/g, (match, term, def) => {
            const safeTerm = typeof SecurityValidator !== 'undefined'
                ? SecurityValidator.escapeHTML(term) : term;
            const safeDef = typeof SecurityValidator !== 'undefined'
                ? SecurityValidator.escapeAttr(def) : def;
            const safeDefHTML = typeof SecurityValidator !== 'undefined'
                ? SecurityValidator.escapeHTML(def) : def;
            return `<span class="glossary-term" tabindex="0" aria-label="${safeDef}">${safeTerm}<span class="glossary-tooltip">${safeDefHTML}</span></span>`;
        });
    }
```

**Step 2: Test glossary rendering**

Open the game and navigate to a scene with glossary terms (e.g., `[olla popular|Comedor comunitario]`). Verify:
- Term displays correctly with dotted underline
- Hover shows tooltip with definition
- No console errors

**Step 3: Commit**

```bash
git add prototype/web/modules/text-presenter.js
git commit -m "fix(security): escape glossary content in parseGlosa to prevent XSS"
```

### Task 2.3: Remove innerHTML fallback paths in game.js

**Files:**
- Modify: `prototype/web/game.js` (lines where `SecurityValidator` has fallback)

**Step 1: Find and fix all conditional sanitization**

Search game.js for the pattern `typeof SecurityValidator !== 'undefined'` and ensure the fallback path also escapes. Replace each instance of:

```javascript
const safeContent = typeof SecurityValidator !== 'undefined'
    ? SecurityValidator.sanitizeHTML(item.content)
    : item.content;
```

With a safe fallback:

```javascript
const safeContent = typeof SecurityValidator !== 'undefined'
    ? SecurityValidator.sanitizeHTML(item.content)
    : item.content.replace(/</g, '&lt;').replace(/>/g, '&gt;');
```

Apply this pattern to every conditional sanitization instance in game.js.

**Step 2: Verify game loads and renders text**

Open the game and play through the first day. Verify text renders correctly, choices work, and no console errors appear.

**Step 3: Commit**

```bash
git add prototype/web/game.js
git commit -m "fix(security): add safe fallback for missing SecurityValidator in game.js"
```

### Task 2.4: Fix choice-parser tooltip injection

**Files:**
- Modify: `prototype/web/modules/choice-parser.js`

**Step 1: Escape tooltip attribute value**

Find the tooltip assignment (around line 208):

```javascript
if (meta.tooltip) {
    button.title = meta.tooltip;
}
```

This is actually safe because `.title` is a DOM property (not innerHTML). However, verify that `buildLabel` uses escapeHTML for badge content. Search for any raw string interpolation in badge HTML and ensure `SecurityValidator.escapeHTML()` is applied.

**Step 2: Verify choice rendering**

Play to a scene with choice badges (COSTO, EFECTO, DADOS). Verify they display correctly.

**Step 3: Commit if changes were needed**

```bash
git add prototype/web/modules/choice-parser.js
git commit -m "fix(security): harden choice-parser against injection"
```

### Task 2.5: Add Content Security Policy

**Files:**
- Modify: `prototype/web/index.html`

**Step 1: Add CSP meta tag**

Add after the `<meta charset>` line in `<head>`:

```html
<meta http-equiv="Content-Security-Policy" content="default-src 'self'; script-src 'self' 'unsafe-inline' https://unpkg.com https://cdnjs.cloudflare.com; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com https://cdnjs.cloudflare.com; font-src 'self' https://fonts.gstatic.com https://cdnjs.cloudflare.com https://cdn.jsdelivr.net; img-src 'self' data:; connect-src 'self';">
```

Note: `'unsafe-inline'` is needed for inline scripts/styles currently used. This can be tightened in future by moving to external files.

**Step 2: Test the game loads correctly**

Open in browser, verify:
- No CSP violations in console (or only expected ones)
- Fonts load (Google Fonts, CDN fonts)
- Lucide icons load (unpkg.com)
- Game functions normally

**Step 3: Commit**

```bash
git add prototype/web/index.html
git commit -m "feat(security): add Content-Security-Policy header"
```

### Task 2.6: Run full test suite

**Step 1: Run all tests**

```bash
cd /home/victor/Exp/un-dia-mas/prototype
npm test
npm run lint
npm run test:endings
```

Expected: All pass

**Step 2: Compile and verify**

```bash
npm run build
```

Expected: Build succeeds

---

## Task Group 3: Vínculo System Enhancement

**Problem:** The vínculo system assigns one of 5 NPCs (sofia/elena/diego/marcos/ixchel) as the player's special bond but creates almost no differentiated experience. Juan/Ixchel are also missing from game-over rescue and several ending texts.

### Task 3.1: Add vínculo-differentiated first encounters

**Files:**
- Modify: `prototype/ink/dias/lunes.ink` (wherever `lunes_visita_vinculo` is called)

**Step 1: Add vínculo-specific greeting text to first encounters**

Find the first vínculo encounter in lunes.ink and add conditional text that acknowledges the bond. This should be subtle — not a new scene, but a different opening line:

```ink
// Add at the start of each NPC's first encounter scene
// Example for sofia's encounter:
{ vinculo == "sofia":
    Hay algo familiar. Como si ya se conocieran de antes.
}
```

Add this pattern to:
- `sofia_encuentro_casual` or equivalent first scene in sofia.ink
- `elena_encuentro_casual` or equivalent in elena.ink
- `diego_encuentro_casual` or equivalent in diego.ink
- `marcos_encuentro_casual` or equivalent in marcos.ink
- `ixchel_encuentro_casual` or equivalent in ixchel.ink

Each greeting should be 1-2 lines, unique to the character, reflecting the pre-existing bond.

**Step 2: Compile and test**

Run: `cd /home/victor/Exp/un-dia-mas/prototype && npm run build && npm test`

**Step 3: Commit**

```bash
git add prototype/ink/personajes/sofia.ink prototype/ink/personajes/elena.ink prototype/ink/personajes/diego.ink prototype/ink/personajes/marcos.ink prototype/ink/personajes/ixchel.ink
git commit -m "feat(ink): add vínculo-differentiated first encounter greetings"
```

### Task 3.2: Add vínculo rescue parity for Juan and Ixchel

**Files:**
- Modify: `prototype/ink/mecanicas/recursos.ink:191-206`

**Step 1: Add Juan and Ixchel to check_game_over rescue**

In the `check_game_over` knot (line 191), after the marcos check (line 202-204), add:

```ink
    { vinculo == "juan" && juan_relacion >= 3:
        -> intervencion_vinculo ->
    }
    { vinculo == "ixchel" && ixchel_relacion >= 3:
        -> intervencion_vinculo ->
    }
```

**Step 2: Add Juan and Ixchel to intervencion_vinculo text**

In the `intervencion_vinculo` knot (line 219), after the marcos block (line 237), add:

```ink
{ vinculo == "juan":
    Es Juan.
    "Che, ¿estás bien? Me llegó que andabas mal."
}
{ vinculo == "ixchel":
    Es Ixchel.
    "Hermano, te estuve buscando. Vine a verte."
}
```

**Step 3: Compile and test**

Run: `cd /home/victor/Exp/un-dia-mas/prototype && npm run build && npm test`

**Step 4: Commit**

```bash
git add prototype/ink/mecanicas/recursos.ink
git commit -m "feat(ink): add Juan and Ixchel to vínculo rescue system"
```

### Task 3.3: Add Juan and Ixchel to ending acknowledgment

**Files:**
- Modify: `prototype/ink/finales/finales.ink` (around line 1014-1017)

**Step 1: Find the final_despertar vínculo text and add missing characters**

After the existing marcos line, add:

```ink
{vinculo == "juan": Juan no se olvidó. Desde España, mandó un mensaje.}
{vinculo == "ixchel": Ixchel te trajo comida. Sin decir nada. Se sentó a tu lado.}
```

**Step 2: Compile and test**

Run: `cd /home/victor/Exp/un-dia-mas/prototype && npm run build && npm test && npm run test:endings`

**Step 3: Commit**

```bash
git add prototype/ink/finales/finales.ink
git commit -m "feat(ink): add Juan and Ixchel to final_despertar vínculo text"
```

### Task 3.4: Add vínculo-specific night fragment intro text

**Files:**
- Modify: `prototype/ink/fragmentos/fragmentos.ink` (around line 31-44)

**Step 1: Add a brief vínculo acknowledgment before each fragment dispatch**

Before the fragment dispatch, add a line that marks the vínculo connection:

```ink
=== fragmento_nocturno ===
// Vínculo intro - sutil acknowledgment de la conexión especial
{ vinculo != "":
    ~ temp vinculo_nombre = ""
    { vinculo == "sofia": ~ vinculo_nombre = "Sofía" }
    { vinculo == "elena": ~ vinculo_nombre = "Elena" }
    { vinculo == "diego": ~ vinculo_nombre = "Diego" }
    { vinculo == "marcos": ~ vinculo_nombre = "Marcos" }
    { vinculo == "juan": ~ vinculo_nombre = "Juan" }
    { vinculo == "ixchel": ~ vinculo_nombre = "Ixchel" }
}
```

Note: This task is OPTIONAL. The fragment system already dispatches based on vínculo, which IS the differentiation. Evaluate if additional intro text is needed or if the existing system is sufficient. If not needed, skip this task.

**Step 2: Compile and test if changes made**

**Step 3: Commit if changes made**

### Task 3.5: Update variables.ink vínculo comment

**Files:**
- Modify: `prototype/ink/variables.ink:207`

**Step 1: Fix stale comment**

Replace:

```ink
VAR vinculo = ""      // sofia, elena, diego
```

With:

```ink
VAR vinculo = ""      // sofia, elena, diego, marcos, ixchel, juan
```

**Step 2: Commit**

```bash
git add prototype/ink/variables.ink
git commit -m "docs(ink): update vinculo comment to list all valid options"
```

---

## Task Group 4: Verify Marcos State Machine Integration

**Problem:** Initial audit flagged Marcos as "40% complete" but deep dive revealed the arc is actually 100% feature-complete with 61 knots. However, the state machine transitions in dias/ files need verification.

### Task 4.1: Verify Marcos state transitions are triggered from dias/

**Files:**
- Read: `prototype/ink/dias/lunes.ink`, `martes.ink`, `miercoles.ink`, `jueves.ink`, `viernes.ink`, `sabado.ink`, `domingo.ink`
- Read: `prototype/ink/personajes/marcos.ink`

**Step 1: Map every marcos reference in dias/ files**

Search all dias/ files for "marcos" and verify:

1. **Lunes**: `lunes_visita_marcos` calls `marcos_no_esta` or `marcos_contesta` — VERIFY the tunnel exists and routes correctly
2. **Martes**: `martes_buscar_marcos` — VERIFY call target exists
3. **Miércoles**: `miercoles_llamar_marcos` — VERIFY call target exists
4. **Jueves**: `jueves_marcos` → `marcos_no_esta` — VERIFY tunnel returns
5. **Sábado**: `sabado_marcos` → `marcos_contesta` → encounter chain — VERIFY the chain:
   - `marcos_encuentro_plaza` → `marcos_revelar_despido` → sets `marcos_estado = "mirando"`
   - `marcos_invitar_asamblea` → sets `marcos_vino_a_asamblea`
6. **Domingo**: `domingo_llamar_marcos` → `marcos_llamar` — VERIFY state-dependent responses work

**Step 2: Run structural tests**

```bash
cd /home/victor/Exp/un-dia-mas/prototype && npm test && npm run lint
```

Verify: no broken divert targets related to marcos

**Step 3: Document findings**

If all transitions verified, no code changes needed. If gaps found, fix them.

**Step 4: Commit any fixes**

```bash
git commit -m "fix(ink): verify and fix Marcos state machine transitions"
```

---

## Task Group 5: Final Verification

### Task 5.1: Full compilation and test suite

**Step 1: Clean build**

```bash
cd /home/victor/Exp/un-dia-mas/prototype
npm run clean
npm run build
```

**Step 2: Run all tests**

```bash
npm test
npm run lint
npm run test:endings
npm run audit
```

Expected: All pass. Variable audit may show new variables as healthy.

**Step 3: Verify game plays correctly**

Open `prototype/web/index.html` in browser and:
1. Start new game
2. Select different vínculos
3. Play through at least day 1-2
4. Verify dignidad changes show notifications
5. Verify glossary terms render correctly without console errors
6. Check CSP doesn't block any resources

---

## Summary

| Task Group | Tasks | Estimated Complexity |
|------------|-------|---------------------|
| 1. Dignidad Feedback | 3 tasks | Low — follows existing patterns exactly |
| 2. XSS Fixes | 6 tasks | Medium — refactoring existing JS |
| 3. Vínculo Enhancement | 5 tasks | Medium — Ink content + rescue parity |
| 4. Marcos Verification | 1 task | Low — read and verify, fix if needed |
| 5. Final Verification | 1 task | Low — compilation + testing |

**Total: 16 tasks across 5 groups**

**Dependencies:** Group 2 (XSS) has internal ordering (2.1 before 2.2). All other groups are independent and can be parallelized.
