// ============================================
// UBICACION: LA OLLA POPULAR
// Escenas en la olla del barrio
// ============================================

// --- LLEGADA A LA OLLA ---

=== olla_llegada ===
// Llamar cuando el protagonista va a la olla

# LA OLLA

La olla del barrio.
El patio de la casa de la Chola. Una lona vieja sobre postes, mesas largas, ollas enormes sobre el fuego.
El olor a comida que se siente desde la esquina.

    Sofía está en el medio de todo.
    Coordinando, hablando, moviendo ollas.
    No para nunca.

{olla_en_crisis:
    Hay menos gente de lo habitual.
    Se nota la tensión en el aire.
- else:
    Hay movimiento. Gente cocinando, charlando, sirviendo.
    Es lo que siempre fue: el lugar donde el barrio se junta.
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

La gente. Vecinos, familias, pibes del barrio.
No es una fila de espera. Se habla. Se comparte.
Gente que conocés de vista, algunos de años.

{not tiene_laburo:
    Ahí está la red.
    La que ahora tenés tiempo de ver.
}

Una señora te mira.
"¿Venís a sumarte o a mirar nomás?"

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
~ registrar_ayuda()

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
    El ritmo de la olla es otro. Más humano.
}
{ pelada == -1:
    El cuchillo se resbala. Te cortás el dedo. La sangre gotea sobre una papa lavada.
    "¡Trapo!"
    Elena te venda rápido. Tiene práctica.
    "Tranquilo, pibe. A todos nos pasó alguna vez."
    Sentís la vergüenza arder más que el corte.
    ~ aumentar_inercia(1)
}

Las papas se acaban. Tus manos huelen a tierra y almidón.

* [Seguir ayudando] -> olla_ayudar_menu
* [Irte] -> olla_despedirse

=== olla_servir ===

~ energia -= 1
~ ayude_en_olla = true
~ registrar_ayuda()

Te ponés atrás de la mesa.
Cucharón en mano.

La gente avanza.
Platos, platos, platos.

* [...]
-

{es_vegano:
    Cada cucharón que servís te incomoda. 
    Huesos, grasa flotando.
    Pero esto no va de vos. 
    La olla es de todos, con lo que cada uno puede dar.
    Servís igual. Tus convicciones siguen ahí, intactas.
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
    Calculaste mal. Le diste mucho a los primeros, ahora tenés que equilibrar.
    Un señor te mira el cucharón.
    "¿Querés un poco más de pan?"
    "Dale, sí."
    Compensás como podés. El ritmo se aprende.
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
    Pero la mayoría son trabajadores como vos. Con laburo o sin él.
    Gente del barrio que viene a encontrarse tanto como a comer.
}

La fila se termina.

* [Seguir ayudando] -> olla_ayudar_menu
* [Irte] -> olla_despedirse

=== olla_limpiar ===

~ energia -= 1
~ ayude_en_olla = true
~ registrar_ayuda()

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

"¿Qué pasó? ¿Por qué está todo tan tranquilo?"

Sofía suspira.

"Las donaciones bajaron. El municipio anda lento con los trámites. Lo de siempre, pero peor."

* [...]
-

Mira las ollas.

"Hoy resolvemos, pero la semana que viene hay que ver."

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
// Llamar cuando hay problemas de recursos

# LA OLLA (complicada)

Llegás a la olla.
Está cerrada.

Un cartel en la puerta:
"HOY ABRIMOS MÁS TARDE. ESTAMOS RESOLVIENDO."

* [...]
-

~ olla_en_crisis = true

Hay gente esperando afuera.
Charlando. Algunos miran el celular.

* [...]
-

Vecinos del barrio.
Gente que viene a comer, pero también a encontrarse.
A estar un rato.

{not tiene_laburo:
    Vos tenés tres meses de colchón.
    Otros la reman mes a mes. Como siempre.
}

* [Quedarte un rato] -> olla_crisis_quedarse
* [Irte]
    Te vas.
    Capaz más tarde volvés.
    ->->

=== olla_crisis_quedarse ===

Te quedás.
No sabés para qué.

Sofía sale de la casa.
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
El patio de la olla lleno de gente.

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

Una señora: "En el laburo de mi marido están recortando horas. Menos plata pero las mismas cuentas."

Un tipo: "El kiosco de la esquina cerró. Nos queda uno solo en el barrio."

Otra señora: "La municipalidad no responde. Llamé veinte veces por el tema del alumbrado."

* [...]
-

Un pibe joven: "Hay que hacer algo. No podemos quedarnos esperando que las cosas mejoren solas."

Sofía: "Por eso estamos acá. Para decidir qué hacemos."

{not tiene_laburo:
    Pensás en tu propia situación.
    Tres meses de colchón.
    Estás mejor que muchos. Pero la precariedad es la misma.
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
Adelante tuyo, una señora con sus hijos.
Atrás, un vecino que viene siempre.

Se charla. Alguien hace un chiste.

* [...]
-

{not tiene_laburo:
    La olla es esto.
    Gente que viene a comer, pero también a estar.
    A ser parte de algo.
}

* [...]
-

Te toca.
Te dan un plato.
Guiso.

-> olla_comer_plato

=== olla_comer_plato ===

{not dieta_elegida:
    Mirás el plato que te sirven.
    
    * [Comés de todo.]
        ~ es_vegano = false
    * [Sos vegano.]
        ~ es_vegano = true
    
    - ~ dieta_elegida = true
}

Guiso.
Papas, carne (poca), verduras.

{es_vegano:
    El olor te genera un conflicto interno. 
    Años de convicción frente a un plato que no respeta tus principios.
    Pero viniste a estar, no solo a comer.

    * [Comer solo las verduras y el caldo]
        Apartás los trozos de carne con cuidado. 
        No es perfecto, pero es lo que hay.
        Sofía te ve y asiente. "La próxima hacemos algo aparte."
        -> olla_comer_sentarse
    * [Comer todo. Hoy no es el día para esto.]
        Cerrás los ojos y tragás. 
        Tus principios siguen ahí. Pero hoy elegís la comunidad.
        ~ aumentar_inercia(1)
        -> olla_comer_sentarse
    * [No comer. Pero quedarte.]
        Le pasás el plato a alguien que quiera repetir. 
        No viniste por la comida. Viniste por esto.
        Te quedás charlando un rato.
        -> olla_comer_sentarse
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
~ registrar_ayuda()
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

"La mamá de Sofía. Empezó en los 90, juntando a los vecinos a merendar."

Sofía asiente.

"Quince personas al principio. Lo que empezó como juntada terminó siendo esto."

* [...]
-

"En el 2002 creció mucho. De quince a ochenta vecinos. La Chola y Elena cocinaban turnándose."

Elena se ríe.

"Nos turnábamos para que nadie se quemara. Terminábamos cansadas pero contentas."

* [...]
-

"Después de la crisis, siguió siendo punto de encuentro. La Chola se puso vieja. Sofía estaba en España."

"Y después vino la pandemia", dice Sofía.

"Y se volvió más importante que nunca. El barrio se junta acá."

* [...]
-

Mirás el patio. La lona remendada, las mesas que vieron de todo.

"Todo esto lo armaron ustedes."

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

"La trajo de un viaje a México. Decía que era la patrona de los que luchan."

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

* [...]
-

Sofía mira las ollas. Hace una cuenta mental.

"Y lo que aporto yo de mi sueldo. Ocho mil, más o menos."

No lo dice con orgullo. Lo dice como quien cuenta los días de la semana.

"Es mi forma de ser parte. Todos ponemos algo."

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

// --- LA RED DE OLLAS ---

=== olla_red_coordinacion ===
// Escena sobre la coordinación entre ollas del barrio
// Trigger: después de ayudar 2+ veces, cuando Sofía o Elena mencionan "la red"

~ conoce_red_ollas = true
~ activar_red_sostiene()

# NOTIFICATION:positive:Idea: "La red sostiene"

"No estamos solas acá. Hay una red."

Sofía saca el celular. Muestra un grupo de WhatsApp con muchos mensajes.

"Mirá: nosotras abrimos lunes, miércoles y viernes. La olla del Marconi abre martes y jueves. La de Casabó, sábados."

* [...]
-

"Así nadie se queda sin comer ningún día. Nos pasamos información, insumos cuando sobra, gente cuando falta."

{elena_relacion >= 2:
    Elena, desde la cocina:
    "En el 2002 hacíamos lo mismo pero a los gritos y corriendo por la calle. Ahora hay WhatsApp."
}

"¿Y quién coordina todo eso?"

* [...]
-

"La Coordinadora. La CPS, le dicen. Pero al final somos todas viejas con celular y mala señal."

Sofía guarda el celular.

"A veces nos juntamos. Compartimos recetas, proveedores. Si una olla cierra, las otras absorben."

* ["¿Y si cierran todas?"]
    Sofía te mira.
    "No cierran todas. Nunca cerraron todas. Ni en el 2002."
    ~ subir_llama(1)
    ->->
* ["¿Cuántas ollas hay?"]
    "En el municipio, como veinte. En todo Montevideo, cientos. Nadie sabe exacto."
    ->->
* [Asentir]
    ->->

=== olla_momento_magico ===
// Escena especial: un día donde todo sale bien
// Trigger: veces_que_ayude >= 3 && d6() >= 5 && not vio_momento_magico

~ vio_momento_magico = true

Hoy algo es distinto.

La comida alcanzó exacta. La cola no fue larga. Los gurises jugaron en el patio mientras esperaban.

Nadie se quejó. Nadie se fue con hambre.

* [...]
-

Sofía se sienta un momento en el escalón de la casa. Cosa rara.

Te mira.

"A veces pasa esto."

* ["¿Qué cosa?"]
    -> momento_magico_explicacion
* [Sentarte a su lado]
    Te sentás. Ella sigue hablando sola.
    -> momento_magico_explicacion

=== momento_magico_explicacion ===

"Un día donde todo sale. La cantidad justa de gente, la comida que querías hacer, nadie peleó en la cola."

* [...]
-

Elena pasa con un balde vacío. Sonríe.

"Los días buenos", dice. "Hay que acordarse de estos."

* [...]
-

Sofía asiente.

"Son los días que te hacen seguir. Porque la mayoría no son así."

Se queda mirando el patio. La lona, las mesas, las ollas enfriándose.

"Hoy fue un día bueno."

* [...]
-

Por un rato, nadie habla de plata, ni de donaciones, ni de Claudia, ni de crisis.

Solo está el olor a comida que se va, y las voces de la gente yéndose a sus casas.

~ subir_llama(1)
~ subir_conexion(1)

->->

// --- RAMÓN Y LA VERDULERÍA ---

=== olla_ramon_encuentro ===
// Escena expandida: conocer a Ramón, el verdulero paraguayo
// Reemplaza/expande olla_verduleria_paraguayos

~ conocio_a_ramon = true

Es viernes.

Llega una camioneta vieja. Cajones de verdura en la caja.

Diego los descarga con un hombre morocho, de brazos gruesos y acento suave.

* [Acercarte a ayudar]
    Agarrás un cajón. Pesa.
    -> ramon_presentacion
* [Observar]
    -> ramon_presentacion

=== ramon_presentacion ===

"Te presento a Ramón", dice Diego. "De la verdulería."

Ramón asiente. No sonríe mucho. Tiene cara de cansado.

"Mucho gusto."

"Igualmente."

* [...]
-

Bajan los cajones. Zapallo, papa, cebolla. Todo un poco golpeado pero bueno.

"Esto iba a quedar", explica Ramón. "Mejor acá que en la basura."

* ["Gracias."]
    Ramón se encoge de hombros.
    "No es nada."
    -> ramon_historia
* [Seguir descargando]
    -> ramon_historia

=== ramon_historia ===

Sofía aparece. Le da un abrazo a Ramón.

"Gracias, como siempre."

"Como siempre."

* [...]
-

Ramón se va a la camioneta. Diego te habla bajito:

"Lleva dos años viniendo. Cada viernes, sin falta."

"¿Por qué ayuda?"

* [...]
-

Diego mira hacia la camioneta.

"Una vez le pregunté. Me dijo: 'Porque allá pasamos hambre también. Y acá me dieron de comer cuando llegué'."

* [...]
-

"Hay gente que lo putea en la calle. Le dicen cosas. 'Paragua de mierda', esas cosas."

Aprieta los puños.

"Pero él sigue viniendo. Cada viernes."

* ["Qué hijos de puta los que lo molestan."]
    "Sí. Pero él es más fuerte que todo eso."
    -> ramon_despedida
* [No decir nada]
    -> ramon_despedida

=== ramon_despedida ===

Ramón vuelve del camión con un último cajón. Más chico.

"Esto es aparte. Frutillas. Para los gurises."

Sofía se queda mirando el cajón. No dice nada.

* [...]
-

Ramón se sube a la camioneta. Saluda con la mano y se va.

No dijo casi nada.
Pero trajo comida para sesenta personas.
Y frutillas para los gurises.

~ subir_conexion(1)

->->

// --- ESCENA: SOFÍA HABLA DE LA RED ---

=== sofia_sobre_red ===
// Tunnel: Sofía explica la red de ollas
// Uso: -> sofia_sobre_red ->

{not conoce_red_ollas:
    -> olla_red_coordinacion ->
}

"La red es lo único que nos sostiene. Solas no duraríamos un mes."

->->

