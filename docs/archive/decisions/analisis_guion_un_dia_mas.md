# ANÁLISIS CRÍTICO: "UN DÍA MÁS"
## Informe sobre construcción narrativa, marcos teóricos y recomendaciones de diseño

**Fecha:** 28 de enero de 2026  
**Preparado para:** Equipo de desarrollo "Un Día Más"  
**Analista:** V. (Knowmad Institut)

---

## RESUMEN EJECUTIVO

"Un Día Más" demuestra una comprensión sólida de la fenomenología de la precarización laboral y logra representar materialmente las condiciones de agotamiento bajo el capitalismo tardío. Sin embargo, presenta limitaciones teóricas importantes que reproducen, involuntariamente, algunas de las estructuras que busca criticar: la psicologización de lo político, la ausencia de análisis estructural explícito, y la restricción del horizonte de lo posible a formas reformistas de organización.

Este informe proporciona análisis crítico fundamentado en teoría crítica contemporánea, estudios decoloniales, pensamiento anarquista y feminismos del Sur Global, con el objetivo de fortalecer la dimensión política del juego sin sacrificar su honestidad afectiva.

---

## I. MARCO TEÓRICO DE REFERENCIA

### 1.1 Realismo Capitalista y Privatización del Sufrimiento

Mark Fisher (2009) en *Capitalist Realism: Is There No Alternative?* argumenta que el realismo capitalista opera mediante dos mecanismos centrales:

> "El realismo capitalista no se limita a afirmar que 'no hay alternativa' - también presupone que cualquier fracaso es individual. El sistema nunca falla; solo pueden fallar los individuos dentro del sistema" (p. 16, traducción propia).

**PROBLEMA IDENTIFICADO EN EL GUION:**

El sistema de "salud_mental" como stat individualiza lo que Fisher identifica como una crisis estructural. La depresión y el agotamiento no son patologías individuales sino síntomas de condiciones materiales específicas. Como señala Fisher:

> "En lugar de plantear la pregunta '¿Por qué tantos individuos sufren de enfermedad mental?', deberíamos preguntar '¿Qué tipo de sociedad produce estos niveles de angustia?'" (p. 19, traducción propia).

**RECOMENDACIÓN:**
- Renombrar el stat a `peso_estructural`, `agotamiento_sistémico` o similar
- Agregar diálogos que expliciten la dimensión política del sufrimiento
- Incluir momentos donde personajes rechazan activamente la narrativa de "responsabilidad individual"

**EJEMPLO DE IMPLEMENTACIÓN:**

```
ASAMBLEA_REFLEXION:
Diego: "Yo pensaba que era yo. Que no servía para nada."
Sofía: "No. Así te hacen pensar. Para que no veas el problema real."
Elena: "El problema es que te explotan y te pagan una miseria."
Ixchel: "Y después te dicen que te 'cuides'. Que hagas yoga."
[Idea desbloqueada: "El sistema me enferma, no soy yo quien falla"]
```

### 1.2 Educación como Práctica de la Libertad

Paulo Freire en *Pedagogía del Oprimido* (1970) distingue entre:

**a) Conciencia mágica:** Los problemas se atribuyen a causas externas, fuerzas superiores, destino  
**b) Conciencia ingenua:** Se reconocen problemas pero sin análisis estructural  
**c) Conciencia crítica:** Se comprenden las causas estructurales y se busca transformación

Freire es explícito sobre el proceso:

> "Nadie se libera solo: los hombres se liberan en comunión. [...] No hay diálogo si no hay una intensa fe en los hombres. Fe en su poder de hacer y rehacer. De crear y recrear" (p. 105).

**PROBLEMA IDENTIFICADO:**

El juego presenta el proceso de politización (stat "llama") como acumulativo y lineal, cuando Freire insiste en que la concienciación es dialógica, contradictoria y colectiva. No es una "barra" que sube sino un proceso de transformación cualitativa.

**RECOMENDACIÓN:**

Sustituir el sistema de "llama" por un **sistema de ideas desbloqueadas** que representan momentos cualitativos de ruptura cognitiva:

```
IDEAS_POLITICAS = {
  "no_es_individual": "No es solo mi problema",
  "sistema_tiene_nombre": "Esto se llama explotación",
  "colectivo_posible": "Solos no podemos, juntos sí",
  "autonomia_real": "Podemos organizarnos sin jefes",
  "sabotaje_legitimo": "A veces hay que romper para construir",
  "estado_no_neutro": "El Estado no es árbitro, defiende intereses",
  "prefiguracion": "El mundo nuevo se construye en el viejo"
}
```

Cada idea se desbloquea mediante experiencias específicas (no por acumulación de puntos) y abre nuevas opciones de diálogo y acción.

### 1.3 Interseccionalidad y Ch'ixi

Silvia Rivera Cusicanqui desarrolla el concepto andino de *ch'ixi* para pensar identidades que no son síntesis ni mestizaje, sino coexistencia conflictiva:

> "Lo ch'ixi es esa mezcla abigarrada, ese claroscuro donde coexisten los opuestos sin anularse. [...] No es la hibridez ni el mestizaje. Es la coexistencia en paralelo de múltiples diferencias culturales que no se funden sino que se antagonizan o complementan" (2010, *Ch'ixinakax utxiwa*).

Rita Segato (2018) complementa:

> "La raza y el género son campos de disputa, y no pueden ser tratados como agregados. La experiencia de una mujer negra no es la suma de 'mujer' + 'negra', es una experiencia específica, con su propia historia de opresión y resistencia" (*Contra-pedagogías de la crueldad*, p. 42).

**PROBLEMA IDENTIFICADO:**

El personaje jugador está implícitamente universalizado como mestizo, masculino, clase trabajadora urbana. Esto invisibiliza cómo raza, género y clase operan de manera interseccional en la precarización.

**RECOMENDACIÓN:**

1. **Elección de posición social en creación de personaje:**
   - Género (varón cis, mujer cis, persona trans/no binaria)
   - Racialización (blanco, mestizo, afrodescendiente, indígena)
   - Esto NO es cosmético sino que afecta experiencias concretas

2. **Escenas diferenciadas según posición:**

```
BONDI_ACOSO:
{genero == "mujer" || genero == "trans":
Un tipo te mira de más en el bondi.
Se acerca demasiado.
Sabés ese miedo.
- OPCIÓN: Moverte a otro lugar
- OPCIÓN: Quedarte plantada, sostenele la mirada
- OPCIÓN: {energia >= 2} [Gritarle] # COSTO:1 # EFECTO:dignidad+
}

POLICIA_CALLE:
{raza == "afrodescendiente":
La policía te para.
"¿Adónde vas?"
Ya conocés la rutina.
Documento. Preguntas. Sospecha.
- OPCIÓN: Mostrar documento tranquilo
- OPCIÓN: {llama >= 3} [Preguntar por qué te paran]
}
```

### 1.4 Economías del Deseo y Pedagogías de la Crueldad

Rita Segato distingue entre:

**Economías del capital:** Acumulación, competencia, extracción  
**Economías del deseo:** Reciprocidad, cuidado, reproducción de la vida

En *Contra-pedagogías de la crueldad* (2018):

> "Las pedagogías de la crueldad son todos los actos y prácticas que enseñan, habitúan y programan a los sujetos a transmutar lo vivo y su vitalidad en cosas. [...] En el mundo de hoy, la pedagogía de la crueldad es la que forma sujetos capaces de soportar el sufrimiento del otro sin inmutarse" (p. 11).

**LO QUE EL JUEGO HACE BIEN:**

Las escenas de la olla popular capturan esta dimensión:
- Pelar papas (trabajo concreto)
- Servir comida (cuidado directo)
- Preparar verduras (labor que sostiene vida)

**RECOMENDACIÓN DE PROFUNDIZACIÓN:**

Explicitar el contraste entre ambas economías. Ejemplo:

```
OLLA_REFLEXION:
Ixchel está cortando cebolla. Lágrimas por el ardor.
"En mi comunidad, cada familia daba lo que podía.
No era caridad. Era reciprocidad.
Ayni le dicen. Yo te ayudo, vos me ayudás.
Acá le dicen 'economía solidaria'
como si fuera algo nuevo que inventaron los académicos."

[Si participaste >= 3 veces:]
Sofía agrega: "Lo que hacemos acá no es dar de comer.
Es construir otra forma de vivir.
Donde la comida no se compra. Se comparte."
```

### 1.5 Autonomía y Prefiguración Anarquista

Piotr Kropotkin en *El Apoyo Mutuo* (1902):

> "En la práctica de la ayuda mutua, que podemos rastrear hasta los orígenes más remotos de la evolución, encontramos el origen positivo e innegable de nuestras concepciones éticas" (Introducción).

Gustav Landauer diferencia entre:
- **Revolución destructiva:** Destruir el Estado
- **Revolución constructiva:** Construir nuevas formas de vida *dentro* del viejo mundo

Contemporáneamente, esto se expresa en el concepto de **prefiguración**: las formas de organización política deben anticipar el mundo que se quiere construir.

**PROBLEMA IDENTIFICADO:**

Incluso el "final de lucha colectiva" es reformista. No aparecen opciones de:
- Huelga salvaje (sin sindicato)
- Ocupación de espacios
- Autogestión productiva
- Deserción/sabotaje

**RECOMENDACIÓN:**

Agregar finales que exploren la autonomía radical:

```
FINAL_AUTONOMIA:
La asamblea decidió.
No van a pedir permiso.
La fábrica cerrada está ahí, vacía.
Mañana empiezan a producir por su cuenta.

"¿Y si viene la policía?"
"Vendrá. Pero mientras tanto, producimos."

No es el mundo nuevo.
Es una grieta en el viejo.
Por donde entra luz.

[Si salió mal: represión]
[Si salió medianamente: producción precaria pero autónoma]
[Si salió bien: red de apoyo barrial sostiene la ocupación]
```

---

## II. PROBLEMAS ESPECÍFICOS DE REPRESENTACIÓN

### 2.1 La Exotización de Ixchel

**CITAS PROBLEMÁTICAS DEL GUION:**

> "Pica verduras como si rezara"  
> "Una precisión antigua"  
> "Un silencio que dice cosas"  
> "Alguien te contó que vino de lejos"

Esto es **orientalismo aplicado a lo indígena**. Edward Said (1978) definió orientalismo como:

> "Una forma de pensar basada en la distinción ontológica y epistemológica entre 'Oriente' y 'Occidente'. [...] El Oriente es romantizado, exotizado y esencializado como depositario de sabiduría ancestral, espiritualidad y autenticidad perdida por Occidente" (*Orientalism*, p. 2-3, traducción propia).

Rivera Cusicanqui denuncia esta práctica en la izquierda latinoamericana:

> "El colonialismo interno de la izquierda consiste en hablar *por* los pueblos indígenas, en fetichizar sus prácticas, en convertirlos en objetos de contemplación política sin reconocerlos como sujetos con agencia y pensamiento crítico propio" (2010).

**REESCRITURA NECESARIA DE IXCHEL:**

```
PRESENTACION_IXCHEL:
Ixchel está en la cocina de la olla.
Corta verdura con movimientos precisos.
No habla mucho. Cuando habla, va al punto.

"Llegué hace dos años. 
De una comunidad cerca de la frontera.
Nos sacaron. Proyecto minero.
El Estado dijo que traería desarrollo.
Lo único que trajo fue veneno en el agua."

[Si preguntás más:]
"Acá en la ciudad creen que inventaron la solidaridad.
En mi comunidad se llama ayni. Se llama mink'a.
Lo venimos haciendo hace siglos.
Pero claro, como no tiene papers académicos..."

[Si participás en asamblea con Ixchel:]
"La asamblea está bien. Pero hablan mucho.
En mi comunidad se habla menos y se hace más.
Pero bueno. Cada quien aprende como puede."
```

**Características de esta reescritura:**
- Ixchel tiene historia migratoria **concreta** (desplazamiento por extractivismo)
- Su conocimiento es **político**, no místico
- Crítica activa al colonialismo interno de la izquierda urbana
- Humor irónico sobre fetichización académica
- Agencia y subjetividad completa

### 2.2 Ausencia de Antagonismo de Clase Explícito

Marx en *El Capital* Vol. 1:

> "La relación capitalista presupone la separación de los trabajadores de la propiedad de las condiciones de realización de su trabajo. [...] Este proceso histórico de separación es la génesis de la producción capitalista" (Cap. 24, "La llamada acumulación originaria").

El juego muestra las consecuencias (precarización, agotamiento, despido) pero rara vez nombra **quién** toma las decisiones y **en beneficio de quién**.

**ESCENA FALTANTE - Momento de Ruptura Cognitiva:**

```
ASAMBLEA_ANALISIS:
Se está hablando de los despidos.
Carlos: "Es que la empresa está en crisis. No pueden pagar."

Diego: "Esperá. ¿Los dueños están en crisis también?"

Silencio incómodo.

Sofía: "Los vi el otro día. Restaurant en Pocitos. 
Pedían vino que costaba lo que yo gano en un mes."

Elena: "Y tienen 4x4 nueva. La vi estacionada."

Algo hace clic en tu cabeza.
No es crisis. Es decisión.
No es económico. Es político.
Alguien decide quién come y quién no.
Alguien decide quién trabaja y quién no.

[Idea desbloqueada: "Hay clases con intereses opuestos"]
```

---

## III. SISTEMA DE JUEGO: PROPUESTAS DE REDISEÑO

### 3.1 Del Stat "Llama" a Ideas Desbloqueadas

**SISTEMA ACTUAL (problemático):**
- "llama" sube/baja como puntos
- Gamifica la concienciación
- Modelo lineal y acumulativo

**SISTEMA PROPUESTO:**

```python
class IdeaPolitica:
    nombre: str
    descripcion: str
    desbloqueada: bool = False
    condiciones_desbloqueo: list[str]
    opciones_que_habilita: list[str]

IDEAS = {
    "no_es_individual": IdeaPolitica(
        nombre="No es solo mi problema",
        descripcion="La precariedad no es fracaso personal sino condición estructural",
        condiciones_desbloqueo=["participar_asamblea_1", "hablar_con_dos_vecinos"],
        opciones_que_habilita=["rechazar_culpa", "plantear_problema_colectivo"]
    ),
    
    "antagonismo_clase": IdeaPolitica(
        nombre="Hay intereses opuestos",
        descripcion="Los dueños y los trabajadores no están del mismo lado",
        condiciones_desbloqueo=["asamblea_analisis_despidos"],
        opciones_que_habilita=["proponer_huelga", "cuestionar_narrativa_crisis"]
    ),
    
    "autonomia_posible": IdeaPolitica(
        nombre="Podemos organizarnos sin jefes",
        descripcion="La horizontalidad no es caos sino otra forma de organizar",
        condiciones_desbloqueo=["ver_asamblea_funcionar", "experiencia_olla"],
        opciones_que_habilita=["proponer_autogestión", "rechazar_liderazgos"]
    ),
}
```

**Ventajas:**
- Respeta la no-linealidad del proceso de concienciación
- Cada idea es un salto cualitativo, no cuantitativo
- Abre posibilidades narrativas específicas
- No gamifica la política

### 3.2 Rediseño del Stat "Salud Mental"

**PROPUESTA:**

```python
# ANTES (problemático):
salud_mental: int  # 0-10, implica patología individual

# DESPUÉS:
peso_estructural: int  # 0-10
# Descripción en interfaz: "El peso del sistema sobre tu cuerpo y tu mente"

# Mostrar en UI:
if peso_estructural >= 8:
    "El sistema te está rompiendo. No sos vos."
elif peso_estructural >= 5:
    "El agotamiento pesa. Es la condición normal bajo esto."
else:
    "Hoy el cuerpo aguanta. No significa que el problema no exista."
```

**DIÁLOGOS QUE ACOMPAÑAN:**

```
REFLEXION_AGOTAMIENTO:
{peso_estructural >= 7:
Elena te pregunta cómo estás.
Podrías mentir. Decir "bien, ahí vamos".

- OPCIÓN: "Bien, ahí vamos" # Mantiene máscara
- OPCIÓN: {conexion >= 3} [Ser honesto] # COSTO:1

[Si elegís ser honesto:]
"Estoy para el orto, Elena. Mal. No doy más."

Elena asiente. No se sorprende.
"No es locura. Es vivir bajo esto.
Te rompen de a poco hasta que pensás que sos vos.
Pero no sos vos. Es el sistema."

[Idea potencial desbloqueada: "El sistema me enferma"]
}
```

### 3.3 Sistema de Consecuencias Políticas

Las acciones deben tener consecuencias políticas, no solo individuales.

**EJEMPLO - Huelga:**

```
LABURO_HUELGA_DECISION:
{idea_desbloqueada("antagonismo_clase") && conexion >= 5:

Diego plantea en el almuerzo:
"¿Y si paramos todos? Una semana. Que vean qué pasa sin nosotros."

Silencio.

Alguien: "Nos rajan a todos."
Otra: "Capaz que sí. ¿Pero qué perdemos? Ya nos rajan cuando quieren."

- OPCIÓN: Apoyar la idea # CONSECUENCIA: Huelga se organiza
- OPCIÓN: Quedarte callado # CONSECUENCIA: Huelga no sale
- OPCIÓN: {idea_desbloqueada("autonomia_posible")} [Proponer algo más radical]

[Si apoyás:]
"Yo estoy. Pero tiene que ser sin el sindicato.
Esos ya nos cagaron mil veces."

# FORK NARRATIVO:
# - Camino 1: Huelga se organiza, consecuencias (represión, victorias parciales, etc.)
# - Camino 2: Huelga fracasa por delación
# - Camino 3: Huelga deriva en ocupación
}
```

---

## IV. FINALES: EXPANDIR EL HORIZONTE DE LO POSIBLE

Mark Fisher en *Acid Communism* (póstumo, 2018):

> "El problema no es solo imaginar alternativas sino creer que son posibles. El realismo capitalista opera cerrando el horizonte de lo imaginable" (traducción propia).

**FINALES ACTUALES:**
- Final gris (aguantar)
- Final pequeño cambio (reformista)
- Final vulnerabilidad (terapéutico)
- Final lucha colectiva (reformista)

**FINALES FALTANTES:**

### 4.1 Final: Huelga Salvaje

```
FINAL_HUELGA:
El lunes, nadie fue.
No fue planeado por el sindicato.
Fue planeado en el almuerzo, en el bondi, en la calle.

La patronal amenazó. La policía vino.
Algunos se rajaron. Otros se mantuvieron.

{resultado_variable:
  - Si tiene apoyo comunitario alto: La olla sostuvo a las familias
  - Si tiene ideas clave: Se mantuvieron firmes, lograron negociar mejor
  - Si represión alta: Los cagaron a palos, pero algo cambió
}

No ganaron todo. Capaz no ganaron nada.
Pero aprendieron algo:
El poder del patrón no es absoluto.
Existe solo si ellos van a trabajar.

[Idea desbloqueada: "Nuestro trabajo vale más que nuestro sueldo"]
```

### 4.2 Final: Autogestión/Ocupación

```
FINAL_OCUPACION:
La fábrica cerró hace dos semanas.
"Problemas financieros", dijeron los dueños.
Mientras tanto, maquinaria nueva, sin usar.

La asamblea decidió.
Esta noche entran.

{si_sale_bien:
Producen por dos meses sin que nadie se entere.
Venden directo. Sin patrón. Sin intermediarios.
Eventualmente los descubren. Viene la policía.
Pero esos dos meses probaron algo:
No los necesitamos. Nunca los necesitamos.
}

{si_sale_mal:
La policía llega a la semana.
Represión. Desalojo. Algunos detenidos.
Pero algo quedó:
La sensación de que otro mundo es posible.
Breve. Frágil. Pero posible.
}
```

### 4.3 Final: Deserción/Fuga

Basado en Franco Berardi "Bifo" - *After the Future* (2011):

> "La deserción no es escapismo sino retirada estratégica. Es negarse a participar en los juegos del capital, negarse a competir, negarse a acelerar"

```
FINAL_FUGA:
Renunciaste. O te rajaron. Ya no importa.

Pero decidiste algo:
No volvés al circuito.
No más CV.
No más entrevistas donde te humillan.
No más "adaptabilidad al cambio" y "trabajo en equipo".

{si_conexion_alta:
La olla te ofrece algo.
No es sueldo. Es comida a cambio de trabajo.
No es futuro. Es presente.
Vivir de otra forma.
}

Los tres meses se terminan.
No conseguiste laburo.
Pero tampoco lo buscaste.

¿Es rendirse? ¿Es desertar?
No sabés.
Pero estás vivo. Y eso, hoy, es victoria.
```

### 4.4 Final: Represión (importante)

**Los finales radicales DEBEN poder salir mal.** Si toda acción colectiva sale bien, el juego miente.

```
FINAL_REPRESION:
La huelga duró tres días.
La policía entró al cuarto día.

Te agarraron a vos, a Diego, a cinco más.
Golpes. Comisaría. Abogado caro que no tenés.

Salís una semana después.
Marcado. Nadie te va a dar laburo.
Tu cara está en la lista.

{conexion_alta:
Pero el barrio te sostiene.
Sofía trae comida.
Elena te consigue changas bajo mano.
No te salvaron. Pero no te dejaron solo.
}

No es victoria. Es derrota.
Pero hay algo.
Dignidad. Memoria. Gente.

La lucha no siempre gana.
A veces te rompen.
Pero no te rompiste solo.
Y eso cambia todo.
```

---

## V. DIÁLOGOS: GUÍA DE ESCRITURA POLÍTICA

### 5.1 Evitar Discurso Panfletario

**MAL EJEMPLO (panfletario):**
> "¡Compañeros! ¡El capitalismo nos oprime! ¡Debemos unirnos y luchar por la revolución proletaria!"

**BUEN EJEMPLO (materialista):**
> Diego: "Sabés que producimos 50 unidades por hora, ¿no?"  
> Vos: "Sí, ¿y?"  
> Diego: "Cada una se vende a 800 pesos. 50 por hora, por 8 horas..."  
> [silencio mientras hace la cuenta]  
> Diego: "320.000 pesos por día producimos entre los diez que estamos."  
> Diego: "Nos pagan 15.000 a cada uno. Por mes."  
> [lo dejás pensando]

### 5.2 Usar Lenguaje Situado

Los personajes no hablan como papers académicos. Usan el lenguaje del barrio, del trabajo, de la calle.

**MAL:**
> "Debemos desarrollar prácticas prefigurativas de economía solidaria"

**BIEN:**
> Sofía: "Esto que hacemos acá en la olla.  
> Nadie manda, nadie cobra.  
> Cada uno aporta lo que puede.  
> Así tendría que ser todo, ¿no?"

### 5.3 Mostrar Contradicciones

Los personajes no son ideológicamente consistentes. Tienen contradicciones, dudas, retrocesos.

```
DIEGO_CONTRADICCION:
Diego: "Hay que organizarse. Pelear juntos."
[dos días después]
Diego: "Sabés qué, la verdad, yo tengo familia.
No puedo arriesgarme a que me rajen.
Ojalá pueda. Pero no puedo."

[Esto es más honesto que un personaje revolucionario perfecto]
```

---

## VI. ASPECTOS TÉCNICOS DE IMPLEMENTACIÓN

### 6.1 Variables de Estado Propuestas

```python
# Estados estructurales
peso_estructural: int = 5  # 0-10, reemplaza "salud_mental"
energia: int = 5  # 0-10, física
conexion: int = 5  # 0-10, redes de apoyo
dignidad: int = 5  # 0-10, auto-percepción

# Situación material
tiene_laburo: bool = True
dias_sin_laburo: int = 0
ahorro: int = 0  # En unidades abstractas
deudas: int = 0

# Experiencia política
ideas_desbloqueadas: set[str] = set()
participaciones_asamblea: int = 0
veces_que_ayude: int = 0
accion_directa_intentada: bool = False

# Posición social (afecta experiencias)
genero: str  # "varon", "mujer", "no_binario"
raza: str  # "blanco", "mestizo", "afro", "indigena"

# Historia personal
perdida: str  # "familiar", "relacion", "futuro", "vacio"
atadura: str  # "responsabilidad", "barrio", "inercia", "algo"
posicion: str  # "ajeno", "quemado", "esperanzado", "ambiguo"
vinculo: str  # "sofia", "elena", "diego", "marcos", "ixchel"
```

### 6.2 Sistema de Desbloqueo de Ideas

```python
def chequear_desbloqueo_ideas(estado_juego):
    """
    Chequea si se cumplen condiciones para desbloquear ideas políticas
    """
    
    # Idea: "No es individual"
    if (estado_juego.participaciones_asamblea >= 1 and 
        estado_juego.conexion >= 4):
        desbloquear_idea("no_es_individual")
    
    # Idea: "Antagonismo de clase"
    if "no_es_individual" in estado_juego.ideas_desbloqueadas:
        # Se desbloquea en escena específica de asamblea
        pass
    
    # Idea: "Autonomía posible"
    if (estado_juego.veces_que_ayude >= 3 and
        estado_juego.participaciones_asamblea >= 2):
        desbloquear_idea("autonomia_posible")
    
    # Idea: "Sabotaje legítimo"
    if ("antagonismo_clase" in estado_juego.ideas_desbloqueadas and
        estado_juego.peso_estructural >= 7):
        desbloquear_idea("sabotaje_legitimo")
```

### 6.3 Estructura de Escenas Políticas

```
ESTRUCTURA_ASAMBLEA:

1. OBSERVACION (primer contacto)
   - Personaje ve la asamblea de afuera
   - Opción de entrar o no
   - Si no entra: pierde oportunidad esta semana

2. PARTICIPACION_INICIAL (primera vez)
   - Hablan otros
   - Personaje escucha
   - Puede preguntar o quedarse callado
   
3. DEBATE_POLITICO (segunda/tercera vez)
   - Se discute tema concreto (despidos, huelga, olla)
   - Personaje puede aportar
   - Aquí se desbloquean ideas mediante diálogo

4. DECISION_COLECTIVA (cuarta vez en adelante)
   - La asamblea decide acción
   - Personaje puede proponer según ideas desbloqueadas
   - Consecuencias reales según decisión
```

---

## VII. CHECKLIST DE IMPLEMENTACIÓN

### Prioridad Alta (Cambios Fundamentales)

- [ ] Renombrar stat "salud_mental" → "peso_estructural"
- [ ] Reescribir completamente el personaje de Ixchel (sin exotización)
- [ ] Implementar sistema de ideas desbloqueadas (reemplaza "llama")
- [ ] Agregar elección de género y raza en creación de personaje
- [ ] Crear escena "ASAMBLEA_ANALISIS" (momento de antagonismo de clase)
- [ ] Escribir al menos 2 finales radicales nuevos

### Prioridad Media (Expansiones Narrativas)

- [ ] Agregar escenas diferenciadas por género/raza
- [ ] Expandir diálogos de asamblea con análisis político explícito
- [ ] Crear ramas de huelga/ocupación/autogestión
- [ ] Incluir posibilidad de fracaso/represión en acciones radicales
- [ ] Agregar momentos de contradicción en personajes NPC

### Prioridad Baja (Pulido)

- [ ] Revisar todo el lenguaje para evitar psicologización
- [ ] Agregar más referencias a economías del cuidado
- [ ] Incluir momentos de alegría colectiva (no todo es dolor)
- [ ] Expandir consecuencias de largo plazo de decisiones políticas

---

## VIII. RECURSOS BIBLIOGRÁFICOS COMPLEMENTARIOS

### Textos Fundamentales

**Sobre Capitalismo y Subjetividad:**
- Fisher, Mark. *Capitalist Realism: Is There No Alternative?* (2009)
- Fisher, Mark. *Ghosts of My Life: Writings on Depression, Hauntology and Lost Futures* (2014)
- Berardi, Franco "Bifo". *The Soul at Work: From Alienation to Autonomy* (2009)
- Berardi, Franco "Bifo". *After the Future* (2011)

**Sobre Pedagogía y Concienciación:**
- Freire, Paulo. *Pedagogía del Oprimido* (1970)
- Freire, Paulo. *La educación como práctica de la libertad* (1967)

**Sobre Interseccionalidad y Colonialismo:**
- Rivera Cusicanqui, Silvia. *Ch'ixinakax utxiwa: On Decolonising Practices and Discourses* (2010)
- Segato, Rita. *Contra-pedagogías de la crueldad* (2018)
- Segato, Rita. *La crítica de la colonialidad en ocho ensayos* (2015)

**Sobre Autonomía y Organización:**
- Kropotkin, Piotr. *El Apoyo Mutuo* (1902)
- Malatesta, Errico. *En el café: Conversaciones sobre el anarquismo* (1922)
- Holloway, John. *Cambiar el mundo sin tomar el poder* (2002)
- Zibechi, Raúl. *Dispersar el poder: Los movimientos como poderes antiestatales* (2006)

### Referencia de Juegos con Política Explícita

- **Disco Elysium** (2019): Análisis materialista, ideologías como sistema mecánico
- **Tonight We Riot** (2020): Acción directa, organización sindical
- **The Republia Times** (2012): Propaganda y control mediático
- **Papers, Please** (2013): Burocracia y violencia estructural
- **Cart Life** (2011): Precarización y trabajo informal

---

## IX. CONCLUSIONES Y LLAMADO A LA ACCIÓN

"Un Día Más" tiene el potencial de ser algo más que un juego sobre la depresión laboral. Puede ser una herramienta de concienciación política que:

1. **Nombre el problema:** Capitalismo, explotación, precarización estructural
2. **Muestre alternativas:** Autonomía, autogestión, acción directa
3. **Represente honestamente:** Incluyendo fracasos, contradicciones, represión
4. **Evite reproducir opresiones:** Sin exotización, sin psicologización, sin universalización

Como escribió Mark Fisher poco antes de su muerte:

> "La tarea es construir lo que podríamos llamar 'realismo ácido': la comprensión de que el mundo actual no es inevitable ni natural, y que alternativas son posibles si nos atrevemos a imaginarlas y construirlas" (notas posthumas, 2017).

Este juego puede contribuir a ese proyecto.

Las recomendaciones aquí presentadas no buscan "suavizar" ni "equilibrar" el mensaje político. Al contrario: buscan radicalizarlo, hacerlo más honesto, más situado, más útil como herramienta de transformación.

---

**Preguntas abiertas para el equipo:**

1. ¿Están dispuestos a incluir finales donde la acción política fracasa y hay represión?
2. ¿Cuál es el límite de "radicalidad" que están dispuestos a representar? (huelga, ocupación, sabotaje)
3. ¿Cómo piensan balancear la honestidad afectiva (el dolor del agotamiento) con la apertura de horizontes políticos?
4. ¿El juego busca representar o transformar? (Son objetivos distintos)

---

**Contacto para seguimiento:**  
V. - Knowmad Institut  
[email protegido por privacidad]

**Licencia de este documento:**  
Creative Commons BY-SA 4.0 - Puede ser compartido, modificado y usado libremente con atribución
