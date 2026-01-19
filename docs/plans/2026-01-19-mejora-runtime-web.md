# Plan de Mejora del Runtime Web - Un Día Más

**Fecha:** 2026-01-19
**Estado:** Propuesta para implementación
**Scope:** Mejoras al sistema web actual (prototype/web/)

---

## Resumen Ejecutivo

Este plan detalla la evolución del runtime web actual hacia un sistema más robusto, mantenible y feature-complete. El objetivo es mejorar la experiencia del jugador y la mantenibilidad del código **sin migrar a otro engine**.

### Métricas de Éxito
- [ ] Stats ocultos (trauma, acumulación) visibles cuando corresponde
- [ ] Relaciones NPC visualizables
- [ ] Sistema de Save/Load funcional
- [ ] Arquitectura config-driven (agregar stat = editar JSON)
- [ ] Sistema de portraits para NPCs
- [ ] Performance mantenida (<100ms de carga inicial)

---

## Arquitectura Actual vs Propuesta

```
ACTUAL                              PROPUESTA
────────────────────────────────    ────────────────────────────────
game.js (467 líneas, monolítico)    modules/
                                    ├── config-manager.js
                                    ├── state-manager.js
                                    ├── ui-renderer.js
                                    ├── notification-system.js
                                    ├── portrait-system.js
                                    ├── save-system.js
                                    ├── stats-panel.js
                                    └── choice-parser.js

                                    config/
                                    ├── game.json
                                    ├── stats.json
                                    ├── characters.json
                                    └── ui.json

                                    game.js (orquestador, ~150 líneas)
```

---

## Fases de Implementación

### FASE 0: Preparación (1-2 horas)
**Objetivo:** Setup sin romper nada existente

- [ ] Crear estructura de carpetas (`modules/`, `config/`, `assets/`)
- [ ] Backup del `game.js` actual
- [ ] Setup de archivos de configuración vacíos

### FASE 1: Arquitectura Config-Driven (4-6 horas)
**Objetivo:** Externalizar configuración hardcodeada

#### 1.1 Crear ConfigManager
```javascript
// modules/config-manager.js
class ConfigManager {
    async loadAll() { /* carga todos los JSON */ }
    get(path) { /* acceso tipo 'stats.energia.max' */ }
    subscribe(config, callback) { /* observer pattern */ }
}
```

#### 1.2 Crear archivos de configuración

**config/stats.json:**
```json
{
  "stats": {
    "energia": {
      "label": "Energía",
      "icon": "zap",
      "max": 5,
      "default": 4,
      "color": "#ffc107",
      "visible": true,
      "description": "Capacidad de acción diaria"
    },
    "conexion": { /* ... */ },
    "dignidad": { /* ... */ },
    "llama": { /* ... */ },
    "trauma": {
      "label": "Trauma",
      "icon": "heart-crack",
      "max": 10,
      "default": 0,
      "visible": false,
      "effectsOnly": true
    },
    "acumulacion": {
      "label": "Acumulación",
      "visible": false,
      "showInFinal": true
    }
  }
}
```

**config/characters.json:**
```json
{
  "characters": {
    "sofia": {
      "name": "Sofía",
      "role": "La de la olla",
      "color": "#e89b7b",
      "relationVar": "sofia_relacion",
      "stateVar": "sofia_estado",
      "states": ["activa", "agotada", "quebrando", "ausente"],
      "portrait": "assets/portraits/sofia.png"
    },
    "elena": { /* ... */ },
    "diego": { /* ... */ },
    "marcos": { /* ... */ },
    "juan": { /* ... */ }
  }
}
```

**config/ui.json:**
```json
{
  "theme": {
    "colors": {
      "bgDark": "#1a1a1a",
      "accent": "#ff6b35"
    }
  },
  "layout": {
    "maxParagraphsBeforePause": 4,
    "notificationDuration": 2500
  },
  "features": {
    "portraits": true,
    "statsPanel": true,
    "autoSave": true,
    "notifications": true
  }
}
```

#### 1.3 Refactorizar game.js para usar config
- Reemplazar constantes hardcodeadas por `Config.get()`
- Mantener compatibilidad con código existente

**Entregable:** Configuración externalizada, comportamiento idéntico.

---

### FASE 2: Sistema de Stats Mejorado (6-8 horas)
**Objetivo:** Panel expandible + stats ocultos + umbrales visuales

#### 2.1 Crear StatsPanel Component
```javascript
// modules/stats-panel.js
class StatsPanel {
    constructor(story, config) { /* ... */ }
    render() { /* genera HTML del panel */ }
    toggle() { /* expand/collapse */ }
    update() { /* sincroniza con story */ }
}
```

#### 2.2 Implementar visualización completa

**Stats siempre visibles (header colapsado):**
- Día actual
- Energía (barra de 5 segmentos)

**Stats en panel expandido:**
- Conexión, Dignidad, Llama (barras con valores)
- Indicadores de umbral ("Aislado", "Traumatizado")

**Stats en modal "Más Info":**
- Trauma (si > 0)
- Relaciones NPC
- Ideas internalizadas
- Perfil del personaje (perdida, atadura, posición, vínculo)

#### 2.3 Efectos visuales por umbral
```css
/* Trauma alto (≥4) */
body.trauma-high {
    filter: saturate(0.7);
}
body.trauma-high::after {
    content: '';
    position: fixed;
    inset: 0;
    box-shadow: inset 0 0 100px rgba(0,0,0,0.5);
    pointer-events: none;
}

/* Llama baja (≤2) */
body.llama-low {
    --accent: #666;
}
```

**Entregable:** Panel de stats completo con toda la información del juego.

---

### FASE 3: Sistema de Relaciones NPC (4-6 horas)
**Objetivo:** Visualizar relaciones y estados de personajes

#### 3.1 Crear RelationshipsPanel
```javascript
// modules/relationships-panel.js
class RelationshipsPanel {
    constructor(story, charactersConfig) { /* ... */ }

    renderCharacterCard(charId) {
        const char = this.config[charId];
        const relation = this.story.variablesState[char.relationVar];
        const state = this.story.variablesState[char.stateVar];

        return `
            <div class="char-card ${charId === vinculo ? 'special-bond' : ''}">
                <div class="char-portrait">
                    <img src="${char.portrait}" alt="${char.name}">
                </div>
                <div class="char-info">
                    <h4>${char.name}</h4>
                    <p class="char-role">${char.role}</p>
                    <div class="relation-bar">
                        ${'❤️'.repeat(relation)}${'🖤'.repeat(5-relation)}
                    </div>
                    <span class="char-state state-${state}">${state}</span>
                </div>
            </div>
        `;
    }
}
```

#### 3.2 Integrar con StatsPanel
- Sección "Vínculos" en el panel expandido
- Indicador ★ para el vínculo especial elegido en creación

**Entregable:** Relaciones NPC visibles y comprensibles.

---

### FASE 4: Sistema de Save/Load (6-8 horas)
**Objetivo:** Persistencia de partidas con versionado

#### 4.1 Crear SaveSystem
```javascript
// modules/save-system.js
const SaveSystem = {
    VERSION: 1,

    save(story, slotId, metadata) {
        const saveData = {
            version: this.VERSION,
            timestamp: Date.now(),
            inkState: story.state.toJson(),
            metadata: { /* día, preview, etc */ }
        };
        localStorage.setItem(`udm_save_${slotId}`, JSON.stringify(saveData));
    },

    load(story, slotId) {
        const data = JSON.parse(localStorage.getItem(`udm_save_${slotId}`));
        data = this.migrate(data); // versionado
        story.state.LoadJson(data.inkState);
    },

    migrate(data) {
        // Migraciones incrementales v1→v2→v3...
    }
};
```

#### 4.2 Auto-save
```javascript
class AutoSaver {
    constructor(story, interval = 30000) { /* ... */ }
    onPlayerAction() { /* debounced save */ }
}
```

#### 4.3 UI de Save/Load
- Modal con slots de guardado
- Preview de cada save (día, stats principales)
- Botón de export/import para backup

**Entregable:** Sistema de guardado robusto con 3 slots + autosave.

---

### FASE 5: Sistema de Portraits (8-12 horas)
**Objetivo:** Retratos visuales de personajes durante diálogos

#### 5.1 Estructura de assets
```
assets/portraits/
├── sofia/
│   ├── neutral.png
│   ├── happy.png
│   ├── sad.png
│   └── worried.png
├── elena/
│   └── ...
└── placeholder.png
```

#### 5.2 Crear PortraitSystem
```javascript
// modules/portrait-system.js
class PortraitSystem {
    show(charId, expression = 'neutral', position = 'left') { /* ... */ }
    hide(charId) { /* ... */ }
    setSpeaking(charId) { /* highlight active speaker */ }
}
```

#### 5.3 Integración con Ink via tags
```ink
// En archivos .ink
=== elena_charla ===
# PORTRAIT:elena,neutral,left
"¿Cómo andás, m'hijo?"

# PORTRAIT:elena,worried
"Vi que cerraron otra fábrica..."

# HIDE_PORTRAIT:elena
```

#### 5.4 CSS para portraits
```css
.portrait-container {
    position: fixed;
    bottom: 0;
    width: 100%;
    height: 40vh;
    pointer-events: none;
}

.portrait {
    max-height: 100%;
    transition: transform 0.3s, filter 0.3s;
}

.portrait-speaking {
    filter: brightness(1.1);
    transform: scale(1.02);
}

.portrait-inactive {
    filter: brightness(0.6) grayscale(30%);
}
```

**Entregable:** Portraits funcionales para los 5 NPCs principales.

---

### FASE 6: Refactorización Final (4-6 horas)
**Objetivo:** Código limpio, modular, documentado

#### 6.1 Separar responsabilidades
- Extraer `UIRenderer` de game.js
- Extraer `NotificationSystem`
- Extraer `ChoiceParser`

#### 6.2 Documentación
- JSDoc en todas las funciones públicas
- README actualizado con arquitectura
- Comentarios en archivos de config

#### 6.3 Optimizaciones
- Debounce en refreshIcons()
- Lazy loading de portraits
- Preload de assets críticos

**Entregable:** Codebase mantenible y documentada.

---

### FASE 7: Polish y QA (4-6 horas)
**Objetivo:** Pulir detalles y testing

#### 7.1 Animaciones
- Transiciones suaves en cambio de stats
- Fade in/out de portraits
- Micro-animaciones en notificaciones

#### 7.2 Responsive
- Testing en mobile (320px - 768px)
- Touch gestures para panel de stats
- Portraits adaptativos (ocultar en mobile si muy pequeño)

#### 7.3 Accesibilidad
- ARIA labels en elementos interactivos
- Navegación por teclado (Tab, Enter, Escape)
- Contraste de colores verificado

**Entregable:** Experiencia pulida en todos los dispositivos.

---

## Cronograma Estimado

| Fase | Descripción | Horas | Dependencias |
|------|-------------|-------|--------------|
| 0 | Preparación | 1-2h | - |
| 1 | Config-Driven | 4-6h | Fase 0 |
| 2 | Stats Panel | 6-8h | Fase 1 |
| 3 | Relaciones NPC | 4-6h | Fase 1, 2 |
| 4 | Save/Load | 6-8h | Fase 1 |
| 5 | Portraits | 8-12h | Fase 1 |
| 6 | Refactorización | 4-6h | Fases 1-5 |
| 7 | Polish y QA | 4-6h | Fase 6 |
| **Total** | | **37-54h** | |

---

## Estructura de Archivos Final

```
prototype/web/
├── index.html
├── style.css
├── game.js                    # Orquestador principal (~150 líneas)
├── ink.js                     # inkjs runtime
├── un_dia_mas.js              # Story compilada
│
├── modules/
│   ├── config-manager.js      # Carga y gestión de config
│   ├── state-manager.js       # Gestión de estado del juego
│   ├── ui-renderer.js         # Renderizado de contenido
│   ├── notification-system.js # Sistema de notificaciones
│   ├── stats-panel.js         # Panel expandible de stats
│   ├── relationships-panel.js # Panel de relaciones NPC
│   ├── portrait-system.js     # Sistema de portraits
│   ├── save-system.js         # Save/Load con versionado
│   └── choice-parser.js       # Parser de tags de choices
│
├── config/
│   ├── game.json              # Config general
│   ├── stats.json             # Definición de stats
│   ├── characters.json        # Definición de personajes
│   └── ui.json                # Configuración de UI/tema
│
└── assets/
    ├── portraits/
    │   ├── sofia/
    │   ├── elena/
    │   ├── diego/
    │   ├── marcos/
    │   └── juan/
    ├── backgrounds/           # (futuro)
    └── audio/                 # (futuro)
```

---

## Inventario de Variables a Visualizar

### Siempre Visibles (Header)
| Variable | Visualización |
|----------|---------------|
| dia_actual | Texto: "LUNES" |
| energia | Barra: ●●●○○ |

### Panel Expandido
| Variable | Visualización |
|----------|---------------|
| conexion | Barra + número: ████░░ 6/10 |
| dignidad | Barra + número |
| llama | Barra + número (color especial) |
| Umbrales | Tags: "Aislado", "Traumatizado" |

### Modal "Más Info"
| Variable | Visualización |
|----------|---------------|
| trauma | Barra (si > 0) |
| sofia_relacion | ❤️❤️❤️🖤🖤 (3/5) |
| elena_relacion | Ídem |
| diego_relacion | Ídem |
| marcos_relacion | Ídem |
| juan_relacion | Ídem |
| *_estado | Tag de color |
| perdida | Texto descriptivo |
| atadura | Texto descriptivo |
| posicion | Badge |
| vinculo | ★ en personaje |
| Ideas activas | Lista de ideas |

### Efectos Visuales (sin número)
| Condición | Efecto |
|-----------|--------|
| trauma >= 4 | Desaturación, viñeta oscura |
| llama <= 2 | Colores fríos |
| conexion <= 3 | Opacidad reducida |
| tiene_laburo == false | Cambio de paleta |

---

## Riesgos y Mitigaciones

| Riesgo | Probabilidad | Impacto | Mitigación |
|--------|--------------|---------|------------|
| Romper funcionalidad existente | Media | Alto | Backup de game.js, testing incremental |
| Performance degradada | Baja | Medio | Lazy loading, debounce, profiling |
| Complejidad excesiva | Media | Medio | Mantener módulos pequeños (<200 líneas) |
| Assets de portraits no disponibles | Alta | Bajo | Usar placeholders, fase opcional |

---

## Criterios de Aceptación por Fase

### Fase 1 (Config-Driven)
- [ ] Agregar nueva stat solo requiere editar stats.json
- [ ] Cambiar colores solo requiere editar ui.json
- [ ] Juego funciona idéntico con config externalizada

### Fase 2 (Stats Panel)
- [ ] Panel se expande/colapsa con animación suave
- [ ] Todas las stats principales visibles
- [ ] Umbrales muestran indicadores visuales

### Fase 3 (Relaciones)
- [ ] 5 personajes con relación y estado visible
- [ ] Vínculo especial marcado con ★
- [ ] Estados tienen colores semánticos

### Fase 4 (Save/Load)
- [ ] Auto-save cada 30 segundos
- [ ] 3 slots manuales funcionales
- [ ] Migración de saves entre versiones
- [ ] Export/import de backup

### Fase 5 (Portraits)
- [ ] Al menos 3 expresiones por personaje
- [ ] Transiciones suaves
- [ ] Funciona en mobile (o se oculta elegantemente)

### Fase 6 (Refactorización)
- [ ] Ningún archivo > 300 líneas
- [ ] JSDoc en funciones públicas
- [ ] Sin código duplicado

### Fase 7 (Polish)
- [ ] Funciona en Chrome, Firefox, Safari
- [ ] Responsive 320px - 1920px
- [ ] Sin errores en consola

---

## Notas de Implementación

### Tags de Ink a Implementar

```ink
// Stats
# EFECTO:conexion+2        // Notificación de cambio
# EFECTO:energia-1
# EFECTO:llama?            // Incertidumbre

// Choices
# COSTO:2                  // Requiere energía
# DADOS                    // Indica tirada
# DADOS:conexion           // Tirada con modificador
# FALSA                    // Choice sin consecuencia

// Portraits
# PORTRAIT:elena,happy,left
# PORTRAIT:sofia,worried,right,speaking
# HIDE_PORTRAIT:elena
# HIDE_ALL_PORTRAITS

// UI
# CLEAR                    // Limpia pantalla
# PAUSE                    // Espera input
# HEADER:JUEVES            // Encabezado de día
```

### Orden de Carga en index.html

```html
<!-- 1. Dependencias externas -->
<script src="https://unpkg.com/lucide@latest/dist/umd/lucide.min.js"></script>

<!-- 2. Ink runtime -->
<script src="ink.js"></script>
<script src="un_dia_mas.js"></script>

<!-- 3. Módulos (orden importa) -->
<script src="modules/config-manager.js"></script>
<script src="modules/state-manager.js"></script>
<script src="modules/notification-system.js"></script>
<script src="modules/stats-panel.js"></script>
<script src="modules/relationships-panel.js"></script>
<script src="modules/portrait-system.js"></script>
<script src="modules/save-system.js"></script>
<script src="modules/choice-parser.js"></script>
<script src="modules/ui-renderer.js"></script>

<!-- 4. Orquestador principal -->
<script src="game.js"></script>
```

---

## Próximos Pasos

1. **Aprobar este plan** con stakeholders
2. **Crear branch** `feature/runtime-improvements`
3. **Implementar Fase 0** (setup)
4. **Iterar** fase por fase con commits frecuentes
5. **Testing** después de cada fase
6. **Merge** cuando todas las fases pasen QA

---

## Referencias

- Análisis de arquitectura actual: agente `a07d904`
- Inventario de variables: agente `a2938c2`
- Mejores prácticas UI: agente `a1f3b46`
- Propuesta narrativa integral: `docs/plans/2026-01-19-propuesta-narrativa-integral.md`
