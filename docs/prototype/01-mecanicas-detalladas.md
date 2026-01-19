# LA LLAMA - Mecánicas Detalladas
## Prototipo: "Cuando Todo Cae"

**Conflicto híbrido:** Crisis personal (despido) + Crisis comunitaria (olla en peligro)
**Duración:** 5 días (Miércoles a Domingo)
**Estructura:** Despido el miércoles, resolución el domingo

---

## 1. SISTEMA DE RECURSOS

### 1.1 ENERGIA [Dados, 3-5 por día]

La ENERGIA representa tu capacidad para hacer cosas. No es sobre si comés: es sobre si podés levantarte a buscar laburo, si aguantás otra entrevista humillante, si te da para ir a la olla cuando podrías quedarte en la cama mirando el techo.

#### Obtención

Al despertar cada día, tirás dados para determinar cuánta ENERGIA tenés:

| Condición | Dados base | Modificadores |
|-----------|------------|---------------|
| Normal | 4 dados | - |
| Después de dormir mal | 3 dados | TRAUMA >= 5: -1 dado |
| Día de crisis (Miércoles) | 3 dados | Despido reciente: -1 dado |
| Día bueno (raro) | 5 dados | LA LLAMA >= 7: +1 dado |
| DIGNIDAD <= 3 | - | -1 dado |
| CONEXION >= 8 | - | +1 dado (alguien te trae café) |

**Mínimo absoluto:** 2 dados (siempre podés hacer algo mínimo)
**Máximo absoluto:** 6 dados (días excepcionales)

#### Gasto

Cada acción tiene un costo en dados. **El costo no es fijo: es un mínimo.** Podés invertir más dados para mejor resultado.

| Acción tipo | Costo mínimo | Dados extra = |
|-------------|--------------|---------------|
| Básica (ir a un lugar, hablar casual) | 1 dado | Mejor impresión, más detalle |
| Media (ayudar en la olla, buscar laburo) | 2 dados | Resultado más efectivo |
| Demandante (confrontación, entrevista larga) | 3 dados | Control de la situación |
| Extrema (acción directa, revelación) | 4 dados | Raramente vale la pena |

**Ejemplo concreto:**
*"Ir a ayudar a Sofía con la olla"* cuesta 1 dado mínimo. Pero si invertís 2, podés quedarte más rato y desbloquear una conversación que con 1 dado no sale. Con 3 dados, ella te cuenta lo que realmente la preocupa.

#### Agotamiento (ENERGIA = 0)

Si terminás el día sin dados:

```
EFECTO INMEDIATO:
- TRAUMA +1
- Texto: "No podés más. Te tirás en la cama. Mañana ves."

EFECTO EN SUEÑO:
- Recuperación reducida al día siguiente (-1 dado)
- Posible IDEA INVOLUNTARIA ("Esto es lo que hay")

SI PASA DOS DÍAS SEGUIDOS:
- TRAUMA +2 total
- Posible IDEA INVOLUNTARIA ("Para qué")
- Opciones del día siguiente limitadas
```

#### Recuperación

Al dormir recuperás dados, pero no todos:

| Condición de sueño | Recuperación |
|--------------------|--------------|
| Normal | Base del día siguiente |
| Después de día agotador | Base -1 |
| Después de victoria pequeña | Base normal |
| Después de fragmento esperanzador | Base +1 (máx 1 vez por semana) |
| TRAUMA >= 7 | Base -1 permanente |

---

### 1.2 CONEXION [0-10]

La CONEXION representa tu lugar en el tejido del barrio. No es popularidad: es pertenencia. Si la gente te incluye, te busca, cuenta con vos.

#### Valor inicial: 5

Estás en el barrio, te conocen, pero no sos central.

#### Cómo sube

| Acción | Cambio | Notas |
|--------|--------|-------|
| Ayudar sin que te pidan | +1 | Máximo 1 vez por día |
| Ir a la olla a dar una mano | +1 | Presencia vale |
| Pedir ayuda y aceptarla | +1 | Importante: no solo pedir, aceptar |
| Defender a alguien | +1 | En situación concreta |
| Estar en la asamblea | +1 | Participar, no solo ir |
| Dar tu tiempo cuando podrías no darlo | +2 | Si es sacrificio real |

#### Cómo baja

| Acción | Cambio | Notas |
|--------|--------|-------|
| Rechazar invitación a espacio colectivo | -1 | "No puedo" cuenta |
| Rechazar ayuda ofrecida | -1 | Aunque sea "por orgullo" |
| No aparecer cuando te necesitan | -2 | Si es explícito |
| Priorizar lo tuyo cuando el grupo necesita | -1 | Si se nota |
| Aceptar oferta de Walter | -2 | El barrio nota |
| Días sin aparecer | -1/día | Después del segundo día |

#### Efectos mecánicos

**CONEXION >= 7 (Parte del tejido)**
```
BENEFICIOS:
- Alguien te avisa de changas antes de que salgan públicas
- Te esperan aunque llegues tarde
- Podés pedir 1 dado prestado por día (alguien te banca)
- Fragmentos de NPCs te incluyen ("vi a [jugador] hoy")
- Opciones colectivas cuestan 1 dado menos

TEXTO INTERNO:
"Tenés dónde estar. Tenés a quién llamar."
```

**CONEXION 4-6 (Normal)**
```
ESTADO:
- El barrio te conoce, te saluda
- Podés participar sin fricciones
- No hay beneficios especiales
- No hay penalizaciones

TEXTO INTERNO:
Neutro, descriptivo.
```

**CONEXION <= 3 (Aislado)**
```
PENALIZACIONES:
- Opciones colectivas cuestan +1 dado
- No te enteras de cosas hasta que es tarde
- Fragmentos de NPCs no te mencionan
- Sofía no te pide ayuda (pero la necesita igual)
- Diego no te busca para hablar

TEXTO INTERNO:
"Hay gente alrededor pero podrían no estar."
```

---

### 1.3 DIGNIDAD [0-10]

La DIGNIDAD es lo que la búsqueda de laburo te va sacando de a poco. Cada CV sin respuesta. Cada entrevista donde te miran como número. Cada "te llamamos" que nunca llega. Cada vez que sentís que "no servís para nada".

#### Valor inicial: 5

Normal. Ni machacado ni firme.

#### Cómo baja

| Situación | Cambio | Ejemplo en el prototipo |
|-----------|--------|------------------------|
| Entrevista humillante | -1 | Te hacen esperar 2 horas y te atienden 5 minutos |
| Ghosting de un laburo que parecía seguro | -1 | "Te llamamos" y nunca llaman |
| Mentir sobre tu situación | -1 | "Estoy bien, eligiendo opciones" cuando no |
| Aceptar condiciones degradantes | -1 | Laburo en negro sin aguinaldo porque "algo es algo" |
| Sentir que no servís para nada | -1 | Otro día sin respuestas, sin entrevistas |
| Aguantar comentario humillante sin reaccionar | -1 | "Con la edad que tenés, difícil" |

#### Cómo sube

| Situación | Cambio | Ejemplo en el prototipo |
|-----------|--------|------------------------|
| Plantarse | +1 | Decir que no a condiciones de mierda |
| Actuar colectivamente | +1 | Ir a la asamblea y hablar |
| Que te traten como persona | +1 | Sofía que te pide ayuda como igual |
| Rechazar humillación aunque cueste | +1 | "No, así no laburo" |
| Sentir que aportás algo | +1 | Ayudar en la olla y que sirva |
| Lograr algo con otros | +2 | La olla sigue abierta por esfuerzo colectivo |

#### Efectos mecánicos

**DIGNIDAD >= 7 (Firme)**
```
BENEFICIOS:
- Opciones de confrontación disponibles
- Texto interno más firme, menos dudas
- Podés negarte a cosas sin costo de ENERGIA
- Elena te mira con reconocimiento

TEXTO INTERNO:
"Perdiste el laburo, no perdiste quién sos."
Opciones aparecen en tono afirmativo.
```

**DIGNIDAD 4-6 (Normal)**
```
ESTADO:
- Neutro
- Todas las opciones disponibles
- Texto interno estándar
```

**DIGNIDAD <= 3 (Machacado)**
```
PENALIZACIONES:
- Algunas opciones bloqueadas con "¿Para qué?"
- Confrontación cuesta +2 dados
- Texto interno derrotado
- Ideas optimistas cuestan +1 TRAUMA para internalizar

TEXTO INTERNO:
"¿Para qué mandás otro CV? Van a elegir a otro."
Las opciones aparecen como preguntas retóricas:
"Podrías decir algo. ¿Pero quién te va a escuchar?"
```

---

### 1.4 LA LLAMA [0-10, Compartida]

LA LLAMA es la capacidad colectiva de imaginar que las cosas pueden ser diferentes. No es tuya: es de todos. Pero tus acciones la afectan. Tu conexión con LA LLAMA viene de sentir que podés aportar algo, no de necesitar que te salven.

#### Valor inicial: 3

Casi apagada. Pero ahí. Después de años de derrota, algo queda.

#### Cómo sube

| Evento | Cambio | Notas |
|--------|--------|-------|
| Victoria colectiva pequeña | +1 | La olla sobrevive un día más |
| Solidaridad inesperada | +1 | Alguien ayuda sin razón |
| Acto de generosidad visible | +1 | Dar tiempo cuando podrías no darlo |
| Asamblea que llega a acuerdo | +2 | Raro pero poderoso |
| Marcos vuelve a participar | +2 | Evento especial |
| Walter pierde en algo público | +1 | El barrio lo ve |

#### Cómo baja

| Evento | Cambio | Notas |
|--------|--------|-------|
| Traición dentro del grupo | -2 | Alguien se vende |
| La olla cierra | -3 | Devastador |
| Alguien se va del barrio | -1 | Diego o similar |
| Individualismo visible | -1 | Priorizar lo propio cuando el grupo necesita |
| Derrota colectiva | -1 | Trámite rechazado, promesa rota |
| ACUMULACION colectiva | -1 | Si varios eligen lo individual |

#### Efectos mecánicos

**LA LLAMA >= 6 (Encendida)**
```
BENEFICIOS:
- Fragmentos de NPCs más esperanzados
- Opciones colectivas más efectivas (+1 al resultado)
- Ideas optimistas cuestan menos ENERGIA
- Elena sonríe a veces
- Texto del juego tiene color

TEXTO GLOBAL:
Descripciones menos grises. "El sol entra por la ventana"
en vez de "Hay luz."
```

**LA LLAMA 3-5 (Frágil)**
```
ESTADO:
- Normal, el estado base
- Todo funciona como está diseñado
- Podría apagarse, podría crecer

TEXTO GLOBAL:
Neutro. Funcional. Precario pero presente.
```

**LA LLAMA <= 2 (Casi apagada)**
```
PENALIZACIONES:
- Opciones de esperanza cuestan +1 ENERGIA
- Fragmentos de NPCs pesimistas
- Diego habla de irse
- Elena no sale del cuarto
- Algunas opciones colectivas desaparecen

TEXTO GLOBAL:
Gris. "Hay luz" se vuelve "Una luz."
Frases más cortas. Menos adjetivos.
```

**LA LLAMA = 0 (Apagada)**
```
CAMBIO DE TONO:
- El juego sigue pero todo cambia
- No hay opciones colectivas
- Cada NPC está en lo suyo
- El texto es funcional, sin emoción
- "La olla" se vuelve "el lugar donde dan comida"
- No es game over: es un estado

POSIBLE RECUPERACION:
Difícil. Requiere evento especial.
+1 si alguien hace algo inesperado.
```

---

### 1.5 ACUMULACION [0-10, Oculto]

El jugador **NUNCA** ve este número. Solo ve consecuencias. Representa tu complicidad con la lógica del capital: priorizar tu comodidad, separarte del barrio, volver a la "normalidad" a cualquier costo.

#### Valor inicial: 0

Empezás limpio.

#### Cómo sube (sin que el jugador sepa que sube)

| Acción | Cambio | El jugador ve |
|--------|--------|---------------|
| Priorizar tu búsqueda de laburo sobre ayudar | +1 | "Tenés que hacer lo tuyo" |
| Aceptar oferta de Walter | +2 | "Laburo seguro, volver a la normalidad" |
| Mentir para ventaja personal | +1 | Funcionó |
| Faltar a la olla cuando dijiste que ibas | +1 | Nada inmediato |
| Rechazar dar tu tiempo cuando podrías | +1 | Nada inmediato |
| Priorizar sistemáticamente lo individual | +1 | Por cada 3 decisiones así |

#### Efectos mecánicos (el jugador ve esto, no el número)

**ACUMULACION 0-2 (Limpio)**
```
ESTADO:
Normal. Sin efectos visibles.
```

**ACUMULACION 3-5 (Algo huele)**
```
LO QUE VE EL JUGADOR:
- "Sofía te miró raro cuando llegaste"
- Opciones colectivas cuestan +1 ENERGIA (sin explicación)
- Fragmentos de NPCs te mencionan menos
- Diego no te busca para charlar

EL JUGADOR PUEDE PENSAR:
"Qué raro" o "Será otra cosa"
```

**ACUMULACION 6-8 (El barrio nota)**
```
LO QUE VE EL JUGADOR:
- CONEXION baja automáticamente -1 por día
- "Elena no te miró cuando entraste"
- Opciones colectivas cuestan +2 ENERGIA
- Marcos hace un comentario críptico
- Fragmentos te muestran desde afuera: "Vi a [jugador] yendo para el lado de Walter"

EL JUGADOR DEBERIA NOTAR:
Algo está pasando. No le dicen qué.
```

**ACUMULACION 9-10 (Perdiste el lugar)**
```
LO QUE VE EL JUGADOR:
- No te esperan en la olla
- Diego te evita
- Sofía no te pide ayuda
- Walter te habla como si fueras de los suyos
- Fragmento especial: "Ya no es de acá. No importa si vive acá."

FINAL ESPECIAL DESBLOQUEADO:
"Volviste a la normalidad pero perdiste algo" - Tenés laburo pero estás solo.
```

---

### 1.6 TRAUMA [0-10, Solo Sube]

El TRAUMA nunca baja. Se acumula. No es sobre peligro físico: es el desgaste de sentir que perdiste tu lugar, de no saber quién sos sin laburo, de ver cómo tu vida se reorganiza forzosamente.

#### Valor inicial: 0

Al inicio del prototipo, empezás en 0. El despido es el primer golpe.

#### Cómo sube

| Evento | Cambio | Notas |
|--------|--------|-------|
| Terminar día sin ENERGIA | +1 | Agotamiento total |
| El despido | +2 | Crisis identitaria: "¿Quién soy si no tengo laburo?" |
| Soledad prolongada (CONEXION <= 3 por 2+ días) | +1 | Aislamiento |
| Rechazo tras rechazo en búsqueda de laburo | +1 | Sentir que no servís |
| Perder algo importante | +1 | NPC que se va, olla que cierra |
| No poder ayudar cuando querés | +1 | Impotencia |
| Internalizar IDEA INVOLUNTARIA negativa | +1 | Costo de ciertas ideas |

#### Efectos mecánicos

**TRAUMA 0-2 (Entero)**
```
ESTADO:
Normal. Sin efectos.
Texto interno estándar.
```

**TRAUMA 3-5 (Acumulando)**
```
EFECTOS:
- IDEAS INVOLUNTARIAS empiezan a aparecer
- "Esto es lo que hay" puede internalizarse sin elegirlo
- Texto interno tiene momentos de deriva
- Sueño afectado: -1 dado ocasional

TEXTO INTERNO EJEMPLO:
"Podrías ir a ayudar. O podrías quedarte acá.
Total... no. Andá. Andá."
```

**TRAUMA 6-8 (Cargado)**
```
EFECTOS:
- Opciones pesimistas son "gratis" (0 dados)
- Opciones optimistas cuestan +1 ENERGIA
- IDEAS INVOLUNTARIAS frecuentes
- Fragmentos tienen tono más oscuro
- DIGNIDAD tiende a bajar

TEXTO INTERNO EJEMPLO:
"¿Por qué te levantás? Porque todavía te levantás.
No hay razón. Solo costumbre."
```

**TRAUMA >= 9 (Quiebre inminente)**
```
EFECTOS:
- Dados máximos: 3 (no podés tener más)
- Opciones extremadamente limitadas
- Texto interno fragmentado
- FINAL ESPECIAL desbloqueado

FINAL ESPECIAL:
"Quiebre" - No podés seguir.
El juego termina con dignidad: "Hay límites."
No hay juicio. Solo reconocimiento.
```

---

## 2. SISTEMA DE IDEAS (GABINETE DEL PENSAMIENTO)

Las IDEAS no son power-ups. Son pensamientos que internalizás y cambian cómo ves todo. Tienen costo y efecto permanente.

### 2.1 Tipos de Ideas

#### IDEAS ELEGIDAS
Las encontrás durante el juego. Decidís si internalizarlas.

#### IDEAS INVOLUNTARIAS
Aparecen por TRAUMA alto o eventos. No las elegís.

#### IDEAS HEREDADAS
Vienen de NPCs específicos. Requieren CONEXION con ellos.

#### IDEAS INCOMODAS
Duelen pero desbloquean opciones. Cuestan DIGNIDAD o TRAUMA.

---

### 2.2 Ideas del Prototipo

#### IDEA 1: "Todo cae junto"
```
TIPO: Involuntaria
APARECE: MIERCOLES, después del despido
CONDICION: Automática

COSTO DE INTERNALIZACION:
- No hay costo: se internaliza sola
- Representa: el golpe del despido

EFECTO PERMANENTE:
- Las crisis personales y colectivas se muestran conectadas
- Cuando algo malo pasa en la olla, tu texto interno dice:
  "Claro. Todo cae junto."
- Desbloquea: ver la olla no como "caridad" sino como "lo mismo"

TEXTO DE INTERNALIZACION:
"El laburo que te ordenaba la vida. La olla que ordena el barrio.
Tu rutina. La rutina de ellos.
No son cosas separadas que caen por separado.
Todo se reorganiza junto. O nada se reorganiza."
```

#### IDEA 2: "No tengo nada, pero tengo tiempo"
```
TIPO: Elegida
APARECE: JUEVES, en la olla
CONDICION: Estar en la olla pudiendo aportar algo

COSTO DE INTERNALIZACION:
- 1 ENERGIA
- 0 TRAUMA (puede ser liberadora)

EFECTO PERMANENTE:
- Opciones de "ayudar con tiempo" cuestan 1 dado menos
- "Estar" cuenta como acción (no solo hacer)
- CONEXION +1 por día que simplemente estés presente

TEXTO DE INTERNALIZACION:
"No tenés laburo. No tenés rutina. No tenés lugar.
Pero tenés tiempo. Eso que antes no tenías.
Y el tiempo, puesto acá, hace algo.
Antes no podías venir. Ahora podés."
```

#### IDEA 3: "Pedir ayuda no es debilidad"
```
TIPO: Elegida
APARECE: VIERNES, si DIGNIDAD >= 4 y alguien te ofrece acompañamiento
CONDICION: Aceptar que te acompañen

COSTO DE INTERNALIZACION:
- 2 ENERGIA (cuesta admitirlo)
- DIGNIDAD +1 (paradójicamente)

EFECTO PERMANENTE:
- Pedir acompañamiento cuesta 0 dados (era 1)
- Aceptar que te banquen da CONEXION +1 (automático)
- Desbloquea opción: "Contarle a alguien cómo te sentís"

TEXTO DE INTERNALIZACION:
"Toda tu vida te dijeron que pedir es de débil.
Que aguantar solo es de fuerte. Mentira.
No es pedir comida. Es pedir que te escuchen.
Que te pasen un contacto. Que te digan que no estás loco.
Eso no es debilidad. Eso es lo único que hay."
```

#### IDEA 4: "La red o la nada"
```
TIPO: Heredada (Elena)
APARECE: Fragmento de Elena + conversación profunda con ella
CONDICION: CONEXION con Elena >= 6, LA LLAMA >= 4

COSTO DE INTERNALIZACION:
- 2 ENERGIA
- 1 TRAUMA (la lucidez duele)

EFECTO PERMANENTE:
- Opciones colectivas siempre visibles (aunque cuesten mucho)
- ACUMULACION sube más lento (-1 a cualquier aumento)
- Podés ver cuando otros están solos (nuevo texto)

TEXTO DE INTERNALIZACION:
"Elena te lo dijo sin decirlo.
Lo que tienen es la red. Lo que tienen es que se tienen.
No es que la olla te salve el hambre.
Es que la olla te salva de estar solo.
El día que la red se rompa, cada uno en su casa.
Y en tu casa, solo, te comés la cabeza.
La red o la nada."
```

#### IDEA 5: "Esto es lo que hay"
```
TIPO: Involuntaria
APARECE: Automáticamente si TRAUMA >= 5
CONDICION: No se elige, se impone

COSTO DE INTERNALIZACION:
- Se internaliza sola
- DIGNIDAD -1 al internalizarse

EFECTO PERMANENTE:
- Opciones de esperanza cuestan +1 dado
- Opciones de resignación cuestan 0 dados
- Texto interno tiene tono de "ya sé cómo termina esto"
- PUEDE coexistir con ideas esperanzadoras (conflicto interno)

TEXTO DE INTERNALIZACION:
"Esto es lo que hay.
No vas a conseguir laburo de lo tuyo.
Vas a terminar aceptando cualquier cosa.
Siempre es así. Siempre."

CONTRADICCION MECANICA:
Si tenés "La red o la nada" Y "Esto es lo que hay":
- Las dos aparecen en el texto interno, en tensión
- "Esto es lo que hay. Pero... la red. Pero... para qué."
- Abre opciones especiales de lucidez amarga
```

#### IDEA 6: "Nadie debería agradecer lo que es un derecho"
```
TIPO: Elegida
APARECE: En la olla, cuando alguien agradece demasiado
CONDICION: Ver a alguien agradecer con vergüenza

COSTO DE INTERNALIZACION:
- 1 ENERGIA
- DIGNIDAD +2 (es rabia justa)

EFECTO PERMANENTE:
- Cuando alguien te agradece: "No me agradezcas" disponible
- Texto interno politizado: "Esto no es caridad. Es lo mínimo."
- Opciones de confrontar la lógica de la caridad disponibles
- LA LLAMA +1 permanente (mientras la tengas)

TEXTO DE INTERNALIZACION:
"Te dijo 'gracias' y le dolió decirlo.
Gracias por la comida. Gracias por el espacio.
Nadie debería agradecer eso.
Comer no es un favor. Tener dónde estar no es regalo.
La vergüenza de agradecer lo mínimo.
Esa vergüenza es política."
```

---

### 2.3 Mecánica de Internalización

#### Cuándo aparecen las Ideas

Las IDEAS aparecen en momentos específicos, marcadas en el texto:

```
[Aparece una idea flotando en tu mente]

"No tengo nada, pero tengo tiempo"

[INTERNALIZAR] - Cuesta 1 ENERGIA
[DEJAR PASAR] - Se va pero puede volver
```

#### Proceso de Internalización

1. **Aparece la idea** (texto + contexto)
2. **Ves el costo** (ENERGIA, TRAUMA, DIGNIDAD)
3. **Decidís** (Internalizar o Dejar Pasar)
4. **Si internalizás:**
   - Se paga el costo
   - Texto de internalización aparece
   - Efecto permanente activo
5. **Si dejás pasar:**
   - Puede volver más tarde
   - Algunas ideas no vuelven

#### Ideas que Vuelven vs Ideas que se Van

| Idea | ¿Vuelve? | Notas |
|------|----------|-------|
| "Todo cae junto" | No vuelve | Involuntaria, única |
| "No tengo nada, pero tengo tiempo" | Vuelve 1 vez | Si la dejás pasar en la olla |
| "Pedir ayuda no es debilidad" | Vuelve cada vez que te ofrecen acompañamiento | Pero el costo sube +1 cada vez |
| "La red o la nada" | No vuelve | Requiere momento específico con Elena |
| "Esto es lo que hay" | No se puede rechazar | Involuntaria |
| "Nadie debería agradecer..." | Vuelve 1 vez | Si volvés a ver la escena |

---

## 3. SISTEMA DE FRAGMENTOS

Los FRAGMENTOS son ventanas a la vida de otros. No controlás nada. Solo ves. Te muestran gente que también está en sus luchas. No te muestran "pobrecito el protagonista": te muestran comunidad, no caridad.

### 3.1 Cómo Funcionan

Cada noche, entre días, ves UN fragmento:

```
[NOCHE DEL MIERCOLES]

La pantalla se oscurece. No es tu historia ahora.

---

FRAGMENTO: Sofía

[Descripción de lo que Sofía hace/piensa]

---

[AMANECER DEL JUEVES]
```

### 3.2 Qué Fragmento Aparece

El fragmento depende de:

1. **Tus decisiones del día**
   - Si ayudaste en la olla → más probable Sofía
   - Si hablaste con Diego → más probable Diego
   - Si no apareciste → más probable Elena (pensando en el grupo)

2. **Estado de LA LLAMA**
   - LA LLAMA alta → fragmentos más cálidos
   - LA LLAMA baja → fragmentos más grises

3. **Rotación**
   - No repetís NPC dos noches seguidas
   - Prioridad a NPCs con arco activo

### 3.3 Fragmentos por NPC

#### SOFIA - Fragmentos

**Fragmento A: Contando números (LA LLAMA < 4)**
```
SOFIA

La mesa de la cocina. Los pibes duermen.
Sofía hace cuentas. Las donaciones. Los gastos. Las porciones.

Doscientos pesos más. Trescientos menos.
No da. Nunca da exacto.

Vuelve a hacer las cuentas.

Doscientos. Trescientos.
Como si contar cambiara algo.
Como si los números escucharan.
```

**Fragmento B: Pensando en cerrar (LA LLAMA < 3)**
```
SOFIA

La olla grande, vacía. Sofía la mira.

Podría no abrir mañana.
Podría decir que se enfermó.
Podría quedarse en la cama y que el mundo siga.

Pero hay gente que cuenta con esto.
Y Diego que viene aunque no sepa cocinar.
Y [jugador] que ahora tiene tiempo y aparece.

Mañana abre.
Porque qué otra cosa va a hacer.
```

**Fragmento C: Después de un buen día (LA LLAMA >= 5)**
```
SOFIA

Los pibes comen. Sofía come con ellos.

—¿Hoy estuvo buena la olla, ma?
—Hoy sí. Hoy sí estuvo buena.

No dice que llegó donación.
No dice que Elena trajo verdura.
No dice que [jugador] ayudó a servir.

Solo: "Hoy estuvo buena."
Y es suficiente.
```

---

#### ELENA - Fragmentos

**Fragmento A: Sin dormir (LA LLAMA < 4)**
```
ELENA

Las tres de la mañana. Elena no duerme.

Mira fotos que no muestra. Nombres que no dice.
El Flaco. La Negra. El Toto.
Todos se fueron. De distintas maneras.
Algunos con nombre en una lista. Otros de cansancio.

¿Para qué guardó todo esto?
¿Para contarle a quién?

La Llama que ellos prendieron.
La Llama que ella vio apagarse tantas veces.
La Llama que...

Se levanta. Pone la pava.
Hay que llegar a mañana.
```

**Fragmento B: Semilla (LA LLAMA >= 4)**
```
ELENA

El frasco de semillas. Elena las cuenta. Las ordena.

Tomate. Zapallo. Lechuga. Perejil.
Semillas guardadas de plantas que dieron fruto.
Que dieron fruto de semillas que ella guardó.
De plantas que...

La línea no se corta.
Aunque todo se rompa, la línea no se corta.

Mañana le lleva semillas a Sofía para la huerta.
No es mucho. Es algo.
```

---

#### DIEGO - Fragmentos

**Fragmento A: Solo (LA LLAMA < 4 o CONEXION baja)**
```
DIEGO

La pieza. Una cama. Una mesa. Una silla.
Diego mira el techo.

Podría volver al pueblo. No hay nada pero hay familia.
Podría quedarse acá. No hay nada pero...
¿Pero qué?

El barrio. Que no es suyo. Pero podría ser.
La olla. Donde lo dejan ayudar aunque no sepa cocinar.
[Jugador]. Que también anda medio perdido. Que también busca.

Mañana ve. Siempre mañana ve.
```

**Fragmento B: Dudando irse (LA LLAMA < 3 por 2+ días)**
```
DIEGO

El celular. El pasaje de vuelta.
Montevideo - Tacuarembó. $1.800.

Lo mira. Cierra. Lo abre.

Mamá pregunta cuándo vuelve.
Dice "pronto" pero no sabe qué significa pronto.
Dice "estoy bien" pero no sabe qué significa bien.

Si la olla cierra, se va.
Si [jugador] desaparece, se va.
Si una cosa más falla, se va.

Pero todavía no falla.
Todavía.
```

**Fragmento C: Perteneciendo (CONEXION jugador >= 7 con Diego)**
```
DIEGO

Mensaje de mamá: "¿cuándo venís?"

Diego escribe: "Ma, creo que me quedo un poco más."

Borra.

Escribe: "Acá hay gente."

Borra.

Escribe: "Estoy bien. Hablamos mañana."

Envía.

No es mentira. Hoy no es mentira.
```

---

#### MARCOS - Fragmentos

**Fragmento A: Desde afuera (Estado normal)**
```
MARCOS

La ventana. La calle. La olla a una cuadra.

Marcos podría caminar hasta allá. Saludar. Quedarse.
Lo hizo mil veces antes. Antes.

Ahora mira. Solo mira.
Sofía sirviendo. Diego cargando. [Jugador] ahí.
Elena en la puerta, mirando para todos lados.
Como esperando a alguien.

No te espera a vos, pelotudo.
Dejaste de ir hace dos años.
Ya no te esperan.

Cierra la ventana.
```

**Fragmento B: Algo se mueve (LA LLAMA >= 5)**
```
MARCOS

Mensaje de Elena: "Mañana asamblea. Por la olla."

Marcos mira el mensaje.
No responde.
No borra.

Lo deja ahí. En visto.

Mañana ve.
(Pero algo se movió. Algo.)
```

---

#### YULIMAR - Fragmentos

**Fragmento A: Calculando (Estado normal)**
```
YULIMAR

WhatsApp abierto. La foto de los niños.
Yulimar calcula.

Lo del puesto: 400 dólares este mes. Menos que el anterior.
Alquiler: 200. Comida: 100. Transporte: 50.
Quedan 50.

50 dólares para mandar.
El mes pasado mandó 100.
El mes pasado comió menos.

Escribe: "Mi amor, este mes está difícil."
Borra.
Escribe: "Van 50, mi cielo. El mes que viene mando más."
Envía.

No va a mandar más.
Pero tiene que decirlo.
```

**Fragmento B: Escuchando (Si hubo comentario xenófobo en el día)**
```
YULIMAR

La olla. Yulimar sirve. Escucha.

"—Estos venecos vienen a sacarnos el laburo."

No lo dijeron a ella. Lo dijeron cerca.
Como si ella no estuviera. Como si no contara.

Podría decir algo. Ha dicho algo antes.
A veces funciona. A veces empeora.

Hoy no tiene fuerza.
Hoy sigue sirviendo.

[Si jugador intervino:]
"Pero [jugador] dijo algo. No sé si cambió algo.
Pero dijo algo."
```

---

## 4. SISTEMA DE DECISIONES (NO BINARIO)

Las decisiones en LA LLAMA no son "A o B". Son "cuánto de cada cosa". Los costos de ENERGIA son sobre tiempo y capacidad emocional, no sobre supervivencia.

### 4.1 Estructura de una Situación

```
╔══════════════════════════════════════════════════════════════════╗
║  SITUACION: Es jueves. Tenés 4 dados.                            ║
║                                                                   ║
║  La olla necesita ayuda. Pero también querés buscar laburo.      ║
║  Y Diego te pidió que lo acompañes al trámite.                   ║
╠══════════════════════════════════════════════════════════════════╣
║                                                                   ║
║  [A] AYUDAR EN LA OLLA                                           ║
║      Mínimo: 1 dado | Recomendado: 2 dados | Máximo: 3 dados     ║
║      1 dado = Ayudás pero poco. Sofía nota que estás ausente.   ║
║      2 dados = Ayuda real. Sofía puede descansar un rato.       ║
║      3 dados = Te quedás toda la mañana. CONEXION +1.           ║
║                                                                   ║
║  [B] BUSCAR LABURO                                               ║
║      Mínimo: 1 dado | Recomendado: 2 dados | Máximo: 4 dados     ║
║      1 dado = Mandás CVs online. Probablemente nada.             ║
║      2 dados = Vas a un lugar que viste. Puede salir algo.       ║
║      3 dados = Recorrés varias opciones. Mejor chance.           ║
║      4 dados = Todo el día en eso. Agotador pero productivo.     ║
║                                                                   ║
║  [C] ACOMPANAR A DIEGO                                           ║
║      Costo fijo: 2 dados                                          ║
║      Diego no puede hacer el trámite solo. No es opcional.       ║
║      Si vas: CONEXION con Diego +2. Diego no se va.              ║
║      Si no vas: Diego solo. Puede salir mal.                     ║
║                                                                   ║
║  [D] NO HACER NADA                                               ║
║      0 dados. Pero no es gratis.                                  ║
║      Te quedás en casa mirando el techo.                         ║
║      TRAUMA +1 por sentir que no servís para nada.               ║
║                                                                   ║
╠══════════════════════════════════════════════════════════════════╣
║  Tenés 4 dados. ¿Cómo los repartís?                               ║
║                                                                   ║
║  Ejemplo: [A:1] [B:1] [C:2] = 4 dados                             ║
║  Ejemplo: [A:0] [B:2] [C:2] = 4 dados                             ║
║  Ejemplo: [A:2] [B:2] [C:0] = 4 dados (Diego solo)                ║
╚══════════════════════════════════════════════════════════════════╝
```

### 4.2 Tipos de Costos

#### Costo Mínimo
Lo mínimo para intentar algo. Resultado parcial.

#### Costo Recomendado
Donde la acción tiene el resultado esperado.

#### Costo Máximo
Inversión total. Resultados excepcionales.

#### Costo Fijo
Algunas acciones no escalan. Es todo o nada.

### 4.3 Modificadores

Las decisiones se modifican por estado del jugador:

#### Por IDEAS Internalizadas

| Idea | Efecto en decisiones |
|------|---------------------|
| "No tengo nada pero tengo tiempo" | Opciones de "estar" cuestan 1 menos |
| "Pedir ayuda no es debilidad" | [PEDIR ACOMPAÑAMIENTO] siempre disponible, cuesta 0 |
| "La red o la nada" | Opciones colectivas cuestan 1 menos |
| "Esto es lo que hay" | Opciones pesimistas cuestan 0 |
| "Nadie debería agradecer..." | Opciones de confrontar sistema disponibles |

#### Por CONEXION

| Nivel | Efecto |
|-------|--------|
| CONEXION >= 7 | Podés pedir 1 dado prestado (alguien te banca) |
| CONEXION >= 8 | Opciones colectivas cuestan 1 menos |
| CONEXION <= 3 | Opciones colectivas cuestan 1 más |
| CONEXION <= 2 | Algunas opciones colectivas no aparecen |

#### Por DIGNIDAD

| Nivel | Efecto |
|-------|--------|
| DIGNIDAD >= 7 | Opciones de confrontación disponibles |
| DIGNIDAD <= 3 | Algunas opciones bloqueadas ("¿Para qué?") |
| DIGNIDAD <= 2 | Opciones que requieren iniciativa cuestan +1 |

#### Por LA LLAMA

| Nivel | Efecto |
|-------|--------|
| LA LLAMA >= 6 | Opciones colectivas más efectivas (+1 resultado) |
| LA LLAMA <= 2 | Opciones esperanzadas cuestan +1 |
| LA LLAMA = 0 | Opciones colectivas desaparecen |

---

### 4.4 Ejemplo Completo del Prototipo

```
╔══════════════════════════════════════════════════════════════════╗
║  VIERNES - LA ASAMBLEA                                           ║
║                                                                   ║
║  Es hoy. La asamblea para decidir qué hacer con la olla.         ║
║  Sofía dice que no da más. Elena dice que hay que seguir.        ║
║  Walter ofreció "ayudar" si le dejan poner su nombre.            ║
║                                                                   ║
║  Tenés 3 dados.                                                   ║
╠══════════════════════════════════════════════════════════════════╣
║                                                                   ║
║  [A] HABLAR EN LA ASAMBLEA                                       ║
║      Mínimo: 2 dados | Máximo: 3 dados                            ║
║      2 dados = Decís lo que pensás. Te escuchan.                 ║
║      3 dados = Hablás y proponés algo. LA LLAMA +1 si sale bien. ║
║      REQUIERE: DIGNIDAD >= 4                                      ║
║      BLOQUEADO si: DIGNIDAD <= 3 ("¿Para qué? No te van a...") ║
║                                                                   ║
║  [B] APOYAR A SOFIA                                              ║
║      Costo: 1 dado                                                ║
║      No hablás, pero estás ahí. Sofía sabe que no está sola.     ║
║      Si Sofía habla y vos apoyás: CONEXION +1, ella +1 DIGNIDAD  ║
║                                                                   ║
║  [C] CONFRONTAR A WALTER                                         ║
║      Costo: 2 dados | REQUIERE: DIGNIDAD >= 5                     ║
║      Decís lo que Walter es. Lo que representa.                  ║
║      RIESGO: Si LA LLAMA < 4, puede salir mal.                   ║
║      EXITO: Walter pierde credibilidad. LA LLAMA +1.             ║
║      FALLO: Parecés el problemático. CONEXION -1.                ║
║                                                                   ║
║  [D] QUEDARTE CALLADO                                            ║
║      0 dados.                                                      ║
║      Mirás. Escuchás. Nadie te pide nada.                        ║
║      TRAUMA +1 si la asamblea sale mal.                          ║
║      ("Podrías haber dicho algo.")                               ║
║                                                                   ║
║  [E] NO IR                                                        ║
║      0 dados. Pero cuesta.                                        ║
║      CONEXION -2. LA LLAMA -1.                                    ║
║      "No estuviste cuando importaba."                            ║
║                                                                   ║
╠══════════════════════════════════════════════════════════════════╣
║  MODIFICADORES ACTIVOS:                                           ║
║  - DIGNIDAD: 6 (todas las opciones disponibles)                  ║
║  - Tenés "La red o la nada": [A] cuesta 1 menos = 1-2 dados      ║
║  - CONEXION: 7 (Podés pedir dado prestado a Elena)               ║
║                                                                   ║
║  ¿Qué hacés?                                                      ║
╚══════════════════════════════════════════════════════════════════╝
```

---

## 5. SISTEMA DE FINALES

El prototipo tiene múltiples finales basados en el estado de las variables. No hay "bueno" o "malo": hay estados diferentes.

### 5.1 Variables que Determinan el Final

| Variable | Peso | Notas |
|----------|------|-------|
| LA LLAMA | Alto | Estado colectivo, fundamental |
| CONEXION | Alto | Tu lugar en el barrio |
| ACUMULACION | Medio | Si "volviste a la normalidad" pero perdiste |
| TRAUMA | Medio | Si llegaste al quiebre |
| Estado de la olla | Alto | Abierta/cerrada/transformada |
| Diego | Medio | Se fue/se quedó |
| Sofía | Alto | Sigue/se quebró/descansa |
| Elena | Medio | Sigue/cayó/transmitió algo |
| Marcos | Bajo | Volvió/no volvió |

### 5.2 Matriz de Finales

#### FINAL: "La olla sigue" (Colectivo alto)

```
CONDICIONES:
- LA LLAMA >= 5
- La olla abierta
- ACUMULACION <= 4
- Sofía no quebrada

TEXTO:
"Es domingo. La olla abre como siempre.
No conseguiste laburo. Pero no perdiste todo.
La indemnización te banca un par de meses más.

Elena pasa y te saluda.
Sofía tiene ojeras pero sonríe.
Diego se quedó.

Tenés dónde estar. Tenés a quién ver.
La semana que viene seguís buscando laburo.
Pero no solo."

ESTADO FINAL:
- LA LLAMA mostrada
- CONEXION mostrada
- Texto sobre el futuro: incierto pero acompañado
```

#### FINAL: "Volviste a la normalidad" (Acumulación alta)

```
CONDICIONES:
- ACUMULACION >= 8
- Aceptaste oferta de Walter

TEXTO:
"Es domingo. Tenés laburo.
Es el laburo de Walter. Está bien pago.
Empezás el lunes. Horarios normales. Sueldo normal.

La olla sigue o cerró. No te enteraste.
Diego se fue o se quedó. No lo viste.
Elena... no te mira cuando pasás.

Tenés laburo. Tenés rutina. Tenés normalidad.
Tenés todo lo que querías recuperar.
¿Por qué se siente así?"

ESTADO FINAL:
- Recursos altos
- CONEXION: 2
- Texto sobre el futuro: seguro pero vacío
```

#### FINAL: "El quiebre" (Trauma extremo)

```
CONDICIONES:
- TRAUMA >= 9

TEXTO:
"Es domingo. Pero no importa qué día es.

No podés más. No es metáfora.
La cabeza no para. El cuerpo no responde.
Todo lo que acumulaste —los rechazos, las entrevistas,
el sentir que no servís para nada— tiene un límite.

No es el final de la historia.
Es el final de lo que podés contar.
Hay cosas que no se narran. Solo se viven.

Y vos necesitás parar."

ESTADO FINAL:
- No hay stats
- Texto sobre el futuro: silencio
- Nota: "Esto pasa. No es debilidad."
```

#### FINAL: "La llama se apagó" (Colectivo destruido)

```
CONDICIONES:
- LA LLAMA <= 1
- La olla cerrada

TEXTO:
"Es domingo. La olla no abrió.

Sofía no pudo más. Diego se fue.
Elena no sale del cuarto.
El local está cerrado.
Nadie sabe si abre mañana.

Vos seguís acá.
Con tu indemnización que se acaba.
Con tu búsqueda de laburo que no avanza.
Pero ahora sin la olla. Sin el lugar.

Hay brasas. Puede que prendan. Puede que no.
El lunes es un día más."

ESTADO FINAL:
- LA LLAMA: 0-1
- Todo gris
- Texto sobre el futuro: solo
```

#### FINAL: "Algo nuevo" (Transformación)

```
CONDICIONES:
- LA LLAMA >= 6
- Asamblea resolvió cambiar algo
- CONEXION >= 6
- Marcos volvió

TEXTO:
"Es domingo. Pero no es un domingo cualquiera.

La olla sigue. Pero cambiamos algo.
No es solo dar de comer. Es otra cosa.
Elena habló de huerta. Sofía habló de turnos.
Marcos apareció. Después de dos años.

Seguís sin laburo. La indemnización se acaba.
Pero por primera vez en mucho tiempo,
no sé qué va a pasar
y eso no me da miedo.

Hay algo acá. Hay algo."

ESTADO FINAL:
- LA LLAMA alta
- CONEXION alta
- Texto sobre el futuro: incierto pero vivo
```

#### FINAL: "Diego se fue" (Pérdida específica)

```
CONDICIONES:
- Diego decidió irse (CONEXION con él < 4 O LA LLAMA <= 2)

TEXTO:
"Es domingo. Diego no está.

Se fue el viernes. O el sábado. No lo viste.
Un mensaje: 'Gracias por todo. No pude.'

Podés entender. Volver al pueblo tiene sentido.
Quedarse acá es difícil. Buscar laburo es difícil.
Todo es difícil.

Pero duele igual.
Alguien que podría haber pertenecido.
Que no perteneció.

La olla sigue. La silla de Diego vacía."

ESTADO FINAL:
- Stats normales pero
- Pérdida marcada
- LA LLAMA -1 permanente (en la ficción)
```

#### FINAL: "Ni victoria ni derrota" (Sin resolución)

```
CONDICIONES:
- LA LLAMA 3-5 (sin cambio significativo)
- CONEXION 4-6 (sin cambio significativo)
- Nada definitivo pasó

TEXTO:
"Es domingo. Como cualquier domingo.

La olla abrió. Seguís sin laburo pero tenés para un par de meses.
Elena está. Sofía está cansada pero está.
Diego duda pero todavía está.

Nada cambió definitivamente.
Nada se rompió definitivamente.

El lunes viene.
Y el martes. Y el miércoles.
La semana se repite.
La búsqueda sigue. La cuenta regresiva sigue.
El barrio sigue."

ESTADO FINAL:
- Todo en el medio
- Texto sobre el futuro: continuidad incierta
```

---

### 5.3 Combinaciones Especiales

| Combinación | Final resultante |
|-------------|------------------|
| LA LLAMA alta + ACUMULACION alta | "Ellos ganaron, vos te fuiste" |
| LA LLAMA baja + ACUMULACION baja | "Perdieron todos" |
| TRAUMA alto + CONEXION alta | "Te bancaron pero no alcanzó" |
| Sofía quebrada + Olla abierta | "Alguien tomó la posta" |
| Elena cayó | Cualquier final tiene nota sobre "lo que se perdió" |

---

## NOTAS DE IMPLEMENTACION

### Sobre el Balance

- Los números son tentativos. Requieren playtesting.
- El objetivo no es dificultad sino tensión moral.
- Siempre tiene que haber opciones, aunque sean malas.

### Sobre el Tono

- Nunca juzgar al jugador.
- Mostrar consecuencias, no moralizar.
- No es This War of Mine (supervivencia). Es más como Disco Elysium (crisis existencial/identitaria).
- El protagonista tiene techo y comida. Su crisis es futura, no presente.
- La amenaza no es la indigencia personal. La amenaza es el aislamiento.

### Sobre la Esperanza

- La esperanza existe pero cuesta.
- No es gratis, no es ingenua.
- Es elegir pertenecer cuando podrías aislarte.

### Sobre la Olla

- La olla no le da comida al protagonista.
- La olla le da propósito, pertenencia, un lugar donde estar.
- La conexión es "puedo aportar algo" no "necesito que me salven".

---

*Documento técnico del prototipo "Cuando Todo Cae" para LA LLAMA.*
*Actualizar según avance el desarrollo.*
