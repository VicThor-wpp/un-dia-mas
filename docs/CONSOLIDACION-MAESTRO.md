# UN DÍA MÁS - Plan Maestro de Consolidación

> **Fecha:** 2026-01-19
> **Objetivo:** Eliminar legacy, sincronizar código/docs, establecer single source of truth

---

## 1. SOLUCIÓN NARRATIVA: LA UNIPERSONAL FORZADA

### El Problema Original
La documentación mencionaba una indemnización de 3 meses que contradecía la narrativa de crisis. Si el protagonista tiene colchón financiero, ¿dónde está la urgencia?

### La Solución: Falso Autónomo Uruguayo

**Contexto legal real en Uruguay:**

El protagonista trabajaba como **"unipersonal"** - una figura donde la empresa lo obligó a facturar como trabajador independiente aunque funcionaba como empleado dependiente. Esto es una práctica real de precarización laboral en Uruguay.

**Consecuencias narrativas:**
- ❌ **Sin indemnización** - Los unipersonales no tienen derecho a despido
- ❌ **Sin seguro de desempleo** - BPS no cubre a monotributistas/unipersonales
- ❌ **Sin aguinaldo proporcional** - No aplica a "independientes"
- ✅ **Deuda con BPS** - Probablemente atrasado en aportes
- ✅ **Vulnerabilidad total** - De un día para otro, sin nada

**Cómo se implementa en la narrativa:**

```ink
// El despido (miércoles)
La reunión es corta. Veinte minutos.

"Ya no vamos a necesitar tus servicios."

No hay indemnización. No hay nada que negociar.
Sos unipersonal, ¿te acordás? Vos elegiste esto.

(No elegiste nada. Te dijeron que era así o nada.)

Tres años facturando. Tres años sin aportar lo suficiente.
Tres años de "flexibilidad" que ahora significa: la calle.
```

**Referencias legales reales:**
- [Monotributo en Uruguay - BPS](https://www.bps.gub.uy/4659/monotributo.html)
- [Tercerización laboral - RSM Uruguay](https://www.rsm.global/uruguay/es/news/la-tercerizacion-en-uruguay)
- [Empresas Unipersonales - BPS](https://www.bps.gub.uy/10171/unipersonales-y-profesionales.html)

---

## 2. DECISIONES CANÓNICAS (Single Source of Truth)

### Variables del Sistema

| Variable | Valor Inicial | Rango | Dirección | Canónico |
|----------|---------------|-------|-----------|----------|
| `energia` | 4 | 0-6 | Gasta/Recupera | ✅ |
| `dignidad` | 5 | 0-10 | Sube/Baja | ✅ |
| `conexion` | 3 | 0-10 | Sube/Baja | ⚠️ Cambiar código de 5→3 |
| `llama` | 5 | 0-10 | Sube/Baja | ⚠️ Cambiar código de 3→5 |
| `salud_mental` | 3 | 0-5 | **Solo baja** | ✅ NUEVO CANÓNICO |
| `acumulacion` | 0 | 0-10 | Solo sube (oculto) | ✅ |

### Cambio Crítico: SALUD_MENTAL reemplaza TRAUMA

| Aspecto | TRAUMA (docs legacy) | SALUD_MENTAL (canónico) |
|---------|---------------------|-------------------------|
| Dirección | Sube (acumula) | **Baja (se deteriora)** |
| Rango | 0-10 | **0-5** |
| Inicial | 0 | **3** |
| Crítico | ≥9 (quiebre) | **≤1 (quiebre)** |
| Mecánica | Trauma se acumula | Salud se desgasta |

**Umbrales de SALUD_MENTAL:**
- **5**: Bien, sin efectos
- **4**: Cansancio acumulado
- **3**: Normal post-despido (inicio)
- **2**: Agotamiento visible, opciones pesimistas aparecen
- **1**: Crisis, máximo 3 dados de energía
- **0**: FINAL "El Quiebre"

### Personajes Canónicos

| NPC | Nombre | Rol | Archivo |
|-----|--------|-----|---------|
| Compañero de trabajo | **JUAN** | El que avisa, el testigo | `juan.ink` |
| La que sostiene | Sofía | Centro de la olla | `sofia.ink` |
| La memoria | Elena | Veterana del barrio | `elena.ink` |
| El nuevo | Diego | ¿Se queda o se va? | `diego.ink` |
| El quemado | Marcos | El que vuelve | `marcos.ink` |
| La migrante | Yulimar | Xenofobia y solidaridad | `fragmentos.ink` |
| El acumulador | Walter | Tentación individual | `fragmentos.ink` |

### Nombre del Juego

**UN DÍA MÁS** (no "La Llama")

- "La llama" es una variable del sistema, no el título
- El título refleja la experiencia: sobrevivir un día más

---

## 3. ESTRUCTURA DE DOCUMENTACIÓN CONSOLIDADA

### Nueva Estructura Propuesta

```
docs/
├── CONSOLIDACION-MAESTRO.md    ← ESTE ARCHIVO (source of truth)
├── game-design.md              ← GDD unificado (fusionar index + prototype/)
├── plans/
│   └── 2026-01-19-mejora-runtime-web.md  ← Plan activo
└── archive/                    ← Legacy para referencia
    ├── conflicts/              ← 8 conflictos (backlog futuro)
    ├── decisions/              ← Decisiones históricas
    └── prototype-legacy/       ← Docs originales del prototipo
```

### Archivos a ELIMINAR o ARCHIVAR

| Archivo | Acción | Razón |
|---------|--------|-------|
| `prototype/NOTA-CORRECCION-TONO.md` | ELIMINAR | Integrado aquí |
| `prototype/00-conflicto-hibrido.md` | ARCHIVAR | Fusionar en GDD |
| `prototype/01-mecanicas-detalladas.md` | ARCHIVAR | Fusionar en GDD |
| `prototype/02-estructura-semana.md` | ARCHIVAR | Fusionar en GDD |
| `prototype/03-npcs-en-hibrido.md` | ARCHIVAR | Fusionar en GDD |
| `prototype/04-plan-implementacion.md` | ARCHIVAR | Supersedido |
| `plans/2026-01-11-implementacion-ui.md` | ARCHIVAR | Supersedido por 01-19 |
| `plans/2026-01-12-mejoras-jugabilidad-design.md` | ARCHIVAR | Ideas integradas |
| `decisions/2026-01-11-arquitectura-ui.md` | ARCHIVAR | Decisión tomada |
| `conflicts/01-08` | ARCHIVAR | Backlog para expansión |

---

## 4. CAMBIOS REQUERIDOS EN CÓDIGO

### Archivo: `prototype/ink/variables.ink`

```ink
// CAMBIOS REQUERIDOS:

// 1. Cambiar valor inicial de conexion
VAR conexion = 3  // Era 5, ahora 3

// 2. Cambiar valor inicial de llama
VAR llama = 5     // Era 3, ahora 5

// 3. Renombrar funciones de juan.ink (si existen como renzo_*)
// Buscar: renzo_ → Reemplazar: juan_
```

### Archivo: `prototype/ink/personajes/juan.ink`

```ink
// Renombrar todas las funciones:
// renzo_saludo_manana → juan_saludo_manana
// renzo_rumor → juan_rumor
// etc.
```

### Archivo: `prototype/ink/mecanicas/recursos.ink`

```ink
// Agregar función para salud_mental si no existe:
=== function bajar_salud_mental(cantidad) ===
~ salud_mental = salud_mental - cantidad
~ if salud_mental < 0
    ~ salud_mental = 0
~ return salud_mental
```

### Archivo: `prototype/ink/dias/miercoles.ink`

Agregar contexto de unipersonal al despido:

```ink
=== el_despido ===
La reunión es en la sala chica. Sin ventanas.

Recursos Humanos. La jefa. Vos.

"Mirá, no hay forma fácil de decir esto."

Veinte minutos después estás en la calle con una caja.

Sin indemnización. Sin aguinaldo. Sin seguro.

Unipersonal. Así te contrataron. Así te echan.

// Efectos mecánicos:
~ tiene_laburo = false
~ bajar_salud_mental(1)
~ bajar_dignidad(1)

->->
```

---

## 5. TIMELINE DE IMPLEMENTACIÓN

### Fase 1: Sincronización Inmediata (Día 1)
- [ ] Cambiar `conexion = 3` en variables.ink
- [ ] Cambiar `llama = 5` en variables.ink
- [ ] Renombrar `renzo_*` → `juan_*` en juan.ink
- [ ] Verificar compilación con inklecate

### Fase 2: Narrativa del Despido (Día 1-2)
- [ ] Reescribir escena del despido con contexto unipersonal
- [ ] Eliminar referencias a indemnización en toda la narrativa
- [ ] Ajustar diálogos de Juan como testigo del sistema

### Fase 3: Consolidación de Docs (Día 2)
- [ ] Crear carpeta `docs/archive/`
- [ ] Mover archivos legacy a archive
- [ ] Crear `game-design.md` unificado
- [ ] Actualizar `CLAUDE.md` si es necesario

### Fase 4: Verificación de Consistencia (Día 3)
- [ ] Revisar todas las referencias a variables en .ink
- [ ] Verificar que no queden menciones a "renzo"
- [ ] Verificar que no queden menciones a indemnización
- [ ] Compilar y testear flujo completo

### Fase 5: Sistema de Salud Mental (Día 3-4)
- [ ] Implementar umbrales de salud_mental en mecánicas
- [ ] Agregar efectos en energía cuando salud_mental ≤ 2
- [ ] Implementar final "El Quiebre" cuando salud_mental = 0
- [ ] Conectar fragmentos nocturnos con estado de salud_mental

---

## 6. CHECKLIST DE VALIDACIÓN

### Antes de Considerar "Consolidado"

**Código:**
- [ ] `inklecate prototype/ink/main.ink` compila sin errores
- [ ] No existen referencias a "renzo" (grep -r "renzo")
- [ ] No existen referencias a "indemnización" o "indemnizacion"
- [ ] Variables iniciales: conexion=3, llama=5, salud_mental=3
- [ ] Juan tiene funciones propias (juan_*)

**Documentación:**
- [ ] Un solo archivo de diseño activo (game-design.md)
- [ ] Legacy claramente archivado
- [ ] CONSOLIDACION-MAESTRO.md actualizado como referencia

**Narrativa:**
- [ ] Despido explica situación de unipersonal
- [ ] No hay expectativa de "colchón" financiero
- [ ] La urgencia es real desde el miércoles

---

## 7. NOTAS DE DISEÑO

### Por qué Salud Mental en Descenso

La decisión de usar "salud mental que baja" en lugar de "trauma que sube" es:

1. **Más intuitivo**: El jugador entiende que debe proteger su salud
2. **Menos estigmatizante**: No acumulas "trauma" como puntos negativos
3. **Refleja la realidad**: La salud mental se desgasta con el estrés
4. **Permite recuperación futura**: En una expansión, podría subir con apoyo

### Por qué la Unipersonal Forzada

1. **Es real en Uruguay**: Miles de trabajadores están en esta situación
2. **Elimina la contradicción**: Sin indemnización = crisis real
3. **Agrega profundidad política**: El juego critica la precarización
4. **Juan como testigo**: Él vio cómo te obligaron, él sabe la verdad

### Sobre el Nombre "Un Día Más"

El título captura la esencia del juego:
- Cada día es una victoria
- No hay grandes gestas, hay resistencia cotidiana
- La solidaridad se construye un día a la vez
- Sobrevivir es resistir

---

## 8. FUENTES Y REFERENCIAS

### Legislación Uruguaya
- [Monotributo - BPS](https://www.bps.gub.uy/4659/monotributo.html)
- [Unipersonales y Profesionales - BPS](https://www.bps.gub.uy/10171/unipersonales-y-profesionales.html)
- [Tercerización en Uruguay - RSM](https://www.rsm.global/uruguay/es/news/la-tercerizacion-en-uruguay)
- [Despido régimen común - MTSS](https://www.gub.uy/ministerio-trabajo-seguridad-social/institucional/derecho-laboral-uruguayo/despido-regimen-comun)

### Sobre Falso Autónomo
- [Qué es el falso autónomo - InfoAutónomos](https://www.infoautonomos.com/seguridad-social/que-es-el-falso-autonomo/)
- [Fraude laboral mediante sociedades unipersonales](https://www.elforodelabos.es/2023/02/fraude-al-derecho-laboral-a-traves-de-sociedades-unipersonales/)

---

*Documento generado el 2026-01-19. Este es el source of truth para el proyecto Un Día Más.*
