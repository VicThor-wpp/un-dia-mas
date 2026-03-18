# UX/Design Polish - Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Elevate the game's presentation from functional to polished: complete the portrait system with assets for all 11 NPCs, activate the dormant audio system, add pacing controls for player comfort, and implement replay incentives (achievements, returning-player recognition, ending guide).

**Architecture:** All changes build on existing infrastructure — the portrait system (306-line JS module + CSS + config), audio system (279-line JS module + config), TextPresenter pacing, and EndingScreen meta-tracking are already implemented. This plan fills the gaps with content, assets, and small feature additions. No new architectural patterns needed.

**Tech Stack:** Ink (narrative tags), vanilla JavaScript (IIFE modules), CSS, SVG/PNG assets, MP3 audio, JSON config

---

## Task Group 1: Complete Portrait System

**Current state:** 22 portrait PNGs exist for 5 NPCs (Sofia, Elena, Diego, Marcos, Juan). PortraitSystem.js is fully implemented with show/hide/expression/speaking. Only 14 `# PORTRAIT:` tags exist in Ink files, all in jueves.ink and a few personajes/ files. 6 NPCs have zero assets: Ixchel, Lucía, Tiago, Cacho, Bruno, Claudia.

### Task 1.1: Generate portrait assets for missing NPCs

**Files:**
- Create: `prototype/web/assets/portraits/ixchel/neutral.png`
- Create: `prototype/web/assets/portraits/ixchel/teaching.png`
- Create: `prototype/web/assets/portraits/ixchel/remembering.png`
- Create: `prototype/web/assets/portraits/ixchel/warm.png`
- Create: `prototype/web/assets/portraits/lucia/neutral.png`
- Create: `prototype/web/assets/portraits/lucia/determined.png`
- Create: `prototype/web/assets/portraits/lucia/worried.png`
- Create: `prototype/web/assets/portraits/tiago/neutral.png`
- Create: `prototype/web/assets/portraits/tiago/guarded.png`
- Create: `prototype/web/assets/portraits/tiago/scared.png`
- Create: `prototype/web/assets/portraits/cacho/neutral.png`
- Create: `prototype/web/assets/portraits/cacho/scheming.png`
- Create: `prototype/web/assets/portraits/cacho/vulnerable.png`
- Create: `prototype/web/assets/portraits/bruno/neutral.png`
- Create: `prototype/web/assets/portraits/bruno/threatening.png`
- Create: `prototype/web/assets/portraits/claudia/neutral.png`
- Create: `prototype/web/assets/portraits/claudia/cold.png`

**Step 1: Decide art style**

Check existing portraits to match style:
```bash
file prototype/web/assets/portraits/sofia/neutral.png
identify prototype/web/assets/portraits/sofia/neutral.png  # if imagemagick installed
```

Review existing art: all portraits are ~3-5KB PNGs. Match the existing style (likely simple/minimalist given file size). If AI-generated or hand-drawn, maintain consistency.

**Step 2: Create directory structure**

```bash
mkdir -p prototype/web/assets/portraits/{ixchel,lucia,tiago,cacho,bruno,claudia}
```

**Step 3: Generate or commission portraits**

Options:
- A) Use same tool/process that created existing portraits
- B) Create SVG placeholders with character initials as temporary stand-ins
- C) Commission an artist

For placeholder approach (option B), create simple colored circle avatars:

```bash
# Example SVG placeholder - repeat for each character/expression
# Use character colors from characters.json
```

**Step 4: Verify portraits load in PortraitSystem**

Open browser console and test:
```javascript
PortraitSystem.show('ixchel', 'neutral', 'right');
PortraitSystem.show('bruno', 'threatening', 'left');
```

**Step 5: Commit assets**

```bash
git add prototype/web/assets/portraits/
git commit -m "feat(assets): add portrait images for all NPCs"
```

### Task 1.2: Add missing NPCs to characters.json config

**Files:**
- Modify: `prototype/web/config/characters.json`

**Step 1: Add Ixchel, Lucía, Tiago, Cacho, Bruno, Claudia entries**

Add after the "juan" entry (before `"display"`):

```json
    "ixchel": {
      "name": "Ixchel",
      "role": "La que teje",
      "description": "Maya-K'iche'. Sabe cosas que olvidamos.",
      "color": "#c49b6a",
      "relationVar": "ixchel_relacion",
      "stateVar": "ixchel_estado",
      "states": {
        "observando": { "label": "Observando", "color": "#2196f3" },
        "enseñando": { "label": "Enseñando", "color": "#4caf50" },
        "recordando": { "label": "Recordando", "color": "#9c27b0" }
      },
      "portrait": "assets/portraits/ixchel",
      "expressions": ["neutral", "teaching", "remembering", "warm"]
    },
    "lucia": {
      "name": "Lucía",
      "role": "La delegada",
      "description": "Sindicalista. Sigue peleando.",
      "color": "#d45d5d",
      "relationVar": "lucia_relacion",
      "stateVar": "lucia_estado",
      "states": {
        "activa": { "label": "Activa", "color": "#4caf50" },
        "luchando": { "label": "Luchando", "color": "#f44336" }
      },
      "portrait": "assets/portraits/lucia",
      "expressions": ["neutral", "determined", "worried"]
    },
    "tiago": {
      "name": "Tiago",
      "role": "El pibe",
      "description": "Calle. Desconfianza. Futuro incierto.",
      "color": "#8bc34a",
      "relationVar": "tiago_confianza",
      "stateVar": "tiago_estado",
      "states": {
        "desconfiado": { "label": "Desconfiado", "color": "#ff9800" },
        "abierto": { "label": "Abierto", "color": "#4caf50" },
        "captado": { "label": "En riesgo", "color": "#f44336" }
      },
      "portrait": "assets/portraits/tiago",
      "expressions": ["neutral", "guarded", "scared"]
    },
    "cacho": {
      "name": "Cacho",
      "role": "El iluso",
      "description": "Cripto, LinkedIn, changas. Siempre tiene un plan.",
      "color": "#ffb74d",
      "relationVar": "cacho_relacion",
      "stateVar": "cacho_estado",
      "states": {
        "negociando": { "label": "Negociando", "color": "#ff9800" },
        "vulnerable": { "label": "Vulnerable", "color": "#9e9e9e" }
      },
      "portrait": "assets/portraits/cacho",
      "expressions": ["neutral", "scheming", "vulnerable"]
    },
    "bruno": {
      "name": "Bruno",
      "role": "El apóstol",
      "description": "Orden. Control. Su chacra, sus reglas.",
      "color": "#795548",
      "relationVar": "bruno_tension",
      "stateVar": "bruno_estado",
      "states": {
        "acechando": { "label": "Acechando", "color": "#f44336" },
        "presionando": { "label": "Presionando", "color": "#9b2335" }
      },
      "portrait": "assets/portraits/bruno",
      "expressions": ["neutral", "threatening"]
    },
    "claudia": {
      "name": "Claudia",
      "role": "La auditora",
      "description": "Formularios. Plazos. Un Excel con tu nombre.",
      "color": "#78909c",
      "relationVar": "claudia_hostilidad",
      "stateVar": "claudia_estado",
      "states": {
        "auditando": { "label": "Auditando", "color": "#ff9800" },
        "presionando": { "label": "Presionando", "color": "#f44336" }
      },
      "portrait": "assets/portraits/claudia",
      "expressions": ["neutral", "cold"]
    },
```

**Step 2: Verify JSON is valid**

```bash
cd /home/victor/Exp/un-dia-mas/prototype/web
node -e "JSON.parse(require('fs').readFileSync('config/characters.json','utf8')); console.log('Valid JSON')"
```

**Step 3: Commit**

```bash
git add prototype/web/config/characters.json
git commit -m "feat(config): add all 11 NPCs to characters.json with portrait config"
```

### Task 1.3: Add PORTRAIT tags to key NPC scenes in Ink

**Files:**
- Modify: `prototype/ink/personajes/sofia.ink`
- Modify: `prototype/ink/personajes/elena.ink`
- Modify: `prototype/ink/personajes/diego.ink`
- Modify: `prototype/ink/personajes/marcos.ink`
- Modify: `prototype/ink/personajes/juan.ink`
- Modify: `prototype/ink/personajes/ixchel.ink`
- Modify: `prototype/ink/personajes/bruno.ink`
- Modify: `prototype/ink/personajes/claudia.ink`
- Modify: `prototype/ink/personajes/tiago.ink`
- Modify: `prototype/ink/personajes/cacho.ink`

**Step 1: Add PORTRAIT tags to NPC encounter scenes**

For each NPC, add `# PORTRAIT:` tags at key emotional moments. Pattern:

```ink
// At the start of an encounter:
# PORTRAIT:sofia,neutral,right

// When emotion changes:
# EXPRESSION:sofia,tired

// When speaking:
# SPEAKING:sofia

// At end of encounter:
# HIDE_PORTRAIT:sofia
```

**Target: 3-5 PORTRAIT tags per NPC file**, placed at:
1. First encounter (neutral expression)
2. Emotional peak (appropriate expression)
3. Scene exit (HIDE_PORTRAIT)

**Priority NPCs (have assets already):**
- Sofia: encounters → neutral, tired, worried, sad, happy
- Elena: banco conversation → neutral, wise, remembering, worried
- Diego: olla work → neutral, curious, hopeful, worried
- Marcos: plaza → neutral, distant, opening, bitter
- Juan: workplace → neutral, friendly, worried, distant

**New NPCs (need assets from Task 1.1):**
- Ixchel: olla teaching → neutral, teaching, warm
- Bruno: threat scenes → neutral, threatening
- Claudia: audit → neutral, cold
- Tiago: street → neutral, guarded, scared
- Cacho: encounter → neutral, scheming, vulnerable
- Lucía: workplace → neutral, determined

**Step 2: Compile and test**

```bash
cd /home/victor/Exp/un-dia-mas/prototype && npm run build && npm test
```

**Step 3: Verify portraits appear in-game**

Open browser, play to an NPC encounter, verify portrait appears at bottom with correct expression.

**Step 4: Commit**

```bash
git add prototype/ink/personajes/*.ink
git commit -m "feat(ink): add PORTRAIT tags to all NPC encounter scenes"
```

---

## Task Group 2: Activate Audio System

**Current state:** AudioSystem module (279 lines) is complete but in "logging mode" — playback lines are commented out. audio-config.json maps 7 BGM tracks and 10 SFX names. No audio files exist. No `# AUDIO:` tags in Ink files.

### Task 2.1: Source or create audio assets

**Files:**
- Create: `prototype/web/assets/audio/` directory
- Create: 7 BGM files + 10 SFX files

**Step 1: Create audio directory**

```bash
mkdir -p prototype/web/assets/audio
```

**Step 2: Source audio files**

Required tracks (from audio-config.json):

| File | Mood | Duration | Notes |
|------|------|----------|-------|
| `bgm_rutina.mp3` | neutral | 2-3 min loop | Monday office routine |
| `bgm_tension.mp3` | tension | 2-3 min loop | Tuesday rumors |
| `bgm_despido.mp3` | dark | 2-3 min loop | Wednesday firing |
| `bgm_vacio.mp3` | melancholy | 2-3 min loop | Thursday emptiness |
| `bgm_crisis.mp3` | urgent | 2-3 min loop | Friday olla crisis |
| `bgm_asamblea.mp3` | hopeful | 2-3 min loop | Saturday assembly |
| `bgm_reflexion.mp3` | contemplative | 2-3 min loop | Sunday reflection |
| `sfx_dados.mp3` | - | <1 sec | Dice roll sound |
| `sfx_exito.mp3` | positive | <1 sec | Success chime |
| `sfx_fallo.mp3` | negative | <1 sec | Failure thud |
| `sfx_critico.mp3` | dramatic | <1 sec | Critical result |
| `sfx_subida.mp3` | positive | <1 sec | Stat increase |
| `sfx_bajada.mp3` | negative | <1 sec | Stat decrease |
| `sfx_idea.mp3` | ethereal | <2 sec | Idea unlock |
| `sfx_guardar.mp3` | neutral | <1 sec | Save confirmation |
| `sfx_final.mp3` | dramatic | 3-5 sec | Ending transition |
| `sfx_notificacion.mp3` | neutral | <1 sec | Toast notification |

**Sources for royalty-free audio:**
- freesound.org (CC0/CC-BY)
- incompetech.com (Kevin MacLeod, CC-BY)
- opengameart.org
- Custom composition

**Target file size:** BGM ≤ 500KB each (128kbps), SFX ≤ 50KB each

**Step 3: Place files and verify**

```bash
ls -la prototype/web/assets/audio/
# Should show 17 files, all .mp3
```

**Step 4: Commit**

```bash
git add prototype/web/assets/audio/
git commit -m "feat(assets): add BGM and SFX audio files"
```

### Task 2.2: Uncomment audio playback in AudioSystem

**Files:**
- Modify: `prototype/web/modules/audio-system.js`

**Step 1: Find and uncomment BGM playback (around lines 152-154)**

Replace:
```javascript
// Note: actual audio files not included yet
// bgmElement.src = `assets/audio/${track}.mp3`;
// bgmElement.play().catch(e => {});
```

With:
```javascript
bgmElement.src = `assets/audio/${track}.mp3`;
bgmElement.play().catch(e => {
    console.log('[AudioSystem] BGM autoplay blocked - waiting for user interaction');
});
```

**Step 2: Find and uncomment SFX playback (around lines 169-171)**

Replace:
```javascript
// Note: actual audio files not included yet
// sfxElement.src = `assets/audio/${track}.mp3`;
// sfxElement.play().catch(e => {});
```

With:
```javascript
sfxElement.src = `assets/audio/${track}.mp3`;
sfxElement.play().catch(e => {
    console.log('[AudioSystem] SFX play failed:', e.message);
});
```

**Step 3: Test in browser**

Open the game. Audio should:
- Start playing when first day begins (bgm_rutina)
- Change tracks on day transitions
- Be toggleable via Reading Preferences
- Respect saved volume preferences

Note: Browser autoplay policies may block audio until first user interaction. This is handled by the .catch().

**Step 4: Commit**

```bash
git add prototype/web/modules/audio-system.js
git commit -m "feat(audio): activate BGM and SFX playback"
```

### Task 2.3: Add AUDIO tags to Ink narratives

**Files:**
- Modify: `prototype/ink/dias/lunes.ink`
- Modify: `prototype/ink/dias/martes.ink`
- Modify: `prototype/ink/dias/miercoles.ink`
- Modify: `prototype/ink/dias/jueves.ink`
- Modify: `prototype/ink/dias/viernes.ink`
- Modify: `prototype/ink/dias/sabado.ink`
- Modify: `prototype/ink/dias/domingo.ink`
- Modify: `prototype/ink/mecanicas/dados.ink`

**Step 1: Add BGM tags at day transitions**

Note: game.js already handles day BGM transitions via the day name tag detection (line 223). Verify this works by checking that each day file emits day name tags (e.g., `# LUNES`). If already present, no BGM tags needed in Ink.

**Step 2: Add SFX tags at key narrative moments**

Add `# AUDIO:sfx_name` tags at:

```ink
// In dados.ink - after dice roll result
# AUDIO:sfx_dados

// After critical success
# AUDIO:sfx_critico

// In mecanicas/ideas.ink - when idea unlocks
# AUDIO:sfx_idea

// In finales/finales.ink - at ending trigger
# AUDIO:sfx_final
```

**Step 3: Compile and test**

```bash
cd /home/victor/Exp/un-dia-mas/prototype && npm run build && npm test
```

**Step 4: Commit**

```bash
git add prototype/ink/dias/*.ink prototype/ink/mecanicas/dados.ink prototype/ink/mecanicas/ideas.ink prototype/ink/finales/finales.ink
git commit -m "feat(ink): add AUDIO tags for SFX at key narrative moments"
```

### Task 2.4: Integrate SFX with notification system

**Files:**
- Modify: `prototype/web/modules/notification-system.js`

**Step 1: Add SFX triggers to notification types**

Find the notification `show()` function and add AudioSystem calls based on type:

```javascript
// After creating the notification element, add:
if (typeof AudioSystem !== 'undefined' && AudioSystem.isEnabled()) {
    switch(type) {
        case 'positive':
        case 'success':
        case 'dice-success':
            AudioSystem.playSFX('stat_up');
            break;
        case 'negative':
        case 'error':
        case 'dice-fail':
            AudioSystem.playSFX('stat_down');
            break;
    }
}
```

**Step 2: Test in browser**

Trigger a stat change (play the game and make a choice with EFECTO tag). Verify sound plays with notification.

**Step 3: Commit**

```bash
git add prototype/web/modules/notification-system.js
git commit -m "feat(audio): integrate SFX with notification system"
```

---

## Task Group 3: Pacing Controls

**Current state:** TextPresenter uses automatic flow with calculated delays (400ms base + 50ms/word, max 2500ms). Skip via click/Space/Enter. No click-to-continue mode. Typewriter effect exists but is disabled. No reduced-motion beyond `prefersReducedMotion()` check.

### Task 3.1: Add pacing mode to Reading Preferences

**Files:**
- Modify: `prototype/web/modules/reading-preferences.js`
- Modify: `prototype/web/modules/text-presenter.js`
- Modify: `prototype/web/config/ui.json`

**Step 1: Add pacing preference to ReadingPreferences**

In the preferences panel HTML generation, add a new section after the line-height options:

```javascript
// Pacing Mode
const pacingSection = document.createElement('div');
pacingSection.className = 'pref-section';
pacingSection.innerHTML = `
    <div class="pref-label">Ritmo de lectura</div>
    <div class="pref-options">
        <button class="pref-btn" data-pacing="auto">Auto</button>
        <button class="pref-btn" data-pacing="click">Click</button>
        <button class="pref-btn" data-pacing="fast">Rápido</button>
    </div>
`;
```

Add localStorage persistence for pacing preference (key: `pacing` in existing `undiamas_reading_prefs` object).

**Step 2: Modify TextPresenter to respect pacing mode**

In `text-presenter.js`, modify `showNext()`:

```javascript
function showNext() {
    if (!isPresenting) return;
    if (paragraphQueue.length === 0) { finish(); return; }

    const item = paragraphQueue.shift();
    renderItem(item);

    const pacingMode = getPacingMode(); // reads from ReadingPreferences

    if (paragraphQueue.length > 0) {
        switch (pacingMode) {
            case 'click':
                // Don't auto-advance; wait for click/Space/Enter
                // The existing skip listener in init() handles this
                break;
            case 'fast':
                activeTimeout = setTimeout(showNext, Math.floor(calculateReadTime(item.content) / 2));
                break;
            default: // 'auto'
                activeTimeout = setTimeout(showNext, calculateReadTime(item.content));
        }
    } else {
        activeTimeout = setTimeout(finish, 500);
    }
}
```

For 'click' mode, add a "continuar" indicator that appears after each paragraph.

**Step 3: Test all three modes**

1. Auto: text flows automatically (existing behavior)
2. Click: each paragraph waits for Space/Enter/click
3. Fast: text flows at 2x speed

**Step 4: Commit**

```bash
git add prototype/web/modules/reading-preferences.js prototype/web/modules/text-presenter.js
git commit -m "feat(ux): add pacing mode preference (auto/click/fast)"
```

### Task 3.2: Add scene breaks for long content

**Files:**
- Modify: `prototype/web/game.js` (content batching logic)

**Step 1: Enhance content batching for long scenes**

The current batching system uses `maxParagraphsBeforePause: 4` from ui.json. This works but doesn't account for very long paragraphs. Add word-count-based batching:

In `game.js`, modify the batching logic to also break at word count thresholds:

```javascript
const MAX_WORDS_PER_BATCH = 300; // ~1.5 minutes of reading

// In the content accumulation loop:
let currentBatchWords = 0;
items.forEach(item => {
    const words = (item.content || '').split(/\s+/).length;
    currentBatchWords += words;
    if (currentBatchWords >= MAX_WORDS_PER_BATCH) {
        // Force batch break
        contentQueue.push([...currentBatch]);
        currentBatch = [];
        currentBatchWords = 0;
    }
    currentBatch.push(item);
});
```

**Step 2: Test with a long NPC scene**

Navigate to an Ixchel or Marcos scene (known to be 1000+ words). Verify:
- Scene breaks into manageable chunks
- "Continuar →" button appears between chunks
- No content lost between chunks

**Step 3: Commit**

```bash
git add prototype/web/game.js
git commit -m "feat(ux): add word-count-based scene breaks for long content"
```

### Task 3.3: Improve reduced-motion support

**Files:**
- Modify: `prototype/web/css/story.css`
- Modify: `prototype/web/css/notifications.css`
- Modify: `prototype/web/css/ending-screen.css`

**Step 1: Add comprehensive reduced-motion media queries**

Add to each CSS file:

```css
@media (prefers-reduced-motion: reduce) {
    .tp-paragraph {
        transition: none !important;
        opacity: 1 !important;
        transform: none !important;
    }

    .notification {
        transition: none !important;
        animation: none !important;
    }

    .ending-card {
        animation: none !important;
    }

    .stat-bar-fill {
        transition: none !important;
    }

    .portrait {
        transition: none !important;
    }
}
```

**Step 2: Verify with browser devtools**

In Chrome DevTools: Rendering > Emulate CSS media feature > prefers-reduced-motion: reduce
Verify all animations are disabled.

**Step 3: Commit**

```bash
git add prototype/web/css/story.css prototype/web/css/notifications.css prototype/web/css/ending-screen.css
git commit -m "feat(a11y): add comprehensive prefers-reduced-motion support"
```

---

## Task Group 4: Replay Incentives

**Current state:** EndingScreen tracks unlocked endings in localStorage (`undm_unlocked_endings`). Book of Endings shows X/12 discovered. No achievements, no returning-player detection, no ending guide, no New Game+ variants.

### Task 4.1: Implement achievement system

**Files:**
- Create: `prototype/web/modules/achievements.js`
- Create: `prototype/web/config/achievements-config.json`
- Modify: `prototype/web/index.html` (add script)
- Modify: `prototype/web/css/notifications.css` (achievement toast style)

**Step 1: Create achievements config**

```json
{
  "achievements": {
    "primer_final": {
      "title": "Un día más",
      "description": "Completaste tu primera semana",
      "icon": "sunrise",
      "condition": "any_ending"
    },
    "todos_colectivos": {
      "title": "Fuego colectivo",
      "description": "Descubriste todos los finales colectivos",
      "icon": "flame",
      "condition": "all_category_colectivo"
    },
    "todos_finales": {
      "title": "Todas las vidas",
      "description": "Descubriste los 12 finales",
      "icon": "book-open",
      "condition": "all_endings"
    },
    "la_llama": {
      "title": "La llama vive",
      "description": "Encontraste el final épico",
      "icon": "flame",
      "condition": "ending_final_la_llama"
    },
    "solo": {
      "title": "Soledad",
      "description": "Terminaste completamente solo",
      "icon": "cloud",
      "condition": "ending_final_solo"
    },
    "tejido": {
      "title": "El tejido",
      "description": "Ixchel te enseñó a tejer comunidad",
      "icon": "heart",
      "condition": "ending_final_tejido"
    },
    "tres_vinculos": {
      "title": "Tres caminos",
      "description": "Jugaste con tres vínculos diferentes",
      "icon": "git-branch",
      "condition": "three_different_vinculos"
    },
    "huelga": {
      "title": "Paro",
      "description": "Organizaste la huelga",
      "icon": "shield",
      "condition": "ending_final_huelga"
    }
  }
}
```

**Step 2: Create achievements module**

```javascript
const Achievements = (function() {
    'use strict';

    const STORAGE_KEY = 'undm_achievements';
    const VINCULO_KEY = 'undm_played_vinculos';
    let config = null;
    let unlocked = [];

    function init() {
        unlocked = JSON.parse(localStorage.getItem(STORAGE_KEY) || '[]');
        loadConfig();
    }

    async function loadConfig() {
        try {
            const r = await fetch('config/achievements-config.json');
            if (r.ok) config = await r.json();
        } catch(e) { console.warn('Achievements config not found'); }
    }

    function check(endingName, storyVars) {
        if (!config) return;

        // Track vínculo for multi-playthrough achievement
        const playedVinculos = JSON.parse(localStorage.getItem(VINCULO_KEY) || '[]');
        if (storyVars.vinculo && !playedVinculos.includes(storyVars.vinculo)) {
            playedVinculos.push(storyVars.vinculo);
            localStorage.setItem(VINCULO_KEY, JSON.stringify(playedVinculos));
        }

        const endings = JSON.parse(localStorage.getItem('undm_unlocked_endings') || '[]');

        Object.entries(config.achievements).forEach(([id, ach]) => {
            if (unlocked.includes(id)) return;

            let earned = false;
            switch(ach.condition) {
                case 'any_ending': earned = true; break;
                case 'all_endings': earned = endings.length >= 12; break;
                case 'all_category_colectivo':
                    earned = ['final_la_llama','final_red','final_tejido','final_lucha_colectiva']
                        .every(e => endings.includes(e));
                    break;
                case 'three_different_vinculos':
                    earned = playedVinculos.length >= 3;
                    break;
                default:
                    if (ach.condition.startsWith('ending_'))
                        earned = endingName === ach.condition.replace('ending_', '');
            }

            if (earned) unlock(id, ach);
        });
    }

    function unlock(id, ach) {
        unlocked.push(id);
        localStorage.setItem(STORAGE_KEY, JSON.stringify(unlocked));
        // Show achievement notification
        if (typeof NotificationSystem !== 'undefined') {
            NotificationSystem.show(`🏆 ${ach.title}: ${ach.description}`, 'success', 6000);
        }
    }

    function getUnlocked() { return [...unlocked]; }
    function getAll() { return config ? config.achievements : {}; }

    return { init, check, getUnlocked, getAll };
})();
```

**Step 3: Wire into EndingScreen**

In `ending-screen.js`, after unlocking the ending, call:
```javascript
if (typeof Achievements !== 'undefined') {
    Achievements.check(endingName, storyVariables);
}
```

**Step 4: Add achievement display to ending screen**

In the Book of Endings section, add an achievements grid:
```javascript
const achievementsHTML = Object.entries(Achievements.getAll()).map(([id, ach]) => {
    const isUnlocked = Achievements.getUnlocked().includes(id);
    return `<div class="achievement ${isUnlocked ? 'unlocked' : 'locked'}">
        <span class="ach-icon">${isUnlocked ? '🏆' : '🔒'}</span>
        <span class="ach-title">${isUnlocked ? ach.title : '???'}</span>
    </div>`;
}).join('');
```

**Step 5: Add achievement CSS**

```css
.achievement { padding: 8px; border: 1px dashed var(--fg); opacity: 0.4; }
.achievement.unlocked { opacity: 1; border-style: solid; }
.achievement .ach-icon { font-size: 1.2rem; margin-right: 8px; }
```

**Step 6: Add script to index.html**

Add before game.js:
```html
<script src="modules/achievements.js"></script>
```

**Step 7: Test**

Play through to any ending. Verify:
- "Un día más" achievement unlocks on first completion
- Achievement toast appears with 6-second duration
- Achievements persist in localStorage across sessions

**Step 8: Commit**

```bash
git add prototype/web/modules/achievements.js prototype/web/config/achievements-config.json prototype/web/index.html prototype/web/css/notifications.css prototype/web/modules/ending-screen.js
git commit -m "feat(ux): implement achievement system with 8 achievements"
```

### Task 4.2: Add returning-player detection

**Files:**
- Modify: `prototype/web/modules/start-screen.js`

**Step 1: Detect returning players on start screen**

In the start screen initialization, check for previous playthroughs:

```javascript
function getPlaythroughCount() {
    const endings = JSON.parse(localStorage.getItem('undm_unlocked_endings') || '[]');
    return endings.length;
}

// In the start screen display logic:
const playthroughs = getPlaythroughCount();
if (playthroughs > 0) {
    // Add subtle returning-player text
    const returnText = document.createElement('p');
    returnText.className = 'return-player-text';
    returnText.textContent = playthroughs === 1
        ? 'Ya viviste un día. ¿Otro más?'
        : `${playthroughs} finales descubiertos. ¿Cuántos quedan?`;
    // Insert after manifesto text
}
```

**Step 2: Add CSS**

```css
.return-player-text {
    font-style: italic;
    opacity: 0.7;
    font-size: 0.9rem;
    margin-top: 10px;
}
```

**Step 3: Test**

1. Clear localStorage, load game → no return text
2. Play to ending, return to start → return text appears
3. Play again → counter updates

**Step 4: Commit**

```bash
git add prototype/web/modules/start-screen.js prototype/web/css/start-screen.css
git commit -m "feat(ux): add returning-player detection on start screen"
```

### Task 4.3: Add ending guide (post-first-playthrough)

**Files:**
- Modify: `prototype/web/modules/ending-screen.js`
- Modify: `prototype/web/config/endings-config.json`

**Step 1: Add hints to endings config**

For each ending, add a `hint` field (shown only after the ending is unlocked):

```json
"final_la_llama": {
    "title": "La Llama",
    "description": "El fuego no se apagó...",
    "category": "colectivo",
    "tone": "esperanzado",
    "hint": "Conexión alta, llama viva, ideas positivas, asamblea y ayuda en la olla"
},
"final_solo": {
    "title": "Solo",
    "description": "El barrio sigue...",
    "category": "aislamiento",
    "tone": "melancólico",
    "hint": "Evitá la comunidad. No ayudes. No pidas ayuda."
}
```

Add hints for all 12 endings (keep them vague enough to not spoil, specific enough to guide).

**Step 2: Show hints in Book of Endings for unlocked entries**

In the ending card generation, add:

```javascript
if (isUnlocked && ending.hint) {
    cardHTML += `<div class="ending-hint">${ending.hint}</div>`;
}
```

For locked endings, show category only:
```javascript
if (!isUnlocked) {
    cardHTML += `<div class="ending-hint-locked">${ending.category}</div>`;
}
```

**Step 3: Add CSS**

```css
.ending-hint {
    font-size: 0.75rem;
    font-style: italic;
    opacity: 0.6;
    margin-top: 4px;
}
.ending-hint-locked {
    font-size: 0.75rem;
    text-transform: uppercase;
    letter-spacing: 0.1em;
    opacity: 0.3;
}
```

**Step 4: Test**

Complete an ending, check Book of Endings. Verify:
- Unlocked endings show hint text
- Locked endings show category only
- Hints are helpful but not spoilery

**Step 5: Commit**

```bash
git add prototype/web/modules/ending-screen.js prototype/web/config/endings-config.json prototype/web/css/ending-screen.css
git commit -m "feat(ux): add ending hints to Book of Endings for replay guidance"
```

---

## Task Group 5: Final Verification & Build

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

Expected: All pass

**Step 3: Verify all new features in browser**

Checklist:
- [ ] Portraits appear for existing NPCs (sofia, elena, diego, marcos, juan)
- [ ] New NPC portraits appear (if assets created)
- [ ] Audio plays on day transitions (if assets created)
- [ ] SFX plays on dice rolls and notifications
- [ ] Pacing mode toggle works (auto/click/fast)
- [ ] Long scenes break at word count threshold
- [ ] Reduced-motion disables all animations
- [ ] Achievement unlocks on first ending
- [ ] Returning-player text appears on second visit
- [ ] Ending hints show in Book of Endings
- [ ] No console errors
- [ ] CSP doesn't block new resources

---

## Summary

| Task Group | Tasks | Estimated Complexity | Asset Dependency |
|------------|-------|---------------------|------------------|
| 1. Portraits | 3 tasks | Medium | Requires portrait images |
| 2. Audio | 4 tasks | Medium | Requires audio files |
| 3. Pacing | 3 tasks | Low-Medium | No external assets |
| 4. Replay | 3 tasks | Medium | No external assets |
| 5. Verification | 1 task | Low | - |

**Total: 14 tasks across 5 groups**

**Dependencies:**
- Task Group 1 depends on having portrait images (Task 1.1)
- Task Group 2 depends on having audio files (Task 2.1)
- Task Groups 3 and 4 have no external dependencies and can start immediately
- Task Group 5 runs last

**Recommended execution order:** Groups 3 & 4 first (no asset dependencies), then Groups 1 & 2 when assets are ready.

**Asset pipeline note:** Tasks 1.1 and 2.1 require creative assets (images and audio) that may need to be sourced externally. All code changes can be completed and tested with placeholder assets first.
