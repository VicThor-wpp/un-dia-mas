# Political Sharpening - Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Give characters the political vocabulary they'd actually have. Name structures, not just symptoms. Make the game's anti-capitalist analysis explicit through character voice, not authorial lecture.

**Architecture:** Surgical edits to existing dialogue — 3-15 lines per change. No new knots, no new variables, no structural changes. Every edit replaces vague language ("el sistema", "las cosas", "ellos") with specific language the character would realistically use (Elena says "capitalismo" because a 70-year-old Uruguayan organizer would; Lucía names laws because she's a union delegate). The principle: show the same things, but let characters NAME what they see.

**Tech Stack:** Ink (Inkle), inklecate compiler

---

## Task 1: Elena names capitalism and class

**Files:**
- Modify: `prototype/ink/personajes/elena.ink`

**Context:** Elena is 70+, organized through the 2002 crisis, worked in a textile factory in Cerro, was near tupamaros. She says "el de arriba siempre caga al de abajo" (line 719) but never says "capitalismo." A woman with her history would use that word like she uses "mate" — without thinking it's a big deal.

**Step 1: Sharpen elena_sobre_2002 (lines 407-442)**

Find the line:
```ink
"Organizándonos. No esperando.
Entendiendo que la vergüenza es de ellos, no nuestra."
```

Replace with:
```ink
"Organizándonos. No esperando.
Entendiendo que la vergüenza es de ellos, no nuestra.
El capitalismo necesita que te dé vergüenza ser pobre.
Así no pedís lo que te corresponde."
```

**Step 2: Sharpen elena_sobre_2002 ending (lines 436-440)**

Find the line:
```ink
"Después volvió todo. El país se acomodó para los que siempre están bien. Los políticos se votaron sus propios aumentos y nos dijeron que la 'crisis había pasado'."
```

Replace with:
```ink
"Después volvió todo. El capital se reacomodó. Los de siempre volvieron a ganar. Los políticos se votaron sus propios aumentos y nos dijeron que la 'crisis había pasado'. Pero la crisis no pasa. La crisis es el sistema. Lo que pasa es que a veces se nota más."
```

**Step 3: Sharpen elena_anarquismo (line 719)**

Find the line:
```ink
"Pero aprendí que el de arriba siempre caga al de abajo. No importa el color de la bandera."
```

Replace with:
```ink
"Pero aprendí que el de arriba siempre caga al de abajo. No importa el color de la bandera. Capitalismo, socialismo de Estado, lo que sea. Si hay un arriba y un abajo, el de arriba te caga."
```

**Step 4: Add frigorífico reference to elena_historia_olla (lines 228-232)**

Find the line:
```ink
"No teníamos nada. Pero teníamos bronca y teníamos manos.
Cocinábamos en la calle para que nos vieran. Para que supieran que no nos íbamos a morir en silencio."
```

Replace with:
```ink
"No teníamos nada. Pero teníamos bronca y teníamos manos.
Cuando cerraron el frigorífico del Cerro, setecientas familias se quedaron en la calle.
Cocinábamos en la vereda para que nos vieran. Para que supieran que no nos íbamos a morir en silencio."
```

**Step 5: Compile and test**

```bash
cd /home/victor/Exp/un-dia-mas/prototype && npm run build && npm test
```

**Step 6: Commit**

```bash
git add prototype/ink/personajes/elena.ink
git commit -m "feat(narrative): Elena names capitalism, frigorífico del Cerro, crisis as system"
```

---

## Task 2: Diego explains WHY cooperatives work

**Files:**
- Modify: `prototype/ink/personajes/diego.ink`

**Context:** Diego describes CECOSESOLA (what it is, how it operated) but never explains WHY horizontal organization is materially superior to hierarchy. He says "no había patrón" but not WHY that matters economically. A Venezuelan who grew up in CECOSESOLA would know this intuitively.

**Step 1: Expand diego_cecosesola_cont (after line ~451)**

Find the section where Diego says:
```ink
"El Estado quería que dependiéramos de él. Créditos estatales, contratos oficiales, consejos comunales alineados al partido. Nosotros dijimos que no. CECOSESOLA nunca aceptó plata del gobierno. Preferíamos ser pobres y libres."
```

After this, add:
```ink
* ["¿Pero por qué funciona sin jefe?"]

    Diego sonríe. Como si le hubieran hecho la pregunta correcta.

    "Porque el jefe se queda con la diferencia.
    Vos producís cien, el jefe te paga treinta, se queda setenta.
    Eso es una empresa.

    En la cooperativa, producís cien, te quedás cien.
    No hay nadie arriba sacando tajada."

    "Así de simple."

    "Así de simple. Por eso nos combaten. No porque no funcione.
    Porque funciona demasiado bien."

* [Asentir]
    -> diego_post_cecosesola
```

Make sure this flows correctly to whatever comes after (the "Y eso nos hizo enemigos" line or the tunnel return). Adjust diverts as needed.

**Step 2: Sharpen diego_y_marcos (lines 576-622)**

Find Diego's closing line:
```ink
"Sin la asamblea, sos solo otro tipo con libros y buenas intenciones. Y eso no alcanza."
```

Replace with:
```ink
"Sin la asamblea, sos solo otro tipo con libros y buenas intenciones. Y eso no alcanza.
La asamblea no es democracia de juguete. Es el único lugar donde el que trabaja decide.
En la empresa decide el dueño. En el Estado decide el funcionario. En la asamblea decidís vos."
```

**Step 3: Compile and test**

```bash
cd /home/victor/Exp/un-dia-mas/prototype && npm run build && npm test
```

**Step 4: Commit**

```bash
git add prototype/ink/personajes/diego.ink
git commit -m "feat(narrative): Diego explains WHY cooperatives work — surplus, assembly as real democracy"
```

---

## Task 3: Lucía names the legal architecture of precarity

**Files:**
- Modify: `prototype/ink/personajes/lucia.ink`

**Context:** Lucía already mentions BPS, MTSS, PIT-CNT, convenio colectivo. She's the most institutionally literate character. But she could be sharper about WHO designed the legal framework and WHY.

**Step 1: Sharpen lucia_explica_sistema (around line 682)**

Find the line:
```ink
"El sistema está armado así. Las empresas tercerizan, contratan unipersonales, y se ahorran el treinta por ciento de aportes. Vos ponés el cuerpo, ellos ponen las reglas."
```

Replace with:
```ink
"El sistema está armado así. Las empresas tercerizan, contratan unipersonales, y se ahorran el treinta por ciento de aportes. Vos ponés el cuerpo, ellos ponen las reglas.

¿Y sabés lo peor? No es un error. Es una ley. La escribieron así a propósito. Las cámaras empresariales la pidieron. Los legisladores la votaron. Y los sindicatos no pudieron frenarla porque los unipersonales no somos 'trabajadores' ante la ley.

Somos 'empresas'. De una sola persona. Sin capital. Sin empleados. Sin nada. Pero somos 'empresas'."
```

**Step 2: Sharpen lucia's closing line (around line 696)**

Find:
```ink
"El Estado no te va a salvar. El sindicato tampoco, porque legalmente no sos de los nuestros."
```

Replace with:
```ink
"El Estado no te va a salvar. El Estado es el que firmó la ley que te deja afuera. El sindicato tampoco puede, porque legalmente no sos de los nuestros. Sos una 'empresa' que le factura a otra empresa. Dos empresas haciendo negocios. ¿Ves la trampa?"
```

**Step 3: Compile and test**

```bash
cd /home/victor/Exp/un-dia-mas/prototype && npm run build && npm test
```

**Step 4: Commit**

```bash
git add prototype/ink/personajes/lucia.ink
git commit -m "feat(narrative): Lucía names who wrote the precarity laws and why"
```

---

## Task 4: Bruno's ideology named as fascism

**Files:**
- Modify: `prototype/ink/personajes/bruno.ink`
- Modify: `prototype/ink/personajes/elena.ink`

**Context:** Bruno offers "order, discipline, purpose" but the game never calls this fascism. Elena connects him to the dictatorship ("tiene los mismos ojos") but doesn't name the pattern. A woman who lived through the dictatorship would name it.

**Step 1: Sharpen elena_sobre_bruno (around lines 149-151)**

Find:
```ink
"No sé si es el mismo. Pero es del mismo palo.
Orden. Disciplina. Control.
Las palabras cambian. La mirada no."
```

Replace with:
```ink
"No sé si es el mismo. Pero es del mismo palo.
Orden. Disciplina. Control. Fascismo, m'hijo. Se llama fascismo.
No importa si usa uniforme o camisa. Si te pide obediencia a cambio de seguridad, es fascismo.
Las palabras cambian. La mirada no."
```

**Step 2: Add political analysis to bruno's recruitment (bruno.ink, around line 421)**

Find the narrator line:
```ink
Eso último suena menos a libertad de lo que pretende.
```

Replace with:
```ink
Eso último suena menos a libertad de lo que pretende.

El fascismo siempre empieza así. No con tanques.
Con alguien que le ofrece orden a los que no tienen nada.
```

**Step 3: Sharpen elena_confronta_bruno (around lines 226-230)**

Find:
```ink
Elena da un paso adelante.
Bruno, por primera vez, retrocede.

"La dignidad no se cobra, Bruno. Se construye.
Vos no sabés de eso."
```

Replace with:
```ink
Elena da un paso adelante.
Bruno, por primera vez, retrocede.

"La dignidad no se cobra, Bruno. Se construye. Entre todos.
Vos lo que hacés es comprar obediencia con comida. Eso tiene nombre.
Y los que lo hicieron antes terminaron mal."
```

**Step 4: Compile and test**

```bash
cd /home/victor/Exp/un-dia-mas/prototype && npm run build && npm test
```

**Step 5: Commit**

```bash
git add prototype/ink/personajes/elena.ink prototype/ink/personajes/bruno.ink
git commit -m "feat(narrative): name fascism explicitly — Elena calls it, narrator confirms it"
```

---

## Task 5: Claudia as systemic function, not individual cruelty

**Files:**
- Modify: `prototype/ink/personajes/claudia.ink`

**Context:** Claudia's humanization scene (claudia_sola_humana, lines 385-411) makes her sympathetic by showing she remembers 2002 ollas. This undermines the political analysis. The point isn't that she's cruel — it's that her FUNCTION is violence regardless of her feelings. Reframe, don't remove.

**Step 1: Sharpen claudia_sola_humana (lines 396-410)**

Find:
```ink
"No es lo mismo", se dice.
"Ahora hay protocolos. Controles."

Pero la imagen no se va.

Prende el auto.
Se va.

Mañana tiene que decidir.
Hoy prefiere no pensar.
```

Replace with:
```ink
"No es lo mismo", se dice.
"Ahora hay protocolos. Controles."

Pero la imagen no se va.

Sabe lo que hace.
Sabe que el protocolo que aplica es el mismo que hubiera cerrado la olla de su abuela.
Pero el protocolo no es suyo. Es del ministerio. Del sistema.
Ella solo aplica.

Eso es lo que se dice.

Prende el auto.
Se va.

El problema no es Claudia.
El problema es que el Estado necesita Claudias.
Gente que sabe y aplica igual.
```

**Step 2: Sharpen the narrator in claudia_el_tupper (after line 242)**

Find:
```ink
El hambre convertido en infracción administrativa.
La solidaridad, en delito contable.
```

Replace with:
```ink
El hambre convertido en infracción administrativa.
La solidaridad, en delito contable.
El Estado no falla en ayudar. El Estado controla quién ayuda.
Porque una olla que funciona sin el Estado demuestra que el Estado no es necesario.
Y eso no puede ser.
```

**Step 3: Compile and test**

```bash
cd /home/victor/Exp/un-dia-mas/prototype && npm run build && npm test
```

**Step 4: Commit**

```bash
git add prototype/ink/personajes/claudia.ink
git commit -m "feat(narrative): Claudia as systemic function — the State needs Claudias"
```

---

## Task 6: Despido scene — name the mechanism

**Files:**
- Modify: `prototype/ink/ubicaciones/laburo.ink`

**Context:** The despido scene already has "Es el sistema funcionando como fue diseñado" (line ~579). But "optimización de recursos" goes unchallenged. The protagonist should crack the euphemism.

**Step 1: Sharpen laburo_despido (after "Optimización de recursos. Vos sos el recurso.")**

Find:
```ink
Optimización de recursos. Vos sos el recurso.
```

Replace with:
```ink
Optimización de recursos. Vos sos el recurso.
Lo que significa: tu laburo generaba plata. Pero no la suficiente.
No para vos. Para ellos. Siempre para ellos.
```

**Step 2: Sharpen laburo_despido_preguntar (after the "profesional" rant)**

Find:
```ink
Querés gritar.
Pero no gritás.
Porque sos profesional.
Porque te enseñaron a ser profesional mientras te robaban.

Nunca es personal.
Es el sistema funcionando como fue diseñado.
```

Replace with:
```ink
Querés gritar.
Pero no gritás.
Porque sos profesional.
Porque te enseñaron a ser profesional mientras te robaban.

Nunca es personal.
Es el capitalismo funcionando como fue diseñado.
Tu laburo vale más de lo que te pagan. Siempre valió más.
La diferencia se la quedó la empresa. Tres años de diferencia.
Y ahora te dan una caja de cartón.
```

**Step 3: Compile and test**

```bash
cd /home/victor/Exp/un-dia-mas/prototype && npm run build && npm test
```

**Step 4: Commit**

```bash
git add prototype/ink/ubicaciones/laburo.ink
git commit -m "feat(narrative): despido scene names capitalism and surplus extraction"
```

---

## Task 7: final_apagado — decouple clarity from despair

**Files:**
- Modify: `prototype/ink/finales/finales.ink`

**Context:** final_apagado has the sharpest political analysis in the game ("No estás enfermo. El sistema está enfermo.") but it's the WORST ending. This teaches: understanding the system = depression. The fix: keep the analysis, add a crack of light. Not false hope — but the recognition that clarity is the first step, not the last.

**Step 1: Add to final_apagado, after "Y vos te la tomás" and before the idea conditionals**

Find:
```ink
Porque mañana hay que levantarse igual.

* [...]
-

{idea_quien_soy:
```

Replace with:
```ink
Porque mañana hay que levantarse igual.

* [...]
-

Pero hay algo que la pastilla no borra.

Sabés.

Sabés que el problema no sos vos.
Sabés que el alquiler está caro porque alguien se enriquece con tu necesidad.
Sabés que "flexibilidad" es la palabra que usan para no darte derechos.
Sabés que hay otros que saben lo mismo.

No es consuelo. Pero es el principio de algo.
La rabia lúcida no es enfermedad.
Es el primer paso.

* [...]
-

{idea_quien_soy:
```

**Step 2: Compile and test**

```bash
cd /home/victor/Exp/un-dia-mas/prototype && npm run build && npm test && npm run test:endings
```

**Step 3: Commit**

```bash
git add prototype/ink/finales/finales.ink
git commit -m "feat(narrative): final_apagado — clarity is not despair, it's the first step"
```

---

## Task 8: The olla named as political project

**Files:**
- Modify: `prototype/ink/personajes/sofia.ink`

**Context:** Sofia runs the olla but never names it as a political project. She sees it as survival, not as proof that autonomous organization works. One moment where she realizes what the olla IS.

**Step 1: Add to sofia_conversacion_profunda (after her existing dialogue about the olla)**

Find a natural conversation point where Sofia talks about the olla. After her existing text about struggling to keep it running, add:

```ink
{participe_asamblea && veces_que_ayude >= 2:
    Sofia se queda mirando la olla.

    "¿Sabés qué me dijo Elena el otro día?"

    * [...]
    -

    "Que esto no es caridad. Que esto es política."

    "Y yo le dije que no, que esto es cocinar."

    "Pero después lo pensé. Y tiene razón."

    "Nadie nos mandó a hacer esto. Nadie nos paga.
    Nadie nos dio permiso.
    Lo hacemos porque se necesita.
    Y funciona."

    "Eso es poder, ¿no? Poder real.
    No el poder de mandar. El poder de hacer."
}
```

Find the right insertion point — after the cross-NPC references (Diego/Elena/Marcos) and before the choice options.

**Step 2: Compile and test**

```bash
cd /home/victor/Exp/un-dia-mas/prototype && npm run build && npm test
```

**Step 3: Commit**

```bash
git add prototype/ink/personajes/sofia.ink
git commit -m "feat(narrative): Sofia names the olla as political project — power to do, not to command"
```

---

## Task 9: Activate idea_sabotaje_legitimo

**Files:**
- Modify: `prototype/ink/mecanicas/sistema_ideas.ink`

**Context:** The function `activar_sabotaje_legitimo()` exists but is NEVER CALLED. The idea ("A veces hay que romper para construir") has no narrative scene. Add one in the night reflection system, triggered by experiencing Claudia's violence + having political consciousness.

**Step 1: Add activation scene to sistema_ideas.ink reflexion_nocturna**

Find the section in sistema_ideas.ink where other political ideas are activated during night reflection (around the `claudia_hostilidad` check). After the `idea_antagonismo_clase` activation block, add:

```ink
// Sabotaje legítimo: cuando la legalidad es la trampa
{idea_antagonismo_clase && claudia_hostilidad >= 2 && lista_entregada == false && not idea_sabotaje_legitimo:

    Pensás en Claudia. En la planilla. En el protocolo.

    Lo "legal" es que te pidan cédula para comer.
    Lo "ilegal" es darle comida a alguien sin papeles.

    Si la ley dice que el hambre es legal y la solidaridad es delito...

    * [Pensar: "La ley está mal."]
        La ley no está mal. La ley funciona perfecto.
        Protege la propiedad. No a las personas.
        Siempre fue así.

        A veces, desobedecer la ley es lo más digno que podés hacer.

        ~ activar_sabotaje_legitimo()
        # IDEA DESBLOQUEADA: "A VECES HAY QUE ROMPER PARA CONSTRUIR"
        # NOTIFICATION:info:Una idea peligrosa pero honesta

    * [Dejarlo pasar]
        No es el momento.
        Quizás nunca.
}
```

Find the exact insertion point in the reflexion_nocturna flow — after the antagonismo_clase activation and before the closing of the reflection section.

**Step 2: Compile and test**

```bash
cd /home/victor/Exp/un-dia-mas/prototype && npm run build && npm test
```

**Step 3: Commit**

```bash
git add prototype/ink/mecanicas/sistema_ideas.ink
git commit -m "feat(narrative): activate idea_sabotaje_legitimo — disobedience as dignity"
```

---

## Task 10: Monday opening — set the political tone

**Files:**
- Modify: `prototype/ink/ubicaciones/laburo.ink`

**Context:** The workplace opening (laburo_llegada, laburo_manana) is pure atmosphere — "el edificio de siempre, la puerta de siempre." It could have one line that plants the political seed without being heavy.

**Step 1: Add to laburo_llegada, after "Nadie pregunta si lo es."**

Find:
```ink
Todos dicen buen día.
Nadie pregunta si lo es.

->->
```

Replace with:
```ink
Todos dicen buen día.
Nadie pregunta si lo es.

Afuera el bondi pasó lleno. Adentro el café cuesta ochenta pesos.
La empresa factura en dólares. Vos facturás en pesos.
La diferencia es el negocio de alguien.

->->
```

**Step 2: Compile and test**

```bash
cd /home/victor/Exp/un-dia-mas/prototype && npm run build && npm test
```

**Step 3: Commit**

```bash
git add prototype/ink/ubicaciones/laburo.ink
git commit -m "feat(narrative): Monday opening plants political seed — currency gap as extraction"
```

---

## Task 11: Uruguayan geographic specificity

**Files:**
- Modify: `prototype/ink/personajes/elena.ink`
- Modify: `prototype/ink/ubicaciones/laburo.ink`
- Modify: `prototype/ink/dias/lunes.ink`

**Context:** The game could be any Latin American city. Add 3-4 references that anchor it in Montevideo: barrio names, specific institutions, radio.

**Step 1: In elena_sobre_la_chola (line ~499)**

Find:
```ink
"Nos conocimos en la fábrica textil del Cerro. Año 75."
```

This already names El Cerro — good. No change needed here.

**Step 2: In laburo_llegada or laburo_manana, add a geographic anchor**

Find the morning routine section in laburo_manana. After the mental check and before `->->`, add:

```ink
{d6() >= 5:
    Por la ventana se ve el puerto. Las grúas. Los contenedores que van y vienen.
    La riqueza del país pasando de largo.
}
```

**Step 3: In lunes_amanecer or the casa_despertar module, add radio reference**

Search for the ambiente_amanecer tunnel or casa_despertar. If there's a morning atmosphere scene, add:

```ink
{escucho_radio:
    La CX 30 habla de despidos en la zona franca.
    Trescientos. "Reestructuración", dicen.
    Siempre dicen reestructuración.
}
```

If `escucho_radio` isn't set at this point, use a different condition or make it unconditional flavor text.

**Step 4: Compile and test**

```bash
cd /home/victor/Exp/un-dia-mas/prototype && npm run build && npm test
```

**Step 5: Commit**

```bash
git add prototype/ink/personajes/elena.ink prototype/ink/ubicaciones/laburo.ink prototype/ink/dias/lunes.ink
git commit -m "feat(narrative): Uruguayan specificity — puerto, CX 30, frigorífico del Cerro"
```

---

## Task 12: final_la_llama — sharpen the collective victory

**Files:**
- Modify: `prototype/ink/finales/finales.ink`

**Context:** final_la_llama says "El sistema no cambió. Quizás nunca." This is honest but defeatist. For the BEST ending, it should acknowledge that the olla IS systemic change — small, fragile, but real.

**Step 1: Replace the "El sistema no cambió" section**

Find:
```ink
El sistema no cambió.
No va a cambiar mañana.
Quizás nunca.

Pero ustedes sí cambiaron.
```

Replace with:
```ink
El sistema no cambió.
No va a cambiar mañana.

Pero en esta cuadra, en esta olla, con esta gente,
hay un pedazo de mundo que funciona sin patrón.
Sin permiso. Sin Estado.

Eso ya es cambio.
Pequeño. Frágil. Pero real.
Y los cambios reales siempre empiezan así.
```

**Step 2: Compile and test**

```bash
cd /home/victor/Exp/un-dia-mas/prototype && npm run build && npm test && npm run test:endings
```

**Step 3: Commit**

```bash
git add prototype/ink/finales/finales.ink
git commit -m "feat(narrative): final_la_llama — the olla IS systemic change, small but real"
```

---

## Task 13: Búsqueda — protagonist discovers the pattern alone

**Files:**
- Modify: `prototype/ink/ubicaciones/busqueda.ink`

**Context:** The búsqueda already has dignity moments. But the protagonist never makes the political connection ON THEIR OWN (without an NPC). After enough rejections, they should see the pattern — not because Elena told them, but because the evidence is overwhelming.

**Step 1: Add to busqueda_reflexion_domingo (the Sunday reflection on job search)**

Find the existing reflexion block for `rechazos_enviados >= 10`. After it, add:

```ink
{rechazos_enviados >= 15 && not idea_no_es_individual:

    Quince postulaciones. Cero respuestas.

    Pero esta vez no te sentís inútil.
    Te sentís estafado.

    Porque viste los números.
    847 postulantes para un puesto.
    La mitad del sueldo que pagaban antes.
    "Beneficios: fruta en la oficina."

    No es que no valés.
    Es que el mercado necesita que creas que no valés.
    Así aceptás cualquier cosa.
    Así bajás el precio de tu laburo.
    Así la ganancia de alguien sube.

    ~ activar_no_es_individual()
    # IDEA DESBLOQUEADA: "NO ES SOLO MI PROBLEMA"
    # NOTIFICATION:info:Lo viste solo. Sin que nadie te lo diga.
}
```

This is crucial: the player can discover class analysis THROUGH the búsqueda path, not just the olla path. It's earned through suffering, not through NPC teaching.

**Step 2: Compile and test**

```bash
cd /home/victor/Exp/un-dia-mas/prototype && npm run build && npm test
```

**Step 3: Commit**

```bash
git add prototype/ink/ubicaciones/busqueda.ink
git commit -m "feat(narrative): búsqueda path unlocks idea_no_es_individual through lived experience"
```

---

## Summary

| Task | Character/Scene | What changes | Lines added |
|------|----------------|-------------|-------------|
| 1 | Elena | Names capitalism, frigorífico, crisis as system | ~12 |
| 2 | Diego | Explains WHY cooperatives work (surplus, assembly) | ~15 |
| 3 | Lucía | Names who wrote precarity laws and why | ~10 |
| 4 | Bruno/Elena | Names fascism explicitly | ~8 |
| 5 | Claudia | State needs Claudias — systemic function | ~10 |
| 6 | Despido | Names capitalism and surplus extraction | ~8 |
| 7 | final_apagado | Clarity is not despair, it's the first step | ~12 |
| 8 | Sofia | Olla as political project — power to do | ~15 |
| 9 | sistema_ideas | Activate idea_sabotaje_legitimo | ~15 |
| 10 | Monday opening | Currency gap as extraction | ~3 |
| 11 | Geography | Puerto, CX 30, specificity | ~6 |
| 12 | final_la_llama | The olla IS systemic change | ~6 |
| 13 | Búsqueda | Self-discovered class analysis | ~15 |

**Total: ~135 lines of surgical edits across 13 tasks.**

**Dependencies:** None between tasks. All can be executed in parallel or any order.

**Risk:** Low. No structural changes, no new variables, no flow changes. Only dialogue modifications within existing knots.
