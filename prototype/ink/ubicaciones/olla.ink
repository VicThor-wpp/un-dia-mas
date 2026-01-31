// ============================================
// UBICACION: LA OLLA POPULAR
// Escenas en la olla del barrio
// ============================================

// --- LLEGADA A LA OLLA ---

=== olla_llegada ===
// Llamar cuando el protagonista va a la olla

# LA OLLA

La olla popular del barrio.
Un galponcito con chapas, mesas largas, ollas enormes.
El olor a comida que se siente desde la esquina.

    Sofía está en el medio de todo.
    Coordinando, hablando, moviendo ollas.
    No para.

{olla_en_crisis:
    Hay poca gente cocinando.
    Las ollas están casi vacías.
    Se nota la tensión.
- else:
    Hay movimiento. Gente cocinando, gente sirviendo.
    Funciona.
}

* [Acercarte a ayudar] # EFECTO:conexion+
    -> olla_ofrecer_ayuda
* [Quedarte mirando] -> olla_observar
* {olla_en_crisis} [Preguntar qué pasa] # EFECTO:conexion?
    -> olla_preguntar_crisis
* [Irte] # EFECTO:conexion-
    -> olla_irse

=== olla_irse ===

Te vas.
Todavía no estás listo para esto.

->->

=== olla_observar ===

Te quedás mirando desde afuera.

La gente. Viejos, familias, pibes.
No es una fila de espera pasiva. Se habla. Se comparte.
Vecinos. Gente que conocés de vista.

{not tiene_laburo:
    Ahí está la red.
    La que te empieza a faltar a vos.
}

Una señora te mira.
"¿Vas a comer o a mirar?"

* [Ofrecer ayuda] -> olla_ofrecer_ayuda
* [Irte]
    "No, nada. Perdón."
    Te vas.
    ->->

=== olla_ofrecer_ayuda ===

"Disculpá, ¿necesitan una mano?"

Sofía te mira de arriba abajo.

{veces_que_ayude == 0:
    "¿Sabés pelar papas?"
    "Sí."
    "Entonces vení."
- else:
    "Ah, volviste. Bien. Metete en {d6() >= 4: las papas|el reparto}."
}

-> olla_ayudar_menu

=== olla_ayudar_menu ===

# AYUDANDO EN LA OLLA

// Evento Tiago (Fase 2)
{tiago_confianza == 0 && d6() >= 5:
    -> tiago_primer_encuentro ->
}

¿Qué hacés?

* [Pelar papas] # COSTO:1 # DADOS # EFECTO:conexion+
    -> olla_pelar_papas
* [Servir] # COSTO:1 # DADOS # EFECTO:conexion+
    -> olla_servir
* [Limpiar] # COSTO:1 # DADOS # STAT:conexion # EFECTO:conexion+
    -> olla_limpiar
* {energia <= 1} [Decir que te vas]
    -> olla_despedirse

=== olla_pelar_papas ===

~ energia -= 1
~ ayude_en_olla = true
~ veces_que_ayude += 1

Te sentás en un banquito con un balde de papas.
Pelás.

Hay una señora al lado tuyo. Es Elena, la veterana del barrio. No la habías visto en esta tarea antes, o quizás sí y no te dabas cuenta.

* [...]
-

// Chequeo comunitario: pelar papas en la olla
~ temp pelada = chequeo_comunitario(0, 3)
{ pelada == 2:
    Te sale natural. La cáscara sale en una tira larga, casi perfecta.
    Elena te mira de reojo. No sonríe, pero asiente.
    "Mi viejo pelaba así", dice. "En el 2002. Cuando tuvimos que cerrar el taller."
    Es la primera vez que menciona el taller. El cuchillo sigue moviéndose.
    Historias que se cuentan mirando para abajo.
    ~ subir_conexion(1)
}
{ pelada == 1:
    Pelás. El movimiento repetitivo calma algo en tu cabeza.
    Elena habla del precio del aceite. De que no alcanza.
    "Es cíclico", dice. "Cada diez años nos rompen las piernas. Y aprendemos a caminar de nuevo."
    Te pasa otra papa sin mirarte.
    "Aprendemos."
}
{ pelada == 0:
    Se te caen un par de papas. Tenés las manos torpes, desacostumbradas al trabajo manual.
    Elena las levanta sin decir nada. Las lava. Te las devuelve.
    "Despacio", dice. "Nadie nos corre."
    Pero el hambre sí corre.
}
{ pelada == -1:
    El cuchillo se resbala. Te cortás el dedo. La sangre gotea sobre una papa lavada.
    "¡Trapo!"
    Elena te venda rápido. Tiene práctica.
    "La sangre se lava. El hambre no", murmura alguien.
    Sentís la vergüenza arder más que el corte.
    ~ aumentar_inercia(1)
}

Las papas se acaban. Tus manos huelen a tierra y almidón.

* [Seguir ayudando] -> olla_ayudar_menu
* [Irte] -> olla_despedirse

=== olla_servir ===

~ energia -= 1
~ ayude_en_olla = true
~ veces_que_ayude += 1

Te ponés atrás de la mesa.
Cucharón en mano.

La gente avanza.
Platos, platos, platos.

* [...]
-

{es_vegano:
    Cada cucharón que servís te pesa. 
    Huesos, grasa flotando, restos de un sistema que rechazás.
    Pero la gente tiene hambre. 
    Y el hambre no entiende de especismo.
    Servís igual. Pero por dentro, algo se retuerce.
}

// Chequeo comunitario: servir en la olla
~ temp servicio = chequeo_comunitario(0, 3)
{ servicio == 2:
    El ritmo es perfecto. Cucharón, plato, sonrisa. Cucharón, plato, sonrisa.
    Ves una cara conocida. González. De contabilidad.
    Te ve. Baja la vista.
    Le servís un poco más de carne.
    Él asiente, rápido, y se va sin mirar atrás.
    La dignidad es un cristal frágil. Hoy vos lo cuidaste.
    ~ subir_conexion(1)
}
{ servicio == 1:
    Servís. Las manos se estiran. Manos curtidas, manos de oficina, manos de pibes.
    Una nena te da un dibujo a cambio del plato. Un sol negro.
    "Gracias", dice.
    Te guardás el dibujo en el bolsillo. Quema.
}
{ servicio == 0:
    Calculaste mal. Le diste mucho a los primeros, ahora tenés que escatimar.
    Un viejo te mira el cucharón medio vacío.
    "¿Eso es todo?"
    "Hay que estirar, abuelo."
    Te odiás por decir eso. Te odiás mucho.
}
{ servicio == -1:
    Se te vuelca el cucharón sobre la mesa.
    "¡Eh, cuidado!"
    Es comida caliente. Es comida que falta.
    Sofía viene con un trapo. No te reta. Su silencio es peor.
    "Tomate un respiro", te dice.
    Te apartás, con las manos temblando.
    ~ aumentar_inercia(1)
}

{not tiene_laburo:
    Del otro lado del mesón, las caras cambian.
    Pero los ojos son los mismos.
    Miedo.
    El mismo miedo que tenés vos cuando te despertás a las 4 de la mañana.
}

La fila se termina.

* [Seguir ayudando] -> olla_ayudar_menu
* [Irte] -> olla_despedirse

=== olla_limpiar ===

~ energia -= 1
~ ayude_en_olla = true
~ veces_que_ayude += 1

Limpiás.
Mesas, ollas, pisos.

El trabajo físico te vacía la cabeza.
Por un rato no pensás en nada.
Solo en la mugre y en sacarla.

* [...]
-

{d6() >= 5:
    Sofía está haciendo cuentas en una libreta.
    Muerde la lapicera.
    "No cierran", murmura. "Nunca cierran."
    Te ve limpiando. Cierra la libreta de golpe.
    "Dejá eso. Vení."
    Te da un mate. El termo ya perdió temperatura, pero es lo que hay.
    "Gracias por venir. La mayoría viene una vez, se saca la foto moral y no vuelve."
    Te mira fijo.
    "No desaparezcas."
    ~ subir_conexion(1)
}

Terminás de limpiar. El piso brilla, o eso te parece.

* [Seguir ayudando] -> olla_ayudar_menu
* [Irte] -> olla_despedirse

=== olla_despedirse ===

"Me voy yendo."

{veces_que_ayude >= 2:
    Sofía asiente.
    "Gracias por la mano. La olla es de todos."

    ~ subir_conexion(1)
- else:
    "Bueno. Gracias."
}

Salís de la olla.
El olor a comida te sigue un rato.

->->

// --- ESCENAS DE CRISIS ---

=== olla_preguntar_crisis ===

"¿Qué pasó? ¿Por qué tan vacío?"

Sofía suspira.

"No hay donaciones. El municipio se borró. El super cerró."

* [...]
-

Mira las ollas casi vacías.

"Hoy damos, pero mañana... no sé."

* [Ofrecer plata] -> olla_ofrecer_plata
* [Ofrecer ayuda] -> olla_ofrecer_ayuda_crisis
* [No decir nada]
    No sabés qué decir.
    Ella tampoco espera que digas nada.
    ->->

=== olla_ofrecer_plata ===

{not tiene_laburo:
    No tenés nada. Sin indemnización.
    Lo poco que tenés es lo que juntaste.
    Pero...
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
    // No cumplir promesas tiene costo
    ~ aumentar_inercia(1)
    ->->

=== olla_ofrecer_ayuda_crisis ===

"¿Qué puedo hacer?"

"Conseguir donaciones. Hablar con gente. Mover contactos."

{not tiene_laburo:
    Tenés tiempo, al menos.
}

"Hay una asamblea el viernes. Si querés venir..."

* [Decir que vas a ir]
    "Voy."
    "Bien."
    ->->
* [Decir que vas a ver]
    "Voy a ver si puedo."
    "Bueno."
    ->->

=== olla_crisis_sin_comida ===
// Llamar cuando la crisis es grave

# LA OLLA (en crisis)

Llegás a la olla.
Está cerrada.

Un cartel en la puerta:
"HOY NO HAY COMIDA. MAÑANA INTENTAMOS."

* [...]
-

~ olla_en_crisis = true

Hay gente parada afuera.
Mirando el cartel.
Sin saber qué hacer.

* [...]
-

Una señora con un nene.
Un viejo con bastón.
Dos pibes que no tienen más de 15.

{not tiene_laburo:
    Vos tenés tres meses de colchón.
    Ellos no tienen nada.
}

* [Quedarte un rato] -> olla_crisis_quedarse
* [Irte]
    Te vas.
    No hay nada que hacer.
    O sí, pero no sabés qué.
    ->->

=== olla_crisis_quedarse ===

Te quedás.
No sabés para qué.

Sofía sale del galpón.
Tiene los ojos rojos.

* [...]
-

"Mañana capaz que conseguimos algo. Hoy no hay."

La gente se va de a poco.
Vos te quedás.

* [...]
-

"¿Querés ayudar de verdad?"

"Sí."

"Entonces vení el viernes a la asamblea."

->->

// --- ASAMBLEA ---

=== olla_asamblea ===
// Llamar cuando hay asamblea en la olla

# ASAMBLEA EN LA OLLA

Viernes de noche.
El galpón de la olla lleno de gente.

No solo los que ayudan.
Vecinos.
Gente del barrio que nunca viste.

* [...]
-

Sofía está al frente.

"Bueno, gracias por venir. Esto es de todos. Hablamos todos."

~ participe_asamblea = true

* [Escuchar]
    -> olla_asamblea_escuchar
* [Hablar] # COSTO:1 # STAT:conexion
    -> olla_asamblea_hablar

=== olla_asamblea_escuchar ===

Escuchás.

Una señora: "Mi marido perdió el laburo. Somos cuatro. No llegamos."

Un tipo: "El kiosco de la esquina cerró. ¿Quién nos va a donar ahora?"

Otra señora: "La municipalidad no responde. Llamé veinte veces."

* [...]
-

Un pibe joven: "Hay que hacer algo. No podemos quedarnos esperando."

Sofía: "Por eso estamos acá. Para decidir qué hacemos."

{not tiene_laburo:
    Pensás en tu propia situación.
    Tres meses.
    No es nada comparado con esto.
    O es lo mismo, pero en cámara lenta.
}

-> olla_asamblea_propuestas

=== olla_asamblea_hablar ===

~ energia -= 1

Levantás la mano.

"Yo... hace poco perdí el laburo. No estoy en la misma que ustedes, todavía. Pero quiero ayudar."

* [...]
-

La gente te mira.

Sofía asiente.

"Todo el mundo aporta lo que puede. Eso está bien."

~ subir_conexion(1)

-> olla_asamblea_propuestas

=== olla_asamblea_propuestas ===

Se discuten propuestas.

"Hay que hacer una colecta."
"Hay que ir a la municipalidad."
"Hay que hablar con los comercios que quedan."
"Hay que organizarse mejor."

* [...]
-

{d6() >= 4:
    Al final, algo se decide.
    Un plan. Tareas.
    Vos te anotás para algo.

    ~ ayude_en_olla = true
- else:
    Al final, no se decide mucho.
    Pero algo se mueve.
    Al menos la gente habló.
}

La asamblea termina.
La gente se va de a poco.

Sofía te ve.

"Gracias por venir."

->->

// --- ESCENA ESPECIAL: COMIENDO EN LA OLLA ---

=== olla_comer ===
// Si el protagonista decide comer en la olla

# COMIENDO EN LA OLLA

{veces_que_ayude >= 2:
    Sofía te ve.
    "¿Hoy comés?"

    * [Sí]
        "Sí."
        "Sentate."
        -> olla_comer_plato
    * [No, solo vine a ayudar]
        "No, vine a ayudar nomás."
        "Bueno. Vení."
        -> olla_ayudar_menu
- else:
    Hacés la cola.
    Como todos.
    -> olla_comer_cola
}

=== olla_comer_cola ===

La cola.
Adelante tuyo, una señora con tres pibes.
Atrás, un viejo solo.

Nadie habla.

* [...]
-

{not tiene_laburo:
    ¿Es esto tu futuro?
    Quizás.
    Pero si es esto, al menos no estás solo.
}

* [...]
-

Te toca.
Te dan un plato.
Guiso.

-> olla_comer_plato

=== olla_comer_plato ===

Guiso.
Papas, carne (poca), verduras.

{es_vegano:
    El olor a grasa te revuelve el estómago. 
    Años de convicción frente a un plato caliente que no respeta tus principios.
    Pero es lo que hay. O comés, o seguís vacío.

    * [Comer solo el caldo y las verduras]
        Apartás los trozos de carne con cuidado. 
        El caldo sabe a animal, pero el hambre es más fuerte que el asco.
        Te sentís sucio, pero un poco más lleno.
        ~ aumentar_inercia(1)
        -> olla_comer_sentarse
    * [Comer todo. El hambre no tiene ética.]
        Cerrás los ojos y tragás. 
        La carne es blanda, fibrosa. 
        Tus principios se disuelven en el ácido gástrico.
        ~ aumentar_inercia(1)
        ~ bajar_dignidad(1)
        -> olla_comer_sentarse
    * [No comer. La ética es lo único que me queda.]
        Dejás el plato sobre la mesa. 
        No podés. 
        Preferís el rugido del estómago al silencio de la conciencia.
        ~ subir_dignidad(1)
        ~ energia -= 1
        -> olla_despedirse
- else:
    Comida de verdad.
    -> olla_comer_sentarse
}

=== olla_comer_sentarse ===

Te sentás en una mesa larga.
Comés.

* [...]
-

{d6() >= 4:
    Alguien al lado tuyo te habla.
    "¿Primera vez?"
    "Sí."
    "Está bien la comida."
    "Sí."
    No dicen más.
    Pero es algo.
}

Terminás de comer.

->->

// --- AMBIENTE NORMAL ---

=== olla_ambiente_normal ===
// Tunnel para el ambiente normal de la olla
// Llamar: -> olla_ambiente_normal ->

La olla funcionando.

Ollas en el fuego.
Gente preparando.
El olor a comida.

Lo de siempre.
Pero hay tensión.
Se nota en las caras.

->->

// --- AYUDAR EN COCINA ---

=== olla_ayudar_cocina ===
// Tunnel para ayudar en la cocina
// Llamar: -> olla_ayudar_cocina ->

Te ponés a ayudar.

Pelás papas.
Cortás verduras.
Revolvés la olla.

* [...]
-

No es difícil.
Pero es necesario.

~ ayude_en_olla = true
~ veces_que_ayude += 1
~ subir_conexion(1)

->->

// --- ESCUCHAR CRISIS ---

=== olla_escuchar_crisis ===
// Tunnel para escuchar sobre la crisis
// Llamar: -> olla_escuchar_crisis ->

"No hay para mañana."

Sofía lo dice bajito.
Pero todos escuchan.

* [...]
-

"Las donaciones no llegan."
"El municipio no contesta."
"Los comercios ya no dan."

~ olla_en_crisis = true

* [...]
-

Silencio.
¿Qué se hace?

->->

// --- AMBIENTE CRISIS ---

=== olla_ambiente_crisis ===
// Tunnel para el ambiente de crisis
// Llamar: -> olla_ambiente_crisis ->

La olla está distinta hoy.

Menos movimiento.
Más caras largas.

Se siente la tensión.
Algo no está bien.

{olla_en_crisis:
    Ya sabés lo que es.
    No hay recursos.
}

->->

// --- COLECTA CALLEJERA ---

=== olla_colecta_callejera ===
// Tunnel para hacer colecta en la calle
// Llamar: -> olla_colecta_callejera ->

# LA COLECTA

Salís a la calle.
A pedir.

Es difícil.
Pararte en una esquina.
Explicar.
Pedir.

* [...]
-

~ energia -= 1
~ subir_dignidad(1)
~ subir_llama(1)

Pero lo hacés.
No bajás la cabeza. Mirás a los ojos.
Esto es trabajo digno. Es sostener.

* [...]
-

Algunos dan.
La mayoría no.
Pero algunos sí.

~ subir_llama(1)

->->

// --- PEDIR A VECINOS ---

=== olla_pedir_vecinos ===
// Tunnel para pedir comida a vecinos
// Llamar: -> olla_pedir_vecinos ->

# PUERTA A PUERTA

Vas por las casas.
Golpeando puertas.
Pidiendo comida.

"Lo que tengan. Una papa. Un tomate."

~ energia -= 1

{d6() >= 3:
    Algunos dan.
    Una bolsa acá, otra allá.
    Se junta algo.
    ~ subir_conexion(1)
}

{d6() < 3:
    Pocas puertas se abren.
    La gente también está mal.
}

->->

// --- RESULTADO COLECTA ---

=== olla_resultado_colecta ===
// Tunnel para el resultado de la colecta
// Llamar: -> olla_resultado_colecta ->

Vuelven todos.
Se cuenta lo que hay.

{d6() >= 4:
    "Algo juntamos."
    No es mucho.
    Pero es algo.
    ~ subir_llama(1)
}

{d6() < 4:
    "No alcanza."
    Pero hay que cocinar igual.
    Con lo que hay.
}

->->

// --- PREPARAR ASAMBLEA ---

=== olla_preparar_asamblea ===
// Tunnel para la preparación de la asamblea
// Llamar: -> olla_preparar_asamblea ->

La olla se prepara para la asamblea.

Sillas en círculo.
Termo de café.
Papeles con números.

Hoy se habla de todo.
De cómo seguir.
De si se puede seguir.

->->

// --- INICIO ASAMBLEA ---

=== olla_asamblea_inicio ===
// Tunnel para el inicio de la asamblea
// Llamar: -> olla_asamblea_inicio ->

# LA ASAMBLEA

~ participe_asamblea = true

La gente se sienta.
Sofía abre.

"Bueno. Estamos todos los que estamos."
"Gracias por venir."

* [...]
-

Elena ceba mate. La ronda empieza.
Alguien trae bizcochos.

"Hay que hablar de cómo seguimos."

->->

// --- DISCUSION ASAMBLEA ---

=== olla_asamblea_discusion ===
// Tunnel para la discusión de la asamblea
// Llamar: -> olla_asamblea_discusion ->

La discusión empieza.

Ideas van y vienen:
- "Hacer más colectas."
- "Buscar comercios nuevos."
- "Ir al municipio de vuelta."
- "Organizar una feria."

* [...]
-

Nadie tiene la respuesta.
Pero todos buscan.

->->

// --- MOMENTO COLECTIVO EN ASAMBLEA ---

=== asamblea_momento_colectivo ===
// Tunnel: El momento donde la comunidad actua como unidad
// Llamar desde la escena de asamblea del sabado: -> asamblea_momento_colectivo ->

Sofía pide silencio.

"Bueno. Ya saben por qué estamos acá."

Mira alrededor. A las caras cansadas. A los números que no cierran.

"Tenemos que decidir."

* [...]
-

Silencio.

Nadie quiere ser el primero.

# PAUSA

Entonces Elena se para.

-> elena_habla_asamblea ->

-> asamblea_votacion ->

-> asamblea_canto ->

->->

=== elena_habla_asamblea ===
// Tunnel: Elena habla en la asamblea

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

->->

=== asamblea_votacion ===
// Tunnel: La votacion en la asamblea

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
// Las manos suben en la votacion

Las manos suben.

No todas. Pero suficientes.

{ixchel_relacion >= 2:
    Ixchel no levanta la mano. Pero asiente. En su cultura, el consenso se muestra distinto.
}

Sofía cuenta.

"Mayoría. Seguimos."

# PAUSA

Y entonces, no sabés quién empieza, alguien tararea.

->->

=== asamblea_canto ===
// Tunnel: El canto colectivo

Es una murga vieja. De las que cantaban en el 2002.

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
// Cierre del momento del canto

No dura mucho.

Se apaga solo, como empezó.

Pero por un momento, algo pasó.

# PAUSA

No es una victoria.
No es una solución.

Pero es algo que no se puede poner en una planilla.

->->

// --- FIN ASAMBLEA ---

=== olla_asamblea_fin ===
// Tunnel para el fin de la asamblea
// Llamar: -> olla_asamblea_fin ->

La asamblea termina.

No hay solución mágica.
Pero hay un plan.
Más o menos.

* [...]
-

La gente se va yendo.
Algunos se quedan a limpiar.

"Gracias por venir", dice Sofía.

~ subir_conexion(1)

->->

// --- CERRAR NOCHE ---

=== olla_cerrar_noche ===
// Tunnel para cerrar la olla de noche
// Llamar: -> olla_cerrar_noche ->

La olla cierra.

Las ollas vacías.
Las mesas limpias.
Las luces se apagan.

* [...]
-

Sofía es la última en irse.
Siempre.

Mañana hay que volver a empezar.

->->

// --- ECO: ELENA RECUERDA ---

=== viernes_olla_elena_eco ===
// Tunnel: Elena recuerda si te conto su historia
// Llamar: -> viernes_olla_elena_eco ->

{elena_conto_historia:
    Elena te ve llegar.
    "Viniste."
    No es sorpresa.
    Es algo más.
    Como si hubiera esperado que vinieras.
    Como si la historia del 2002 hubiera funcionado.
    ~ elena_relacion += 1
}

->->

// --- HISTORIA FUNDACIONAL DE LA OLLA ---

=== olla_historia_fundacion ===
// La historia de cómo empezó la olla

~ escuche_historia_olla = true

Elena está sentada en un rincón.
Sofía revuelve la olla.
Hay un momento de calma.

"¿Cómo empezó todo esto?", preguntás.

Elena y Sofía se miran.

"La Chola", dicen las dos al mismo tiempo.

* [...]
-

Elena habla primero.

"La mamá de Sofía. Empezó en los 90, dando merienda a los gurises en su casa."

Sofía asiente.

"Quince porciones. Con lo que había. Nada más."

* [...]
-

"En el 2002 explotó. De quince a ochenta porciones. La Chola y Elena cocinaban turnándose."

Elena se ríe.

"Terminábamos a las cuatro de la mañana. Y a las siete ya estábamos pelando de nuevo."

* [...]
-

"Después de la crisis, bajó un poco. Veinte, treinta porciones. La Chola se puso vieja. Sofía estaba en España."

"Y después vino la pandemia", dice Sofía.

"Y de treinta pasamos a cien. Y acá estamos."

* [...]
-

Mirás el galponcito. Las paredes de bloque, el techo de chapa.

"Todo esto lo construyeron ustedes."

"Entre todos", corrige Elena. "Nunca nadie solo."

~ subir_conexion(1)

->->

=== olla_virgen_guadalupe ===
// La imagen de la Virgen

Notás una imagen en la pared.
La Virgen de Guadalupe. Colores vivos. Flores dibujadas alrededor.

"La puso la Chola", dice Sofía sin que preguntes.

* [...]
-

"La trajo de un viaje a México. Decía que era la patrona de los pobres."

"¿Vos creés en eso?"

* [...]
-

Sofía se encoge de hombros.

"Creo en lo que funciona. Y esa imagen lleva ahí veinte años. La gente la mira cuando entra. Algunos rezan. Otros no. Pero todos la ven."

* [...]
-

Mirás la imagen.
Morena, con rayos dorados.
Parece vigilar todo.

{ixchel_me_conto_de_tomas:
    Pensás en Ixchel.
    Ella también tiene una estampita de la Virgen.
    La misma Virgen en dos continentes.
    La misma lucha.
}

->->

=== olla_grupo_whatsapp ===
// El grupo de WhatsApp

El celular de Sofía no para de sonar.

"El grupo", explica. "Ahí coordinamos todo."

"¿Cuántos son?"

"Ocho. Los que siempre estamos."

* [...]
-

"Diego avisa cuando consigue donaciones. Yo anoto quién trae qué. Las vecinas confirman si pueden venir."

"¿Y Elena?"

* [...]
-

Sofía se ríe.

"Elena no tiene WhatsApp. Dice que es 'para pendejos'. Yo le cuento todo."

"¿Y funciona?"

"Más o menos. A veces los mensajes se pierden. A veces la gente no lee. Pero es mejor que nada."

->->

// --- ECONOMÍA COLECTIVA ---

=== olla_sobre_donaciones ===
// Cómo funcionan las donaciones

"¿De dónde sale todo esto?", preguntás mirando las ollas, los cajones de verdura.

Sofía cuenta con los dedos.

"El Plan ABC de la Intendencia. Insumos básicos: arroz, fideos, aceite. Pero llega irregular."

* [...]
-

"Don Rubén, del almacén de la esquina. Nos da lo que está por vencer. Y a veces algo más."

"La verdulería de los paraguayos. Dejan cajones los viernes."

* [...]
-

"Vecinos que aportan. Desde cien pesos hasta dos mil. Todo va a una caja que administra Elena."

"¿Y vos?"

* [...]
-

Sofía duda.

"Yo pongo entre diez y quince mil por mes. Más cuando hay emergencias."

"Eso es mucho."

"Sí. Pero no alcanza para mantenerlo sola. Esto es colectivo o no es."

~ subir_conexion(1)

->->

=== olla_don_ruben ===
// El almacenero Don Rubén

Llega un hombre mayor cargando bolsas.

"Don Rubén", lo saluda Sofía. "Gracias."

"De nada, m'hija. Esto iba a la basura pero todavía está bueno."

* [...]
-

Don Rubén se va.

"Siempre nos ayuda", dice Sofía. "Desde el 2002."

"¿Por qué?"

* [...]
-

"Dice que él también estuvo en la cola cuando era chico. En otra olla, en otro barrio. Ahora le toca dar."

"Qué grande."

"Es el barrio. Así funciona. Los que pueden dan, los que necesitan reciben. Y a veces es lo mismo."

->->

=== olla_verduleria_paraguayos ===
// La verdulería de los paraguayos

Es viernes.
Llegan cajones de verdura.

"De la verdulería de los paraguayos", explica Diego. "Siempre los viernes."

* [...]
-

"¿Por qué ayudan?"

"Porque son de acá también. Aunque algunos no los vean así."

* [...]
-

Diego baja la voz.

"A veces los molestan. Les dicen cosas. Pero siguen viniendo, siguen donando."

"Qué hijos de puta los que los molestan."

"Sí. Pero ellos son más fuertes que eso."

~ subir_conexion(1)

->->

=== olla_plan_abc ===
// El Plan ABC de la Intendencia

Sofía revisa unas cajas.

"El Plan ABC llegó", anuncia.

"¿Qué es?"

* [...]
-

"El plan de la Intendencia de Montevideo. Nos dan insumos: arroz, fideos, aceite. A veces lentejas."

"¿Y alcanza?"

* [...]
-

Sofía se ríe sin gracia.

"Alcanza para un día y medio. Y llega una vez por mes. Cuando llega."

"¿Cómo que cuando llega?"

* [...]
-

"A veces se demoran. A veces falta algo. Una vez nos mandaron arroz para tres meses pero nada de aceite. ¿Qué hacés con arroz sin aceite?"

Suspira.

"Pero es algo. Más de lo que teníamos antes de 2020."

->->

=== olla_caja_elena ===
// La caja que administra Elena

Elena saca una caja de lata de debajo de la mesa.

"La caja", dice.

"¿Qué tiene?"

* [...]
-

"Los aportes de los vecinos. Los que pueden, ponen algo. Cien pesos, quinientos, lo que tengan."

Abre la caja. Billetes doblados, monedas, un papelito con anotaciones.

* [...]
-

"Todo se anota. Yo llevo la cuenta acá, Sofía tiene un backup en el celular."

"¿Y cuánto hay?"

Elena cuenta.

"Mil trescientos. Alcanza para una garrafa y algo de verdura."

* [...]
-

Cierra la caja.

"No es mucho. Pero es nuestro. Nadie nos lo regaló."

~ subir_conexion(1)

->->

