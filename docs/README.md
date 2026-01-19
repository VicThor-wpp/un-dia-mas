# Documentación - Un Día Más

Documentación completa del juego narrativo **Un Día Más**.

---

## 📚 Archivos Disponibles

### ⚡ [QUICK-REFERENCE.txt](./QUICK-REFERENCE.txt)
**Referencia rápida en ASCII** - Vista compacta de toda la estructura.

**Contiene:**
- ✅ Estructura de la semana (timeline ASCII)
- ✅ Decisiones críticas resumidas
- ✅ 6 finales con requisitos
- ✅ Variables clave explicadas
- ✅ NPCs resumidos
- ✅ Economía de recursos (tablas)
- ✅ Ideas desbloqueables
- ✅ Rutas a cada final
- ✅ Testing checklist

**Ideal para:**
- Referencia rápida durante desarrollo
- Ver estructura sin abrir markdown
- Copiar/pegar en documentos
- Imprimir para tener a mano

**Formato:** Plain text ASCII art (abre en cualquier editor)

---

### 🗺️ [NARRATIVE-MAP.md](./NARRATIVE-MAP.md)
**Mapa narrativo completo** - Análisis exhaustivo de la estructura del juego.

**Contiene:**
- ✅ Estructura detallada de los 7 días
- ✅ Todas las decisiones críticas y sus impactos
- ✅ Sistema de finales (6 endings)
- ✅ NPCs y sus arcos narrativos
- ✅ Mecánicas de dados, recursos y energía
- ✅ Sistema de ideas (6 ideas desbloqueables)
- ✅ Variables de estado y tracking
- ✅ Guías de rutas para cada final

**Ideal para:**
- Entender la estructura completa del juego
- Planificar contenido nuevo
- Balancear mecánicas
- Referencia rápida de variables

**Formato:** Markdown con tablas, código Ink, y ejemplos

---

### 📊 [FLOWCHARTS.md](./FLOWCHARTS.md)
**Flowcharts interactivos Mermaid** - Visualización de rutas y mecánicas.

**Contiene:**
- ✅ Timeline de la semana completa
- ✅ Flowchart de rutas críticas a finales
- ✅ Árbol de evaluación de finales
- ✅ Decisión Miércoles (turning point) detallado
- ✅ Arcos narrativos de Sofía y Marcos
- ✅ Economía de energía y recursos
- ✅ Sistema de ideas (árbol de unlock)
- ✅ Comparación: Aislamiento vs. Conexión

**Ideal para:**
- Ver rutas visualmente
- Entender flujo de decisiones
- Explicar el juego a terceros
- Presentaciones y pitches

**Formato:** Mermaid diagrams (renderiza en GitHub/VS Code)

**Cómo usar:**
1. En GitHub: se ven automáticamente
2. En VS Code: instalar extensión "Markdown Preview Mermaid Support"
3. Exportar: copiar código → https://mermaid.live/ → exportar PNG/SVG

---

## 🎯 Guía Rápida de Uso

### Para Desarrollo
```
Necesito...                     → Ver...
──────────────────────────────────────────────────────────
Entender el día Jueves          → NARRATIVE-MAP.md §2 "Jueves"
Ver rutas a final LA RED        → FLOWCHARTS.md "Rutas Críticas"
Saber qué hace ayude_en_olla    → NARRATIVE-MAP.md §6 "Variables"
Ver arco de Marcos              → Ambos (texto + visual)
Añadir nueva decisión           → NARRATIVE-MAP.md §8 "Decisiones"
Balancear conexion/llama        → NARRATIVE-MAP.md §9 "Economía"
```

### Para Testing
```
Quiero probar...                → Consultar...
──────────────────────────────────────────────────────────
Final SOLO                      → NARRATIVE-MAP.md §4 "SOLO"
Todas las ideas                 → NARRATIVE-MAP.md §10 "Ideas"
Ruta Marcos completa            → FLOWCHARTS.md "Marcos"
Máxima conexión                 → FLOWCHARTS.md "Ruta Conexión"
Trigger final GRIS              → NARRATIVE-MAP.md §4 "GRIS"
```

### Para Diseño
```
Pregunta...                     → Buscar en...
──────────────────────────────────────────────────────────
¿Cuántos finales hay?           → NARRATIVE-MAP.md §4
¿Cómo se desbloquean ideas?     → FLOWCHARTS.md "Sistema Ideas"
¿Qué decisión es más crítica?   → NARRATIVE-MAP.md §8 + FLOWCHARTS
¿Cuánta energía por día?        → NARRATIVE-MAP.md §9 "Energía"
¿Cómo funciona conta_a_alguien? → NARRATIVE-MAP.md §6 "Tracking"
```

---

## 📖 Estructura de NARRATIVE-MAP.md

1. **Visión General** - Intro y mecánicas core
2. **Estructura 7 Días** - Detalle día por día
3. **Flowchart Rutas Críticas** - Mermaid de rutas principales
4. **Todos los Finales** - 6 endings con triggers
5. **Sistema de Dados** - d6() y chequeo()
6. **Variables de Estado** - Gameplay + tracking
7. **NPCs y Relaciones** - 5 NPCs con escenas
8. **Decisiones Críticas** - 5 decisiones que cambian todo
9. **Economía de Recursos** - Energía, conexión, llama, etc.
10. **Sistema de Ideas** - 6 ideas + callbacks

---

## 📈 Estructura de FLOWCHARTS.md

1. **Semana Completa - Timeline** - Gantt de 7 días
2. **Rutas Críticas a Finales** - Flowchart principal
3. **Miércoles - Turning Point** - Detalle despido
4. **Sistema de Finales** - Árbol de evaluación
5. **NPCs - Arcos Narrativos** - Sofía y Marcos
6. **Economía de Recursos** - Energía y conexión
7. **Sistema de Ideas** - Unlock tree

---

## 🔍 Búsqueda Rápida

### Variables Críticas
- `ayude_en_olla` → NARRATIVE-MAP §6, §8
- `conexion` → NARRATIVE-MAP §6, §9
- `llama` → NARRATIVE-MAP §6, §9
- `conte_a_alguien` → NARRATIVE-MAP §2 (Miércoles), §6

### Decisiones Críticas
1. **Lunes Almuerzo** → NARRATIVE-MAP §2.1
2. **Miércoles Post-Despido** → NARRATIVE-MAP §2.3, §8.1, FLOWCHARTS §3
3. **Jueves Ayudar Olla** → NARRATIVE-MAP §2.4, §8.2, FLOWCHARTS §7
4. **Viernes Crisis** → NARRATIVE-MAP §2.5, §8.3
5. **Sábado Asamblea** → NARRATIVE-MAP §2.6, §8.4
6. **Sábado Llamar Marcos** → NARRATIVE-MAP §2.6, §7.4, FLOWCHARTS §5.2

### Finales
- **LA RED** (mejor) → NARRATIVE-MAP §4.1, FLOWCHARTS §4
- **SOLO** (peor) → NARRATIVE-MAP §4.2, FLOWCHARTS §4
- **GRIS** (burnout) → NARRATIVE-MAP §4.3, FLOWCHARTS §4
- **QUIZÁS** (esperanza) → NARRATIVE-MAP §4.4, FLOWCHARTS §4
- **INCIERTO** (ambiguo) → NARRATIVE-MAP §4.5, FLOWCHARTS §4

### NPCs
- **Sofía** → NARRATIVE-MAP §7.1, FLOWCHARTS §5.1
- **Elena** → NARRATIVE-MAP §7.2
- **Diego** → NARRATIVE-MAP §7.3
- **Marcos** → NARRATIVE-MAP §7.4, FLOWCHARTS §5.2
- **Juan** → NARRATIVE-MAP §7.5

---

## 🛠️ Mantenimiento

### Actualizar documentación cuando:
- ✅ Se añade un nuevo día/escena
- ✅ Se cambia trigger de final
- ✅ Se añade/modifica variable crítica
- ✅ Se cambia balance de recursos
- ✅ Se añade nueva idea
- ✅ Se modifica arco NPC

### Cómo actualizar:
1. **Cambios menores** → Editar NARRATIVE-MAP.md directamente
2. **Cambios visuales** → Actualizar flowcharts en FLOWCHARTS.md
3. **Nuevas mecánicas** → Añadir sección en ambos docs

---

## 📊 Estadísticas del Juego

| Métrica | Valor |
|---------|-------|
| Días totales | 7 |
| Escenas únicas | ~80+ |
| Puntos de decisión críticos | 15+ |
| NPCs con arco | 5 |
| Variables de estado | 30+ |
| Finales posibles | 6 |
| Ideas desbloqueables | 6 |
| Dice rolls explícitos | 7 |
| Horas juego (1st playthrough) | 1.5-2 |
| Rejugabilidad | Alta |

---

## 🎮 Para Jugadores (Spoiler-Free)

Si sos jugador y querés **evitar spoilers**, no leas estos docs. El juego está diseñado para descubrirse jugando.

Si ya jugaste y querés entender las mecánicas ocultas, adelante.

---

## 📝 Notas

- Documentación generada el **2026-01-19**
- Basada en **Prototype v0.8**
- Generada por análisis automático del código Ink
- Mantenida manualmente cuando el juego cambia

---

## 🔗 Ver También

- [CLAUDE.md](../CLAUDE.md) - Instrucciones para Claude Code
- [prototype/ink/](../prototype/ink/) - Archivos Ink del juego
- [prototype/web/](../prototype/web/) - Runtime web

---

**¿Preguntas?** Consultar [NARRATIVE-MAP.md](./NARRATIVE-MAP.md) primero.
