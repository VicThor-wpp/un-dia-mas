# Mejoras Narrativas e Impacto Emocional - Plan de Implementación

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Cerrar arcos narrativos huérfanos, agregar momentos emocionales faltantes, reforzar coherencia temática, y mejorar el pacing dramático del juego.

**Architecture:** Modificaciones al contenido Ink existente en `prototype/ink/`, agregando escenas nuevas en archivos de personajes y días, integrando llamadas desde los días correspondientes, y limpiando variables no utilizadas.

**Tech Stack:** Ink (Inkle), inklecate (compilador), sistema de tags PAUSA/CONTINUO existente.

---

## Contexto del Proyecto

"Un Día Más" es un juego narrativo sobre precariedad laboral y solidaridad barrial en Uruguay. El jugador es despedido el miércoles y debe decidir si conectar con redes comunitarias o aislarse. El juego tiene ~19,000 líneas de Ink, 11 NPCs, y 12 finales.

### Diagnóstico Realizado

1. **Juan tiene arco escrito pero sin payoff** - Sus variables post-despido (`juan_fue_a_olla`, `juan_tambien_despedido`) nunca se chequean
2. **Sofía nunca se quiebra** - Siempre funcional, falta vulnerabilidad
3. **Momentos emocionales clave faltan** - Protagonista nunca pide ayuda, asamblea no tiene momento colectivo dramatizado, antagonistas no son confrontados directamente
4. **Solo 2 PAUSA tags en todo el juego** - Pacing dramático insuficiente
5. **Temas presentes pero no explicitados** - Canales institucionales fallan sin explicación, género mencionado pero no desarrollado

---

## Mejoras a Implementar

### Categoría A: Arcos de Personajes

| ID | NPC | Descripción |
|----|-----|-------------|
| A1 | Juan | Cerrar arco con migración a España |
| A2 | Sofía | Escena de quiebre emocional |
| A3 | Marcos | Mostrar que está al borde |
| A4 | Elena | Fragmento de soledad real |

### Categoría B: Momentos Emocionales

| ID | Ubicación | Descripción |
|----|-----------|-------------|
| B1 | Protagonista | Escena pidiendo ayuda |
| B2 | Viernes | Dramatizar cierre de olla |
| B3 | Sábado | Momento colectivo en asamblea |
| B4 | Sábado | Confrontación con antagonista |

### Categoría C: Coherencia Temática

| ID | Tema | Descripción |
|----|------|-------------|
| C1 | Instituciones | Por qué canales formales fallan |
| C2 | Género | Visibilizar carga diferencial |

### Categoría D: Técnico

| ID | Descripción |
|----|-------------|
| D1 | Agregar PAUSA tags en momentos clave |
| D2 | Limpiar variables huérfanas de Juan |

---

## Task 1: Limpiar variables huérfanas de Juan (D2)

**Files:**
- Modify: `prototype/ink/variables.ink:95-101`
- Modify: `prototype/ink/personajes/juan.ink:1000-1021`
- Modify: `prototype/ink/dias/sabado.ink:57`

**Step 1: Identificar variables a eliminar**

Variables huérfanas (se setean pero nunca se chequean):
- `juan_fue_a_olla`
- `juan_tambien_despedido` (será reemplazada por `juan_migra`)
- `juan_ofrecio_changa`
- `juan_ofrecio_contacto`

**Step 2: Comentar la escena de invitar a la olla en sabado.ink**

En `prototype/ink/dias/sabado.ink`, línea 57, comentar o eliminar:
```ink
// REMOVIDO: Juan no se integra a la olla, su arco es migración
// -> juan_invitar_olla_sabado ->
```

**Step 3: Marcar variables como deprecadas en variables.ink**

En `prototype/ink/variables.ink`, reemplazar líneas 95-101:
```ink
// === JUAN - Variables activas ===
VAR juan_relacion = 2
VAR juan_sabe_de_mi_despido = false
VAR juan_sabe_mi_situacion = false
VAR juan_recuerdo_padre = false
VAR juan_hablo_de_laura = false
VAR juan_hablo_de_miedo = false
VAR juan_mostro_contradiccion = false
VAR juan_migra = false              // NUEVO: Juan decide irse a España

// === JUAN - Variables deprecadas (no eliminar aún, pueden romper compilación) ===
VAR juan_tambien_despedido = false   // DEPRECADA: reemplazada por juan_migra
VAR juan_ofrecio_changa = false      // DEPRECADA: arco cambiado
VAR juan_ofrecio_contacto = false    // DEPRECADA: arco cambiado
VAR juan_fue_a_olla = false          // DEPRECADA: Juan no va a la olla
```

**Step 4: Compilar y verificar**

Run: `inklecate -o prototype/web/un_dia_mas.json prototype/ink/main.ink`
Expected: Compilación exitosa sin errores

**Step 5: Commit**

```bash
git add prototype/ink/variables.ink prototype/ink/dias/sabado.ink
git commit -m "refactor(juan): deprecate orphaned variables, prepare for migration arc"
```

---

## Task 2: Escribir escena de despedida de Juan - migración (A1)

**Files:**
- Create section in: `prototype/ink/personajes/juan.ink` (después de línea 950)
- Modify: `prototype/ink/dias/viernes.ink` (integrar llamada)

**Step 1: Escribir la escena de despedida**

Agregar en `prototype/ink/personajes/juan.ink` después de `juan_encuentro_fin`:

```ink
// === JUAN SE VA - MIGRACIÓN A ESPAÑA ===

=== juan_despedida_migracion ===
// Reemplaza juan_encuentro_viernes cuando juan_relacion >= 3
// Juan cuenta que se va a España con Laura

El teléfono vibra. Juan.

"Che, ¿podés? Necesito contarte algo."

* ["Sí, dale."]
    "¿Dónde estás? Voy para allá."
    -> juan_despedida_cafe
* ["Estoy complicado ahora."]
    "Es importante. Media hora."
    -> juan_despedida_cafe

=== juan_despedida_cafe ===

~ energia -= 1

El mismo bar de siempre.
Pero Juan está distinto. Nervioso. O aliviado. No sabés.

Pide dos cervezas. No espera a que lleguen.

"Nos vamos."

* ["¿Cómo?"]
    -> juan_explica_migracion
* ["¿A dónde?"]
    -> juan_explica_migracion
* [...]
    -> juan_explica_migracion

=== juan_explica_migracion ===

"Laura tiene familia en Valencia. Una tía. Consiguió laburo en una clínica, le hacen los papeles."

# PAUSA

"Y yo... bueno. Con el pasaporte italiano del abuelo puedo entrar. Buscar algo allá."

* ["¿Y el laburo acá?"]
    Juan se ríe. Amargo.
    "¿Qué laburo? Estamos todos colgando de un hilo. Mejor cortar antes de que me corten."
    -> juan_migracion_razones
* ["¿Cuándo?"]
    "En dos semanas. Ya sacamos los pasajes."
    -> juan_migracion_razones
* [Quedarte callado]
    Las cervezas llegan. Juan toma un trago largo.
    -> juan_migracion_razones

=== juan_migracion_razones ===

"Mirá, yo sé lo que estás pensando. Que me escapo. Que es de cagón."

# PAUSA

"Capaz que sí. Pero Laura tiene la oportunidad, y yo... no tengo nada que me ate acá."

Silencio.

"Mis viejos se van a quedar solos. Eso me mata. Pero ellos mismos me dicen que me vaya. 'Andá, que acá no hay futuro'."

* ["¿Y vos qué pensás?"]
    -> juan_duda_interna
* ["Tus viejos tienen razón."]
    Juan asiente. Pero no parece convencido.
    -> juan_duda_interna
* ["Yo no me iría."]
    -> juan_contraste_quedarse

=== juan_duda_interna ===

Juan mira la cerveza.

"No sé. A veces pienso que me voy porque puedo. Porque tengo el pasaporte, porque Laura tiene el contacto."

# PAUSA

"Y pienso en Diego. En lo que tuvo que dejar. En que él no eligió irse."

* [...]
-

"Yo elijo. Y no sé si eso me hace libre o cobarde."

-> juan_despedida_final

=== juan_contraste_quedarse ===

"¿Por qué no?"

* ["Porque acá está mi gente."]
    Juan te mira.
    "¿Qué gente? A vos te echaron igual que a mí. ¿Qué te queda?"
    "No sé. Pero algo."
    -> juan_reflexion_quedarse
* ["Porque irme es rendirse."]
    "¿Y quedarte qué es? ¿Ganar?"
    No tenés respuesta.
    -> juan_reflexion_quedarse
* ["No tengo a dónde ir."]
    Juan asiente.
    "Eso también. Yo puedo porque Laura puede. Si no, estaría igual que vos."
    -> juan_reflexion_quedarse

=== juan_reflexion_quedarse ===

# PAUSA

"Sabés qué pienso a veces? Que los que se quedan son más valientes. O más boludos. No sé."

Silencio.

"Mi viejo se quedó toda la vida. Fue a las marchas, peleó, y al final... monoambiente y soledad."

* [...]
-

"Yo no quiero eso. Pero tampoco quiero ser el que se fue y nunca volvió."

-> juan_despedida_final

=== juan_despedida_final ===

Terminan las cervezas.

Juan deja plata en la mesa. Más de lo que corresponde.

"Bueno. Era eso."

Se para. Incómodo.

* [Abrazarlo]
    Lo abrazás.
    Un abrazo largo. De esos que no se daban antes.
    "Cuidate, boludo."
    "Vos también."
    ~ juan_relacion += 1
    ~ subir_conexion(1)
    -> juan_despedida_cierre
* [Darle la mano]
    Le das la mano.
    "Suerte, Juan."
    "Gracias. Vos también."
    -> juan_despedida_cierre
* [No decir nada]
    No sabés qué decir.
    Juan tampoco.
    "Bueno. Chau."
    "Chau."
    -> juan_despedida_cierre

=== juan_despedida_cierre ===

~ juan_migra = true

Se va.

Lo mirás caminar hasta la esquina. Dobla. Desaparece.

# PAUSA

Otro que se va.
Diego vino huyendo. Juan se va buscando.
Vos te quedás.

No sabés si es valentía o inercia.
Pero te quedás.

->->
```

**Step 2: Integrar la escena en viernes.ink**

Buscar en `prototype/ink/dias/viernes.ink` la llamada a `juan_llamado_viernes` (línea ~568) y modificar:

```ink
// Reemplazar la llamada existente:
{juan_relacion >= 3 && not juan_migra:
    -> juan_despedida_migracion ->
}
```

**Step 3: Compilar y verificar**

Run: `inklecate -o prototype/web/un_dia_mas.json prototype/ink/main.ink`
Expected: Compilación exitosa

**Step 4: Test manual**

Jugar hasta viernes con juan_relacion >= 3, verificar que aparece la escena de despedida.

**Step 5: Commit**

```bash
git add prototype/ink/personajes/juan.ink prototype/ink/dias/viernes.ink
git commit -m "feat(juan): add migration farewell scene - closes his arc with thematic contrast"
```

---

## Task 3: Escena de quiebre de Sofía (A2)

**Files:**
- Create section in: `prototype/ink/personajes/sofia.ink`
- Modify: `prototype/ink/dias/viernes.ink` (integrar llamada)

**Step 1: Escribir la escena de quiebre**

Agregar en `prototype/ink/personajes/sofia.ink`:

```ink
// === SOFÍA SE QUIEBRA ===

=== sofia_momento_quiebre ===
// Escena donde Sofía admite que no puede más
// Trigger: viernes, después de la auditoría de Claudia, si sofia_relacion >= 3

La olla está vacía.
Todos se fueron.

Sofía está sentada en un banco. Sola.
No te vio entrar.

* [Acercarte]
    -> sofia_quiebre_encuentro
* [Observar desde lejos]
    -> sofia_quiebre_observar

=== sofia_quiebre_observar ===

Tiene la cabeza entre las manos.

Los hombros le tiemblan.

# PAUSA

Nunca la viste así.
Sofía siempre es la que sostiene.
La que tiene respuestas.
La que sigue.

* [Acercarte ahora]
    -> sofia_quiebre_encuentro
* [Dejarla sola]
    Te vas sin hacer ruido.
    Hay cosas que se procesan solas.
    ->->

=== sofia_quiebre_encuentro ===

"Sofía."

Se sobresalta. Se limpia la cara rápido.

"Ah. Sos vos."

* ["¿Estás bien?"]
    "Sí, sí. Bien."
    Mentira evidente.
    -> sofia_quiebre_presion
* [Sentarte al lado sin decir nada]
    Te sentás.
    Silencio.
    Ella respira hondo.
    -> sofia_quiebre_admision
* ["No tenés que estar bien."]
    -> sofia_quiebre_admision

=== sofia_quiebre_presion ===

"En serio, Sofía."

# PAUSA

Silencio largo.

Después, muy bajo:

-> sofia_quiebre_admision

=== sofia_quiebre_admision ===

"No sé si puedo seguir."

# PAUSA

Lo dijo.

"La Chola me dejó esto. Me dijo 'la olla sos vos ahora'. Y yo dije que sí porque no podía decir que no."

* [...]
-

"Pero yo no soy ella. Ella tenía... no sé. Fe. Yo solo tengo miedo."

* ["¿Miedo de qué?"]
    -> sofia_miedo
* [Escuchar]
    -> sofia_miedo

=== sofia_miedo ===

"De que cierre. De que mañana no haya comida. De Claudia y sus planillas."

Se frota la cara.

"De fallarles a todos."

# PAUSA

"Cuarenta personas vienen acá. Cuarenta. Y yo no sé si la semana que viene voy a poder darles un plato."

* ["No estás sola."]
    -> sofia_no_sola
* ["Cerremos entonces."]
    -> sofia_cerrar_provocacion
* [Quedarte en silencio]
    -> sofia_silencio

=== sofia_no_sola ===

"Ya sé. Elena, Diego, vos... pero al final la que firma soy yo. La que responde soy yo. La que no duerme soy yo."

Pausa.

"Mi vieja murió haciendo esto. ¿Sabés? Literalmente. Se murió cocinando."

# PAUSA

"Y yo a veces pienso: ¿para qué?"

* [...]
-

-> sofia_cierre_quiebre

=== sofia_cerrar_provocacion ===

Sofía te mira. Dura.

"¿Vos me estás cargando?"

"No. En serio. Si no podés, cerramos. Nadie te obliga."

# PAUSA

Silencio.

"No puedo cerrar. Eso es lo peor. No puedo."

-> sofia_cierre_quiebre

=== sofia_silencio ===

No decís nada.

A veces no hay nada que decir.

Sofía respira. Una vez. Dos.

# PAUSA

-> sofia_cierre_quiebre

=== sofia_cierre_quiebre ===

Después de un rato, dice:

"Gracias por no decirme que todo va a estar bien."

* ["No sé si va a estar bien."]
    "No. Yo tampoco."
    -> sofia_cierre_final
* ["Capaz que no. Pero estamos."]
    Sofía asiente.
    -> sofia_cierre_final
* [...]
    -> sofia_cierre_final

=== sofia_cierre_final ===

Se para. Se acomoda el pelo.

"Bueno. Mañana hay asamblea. Hay que preparar."

La máscara vuelve.
Pero ahora sabés lo que hay abajo.

~ sofia_estado = "quebrando"
~ sofia_relacion += 1
~ subir_conexion(1)

"¿Me ayudás a cerrar?"

"Sí."

Cierran la olla juntos.

->->
```

**Step 2: Integrar en viernes.ink**

Agregar en `prototype/ink/dias/viernes.ink`, después de las escenas de Claudia:

```ink
{sofia_relacion >= 3 && claudia_vino_a_auditar:
    -> sofia_momento_quiebre ->
}
```

**Step 3: Compilar y verificar**

Run: `inklecate -o prototype/web/un_dia_mas.json prototype/ink/main.ink`
Expected: Compilación exitosa

**Step 4: Commit**

```bash
git add prototype/ink/personajes/sofia.ink prototype/ink/dias/viernes.ink
git commit -m "feat(sofia): add emotional breakdown scene - shows vulnerability under pressure"
```

---

## Task 4: Protagonista pide ayuda (B1)

**Files:**
- Create section in: `prototype/ink/ubicaciones/olla.ink` o `prototype/ink/personajes/elena.ink`
- Modify: `prototype/ink/dias/jueves.ink` o `viernes.ink`

**Step 1: Escribir la escena**

Agregar en `prototype/ink/personajes/elena.ink`:

```ink
// === PROTAGONISTA SE QUIEBRA ===

=== protagonista_pide_ayuda ===
// El protagonista finalmente muestra vulnerabilidad
// Trigger: jueves o viernes, después de varios días sin laburo

Elena está pelando papas.

Movimientos lentos, seguros. Años de práctica.

Te sentás al lado. Agarrás un cuchillo.

* [Pelar en silencio]
    -> pelar_silencio
* ["Elena, ¿puedo preguntarte algo?"]
    -> elena_pregunta_directa

=== pelar_silencio ===

Pelan.

El ruido del cuchillo contra la cáscara.

# PAUSA

"¿Qué te pasa, gurí?"

Elena no te mira. Sigue pelando.

* ["Nada."]
    "Mentira."
    Sigue pelando.
    -> protagonista_admision
* ["No sé."]
    -> protagonista_admision
* [Dejar el cuchillo]
    Dejás el cuchillo.
    Elena espera.
    -> protagonista_admision

=== elena_pregunta_directa ===

"Preguntá."

* ["¿Cómo hacés?"]
    "¿Cómo hago qué?"
    "Para seguir. Cuando todo se va a la mierda."
    -> protagonista_admision
* ["¿Alguna vez quisiste dejar todo?"]
    Elena deja de pelar. Te mira.
    "¿Vos querés dejar todo?"
    -> protagonista_admision

=== protagonista_admision ===

# PAUSA

"No sé qué estoy haciendo."

Lo dijiste.

"Me echaron. No tengo guita. No tengo plan. Vengo acá y ayudo pero no sé por qué. No sé si sirve de algo."

# PAUSA

Elena sigue pelando.

"Y tengo miedo. Todo el tiempo. De que se me acabe la plata, de no conseguir nada, de terminar..."

No terminás la frase.

* [...]
-

Silencio.

-> elena_respuesta

=== elena_respuesta ===

Elena termina una papa. Agarra otra.

"En el 2002 perdí todo."

# PAUSA

"El laburo, los ahorros, casi la casa. Raúl estaba enfermo. Los guríses chicos."

* [...]
-

"¿Sabés qué hice? Vine acá. A esta misma olla. Que en ese momento era un fogón en la calle."

"¿Y?"

# PAUSA

"Y pelé papas. Porque no sabía qué más hacer."

-> elena_consejo

=== elena_consejo ===

Te mira por primera vez.

"No tenés que saber qué estás haciendo. Solo tenés que seguir haciendo."

* ["¿Y si no alcanza?"]
    "Nunca alcanza. Pero hacemos igual."
    -> elena_cierre
* ["Suena a resignación."]
    "No. Resignación es quedarte en tu casa esperando que alguien te salve. Esto es otra cosa."
    -> elena_cierre
* [Asentir]
    -> elena_cierre

=== elena_cierre ===

"El miedo no se va, gurí. Se acompaña."

# PAUSA

Te pasa una papa.

"Dale. Que estas no se pelan solas."

~ elena_relacion += 1
~ subir_conexion(1)
~ reducir_inercia(1)

Pelás.

El miedo sigue ahí.
Pero estás pelando papas.
Por ahora, alcanza.

->->
```

**Step 2: Integrar en jueves.ink**

Agregar en `prototype/ink/dias/jueves.ink`:

```ink
{ayude_en_olla && elena_relacion >= 2 && inercia >= 4:
    -> protagonista_pide_ayuda ->
}
```

**Step 3: Compilar y verificar**

Run: `inklecate -o prototype/web/un_dia_mas.json prototype/ink/main.ink`
Expected: Compilación exitosa

**Step 4: Commit**

```bash
git add prototype/ink/personajes/elena.ink prototype/ink/dias/jueves.ink
git commit -m "feat(protagonist): add vulnerability scene - asks Elena for help"
```

---

## Task 5: Momento colectivo en asamblea (B3)

**Files:**
- Modify: `prototype/ink/ubicaciones/olla.ink` (sección asamblea)
- Or create section in días/sabado.ink

**Step 1: Identificar ubicación actual de asamblea**

Buscar `olla_asamblea` en el código y expandir.

**Step 2: Escribir el momento colectivo**

```ink
// === MOMENTO COLECTIVO EN ASAMBLEA ===

=== asamblea_momento_colectivo ===
// El momento donde la comunidad actúa como unidad

Sofía pide silencio.

"Bueno. Ya saben por qué estamos acá."

Mira a Claudia's planilla imaginaria. A los números que no cierran. A todo lo que amenaza con cerrar esto.

"Tenemos que decidir."

* [...]
-

Silencio.

Nadie quiere ser el primero.

# PAUSA

Entonces Elena se para.

-> elena_habla_asamblea

=== elena_habla_asamblea ===

"Yo voy a hablar."

Todos la miran.

"En el 2002, cuando cerraron los bancos, vinimos acá. A este mismo lugar. Éramos veinte, treinta. No teníamos nada."

# PAUSA

"Hoy somos más. Y seguimos sin tener nada."

Risas nerviosas.

"Pero estamos."

* [...]
-

"Yo no sé qué va a pasar mañana. No sé si Claudia nos cierra, si conseguimos la plata, si esto se sostiene."

# PAUSA

"Pero sé una cosa: solos no llegamos a ningún lado. Juntos... tampoco sé. Pero prefiero no saber juntos."

-> asamblea_votacion

=== asamblea_votacion ===

Sofía asiente.

"Gracias, Elena. ¿Alguien más?"

{marcos_vino_a_asamblea:
    Marcos levanta la mano. Tímido.
    "Yo... hace mucho que no venía. Pero estoy."
    Es poco. Pero es algo.
}

{diego_relacion >= 3:
    Diego dice:
    "En mi país destruyeron algo que tardó sesenta años en construirse. No voy a dejar que pase acá."
}

* [...]
-

Sofía mira alrededor.

"Bueno. Votemos. ¿Seguimos?"

# PAUSA

Silencio.

Después, una mano.

Otra.

Otra.

-> asamblea_manos

=== asamblea_manos ===

Las manos suben.

No todas. Pero suficientes.

{ixchel_presente:
    Ixchel no levanta la mano. Pero asiente. En su cultura, el consenso se muestra distinto.
}

Sofía cuenta.

"Mayoría. Seguimos."

# PAUSA

Y entonces, no sabés quién empieza, alguien tararea.

-> asamblea_canto

=== asamblea_canto ===

Es una murga. Vieja. De las que cantaban en el 2002.

# PAUSA

"...que se vayan todos, que no quede ni uno solo..."

Algunos se suman.

Elena sonríe. Conoce la letra.

Diego no la conoce pero hace palmas.

{marcos_vino_a_asamblea:
    Marcos murmura la letra. La recuerda de algún lado.
}

* [Cantar]
    Cantás.
    No te sabés toda la letra, pero cantás.
    ~ subir_conexion(2)
    ~ subir_llama(1)
    -> asamblea_canto_final
* [Hacer palmas]
    Hacés palmas.
    Es suficiente.
    ~ subir_conexion(1)
    -> asamblea_canto_final
* [Observar]
    Mirás.
    Algo se mueve adentro tuyo.
    -> asamblea_canto_final

=== asamblea_canto_final ===

No dura mucho.

Se apaga solo, como empezó.

Pero por un momento, algo pasó.

# PAUSA

No es una victoria.
No es una solución.

Pero es algo que no se puede poner en una planilla.

~ participe_asamblea = true

->->
```

**Step 3: Integrar en sabado.ink**

Reemplazar o expandir la escena de asamblea existente para incluir este momento.

**Step 4: Compilar y verificar**

Run: `inklecate -o prototype/web/un_dia_mas.json prototype/ink/main.ink`

**Step 5: Commit**

```bash
git add prototype/ink/ubicaciones/olla.ink prototype/ink/dias/sabado.ink
git commit -m "feat(assembly): add collective moment - dramatized voting and singing"
```

---

## Task 6: Agregar PAUSA tags en momentos clave (D1)

**Files:**
- Modify: múltiples archivos en `prototype/ink/`

**Step 1: Identificar momentos que necesitan PAUSA**

Escenas prioritarias:
1. `prototype/ink/dias/miercoles.ink` - El despido
2. `prototype/ink/personajes/sofia.ink` - Historia de la Chola
3. `prototype/ink/personajes/elena.ink` - Desalojo García
4. `prototype/ink/personajes/marcos.ink` - Revela que lo echaron
5. `prototype/ink/personajes/diego.ink` - CECOSESOLA
6. `prototype/ink/personajes/claudia.ink` - "El Estado soy yo"
7. `prototype/ink/personajes/ixchel.ink` - Historia de Tomás

**Step 2: Agregar PAUSA tags**

Para cada archivo, buscar momentos de silencio significativo, revelaciones, y clímax emocionales. Agregar `# PAUSA` en línea separada antes del texto que sigue al silencio.

Ejemplo en miercoles.ink (despido):
```ink
// Buscar la escena del despido y agregar:
"Tu contrato termina hoy."

# PAUSA

// El silencio después de la noticia
```

**Step 3: Verificar cantidad**

Target: ~30-50 PAUSA tags distribuidos en el juego.

**Step 4: Compilar y verificar**

Run: `inklecate -o prototype/web/un_dia_mas.json prototype/ink/main.ink`

**Step 5: Commit por archivo o grupo**

```bash
git add prototype/ink/dias/miercoles.ink
git commit -m "feat(pacing): add PAUSA tags to firing scene"
# Repetir para cada archivo
```

---

## Task 7: Escena de canales institucionales fallando (C1)

**Files:**
- Modify: `prototype/ink/personajes/lucia.ink`
- Modify: `prototype/ink/dias/jueves.ink` o `viernes.ink`

**Step 1: Escribir la escena**

Agregar en `prototype/ink/personajes/lucia.ink`:

```ink
// === POR QUÉ EL SINDICATO NO PUEDE AYUDAR ===

=== lucia_explica_unipersonal ===
// Lucía explica por qué los canales formales no funcionan para unipersonales

"¿Y el sindicato? ¿No pueden hacer algo?"

Lucía suspira.

"Mirá, yo quisiera. Pero vos no sos empleado. Sos 'prestador de servicios'."

* ["Es lo mismo."]
    "Para vos sí. Para la ley, no."
    -> lucia_explica_legal
* ["¿Y eso qué significa?"]
    -> lucia_explica_legal

=== lucia_explica_legal ===

"Significa que no tenés convenio colectivo. No tenés despido. No tenés BPS patronal. No tenés nada."

# PAUSA

"Facturás, cobrás, y cuando no te sirven más... chau. Sin indemnización, sin seguro de paro, sin nada."

* ["Pero yo laburaba ahí todos los días..."]
    "Sí. Como empleado. Pero en los papeles sos un 'proveedor'. Como si vendieras tornillos."
    -> lucia_explica_sistema
* ["¿Y el MTSS?"]
    "Podés hacer la denuncia. Van a decir que es 'relación de dependencia encubierta'. Capaz ganás en tres años. Capaz."
    -> lucia_explica_sistema

=== lucia_explica_sistema ===

Lucía toma mate.

"El sistema está armado así. Las empresas tercerizan, contratan unipersonales, y se ahorran el 30% de aportes. Vos ponés el cuerpo, ellos ponen las reglas."

# PAUSA

"Nosotros peleamos desde adentro, pero los que están afuera... no tenemos cómo cubrirlos."

* ["Entonces estoy solo."]
    "No solo. Pero sí... desprotegido."
    -> lucia_cierre_institucional
* ["¿Y qué hago?"]
    -> lucia_cierre_institucional

=== lucia_cierre_institucional ===

"Mirá, yo no te voy a mentir. El Estado no te va a salvar. El sindicato tampoco, porque legalmente no sos de los nuestros."

# PAUSA

"Pero hay otras redes. La olla. Los vecinos. Eso no tiene convenio colectivo, pero existe."

~ lucia_consejo_sindical = true

"Es lo que hay."

->->
```

**Step 2: Integrar en jueves.ink**

```ink
{fui_despedido && lucia_relacion >= 1:
    -> lucia_explica_unipersonal ->
}
```

**Step 3: Commit**

```bash
git add prototype/ink/personajes/lucia.ink prototype/ink/dias/jueves.ink
git commit -m "feat(lucia): explain why institutional channels fail for gig workers"
```

---

## Tareas Opcionales (Prioridad Baja)

### Task 8: Marcos al borde (A3)
Agregar escena donde alguien percibe que Marcos está en peligro real antes del sábado.

### Task 9: Elena fragmento de soledad (A4)
Agregar fragmento nocturno donde Elena procesa su propia soledad.

### Task 10: Confrontación con antagonista (B4)
Elena vs Bruno o Sofía vs Claudia - confrontación directa.

### Task 11: Visibilizar género (C2)
Rescatar/amplificar líneas existentes sobre carga diferencial de género.

---

## Orden de Implementación Recomendado

| Orden | Task | Razón |
|-------|------|-------|
| 1 | Task 1 (D2) | Limpieza técnica, prepara para Task 2 |
| 2 | Task 2 (A1) | Cierra arco de Juan |
| 3 | Task 6 (D1) | PAUSA tags mejoran todo el juego |
| 4 | Task 3 (A2) | Sofía se quiebra - alto impacto |
| 5 | Task 5 (B3) | Momento colectivo - climax temático |
| 6 | Task 4 (B1) | Protagonista vulnerable |
| 7 | Task 7 (C1) | Coherencia temática |

---

## Verificación Final

Después de implementar todas las tareas:

1. **Compilar**: `inklecate -o prototype/web/un_dia_mas.json prototype/ink/main.ink`
2. **Generar wrapper**: `echo "var storyContent = $(cat prototype/web/un_dia_mas.json);" > prototype/web/un_dia_mas.js`
3. **Test manual**: Jugar rutas que activan las nuevas escenas
4. **Verificar PAUSA**: Contar PAUSA tags (target: 30-50)
5. **Verificar variables**: Buscar variables huérfanas restantes
