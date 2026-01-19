# Decisiones de Arquitectura: UI para Testing

**Fecha:** 2026-01-11
**Estado:** Aprobado
**Contexto:** Selección de framework y sistema de diseño para la UI de testing del juego narrativo

---

## Resumen Ejecutivo

Se eligió **Atrament Web UI** como framework base para la interfaz de testing y demostración del juego "Un Día Más". Esta decisión prioriza debugging integrado, customización visual, y mantenimiento activo del proyecto.

---

## Decisión 1: Nombre del Proyecto

### Decisión
**Un Día Más**

### Alternativas Consideradas
| Nombre | Razón de Descarte |
|--------|-------------------|
| La Llama | Tono demasiado épico, rompe el realismo |
| Olla | Muy monosilábico para el peso político del juego |
| Es Lo Que Hay | Resignación pasiva, cierra la conversación |
| Miércoles | Demasiado específico |

### Justificación
- Captura la mecánica central: sobrevivir día a día
- Tono existencial y pesimista sin ser derrotista
- Abre pregunta implícita: ¿y mañana?
- Funciona en español e internacionalmente

---

## Decisión 2: Framework de UI

### Decisión
**Atrament Web UI** (https://github.com/technix/atrament-web-ui)

### Alternativas Evaluadas

| Framework | Pros | Contras | Veredicto |
|-----------|------|---------|-----------|
| **Atrament Web UI** | Debugger integrado, sistema de saves, markup rico, mantenido activamente (2023+), soporte multimedia | Requiere Node.js 22+ | **Elegido** |
| Disco Elysium Template | Visual muy pulido, sistema de skills | Abandonado (4+ años), sin debugger | Descartado |
| Calico | Compila .ink directo, sistema de patches | Sin debugger, más DIY | Descartado |
| Pixi'VN | Engine 2D completo, animaciones | Complejidad excesiva para testing | Descartado |
| Blotter + Gall | Simple, CLI tool | Muy básico, sin features de debug | Descartado |
| Ink VN Lite | Visual novel ready | Orientado a VN, no a RPG narrativo | Descartado |

### Justificación
1. **Debugger integrado**: Ver/editar variables en tiempo real, navegar a knots, ver contadores
2. **Sistema de saves**: Autosave, checkpoints, múltiples slots
3. **Markup rico**: Progress bars, overlays, tablas, botones, capas de imágenes
4. **Multimedia**: Soporte nativo para imágenes, sonido, video, backgrounds
5. **Customización**: Themes JSON, CSS custom, fonts custom
6. **Mantenimiento**: Proyecto activo con soporte de la Interactive Fiction Technology Foundation
7. **Publicación flexible**: PWA, single HTML, o ejecutable desktop

---

## Decisión 3: Sistema de Diseño Visual

### Paleta de Colores

```css
/* Fondos */
--bg-primary: #1a1a1f;      /* Fondo principal */
--bg-secondary: #252530;    /* Fondo secundario */
--bg-card: #2d2d3a;         /* Cards y contenedores */
--bg-hover: #363645;        /* Estados hover */

/* Texto */
--text-primary: #e8e6e3;    /* Texto principal */
--text-secondary: #a8a5a0;  /* Texto secundario */
--text-muted: #6b6966;      /* Texto deshabilitado */

/* Acentos - Recursos del juego */
--accent-warm: #d4a574;     /* Energía, luz de farol */
--accent-hope: #7eb8a2;     /* Conexión, esperanza */
--accent-alert: #c75d5d;    /* Alerta, tensión */
--accent-dignity: #a08bd4;  /* Dignidad */

/* Personajes */
--color-sofia: #e89b7b;     /* Mecánica */
--color-elena: #98b89e;     /* Jubilada */
--color-diego: #d4a574;     /* Cocinero */
--color-marcos: #7ba3c7;    /* Albañil */
--color-renzo: #8b7b7b;     /* Jefe */
```

### Tipografía
- **Body**: Lora (serif) - narrativa, literaria
- **UI**: Source Sans 3 (sans-serif) - interfaz, stats

### Justificación
- Tema oscuro: reduce fatiga visual en sesiones largas
- Colores cálidos: reflejan el barrio (luz de farol, café)
- Verde esperanza: la conexión comunitaria como aspecto positivo
- Cada personaje con color único para reconocimiento instantáneo

---

## Decisión 4: Arquitectura de Componentes UI

### Toolbar Superior (siempre visible)
```
[Día] [Energía ████░░ 3/5] [Conexión ██░░░░ 4/10] [Stats] [Debug]
```

### Elementos de Juego
| Componente | Uso | Markup Atrament |
|------------|-----|-----------------|
| Progress bars | Recursos (energía, conexión, dignidad) | `[progress value={var}]Label[/progress]` |
| Banners | Cambio de día, eventos importantes | `[banner style=accent]MIÉRCOLES[/banner]` |
| Info boxes | Cambios de estado, notificaciones | `[info side=accent]Conexión +1[/info]` |
| Choices | Opciones del jugador | Nativo de Ink + CSS custom |
| Overlay | Panel de stats, inventario | `[button onclick=stats]Stats[/button]` |
| Diálogos | Conversaciones con NPCs | Portrait + nombre coloreado |
| Dados | Resultados de chequeos | Modal custom con CSS |

### Sistema de Dados (visual)
```
┌─────────────────────┐
│  CHEQUEO: CARISMA   │
│       ┌───┐         │
│       │ 5 │ 🎲      │
│       └───┘         │
│   5 + 2 = 7 vs 4    │
│     ✓ ÉXITO         │
└─────────────────────┘
```

---

## Decisión 5: Estructura de Archivos

```
un-dia-mas/
├── root/
│   └── game/
│       ├── story.ink.json      # Ink compilado
│       ├── images/
│       │   ├── backgrounds/    # Fondos por ubicación
│       │   └── portraits/      # Retratos de personajes
│       └── sounds/
│           ├── ambient/        # Sonidos de ambiente
│           └── sfx/            # Efectos de sonido
├── resources/
│   ├── themes/
│   │   └── barrio.json         # Theme custom
│   ├── styles/
│   │   └── custom.css          # CSS personalizado
│   └── fonts/                  # Fonts custom si es necesario
├── prototype/
│   └── ink/                    # Archivos .ink fuente (existentes)
└── docs/
    ├── decisions/              # Este archivo
    └── plans/                  # Planes de implementación
```

---

## Decisión 6: Mapeo de Variables Ink → UI

| Variable Ink | Display en Toolbar | Color |
|--------------|-------------------|-------|
| `dia_actual` | 📅 LUNES/MARTES/etc | --accent-warm |
| `energia` | ⚡ ████░░ 3/5 | --accent-warm |
| `conexion` | 🤝 ██░░░░ 4/10 | --accent-hope |
| `la_llama` | 🔥 ███░░░ 3/10 | gradient warm |
| `dignidad` | ✊ (en overlay Stats) | --accent-dignity |
| `tiene_laburo` | 💼 Status en Stats | --accent-alert si false |
| `vinculo` | 💜 Nombre en Stats | color del personaje |

---

## Dependencias Técnicas

| Dependencia | Versión | Propósito |
|-------------|---------|-----------|
| Node.js | 22.12+ | Runtime |
| inkjs | latest | Interprete Ink |
| Preact | latest | UI framework (via Atrament) |
| inklecate | latest | Compilador Ink |

---

## Referencias

- Atrament Web UI: https://github.com/technix/atrament-web-ui
- Atrament Core: https://github.com/technix/atrament-core
- inkjs: https://github.com/y-lohse/inkjs
- Ink Language: https://github.com/inkle/ink

---

## Changelog

| Fecha | Cambio |
|-------|--------|
| 2026-01-11 | Documento inicial |
