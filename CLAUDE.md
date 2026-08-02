# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Un Día Más** is a narrative game written in Ink (Inkle Studios' scripting language) about labor precarity and neighborhood solidarity in Uruguay. The story follows a worker who gets fired on Wednesday and must decide whether to connect with community support networks.

## Directory Structure

**IMPORTANT: Where to make changes**

| Directory | Purpose | Editable? |
|-----------|---------|-----------|
| `prototype/` | **Main game project** - all development happens here | ✅ YES |
| `prototype/ink/` | Ink narrative files (story, mechanics, NPCs) | ✅ YES |
| `prototype/web/` | Web runtime (HTML, CSS, JS for playing the game) | ✅ YES |
| `prototype/web/css/` | Modular CSS (themes, components, responsive) | ✅ YES |
| `prototype/web/modules/` | Custom modular framework (UI, saves, stats, etc.) | ✅ YES |
| `docs/` | **Game documentation** - narrative maps, flowcharts, references | 📖 REFERENCE |

### Documentation

The `docs/` folder contains comprehensive documentation of the game's narrative structure:

- **[docs/README.md](docs/README.md)** - Documentation index and quick reference guide
- **[docs/MASTER-PLAN.md](docs/MASTER-PLAN.md)** - Source of truth: current state, canonical
  definitions (inercia system) and roadmap. Read first.
- **[docs/design/narrative-map.md](docs/design/narrative-map.md)** - Complete narrative structure analysis
  - All 7 days detailed breakdown
  - Decision trees and critical choices
  - NPCs arcs and relationships
  - Resource economy (energia, conexion, llama, inercia)
  - Variables reference
- **[docs/design/finales.md](docs/design/finales.md)** - All 19 endings with their exact
  trigger conditions, grouped in 6 categories
- **[docs/design/flowcharts.md](docs/design/flowcharts.md)** - Visual Mermaid flowcharts
  - Critical routes to endings
  - Week timeline
  - NPCs narrative arcs
  - Decision impact visualization
  - Resource flow diagrams
- **[docs/design/characters/](docs/design/characters/)** - Per-NPC profiles (11 NPCs + protagonist)
- **[docs/design/locations/](docs/design/locations/)** - Per-location design notes

**When to consult docs:**
- Before modifying game structure or flow
- When adding new NPCs or mechanics
- To understand variable dependencies
- For testing specific narrative paths
- When balancing resources or endings

### Web Runtime Architecture

The game uses a custom modular framework built on top of Ink's official runtime:

**Core Stack:**
- `ink.js` - Official Ink runtime from Inkle Studios
- `game.js` - Main game engine that orchestrates all modules
- `css/` - Modular CSS architecture (each file is linked directly from
  `index.html`; there is no aggregate entry point):
  - `variables.css` - Theme colors, fonts, stat colors
  - `base.css` - Reset, utilities, scrollbar
  - `header.css` - Sticky header bar and stats display
  - `story.css` - Narrative text and text presenter animations
  - `dice.css` - Dice roll display and result styling
  - `choices.css` - Choice buttons and badges
  - `notifications.css` - Toast notifications
  - `modals.css` - All modal dialogs (stats, save, manual, manifesto, prefs)
  - `ui-elements.css` - Relationships, tags, portraits, threshold effects
  - `start-screen.css` - Game intro screen
  - `ending-screen.css` - Game over and book of endings
  - `responsive.css` - Mobile styles and accessibility
- `modules/` - Custom subsystems:
  - `config-manager.js` - Configuration loading and access
  - `notification-system.js` - Visual notifications and feedback
  - `decision-log.js` - Player decision history
  - `stats-panel.js` - Stats display with threshold effects
  - `relationships-panel.js` - NPC relationship tracking
  - `portrait-system.js` - Character portrait display
  - `save-system.js` - Save/load functionality
  - `choice-parser.js` - Choice tag parsing and enhancement
  - `text-presenter.js` - Progressive text reveal
  - `start-screen.js` / `ending-screen.js` - Intro and ending/book-of-endings UI
  - `achievements.js` - Achievement tracking
  - `audio-system.js` - Audio playback
  - `accessibility-manager.js` - Accessibility options
  - `reading-preferences.js` - Reading preferences (size, speed, contrast)
  - `security-validator.js` - Validation of loaded save data
- `config/` - JSON config consumed by the modules: `game.json`, `ui.json`,
  `stats.json`, `characters.json`, `endings-config.json`,
  `achievements-config.json`, `audio-config.json`, `security-config.json`

## Build Commands

Run everything from `prototype/`. Never invoke `inklecate` by hand — the npm
scripts use the native binary in `bin/` and write both the JSON and the JS
wrapper the web runtime needs.

```bash
cd prototype

npm run build          # ink/main.ink -> web/un_dia_mas.json + web/un_dia_mas.js
npm run dev            # build in watch mode
npm run lint           # static checks over the .ink files
npm test               # full suite: structure + real playthroughs
npm run test:narrative # playthroughs only (200 random runs)
npm run test:endings   # all 19 endings exist and terminate
npm run audit          # declared vs used variables
```

**`npm run build` exits 1 if the Ink does not compile**, and deletes the
previous JSON before compiling so a failed build can never be mistaken for a
good one.

**The compiled `web/un_dia_mas.json` and `.js` are committed to the repo.**
Netlify publishes `prototype/web/` as a static site with no build step, so the
file in git *is* the game people play. After touching any `.ink` file: rebuild,
run the tests, and commit the regenerated output along with the source. Never
hand-edit it.

Debugging a failing playthrough:

```bash
TRACE_SEED=42 npm run test:narrative              # transcript for that seed
TRACE_SEED=42 TRACE_LINES=60 npm run test:narrative
FUZZ_RUNS=2000 npm run test:narrative             # longer fuzz
```

## Architecture

### Modular Tunnel Pattern

The codebase uses Ink's tunnel pattern for modularity. Files in `dias/` handle routing, while actual scenes live in `ubicaciones/` and `personajes/`:

```ink
// Caller (dias/lunes.ink)
-> casa_despertar ->      // Call tunnel
-> lunes_siguiente        // Returns here

// Module (ubicaciones/casa.ink)
=== casa_despertar ===
// Scene content
->->                      // Return to caller
```

### Variable Centralization

**All VAR declarations must be in `variables.ink` or `mecanicas/`**. Declaring VAR in other modules causes duplication errors at compile time.

### Ink Pitfalls

Four mistakes account for essentially every flow bug this codebase has had.
`npm run test:narrative` catches all of them; run it after touching narrative.

**1. No gathers inside a conditional block.** A `-` at the start of a line
inside `{cond: ... }` is parsed as another condition clause, not as a gather:

```ink
{condicion:              // ERROR: "Expected an '- else:' clause here"
    Texto.
    + [...]
    -
    Más texto.
}
```

Move the branch into its own stitch and divert into it:

```ink
{condicion:
    -> rama_a
- else:
    -> rama_b
}

= rama_a
Texto.
+ [...]
-
Más texto.
-> sigue
```

**2. Continue beats must be sticky.** The `[...]` "press to continue" beat is
written `+ [...]`, never `* [...]`. A once-only beat is consumed on the first
visit, so the second time the scene runs it has no available choice and the
flow dies with `unexpectedly reached end of content`. Same rule for the choice
lists of any scene that repeats across days (bondi, casa at night, the olla
menu, recurring NPC conversations).

**3. A choice point must never be able to empty out.** If every option is
conditional (`* {energia >= 2} [...]`) or once-only, there must be an
unconditional sticky option, or the run dies whenever the conditions are false.
Menus you loop back into (`olla_ayudar_menu`) need an always-available exit.

**4. A knot body does not fall into its first stitch.** Running off the end of
knot content when the knot has stitches is `ran out of content`. End the body
with an explicit `-> nombre_del_stitch`.

### File Responsibilities

| Directory | Purpose |
|-----------|---------|
| `mecanicas/` | Game systems (dice, resources) - functions only |
| `ubicaciones/` | Reusable scenes by physical location |
| `personajes/` | NPC dialogues, encounters, night fragments |
| `dias/` | Day routing - calls tunnels, handles flow |
| `finales/` | End states based on accumulated variables |

### Key Game State Variables

- `dia_actual` (1-7): Current day
- `tiene_laburo` (bool): False after Wednesday despido
- `energia` (0-6, starts 5): Daily action capacity
- `conexion` (0-10, starts 3): Community integration
- `dignidad` (0-10, starts 5): What the system chips away at
- `llama` (0-10, starts 5): Collective hope ("la llama" - the flame)
- `inercia` (0-10, starts 5): **Central mechanic.** Resistance to change; at 10
  the game ends in final APAGADO
- `vinculo`: Chosen during character creation in `main.ink` — one of `"sofia"`,
  `"elena"`, `"diego"`, `"marcos"`, `"ixchel"`

**Adding a value to `vinculo` means updating every dispatch table that branches
on it** (`lunes_visita_vinculo`, `martes_buscar`, `jueves_buscar_vinculo`, the
`fragmento_*` dispatches, `check_game_over`). Each one now ends with an
unconditional fallback divert so an unhandled value degrades instead of killing
the run — keep it that way.

### Dice System

```ink
// Basic roll
d6()

// Check with modifier vs difficulty
// Returns: 2=critical, 1=success, 0=fail, -1=fumble
chequeo(modificador, dificultad)

// Result stored in ultima_tirada for conditional branching
```

### Resource Functions

Use helper functions instead of direct manipulation:
- `subir_conexion(n)` / `bajar_conexion(n)`
- `subir_dignidad(n)` / `bajar_dignidad(n)`
- `subir_llama(n)` / `bajar_llama(n)`
- `aumentar_inercia(n)` / `disminuir_inercia(n)` / `reducir_inercia_accion(n)`
- `gastar_energia(n)` - returns false if insufficient
- `recuperar_energia(n)` / `recuperar_energia_diaria()`
- `registrar_ayuda()` - counts a shift helped in the olla
- `unlock_idea(ref idea_var)` - internalize an idea (in `mecanicas/sistema_ideas.ink`)

State queries: `esta_agotado()`, `esta_cansado()`, `esta_conectado()`,
`esta_aislado()`, `inercia_alta()`, `llama_viva()`, `llama_apagandose()`.

Ending evaluation lives in `evaluar_*()` functions in `mecanicas/recursos.ink`;
`check_game_over` is tunneled at the end of each day.

## Common Patterns

### Conditional by game phase
```ink
{tiene_laburo: /* before firing */ }
{dia_actual >= 4: /* after Wednesday */ }
```

### NPC relationship checks
```ink
{sofia_relacion >= 4: /* friendly */ }
{vinculo == "sofia": /* special bond */ }
```

## Language

The game uses Uruguayan Spanish vocabulary:
- **bondi** = bus (not "micro")
- **laburo** = work
- **olla popular** = community soup kitchen
- **pibe/a** = kid
