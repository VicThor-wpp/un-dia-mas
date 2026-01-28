# Un Día Más - Mejoras Narrativa y Mecánicas - Plan de Implementación

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Amplificar el impacto narrativo, optimizar mecánicas de juego, y mejorar el enganche del jugador a través de feedback visible, uso expandido de dados, y consecuencias encadenadas.

**Architecture:** Modificaciones modulares a archivos Ink existentes, añadiendo nuevas escenas, expandiendo el sistema de dados, e implementando feedback narrativo en thresholds de stats. Cada tarea es independiente y puede commitearse por separado.

**Tech Stack:** Ink (Inkle Studios), inklecate (compilador), JavaScript runtime existente (prototype/web/).

---

## Fase 1: Feedback Inmediato al Jugador (Impacto Alto, Esfuerzo Bajo)

### Task 1: Sistema de Thresholds Narrativos para Conexión

**Files:**
- Modify: `prototype/ink/mecanicas/recursos.ink:1-50`
- Test: Compilar con `inklecate` y verificar no hay errores

**Step 1: Leer archivo actual de recursos**

Verificar estructura actual de `subir_conexion()` y `bajar_conexion()`.

**Step 2: Implementar feedback narrativo en subir_conexion**

```ink
=== function subir_conexion(cantidad) ===
~ temp conexion_antes = conexion
~ conexion += cantidad
{conexion > 10: ~ conexion = 10}

// Feedback narrativo en thresholds
{
- conexion >= 7 && conexion_antes < 7:
    # STAT_THRESHOLD
    Algo cambió.
    Ya no te sentís tan solo.
    El barrio te conoce. Vos conocés al barrio.

- conexion >= 5 && conexion_antes < 5:
    # STAT_THRESHOLD
    Hay gente.
    No muchos. Pero hay.
}
```

**Step 3: Implementar feedback narrativo en bajar_conexion**

```ink
=== function bajar_conexion(cantidad) ===
~ temp conexion_antes = conexion
~ conexion -= cantidad
{conexion < 0: ~ conexion = 0}

// Feedback narrativo en thresholds críticos
{
- conexion <= 2 && conexion_antes > 2:
    # STAT_THRESHOLD
    El aislamiento se siente físico.
    Pasás por la calle y nadie te mira.
    O quizás vos no mirás.
}
```

**Step 4: Compilar y verificar**

Run: `inklecate prototype/ink/main.ink`
Expected: Sin errores de compilación

**Step 5: Commit**

```bash
git add prototype/ink/mecanicas/recursos.ink
git commit -m "feat: add narrative feedback on conexion thresholds"
```

---

### Task 2: Sistema de Thresholds Narrativos para Llama

**Files:**
- Modify: `prototype/ink/mecanicas/recursos.ink`

**Step 1: Añadir feedback a subir_llama**

```ink
=== function subir_llama(cantidad) ===
~ temp llama_antes = llama
~ llama += cantidad
{llama > 10: ~ llama = 10}

{
- llama >= 7 && llama_antes < 7:
    # STAT_THRESHOLD
    La llama arde.
    No es solo esperanza.
    Es algo más. Algo colectivo.

- llama >= 5 && llama_antes < 5:
    # STAT_THRESHOLD
    Hay una llama.
    Pequeña. Pero viva.
}
```

**Step 2: Añadir feedback a bajar_llama**

```ink
=== function bajar_llama(cantidad) ===
~ temp llama_antes = llama
~ llama -= cantidad
{llama < 0: ~ llama = 0}

{
- llama <= 2 && llama_antes > 2:
    # STAT_THRESHOLD
    La llama se apaga.
    El frío entra.
    Es difícil creer en algo.
}
```

**Step 3: Compilar y verificar**

Run: `inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 4: Commit**

```bash
git add prototype/ink/mecanicas/recursos.ink
git commit -m "feat: add narrative feedback on llama thresholds"
```

---

### Task 3: Mini-Cliffhangers Entre Días

**Files:**
- Modify: `prototype/ink/dias/lunes.ink` (final del día)
- Modify: `prototype/ink/dias/martes.ink` (final del día)
- Modify: `prototype/ink/dias/miercoles.ink` (final del día)
- Modify: `prototype/ink/dias/jueves.ink` (final del día)

**Step 1: Leer estructura actual de transiciones entre días**

Identificar knots de cierre de cada día (ej: `fragmento_lunes`, `fragmento_martes`, etc.)

**Step 2: Añadir hook al final del lunes**

En el fragmento nocturno del lunes, antes de `-> martes_amanecer`:

```ink
=== fragmento_lunes_hook ===
// Después del fragmento nocturno

El celular vibra.

Un mensaje de grupo del laburo.

"Mañana reunión de área. Obligatoria."

No dice más.

* [Dormir inquieto] -> martes_amanecer
```

**Step 3: Añadir hook al final del martes**

```ink
=== fragmento_martes_hook ===
El celular vibra.

Es de RRHH.

"Confirmamos reunión mañana 11 AM. Sala 3."

No dice más.
Pero sabés que no es bueno.

* [Intentar dormir] -> miercoles_amanecer
```

**Step 4: Añadir hook al final del jueves**

```ink
=== fragmento_jueves_hook ===
{conte_a_alguien:
    El celular vibra.

    {vinculo == "sofia":
        Sofía: "Mañana necesito hablar. Es sobre la olla. Urgente."
    }
    {vinculo == "elena":
        Elena: "Mañana te llamo temprano. Hay algo."
    }
    {vinculo == "diego":
        Diego: "Che, mañana te busco. Tengo una idea."
    }
}

* [Dormir] -> viernes_amanecer
```

**Step 5: Compilar y verificar**

Run: `inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 6: Commit**

```bash
git add prototype/ink/dias/lunes.ink prototype/ink/dias/martes.ink prototype/ink/dias/miercoles.ink prototype/ink/dias/jueves.ink
git commit -m "feat: add cliffhanger hooks between days for tension"
```

---

### Task 4: Sistema de "Ecos" - NPCs Mencionan Acciones Pasadas

**Files:**
- Modify: `prototype/ink/dias/sabado.ink`
- Modify: `prototype/ink/ubicaciones/olla.ink`

**Step 1: Añadir eco de Sofía el sábado**

En escena de asamblea sábado, cuando ves a Sofía:

```ink
=== sabado_ver_sofia ===
Sofía te ve llegar.

{ayude_en_olla && veces_que_ayude >= 2:
    "Che, gracias por el viernes. No sé cómo hubiéramos hecho sin vos."

    Alguien notó.
    Alguien se acuerda.

    ~ sofia_relacion += 1
}
{ayude_en_olla && veces_que_ayude == 1:
    "Qué bueno que viniste."

    Un reconocimiento simple.
    Pero real.
}
{not ayude_en_olla:
    "Hola."

    Nada más.
    No hay mucho que decir.
}
```

**Step 2: Añadir eco de Elena en olla viernes**

```ink
=== viernes_olla_elena_eco ===
{elena_conto_historia:
    Elena te ve llegar.

    "Viniste."

    No es sorpresa.
    Es algo más.
    Como si hubiera esperado que vinieras.
    Como si la historia del 2002 hubiera funcionado.
}
```

**Step 3: Añadir eco de Diego**

```ink
=== sabado_ver_diego ===
Diego está en la asamblea.

{hable_con_diego_profundo:
    Te ve y se acerca.

    "Che, lo que hablamos el otro día... me quedó dando vueltas.
    Creo que tenías razón."

    ~ diego_relacion += 1
}
{conte_a_alguien && vinculo == "diego":
    Diego asiente cuando te ve.

    Hay algo compartido ahí.
    Un secreto. Tu despido.
    Él sabe. Y vos sabés que él sabe.
}
```

**Step 4: Compilar y verificar**

Run: `inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 5: Commit**

```bash
git add prototype/ink/dias/sabado.ink prototype/ink/ubicaciones/olla.ink
git commit -m "feat: add echo system - NPCs reference past player actions"
```

---

## Fase 2: Expandir Crisis Viernes y Decisiones Críticas

### Task 5: Nueva Opción "Cancelar la Olla" en Crisis Viernes

**Files:**
- Modify: `prototype/ink/dias/viernes.ink`

**Step 1: Leer escena actual de crisis viernes**

Ubicar el knot de crisis donde Sofía presenta el problema.

**Step 2: Añadir nueva opción de cancelar**

```ink
=== viernes_crisis_opciones ===
Sofía te mira. A todos.

"No tenemos para hoy. Las donaciones no alcanzaron.
Hay 40 personas que van a venir. ¿Qué hacemos?"

* [Proponer colecta callejera] # EFECTO:conexion+ # EFECTO:dignidad-
    -> viernes_colecta

* [Proponer ir puerta a puerta con vecinos] # EFECTO:conexion+
    -> viernes_vecinos

* [Proponer cancelar por hoy] # EFECTO:llama- # EFECTO:dignidad+
    -> viernes_cancelar_olla

* [Quedarte callado]
    -> viernes_silencio
```

**Step 3: Implementar escena de cancelar olla**

```ink
=== viernes_cancelar_olla ===
"Capaz que... capaz que hoy no."

Silencio.

Sofía te mira.

"¿Cancelar?"

"No podemos dar lo que no tenemos. Mejor cerrar hoy que... que improvisar mal."

~ bajar_llama(2)
~ subir_dignidad(1)

Elena suspira.
"Tiene razón. Una vez cerramos en el 2002. Fue un día. Volvimos al otro."

Sofía se sienta.
Tiene la cara de alguien que no durmió.

"Okay. Cerramos."

~ olla_cerro_viernes = true

Diego no dice nada.
Nadie dice nada.

El silencio pesa.

* [Quedarte con ellos] -> viernes_quedarse_cerrado
* [Irte] -> viernes_irte_cerrado
```

**Step 4: Añadir variable de tracking**

En `variables.ink`:

```ink
VAR olla_cerro_viernes = false
```

**Step 5: Compilar y verificar**

Run: `inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 6: Commit**

```bash
git add prototype/ink/dias/viernes.ink prototype/ink/variables.ink
git commit -m "feat: add 'cancel olla' option in friday crisis - moral dilemma"
```

---

### Task 6: Consecuencias de Cancelar en Sábado

**Files:**
- Modify: `prototype/ink/dias/sabado.ink`

**Step 1: Añadir referencia a cierre del viernes en asamblea**

```ink
=== sabado_asamblea_inicio ===
La asamblea empieza.

{olla_cerro_viernes:
    El aire está raro.
    Ayer la olla cerró.
    Primera vez en meses.

    Sofía está callada.
    Elena tiene cara de preocupación.

    "Bueno... tenemos que hablar de lo de ayer."

    -> sabado_asamblea_post_cierre
}

// Flujo normal si no cerró
-> sabado_asamblea_normal
```

**Step 2: Implementar escena post-cierre**

```ink
=== sabado_asamblea_post_cierre ===
Sofía suspira.

"Ayer cerramos. Lo saben.
La pregunta es: ¿qué hacemos para que no pase de nuevo?"

{vos_propusiste_cerrar:
    Te miran.
    Vos propusiste cerrar.
    Ahora te toca proponer qué sigue.

    * [Proponer sistema de reserva] -> asamblea_propuesta_reserva
    * [Proponer red de donantes fijos] -> asamblea_propuesta_donantes
    * [Quedarte callado] -> asamblea_silencio_culpa
}
{not vos_propusiste_cerrar:
    -> asamblea_discusion_cierre
}
```

**Step 3: Compilar y verificar**

Run: `inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 4: Commit**

```bash
git add prototype/ink/dias/sabado.ink
git commit -m "feat: add saturday consequences for friday olla closure"
```

---

## Fase 3: Expandir Uso de Sistema de Dados

### Task 7: Chequeo de Dados en Conversación Profunda con Elena

**Files:**
- Modify: `prototype/ink/dias/jueves.ink`
- Reference: `prototype/ink/mecanicas/dados.ink`

**Step 1: Identificar escena de charla con Elena el jueves**

**Step 2: Añadir chequeo de dados para profundidad de conversación**

```ink
=== jueves_charla_elena ===
Estás en la cocina de la olla.
Elena pela papas a tu lado.

~ temp modificador = 0
{elena_relacion >= 3: ~ modificador = 1}
{escuche_sobre_2002: ~ modificador = modificador + 1}

~ temp resultado = chequeo(modificador, 4)

{
- resultado == 2:  // Crítico
    Elena para de pelar.
    Te mira.

    "Vos me hacés acordar a Raúl."

    Pausa larga.

    "Él también se sentaba así. Pelando. Sin decir nada.
    Pero estando."

    Se le humedecen los ojos.
    No dice más.
    No hace falta.

    ~ elena_relacion += 2
    ~ idea_pedir_no_debilidad = true

    # IDEA: "PEDIR AYUDA NO ES DEBILIDAD"

    -> jueves_elena_fin

- resultado == 1:  // Éxito
    Elena te cuenta cosas.
    De cómo era el barrio antes.
    De los que ya no están.

    Hay algo cómodo en el silencio compartido.

    ~ elena_relacion += 1

    -> jueves_elena_fin

- resultado == -1:  // Fumble
    Te cortás el dedo con el cuchillo.

    "Pará, pará."

    Elena te cura con alcohol.
    Duele.

    "Despacio, pibe. Esto no es carrera."

    Es un momento íntimo.
    Raro. Pero íntimo.

    ~ elena_relacion += 1

    -> jueves_elena_fin

- else:  // Fallo
    Pelás en silencio.
    Elena también.

    No está mal.
    A veces el silencio es suficiente.

    -> jueves_elena_fin
}
```

**Step 3: Compilar y verificar**

Run: `inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 4: Commit**

```bash
git add prototype/ink/dias/jueves.ink
git commit -m "feat: add dice check in Elena deep conversation - varied outcomes"
```

---

### Task 8: Chequeo de Dados en Propuesta de Asamblea

**Files:**
- Modify: `prototype/ink/dias/sabado.ink`

**Step 1: Añadir chequeo cuando proponés en asamblea**

```ink
=== sabado_asamblea_proponer ===
Te levantás.
Todos te miran.

~ temp modificador = 0
{veces_que_ayude >= 2: ~ modificador = 1}  // Tenés credibilidad
{participe_antes: ~ modificador = modificador + 1}
{sofia_relacion >= 4: ~ modificador = modificador + 1}

~ temp resultado = chequeo(modificador, 5)

{
- resultado == 2:  // Crítico
    Las palabras salen.
    No sabés de dónde.
    Pero salen.

    Hablás de la semana.
    De lo que perdiste.
    De lo que encontraste.

    Cuando terminás, hay silencio.
    Después, aplausos.

    Sofía tiene lágrimas.

    ~ subir_llama(2)
    ~ subir_conexion(2)
    ~ subir_dignidad(1)

    -> asamblea_exito_total

- resultado == 1:  // Éxito
    Proponés algo.
    Un sistema de turnos.
    Una red de ayuda.
    Algo.

    La gente asiente.
    No es revolución.
    Pero es algo.

    ~ subir_llama(1)
    ~ subir_conexion(1)

    -> asamblea_exito

- resultado == 0:  // Fallo
    Empezás a hablar.
    Te trabás.

    Sofía interviene, suave.
    "Gracias. ¿Alguien más?"

    Te sentás.
    No estuvo mal.
    Pero tampoco estuvo bien.

    -> asamblea_continua

- else:  // Fumble
    Te levantás.
    Abrís la boca.

    Nada sale.

    Te sentás de nuevo.
    Nadie dice nada.

    ~ bajar_dignidad(1)

    -> asamblea_continua
}
```

**Step 2: Compilar y verificar**

Run: `inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 3: Commit**

```bash
git add prototype/ink/dias/sabado.ink
git commit -m "feat: add dice check for assembly proposal - varied outcomes"
```

---

## Fase 4: Domingo Encuentro Grupal y Final LA LLAMA

### Task 9: Escena de Encuentro Grupal Domingo

**Files:**
- Modify: `prototype/ink/dias/domingo.ink`

**Step 1: Añadir escena de encuentro antes de evaluación final**

```ink
=== domingo_encuentro_grupo ===
Pasás por la olla.
No hay reunión hoy. Pero hay gente.

{participe_asamblea && ayude_en_olla:
    Sofía está afuera.
    Elena toma mate en la vereda.
    Diego ordena cosas.
    {marcos_vino_a_asamblea: Marcos está parado lejos, pero ahí.}

    Te ven.

    * [Acercarte]
        -> domingo_cierre_red
    * [Saludar de lejos y seguir]
        -> domingo_cierre_distante
}
{participe_asamblea && not ayude_en_olla:
    Hay gente.
    Te miran.
    Saludan, pero...
    Hay algo raro.
    No sos parte. No del todo.

    * [Acercarte igual] -> domingo_cierre_intento
    * [Seguir de largo] -> domingo_cierre_distante
}
{not participe_asamblea:
    La olla está cerrada.
    No hay nadie.
    O quizás hay, pero no te ven.
    O no te buscan.

    * [Seguir] -> domingo_tarde
}
```

**Step 2: Implementar cierre de red**

```ink
=== domingo_cierre_red ===
Te acercás.

Sofía te pasa un mate.
Elena te hace lugar en el banco.
Diego asiente.

{marcos_vino_a_asamblea:
    Marcos te mira desde lejos.
    Levanta la mano.
    Es un gesto mínimo.
    Pero es algo.
}

Nadie dice nada importante.
Pero están.
Y vos estás.

Esto es algo.

~ subir_conexion(1)

* [Quedarte un rato] -> domingo_tarde
```

**Step 3: Compilar y verificar**

Run: `inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 4: Commit**

```bash
git add prototype/ink/dias/domingo.ink
git commit -m "feat: add sunday group encounter scene - visual closure"
```

---

### Task 10: Nuevo Final Oculto "LA LLAMA"

**Files:**
- Modify: `prototype/ink/finales/finales.ink`
- Modify: `prototype/ink/variables.ink`

**Step 1: Añadir función para verificar todas las ideas**

En `variables.ink`:

```ink
=== function tiene_todas_ideas() ===
~ return idea_tengo_tiempo && idea_pedir_no_debilidad && idea_hay_cosas_juntos && idea_red_o_nada
```

**Step 2: Añadir evaluación de final LA LLAMA antes de LA RED**

En `finales.ink`, al inicio de `evaluar_final`:

```ink
=== evaluar_final ===

// FINAL OCULTO - Requiere perfección
{
    conexion >= 9
    && llama >= 8
    && veces_que_ayude >= 3
    && participe_asamblea
    && marcos_vino_a_asamblea
    && sofia_relacion >= 4
    && elena_relacion >= 4
    && tiene_todas_ideas():
    -> final_la_llama
}

// Luego los finales normales...
{conexion >= 7 && llama >= 5 && ayude_en_olla:
    -> final_red
}
// ... resto igual
```

**Step 3: Implementar final LA LLAMA**

```ink
=== final_la_llama ===

# FINAL: LA LLAMA

El lunes llega.

No tenés laburo.
Pero tenés algo que pocos tienen.

La olla no solo sobrevivió.
Creció.

La asamblea no fue solo un evento.
Fue el principio.

Sofía te mira diferente ahora.
"Sos parte del equipo."

Elena te dijo: "Raúl estaría orgulloso."

Diego ya no se siente tan solo.
"Gracias por bancarme."

{marcos_vino_a_asamblea:
    Marcos volvió.
    De a poco. Pero volvió.
    "Capaz que hay algo," dijo ayer.
    Capaz.
}

Y hay una llama.

No es esperanza ingenua.
No es ilusión.

Es conocimiento.
De que juntos, hay algo.

El sistema no cambió.
No va a cambiar mañana.
Quizás nunca.

Pero ustedes sí cambiaron.

Y la llama no se apaga.

Los tres meses empiezan.
No sabés qué viene.
Pero sabés con quién vas.

# FIN - "Prendimos fuego"

-> END
```

**Step 4: Compilar y verificar**

Run: `inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 5: Commit**

```bash
git add prototype/ink/finales/finales.ink prototype/ink/variables.ink
git commit -m "feat: add hidden ending LA LLAMA - requires near-perfect playthrough"
```

---

## Fase 5: Sistema de Pequeñas Victorias

### Task 11: Implementar Tracking de Pequeñas Victorias

**Files:**
- Modify: `prototype/ink/variables.ink`
- Modify: `prototype/ink/ubicaciones/casa.ink`
- Modify: `prototype/ink/finales/finales.ink`

**Step 1: Añadir variable de tracking**

En `variables.ink`:

```ink
VAR pequenas_victorias = 0
```

**Step 2: Añadir incrementos en acciones pequeñas**

En escenas de casa y rutinas:

```ink
// En casa_despertar o similar
=== casa_despertar_mejorado ===
Te despertás.

* [Levantarte y bañarte]
    Te bañás.
    El agua caliente ayuda.
    ~ pequenas_victorias += 1
    -> casa_desayuno

* [Quedarte en cama un rato]
    -> casa_quedarse
```

```ink
// En escena de cocinar
=== casa_cocinar ===
* [Cocinar algo]
    Cocinás.
    No es gourmet.
    Pero es comida hecha por vos.
    ~ pequenas_victorias += 1
    -> casa_comer

* [Pedir delivery / comer cualquier cosa]
    -> casa_comer_rapido
```

**Step 3: Añadir referencia en finales**

En todos los finales, añadir bloque condicional:

```ink
{pequenas_victorias >= 8:
    No salvaste el mundo.
    No cambiaste el sistema.

    Pero te levantaste.
    Te bañaste.
    Cocinaste.
    Saliste.

    Eso, a veces, es todo.
}
```

**Step 4: Compilar y verificar**

Run: `inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 5: Commit**

```bash
git add prototype/ink/variables.ink prototype/ink/ubicaciones/casa.ink prototype/ink/finales/finales.ink
git commit -m "feat: add small victories tracking system"
```

---

## Fase 6: Flashbacks Según Pérdida Elegida

### Task 12: Implementar Flashbacks en Momento de Despido

**Files:**
- Modify: `prototype/ink/dias/miercoles.ink`

**Step 1: Añadir flashbacks después del despido**

Después del knot `miercoles_salida`, añadir:

```ink
=== miercoles_flashback ===
Salís del edificio.
El sol pega.
Es mediodía.

{perdida == "familiar":
    Por un segundo, ves a tu vieja en la calle.
    No es ella. No puede ser.
    Pero por un segundo...

    Recordás cuando te dijo:
    "Mientras tengas laburo, estás bien."

    Ya no tenés laburo.

    El fantasma se desvanece.
}

{perdida == "relacion":
    Pensás en llamar a alguien.
    Por un segundo, tu dedo va al contacto.
    Todavía está ahí.
    No lo borraste.

    No llamás.

    Pero por un segundo, quisiste.
}

{perdida == "futuro":
    Recordás cuando tenías un plan.
    Ibas a ser algo.
    Tenías una forma.

    Ahora no hay forma.
    Solo hay esto.
    Un mediodía, sin laburo.
}

{perdida == "vacio":
    Hay algo.
    No sabés qué.
    Ese vacío que siempre estuvo.
    Ahora más grande.

    O quizás siempre fue así de grande.
    Y recién ahora lo ves.
}

-> miercoles_salida_continua
```

**Step 2: Compilar y verificar**

Run: `inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 3: Commit**

```bash
git add prototype/ink/dias/miercoles.ink
git commit -m "feat: add flashbacks based on chosen loss in character creation"
```

---

## Resumen de Tareas

| Task | Descripción | Archivos | Commits |
|------|-------------|----------|---------|
| 1 | Thresholds narrativos conexión | recursos.ink | 1 |
| 2 | Thresholds narrativos llama | recursos.ink | 1 |
| 3 | Cliffhangers entre días | lunes/martes/miercoles/jueves.ink | 1 |
| 4 | Sistema de "Ecos" NPCs | sabado.ink, olla.ink | 1 |
| 5 | Opción cancelar olla viernes | viernes.ink, variables.ink | 1 |
| 6 | Consecuencias cancelar sábado | sabado.ink | 1 |
| 7 | Dados en charla Elena | jueves.ink | 1 |
| 8 | Dados en propuesta asamblea | sabado.ink | 1 |
| 9 | Encuentro grupal domingo | domingo.ink | 1 |
| 10 | Final oculto LA LLAMA | finales.ink, variables.ink | 1 |
| 11 | Pequeñas victorias | variables.ink, casa.ink, finales.ink | 1 |
| 12 | Flashbacks según pérdida | miercoles.ink | 1 |

**Total estimado**: ~25-30 horas de implementación
**Commits**: 12 commits atómicos

---

## Verificación Final

Después de todos los tasks:

```bash
# Compilar todo
inklecate -o prototype/web/un_dia_mas.json prototype/ink/main.ink

# Crear JS wrapper
echo "var storyContent = $(cat prototype/web/un_dia_mas.json);" > prototype/web/un_dia_mas.js

# Verificar que no hay errores
echo "Compilación exitosa si no hay errores arriba"
```

---

## Notas para el Implementador

1. **Orden de implementación**: Las tareas son independientes, pero recomiendo seguir el orden para build incremental.

2. **Testing manual**: Después de cada commit, probar la ruta afectada en el navegador.

3. **Variables nuevas**: Añadir todas las nuevas VAR en `variables.ink`, nunca en otros archivos.

4. **Estilo de escritura**: Mantener el estilo existente - frases cortas, sin puntuación excesiva, voz uruguaya.

5. **Tags especiales**: Usar `# STAT_THRESHOLD`, `# IDEA:`, `# DECISIÓN CRÍTICA` para que el UI pueda capturar momentos importantes.
