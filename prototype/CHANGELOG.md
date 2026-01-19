# CHANGELOG - Un Día Más Implementation

## Session: 2026-01-19

### MAJOR REFACTOR: Modular Architecture (COMPLETED)

Complete refactoring of the web runtime into a modular, config-driven architecture.

#### New Architecture
```
prototype/web/
├── game.js                    # Main orchestrator (~400 lines, down from 467)
├── modules/
│   ├── config-manager.js      # JSON config loading and access
│   ├── notification-system.js # Visual notifications for stat changes
│   ├── stats-panel.js         # Expandable stats display
│   ├── relationships-panel.js # NPC relationships visualization
│   ├── portrait-system.js     # Character portrait display (prepared)
│   ├── save-system.js         # Save/Load with versioning
│   └── choice-parser.js       # Choice tag parsing
├── config/
│   ├── game.json              # Game metadata and dice config
│   ├── stats.json             # Stats definitions with thresholds
│   ├── characters.json        # NPC definitions with relationships
│   └── ui.json                # UI/theme configuration
└── assets/
    └── portraits/             # Character portrait directories (prepared)
```

#### Features Implemented

**1. ConfigManager (config-manager.js)**
- Loads JSON configuration files asynchronously
- Dot notation access (`ConfigManager.get('stats.energia.max')`)
- Helper methods for stats, characters, thresholds, dice results
- Fallback defaults if fetch fails (file:// protocol support)

**2. StatsPanel (stats-panel.js)**
- Expandable/collapsible stats display
- Click to toggle between minimal and full view
- Threshold indicators ("Traumatizado", "Aislado", "Sin esperanza")
- "Más info" modal with complete game state
- Body class effects for threshold states

**3. RelationshipsPanel (relationships-panel.js)**
- NPC relationship visualization (heart icons)
- Character state display (activa, agotada, etc.)
- Vinculo special highlight
- Character cards with descriptions

**4. SaveSystem (save-system.js)**
- 3 manual save slots + 1 auto-save
- Auto-save every 30 seconds
- Save versioning with migration support
- Preview info (day, stats, vinculo)
- Export/Import functionality
- Modal UI for save management

**5. PortraitSystem (portrait-system.js)**
- Prepared for character portraits during dialogues
- Tag processing: PORTRAIT:char,expression,position
- Multiple positions (left, right, center)
- Speaking/inactive states
- Mobile-aware (hide on small screens)

**6. NotificationSystem (notification-system.js)**
- Extracted from game.js
- Supports stat changes, dice rolls, generic messages
- Configurable duration and fade

**7. ChoiceParser (choice-parser.js)**
- Extracted tag parsing logic
- Supports: COSTO, DADOS, STAT, EFECTO, FALSA, TOOLTIP
- Builds choice buttons with badges

#### Configuration System
- Stats configurable: label, icon, max, color, visibility, thresholds
- Characters configurable: name, role, color, states, expressions
- UI configurable: colors, layout, feature toggles
- Adding a new stat = edit stats.json (no code changes)

#### CSS Additions (~700 lines)
- Stats panel expanded styles
- Modal system (overlay, content, header, body)
- Save/Load modal specific styles
- Character cards and relationship display
- Portrait container and animations
- Threshold body effects (trauma-high, llama-low, conexion-low)
- Button styles (primary, secondary, danger)
- Mobile responsive adjustments

#### Files Created
- `modules/config-manager.js`
- `modules/notification-system.js`
- `modules/stats-panel.js`
- `modules/relationships-panel.js`
- `modules/portrait-system.js`
- `modules/save-system.js`
- `modules/choice-parser.js`
- `config/game.json`
- `config/stats.json`
- `config/characters.json`
- `config/ui.json`
- `game.backup.js` (backup of original)

#### Files Modified
- `game.js` - Refactored to use modules
- `index.html` - Added module script tags
- `style.css` - Added ~700 lines for new components

#### Breaking Changes
- None. All existing functionality preserved.
- Game plays identically to before refactor.

#### Future Ready
- Portrait system ready (needs images)
- Save system includes migration path for future versions
- Config files documented and extensible

---

## Session: 2026-01-12

### Deployment (COMPLETED)
- **GitHub Repository**: https://github.com/VicThor-wpp/un-dia-mas
- **Live URL**: https://un-dia-mas-game.netlify.app
- All 6 resources verified loading (HTTP 200)
- Netlify site configured with security headers

### BATCH 4: Visual Feedback System (COMPLETED)
- Added comprehensive dice roll visual feedback:
  - Critical success (gold glow animation)
  - Success (green highlight)
  - Failure (red highlight)
  - Critical failure (red with shake animation)
- Implemented stat change notifications (corner pop-ups)
- Added dice roll detection via `ultima_tirada`/`ultimo_resultado` variables
- CSS animations: pulse-gold for crits, shake for fumbles
- Notifications auto-fade after 2.5 seconds

### BATCH 6: Full Review & Fixes (COMPLETED)
- **Tags applied across all files:**
  - dias/*.ink: 21+ choices tagged with COSTO/DADOS/STAT
  - ubicaciones/*.ink: 14 choices tagged
  - Comprehensive coverage of energy costs, dice rolls, and stat impacts

- **Dream sequences standardized:**
  - All headers now use `# MIENTRAS DORMÍS` (consistent accent)
  - Each character has their own header: `# SOFÍA`, `# ELENA`, `# DIEGO`, `# MARCOS`
  - Character-based routing in all dream fragments

- **Martes dreams expanded:**
  - Added fragmento_sofia_martes, fragmento_elena_martes, fragmento_diego_martes, fragmento_marcos_martes
  - Each character has unique perspective on the night before the firing

- **Marcos visibility fixed:**
  - Added fragmento_marcos_jueves, fragmento_marcos_viernes, fragmento_marcos_sabado
  - Marcos now has perspective in all dream sequences
  - His isolation narrative is consistent throughout

- **Viernes/Sabado dreams restructured:**
  - Changed from action-based (ayude/no ayude) to character-based routing
  - Added conditional content within character fragments
  - Better narrative flow with consistent structure

### Files Modified (Batch 6)
- `ink/dias/lunes.ink` - Tags on kiosco, olla, vinculo visits
- `ink/dias/martes.ink` - Character-based dream fragments
- `ink/dias/miercoles.ink` - Tags on key choices
- `ink/dias/jueves.ink` - Tags, Marcos fragment, character headers
- `ink/dias/viernes.ink` - Tags, character-based dreams
- `ink/dias/sabado.ink` - Tags, character-based dreams
- `ink/dias/domingo.ink` - Tags on choices
- `ink/ubicaciones/casa.ink` - Tags on morning/night choices
- `ink/ubicaciones/laburo.ink` - Tags on almuerzo choices
- `ink/ubicaciones/olla.ink` - Tags on all ayudar/asamblea choices
- `ink/ubicaciones/barrio.ink` - Tags on encuentros

### BATCH 5: Choice Metadata System (COMPLETED)
- Added tag-based choice metadata in Ink:
  - `# COSTO:N` - Shows energy cost on button (⚡N)
  - `# DADOS` - Shows dice icon (🎲)
  - `# DADOS:stat` - Shows dice + stat icon (🎲🤝)
  - `# STAT:stat` - Shows stat icon
- Choice badges styled with colors:
  - Cost: Yellow/amber, red if insufficient energy
  - Dice: Purple
- Unavailable choices visually dimmed

### UI/UX Improvements (COMPLETED)
- Content batching: Max 4 paragraphs before pause button
- "..." continue button for poetic pacing
- Status bar shows "CREACIÓN DE PERSONAJE" during character creation
- Changed vínculo from random to player choice
- Reformulated political question to "¿CREÉS QUE LAS COSAS PUEDEN CAMBIAR?"

### Files Modified
- `web/game.js` - Dice detection, stat tracking, choice badges, notifications
- `web/style.css` - Dice roll styles, choice badges, notification animations
- `ink/main.ink` - Title "UN DÍA MÁS", vínculo choice, reformulated question
- `ink/dias/lunes.ink` - Added cost/dice tags to choices
- `ink/dias/miercoles.ink` - Added cost/stat tags to choices
- `ink/ubicaciones/bondi.ink` - Added cost/dice tags to choices

## Session: 2026-01-11

### BATCH 1: Web Infrastructure (COMPLETED)
- Created `web/index.html` - HTML5 game template with responsive viewport
- Created `web/style.css` - Terminal aesthetic (dark theme, monospace font, orange accents)
- Created `web/game.js` - inkjs integration with Spanish day names and energy display
- Added `web/ink.js` - inkjs v2.2.4 runtime library from CDN

### BATCH 2: Compilation & Bug Fixes (COMPLETED)
- Installed inklecate via npm
- Fixed Unicode encoding issues in knot names:
  - `mañana` -> `manana` (all files)
  - `compañero` -> `companero` (laburo.ink)
  - `acompañado` -> `acompanado` (laburo.ink)
- Fixed naming conflict: `elena_preocupada_olla` VAR vs knot -> renamed knot to `elena_preocupada_olla_knot`
- Fixed loose ends in `barrio.ink` (added ->-> returns)
- Fixed choices in conditionals in `barrio.ink` (explicit diverts)
- Created missing `olla_irse` knot
- Created missing `barrio_caminar_manana` tunnel
- Successfully compiled `main.ink` to JSON (224KB)

### BATCH 3: Integration & Deployment (COMPLETED)
- Created `web/la_llama.js` wrapping JSON as `storyContent` variable
- Removed BOM character from JSON for proper parsing
- All web files in place:
  - index.html
  - style.css
  - game.js
  - ink.js (122KB)
  - la_llama.js (220KB)
- Deployed via ngrok
- **LIVE URL**: https://bede86a7c047.ngrok-free.app

### Verification Results
- All 5 web resources load with HTTP 200
- Story content: 224KB compiled JSON
- Game duration: 7 days of gameplay
- Total endings: 6 different finales

### Files Modified
- `ink/ubicaciones/laburo.ink` - Fixed ñ in identifiers
- `ink/ubicaciones/barrio.ink` - Fixed loose ends, added manana tunnel
- `ink/ubicaciones/olla.ink` - Added olla_irse knot
- `ink/personajes/juan.ink` - Fixed ñ in identifiers
- `ink/personajes/elena.ink` - Renamed conflicting knot
- `ink/dias/*.ink` - Fixed ñ in all day files

### Project Status
- Game content: 7 days complete (Lunes-Domingo)
- NPCs: 5 characters (Sofia, Elena, Diego, Marcos, Juan)
- Locations: 5 modules (casa, bondi, laburo, barrio, olla)
- Endings: 6 different finales
- Web export: Ready for testing
