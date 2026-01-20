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

{not conozco_a_marta:
    Hay una señora corpulenta dirigiendo todo.
    Marta. Todos la conocen.
    ~ conozco_a_marta = true
- else:
    Marta está ahí, como siempre.
}

{olla_en_crisis:
    Hay poca gente cocinando.
    Las ollas están casi vacías.
    Se nota la tensión.
- else:
    Hay movimiento. Gente cocinando, gente sirviendo.
    Funciona.
}

* [Acercarte a ayudar] # EFECTO:conexion+ -> olla_ofrecer_ayuda
* [Quedarte mirando] -> olla_observar
* {olla_en_crisis} [Preguntar qué pasa] # EFECTO:conexion? -> olla_preguntar_crisis
* [Irte] # EFECTO:conexion- -> olla_irse

=== olla_irse ===

Te vas.
Todavía no estás listo para esto.

->->

=== olla_observar ===

Te quedás mirando desde afuera.

La cola. Viejos, familias, pibes solos.
Gente del barrio. Gente que conocés de vista.
Gente que no esperabas ver acá.

{not tiene_laburo:
    ¿Cuánto falta para que te quedes sin red?
    Para que nadie te sostenga.

Una señora te mira.
"¿Vas a comer o a mirar?"

* [Ofrecer ayuda] -> olla_ofrecer_ayuda
* [Irte]
    "No, nada. Perdón."
    Te vas.
    ->->

=== olla_ofrecer_ayuda ===

"Disculpá, ¿necesitan una mano?"

Marta te mira de arriba abajo.

{veces_que_ayude == 0:
    "¿Sabés pelar papas?"
    "Sí."
    "Entonces vení."
- else:
    "Ah, volviste. Bien. Andá a {d6() >= 4: las papas|servir}."
}

-> olla_ayudar_menu

=== olla_ayudar_menu ===

# AYUDANDO EN LA OLLA

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

Hay una señora al lado tuyo. Elena, se llama. No la Sofía del barrio, otra Elena.

* [...]
-

{d6() >= 4:
    "¿Vos sos nuevo?"
    "Sí. Primera vez."
    "Ah. Está bien. Siempre hace falta gente."
    Pelás papas en silencio un rato.
    "Yo venía a comer. Ahora ayudo. Es mejor ser parte que mirar de afuera."
    No sabés qué decir.
    Seguís pelando.
- else:
    Pelás en silencio.
    A veces está bien no hablar.
}

Las papas se acaban.

* [Seguir ayudando] -> olla_ayudar_menu
* [Irte] -> olla_despedirse

=== olla_servir ===

~ energia -= 1
~ ayude_en_olla = true
~ veces_que_ayude += 1

Te ponés atrás de la mesa.
Cucharón en mano.

La cola avanza.
Platos, platos, platos.

* [...]
-

{d6() <= 2:
    Una nena te mira.
    "Más, por favor."

    El plato ya tiene lo que corresponde.
    Pero mirás para el costado y le ponés un poco más.

    Marta te ve pero no dice nada.
- else:
    Servís.
    Uno tras otro.
    Caras de cansancio, de hambre. De bronca, a veces.
}

{not tiene_laburo:
    Algunos te miran con agradecimiento.
    Otros no te miran.
    Vos estás de este lado del cucharón.
    Por ahora.
}

La cola se termina.

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
    Marta se acerca.
    "Gracias, pibe. Hacía falta."

    No es mucho.
    Pero se siente bien.
    ~ subir_conexion(1)
}

Terminás de limpiar.

* [Seguir ayudando] -> olla_ayudar_menu
* [Irte] -> olla_despedirse

=== olla_despedirse ===

"Me voy yendo."

{veces_que_ayude >= 2:
    Marta asiente.
    "Gracias por la mano. Volvé cuando quieras."

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

Marta suspira.

"No hay donaciones. La municipalidad nos clavó. El super que nos daba las verduras cerró."

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

Marta te mira.

"Todo suma, pibe. Todo suma."

* [Dar algo chico]
    Le das lo que tenés en el bolsillo.
    No es mucho.
    "Gracias."
    ->->
* [Dar algo más] # COSTO:1 # STAT:conexion
    Le das un billete más grande.
    ~ energia -= 1
    "Gracias. En serio."
    ~ subir_conexion(1)
    ->->
* [Pensarlo mejor]
    "Después te traigo algo."
    "Bueno."
    No suena convencida.
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

Marta sale del galpón.
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

Marta está al frente.

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

Marta: "Por eso estamos acá. Para decidir qué hacemos."

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

Marta asiente.

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

Marta te ve.

"Gracias por venir."

->->

// --- ESCENA ESPECIAL: COMIENDO EN LA OLLA ---

=== olla_comer ===
// Si el protagonista decide comer en la olla

# COMIENDO EN LA OLLA

{veces_que_ayude >= 2:
    Marta te ve.
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
    Tres meses de colchón.
    Después, ¿esto?
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
Comida de verdad.

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
~ subir_dignidad(-1)

Pero lo hacés.

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

Elena sirve café.
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
