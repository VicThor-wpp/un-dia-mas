# Corrección Integral: Auditoría Un Día Más

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Corregir todos los problemas identificados en la auditoría: intro mediocre, finales inalcanzables, túneles rotos, placeholders vacíos, y opciones sin consecuencias.

**Architecture:** Modificaciones quirúrgicas a archivos Ink existentes. El intro se reestructura para enganchar en los primeros 5 minutos. Los finales faltantes se conectan. Los túneles se cierran correctamente. Las opciones cosméticas ganan consecuencias reales.

**Tech Stack:** Ink (Inkle), inklecate compiler

---

## FASE 1: INTRO - Arreglar el Flujo de Enganche

### Task 1: Compactar el Sueño Onírico

**Files:**
- Modify: `prototype/ink/main.ink:58-117`

**Objetivo:** Reducir las 4 preguntas sobre traumas a 2 máximo. El jugador debe despertar en menos de 2 minutos de lectura.

**Step 1: Reescribir intro onírico**

Cambiar de 4 preguntas a 2. El sueño actual (líneas 65-114) tiene:
1. Pérdida (4 opciones)
2. Atadura (4 opciones)
3. Posición (4 opciones)
4. Vínculo (5 opciones)

Consolidar a:
1. Pérdida/Atadura combinadas (4 opciones que setean ambas)
2. Vínculo (5 opciones - este SÍ importa mecánicamente)

```ink
=== inicio ===

# UN DÍA MÁS
# AUDIO:bgm_sueno

Todavía no despertaste.

Fragmentos.

Una mano. Una calle. Una voz.

* [Tu madre esperando. El cepillo de dientes que quedó.]
    ~ perdida = "familiar"
    ~ atadura = "responsabilidad"
* [La valija sin abrir. El diploma en un cajón.]
    ~ perdida = "futuro"
    ~ atadura = "inercia"
* [El almacenero. La panadera. Las veredas rotas.]
    ~ perdida = "vacio"
    ~ atadura = "barrio"
* [El portón cerrado. Lo que no dijiste.]
    ~ perdida = "relacion"
    ~ atadura = "algo"

- "...hay que organizarse..."

La voz se pierde.

Una cara. Alguien del barrio.

* [Sofía. Un tupper que apareció en tu puerta.]
    ~ vinculo = "sofia"
    ~ posicion = "esperanzado"
* [Elena. "Mirá qué grande estás", te dijo.]
    ~ vinculo = "elena"
    ~ posicion = "quemado"
* [Diego. Le señalaste el camino. Te buscó después.]
    ~ vinculo = "diego"
    ~ posicion = "ajeno"
* [Marcos. El portón cerrado. Algo sin cerrar.]
    ~ vinculo = "marcos"
    ~ posicion = "ambiguo"
* [Ixchel. Trabaja en la olla. Seria. Sin sonrisas de compromiso.]
    ~ vinculo = "ixchel"
    ~ posicion = "esperanzado"

-

* [Despertar] -> lunes_amanecer
```

**Step 2: Verificar compilación**

Run: `inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 3: Commit**

```bash
git add prototype/ink/main.ink
git commit -m "refactor(intro): compact dream sequence from 4 to 2 choices

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>"
```

---

### Task 2: Añadir Hook Temprano con Amenaza Clara

**Files:**
- Modify: `prototype/ink/ubicaciones/casa.ink:8-45`

**Objetivo:** Introducir el rumor de despidos ANTES de salir de casa. Crear tensión desde el primer momento.

**Step 1: Añadir notificación de celular al despertar**

Después de la elección de levantarse, antes del baño, añadir:

```ink
=== casa_levantarse_rapido ===

Te levantás de una.
La disciplina del cuerpo que ya no pregunta.

{tiene_laburo: Años de lo mismo. El cuerpo sabe.}
{not tiene_laburo: El cuerpo todavía no sabe que ya no hace falta.}

~ pequenas_victorias += 1

{tiene_laburo && dia_actual == 1:
    El celular vibra.
    Un mensaje del grupo del laburo.

    "Ojo hoy. Andan raros los jefes."

    No dice más.
    Pero algo se te aprieta en el pecho.
}

-> casa_banarse
```

**Step 2: Verificar compilación**

Run: `inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 3: Commit**

```bash
git add prototype/ink/ubicaciones/casa.ink
git commit -m "feat(intro): add early threat hook on Monday morning

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>"
```

---

### Task 3: Primer Chequeo de Dados en los Primeros 10 Minutos

**Files:**
- Modify: `prototype/ink/dias/lunes.ink:27-36`

**Objetivo:** Mover el primer chequeo de dados al bondi (antes del trabajo). El jugador ve las mecánicas funcionando temprano.

**Step 1: Hacer el encuentro en el bondi NO aleatorio**

El bondi ya tiene un chequeo en `bondi_esperar_hablar`. Forzar que la opción aparezca siempre (quitar el requisito de energía >= 3 para el primer día):

En `prototype/ink/ubicaciones/bondi.ink:19`, cambiar:

```ink
* {energia >= 3} [Hablar con alguien] # COSTO:1 # DADOS:conexion # EFECTO:conexion+
```

A:

```ink
* {energia >= 3 || dia_actual == 1} [Hablar con alguien] # COSTO:1 # DADOS:conexion # EFECTO:conexion+
```

Esto garantiza que el lunes el jugador pueda elegir hablar, vea un chequeo, y entienda el sistema.

**Step 2: Verificar compilación**

Run: `inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 3: Commit**

```bash
git add prototype/ink/ubicaciones/bondi.ink
git commit -m "feat(intro): ensure first dice check available on Monday

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>"
```

---

## FASE 2: FINALES - Conectar los Inalcanzables

### Task 4: Añadir Evaluaciones Faltantes en domingo.ink

**Files:**
- Modify: `prototype/ink/dias/domingo.ink:450-521`

**Objetivo:** Los finales `final_despertar`, `final_juan_migrante`, y `final_resistencia_silenciosa` tienen funciones de evaluación pero nunca se llaman.

**Step 1: Añadir evaluaciones faltantes**

Después de línea 453 (después del check de llama <= 0), añadir:

```ink
// FINAL RESISTENCIA SILENCIOSA - Ayudaste sin participar en asamblea
{evaluar_resistencia_silenciosa():
    -> final_resistencia_silenciosa
}

// FINAL DESPERTAR - Te recuperaste de una espiral
{evaluar_despertar():
    -> final_despertar
}

// FINAL JUAN MIGRANTE - Juan se fue y te despediste
{evaluar_juan_migrante():
    -> final_juan_migrante
}
```

El orden de evaluación importa. Estos finales son específicos y deben ir ANTES de los genéricos.

**Step 2: Verificar compilación**

Run: `inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 3: Commit**

```bash
git add prototype/ink/dias/domingo.ink
git commit -m "fix(endings): connect unreachable endings (despertar, juan, resistencia)

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>"
```

---

### Task 5: Crear Contenido para Finales Faltantes

**Files:**
- Modify: `prototype/ink/finales/finales.ink` (añadir al final)

**Objetivo:** Los finales referenciados necesitan existir. Verificar que existen y si no, crearlos.

**Step 1: Verificar existencia de finales**

Buscar en finales.ink:
- `=== final_resistencia_silenciosa ===`
- `=== final_despertar ===`
- `=== final_juan_migrante ===`

Si no existen, crear:

```ink
=== final_resistencia_silenciosa ===
# ENDING:final_resistencia_silenciosa

# FINAL: RESISTENCIA SILENCIOSA

El lunes llega.

No fuiste a la asamblea.
No hablaste en público.
No levantaste la mano.

* [...]
-

Pero ayudaste.
{veces_que_ayude} veces, para ser exactos.

Pelaste papas.
Serviste platos.
Escuchaste.

* [...]
-

Sofía lo sabe.
"No hace falta gritar para estar."

Elena lo sabe.
"Hay gente que sostiene desde atrás. Son los que no se ven."

* [...]
-

El sistema no te ve.
La olla sí.

Y eso, por ahora, alcanza.

# FIN - "Desde atrás"

-> END

=== final_despertar ===
# ENDING:final_despertar

# FINAL: EL DESPERTAR

El lunes llega.

Hubo un momento en que todo se apagaba.
La inercia te comía.
El cuerpo se movía solo.
La cabeza, en ningún lado.

* [...]
-

Pero algo pasó.

{vinculo == "sofia": Sofía llamó.}
{vinculo == "elena": Elena apareció.}
{vinculo == "diego": Diego insistió.}
{vinculo == "marcos": Marcos, de todos, Marcos.}
{vinculo == "ixchel": Ixchel te miró y dijo: "Todavía estás."}

* [...]
-

No fue magia.
Fue trabajo.
Fue elegir levantarse cuando el cuerpo decía que no.

* [...]
-

Todavía no sabés qué viene.
Pero despertaste.

Y eso, hoy, es todo.

# FIN - "Desperté"

-> END

=== final_juan_migrante ===
# ENDING:final_juan_migrante

# FINAL: EL QUE SE FUE

El lunes llega.

Juan ya está en España.

El mensaje llegó ayer:
"Llegué bien. Acá hace frío pero hay laburo."

* [...]
-

Te acordás de las charlas.
Del almuerzo en el laburo.
De cuando te dijo que tenía miedo.

* [...]
-

"Cuidate, bo. Y si algún día..."

No terminó la frase.
No hacía falta.

* [...]
-

Hay gente que se va.
Hay gente que se queda.

Ninguna opción es la correcta.
Ninguna es la equivocada.

* [...]
-

El barrio sigue.
La olla sigue.
Vos seguís.

Y Juan, desde lejos, también sigue.

# FIN - "Distintos caminos"

-> END
```

**Step 2: Verificar compilación**

Run: `inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 3: Commit**

```bash
git add prototype/ink/finales/finales.ink
git commit -m "feat(endings): add content for resistencia_silenciosa, despertar, juan_migrante

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>"
```

---

## FASE 3: TÚNELES ROTOS

### Task 6: Arreglar Túneles en jueves.ink

**Files:**
- Modify: `prototype/ink/dias/jueves.ink:713-820`

**Objetivo:** Los fragmentos nocturnos en jueves tienen `->->` que retornan al caller, pero algunos branches con `chance()` no tienen destino claro.

**Step 1: Verificar estructura de fragmentos**

Los fragmentos están estructurados correctamente como túneles. El `->->` retorna al caller (`jueves_noche`). El problema es que `chance()` puede ejecutar código sin cambiar el flujo, lo cual es correcto.

Verificar que cada fragmento termina en `->->`:
- fragmento_marcos_jueves: líneas 686-758 ✓
- fragmento_sofia_jueves: líneas 760-820 ✓
- fragmento_elena_jueves: líneas 822-890 ✓
- fragmento_diego_jueves: (similar)

Los túneles están correctos. El agente de auditoría reportó un falso positivo. Los `->->` son retornos válidos de túnel.

**Step 2: Verificar compilación para confirmar**

Run: `inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 3: No commit necesario**

Si no hay errores, los túneles están bien. Documentar que fue falso positivo.

---

## FASE 4: OPCIONES SIN CONSECUENCIAS

### Task 7: Añadir Consecuencias a Decisiones del Lunes

**Files:**
- Modify: `prototype/ink/dias/lunes.ink:72-84`

**Objetivo:** Las tres opciones de `lunes_pre_almuerzo_decision` llevan al mismo lugar sin registrar la elección.

**Step 1: Añadir variables de tracking**

En `prototype/ink/variables.ink`, verificar si existe variable para trackear esta decisión. Si no, usar el sistema existente.

La decisión ya tiene efectos a través de los tags (`# STAT:conexion`, `# EFECTO:conexion+`, etc.). El problema es que todas llevan a `lunes_almuerzo`.

Modificar para que la elección tenga eco narrativo en el almuerzo:

```ink
=== lunes_pre_almuerzo_decision ===

¿Qué hacés con la mirada del jefe?

* [Seguir laburando]
    ~ temp decision_jefe = "ignorar"
    Bajás la cabeza.
    Seguís con lo tuyo.
    -> lunes_almuerzo
* [Preguntarle a Juan] # STAT:conexion # EFECTO:conexion+
    ~ temp decision_jefe = "juan"
    -> juan_preguntar_sobre_jefe ->
    -> lunes_almuerzo
* {energia >= 2} [Hablar con el jefe] # COSTO:1 # DADOS:dignidad # EFECTO:dignidad?
    ~ temp decision_jefe = "jefe"
    -> laburo_hablar_con_jefe ->
    -> lunes_almuerzo
```

**Problema:** Las variables `temp` no persisten entre knots. Necesitamos una variable global o usar el sistema de tracking existente.

Mejor solución: usar las variables que ya se setean en los túneles (`hable_con_juan_sobre_rumores` ya existe).

En `lunes_almuerzo`, añadir eco:

```ink
=== lunes_almuerzo ===

# ALMUERZO

12:30.
Hora de comer.

{hable_con_juan_sobre_rumores:
    Juan te mira.
    "¿Hablaste con el jefe?"
    No contestás.
}

* [Almorzar con Juan] # EFECTO:conexion+
    -> juan_almuerzo ->
    -> lunes_tarde
// ... resto igual
```

**Step 2: Verificar compilación**

Run: `inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 3: Commit**

```bash
git add prototype/ink/dias/lunes.ink
git commit -m "feat(narrative): add echo for Monday decision about boss

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>"
```

---

### Task 8: Añadir Consecuencias a Opciones del Barrio

**Files:**
- Modify: `prototype/ink/ubicaciones/barrio.ink:312-324`

**Objetivo:** Las opciones del kiosquero ("Sí, todo bien" vs "Ahí andamos") no tienen diferencia mecánica.

**Step 1: Añadir consecuencias**

```ink
{d6() == 6:
    El kiosquero te mira.
    "¿Todo bien? Te veo medio caído."

    * ["Sí, todo bien."]
        "Sí, todo bien."
        "Bueno."
        // Mentir aumenta inercia (el automatismo de responder bien)
        ~ aumentar_inercia(1)
        ->->
    * ["Ahí andamos."]
        "Ahí andamos. Perdí el laburo."
        "Uh. Está jodida la cosa."
        "Está jodida."
        "Bueno. Suerte."
        // Ser honesto sube conexión (el kiosquero ahora sabe)
        ~ subir_conexion(1)
        ~ conte_a_alguien = true
        ->->
- else:
    ->->
}
```

**Step 2: Verificar compilación**

Run: `inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 3: Commit**

```bash
git add prototype/ink/ubicaciones/barrio.ink
git commit -m "feat(choices): add mechanical consequences to kiosk conversation

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>"
```

---

### Task 9: Añadir Consecuencias a Opciones de la Olla

**Files:**
- Modify: `prototype/ink/ubicaciones/olla.ink:283-329`

**Objetivo:** Las tres opciones de ofrecer plata tienen `->->` sin diferencia narrativa posterior.

**Step 1: Añadir tracking y consecuencias**

```ink
=== olla_ofrecer_plata ===

{not tiene_laburo:
    No tenés nada. Sin indemnización.
    Pero querés aportar algo.
}

"¿Puedo aportar algo? Plata, digo."

Sofía te mira.

"Todo suma, pibe. Todo suma."

* [Dar algo chico]
    Le das lo que tenés en el bolsillo.
    No es mucho.
    "Gracias."
    ~ pequenas_victorias += 1
    ->->
* [Dar algo más] # COSTO:1 # STAT:conexion
    Le das un billete más grande.
    ~ energia -= 1
    "Gracias. En serio."
    ~ subir_conexion(1)
    ~ pequenas_victorias += 1
    ~ sofia_relacion += 1
    ->->
* [Pensarlo mejor]
    "Después te traigo algo."
    "Bueno."
    No suena convencida.
    // No hacer nada cuando prometiste tiene costo
    ~ aumentar_inercia(1)
    ->->
```

**Step 2: Verificar compilación**

Run: `inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 3: Commit**

```bash
git add prototype/ink/ubicaciones/olla.ink
git commit -m "feat(choices): add mechanical consequences to olla donation

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>"
```

---

## FASE 5: PLACEHOLDERS VACÍOS

### Task 10: Llenar Placeholders en casa.ink

**Files:**
- Modify: `prototype/ink/ubicaciones/casa.ink`

**Objetivo:** Hay múltiples `* [...]` seguidos de `-` sin contenido. Son pausas narrativas válidas pero podrían tener variación.

**Step 1: Revisar placeholders**

Los `* [...] -` son un patrón intencional de Ink para pausas narrativas (el jugador hace clic para continuar). Esto es CORRECTO, no un bug.

Verificar que cada `* [...]` tiene texto antes o después que justifique la pausa.

**Step 2: No modificar**

Los placeholders son pausas narrativas intencionales. No hay bug.

---

## FASE 6: CÓDIGO MUERTO

### Task 11: Limpiar Variable `despertar` No Usada

**Files:**
- Modify: `prototype/ink/mecanicas/dados.ink:8`

**Objetivo:** La variable `VAR despertar = 0` se declara pero nunca se usa.

**Step 1: Eliminar variable**

```ink
// Variable temporal para guardar resultado de última tirada
VAR ultima_tirada = 0
VAR ultimo_resultado = 0
// VAR despertar = 0  <- ELIMINAR
```

**Step 2: Verificar que no se usa en ningún lado**

Buscar "despertar" en todo el proyecto. Si solo aparece en la declaración, es seguro eliminar.

**Step 3: Verificar compilación**

Run: `inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 4: Commit**

```bash
git add prototype/ink/mecanicas/dados.ink
git commit -m "refactor: remove unused despertar variable

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>"
```

---

### Task 12: Limpiar Funciones de Sinergia No Usadas

**Files:**
- Modify: `prototype/ink/mecanicas/ideas.ink`

**Objetivo:** Las funciones `tiene_sinergia_colectiva()`, `tiene_sinergia_individual()`, `tiene_sinergia_politica()`, `tiene_conciencia_radical()` están definidas pero nunca se llaman.

**Step 1: Decidir si eliminar o integrar**

Estas funciones parecen ser parte de un sistema de sinergias de ideas que no se implementó completamente. Dos opciones:

A) Eliminar (código muerto)
B) Integrar en finales o chequeos

Dado que el sistema de ideas YA afecta el juego (ej: `idea_no_es_individual` protege la llama), estas funciones podrían usarse para finales.

Por ahora, comentar pero no eliminar:

```ink
// === FUNCIONES DE SINERGIA (sin usar - potencial futuro) ===
// === function tiene_sinergia_colectiva() ===
//     ~ return sinergia_colectiva >= 2

// === function tiene_sinergia_individual() ===
//     ~ return sinergia_individual >= 2

// ... etc
```

**Step 2: Verificar compilación**

Run: `inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 3: Commit**

```bash
git add prototype/ink/mecanicas/ideas.ink
git commit -m "refactor: comment out unused synergy functions for future use

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>"
```

---

## FASE 7: VERIFICACIÓN FINAL

### Task 13: Compilación y Test de Flujo Completo

**Files:**
- All modified files

**Step 1: Compilar**

Run: `inklecate -o prototype/web/un_dia_mas.json prototype/ink/main.ink`
Expected: Sin errores, archivo JSON generado

**Step 2: Generar JS wrapper**

Run en PowerShell:
```powershell
$json = Get-Content prototype/web/un_dia_mas.json -Raw
"var storyContent = $json;" | Out-File -Encoding utf8 prototype/web/un_dia_mas.js
```

**Step 3: Test manual**

Abrir `prototype/web/index.html` en navegador y verificar:
1. Intro compacto (2 decisiones antes de despertar)
2. Hook del celular aparece el lunes
3. Opción de hablar en el bondi disponible
4. Jugar hasta domingo y verificar que los nuevos finales son alcanzables

**Step 4: Commit final**

```bash
git add prototype/web/un_dia_mas.json prototype/web/un_dia_mas.js
git commit -m "build: compile updated story with all fixes

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>"
```

---

## Resumen de Cambios

| Archivo | Cambio |
|---------|--------|
| `main.ink` | Intro compactado de 4 a 2 decisiones |
| `casa.ink` | Hook temprano con mensaje de grupo |
| `bondi.ink` | Primer chequeo disponible el lunes |
| `domingo.ink` | 3 finales conectados |
| `finales.ink` | 3 finales nuevos con contenido |
| `lunes.ink` | Eco narrativo de decisión del jefe |
| `barrio.ink` | Consecuencias en conversación kiosquero |
| `olla.ink` | Consecuencias en donación |
| `dados.ink` | Variable `despertar` eliminada |
| `ideas.ink` | Funciones no usadas comentadas |

**Total:** 10 archivos modificados, 3 finales nuevos, intro reducido 50%.
