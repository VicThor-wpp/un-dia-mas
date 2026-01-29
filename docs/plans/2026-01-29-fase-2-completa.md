# Fase 2 Completa: Antagonistas, Integración y Balanceo

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Completar la Fase 2 del juego "Un Día Más" integrando los 5 personajes secundarios/antagonistas en el flujo narrativo de los 7 días, cerrando sus arcos, y balanceando los finales radicales para que sean alcanzables.

**Architecture:** El juego usa Ink (Inkle) con patrón de tunnels modulares. Los archivos de días (`dias/*.ink`) controlan el flujo y llaman a escenas en `personajes/*.ink` y `ubicaciones/*.ink`. Las variables están centralizadas en `variables.ink`. Los finales se evalúan en `domingo.ink` y se ejecutan en `finales/finales.ink`.

**Tech Stack:** Ink scripting language, inklecate compiler, web runtime (JS/HTML/CSS)

---

## Semana 1: Integración de Personajes en Días

### Task 1: Lucía en Lunes - Mate y Advertencia

**Files:**
- Modify: `prototype/ink/dias/lunes.ink:50-66` (agregar llamada a Lucía en lunes_manana)
- Reference: `prototype/ink/personajes/lucia.ink:4-40` (lucia_escena_mate ya existe)

**Step 1: Verificar escena existe**

La escena `lucia_escena_mate` ya existe en lucia.ink. Solo necesitamos integrarla.

**Step 2: Modificar lunes.ink para incluir encuentro con Lucía**

En `lunes.ink`, después de `lunes_manana` (línea 50), agregar la llamada condicional:

```ink
=== lunes_manana ===

-> laburo_manana ->

// Encuentro con Juan
-> juan_saludo_manana ->

// NUEVO: Encuentro con Lucía (compañera sindicalista)
{RANDOM(1,2) == 1:
    -> lucia_escena_mate ->
}

// Trabajo de la mañana
-> laburo_trabajo_rutina ->
```

**Step 3: Compilar y verificar**

Run: `./bin/inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 4: Commit**

```bash
git add prototype/ink/dias/lunes.ink
git commit -m "feat(lunes): integrar lucia_escena_mate en la mañana laboral"
```

---

### Task 2: Lucía en Martes - Almuerzo Tenso

**Files:**
- Modify: `prototype/ink/dias/martes.ink:74-85` (agregar opción de almuerzo con Lucía)
- Reference: `prototype/ink/personajes/lucia.ink:67-97` (lucia_almuerzo_oficina ya existe)

**Step 1: Agregar opción de almuerzo con Lucía**

En `martes.ink`, después del trabajo de rutina y antes de la citación, agregar:

```ink
=== martes_laburo ===

-> laburo_llegada ->

// El laburo hoy está raro - contenido específico del martes
El laburo hoy está raro.

El jefe no te mira.
Los de RRHH entran y salen.
Hay reuniones que no te incluyen.

// Chequeo mental existente...
~ temp aguante = chequeo_mental(0, 4)
// ... resto del código existente ...

-> laburo_manana ->

// Encuentro con Juan
-> juan_saludo_manana ->

// Trabajo de rutina
-> laburo_trabajo_rutina ->

// NUEVO: Almuerzo - ahora con opción Lucía
# ALMUERZO

12:30. Hora de comer.

* [Almorzar con Juan] # EFECTO:conexion+
    -> juan_almuerzo ->
    -> martes_citacion
* [Almorzar con Lucía] # EFECTO:conexion+
    -> lucia_almuerzo_oficina ->
    -> martes_citacion
* [Almorzar solo] # EFECTO:conexion-
    -> laburo_almuerzo_solo ->
    -> martes_citacion

=== martes_citacion ===
// resto igual...
```

**Step 2: Compilar y verificar**

Run: `./bin/inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 3: Commit**

```bash
git add prototype/ink/dias/martes.ink
git commit -m "feat(martes): agregar opción de almuerzo con Lucía"
```

---

### Task 3: Bruno en Jueves - Visita Intimidante

**Files:**
- Modify: `prototype/ink/dias/jueves.ink:200-250` (después de llegar a la olla)
- Reference: `prototype/ink/personajes/bruno.ink:77-104` (bruno_la_visita ya existe)

**Step 1: Localizar punto de inserción en jueves.ink**

Buscar la sección donde el jugador está en la olla el jueves. Insertar después de `olla_ayudar_cocina`.

**Step 2: Agregar llamada a bruno_la_visita**

```ink
// En jueves.ink, después de la escena de ayudar en la olla:

// NUEVO: Bruno pasa a marcar territorio
{fui_a_olla_jueves:
    -> bruno_la_visita ->
}
```

**Step 3: Compilar y verificar**

Run: `./bin/inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 4: Commit**

```bash
git add prototype/ink/dias/jueves.ink
git commit -m "feat(jueves): integrar bruno_la_visita cuando el jugador está en la olla"
```

---

### Task 4: Tiago en Jueves - Primer Encuentro

**Files:**
- Modify: `prototype/ink/dias/jueves.ink` (en la olla, durante ayuda)
- Reference: `prototype/ink/personajes/tiago.ink:4-30` (tiago_primer_encuentro ya existe)

**Step 1: Localizar punto de inserción**

El primer encuentro con Tiago debe ocurrir cuando el jugador ayuda en la olla el jueves.

**Step 2: Agregar llamada condicional**

```ink
// En jueves.ink, dentro de la sección de ayudar en la olla:

// NUEVO: Encuentro con Tiago si ayudás en la olla
{ayude_en_olla:
    -> tiago_primer_encuentro ->
}
```

**Step 3: Compilar y verificar**

Run: `./bin/inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 4: Commit**

```bash
git add prototype/ink/dias/jueves.ink
git commit -m "feat(jueves): integrar tiago_primer_encuentro durante ayuda en olla"
```

---

### Task 5: Claudia en Viernes - Ya Integrada, Verificar

**Files:**
- Verify: `prototype/ink/dias/viernes.ink:126-136` (claudia_llegada y claudia_la_auditoria)

**Step 1: Verificar integración existente**

El código ya tiene:
```ink
// Claudia llega a auditar
-> claudia_llegada ->
// ...
// EL CONFLICTO: CLAUDIA (Fase 2)
-> claudia_la_auditoria ->
```

**Step 2: Verificar que claudia_amenaza_final se use**

Buscar si `claudia_amenaza_final` está integrada. Si no, agregarla después de la auditoría.

**Step 3: Agregar claudia_amenaza_final si falta**

```ink
// En viernes.ink, después de claudia_la_auditoria:
{claudia_hostilidad >= 2:
    -> claudia_amenaza_final ->
}
```

**Step 4: Commit**

```bash
git add prototype/ink/dias/viernes.ink
git commit -m "feat(viernes): asegurar claudia_amenaza_final esté integrada"
```

---

### Task 6: Conflicto Tiago vs Claudia en Viernes

**Files:**
- Modify: `prototype/ink/dias/viernes.ink` (después de la auditoría)
- Reference: `prototype/ink/personajes/tiago.ink:32-66` (tiago_conflicto_comida ya existe)

**Step 1: Agregar escena del tupper**

```ink
// En viernes.ink, durante la crisis de la olla:

// NUEVO: Conflicto Tiago vs Claudia por el tupper
{tiago_confianza >= 1:
    -> tiago_conflicto_comida ->
}
```

**Step 2: Compilar y verificar**

Run: `./bin/inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 3: Commit**

```bash
git add prototype/ink/dias/viernes.ink
git commit -m "feat(viernes): integrar conflicto tiago_conflicto_comida con Claudia"
```

---

### Task 7: Bruno Confronta a Sofía en Viernes

**Files:**
- Modify: `prototype/ink/dias/viernes.ink` (tarde, después de la colecta)
- Reference: `prototype/ink/personajes/bruno.ink:106-143` (bruno_confronta_sofia ya existe)

**Step 1: Agregar confrontación Bruno-Sofía**

```ink
// En viernes.ink, durante la tarde en la olla:

// NUEVO: Bruno aparece a confrontar a Sofía
{bruno_tension >= 1:
    -> bruno_confronta_sofia ->
}
```

**Step 2: Compilar y verificar**

Run: `./bin/inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 3: Commit**

```bash
git add prototype/ink/dias/viernes.ink
git commit -m "feat(viernes): integrar bruno_confronta_sofia"
```

---

### Task 8: Lucía en Viernes - Aparece en la Olla

**Files:**
- Modify: `prototype/ink/dias/viernes.ink` (llegada a la olla)
- Reference: `prototype/ink/personajes/lucia.ink:136-156` (lucia_en_olla ya existe)

**Step 1: Agregar llegada de Lucía**

```ink
// En viernes.ink, al llegar a la olla:

// NUEVO: Lucía aparece si la relación es buena
{lucia_relacion >= 2:
    -> lucia_en_olla ->
}
```

**Step 2: Compilar y verificar**

Run: `./bin/inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 3: Commit**

```bash
git add prototype/ink/dias/viernes.ink
git commit -m "feat(viernes): integrar lucia_en_olla"
```

---

### Task 9: Cacho en Viernes - En la Fila

**Files:**
- Modify: `prototype/ink/dias/viernes.ink` (en la olla)
- Reference: `prototype/ink/personajes/cacho.ink:41-65` (cacho_en_la_fila ya existe)

**Step 1: Agregar encuentro con Cacho**

```ink
// En viernes.ink, durante el servicio de la olla:

// NUEVO: Cacho está en la fila
-> cacho_en_la_fila ->
```

**Step 2: Compilar y verificar**

Run: `./bin/inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 3: Commit**

```bash
git add prototype/ink/dias/viernes.ink
git commit -m "feat(viernes): integrar cacho_en_la_fila"
```

---

### Task 10: Bruno Recluta Tiago en Sábado

**Files:**
- Verify: `prototype/ink/dias/sabado.ink:60-63` (ya existe llamada)
- Reference: `prototype/ink/personajes/bruno.ink:48-75` (bruno_recluta_tiago)

**Step 1: Verificar integración existente**

El código ya tiene:
```ink
// Bruno recluta a Tiago si la olla falló
{olla_en_crisis || olla_cerro_viernes:
    -> bruno_recluta_tiago ->
}
```

**Step 2: Mejorar condición para incluir más casos**

```ink
// Bruno recluta a Tiago si:
// - La olla está en crisis, O
// - La olla cerró el viernes, O
// - Tiago no tiene confianza suficiente con el protagonista
{(olla_en_crisis || olla_cerro_viernes) && not tiago_se_queda:
    -> bruno_recluta_tiago ->
}
```

**Step 3: Commit**

```bash
git add prototype/ink/dias/sabado.ink
git commit -m "fix(sabado): mejorar condición para bruno_recluta_tiago"
```

---

### Task 11: Decisión Final de Tiago en Sábado

**Files:**
- Verify: `prototype/ink/dias/sabado.ink:66-68` (ya existe llamada)
- Reference: `prototype/ink/personajes/tiago.ink:112-165` (tiago_decision_final)

**Step 1: Verificar integración existente**

El código ya tiene:
```ink
// Decisión crucial de Tiago
{tiago_confianza >= 3 && not tiago_captado_por_bruno:
    -> tiago_decision_final ->
}
```

Esto está correcto. Solo verificar que funcione.

**Step 2: Commit (si hubo cambios)**

```bash
git add prototype/ink/dias/sabado.ink
git commit -m "verify(sabado): tiago_decision_final está correctamente integrada"
```

---

### Task 12: Tiago se Abre en Sábado

**Files:**
- Modify: `prototype/ink/dias/sabado.ink` (durante la tarde)
- Reference: `prototype/ink/personajes/tiago.ink:68-110` (tiago_se_abre)

**Step 1: Agregar escena de apertura emocional**

```ink
// En sabado.ink, durante la tarde antes de la asamblea:

// NUEVO: Tiago se abre si hay confianza
-> tiago_se_abre ->
```

Nota: `tiago_se_abre` ya tiene su propia condicional interna `{tiago_confianza >= 2:`.

**Step 2: Compilar y verificar**

Run: `./bin/inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 3: Commit**

```bash
git add prototype/ink/dias/sabado.ink
git commit -m "feat(sabado): integrar tiago_se_abre antes de la asamblea"
```

---

### Task 13: Bruno Oferta al Protagonista en Sábado

**Files:**
- Modify: `prototype/ink/dias/sabado.ink` (si inercia alta)
- Reference: `prototype/ink/personajes/bruno.ink:145-200` (bruno_oferta_protagonista)

**Step 1: Agregar oferta de Bruno**

```ink
// En sabado.ink, durante la tarde:

// NUEVO: Bruno ofrece al protagonista si está vulnerable
-> bruno_oferta_protagonista ->
```

Nota: `bruno_oferta_protagonista` ya tiene su propia condicional `{inercia >= 7:`.

**Step 2: Compilar y verificar**

Run: `./bin/inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 3: Commit**

```bash
git add prototype/ink/dias/sabado.ink
git commit -m "feat(sabado): integrar bruno_oferta_protagonista"
```

---

### Task 14: Cacho sin Olla en Sábado

**Files:**
- Modify: `prototype/ink/dias/sabado.ink` (si olla cerró)
- Reference: `prototype/ink/personajes/cacho.ink:117-155` (cacho_sin_olla)

**Step 1: Agregar escena de Cacho**

```ink
// En sabado.ink, si la olla cerró:

// NUEVO: Cacho reacciona al cierre
-> cacho_sin_olla ->
```

Nota: `cacho_sin_olla` ya tiene su propia condicional `{olla_en_crisis:`.

**Step 2: Compilar y verificar**

Run: `./bin/inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 3: Commit**

```bash
git add prototype/ink/dias/sabado.ink
git commit -m "feat(sabado): integrar cacho_sin_olla"
```

---

## Semana 2: Arcos y Resoluciones

### Task 15: Crear Escena de Cierre para Lucía

**Files:**
- Modify: `prototype/ink/personajes/lucia.ink` (agregar nueva escena)

**Step 1: Escribir escena de cierre**

Agregar al final de `lucia.ink`:

```ink
=== lucia_cierre_domingo ===
// Escena Domingo: Lucía reflexiona sobre la semana

{lucia_consejo_sindical:
    Lucía te llama el domingo.

    "¿Fuiste al ministerio?"

    * [Sí, fui.]
        "Bien. No va a cambiar nada mañana.
        Pero es un ladrillo. Uno de muchos."

        Silencio.

        "Seguimos el lunes. Hay asamblea en el sindicato."

        ~ lucia_sigue_luchando = true
        ~ subir_conexion(1)
        ~ activar_no_es_individual()
        ->->

    * [No pude.]
        "Entiendo. Pero no te quedes.
        Solo no se puede."

        Corta.

        ~ aumentar_inercia(1)
        ->->
- else:
    ->->
}

=== lucia_en_asamblea ===
// Escena Sábado: Lucía aparece en la asamblea del barrio

{lucia_relacion >= 2 && participe_asamblea:
    Lucía entra a la asamblea.
    Algunos la conocen del sindicato.

    "¿Qué hacés acá?", pregunta Sofía.

    "Vine a escuchar. Y a sumar.
    El sindicato tiene recursos.
    Ustedes tienen organización."

    Se sienta.
    Toma nota.

    "Juntos podemos más."

    ~ lucia_relacion += 1
    ~ subir_llama(1)
    ->->
- else:
    ->->
}
```

**Step 2: Compilar y verificar**

Run: `./bin/inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 3: Commit**

```bash
git add prototype/ink/personajes/lucia.ink
git commit -m "feat(lucia): agregar lucia_cierre_domingo y lucia_en_asamblea"
```

---

### Task 16: Crear Escena de Cierre para Tiago

**Files:**
- Modify: `prototype/ink/personajes/tiago.ink` (agregar nuevas escenas)

**Step 1: Escribir escena de cierre**

Agregar al final de `tiago.ink`:

```ink
=== tiago_domingo ===
// Escena Domingo: Resultado de la decisión de Tiago

{tiago_se_queda:
    Tiago está en la olla.
    Barriendo. Ordenando.

    No habla mucho.
    Pero está.

    "¿Todo bien?", preguntás.

    "Más o menos."

    Pausa.

    "Pero estoy acá. Es algo."

    ~ subir_conexion(1)
    ->->
}

{tiago_captado_por_bruno:
    Pasás por la esquina.
    La camioneta de Bruno está ahí.

    Adentro, Tiago.
    Mira para otro lado cuando te ve.

    Ya no es del barrio.
    Ya no es de nadie.

    ~ bajar_llama(1)
    ->->
}

->->

=== tiago_en_asamblea ===
// Escena Sábado: Tiago en la asamblea (si se quedó)

{tiago_se_queda && participe_asamblea:
    Tiago está en el fondo.
    No habla. Escucha.

    Cuando alguien propone algo sobre los pibes del barrio,
    levanta la mano.

    "Yo puedo ayudar con eso."

    Primera vez que lo ves participar.

    ~ tiago_confianza += 1
    ~ subir_llama(1)
    ->->
- else:
    ->->
}
```

**Step 2: Compilar y verificar**

Run: `./bin/inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 3: Commit**

```bash
git add prototype/ink/personajes/tiago.ink
git commit -m "feat(tiago): agregar tiago_domingo y tiago_en_asamblea"
```

---

### Task 17: Crear Escena de Cierre para Cacho

**Files:**
- Modify: `prototype/ink/personajes/cacho.ink` (escena de redención ya existe, verificar)

**Step 1: Verificar escena existente**

`cacho_redencion` ya existe y tiene la condicional correcta:
```ink
{conexion >= 7 && cacho_momento_real:
```

**Step 2: Agregar escena para domingo**

```ink
=== cacho_domingo ===
// Escena Domingo: Cacho reflexiona

{cacho_momento_real:
    Cacho te cruza en la calle.

    "Vecino."

    No tiene el discurso de siempre.
    Se lo ve más... real.

    "Ayer pensé mucho.
    Capaz que tenés razón.
    Capaz que hay que dejar de mentirse."

    Pausa.

    "Pero cuesta, ¿sabés?"

    * [Acompañarlo.]
        "Sí. Cuesta."

        Se quedan un rato en silencio.
        A veces eso alcanza.

        ~ subir_conexion(1)
        ->->

    * [Dejarlo solo.]
        "Suerte, Cacho."

        Te vas.
        Algunos procesos son solitarios.

        ->->
- else:
    // Cacho sigue en su mundo
    Cacho te cruza en la calle.

    "¡Vecino! Tengo una oportunidad de oro.
    Cripto. NFTs. El futuro."

    Seguís de largo.
    Algunos nunca cambian.

    ->->
}
```

**Step 3: Compilar y verificar**

Run: `./bin/inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 4: Commit**

```bash
git add prototype/ink/personajes/cacho.ink
git commit -m "feat(cacho): agregar cacho_domingo con bifurcación según momento_real"
```

---

### Task 18: Crear Escena de Cierre para Bruno

**Files:**
- Modify: `prototype/ink/personajes/bruno.ink` (agregar escena final)

**Step 1: Escribir escena de cierre/confrontación**

```ink
=== bruno_domingo ===
// Escena Domingo: El resultado del conflicto con Bruno

{tiago_captado_por_bruno:
    // Bruno ganó a Tiago
    La camioneta de Bruno pasa por el barrio.
    Despacio. Como patrullando.

    Adentro, Tiago mira al frente.
    Como soldado.

    Bruno baja el vidrio.
    Te mira.
    Sonríe.

    "Gracias por nada, vecino."

    El vidrio sube.
    Se van.

    ~ bruno_tension += 1
    ->->
}

{tiago_se_queda && bruno_tension >= 2:
    // Bruno perdió a Tiago pero no se rinde
    Bruno aparece en la esquina.
    Solo. Sin camioneta.

    "Me sacaste al pibe."

    * [Confrontarlo.]
        "No te lo saqué. Él eligió."

        Bruno achica los ojos.
        "Nadie elige en este barrio.
        Solo sobreviven o no."

        Se va.
        Pero sabés que va a volver.

        ~ subir_dignidad(1)
        ->->

    * [Ignorarlo.]
        Seguís caminando.

        "Esto no termina", dice a tu espalda.

        No te das vuelta.

        ->->
- else:
    ->->
}

=== bruno_amenaza_olla ===
// Escena Sábado tarde: Bruno amenaza la olla directamente

{bruno_tension >= 3 && not lista_entregada:
    Bruno entra a la olla.
    Sin golpear. Sin permiso.

    "Escuché que tienen problemas con la municipalidad."

    Sofía se tensa.

    "Yo tengo contactos. Puedo ayudar.
    Pero necesito algo a cambio."

    * [Rechazarlo.]
        "No necesitamos tu ayuda, Bruno."

        "Todos necesitan ayuda.
        La pregunta es de quién la aceptan."

        Se va.

        ~ subir_dignidad(2)
        ~ bruno_tension += 1
        ->->

    * [Escuchar su propuesta.]
        "¿Qué querés?"

        "La lista. Los nombres de quienes vienen.
        Para mis... estadísticas."

        Sofía niega con la cabeza.

        "Piénsenlo."

        Se va.

        ~ olla_en_crisis = true
        ->->
- else:
    ->->
}
```

**Step 2: Compilar y verificar**

Run: `./bin/inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 3: Commit**

```bash
git add prototype/ink/personajes/bruno.ink
git commit -m "feat(bruno): agregar bruno_domingo y bruno_amenaza_olla"
```

---

### Task 19: Crear Escena de Cierre para Claudia

**Files:**
- Modify: `prototype/ink/personajes/claudia.ink` (agregar escena de resolución)

**Step 1: Escribir escena de cierre**

```ink
=== claudia_domingo ===
// Escena Domingo: El resultado de la auditoría

{lista_entregada:
    // Claudia ganó - hay lista
    El lunes llega la confirmación.
    "Suministros aprobados para la próxima semana."

    Pero el barrio no festeja.
    Saben lo que costó.

    Hay gente que dejó de venir.
    "No quiero que tengan mi cédula."

    La olla sobrevive.
    Pero algo se rompió.

    ~ bajar_llama(1)
    ->->
}

{not lista_entregada && claudia_hostilidad >= 2:
    // Claudia perdió - resistieron
    El domingo suena el teléfono.
    Es Sofía.

    "Claudia mandó una nota.
    Dice que tenemos hasta el miércoles
    para regularizar o nos cierran."

    Pausa.

    "Pero también dice algo más.
    Que hay un recurso. Una apelación.
    Elena conoce a alguien del municipio."

    No es victoria. Es resistencia.

    ~ subir_dignidad(1)
    ->->
- else:
    ->->
}

=== claudia_segundo_round ===
// Escena Sábado: Claudia vuelve a presionar

{claudia_hostilidad >= 1 && not lista_entregada:
    Claudia aparece de nuevo.
    Esta vez con otro papel.

    "Última oportunidad.
    La lista o cierro el lunes."

    Sofía mira a todos.
    Elena. Diego. Vos.

    "No."

    Claudia guarda el papel.

    "Bien. El lunes nos vemos en el juzgado."

    Se va.

    ~ claudia_hostilidad += 1
    ~ olla_en_crisis = true
    ~ subir_dignidad(1)
    ->->
- else:
    ->->
}
```

**Step 2: Compilar y verificar**

Run: `./bin/inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 3: Commit**

```bash
git add prototype/ink/personajes/claudia.ink
git commit -m "feat(claudia): agregar claudia_domingo y claudia_segundo_round"
```

---

### Task 20: Integrar Cierres en Domingo

**Files:**
- Modify: `prototype/ink/dias/domingo.ink` (agregar llamadas a escenas de cierre)

**Step 1: Agregar llamadas a cierres**

```ink
// En domingo.ink, antes de la evaluación de finales:

// CIERRES DE PERSONAJES FASE 2
-> lucia_cierre_domingo ->
-> tiago_domingo ->
-> cacho_domingo ->
-> bruno_domingo ->
-> claudia_domingo ->

// Redención de Cacho si aplica
-> cacho_redencion ->
```

**Step 2: Compilar y verificar**

Run: `./bin/inklecate prototype/ink/main.ink`
Expected: Sin errores

**Step 3: Commit**

```bash
git add prototype/ink/dias/domingo.ink
git commit -m "feat(domingo): integrar escenas de cierre de Fase 2"
```

---

## Semana 3: Balanceo de Stats y Finales

### Task 21: Agregar Eventos de Alto Impacto en Llama

**Files:**
- Modify: `prototype/ink/ubicaciones/olla.ink` (agregar momentos de boost)

**Step 1: Crear escena de momento colectivo**

```ink
=== olla_momento_colectivo ===
// Escena especial: Un momento de unidad que sube mucho la llama

{veces_que_ayude >= 2 && participe_asamblea:
    Algo pasa en la olla.

    No es grande. No es histórico.
    Pero es real.

    Alguien empieza a cantar.
    Una canción vieja. De cuando había fábricas.

    Elena la conoce. Sofía también.
    Uno a uno, se van sumando.

    No es esperanza ingenua.
    Es memoria. Es resistencia.
    Es decir "estamos acá".

    Y por un momento, la llama arde más fuerte.

    ~ subir_llama(3)
    ~ activar_hay_cosas_juntos()
    ->->
- else:
    ->->
}
```

**Step 2: Integrar en sábado**

```ink
// En sabado.ink, durante la asamblea:
-> olla_momento_colectivo ->
```

**Step 3: Commit**

```bash
git add prototype/ink/ubicaciones/olla.ink prototype/ink/dias/sabado.ink
git commit -m "feat(olla): agregar olla_momento_colectivo para boost de llama"
```

---

### Task 22: Agregar Eventos de Alto Impacto en Conexion

**Files:**
- Modify: `prototype/ink/ubicaciones/olla.ink` (agregar momentos de conexión)

**Step 1: Crear escena de reconocimiento**

```ink
=== olla_reconocimiento ===
// Escena especial: El barrio te reconoce como parte

{veces_que_ayude >= 3 && conexion >= 5:
    Sofía te llama aparte.

    "Quiero decirte algo."

    Te mira a los ojos.

    "Cuando llegaste, pensé que eras otro más.
    De los que vienen una vez y no vuelven."

    Pausa.

    "Me equivoqué."

    Te abraza.
    No es un abrazo de bienvenida.
    Es de aceptación.

    "Sos parte, ¿sabés? Ya sos parte."

    ~ subir_conexion(3)
    ~ sofia_relacion += 2
    ->->
- else:
    ->->
}
```

**Step 2: Integrar en sábado**

```ink
// En sabado.ink, durante la asamblea:
-> olla_reconocimiento ->
```

**Step 3: Commit**

```bash
git add prototype/ink/ubicaciones/olla.ink prototype/ink/dias/sabado.ink
git commit -m "feat(olla): agregar olla_reconocimiento para boost de conexion"
```

---

### Task 23: Reducir Thresholds de Finales Fase 2

**Files:**
- Modify: `prototype/ink/dias/domingo.ink` (ajustar evaluación de finales)

**Step 1: Revisar evaluación actual de finales**

Buscar las condiciones para `final_huelga`, `final_ocupacion`, etc.

**Step 2: Reducir thresholds**

Antes:
```ink
{participe_asamblea && veces_que_ayude >= 3 && llama >= 8 && conexion >= 8:
    -> final_huelga
}
```

Después:
```ink
{participe_asamblea && veces_que_ayude >= 2 && llama >= 6 && conexion >= 6:
    -> final_huelga
}
```

Aplicar reducciones similares a todos los finales Fase 2:
- `final_huelga`: llama >= 6, conexion >= 6
- `final_ocupacion`: llama >= 7, conexion >= 7
- `final_represion`: llama >= 5, conexion >= 5

**Step 3: Commit**

```bash
git add prototype/ink/dias/domingo.ink
git commit -m "balance: reducir thresholds de finales Fase 2 para hacerlos alcanzables"
```

---

### Task 24: Agregar Variable de Ayudas Totales

**Files:**
- Modify: `prototype/ink/variables.ink` (verificar variable existe)
- Modify: `prototype/ink/mecanicas/recursos.ink` (crear función helper)

**Step 1: Verificar variable**

`veces_que_ayude` ya existe en variables.ink.

**Step 2: Crear función helper**

```ink
// En recursos.ink:

=== function registrar_ayuda() ===
    ~ veces_que_ayude += 1
    { veces_que_ayude >= 3:
        # STAT_THRESHOLD:ayuda,milestone
    }
```

**Step 3: Reemplazar incrementos directos**

Buscar todas las instancias de `~ veces_que_ayude += 1` y reemplazar con `~ registrar_ayuda()`.

**Step 4: Commit**

```bash
git add prototype/ink/variables.ink prototype/ink/mecanicas/recursos.ink
git commit -m "feat(recursos): crear función registrar_ayuda() con tracking"
```

---

### Task 25: Agregar Más Oportunidades de Ayudar

**Files:**
- Modify: `prototype/ink/dias/jueves.ink` (agregar oportunidad)
- Modify: `prototype/ink/dias/viernes.ink` (agregar oportunidad)
- Modify: `prototype/ink/dias/sabado.ink` (agregar oportunidad)

**Step 1: Agregar en jueves**

```ink
// En jueves.ink, opción adicional en la olla:
* {energia >= 2} [Quedarte a limpiar] # COSTO:1 # EFECTO:conexion+ # EFECTO:llama+
    ~ energia -= 1
    Te quedás a ordenar.
    Sofía te mira con gratitud.
    "Gracias. Esto ayuda más de lo que pensás."
    ~ registrar_ayuda()
    ~ subir_conexion(1)
    ~ subir_llama(1)
    -> jueves_tarde
```

**Step 2: Agregar en viernes**

```ink
// En viernes.ink, opción adicional durante la crisis:
* {energia >= 2} [Ofrecerte para la colecta] # COSTO:2 # EFECTO:conexion++ # EFECTO:llama+
    ~ energia -= 2
    Salís a pedir en los negocios.
    No es fácil. Pero conseguís algo.
    ~ registrar_ayuda()
    ~ subir_conexion(2)
    ~ subir_llama(1)
    -> viernes_tarde
```

**Step 3: Commit**

```bash
git add prototype/ink/dias/jueves.ink prototype/ink/dias/viernes.ink
git commit -m "feat(dias): agregar más oportunidades de ayudar para veces_que_ayude"
```

---

## Semana 4: Testing, Documentación y Polish

### Task 26: Compilar y Verificar Todo

**Files:**
- All .ink files

**Step 1: Compilar**

Run: `./bin/inklecate prototype/ink/main.ink`
Expected: Sin errores ni warnings

**Step 2: Generar JSON**

Run: `./bin/inklecate -o prototype/web/un_dia_mas.json prototype/ink/main.ink`

**Step 3: Generar JS wrapper**

Run: `echo "var storyContent = $(cat prototype/web/un_dia_mas.json);" > prototype/web/un_dia_mas.js`

**Step 4: Commit**

```bash
git add prototype/web/un_dia_mas.json prototype/web/un_dia_mas.js
git commit -m "build: regenerar JSON y JS con todos los cambios de Fase 2"
```

---

### Task 27: Actualizar MASTER-PLAN.md

**Files:**
- Modify: `docs/MASTER-PLAN.md`

**Step 1: Agregar sección de Fase 2 completada**

```markdown
## Fase 2: Antagonistas y Secundarios (COMPLETADA)

### Personajes Integrados

| Personaje | Rol | Días Activo | Arco |
|-----------|-----|-------------|------|
| Lucía | Sindicalista | L, M, V, S, D | Organización vs institucionalización |
| Tiago | Pibe vulnerable | J, V, S, D | Captación por Bruno vs comunidad |
| Cacho | Emprendedor iluso | J, V, S, D | Delirio vs momento de realidad |
| Bruno | Fascista territorial | J, V, S, D | Amenaza a la olla y captación |
| Claudia | Auditora | V, S, D | Violencia administrativa vs resistencia |

### Finales Fase 2 (Alcanzables)

- `final_huelga`: llama >= 6, conexion >= 6, participe_asamblea
- `final_ocupacion`: llama >= 7, conexion >= 7, participe_asamblea
- `final_represion`: llama >= 5, conexion >= 5
- `final_desercion`: conexion >= 6
```

**Step 2: Commit**

```bash
git add docs/MASTER-PLAN.md
git commit -m "docs: actualizar MASTER-PLAN con Fase 2 completada"
```

---

### Task 28: Actualizar narrative-map.md

**Files:**
- Modify: `docs/design/narrative-map.md`

**Step 1: Agregar sección de personajes Fase 2**

Documentar:
- Arcos de cada personaje
- Puntos de decisión
- Variables que afectan
- Cómo se relacionan entre sí

**Step 2: Commit**

```bash
git add docs/design/narrative-map.md
git commit -m "docs: actualizar narrative-map con arcos de Fase 2"
```

---

### Task 29: Actualizar flowcharts.md

**Files:**
- Modify: `docs/design/flowcharts.md`

**Step 1: Agregar diagrama de Fase 2**

Ya existe un diagrama básico. Expandirlo con:
- Flujo de decisiones de Tiago
- Confrontaciones con Bruno
- Crisis de Claudia

**Step 2: Commit**

```bash
git add docs/design/flowcharts.md
git commit -m "docs: expandir flowcharts con flujos de Fase 2"
```

---

### Task 30: Commit Final y Tag

**Step 1: Verificar todo está commiteado**

Run: `git status`
Expected: working tree clean

**Step 2: Crear tag de versión**

```bash
git tag -a v2.0.0 -m "Fase 2 completa: antagonistas, integración y balanceo"
```

**Step 3: Push**

```bash
git push origin master
git push origin v2.0.0
```

---

## Resumen de Archivos Modificados

### Días
- `prototype/ink/dias/lunes.ink` - Tasks 1
- `prototype/ink/dias/martes.ink` - Task 2
- `prototype/ink/dias/jueves.ink` - Tasks 3, 4, 25
- `prototype/ink/dias/viernes.ink` - Tasks 5-9, 25
- `prototype/ink/dias/sabado.ink` - Tasks 10-14, 21, 22
- `prototype/ink/dias/domingo.ink` - Tasks 20, 23

### Personajes
- `prototype/ink/personajes/lucia.ink` - Task 15
- `prototype/ink/personajes/tiago.ink` - Task 16
- `prototype/ink/personajes/cacho.ink` - Task 17
- `prototype/ink/personajes/bruno.ink` - Task 18
- `prototype/ink/personajes/claudia.ink` - Task 19

### Mecánicas
- `prototype/ink/mecanicas/recursos.ink` - Task 24
- `prototype/ink/variables.ink` - Task 24

### Ubicaciones
- `prototype/ink/ubicaciones/olla.ink` - Tasks 21, 22

### Documentación
- `docs/MASTER-PLAN.md` - Task 27
- `docs/design/narrative-map.md` - Task 28
- `docs/design/flowcharts.md` - Task 29

### Build
- `prototype/web/un_dia_mas.json` - Task 26
- `prototype/web/un_dia_mas.js` - Task 26

---

## Verificación Final

Después de completar todas las tareas:

1. **Compilar sin errores**: `./bin/inklecate prototype/ink/main.ink`
2. **Jugar ruta Lucía**: Verificar escenas en L, M, V, S, D
3. **Jugar ruta Tiago**: Verificar decisión Bruno vs comunidad
4. **Jugar ruta Bruno**: Verificar amenazas y confrontaciones
5. **Jugar ruta Claudia**: Verificar auditoría y resistencia
6. **Alcanzar final_huelga**: Verificar thresholds reducidos funcionan
7. **Alcanzar final_ocupacion**: Verificar con conexion y llama altas
