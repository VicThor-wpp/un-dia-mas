# Un Dia Mas - Game Optimization Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Rebalancear las mecanicas del juego (dados, recursos, salud mental) y optimizar el web runtime (save lock, render, estado duplicado).

**Architecture:** El juego usa Ink (inkle) compilado a JSON, con un web runtime modular en vanilla JS. Los cambios de mecanicas se hacen en archivos `.ink` en `prototype/ink/mecanicas/` y `prototype/ink/dias/`. Los cambios de runtime se hacen en `prototype/web/`.

**Tech Stack:** Ink scripting language, vanilla JavaScript (IIFE modules), HTML/CSS, inklecate compiler

---

## PARTE A: MECANICAS INK (Rebalanceo del juego)

---

### Task 1: Agregar funcion `subir_salud_mental()` con feedback narrativo

**Problema:** `salud_mental` solo puede bajar (via `bajar_salud_mental()` en recursos.ink:127-131). No existe funcion de recuperacion. Con inicio en 3/5, cualquier perdida es permanente excepto el recovery de jueves.

**Files:**
- Modify: `prototype/ink/mecanicas/recursos.ink:127-131`

**Step 1: Agregar `subir_salud_mental` despues de `bajar_salud_mental`**

Insertar despues de la linea 131 (cierre de `bajar_salud_mental`):

```ink
=== function subir_salud_mental(cantidad) ===
    ~ temp salud_antes = salud_mental
    ~ salud_mental = salud_mental + cantidad
    {salud_mental > 5:
        ~ salud_mental = 5
    }
    // Feedback narrativo en thresholds
    {
    - salud_mental >= 3 && salud_antes < 3:
        # STAT_THRESHOLD
        Algo se afloja en el pecho.
        No estas bien. Pero estas un poco mejor.
    }
```

**Step 2: Compilar y verificar que no hay errores**

Run: `inklecate prototype/ink/main.ink 2>&1 | head -5`
Expected: No errors

**Step 3: Commit**

```bash
git add prototype/ink/mecanicas/recursos.ink
git commit -m "feat: add subir_salud_mental() recovery function with threshold feedback"
```

---

### Task 2: Conectar recuperacion de salud mental a momentos narrativos clave

**Problema:** La funcion existe pero no se usa en ningun lugar. Necesita puntos de activacion en la narrativa.

**Files:**
- Modify: `prototype/ink/mecanicas/dados.ink` (consecuencias de chequeo_mental critico)
- Modify: `prototype/ink/dias/jueves.ink` (conversacion profunda)
- Modify: `prototype/ink/dias/viernes.ink` (momento de olla)
- Modify: `prototype/ink/dias/sabado.ink` (post-asamblea)

**Step 1: Modificar consecuencia de exito critico mental en dados.ink**

Buscar la funcion `chequeo_mental` (o el bloque de consecuencias criticas mentales). Cuando hay critico exito mental, actualmente da `+1 salud_mental` con cap y `+1 pequenas_victorias`. Verificar que use `subir_salud_mental(1)` en vez de manipulacion directa.

Buscar en dados.ink la seccion de consecuencias criticas del chequeo mental. Si usa `~ salud_mental += 1`, cambiar a `~ subir_salud_mental(1)` para que pase por la funcion con feedback.

**Step 2: Agregar recuperacion en jueves - conversacion profunda con vinculo**

En `jueves.ink`, buscar la seccion donde el jugador tiene conversacion profunda con su vinculo (flag `hable_con_*_profundo`). Despues de ese momento, agregar:

```ink
~ subir_salud_mental(1)
```

Esto da +1 salud mental por abrirse emocionalmente.

**Step 3: Agregar recuperacion en viernes - ayudar en la olla**

En `viernes.ink`, buscar la seccion donde el jugador ayuda activamente en la olla (cuando incrementa `veces_que_ayude`). Despues de la primera ayuda, agregar:

```ink
{veces_que_ayude == 1:
    ~ subir_salud_mental(1)
}
```

Solo la primera vez - el acto de ayudar a otros como alivio.

**Step 4: Agregar recuperacion en sabado - despues de asamblea**

En `sabado.ink`, buscar `sabado_asamblea_fin` (linea ~603). Despues de participar activamente, agregar:

```ink
{participe_asamblea:
    ~ subir_salud_mental(1)
}
```

**Step 5: Compilar y verificar**

Run: `inklecate prototype/ink/main.ink 2>&1 | head -5`
Expected: No errors

**Step 6: Commit**

```bash
git add prototype/ink/mecanicas/dados.ink prototype/ink/dias/jueves.ink prototype/ink/dias/viernes.ink prototype/ink/dias/sabado.ink
git commit -m "feat: connect salud_mental recovery to narrative moments (profundo, olla, asamblea)"
```

---

### Task 3: Agregar recovery mental en viernes y sabado (como jueves)

**Problema:** Solo jueves tiene `recovery_mental_jueves` (jueves.ink:941-961). Si salud_mental llega a 0 en viernes o sabado, es game-over instantaneo sin oportunidad de salvarse.

**Files:**
- Modify: `prototype/ink/dias/viernes.ink:828-839` (transicion_viernes_sabado)
- Modify: `prototype/ink/dias/sabado.ink` (transicion sabado-domingo, buscar patron similar)

**Step 1: Agregar recovery en viernes**

En `viernes.ink`, reemplazar el bloque de transicion (lineas 828-839):

```ink
=== transicion_viernes_sabado ===
// Chequeo de colapso mental antes de continuar
{salud_mental <= 0:
    -> recovery_mental_viernes
}
- (post_recovery_viernes)

// Chequeo de destruccion del tejido social
{llama <= 0:
    -> final_sin_llama
}

-> sabado_amanecer

=== recovery_mental_viernes ===
Todo se pone oscuro. Otra vez. Peor.

* [...]
-

{conexion <= 1 && llama <= 1:
    No queda nada.
    Ni gente. Ni fuego. Ni razon.

    -> final_apagado
}

Pero algo queda. Alguien dijo tu nombre hoy. Alguien te vio.

~ salud_mental = 1

No estas bien. Pero todavia estas.

-> transicion_viernes_sabado.post_recovery_viernes
```

**Step 2: Agregar recovery en sabado**

Buscar la transicion sabado-domingo en `sabado.ink`. Aplicar el mismo patron:

```ink
{salud_mental <= 0:
    -> recovery_mental_sabado
}
- (post_recovery_sabado)

// ... resto de checks ...

=== recovery_mental_sabado ===
La oscuridad viene de nuevo. Mas fuerte.

* [...]
-

{conexion <= 1 && llama <= 1:
    No hay red. No hay llama. No hay manana.

    -> final_apagado
}

{participe_asamblea:
    La asamblea. Las voces. Algo de eso queda.
- else:
    Una cara. Un gesto. Algo minimo.
}

~ salud_mental = 1

Manana es domingo. Ultimo dia. Algo tiene que pasar.

-> [post_recovery_label]
```

**Step 3: Compilar y verificar**

Run: `inklecate prototype/ink/main.ink 2>&1 | head -5`
Expected: No errors

**Step 4: Commit**

```bash
git add prototype/ink/dias/viernes.ink prototype/ink/dias/sabado.ink
git commit -m "feat: add mental health recovery tunnels for viernes and sabado transitions"
```

---

### Task 4: Rebalancear sistema de ventaja/desventaja en dados

**Problema:** Desventaja es 10x mas punitiva que ventaja es beneficiosa.
- Ventaja: pifia solo con doble-1 (2.8%), critico con cualquier 6 (16.7%)
- Desventaja: pifia con cualquier 1 (30.6%), critico solo con doble-6 (2.8%)

**Solucion:** Hacer desventaja menos asimetrica. Pifia en desventaja requiere que el dado elegido (el menor) sea 1 Y el otro sea <= 3 (probabilidad ~25% en vez de 30.6%). Esto suaviza sin eliminar la penalidad.

**Files:**
- Modify: `prototype/ink/mecanicas/dados.ink:72-89`

**Step 1: Modificar `chequeo_desventaja`**

Reemplazar lineas 72-89:

```ink
// Chequeo con desventaja (tira 2, usa el peor)
=== function chequeo_desventaja(modificador, dificultad) ===
    ~ temp t1 = d6()
    ~ temp t2 = d6()
    ~ temp tirada = t1
    { t2 < t1:
        ~ tirada = t2
    }
    ~ ultima_tirada = tirada
    { tirada == 6 && t1 == 6:  // Solo critico si ambos son 6
        ~ return 2
    }
    { tirada == 1 && t1 <= 3 && t2 <= 3:  // Pifia si ambos dados son bajos
        ~ return -1
    }
    { tirada + modificador >= dificultad:
        ~ return 1
    }
    ~ return 0
```

**Nota de diseno:** La condicion `tirada == 1 && t1 <= 3 && t2 <= 3` significa: el dado usado es 1 Y ambos dados son 3 o menos. Probabilidad: ~13.9% (reducida desde 30.6%). Sigue siendo punitiva pero no devastadora.

**Step 2: Compilar y verificar**

Run: `inklecate prototype/ink/main.ink 2>&1 | head -5`
Expected: No errors

**Step 3: Commit**

```bash
git add prototype/ink/mecanicas/dados.ink
git commit -m "fix: rebalance disadvantage critical failure from 30.6% to ~14% probability"
```

---

### Task 5: Subir energia base de jueves en adelante

**Problema:** Con 3 energia/dia desde jueves, el jugador solo puede hacer 3 acciones. Esto fuerza aislamiento involuntario en los dias mas importantes para la conexion.

**Files:**
- Modify: `prototype/ink/dias/viernes.ink:17` (energia = 4, ya esta bien)
- Modify: `prototype/ink/dias/jueves.ink:17` (cambiar de 3 a 4)

**Step 1: Verificar valores actuales**

- jueves.ink:17 → `~ energia = 3` (cambiar a 4)
- viernes.ink:17 → `~ energia = 4` (ya esta bien, no tocar)
- sabado.ink:20 → `~ energia = 4` (ya esta bien, no tocar)

**Step 2: Modificar jueves**

En `jueves.ink`, linea 17, cambiar:
```ink
~ energia = 4  // Dormiste mal, pero el cuerpo se adapta
```

**Step 3: Compilar y verificar**

Run: `inklecate prototype/ink/main.ink 2>&1 | head -5`
Expected: No errors

**Step 4: Commit**

```bash
git add prototype/ink/dias/jueves.ink
git commit -m "fix: increase jueves starting energy from 3 to 4 for better pacing"
```

---

### Task 6: Reducir dano involuntario de fragmentos nocturnos

**Problema:** Los fragmentos nocturnos causan -1 salud_mental o -1 llama sin control del jugador, basado en estado historico. 7 noches = hasta 7 perdidas involuntarias.

**Solucion:** Agregar `chance(50)` a los danos de fragmentos mas duros, y hacer que algunos solo bajen si el jugador ya esta en estado critico (en vez de siempre).

**Files:**
- Modify: Fragmentos en `prototype/ink/dias/jueves.ink` (lineas 646-907)
- Modify: Fragmentos en `prototype/ink/dias/viernes.ink` (lineas 551-826)

**Step 1: Identificar todos los `bajar_salud_mental` dentro de fragmentos**

Buscar con grep todas las llamadas a `bajar_salud_mental` en archivos de dias. Para cada una que este dentro de un fragmento nocturno (no en una decision del jugador), envolver con `chance(50)`:

Patron original:
```ink
~ bajar_salud_mental(1)
```

Patron nuevo:
```ink
{ chance(50):
    ~ bajar_salud_mental(1)
}
```

**Step 2: Hacer lo mismo para `bajar_llama` en fragmentos**

Mismo patron: envolver con `{ chance(60): }` (60% chance, un poco mas probable que salud).

**Nota:** NO cambiar las llamadas a `bajar_*` que estan en decisiones del jugador o en consecuencias de checks. Solo las que estan en fragmentos nocturnos involuntarios.

**Step 3: Compilar y verificar**

Run: `inklecate prototype/ink/main.ink 2>&1 | head -5`
Expected: No errors

**Step 4: Commit**

```bash
git add prototype/ink/dias/jueves.ink prototype/ink/dias/viernes.ink
git commit -m "fix: add chance-gating to involuntary fragment damage (50% mental, 60% llama)"
```

---

### Task 7: Compilar y generar archivo JS final

**Problema:** Despues de todos los cambios Ink, hay que recompilar.

**Files:**
- Output: `prototype/web/un_dia_mas.json`
- Output: `prototype/web/un_dia_mas.js`

**Step 1: Compilar Ink a JSON**

Run: `inklecate -o prototype/web/un_dia_mas.json prototype/ink/main.ink`
Expected: Clean compilation, no errors

**Step 2: Generar wrapper JS**

Run (PowerShell):
```powershell
$json = Get-Content -Raw prototype/web/un_dia_mas.json
"var storyContent = $json;" | Out-File -Encoding utf8 prototype/web/un_dia_mas.js
```

**Step 3: Commit**

```bash
git add prototype/web/un_dia_mas.json prototype/web/un_dia_mas.js
git commit -m "build: recompile ink after mechanics rebalancing"
```

---

## PARTE B: WEB RUNTIME (Optimizacion tecnica)

---

### Task 8: Fix save lock - early returns sin reset

**Problema:** En `save-system.js:90` y `save-system.js:99`, hay `return false` que salen del try-catch sin resetear `saveLock`. Si `createSaveData()` retorna null o el storage quota check falla, el lock queda permanentemente en true.

**Files:**
- Modify: `prototype/web/modules/save-system.js:77-113`

**Step 1: Agregar saveLock = false antes de cada early return**

En `saveToSlot`, linea 90:
```javascript
// ANTES:
if (!saveData) return false;

// DESPUES:
if (!saveData) {
    saveLock = false;
    return false;
}
```

En `saveToSlot`, linea 99:
```javascript
// ANTES:
showNotification('Sin espacio para guardar', 'error');
return false;

// DESPUES:
showNotification('Sin espacio para guardar', 'error');
saveLock = false;
return false;
```

**Step 2: Mismo fix para `autoSave`**

En `autoSave` (linea ~125):
```javascript
// ANTES:
if (!saveData) return false;

// DESPUES:
if (!saveData) {
    saveLock = false;
    return false;
}
```

En `autoSave` (linea ~132):
```javascript
// ANTES (si existe early return por quota):
return false;

// DESPUES:
saveLock = false;
return false;
```

**Step 3: Verificar manualmente abriendo el juego en browser**

Abrir `prototype/web/index.html`, jugar hasta poder guardar, guardar/cargar.

**Step 4: Commit**

```bash
git add prototype/web/modules/save-system.js
git commit -m "fix: reset saveLock on early returns to prevent permanent lock"
```

---

### Task 9: Eliminar estado duplicado `previousStats`

**Problema:** `game.js:27` y `stats-panel.js:10` ambos declaran `let previousStats = {}` y los trackean independientemente. Riesgo de desincronizacion.

**Files:**
- Modify: `prototype/web/game.js`
- Modify: `prototype/web/modules/stats-panel.js`

**Step 1: Determinar quien es el "dueno" de previousStats**

Leer como usa `game.js` su `previousStats` (para detectar cambios y notificar) y como lo usa `stats-panel.js` (para comparar y renderizar). El `StatsPanel` es el modulo correcto para ser dueno del estado de stats.

**Step 2: Exponer API desde StatsPanel**

En `stats-panel.js`, agregar al return del IIFE:

```javascript
getPreviousStats: function() { return {...previousStats}; },
getStatDiff: function(statId) {
    const current = getStatValue(statId);
    const prev = previousStats[statId] ?? current;
    return current - prev;
}
```

**Step 3: En game.js, eliminar `previousStats` y usar StatsPanel**

Reemplazar los usos de `previousStats` en game.js con llamadas a `StatsPanel.getStatDiff()` o `StatsPanel.getPreviousStats()`. Eliminar la declaracion `let previousStats = {}` en game.js:27.

**Step 4: Verificar en browser**

Abrir juego, avanzar, verificar que las notificaciones de cambio de stats siguen funcionando.

**Step 5: Commit**

```bash
git add prototype/web/game.js prototype/web/modules/stats-panel.js
git commit -m "refactor: centralize previousStats in StatsPanel, remove duplicate from GameEngine"
```

---

### Task 10: Optimizar Lucide icon refresh - scope al contenedor

**Problema:** `lucide.createIcons()` escanea el DOM completo cada vez. Se llama en `game.js:503`, `notification-system.js:63`, y otros puntos.

**Files:**
- Modify: `prototype/web/game.js:501-505`
- Modify: `prototype/web/modules/notification-system.js:63`

**Step 1: Modificar `refreshIcons` en game.js para aceptar scope**

```javascript
// ANTES (game.js:501-505):
function refreshIcons() {
    if (typeof lucide !== 'undefined') {
        lucide.createIcons();
    }
}

// DESPUES:
function refreshIcons(container) {
    if (typeof lucide !== 'undefined') {
        if (container) {
            lucide.createIcons({ root: container });
        } else {
            lucide.createIcons();
        }
    }
}
```

**Step 2: Actualizar llamadas en game.js**

Buscar cada `refreshIcons()` en game.js y pasar el contenedor relevante:
- En `showNextBatch`: `refreshIcons(storyContainer)`
- En `showChoices`: `refreshIcons(choicesContainer)`
- En `createDiceElement`: `refreshIcons(diceElement)`

**Step 3: Actualizar notification-system.js**

```javascript
// ANTES (notification-system.js:63):
if (typeof lucide !== 'undefined') {
    lucide.createIcons();
}

// DESPUES:
if (typeof lucide !== 'undefined') {
    lucide.createIcons({ root: notif });
}
```

**Step 4: Verificar en browser**

Abrir juego, verificar que iconos se renderizan correctamente.

**Step 5: Commit**

```bash
git add prototype/web/game.js prototype/web/modules/notification-system.js
git commit -m "perf: scope lucide.createIcons() to specific containers instead of full DOM"
```

---

### Task 11: Debounce portrait resize handler

**Problema:** `portrait-system.js:28` agrega `resize` listener sin debounce, causando layout thrashing.

**Files:**
- Modify: `prototype/web/modules/portrait-system.js`

**Step 1: Agregar debounce al listener**

Buscar linea 28: `window.addEventListener('resize', checkMobile);`

Reemplazar con:

```javascript
let resizeTimer;
window.addEventListener('resize', function() {
    clearTimeout(resizeTimer);
    resizeTimer = setTimeout(checkMobile, 150);
});
```

**Step 2: Verificar en browser**

Abrir juego, redimensionar ventana, verificar que portraits se ocultan/muestran en mobile.

**Step 3: Commit**

```bash
git add prototype/web/modules/portrait-system.js
git commit -m "perf: debounce portrait resize handler to prevent layout thrashing"
```

---

### Task 12: Verificacion final y compilacion

**Files:**
- All modified files

**Step 1: Compilar Ink una ultima vez**

Run: `inklecate -o prototype/web/un_dia_mas.json prototype/ink/main.ink`
Expected: Clean compilation

**Step 2: Regenerar JS wrapper**

Run (PowerShell):
```powershell
$json = Get-Content -Raw prototype/web/un_dia_mas.json
"var storyContent = $json;" | Out-File -Encoding utf8 prototype/web/un_dia_mas.js
```

**Step 3: Abrir juego en browser y hacer playtest rapido**

- Verificar que el juego inicia sin errores en consola
- Avanzar hasta jueves y verificar energia = 4
- Verificar que guardar/cargar funciona
- Verificar que iconos renderizan

**Step 4: Commit final**

```bash
git add -A
git commit -m "build: final recompile after all optimization changes"
```

---

## RESUMEN DE CAMBIOS

| Task | Archivo | Cambio | Impacto |
|------|---------|--------|---------|
| 1 | recursos.ink | Nueva `subir_salud_mental()` | Salud mental ya no es one-way |
| 2 | dados.ink, jueves/viernes/sabado.ink | Conectar recovery a narrativa | 3 puntos de recuperacion |
| 3 | viernes.ink, sabado.ink | Recovery tunnels | Evita game-over instantaneo |
| 4 | dados.ink | Rebalancear desventaja | Pifia baja de 30.6% a ~14% |
| 5 | jueves.ink | Energia 3 -> 4 | Mas acciones en dia critico |
| 6 | jueves.ink, viernes.ink | Chance-gate fragmentos | Dano involuntario reducido |
| 7 | web/un_dia_mas.* | Recompilacion | Necesario |
| 8 | save-system.js | Fix save lock leaks | Saves ya no se bloquean |
| 9 | game.js, stats-panel.js | Centralizar previousStats | Elimina desincronizacion |
| 10 | game.js, notification-system.js | Scope lucide refresh | Menos DOM scans |
| 11 | portrait-system.js | Debounce resize | Menos reflows |
| 12 | Todos | Verificacion final | QA |

## CORRECCIONES AL ANALISIS PREVIO

**Ixchel SI es opcion de vinculo** (main.ink:229-235). El analisis previo decia que `final_tejido` estaba bloqueado pero es incorrecto - Ixchel esta disponible como quinta opcion en creacion de personaje.

**Save lock SI se resetea en catch** (save-system.js:109,139). El bug real es mas estrecho: solo los `return false` intermedios (lineas 90, 99, 125, 132) no resetean el lock.
