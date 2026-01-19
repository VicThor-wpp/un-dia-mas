# Propuesta Narrativa Integral (Un Día Más / La Llama)

**Fecha:** 2026-01-19  
**Estado:** Propuesta para discusión / implementación iterativa  
**Scope:** Ajustes narrativos + reactividad (Ink). No incluye UI.

## 0) Qué queremos lograr (criterios de éxito)

1. **Consecuencias visibles**: que el jugador “vea” el impacto de `CONEXIÓN / DIGNIDAD / LLAMA / TRAUMA / ACUMULACIÓN` en escenas, no solo en finales.
2. **Objetivo diario claro**: cada día tiene una pregunta operativa (“¿qué tengo que resolver hoy?”) además de la pregunta existencial.
3. **Payoff de creación de personaje**: `perdida / atadura / posicion` reescriben momentos clave (mínimo 2 callbacks por variable en la semana).
4. **Setpieces con dilemas reales**: un “momento Walter/condiciones”, un “momento Juan/laburo”, un “momento asamblea/decisión irreversible”.
5. **Finales con escena propia**: cada final cierra con 1 imagen/acto concreto + 1 callback a una decisión + 1 idea internalizada.

Referencias actuales: `prototype/ink/dias/*.ink`, `prototype/ink/personajes/*.ink`, `prototype/ink/finales/finales.ink`, `prototype/ink/variables.ink`, `docs/game-design-index.md`.

---

## 1) Problemas actuales (síntesis)

### 1.1 Reactividad baja (stats “invisibles”)
Las elecciones mueven stats, pero muchas rutas vuelven a la misma escena sin una diferencia clara en:
- trato de NPCs
- disponibilidad de ayuda
- tono de narración
- consecuencias concretas al día siguiente

### 1.2 Falta de “misión del día”
El arco emocional está claro, pero faltan micro-objetivos (“hoy hay que…”) que sostengan el impulso de jugar.

### 1.3 Walter/ACUMULACIÓN no tiene escena fuerte
Existe `acumulacion` y `final_walter`, pero falta un dilema explícito dentro de la semana que:
- te dé un beneficio inmediato
- te cobre un costo social/ético inmediato

### 1.4 Juan se apaga demasiado pronto
Juan es un ancla del mundo laboral; después del despido queda como prólogo.

### 1.5 Desalineación GDD vs prototipo
El GDD dice vínculo aleatorio, el prototipo lo hace elección directa (ver `docs/game-design-index.md` vs `prototype/ink/main.ink`).

---

## 2) Principio rector: “promesas” por día

Cada día empieza con una **promesa concreta** (texto + tracking), y termina con:
- **resultado** (logrado / a medias / fallido)
- **consecuencia** (una escena corta o una modificación visible)

### Implementación mínima (Ink)
- Variables:
  - `VAR promesa_del_dia = ""` (o `VAR promesa_lunes = false` etc.)
  - `VAR promesa_cumplida = false`
- Un bloque `# OBJETIVO` al inicio del día (título + 1 frase).
- Un bloque `# CIERRE` en la noche con 2–4 líneas que reflejen el estado.

---

## 3) Cambios por día (estructura y escenas)

> Nota: no es “escribir 10k líneas nuevas”; es introducir 1–2 setpieces cortos por día y reactividad transversal.

### LUNES — “Señales / primer puente”
**Objetivo:** “No quedarte solo con la sensación rara.”

**Setpiece nuevo (corto):** *Juan te pasa un dato concreto*  
- Gatillo: si hablaste con Juan o con el jefe (`lunes_pre_almuerzo_decision`)  
- Resultado visible el martes: `yo_se_de_renzo = true` desbloquea una opción informada en RRHH (aunque no cambie el despido, cambia tu dignidad/tono).

**Reactividad de creación de personaje (callback 1):**
- `perdida == "relacion"`: evitar calles / “la pasás por adentro”.
- `atadura == "barrio"`: mirada distinta a la olla/kiosco.
- `posicion == "ajeno"`: minimiza lo colectivo; `quemado`: sospecha; `esperanzado`: busca salida; `ambiguo`: se queda en la pregunta.

**Consecuencia visible:**
- `conexion >= 4`: alguien te saluda por el nombre (kiosco o parada). Si no, pasás “invisible”.

---

### MARTES — “La propuesta / el secreto”
**Objetivo:** “Contárselo a alguien o pagar el costo de ocultarlo.”

**Setpiece nuevo:** *RRHH lo vuelve “confidencial”*  
Una escena breve donde te piden “no hablar” (esto es clave para `DIGNIDAD` y `ACUMULACIÓN`).
- Elegir callar: sube `acumulacion` (oculto) y baja `conexion` (visible).
- Elegir hablar: sube `conexion` y sube `trauma` (por exposición) o baja `dignidad` si te tratan de “conflictivo”.

**Reactividad transversal:**
- Si `conte_a_alguien == false`, el texto nocturno cambia a “doble vida”.
- Si `conte_a_alguien == true`, aparece 1 respuesta distinta del vínculo (“no te vendo esperanza; te escucho”).

**Consecuencia visible el miércoles:**
- Si callaste, el miércoles la gente “ya sabía por otro lado” (humillación).
- Si hablaste, hay 1 mensaje de apoyo (aunque no resuelva nada).

---

### MIÉRCOLES — “El despido / la primera decisión irreversible”
**Objetivo:** “Elegir un primer acto: procesar / buscar / conectar.”

**Setpiece reforzado:** *La salida del trabajo como rito de paso*  
Ya existe, pero falta “material” concreto:
- un papel (carta/recibo)
- un objeto (llaves, credencial)
- un sonido (la puerta, el molinete)

**Puente Juan post-despido (nuevo):**
- Si `renzo_relacion >= 3`, Juan te cruza el mismo día (mensaje/llamada) y te ofrece una única cosa concreta: “te paso un contacto / un lugar / una recomendación”.
  - Aceptar: sube `acumulacion` si es “sálvese quien pueda” (depende de cómo se escriba) o sube `conexion` si lo llevás al barrio (“vení a la olla conmigo”).

**Reactividad de `perdida`:**
La idea involuntaria `idea_quien_soy` se formula distinto según pérdida:
- familiar: “¿Quién soy sin el rol que heredé?”
- relación: “¿Quién soy sin alguien mirándome?”
- futuro: “¿Quién soy sin el plan?”
- vacío: “¿Quién soy si nunca supe?”

---

### JUEVES — “Primera visita a la olla / el precio de pedir”
**Objetivo:** “Hacer algo con el tiempo nuevo.”

**Setpiece nuevo (Walter aparece en serio):** *Oferta con condiciones explícitas*  
En `jueves_olla` o un nodo paralelo:
- Walter ofrece **resolver el viernes** (comida o plata) si la olla:
  1) le deja poner su “logo/alianza”
  2) le da datos/fotos/historias
  3) acepta que él “coordine” (verticalización)
- El jugador elige:
  - **Explorar** (no aceptar todavía): `walter_aparecio = true`, `acumulacion += 1` (oculto), cambia el tono de Elena/Marcos.
  - **Rechazar**: sube `dignidad`, baja `llama` si se percibe como “romántico sin plan” (según contexto), o sube `llama` si el colectivo lo banca.
  - **Aceptar**: sube fuerte `acumulacion`, sube `llama` a corto (se resuelve el viernes), baja `conexion` (desconfianza) y setea un conflicto para asamblea.

**Reactividad visible:**
- Si ayudaste en olla (`ayude_en_olla`), Sofía cambia trato y te cuenta 1 dato íntimo más temprano (te “incluye”).
- Si no ayudaste, la olla se siente “ajena” y el texto lo marca.

---

### VIERNES — “Crisis concreta / plan”
**Objetivo:** “Que hoy coman. Como sea. Decidir el costo.”

**Expandir el setpiece existente (`viernes_reunion`) con 1 nodo de dilema Walter:**
- Si `walter_aparecio`:
  - opción: “usar lo de Walter para salvar el día”
  - opción: “no usarlo y jugársela a colecta/vecinos”
  - opción: “negociar condiciones (tirada de `dignidad`/`conexion`)”

**Resultado visible inmediato (no solo stats):**
- “comieron todos / comieron menos / no abrió”
  - esto setea `olla_abierta` y modifica sábado.

**Consecuencia social:**
- Si aceptaste Walter: aparecen comentarios, miradas, un vecino que “no quiere foto”.
- Si no aceptaste y falló: trauma y culpa (pero dignidad puede quedar alta).

---

### SÁBADO — “Asamblea / decisión irreversible”
**Objetivo:** “Definir el modelo: sostener a cualquier costo vs sostener sin destruir.”

**Convertir `sabado_asamblea` en decisión de 3 caminos (cada uno con tradeoff):**
1. **Rotación real**: se redistribuye el trabajo (sube `conexion`, sube `llama`, baja `trauma` futuro vía texto; requiere `conexion` mínima o haber ayudado).
2. **Aceptar ayuda externa** (Walter/político/ONG): sube `llama` corto, sube `acumulacion`, baja `dignidad` o `conexion` según quién lo dice.
3. **Cierre / pausa**: baja `llama`, sube `trauma`, pero sube `dignidad` si se reconoce el límite (no moralizar; es “cuidar a Sofía” vs “hambre real”).

**Reactividad de Marcos:**
- Si `marcos_vino_a_asamblea`: puede subir `llama` con 1 discurso corto (no panfleto, experiencia).
- Si no vino: su fragmento es “mirar desde afuera”, y eso baja `llama` sutilmente.

**Consecuencia visible domingo:**
- Domingo cambia el “ambiente del barrio” (grupo afuera de la olla, silencio, o movimiento de organización).

---

### DOMINGO — “Cierre / evaluación con escena”
**Objetivo:** “Nombrar qué cambió (aunque sea pequeño).”

**Cambiar `evaluar_final` para que cada final tenga:**
- 1 escena concreta distinta
- 1 callback a decisión (Walter/ayuda/contar/no ir asamblea)
- 1 idea internalizada (si existe) como cierre, no solo como insert

Ejemplos de escena final (propuesta):
- **LA RED**: te asignan una tarea simple para el lunes (rotación) y alguien te espera con café; el foco es pertenecer, no “solución”.
- **SOLO**: ves la olla desde lejos, cerrada o abierta, y seguís; el foco es invisibilidad.
- **QUIZÁS**: un mensaje pendiente / una invitación a una feria; el foco es “posibilidad” concreta.
- **INCIERTO**: un lunes en blanco, pero con un detalle (un papel, un contacto, un cuaderno) que demuestra que algo quedó.
- **GRIS**: somatización + ritual mínimo de cuidado (ducha/café/pastilla) sin moraleja.
- **EL TRATO**: recibís el primer “pedido” de Walter (mensaje/llamada) para la semana siguiente: no es futuro abstracto, es deuda.

Archivo objetivo: `prototype/ink/finales/finales.ink`.

---

## 4) Reactividad transversal (la “matriz”)

### 4.1 Umbrales que deben notarse (mínimo)
- `CONEXIÓN`:
  - `<4`: el mundo te “no ve”; menos invitaciones, más silencio.
  - `>=6`: te buscan, te incluyen, te asignan tareas, te cuentan cosas.
- `DIGNIDAD`:
  - `<4`: texto interno más duro, opciones de “evitar/conceder”.
  - `>=7`: opciones de plantarte sin que sea suicida; la gente te respeta.
- `LLAMA`:
  - `<3`: fragmentos con cinismo/fatiga; menos humor/ternura.
  - `>=6`: aparece ternura concreta (no épica): cafés, chistes, pequeñas victorias.
- `TRAUMA`:
  - `>=4`: interrupciones del cuerpo, sueño roto, rumiación; no para castigar, para hacer visible el costo.
- `ACUMULACIÓN` (oculto):
  - `>=5`: la gente te trata distinto (miradas, distancia), y el juego te ofrece “atajos” más seguido.

### 4.2 Payoff de `perdida/atadura/posicion` (mínimos por semana)
- **`perdida`**: 2 callbacks (miércoles + sábado o domingo).
- **`atadura`**: 2 callbacks (lunes + domingo).
- **`posicion`**: 2 callbacks (martes + sábado) donde el texto y/o opciones cambian.

Implementación: bloques de texto condicionados, sin multiplicar ramas completas.

---

## 5) Arcos de NPCs (beats y triggers)

### Sofía (sostener / quebrarse / delegar)
- Beats:
  1) funcional cansada
  2) admite “no doy más”
  3) pide ayuda (no romántico)
  4) acepta delegar o se quiebra (según sábado)
- Triggers:
  - `sofia_estado` avanza si `ayude_en_olla` y si la asamblea decide rotación.

### Elena (memoria / límite / transmisión)
- Beats:
  1) historia 2002 como espejo (ya existe)
  2) consejo de modelo (“cómo seguir”)
  3) transferencia de memoria (te da algo: nombre/contacto/cuaderno)
- Trigger:
  - `escuche_sobre_2002` habilita un callback en sábado o final.

### Diego (pertenecer / espejo / precariedad migrante)
- Beats:
  1) ojo fresco: “esto es difícil, pero…”
  2) te cuenta historia (ya existe)
  3) vulnerabilidad: pierde laburo o casi (opcional según scope)
- Trigger:
  - si `diego_me_conto_historia`, domingo tiene un diálogo distinto sobre futuro.

### Marcos (quemado / reconexión / sentido)
- Beats:
  1) aislamiento
  2) confiesa despido (ya existe)
  3) elige entrar o mirar desde afuera (sábado)
- Trigger:
  - `marcos_vino_a_asamblea` cambia `LLAMA` en domingo.

### Juan (miedo / espejo / fractura del “compañero”)
- Beats:
  1) rumor
  2) “abrazo torpe” (ya existe)
  3) el contacto se pierde (ya existe), pero con 1 última utilidad concreta (nuevo)
- Trigger:
  - `renzo_relacion` >= umbral desbloquea ayuda concreta miércoles/jueves.

---

## 6) Plan de implementación (orden recomendado)

1. **Alinear intención**: decidir si `vinculo` es aleatorio o elección (y documentarlo en `prototype/README.md` + `docs/game-design-index.md`).
2. **Walter setpiece**: agregar 1 escena fuerte + consecuencias viernes/sábado.
3. **Juan puente post-despido**: 1 escena corta con consecuencia.
4. **Promesas por día**: insertar bloques objetivo/cierre (mínimo lunes–viernes).
5. **Umbrales visibles**: 2–3 reactividades por stat (texto + una opción).
6. **Finales con escena propia**: reescritura pequeña de `prototype/ink/finales/finales.ink`.

---

## 7) Matriz de playtesting (para validar que “se note”)

### Caminos mínimos (12 corridas)
- 4 vínculos (Sofía/Elena/Diego/Marcos) × 3 estilos:
  1) “me conecto” (ayudo + asamblea)
  2) “me aíslo” (casa + no asamblea)
  3) “atajos” (Walter/condiciones)

### Checklist por corrida
- ¿Entendí el objetivo del día sin leer docs?
- ¿Vi al menos 2 consecuencias visibles por stats?
- ¿Se sintió distinto el vínculo?
- ¿El final tuvo escena propia + callback?

---

## 8) Notas de tono (para no panfletear)

- Evitar “explicar” lo político; mostrarlo en micro-acciones (tiempo, cansancio, vergüenza, burocracia, foto con logo).
- La asamblea no “resuelve”: decide un modelo y paga un costo.
- Walter no es “villano caricatura”: es utilidad con precio.
