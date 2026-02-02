# Documentación - Un Día Más

Documentación completa del juego narrativo **Un Día Más**.

---

## 📚 Índice Maestro

### ⭐️ [MASTER-PLAN.md](./MASTER-PLAN.md)
**Source of Truth** - El estado actual del proyecto, definiciones canónicas y roadmap.
**LEER PRIMERO.** Define el sistema de **Inercia**, la narrativa de la Unipersonal Forzada y el estado técnico actual.

---

## 🎨 Diseño y Narrativa (Carpeta `design/`)

### 👥 [Personajes](./design/characters/)
**Perfiles Detallados** - Historia y características de cada NPC.
- [Sofía](./design/characters/perfil_sofia.md), [Elena](./design/characters/perfil_elena.md), [Diego](./design/characters/perfil_diego.md)
- [Marcos](./design/characters/perfil_marcos.md), [Juan](./design/characters/perfil_juan.md), [Ixchel](./design/characters/perfil_ixchel.md)
- [Lucía](./design/characters/perfil_lucia.md) (La Sindicalista), [Tiago](./design/characters/perfil_tiago.md) (El Pibe), [Cacho](./design/characters/perfil_cacho.md) (El Heredero)
- [Apóstol Bruno](./design/characters/perfil_apostol.md) (El Fascista), [Claudia](./design/characters/perfil_claudia.md) (La Burócrata)
- [Protagonista](./design/characters/perfil_protagonista.md)

### 🗺️ [Narrative Map](./design/narrative-map.md)
**Mapa narrativo completo** - Análisis exhaustivo de la estructura del juego.
- Estructura detallada de los 7 días
- Sistema de finales (16 endings)

### 📊 [Flowcharts](./design/flowcharts.md)
**Diagramas visuales** - Visualización de rutas y mecánicas con Mermaid.

### 🏛️ [Arquitectura](./design/architecture.md)
**Diseño Técnico** - Estructura del código Ink y del Runtime Web.

### 📍 [Ubicaciones](./design/locations/)
- [La Olla Popular](./design/locations/olla.md)
- [La Casa](./design/locations/casa.md)
- [El Laburo](./design/locations/laburo.md)
- [El Barrio](./design/locations/barrio.md)
- [El Bondi](./design/locations/bondi.md)
- [Búsqueda de Empleo](./design/locations/busqueda.md)

---

## 🔍 Referencias y Análisis (Carpeta `reference/`)

### ⚡ [Quick Reference](./reference/quick-ref.txt)
**Hoja de trucos ASCII** - Referencia rápida para desarrollo.

---

## 📁 Archivos de Proyecto

### 🗺️ Estructura de Carpetas Documentales

```
docs/
├── MASTER-PLAN.md              (Estado actual y definiciones canónicas)
├── README.md                   (Este índice)
├── CHANGELOG.md                (Registro de cambios narrativos y de contenido)
├── design/                     (Documentación de diseño detallada)
│   ├── architecture.md         (Arquitectura técnica)
│   ├── characters/             (Perfiles de NPCs)
│   ├── locations/              (Detalle de ubicaciones)
│   ├── general.md              (GDD Unificado)
│   ├── narrative-map.md        (Mapa narrativo)
│   └── flowcharts.md           (Diagramas de flujo)
├── reference/                  (Material de consulta)
│   └── quick-ref.txt           (Referencia rápida)
├── archive/                    (Documentación histórica y análisis)
└── plans/                      (Planes de implementación pendientes)
```

---

## 🎯 Guía Rápida de Uso

### Para Desarrollo
```
Necesito...                     → Ver...
──────────────────────────────────────────────────────────
Entender el estado actual       → MASTER-PLAN.md
Consultar perfil de NPC         → design/characters/perfil_[nombre].md
Entender arquitectura técnica   → design/architecture.md
Ver rutas a final LA RED        → design/flowcharts.md
```

### Para Testing
```
Quiero probar...                → Consultar...
──────────────────────────────────────────────────────────
Final SOLO                      → design/narrative-map.md
Todas las ideas                 → design/narrative-map.md
Ruta Marcos completa            → design/flowcharts.md
Trigger final GRIS              → design/narrative-map.md
```

---

## 📊 Estadísticas del Juego

| Métrica | Valor |
|---------|-------|
| Días totales | 7 |
| Escenas únicas | ~150+ |
| NPCs con arco | 11 (6 principales + 5 Fase 2) |
| Variables de estado | 139 |
| Ideas desbloqueables | 14 |
| Finales posibles | 16 |
| PAUSA tags (pacing) | 75 |
| Mecánica central | Inercia (0-10) |

---

## 🔗 Ver También

- [CLAUDE.md](../CLAUDE.md) - Instrucciones para el asistente
- [prototype/ink/](../prototype/ink/) - Archivos Ink del juego
- [prototype/web/](../prototype/web/) - Runtime web
