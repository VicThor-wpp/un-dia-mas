# 04 - PLAN DE IMPLEMENTACION DEL PROTOTIPO

## Conflicto: "Cuando Todo Cae" (Hibrido)

---

## RESUMEN DEL PROTOTIPO

**Premisa:** Te despiden el miercoles. Tenes indemnizacion para 3 meses. La olla del barrio esta en crisis. Tenes una semana para decidir que hacer con tu tiempo, tu energia, y tu lugar en el mundo.

**Duracion:** 7 dias completos (lunes a domingo)

**Conflictos combinados:**
- El Cierre (laboral) - Te despiden, pero tenes colchon
- La Olla en Crisis (comunitario) - Sofia no da mas

**Por que este hibrido funciona:**
- El despido te libera tiempo pero te quita identidad
- La olla necesita manos, vos necesitas un lugar
- Las dos crisis se retroalimentan emocionalmente
- Fuerza decisiones entre reconstruirte solo o con otros

---

## 1. TECNOLOGIA ELEGIDA

### Ink (Inkle Studios)

**Que es Ink:**
Ink es un lenguaje de scripting para narrativa interactiva creado por Inkle Studios (los de 80 Days, Heaven's Vault). Es texto plano con marcadores simples que definen flujo, variables y decisiones. Se compila a JSON que cualquier runtime puede leer.

**Por que es ideal para este prototipo:**
- Enfocado en narrativa, no en graficos
- Sintaxis simple: escribis la historia, no codigo
- Variables nativas para trackear estado
- Decisiones con condiciones incorporadas
- Exporta directo a web (HTML5)
- Gratis y open source
- Excelente para iterar rapido sobre texto

**Inky (Editor):**
Editor visual gratuito de Inkle. Te muestra el texto a la izquierda y una preview jugable a la derecha. Errores se marcan en tiempo real. Es todo lo que necesitas para escribir y testear.

**Descarga:** https://github.com/inkle/inky/releases

**Como exporta a web:**
1. Ink compila tu `.ink` a un archivo `.json`
2. La libreria JavaScript `inkjs` lee ese JSON
3. Un template HTML basico muestra el texto y las opciones
4. Inky tiene boton "Export for web" que genera todo

**Limitaciones y como trabajar con ellas:**

| Limitacion | Solucion |
|------------|----------|
| Sin graficos nativos | Usar CSS para estilo visual (terminal, retro) |
| Sin audio nativo | Agregar con JavaScript si es necesario |
| Sin guardado automatico | Implementar con localStorage (simple) |
| Sin UI compleja | Las decisiones son lista de texto, suficiente para prototipo |

### Estructura de Archivos Propuesta

```
la-llama-prototipo/
|-- main.ink              # Punto de entrada, setup inicial
|-- variables.ink         # Todas las variables del juego
|-- ideas.ink             # Sistema del Gabinete del Pensamiento
|-- utilidades.ink        # Funciones helper (mostrar estado, etc.)
|
|-- npcs/
|   |-- sofia.ink         # Dialogos y logica de Sofia
|   |-- elena.ink         # Dialogos y logica de Elena
|   |-- diego.ink         # Dialogos y logica de Diego
|   |-- marcos.ink        # Dialogos y logica de Marcos
|   |-- yulimar.ink       # Dialogos y logica de Yulimar
|   +-- walter.ink        # Dialogos y logica de Walter
|
|-- dias/
|   |-- lunes.ink         # Dia 1: Rutina, todo normal
|   |-- martes.ink        # Dia 2: Las senales
|   |-- miercoles.ink     # Dia 3: EL DESPIDO
|   |-- jueves.ink        # Dia 4: Primer dia sin laburo
|   |-- viernes.ink       # Dia 5: La asamblea
|   |-- sabado.ink        # Dia 6: Consecuencias
|   +-- domingo.ink       # Dia 7: Estado final
|
|-- fragmentos/
|   +-- fragmentos.ink    # Todos los fragmentos nocturnos de NPCs
|
|-- finales/
|   +-- finales.ink       # Todos los posibles finales
|
+-- web/
    |-- index.html        # Template web
    |-- style.css         # Estilos (tipografia, colores)
    |-- ink.js            # Runtime de Inkjs
    +-- game.js           # Logica de juego (UI, guardado)
```

**Como incluir archivos en Ink:**
```ink
INCLUDE variables.ink
INCLUDE ideas.ink
INCLUDE npcs/sofia.ink
INCLUDE dias/lunes.ink
// etc.
```

---

## 2. SISTEMA DE VARIABLES EN INK

### Variables Principales

```ink
// ============================================
// VARIABLES.INK - Sistema de recursos de LA LLAMA
// ============================================

// --- RECURSOS PERSONALES ---

VAR energia = 4           // Dados de energia disponibles hoy (3-5)
VAR energia_max = 5       // Maximo posible por dia
VAR energia_base = 4      // Energia con la que amaneces normalmente

VAR dignidad = 5          // 0-10: Se erosiona buscando laburo, en entrevistas humillantes
VAR trauma = 0            // 0-10: Sube por crisis identitaria, por no saber quien sos ahora

// --- RECURSOS COLECTIVOS ---

VAR la_llama = 3          // 0-10: Capacidad colectiva de imaginar otro mundo
VAR conexion = 5          // 0-10: Tu lugar en el tejido del barrio
VAR acumulacion = 0       // 0-10: Complicidad con la logica del capital (oculto)

// --- ESTADO DE LA OLLA ---

VAR olla_abierta = true       // La olla sigue funcionando?
VAR olla_crisis_nivel = 0     // 0-3: Gravedad de la crisis
VAR olla_recursos = 2         // 0-5: Comida disponible
VAR olla_voluntarios = 1      // Cuanta gente ayuda (1 = solo Sofia)

// --- ESTADO DEL DESPIDO ---

VAR despedido = false         // Ya te echaron?
VAR indemnizacion = 3         // Meses de colchon (empieza en 3)
VAR en_lucha = false          // Estas resistiendo el despido?
VAR ocupacion_activa = false  // Hay ocupacion de la fabrica?
VAR buscando_laburo = false   // Estas activamente buscando?

// --- ESTADO DE NPCs ---

VAR sofia_estado = "agotada"      // normal, agotada, quebrada, recuperando
VAR sofia_en_olla = true          // Sigue en la olla?
VAR sofia_relacion = 3            // 0-5: Vinculo con Sofia

VAR elena_estado = "presente"     // presente, cansada, encerrada
VAR elena_relacion = 3            // 0-5: Vinculo con Elena

VAR diego_estado = "nuevo"        // nuevo, integrado, asustado, se_fue
VAR diego_relacion = 2            // 0-5: Vinculo con Diego

VAR marcos_estado = "alejado"     // alejado, observando, involucrado, quemado
VAR marcos_relacion = 2           // 0-5: Vinculo con Marcos
VAR marcos_volvio = false         // Volvio a involucrarse?

VAR yulimar_estado = "presente"   // presente, solidaria, atacada
VAR yulimar_relacion = 2          // 0-5: Vinculo con Yulimar

VAR walter_oferta = false         // Te ofrecio algo?
VAR walter_aceptado = false       // Aceptaste su oferta?
VAR walter_expuesto = false       // Lo expusiste publicamente?

// --- IDEAS INTERNALIZADAS ---

VAR idea_todo_cae = false                 // "Cuando todo cae, caemos juntos o solos"
VAR idea_tengo_tiempo = false             // "Ahora tengo tiempo para esto"
VAR idea_pedir_no_debilidad = false       // "Pedir ayuda no es debilidad"
VAR idea_red_o_nada = false               // "Sin red, no hay salto"
VAR idea_esto_es_lo_que_hay = false       // "Esto es lo que hay" (involuntaria/negativa)
VAR idea_solidaridad_agota = false        // "La solidaridad tambien agota"
VAR idea_estado_abandono = false          // "El estado nos abandono"
VAR idea_comunidad_no_caridad = false     // "No somos caridad, somos comunidad"
VAR idea_patron_plan_b = false            // "El patron siempre tiene un plan B"
VAR idea_solos_no_podemos = false         // "Solos no podemos"
VAR idea_quien_soy_ahora = false          // "Quien soy si no soy mi trabajo?"

// --- CONTROL DE FLUJO ---

VAR dia = 1                   // 1-7: Dia actual de la semana
VAR momento = "amanecer"      // amanecer, jornada, noche

// --- FLAGS DE EVENTOS ---

VAR vio_sofia_quebrarse = false
VAR hablo_con_elena_sobre_pasado = false
VAR incluyo_a_diego = false
VAR confronto_xenofobia = false
VAR asistio_asamblea = false
VAR propuso_reorganizar_olla = false
VAR ayudo_en_olla = false                 // Dio tiempo a la olla esta semana
```

### Como Usar Cada Variable

**ENERGIA:**
```ink
// Verificar antes de accion costosa
* {energia >= 2} [Quedarte a ayudar en la olla (-2)]
    ~ energia -= 2
    ~ ayudo_en_olla = true
    Pasas la tarde picando verduras, lavando ollas...
    -> ayudaste_olla

* {energia >= 1} [Pasar un rato (-1)]
    ~ energia -= 1
    -> fuiste_poco

* [Ir a casa a mandar CVs]
    ~ buscando_laburo = true
    -> buscar_laburo
```

**LA LLAMA:**
```ink
// Afecta el tono de los textos
{la_llama >= 6: El barrio se siente vivo. Hay algo en el aire.}
{la_llama <= 3: Todo se siente gris. Cada uno en la suya.}
{la_llama == 0: No queda nada. Solo gente sola en el mismo lugar.}
```

**CONEXION:**
```ink
// Afecta que vinculos tenes
* {conexion >= 6} [Pedirle consejo a Elena]
    Elena te hace pasar. Pone la pava.
    -> elena_consejo

* {conexion >= 4 and conexion < 6} [Pedirle consejo a Elena]
    Elena te saluda, pero esta ocupada.
    -> elena_ocupada

* {conexion < 4} [Pedirle consejo a Elena]
    // Esta opcion no aparece: no tenes suficiente vinculo
```

**ACUMULACION:**
```ink
// Modifica percepciones (el jugador no ve el numero)
{acumulacion >= 5:
    Cuando llegas a la olla, las conversaciones se cortan.
}
{acumulacion >= 7:
    Sofia no te mira a los ojos. Algo cambio.
}
```

**TRAUMA:**
```ink
// Sube por crisis identitaria, no por hambre
{trauma >= 3:
    A veces te olvidas que dia es. Que importa.
}
{trauma >= 5 and not idea_esto_es_lo_que_hay:
    // Se impone una idea negativa
    -> imponer_idea_esto_es_lo_que_hay
}

// Afecta recuperacion de energia
~ energia = energia_base - (trauma / 3)
{energia < 2: ~ energia = 2} // Minimo 2
```

**DIGNIDAD:**
```ink
// Baja por humillaciones laborales, no por hacer cola
{dignidad <= 3:
    Otra entrevista donde te tratan como numero.
    Otra empresa que no contesta.
}
{dignidad <= 1:
    Ya no sabes como presentarte. "Soy... era..."
}
```

---

## 3. ESTRUCTURA DE UN DIA EN INK

### Template de Dia

```ink
// ============================================
// MIERCOLES.INK - El dia que todo cambia
// ============================================

=== miercoles ===

= amanecer
    ~ dia = 3
    ~ momento = "amanecer"
    ~ energia = energia_base - (trauma / 3)
    {energia < 2: ~ energia = 2}

    # MIERCOLES

    Te despertas con el telefono vibrando.

    Un mensaje del trabajo: "Reunion obligatoria a las 9. Todos."

    {trauma >= 3:
        No dormiste bien. La cabeza no para.
    }

    Energia: {energia}/{energia_max}

    -> jornada

= jornada
    ~ momento = "jornada"

    // LA ESCENA DEL DESPIDO
    -> escena_despido

= escena_despido
    Llegas a la oficina. Hay un silencio raro.

    Te hacen pasar a una sala. Recursos Humanos.

    "Lamentamos informarte que tu posicion ha sido discontinuada."

    ~ despedido = true
    ~ trauma += 1

    Te dan los papeles. Indemnizacion. Tres meses.
    Tres meses para reinventarte.

    Como reaccionas?

    * [Quedarte en silencio]
        No decis nada. Asenti.
        Firmas. Salis.
        La caja con tus cosas te espera en recepcion.
        -> despues_despido

    * [Preguntar por que]
        "Por que yo?"

        "Reestructuracion. No es personal."

        Pero se siente personal. Es tu vida la que cambia.
        -> despues_despido

    * {dignidad >= 4} [Plantarte]
        "Quiero ver los numeros. Quiero entender."
        ~ dignidad += 1

        Te miran. No esperaban preguntas.

        "Esta todo en regla. Podes consultar con un abogado."

        Lo dicen tranquilos. Saben que tenes colchon. No vas a pelear.
        -> despues_despido

    * {conexion >= 5} [Preguntar por los demas]
        "A cuantos mas?"

        "Eso es confidencial."

        Pero ves la lista sobre la mesa. Son veinte.
        Diego esta en la lista.
        -> despues_despido

= despues_despido
    Salis del edificio. Son las 10 de la manana.

    El cheque en el bolsillo. Tres meses.
    No te estas muriendo. Pero algo murio.

    La ciudad sigue funcionando. La gente va a sus laburos.
    Vos ya no tenes adonde ir.

    Que haces?

    * {energia >= 2} [Ir a buscar a Diego]
        ~ energia -= 2
        Diego sale poco despues. Tiene la misma cara vacia.
        -> hablar_con_diego

    * {energia >= 1} [Ir a la olla a buscar a Sofia]
        ~ energia -= 1
        Necesitas ver una cara conocida. Hacer algo.
        -> ir_a_olla

    * [Ir a casa]
        No queres ver a nadie. Todavia no.
        -> ir_a_casa

    * {walter_oferta} [Llamar a Walter]
        ~ acumulacion += 1
        Recordas su oferta. Capaz ahora tiene sentido.
        -> llamar_walter

= hablar_con_diego
    Diego esta parado en la vereda, mirando el celular sin ver.

    "A vos tambien, no?"

    Asiente sin mirarte.

    * "Tenemos que hacer algo juntos."
        ~ incluyo_a_diego = true
        ~ diego_relacion += 1
        ~ conexion += 1

        Diego levanta la vista.

        "Que podemos hacer?"

        "No se. Pero solos es peor."
        -> fin_jornada

    * "Lo siento, Diego."
        "Gracias."

        Se va caminando. No sabes adonde. Vos tampoco sabes adonde ir.
        -> fin_jornada

    * [No decir nada, solo acompanar]
        Te quedas ahi, parado con el.

        A veces alcanza con no estar solo en el momento.
        ~ diego_relacion += 1
        -> fin_jornada

= ir_a_olla
    Llegas a la olla. Sofia esta sola, lavando ollas.

    "Que haces aca a esta hora?"

    * "Me echaron. Tengo tiempo ahora."
        Sofia deja de fregar. Te mira.

        "Mierda. Lo siento."

        Pero ves algo mas en sus ojos. Alivio, casi.
        Otra persona que puede ayudar.
        ~ sofia_relacion += 1
        -> sofia_pregunta

    * "Vine a ver si necesitas una mano."
        "Siempre. Pero hoy no es tu dia de..."

        "Ya no tengo dias de nada. Me echaron."

        Sofia asiente. Entiende.
        -> sofia_pregunta

= sofia_pregunta
    Sofia se seca las manos.

    "La olla esta mal. No se si llegamos al sabado."

    ~ vio_sofia_quebrarse = true

    * "Que puedo hacer?"
        ~ propuso_reorganizar_olla = true
        ~ ayudo_en_olla = true
        "Ahora tengo tiempo. Puedo venir todos los dias."

        Sofia te mira. Por primera vez en semanas, algo se afloja en su cara.

        "Dale. Empeza por las verduras."
        ~ sofia_relacion += 1
        -> fin_jornada

    * "Estoy procesando lo mio, pero puedo ayudar un rato."
        Sofia asiente. No te juzga.
        "Cada mano suma. Aunque sea un rato."
        ~ ayudo_en_olla = true
        -> fin_jornada

    * "Perdon, necesito ir a casa primero."
        "Cuidate. Cuando puedas, veni."
        -> fin_jornada

= ir_a_casa
    Llegas a tu casa. Esta vacia.

    Te sentas. Miras la pared.
    El silencio es nuevo. Antes era descanso. Ahora es vacio.

    ~ trauma += 1

    Quien sos ahora? No sos tu puesto. No sos tu sueldo.
    Pero entonces, que sos?

    {trauma >= 3:
        Tres meses. La cuenta regresiva empezo.
        La tarjeta. El alquiler. Las cuentas.
        No hoy. Pero pronto.
    }

    -> fin_jornada

= llamar_walter
    Walter atiende al primer tono.

    "Sabia que ibas a llamar. Te enteraste, no?"

    -> walter.oferta_post_despido

= fin_jornada
    El dia pasa. No sabes bien como.

    Tres meses de colchon. Tiempo de sobra.
    Pero el tiempo vacio pesa distinto.

    -> noche

= noche
    ~ momento = "noche"

    # MIERCOLES - NOCHE

    Estas acostado. No dormis.

    {despedido:
        Tres meses. Noventa dias.
        Manana hay que empezar a buscar.
        O... manana hay que empezar algo.
    }

    {vio_sofia_quebrarse:
        Pensas en Sofia. En como se veia. En lo sola que esta.
        Ahora tenes tiempo. Antes no lo tenias.
    }

    // Procesamiento de ideas
    {despedido and not idea_quien_soy_ahora:
        -> ofrecer_idea_identidad
    }

    -> fragmento_miercoles

= ofrecer_idea_identidad
    Pensas en como te presentabas. "Laburo en..."
    Ya no podes decir eso.

    Quien sos si no sos tu trabajo?

    # IDEA DISPONIBLE: "Quien soy si no soy mi trabajo?"

    * [Internalizar]
        ~ idea_quien_soy_ahora = true

        La pregunta duele. Pero tambien abre algo.
        Capaz sos mas que un puesto. Capaz siempre lo fuiste.

        (Ahora podes explorar otros lugares donde pertenecer)
        -> fragmento_miercoles

    * [Dejar pasar]
        No queres pensar en eso. No todavia.
        -> fragmento_miercoles

= fragmento_miercoles
    # MIENTRAS DORMIS

    -> fragmentos.fragmento_sofia_miercoles
```

### Explicacion de la Estructura

**Amanecer:**
- Resetear energia segun base menos trauma
- Mostrar contexto del dia
- Informacion de estado para el jugador

**Jornada:**
- Las escenas principales del dia
- Decisiones con costo de energia (tiempo/esfuerzo, no sobrevivir)
- Modificacion de variables segun elecciones
- El protagonista OFRECE ayuda, no RECIBE

**Noche:**
- Procesar consecuencias emocionales
- Ofrecer ideas para internalizar
- La cuenta regresiva como ansiedad de fondo, no urgencia

**Fragmento:**
- Ventana a la vida de un NPC
- Afectado por decisiones del dia
- No hay control del jugador, solo observa

---

## 4. SISTEMA DE DECISIONES EN INK

### Decisiones Simples (Sin costo)

```ink
Que le decis?

* [Decir la verdad]
    Le contas lo del despido.
    -> consecuencia_verdad

* [No entrar en detalle]
    "Ando en cambios. Ya te cuento."
    -> consecuencia_evasion

* [Preguntar por ella primero]
    "Despues te cuento. Como estas vos?"
    -> consecuencia_escuchar
```

### Decisiones con Costo de Tiempo/Energia

```ink
Como distribuís tu dia?

* {energia >= 3} [Quedarte toda la tarde en la olla (-3 energia)]
    ~ energia -= 3
    ~ conexion += 2
    ~ olla_voluntarios += 1
    ~ ayudo_en_olla = true
    Te quedas hasta que no queda nadie.
    Las manos te quedan oliendo a cebolla. Se siente bien.
    -> ayudaste_mucho

* {energia >= 2} [Ayudar un par de horas y despues buscar laburo (-2 energia)]
    ~ energia -= 2
    ~ conexion += 1
    ~ buscando_laburo = true
    Haces lo que podes en la olla. Despues, a mandar CVs.
    -> dia_dividido

* {energia >= 1} [Pasar un rato por la olla (-1 energia)]
    ~ energia -= 1
    Apareces, charlas, ayudas poco. Pero estas.
    -> ayudaste_poco

* [Dedicar el dia a buscar laburo]
    ~ buscando_laburo = true
    ~ dignidad -= 1
    Portales, CVs, formularios. Nadie contesta hoy.
    -> buscar_laburo
```

### Decisiones Afectadas por Estado

```ink
Necesitas hablar con alguien. A quien buscas?

* {conexion >= 6 and elena_relacion >= 4} [Ir a lo de Elena]
    Elena te hace pasar sin preguntar.
    Pone la pava. Se sienta a escuchar.
    -> elena_consejo_profundo

* {conexion >= 4 and sofia_relacion >= 3} [Buscar a Sofia]
    Sofia esta en la olla, pero hace un corte.
    "Conta."
    -> sofia_escucha

* {diego_relacion >= 3} [Llamar a Diego]
    Diego esta igual que vos. Pero al menos pueden estar perdidos juntos.
    -> diego_companero

* [No hablar con nadie]
    ~ trauma += 1
    Te la bancas solo. Como siempre.
    -> solo
```

### Decisiones que Desbloquean Ramas

```ink
En la asamblea, que postura tomas?

* {idea_solos_no_podemos} [Proponer ocupar la fabrica]
    ~ ocupacion_activa = true
    ~ la_llama += 1
    "Si no ocupamos, nos pasan por arriba."
    -> rama_ocupacion

* {idea_patron_plan_b} [Proponer investigar a la empresa]
    "Ellos saben mas de lo que dicen. Hay que averiguar."
    -> rama_investigacion

* [Apoyar la negociacion]
    "Hay que ser realistas. Consigamos lo que podamos."
    -> rama_negociacion

* [No hablar]
    ~ trauma += 1
    Dejas que otros decidan. No sabes que aportar.
    -> rama_pasivo
```

### Decisiones con Consecuencias Diferidas

```ink
Walter te ofrece laburo. Que le decis?

* [Aceptar]
    ~ walter_aceptado = true
    ~ acumulacion += 3
    "Empezas el lunes."

    Laburo. Sueldo. Normalidad.
    Pero algo no cierra. No preguntes que.
    -> continuar

* [Rechazar]
    ~ dignidad += 1
    ~ la_llama += 1
    "No, gracias. Busco otra cosa."

    Walter se encoge de hombros.
    "Vos sabes. La oferta no dura para siempre."
    -> continuar

* [Pedirle tiempo]
    "Dejame pensarlo."

    ~ walter_oferta_pendiente = true

    "Tenes hasta el viernes."
    -> continuar
```

### Decisiones Sobre Dar vs Guardarse

```ink
// La escasez es de TIEMPO y ENERGIA, no de comida
Tenes la tarde libre. Que haces?

* [Ir a ayudar a la olla]
    ~ energia -= 2
    ~ conexion += 1
    ~ ayudo_en_olla = true
    Das tu tiempo. Lo que antes no tenias.
    -> olla

* [Quedarte a mandar CVs]
    ~ energia -= 1
    ~ buscando_laburo = true
    ~ dignidad -= 1
    El futuro primero. Lo tuyo primero.
    -> buscar

* [Descansar, procesar]
    ~ trauma -= 1
    A veces hay que parar. Esta bien.
    -> descanso
```

---

## 5. SISTEMA DE FRAGMENTOS EN INK

### Estructura General

```ink
// ============================================
// FRAGMENTOS.INK - Las vidas de los otros
// ============================================

=== fragmentos ===

// Router principal segun el dia
= fragmento_noche
    {dia == 1: -> fragmento_lunes}
    {dia == 2: -> fragmento_martes}
    {dia == 3: -> fragmento_miercoles}
    {dia == 4: -> fragmento_jueves}
    {dia == 5: -> fragmento_viernes}
    {dia == 6: -> fragmento_sabado}
    -> fin_fragmento

// ============================================
// LUNES - Fragmento de Diego
// ============================================

= fragmento_lunes
    # MIENTRAS DORMIS

    Diego no duerme.

    Esta sentado en el borde de la cama, en la pieza que alquila.
    El celular brilla en la oscuridad.

    Marca el numero de su madre. Duda. Corta antes de que suene.

    {la_llama >= 5:
        Piensa en la gente del barrio. Capaz manana les habla.
    }
    {la_llama < 5:
        Piensa en el pueblo. Capaz tendria que volver.
    }

    Se acuesta. Mira el techo hasta que amanece.

    -> fin_fragmento

// ============================================
// MARTES - Fragmento de Elena
// ============================================

= fragmento_martes
    # MIENTRAS DORMIS

    Elena abre una caja que tiene guardada.

    Fotos viejas. Volantes de marchas. Recortes de diario.

    {hablo_con_elena_sobre_pasado:
        Penso en vos cuando abrio la caja.
        "Ojala entienda", murmura.
    }

    Hay una foto de su marido. Joven. Sonriendo.

    "Vos sabrias que hacer", le dice a la foto.

    La foto no responde. Nunca responde.

    {la_llama >= 5:
        Elena guarda la caja con cuidado. Hay que seguir.
    }
    {la_llama < 5:
        Elena cierra la caja con fuerza. Ya dio todo.
    }

    -> fin_fragmento

// ============================================
// MIERCOLES - Fragmento de Sofia (critico)
// ============================================

= fragmento_sofia_miercoles
    # MIENTRAS DORMIS

    Sofia esta en el bano. La puerta cerrada.

    Los pibes duermen. No pueden verla asi.

    Se mira al espejo. No se reconoce.

    {vio_sofia_quebrarse and ayudo_en_olla:
        Piensa en vos. Apareciste. Ofreciste manos. Eso es algo.
    }
    {vio_sofia_quebrarse and not ayudo_en_olla:
        Piensa en vos. Viniste pero no te quedaste. Entiende. Todos tienen lo suyo.
    }
    {not vio_sofia_quebrarse:
        Nadie vino hoy. Nadie pregunto.
    }

    Llora sin ruido. Ha aprendido a llorar sin ruido.

    ~ sofia_estado = "al_limite"

    Manana hay que cocinar. Manana hay que sonreir.
    Manana hay que fingir que puede.

    {la_llama >= 5:
        "Un dia mas", se dice. "Solo un dia mas."
    }
    {la_llama < 5:
        "No se cuanto mas", se dice. "No se."
    }

    -> fin_fragmento

// ============================================
// JUEVES - Fragmento de Marcos
// ============================================

= fragmento_jueves
    # MIENTRAS DORMIS

    Marcos camina por el barrio. Son las 2 AM.

    Pasa por la puerta de la olla. Esta cerrada.

    {ocupacion_activa:
        Pasa por la fabrica. Ve las luces adentro.
        La ocupacion sigue. El esta afuera.
    }

    Recuerda cuando era delegado. Cuando creia en algo.

    {marcos_volvio:
        Hoy volvio a sentir algo. No sabe si es bueno o malo.
    }
    {not marcos_volvio:
        "Ya di todo", se dice. Pero suena hueco.
    }

    Sigue caminando. No tiene adonde ir.

    -> fin_fragmento

// ============================================
// VIERNES - Fragmento de la asamblea (o su ausencia)
// ============================================

= fragmento_viernes
    # MIENTRAS DORMIS

    {asistio_asamblea:
        -> fragmento_post_asamblea
    }
    {not asistio_asamblea:
        -> fragmento_sin_asamblea
    }

= fragmento_post_asamblea
    La asamblea termino hace horas. Pero nadie se fue del todo.

    Elena camina a su casa. Piensa en todas las asambleas que vivio.

    {la_llama >= 6:
        Esta se sintio diferente. Como un principio.
    }
    {la_llama <= 4:
        Esta se sintio como un final.
    }

    -> fin_fragmento

= fragmento_sin_asamblea
    Hubo asamblea. No fuiste.

    {conexion >= 4:
        Alguien te nombro. "Y fulano?"
        Nadie supo responder.
    }

    Las decisiones se tomaron sin vos.
    Manana vas a ver las consecuencias.

    -> fin_fragmento

// ============================================
// SABADO - Fragmento segun estado de la olla
// ============================================

= fragmento_sabado
    # MIENTRAS DORMIS

    {olla_abierta:
        -> fragmento_olla_abierta
    }
    {not olla_abierta:
        -> fragmento_olla_cerrada
    }

= fragmento_olla_abierta
    La olla abrio. Con lo poco que habia.

    Una madre con dos pibes se fue con el tupper lleno.
    "Gracias", dijo. Pero no tendria que agradecer.
    Comer no es un favor.

    {sofia_en_olla and ayudo_en_olla:
        Sofia sirvio con vos al lado. Por primera vez en semanas, no estaba sola.
    }
    {sofia_en_olla and not ayudo_en_olla:
        Sofia sirvio hasta el final. Despues se fue sin hablar.
    }
    {not sofia_en_olla:
        Sofia no vino. Otros cubrieron. Pero se noto.
    }

    -> fin_fragmento

= fragmento_olla_cerrada
    La olla no abrio.

    El cartel en la puerta: "Hoy no hay. Disculpen."

    La gente llego igual. Leyo el cartel. Se quedo parada.

    Una madre con dos pibes:
    "Y ahora que comemos?"

    No hubo respuesta. Nunca hay respuesta para los que mas necesitan.

    ~ la_llama -= 1

    -> fin_fragmento

// ============================================
// FIN DE FRAGMENTO - Transicion al dia siguiente
// ============================================

= fin_fragmento

    # ...

    Amanece.

    {dia < 7:
        ~ dia += 1
        {dia == 2: -> dias/martes.amanecer}
        {dia == 3: -> dias/miercoles.amanecer}
        {dia == 4: -> dias/jueves.amanecer}
        {dia == 5: -> dias/viernes.amanecer}
        {dia == 6: -> dias/sabado.amanecer}
        {dia == 7: -> dias/domingo.amanecer}
    }
    {dia == 7:
        -> finales.calcular_final
    }
```

---

## 6. SISTEMA DE IDEAS EN INK

### Estructura para Ofrecer Ideas

```ink
// ============================================
// IDEAS.INK - El Gabinete del Pensamiento
// ============================================

// --- OFRECER IDEA ELEGIDA ---

=== ofrecer_idea(ref idea_var, nombre, texto_intro, texto_internalizacion, texto_rechazo) ===

{not idea_var:

    {texto_intro}

    # IDEA DISPONIBLE: {nombre}

    * [Internalizar esta idea]
        ~ idea_var = true

        {texto_internalizacion}

        (Idea internalizada: {nombre})
        ->->

    * [Dejar pasar]
        {texto_rechazo}
        ->->
}
->->

// --- IDEAS ESPECIFICAS ---

=== ofrecer_idea_solos_no_podemos ===

{not idea_solos_no_podemos:

    Pensas en el dia. En los que estaban. En los que faltaban.

    # IDEA DISPONIBLE: "Solos no podemos"

    * [Internalizar]
        ~ idea_solos_no_podemos = true

        Lo aprendiste hoy. Solo no sos nada.
        Juntos tampoco son mucho. Pero es todo lo que hay.

        (Las acciones colectivas ahora cuestan menos energia)
        ->->

    * [Dejar pasar]
        No estas seguro de nada todavia.
        ->->
}
->->

=== ofrecer_idea_tengo_tiempo ===

{not idea_tengo_tiempo:

    Antes no tenias tiempo. Laburo, viaje, cansancio.
    Ahora tenes tiempo de sobra. Y no sabes que hacer con el.

    # IDEA DISPONIBLE: "Ahora tengo tiempo para esto"

    * [Internalizar]
        ~ idea_tengo_tiempo = true

        El tiempo era lo que te faltaba. Ahora lo tenes.
        Podes darlo. Podes estar. Podes hacer.

        (Ayudar en la olla ahora cuesta -1 energia)
        ->->

    * [Dejar pasar]
        Tiempo para que? Todavia no sabes.
        ->->
}
->->

=== ofrecer_idea_patron_plan_b ===

{not idea_patron_plan_b:

    Pensas en como te enteraste. En los que sabian antes.

    # IDEA DISPONIBLE: "El patron siempre tiene un plan B"

    * [Internalizar]
        ~ idea_patron_plan_b = true

        El patron siempre sabe lo que va a hacer.
        Vos reaccionas. El actua.
        Asi funciona. Asi funciono siempre.

        (Ahora ves intenciones ocultas mas facilmente)
        ->->

    * [Dejar pasar]
        Preferis no pensar en eso.
        ->->
}
->->

=== ofrecer_idea_solidaridad_agota ===

{not idea_solidaridad_agota:

    Viste como Sofia se consume. Como todos se consumen.

    # IDEA DISPONIBLE: "La solidaridad tambien agota"

    * [Internalizar]
        ~ idea_solidaridad_agota = true

        No es egoismo. Es fisica.
        El cuerpo tiene limites. La voluntad tiene limites.
        Sostener lo insostenible te rompe.

        (Ahora podes decir "no" sin perder CONEXION)
        ->->

    * [Dejar pasar]
        Hay que seguir. Siempre hay que seguir.
        ->->
}
->->

// --- IDEAS INVOLUNTARIAS ---

=== imponer_idea_esto_es_lo_que_hay ===

// Esta idea se impone cuando TRAUMA >= 5

~ idea_esto_es_lo_que_hay = true

# IDEA IMPUESTA: "Esto es lo que hay"

No la elegiste. Se instalo sola.

Despues de todo lo que paso, algo cambio adentro.

"No hay nada que hacer. Siempre fue asi. Siempre va a ser asi."

El mundo se siente mas chico. Las opciones, menos.

(Las opciones de cambio ahora cuestan +2 energia)

->->

// --- VERIFICAR EFECTOS DE IDEAS ---

=== aplicar_efectos_ideas ===

// Llamar esto al calcular costos de acciones

{idea_solos_no_podemos:
    // Acciones colectivas: -1 energia
}

{idea_tengo_tiempo:
    // Ayudar en la olla: -1 energia
}

{idea_esto_es_lo_que_hay:
    // Acciones de cambio: +2 energia
}

{idea_solidaridad_agota:
    // Decir "no" no baja conexion
}

->->
```

### Uso en el Juego

```ink
// En una escena, despues de un evento significativo:

= despues_de_ver_asamblea_unida
    Algo paso ahi. No sabes que, pero algo.

    -> ofrecer_idea_solos_no_podemos ->

    -> continuar

// O con condicionales:

= noche_jueves
    {despedido and not idea_tengo_tiempo:
        -> ofrecer_idea_tengo_tiempo ->
    }

    {vio_sofia_quebrarse and not idea_solidaridad_agota:
        -> ofrecer_idea_solidaridad_agota ->
    }

    -> fragmento
```

---

## 7. SISTEMA DE FINALES EN INK

### Calculo del Final

```ink
// ============================================
// FINALES.INK - Como termina la semana
// ============================================

=== calcular_final ===

// FINAL COLECTIVO: Encontraste un lugar
{la_llama >= 6 and conexion >= 6:
    -> final_juntos
}

// FINAL ACUMULACION: Laburo pero solo
{acumulacion >= 7:
    -> final_solo_con_laburo
}

// FINAL ROTO: Perdiste la conexion
{la_llama <= 2 and conexion <= 3:
    -> final_aislado
}

// FINAL SOFIA: Depende de su estado
{sofia_estado == "quebrada":
    -> final_sofia_quebrada
}

// FINAL DIEGO: Se fue
{diego_estado == "se_fue":
    -> final_diego_se_fue
}

// FINAL OLLA CERRADA
{not olla_abierta:
    -> final_olla_cerrada
}

// FINAL POR DEFECTO: En transicion
-> final_transicion

// ============================================
// LOS FINALES
// ============================================

=== final_juntos ===

# DOMINGO

El sol entra por la ventana. Una semana.

{despedido:
    No tenes laburo. Eso no cambio.
    La indemnizacion sigue ahi. La cuenta regresiva tambien.
}

Pero algo mas si cambio.

La olla sigue. {olla_voluntarios > 2: Ya no es solo Sofia.}

{ayudo_en_olla:
    Tus manos huelen a cebolla. Te acostumbraste.
}

{incluyo_a_diego:
    Diego se quedo. No sabe bien por que, pero se quedo.
    Capaz es lo mismo que vos: buscar un lugar.
}

{marcos_volvio:
    Marcos aparecio en la asamblea. No dijo mucho. Pero estaba.
}

Hay una lista de telefonos en tu mesa. Gente del barrio.
Gente que ahora sabes que existe. Gente que sabe que existis.

No conseguiste laburo. Todavia.
No resolviste tu vida. Todavia.

Pero encontraste algo que no tenias:
Un lugar. Una red. Gente.

{la_llama >= 8:
    Y en algun lugar, muy adentro, algo sigue encendido.
    La idea de que se puede distinto.
}

Caimos juntos. Nos levantamos juntos.

-> fin_juego

=== final_solo_con_laburo ===

# DOMINGO

El sol entra por la ventana. Una semana.

Tenes laburo. El que te dio Walter.
Empezas el lunes. Sueldo. Normalidad.

{despedido:
    No volviste a la fabrica. Ya no importa.
}

Pero el barrio se siente distinto.

{sofia_relacion <= 2:
    Sofia te saluda de lejos. Ya no te invita a la olla.
}

{diego_estado == "se_fue":
    Diego se fue. No te aviso.
}

{elena_relacion <= 2:
    Elena te mira como miraba a Walter hace anos.
}

No sos malo. Hiciste lo que tenias que hacer.
Resolviste tu problema. Es lo que hacen todos.

Pero a veces, de noche, te acordas.
De la asamblea. De Diego preguntando que hacer.
De Sofia lavando ollas sola.

Sobreviviste. Pero perdiste algo.
No sabes bien que. Pero lo sentis.

-> fin_juego

=== final_aislado ===

# DOMINGO

El sol entra por la ventana. No queres levantarte.

{despedido:
    No tenes laburo.
    Pero la indemnizacion sigue. Todavia tenes tiempo.
}
{not olla_abierta:
    La olla cerro. Ya no tenes donde ir.
}

Todo se siente gris. Cada uno en la suya.

{la_llama <= 1:
    No hay nada aca. Solo gente sola en el mismo lugar.
}

El barrio sigue ahi. Pero no es tu barrio.
La gente sigue ahi. Pero no te ve.

~ trauma += 1

{trauma >= 6:
    Quien soy? La pregunta duele mas que antes.
    No tenes respuesta.
}

Otro lunes viene. Hay que buscar laburo.
Hay que pagar cuentas. Hay que seguir.

Solo.

-> fin_juego

=== final_sofia_quebrada ===

# DOMINGO

Sofia no sale de su casa. Los pibes estan con la hermana.

La olla cerro hace dias. Nadie la reabrio.

Elena: "Tendriamos que haber visto. Tendriamos que haber hecho algo."

Pero que? Quien tiene energia para sostener
a la que sostiene todo?

{vio_sofia_quebrarse and not ayudo_en_olla:
    La viste. Sabias. No hiciste nada.
    ~ trauma += 1
}

Las 200 personas buscan alternativas. Algunas encuentran.
Otras no.

Y en el barrio queda la sensacion de que algo se rompio.
No solo la olla. Algo mas.
La idea de que podiamos cuidarnos entre nosotros.

Sofia va a recuperarse. Eventualmente.
Pero no va a volver a hacer esto.
Y nadie puede pedirle que lo haga.

-> fin_juego

=== final_olla_cerrada ===

# DOMINGO

El local de la olla esta vacio. Las ollas guardadas.
Un cartel escrito a mano: "Gracias por todo."

{la_llama >= 5:
    Pero algo quedo. La gente que se conocio aca.
    Los grupos de WhatsApp que siguen activos.

    Un mes despues, en otro lugar, con otra gente,
    algo parecido vuelve a empezar.
    No es la misma olla. Pero es la misma necesidad.
    Y la misma respuesta.
}

{la_llama < 5:
    Las 200 personas buscan alternativas.
    Algunas encuentran. Otras no.

    Nadie habla de lo que paso.
    Es mas facil asi.
}

-> fin_juego

=== final_diego_se_fue ===

# DOMINGO

Diego se fue. Volvio al pueblo.

{incluyo_a_diego:
    Te mando un mensaje antes de irse.
    "Gracias por todo. Ojala nos veamos."

    No van a verse. Los dos lo saben.
    Pero el mensaje queda. Algo queda.
}

{not incluyo_a_diego:
    No te aviso. Te enteraste por Elena.
    "El pibe del interior. Se fue ayer."
}

El barrio perdio a alguien. Otra vez.

Asi funciona: la gente llega, intenta, se va.
El que se queda mira como se van los demas.

{la_llama >= 5:
    Pero quizas Diego se lleva algo.
    La idea de que hay lugares donde la gente aparece.
    Capaz en el pueblo cuente lo que vio aca.
}

-> fin_juego

=== final_transicion ===

# DOMINGO

El sol entra por la ventana. Una semana.

{despedido:
    No tenes laburo. Hay que buscar.
    Pero todavia tenes colchon. Todavia hay tiempo.
}

La olla {olla_abierta: sigue|cerro}.
La llama {la_llama >= 5: todavia esta|casi no se ve}.

No cambio nada definitivamente.
La semana termino, el lunes viene.

Victoria lenta o derrota lenta? No se sabe.

Lo unico que sabes es que seguis aca.
El barrio sigue aca.
Y manana hay que levantarse de nuevo.

{ayudo_en_olla:
    Capaz vas a la olla. Capaz ayudas.
}
{buscando_laburo:
    Capaz mandas mas CVs. Capaz alguien contesta.
}

La cuenta regresiva sigue.
Pero no estas solo. No del todo.

-> fin_juego

=== fin_juego ===

# FIN

Gracias por jugar LA LLAMA.

-> END
```

---

## 8. PLAN DE DESARROLLO POR FASES

### FASE 1: Estructura Base (2-3 dias)

**Objetivos:**
- Proyecto Ink funcionando
- Variables implementadas
- Flujo basico lunes-domingo (vacio pero navegable)

**Tareas:**
1. Descargar e instalar Inky
2. Crear estructura de carpetas
3. Escribir `main.ink` con INCLUDEs
4. Escribir `variables.ink` completo
5. Crear plantillas vacias para cada dia
6. Probar que el flujo compile sin errores

**Criterio de exito:**
- Poder "jugar" desde lunes hasta domingo
- Solo texto placeholder, pero funciona

### FASE 2: Dia Critico - Miercoles (2-3 dias)

**Objetivos:**
- El despido completamente jugable
- Crisis identitaria, no de supervivencia
- Primera prueba de tono y mecanicas
- Sistema de fragmentos basico

**Tareas:**
1. Escribir `miercoles.ink` completo
2. La escena del despido: "3 meses para resolver esto"
3. Opciones: procesar solo vs buscar compania vs ayudar en olla
4. Implementar primeras modificaciones de variables
5. Fragmento de Sofia esa noche
6. Testear tono: se siente real? Es crisis identitaria, no hambre?

**Criterio de exito:**
- El miercoles se siente significativo
- Las decisiones son sobre tiempo/energia, no sobrevivir
- El protagonista puede OFRECER ayuda, no pedirla

### FASE 3: Dias 1-2, Lunes-Martes (2-3 dias)

**Objetivos:**
- Establecer el "antes" de la crisis
- Introducir NPCs
- Plantar semillas del conflicto

**Tareas:**
1. `lunes.ink`: dia normal, rutina, la olla existe pero no es tu mundo
2. `martes.ink`: se confirma algo raro, senales
3. Introducir a Diego, Sofia, Elena como conocidos del barrio
4. Primeros fragmentos nocturnos
5. Mostrar la olla funcionando (para que duela cuando caiga)

**Criterio de exito:**
- Se siente como vida normal antes del golpe
- Los NPCs tienen personalidad
- El jugador empieza a conectar con el barrio

### FASE 4: Dias 4-5, Jueves-Viernes (3-4 dias)

**Objetivos:**
- Primer dia sin laburo: que haces con el tiempo?
- Crisis de la olla en pleno
- Walter y la tentacion de "normalidad"
- La asamblea (punto de mayor complejidad)

**Tareas:**
1. `jueves.ink`: manana vacia, que hacer con el dia
2. Opciones: buscar laburo vs ayudar en olla vs quedarte en casa
3. Sofia dice que no puede mas
4. Walter ofrece laburo (volver a la normalidad)
5. `viernes.ink`: la asamblea/reunion
6. Multiples ramas segun decisiones

**Criterio de exito:**
- El jugador siente la tension de TIEMPO, no de comida
- La oferta de Walter es tentadora (normalidad vs comunidad)
- La asamblea se siente real (lenta, frustrante, valiosa)

### FASE 5: Dias 6-7, Sabado-Domingo (2-3 dias)

**Objetivos:**
- Consecuencias de todo lo anterior
- Multiples ramas segun decisiones
- Finales diferenciados por PERTENENCIA, no supervivencia

**Tareas:**
1. `sabado.ink`: la olla abre o no abre
2. Consecuencias visibles de cada rama
3. `domingo.ink`: estado final
4. Implementar sistema de calculo de final
5. Escribir al menos 4 finales distintos

**Criterio de exito:**
- Los finales reflejan donde PERTENECES, no si sobreviviste
- "Caimos juntos, nos levantamos juntos" = encontraste lugar
- "Sobrevivi pero solo" = tenes laburo pero perdiste comunidad

### FASE 6: Pulido (3-5 dias)

**Objetivos:**
- Balance de mecanicas
- Revision de textos (tono correcto!)
- Fragmentos completos
- Testing

**Tareas:**
1. Balancear energia (hay escasez de TIEMPO real?)
2. Revisar que las ideas funcionen
3. Completar fragmentos de todos los NPCs
4. Revisar consistencia de tono (Disco Elysium, no This War of Mine)
5. Eliminar bugs de flujo
6. Agregar transiciones pulidas

**Criterio de exito:**
- Jugar de principio a fin sin fricciones
- Las mecanicas generan tension sobre DONDE ESTAR
- El tono es consistente: clase media precarizada, no indigencia

### RESUMEN DE TIEMPOS

| Fase | Duracion | Acumulado |
|------|----------|-----------|
| 1. Estructura | 2-3 dias | 2-3 dias |
| 2. Miercoles | 2-3 dias | 4-6 dias |
| 3. Lunes-Martes | 2-3 dias | 6-9 dias |
| 4. Jueves-Viernes | 3-4 dias | 9-13 dias |
| 5. Sabado-Domingo | 2-3 dias | 11-16 dias |
| 6. Pulido | 3-5 dias | 14-21 dias |

**TOTAL ESTIMADO: 2-3 semanas**

---

## 9. TESTING E ITERACION

### Que Testear

**Mecanicas:**
- El sistema de energia genera escasez de TIEMPO real?
- Las decisiones son sobre donde estar, no sobre sobrevivir?
- Las ideas cambian la experiencia?
- Los recursos ocultos (ACUMULACION) funcionan sin verse?

**Narrativa:**
- Los fragmentos generan empatia con los NPCs?
- El protagonista AYUDA, no RECIBE?
- El tono es crisis identitaria, no hambre?
- Los dialogos suenan naturales?

**Finales:**
- Los finales son sobre PERTENENCIA, no supervivencia?
- Se siente que encontraste un lugar o que lo perdiste?
- Las decisiones anteriores tienen peso?

**Flujo:**
- Hay callejones sin salida?
- Las transiciones son suaves?
- La duracion es adecuada? (30-45 min ideal)

### Como Testear

**Testeo personal (continuo):**
- Jugar cada seccion al terminarla
- Tomar notas de fricciones
- Probar caminos alternativos
- Verificar que las variables cambien correctamente

**Testeo con otros (cuando este jugable):**
- 2-3 personas de confianza
- Observar sin intervenir
- Anotar donde se confunden
- Preguntar despues: que sentiste? te sentiste en peligro o en busqueda?

**Preguntas para testers:**
1. En algun momento te sentiste perdido?
2. Sentiste que el protagonista estaba por morir de hambre? (mal si si)
3. Sentiste que buscabas un lugar donde pertenecer? (bien si si)
4. Que personaje te importo mas?
5. El final te parecio justo?
6. Algo te saco del momento? (tono raro, bug, etc.)

### Iteracion

**Despues de cada sesion de testing:**
1. Priorizar problemas (critico/medio/menor)
2. Ajustar balance de energia si es necesario
3. Reescribir textos que dramatizan de mas
4. Agregar opciones donde faltan
5. Volver a testear

**Senales de que algo no funciona:**
- El tester cree que el protagonista esta por ser indigente
- El tester no entiende que puede ayudar en la olla
- El tester no se engancha con los NPCs
- El final sorprende negativamente

---

## 10. EXPORTAR A WEB

### Proceso de Exportacion

**Desde Inky:**
1. File -> Export for web
2. Inky genera una carpeta con:
   - `index.html` (template basico)
   - `[nombre].js` (tu historia compilada)
   - `ink.js` (runtime)

**Personalizar:**
- Editar `index.html` para estilo propio
- Agregar `style.css` para look & feel
- Modificar logica de UI si es necesario

### Estructura Web Propuesta

```html
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LA LLAMA</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div id="game">
        <header id="status">
            <!-- Barra de estado: energia, dia -->
        </header>

        <main id="story">
            <!-- El texto de la historia aparece aca -->
        </main>

        <nav id="choices">
            <!-- Las opciones aparecen aca -->
        </nav>
    </div>

    <script src="ink.js"></script>
    <script src="la-llama.js"></script>
    <script src="game.js"></script>
</body>
</html>
```

### CSS Sugerido (Estilo Terminal/Austero)

```css
/* style.css */

:root {
    --bg: #1a1a1a;
    --text: #e0e0e0;
    --accent: #ff6b35;
    --muted: #666;
    --choice-bg: #2a2a2a;
}

* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

body {
    background: var(--bg);
    color: var(--text);
    font-family: 'Courier New', monospace;
    font-size: 18px;
    line-height: 1.6;
    padding: 20px;
    max-width: 700px;
    margin: 0 auto;
}

#status {
    border-bottom: 1px solid var(--muted);
    padding-bottom: 10px;
    margin-bottom: 20px;
    font-size: 14px;
    color: var(--muted);
}

#story {
    margin-bottom: 30px;
}

#story p {
    margin-bottom: 1em;
}

#story h1 {
    color: var(--accent);
    font-size: 1.2em;
    margin: 1.5em 0 0.5em;
    text-transform: uppercase;
}

#choices {
    border-top: 1px solid var(--muted);
    padding-top: 20px;
}

#choices .choice {
    display: block;
    background: var(--choice-bg);
    padding: 15px;
    margin-bottom: 10px;
    cursor: pointer;
    border: 1px solid transparent;
    transition: border-color 0.2s;
}

#choices .choice:hover {
    border-color: var(--accent);
}

/* Tags especiales */
.tag-idea {
    color: var(--accent);
    font-style: italic;
}

.tag-fragmento {
    color: var(--muted);
    font-style: italic;
}
```

### JavaScript para UI (game.js)

```javascript
// game.js - Logica de UI para LA LLAMA

var story = new inkjs.Story(storyContent);
var storyContainer = document.getElementById('story');
var choicesContainer = document.getElementById('choices');
var statusContainer = document.getElementById('status');

function continueStory() {
    storyContainer.innerHTML = '';
    choicesContainer.innerHTML = '';

    while (story.canContinue) {
        var text = story.Continue();
        var tags = story.currentTags;

        var p = document.createElement('p');
        p.innerHTML = text;

        // Procesar tags
        tags.forEach(function(tag) {
            if (tag.startsWith('IDEA')) {
                p.classList.add('tag-idea');
            }
            if (tag === 'MIENTRAS DORMIS') {
                p.classList.add('tag-fragmento');
            }
            // Los headers son tags
            if (tag.match(/^[A-ZAEIOU\s-]+$/)) {
                var h1 = document.createElement('h1');
                h1.textContent = tag;
                storyContainer.appendChild(h1);
            }
        });

        storyContainer.appendChild(p);
    }

    // Mostrar opciones
    story.currentChoices.forEach(function(choice, index) {
        var button = document.createElement('button');
        button.classList.add('choice');
        button.textContent = choice.text;
        button.onclick = function() {
            story.ChooseChoiceIndex(index);
            continueStory();
        };
        choicesContainer.appendChild(button);
    });

    // Actualizar status
    updateStatus();

    // Scroll al inicio
    window.scrollTo(0, 0);
}

function updateStatus() {
    var energia = story.variablesState['energia'];
    var dia = story.variablesState['dia'];
    var dias = ['', 'LUNES', 'MARTES', 'MIERCOLES', 'JUEVES', 'VIERNES', 'SABADO', 'DOMINGO'];

    statusContainer.textContent = dias[dia] + ' | Energia: ' + energia;
}

// Iniciar
continueStory();
```

---

## 11. RECURSOS NECESARIOS

### Software

| Herramienta | Uso | Costo |
|-------------|-----|-------|
| Inky | Editor de Ink | Gratis |
| VS Code | Editor de texto (opcional) | Gratis |
| Extension Ink para VS Code | Sintaxis highlight | Gratis |
| Git | Control de versiones | Gratis |
| Navegador | Testing web | Gratis |

### Conocimiento

**Imprescindible:**
- Sintaxis basica de Ink (1-2 horas de tutorial)
- Entender variables y condicionales
- Saber escribir narrativa interactiva

**Util:**
- HTML/CSS basico (para personalizar web)
- JavaScript basico (para UI custom)
- Git (para no perder trabajo)

**Opcional:**
- Inkjs API (para funciones avanzadas)
- Web hosting (GitHub Pages, Itch.io, Netlify)

### Tiempo

| Tarea | Tiempo |
|-------|--------|
| Aprender Ink | 2-4 horas |
| Desarrollo del prototipo | 2-3 semanas |
| Testing y ajustes | 3-5 dias |
| Exportar y publicar | 1 dia |

**Total: ~3-4 semanas** para prototipo jugable y publicado

### Donde Aprender Ink

1. **Tutorial oficial:** https://www.inklestudios.com/ink/web-tutorial/
2. **Documentacion:** https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md
3. **Ejemplos en Inky:** File -> Open Example

---

## 12. SIGUIENTE PASO INMEDIATO

### Esta Semana

1. **Dia 1: Setup**
   - Descargar Inky
   - Crear carpeta del proyecto
   - Escribir `main.ink` y `variables.ink`
   - Compilar y verificar que funciona

2. **Dia 2-3: Miercoles (el corazon)**
   - Escribir la escena del despido
   - Tono: "Tengo 3 meses para resolver esto", no "me muero de hambre"
   - Probar decisiones: buscar laburo vs ayudar en olla vs procesar solo
   - Agregar fragmento de Sofia
   - Testear tono

3. **Dia 4-5: Expandir**
   - Agregar lunes y martes
   - Introducir NPCs
   - Primeras conexiones con la olla (como OBSERVADOR, no receptor)

### Comandos para Empezar

```bash
# Crear estructura de carpetas
mkdir la-llama-prototipo
cd la-llama-prototipo
mkdir npcs dias fragmentos finales web

# Crear archivos vacios
touch main.ink variables.ink ideas.ink utilidades.ink
touch npcs/sofia.ink npcs/elena.ink npcs/diego.ink
touch npcs/marcos.ink npcs/yulimar.ink npcs/walter.ink
touch dias/lunes.ink dias/martes.ink dias/miercoles.ink
touch dias/jueves.ink dias/viernes.ink dias/sabado.ink dias/domingo.ink
touch fragmentos/fragmentos.ink finales/finales.ink
```

### Primer Archivo: main.ink

```ink
// ============================================
// LA LLAMA - Prototipo "Cuando Todo Cae"
// ============================================

INCLUDE variables.ink
INCLUDE ideas.ink

INCLUDE npcs/sofia.ink
INCLUDE npcs/elena.ink
INCLUDE npcs/diego.ink
INCLUDE npcs/marcos.ink
INCLUDE npcs/yulimar.ink
INCLUDE npcs/walter.ink

INCLUDE dias/lunes.ink
INCLUDE dias/martes.ink
INCLUDE dias/miercoles.ink
INCLUDE dias/jueves.ink
INCLUDE dias/viernes.ink
INCLUDE dias/sabado.ink
INCLUDE dias/domingo.ink

INCLUDE fragmentos/fragmentos.ink
INCLUDE finales/finales.ink

// ============================================
// INICIO DEL JUEGO
// ============================================

# LA LLAMA

Una semana. Un despido. Una olla que se apaga.
Tenes indemnizacion. Tenes tiempo.
Lo que no tenes es un lugar.

Que vas a hacer cuando todo caiga?

* [Empezar]
    -> lunes.amanecer

-> END
```

---

## NOTAS FINALES

Este documento es un mapa, no un destino.

El prototipo va a cambiar mientras lo escribas. Las mecanicas van a ajustarse. Los textos van a reescribirse. Los NPCs van a sorprenderte.

Lo importante es mantener el tono correcto:
- El protagonista tiene colchon. No se muere de hambre.
- Su crisis es identitaria: quien soy sin laburo?
- Su relacion con la olla es de DAR tiempo, no de recibir comida.
- La tension es sobre PERTENECER, no sobre SOBREVIVIR.

Es mas Disco Elysium que This War of Mine.
Es clase media precarizada con ansiedad de futuro.
Es buscar un lugar cuando perdiste el que tenias.

Empeza por el miercoles. El dia del despido. El momento que rompe la identidad pero no la economia (todavia). Si ese dia funciona, el resto se construye alrededor.

Escribi en primera persona. Escribi como si le estuvieras contando a alguien. No expliques demasiado. Deja que el jugador sienta.

Y recorda: el objetivo no es que el jugador "sobreviva". Es que el jugador entienda que significar pertenecer a algo cuando todo lo demas se cae.

---

*Documento de implementacion para el prototipo de LA LLAMA.*
*Conflicto hibrido: "Cuando Todo Cae" (El Cierre + La Olla en Crisis)*
*Tecnologia: Ink (Inkle Studios)*
*Tono: Crisis identitaria y de pertenencia, no de supervivencia.*
