// ============================================
// MIÉRCOLES - EL DESPIDO
// Routing con tunnels, contenido específico del día
// ============================================

=== miercoles_amanecer ===

~ dia_actual = 3
~ energia = 3  // La tensión te afecta

# MIÉRCOLES

// Despertar - contenido específico del miércoles
No dormiste bien.
Hoy es la reunión con RRHH.

* [...]
-

-> casa_despertar ->

{energia < 4: Te levantás con menos energía que ayer. La tensión se siente en el cuerpo.}

* [...]
-

El café no calienta igual, o vos no sentís el calor igual.

Sabés que algo viene. No sabés qué.

* [Ir al laburo] -> miercoles_laburo

=== miercoles_laburo ===

-> bondi_esperar_parada ->

-> laburo_llegada ->

// Contenido específico: la tensión antes de la reunión
Llegás. Todo parece normal.
Los compañeros hacen lo de siempre.
Pero hay algo en el aire.

* [...]
-

El jefe no te mira. Eso es raro.

A las 11 te llaman.

* [Ir a la reunión] -> miercoles_reunion

=== miercoles_reunion ===

# LA REUNIÓN

// El despido - contenido específico del miércoles
// Usamos el módulo de laburo para la mecánica del despido
-> laburo_despido ->

// Chequeo mental: encajar el golpe del despido
~ temp golpe = chequeo_mental(0, 4)
{ golpe == 2:
    Algo en vos se endurece. No se quiebra. Se endurece.
    "Esto no me define", pensás. Y por ahora, lo creés.
    ~ pequenas_victorias += 1
}
{ golpe == 1:
    Respirás. Tragás. Seguís caminando.
    No está bien, pero podés con esto. Ahora.
}
{ golpe == 0:
    El pasillo se siente largo. Las piernas pesan.
    La cabeza repite: "tu puesto fue afectado."
    Fue. Afectado. Como si fuera algo que pasó solo.
}
{ golpe == -1:
    Se te nubla la vista. Tenés que parar en el baño.
    Te mirás al espejo. No te reconocés.
    Las manos tiemblan. El aire no entra bien.
    ~ aumentar_inercia(1)
}

// Después del despido, contenido específico
Alguien te dice "suerte" sin mirarte a los ojos.

Salís.

* [Ir a la calle] -> miercoles_salida

=== miercoles_salida ===

-> laburo_salida_despedido ->

-> miercoles_flashback ->

// La idea involuntaria se activa
{idea_quien_soy:
    # IDEA: "¿QUIÉN SOY SIN LABURO?"

    No la elegiste. Llegó sola.
    La empresa te convenció de que eras un "socio estratégico".
    Ahora sos solo un número que ya no suma.

    La pregunta quema. ¿Sos lo que hacés o lo que sos cuando nadie te paga?
}

// Chequeo temprano: el despido puede destruirte
-> check_game_over ->

¿Qué hacés?

* [Ir a casa a procesar] # COSTO:1 # EFECTO:conexion-
    -> miercoles_casa
* [Caminar sin rumbo] # COSTO:1
    -> miercoles_caminar
* [Ir al barrio, buscar a alguien] # EFECTO:conexion+
    -> miercoles_barrio

=== miercoles_flashback ===

Salís del edificio.
El sol pega.
Es mediodía.

* [...]
-

{perdida == "familiar":
    Por un segundo, ves a tu vieja en la calle.
    No es ella. No puede ser.
    Pero por un segundo...
    Recordás cuando te dijo:
    "Mientras tengas laburo, estás bien."
    Ya no tenés laburo.
    El fantasma se desvanece.
}

{perdida == "relacion":
    Pensás en llamar a alguien.
    Por un segundo, tu dedo va al contacto.
    Todavía está ahí.
    No lo borraste.
    No llamás.
    Pero por un segundo, quisiste.
}

{perdida == "futuro":
    Recordás cuando tenías un plan.
    Ibas a ser algo.
    Tenías una forma.
    Ahora no hay forma.
    Solo hay esto.
    Un mediodía, sin laburo.
}

{perdida == "vacio":
    Hay algo.
    No sabés qué.
    Ese vacío que siempre estuvo.
    Ahora más grande.
    O quizás siempre fue así de grande.
    Y recién ahora lo ves.
}

->->

=== miercoles_casa ===

~ energia -= 1

-> casa_dia_libre ->

// Contenido específico: la casa vacía a las 12
Llegás a casa.
La casa vacía a las 12 del mediodía.
Nunca la viste así a esta hora.

* [...]
-

Te sentás.
No prendés la tele.
No hacés nada.

Solo te sentás.

{energia <= 1: Estás destruido. No podés hacer nada más hoy.}

* {energia > 1} [Llamar a alguien] -> miercoles_llamar
* [Quedarte ahí] -> miercoles_noche

=== miercoles_caminar ===

~ energia -= 1

Caminás.
No sabés bien a dónde.
Las calles de siempre pero distintas.

* [...]
-

Porque ahora tenés tiempo.
Demasiado tiempo.

Pasás por la plaza.

* [...]
-

El tipo que duerme en el banco sigue ahí.
Lo viste mil veces. Hoy lo mirás diferente.

No estás como él. Tenés tres meses.
Pero la distancia se siente más corta.

* [Seguir caminando] -> miercoles_barrio
* [Ir a casa] -> miercoles_casa

=== miercoles_barrio ===

El barrio.
Tu barrio.

A esta hora hay gente.
Gente que no ves normalmente porque estás laburando.

* [...]
-

Sofía está saliendo de su casa.
Te ve.

* [Acercarte] # STAT:conexion # EFECTO:conexion+
    -> miercoles_sofia
* [Evitarla, seguir de largo] # EFECTO:conexion-
    -> miercoles_evitar

=== miercoles_evitar ===

~ bajar_conexion(1)

Bajás la cabeza.
Seguís de largo.
No querés hablar con nadie.

Pero Sofía te vio.
Y vos la viste ver.

* [Ir a casa] -> miercoles_noche

=== miercoles_sofia ===

"¿Qué hacés acá a esta hora? ¿No tenías laburo?"

La pregunta pega.

* [Contar lo que pasó] # STAT:conexion # EFECTO:conexion+
    -> miercoles_contar
* [Evadir: "Salí temprano hoy"] # EFECTO:conexion-
    -> miercoles_evadir

=== miercoles_evadir ===

"Salí temprano hoy."

Sofía te mira.
No te cree, pero no insiste.

"Bueno. Si necesitás algo..."

Deja la frase ahí.

~ conte_a_alguien = false

* [Ir a casa] -> miercoles_noche

=== miercoles_contar ===

~ conte_a_alguien = true
~ subir_conexion(1)

"Me echaron."

Sofía no dice nada por un momento.
Después:

"Mierda."

"Sí."

"¿Estás bien?"

"No sé."

// Chequeo social: abrirte con alguien después del golpe
~ temp abrirse = chequeo_social(0, 3)
{ abrirse == 2:
    Se queda un rato. No dice nada esperanzador, no dice que todo va a estar bien.
    Pero algo en su silencio te sostiene. Sentís que podés con esto.
    ~ subir_conexion(1)
}
{ abrirse == 1:
    Se queda un momento. No te abraza, no te dice que todo va a estar bien.
    Eso lo agradecés.
}
{ abrirse == 0:
    Se queda un momento. Pero se nota que tiene la cabeza en otro lado.
    La olla, los pibes, todo lo que la aplasta a ella también.
}
{ abrirse == -1:
    Se te quiebra la voz. Mierda. No querías llorar.
    Sofía te mira. No dice nada. Esperás que no le cuente a nadie.
    ~ aumentar_inercia(1)
}

* [...]
-

"Mirá, la olla anda complicada, pero si querés venir a dar una mano... a veces ayuda hacer algo."

* [Decir que sí] # STAT:conexion # EFECTO:conexion+ # EFECTO:llama+
    -> miercoles_si_olla
* [Decir que no sabés] # EFECTO:conexion-
    -> miercoles_nosabe_olla
* [Preguntar qué pasa con la olla]
    -> miercoles_pregunta_olla

=== miercoles_pregunta_olla ===

"¿Qué pasa con la olla?"

Sofía suspira.

"No tenemos para el viernes. Las donaciones bajaron. Estamos viendo qué hacer."

~ olla_en_crisis = true

Otra cosa que cae.
Todo cae junto.

* [Ofrecer ayuda] # EFECTO:conexion+ # EFECTO:llama+
    -> miercoles_si_olla
* [Decir que no sabés si podés] # EFECTO:conexion-
    -> miercoles_nosabe_olla

=== miercoles_si_olla ===

~ subir_conexion(1)
~ subir_llama(1)

"Puedo venir. Ahora tengo tiempo."

Sofía medio sonríe.
No es una sonrisa feliz.
Es una sonrisa de "al menos algo".

"Mañana a la tarde estamos. Si te da."

Asiente y se va.
Tenés algo para mañana.
No es mucho. Pero es algo.

* [Ir a casa] -> miercoles_noche

=== miercoles_nosabe_olla ===

"No sé si puedo. Tengo que... no sé."

Sofía asiente.

"Obvio. Si necesitás algo, avisá."

Se va.

Te quedás solo.

* [Ir a casa] -> miercoles_noche

=== miercoles_llamar ===

¿A quién llamás?

* {vinculo == "sofia"} [A Sofía] -> miercoles_llamar_sofia
* {vinculo == "elena"} [A Elena] -> miercoles_llamar_elena
* {vinculo == "diego"} [A Diego] -> miercoles_llamar_diego
* {vinculo == "marcos"} [A Marcos] -> miercoles_llamar_marcos
* [A nadie. Mejor no.] -> miercoles_noche

=== miercoles_llamar_elena ===

~ subir_conexion(1)
~ conte_a_alguien = true

Elena contesta al segundo ring.

"¿Qué pasó?"

Le contás. Ella escucha.
Cuando terminás, hay silencio.

* [...]
-

"En el 2002 cerraron el frigorífico donde laburaba Raúl."

Raúl era su marido.

* [...]
-

"Tres meses estuvo sin laburo. Yo trabajaba limpiando. Los pibes eran chicos. La olla del barrio nos salvó ese invierno."

"No sabía."

"No lo contamos mucho. Pero pasó. Y acá seguimos."

* ["¿Cómo hicieron?"] -> miercoles_elena_como
* ["Gracias por contarme."] -> miercoles_elena_gracias

=== miercoles_elena_como ===

"¿Cómo hicieron?"

"Juntos. No había otra. La gente se juntó. Los que tenían compartían con los que no. No fue lindo. Pero fue lo que hubo."

~ idea_red_o_nada = true

# IDEA DISPONIBLE: "LA RED O LA NADA"

Es una idea heredada. De Elena. De Raúl. De los que estuvieron antes.

* [Internalizar]
    ~ idea_red_o_nada = true
    La internalizás. La red o la nada.
    No es optimismo. Es lo único que hay.
    -> miercoles_elena_fin
* [Dejar pasar]
    -> miercoles_elena_fin

=== miercoles_elena_gracias ===

"Gracias por contarme."

"Para eso estamos."

-> miercoles_elena_fin

=== miercoles_elena_fin ===

Cortás.
Te sentís un poco menos solo.

* [Ir a la noche] -> miercoles_noche

=== miercoles_llamar_sofia ===

~ subir_conexion(1)
~ conte_a_alguien = true

Llamás a Sofía. Contesta enseguida, de fondo se escuchan los pibes gritando.

"Hola. ¿Todo bien?"

Le contás. La reunión, el despido, el frío en el pecho.

"Puta madre. Lo siento mucho, de verdad."

Pausa. Se escucha que le dice a uno de los hijos que se baje de la mesa.

"Mirá, hoy estamos a mil, pero mañana venite a la olla. A veces lo mejor es tener las manos ocupadas para que la cabeza no piense tanto."

* ["Voy a ir."] -> miercoles_si_olla
* ["No sé si puedo."] -> miercoles_nosabe_olla

=== miercoles_llamar_diego ===

~ subir_conexion(1)
~ conte_a_alguien = true

Diego contesta.

"¿Hola?"

"Diego, soy yo."

"¿Qué onda? ¿No estás laburando?"

Le contás.

"La puta madre."

"Sí."

"¿Estás bien?"

"No sé."

Hay un silencio.

"Yo tengo miedo de que me pase lo mismo. En el depósito andan raros también."

Diego también tiene miedo.
No estás solo en eso.

"Si necesitás algo, avisá. No tengo mucho pero..."

"Gracias, Diego."

* [Ir a la noche] -> miercoles_noche

=== miercoles_llamar_marcos ===

Marcos no contesta.
El teléfono suena y suena.

Bueno.
No esperabas otra cosa.

* [Ir a la noche] -> miercoles_noche

=== miercoles_noche ===

# MIÉRCOLES - NOCHE

~ energia = 0

-> check_game_over ->

-> casa_llegada_noche ->

// Contenido específico de la noche del miércoles
La noche llega.
Primer día sin laburo.

Te acostás pero no dormís.
La cabeza no para.

* [...]
-

La tarjeta. El alquiler. La obra social.
Tenés tres meses. Tres meses para resolver algo.

La cuenta regresiva empezó.

{conte_a_alguien: Al menos alguien sabe. No estás completamente solo.}
{not conte_a_alguien: No le contaste a nadie. El peso es solo tuyo.}

// Fragmento nocturno
-> fragmento_miercoles

=== fragmento_miercoles ===

# MIENTRAS DORMÍS (o intentás)

// El fragmento depende de las decisiones del día
{conte_a_alguien && vinculo == "sofia":
    -> fragmento_sofia_miercoles
}
{conte_a_alguien && vinculo == "diego":
    -> fragmento_diego_miercoles
}
{conte_a_alguien && vinculo == "elena":
    -> fragmento_elena_miercoles
}
{conte_a_alguien && vinculo == "marcos":
    -> fragmento_marcos_miercoles
}
// Default
{vinculo == "marcos": -> fragmento_marcos_miercoles}
{vinculo == "sofia": -> fragmento_sofia_miercoles}
{vinculo == "elena": -> fragmento_elena_miercoles}
-> fragmento_diego_miercoles

=== fragmento_sofia_miercoles ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Sofía piensa en vos.

    En cómo te vio salir del edificio.
    Vacío. Roto.

    "Así empiezan todos", piensa.
    "Primero el despido. Después la nada."

    La olla está llena de gente así.
    Gente que era otra cosa.
    Ahora solo sobreviven.

    Vos vas a ser uno más.

    ~ aumentar_inercia(1)
    * [Continuar] -> transicion_miercoles_jueves
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Sofía está en la olla vacía.

    Hoy nadie vino a ayudar.
    Mañana tampoco van a venir.

    "El barrio se deshace", piensa.

    Cada uno con su problema.
    Cada uno solo.
    Ya nadie viene.

    La olla va a cerrar.
    Es cuestión de tiempo.

    ~ bajar_llama(1)
    * [Continuar] -> transicion_miercoles_jueves
}

// FRAGMENTO NORMAL
Sofía tampoco puede dormir.

Está en la cocina, con la calculadora.
Los números de la olla no cierran.
Nunca cierran.

* [...]
-

Piensa en vos.
Otro que cayó.
Pero también: otra persona que puede ayudar.

* [...]
-

No es que se alegre de que te echaron.
Pero hay algo en que no estés solo.
En que quizás vengas mañana.

Apaga la luz.
Mañana hay que seguir.

* [Continuar] -> transicion_miercoles_jueves

=== fragmento_diego_miercoles ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Diego piensa en vos.

    En cómo te vio hoy.
    Destruido. Humillado.

    "Yo también voy a terminar así", piensa.
    "Todos los que venimos de afuera terminamos así."

    Dejó todo en Venezuela.
    Para esto.
    Para ver cómo te rompen en otro país.

    Su madre preguntó cómo estaba.
    "Bien, má."
    Mentira.

    Todo es mentira.

    ~ aumentar_inercia(1)
    * [Continuar] -> transicion_miercoles_jueves
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Diego está solo en su pieza.

    Llegó hace dos años.
    Tiene tres contactos en el celular.
    Tres.

    "Vine acá para estar solo en otro idioma", piensa.

    En Venezuela no tenía a nadie.
    Acá no tiene a nadie.

    No hay diferencia.
    Nunca hubo.

    ~ bajar_llama(1)
    * [Continuar] -> transicion_miercoles_jueves
}

// FRAGMENTO NORMAL
Diego está en su pieza.
Alquilada, chica, con olor a humedad.

Piensa en vos.
En lo que le contaste.
En que podría ser él mañana.

* [...]
-

Llama a su madre.
"Sí, má, todo bien."
Miente.

Cuelga.
Mira el techo.

* [...]
-

No sabe qué hacer.
Quiere ayudarte pero no sabe cómo.
Quiere ayudarse pero no sabe cómo.

Mañana te va a buscar.
No sabe para qué. Pero te va a buscar.

* [Continuar] -> transicion_miercoles_jueves

=== fragmento_elena_miercoles ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Elena piensa en Raúl.

    Él también se rompió.
    En el 2002, cuando cerró el frigorífico.

    Por tres meses fue otra persona.
    Vacía. Derrotada.

    Piensa en vos.
    En tu voz hoy.

    "Ya empezó a romperse", piensa.
    Y sabe que es difícil volver de eso.

    Raúl nunca volvió del todo.
    Murió un poco roto.

    ~ aumentar_inercia(1)
    * [Continuar] -> transicion_miercoles_jueves
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Elena está sola.

    Raúl murió hace tres años.
    Los hijos viven lejos.

    El barrio ya no es lo que era.
    Ya nadie se junta.
    Ya nadie toca timbre.

    "Nos volvimos un país de solos", piensa.

    Antes había red.
    Ahora hay puertas cerradas.

    ~ bajar_llama(1)
    * [Continuar] -> transicion_miercoles_jueves
}

// FRAGMENTO NORMAL
Elena no puede dormir.

Piensa en Raúl.
En el 2002.
En cómo pensó que no iban a salir.
Y salieron. Juntos.

Piensa en vos.
En lo que le contaste.
En la voz que tenías.

Mañana te va a llamar.
Va a ver cómo estás.
Es lo que se hace.

Prende la radio bajito.
Algo de compañía en la oscuridad.

* [Continuar] -> transicion_miercoles_jueves

=== fragmento_marcos_miercoles ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Marcos piensa en vos.

    Ahora somos iguales. 
    Dos descartes del sistema.

    "Ya vas a entender", piensa.
    "Que no importa cuánto te esfuerces."
    "Al final, sos solo una pieza que se cambia."

    Él ya no pelea. 
    Espera que vos tampoco lo hagas. 
    Es más fácil así.

    ~ aumentar_inercia(1)
    * [Continuar] -> transicion_miercoles_jueves
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Marcos mira el teléfono. 
    
    Vio tu llamada perdida. 
    Vio el mensaje.
    
    No respondió. 
    
    "Para qué", se pregunta. 
    "Un despedido consolando a otro despedido."
    "Una miseria compartida no es menos miseria."
    
    Mejor el silencio. 
    En el silencio no hay que fingir nada.

    ~ bajar_llama(1)
    * [Continuar] -> transicion_miercoles_jueves
}

// FRAGMENTO NORMAL
Marcos mira la tele. 
Programas de política que ya no le dicen nada. 
Gente de traje hablando de "macroeconomía" mientras el barrio se cae a pedazos.

Piensa en vos. 
En que te echaron. 
En que ahora sabés lo que se siente.

"Cagaste, uruguayo", murmura para el cuarto vacío. 

Pero hay algo en su mirada. 
Un resto de bronca que todavía no se convirtió en ceniza.

Mañana será otro día.

* [Continuar] -> transicion_miercoles_jueves

=== transicion_miercoles_jueves ===
// Chequeo de colapso mental antes de continuar
{inercia >= 10:
    -> final_apagado
}

// Chequeo de destrucción del tejido social
{llama <= 0:
    -> final_sin_llama
}

-> jueves_amanecer
