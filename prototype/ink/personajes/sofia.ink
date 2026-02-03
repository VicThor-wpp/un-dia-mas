// ============================================
// PERSONAJE: SOFIA
// Madre soltera, maneja la olla popular
// Cansada pero luchadora
// ============================================

// --- ENCUENTRO CASUAL EN EL BARRIO ---

=== sofia_encuentro_casual ===

Sofía sale del almacén con dos bolsas pesadas.
Madre soltera. Dos hijos: Nico y Lupe.
Organiza la olla popular desde hace dos años.

Tiene ojeras. Siempre tiene ojeras.

* [Saludar] -> sofia_saludo
* [Ofrecerte a ayudar con las bolsas] -> sofia_ayudar_bolsas
* [Seguir de largo] -> sofia_ignorar

=== sofia_saludo ===

"Hola, Sofía."

Te mira. Una sonrisa cansada.

"Hola. ¿Cómo andás?"

{sofia_sabe_mi_situacion:
    No esperás la pregunta de siempre.
    Ella sabe. No pregunta.
    "Ahí vamos."
    "Ahí vamos todos."
- else:
    "Bien. ¿Y vos?"
    "En la lucha."
}

Sigue caminando. No tiene tiempo.
Nadie tiene tiempo.

->->

=== sofia_ayudar_bolsas ===

"Dejame ayudarte."

Agarrás una bolsa. Pesa.
Papas, fideos, aceite.

"Gracias. Las piernas ya no me dan."

~ sofia_relacion += 1

Caminan juntos hacia la casa de la Chola.

"¿Para cuántos cocinan hoy?"

"Sesenta y pico. Viene bastante gente."

Sesenta personas que eligen venir.
A comer, a estar, a ser parte.

"¿Y cómo lo bancan?"

Sonríe.

"Entre todos. Cada uno pone lo que puede."

{es_vegano:
    Te mira un segundo. 
    "Espero que no seas muy mañoso con la comida. Acá cocinamos con lo que conseguimos, que no siempre es lo ideal. Pero siempre hay verduras si preferís."
}

->->

=== sofia_ignorar ===

Seguís de largo.
Ella ni se da cuenta.
Tiene demasiado en la cabeza.

->->

// --- EN LA OLLA POPULAR ---

=== sofia_en_olla ===

El patio huele a guiso.
Sofía revuelve una olla enorme.

Hay voluntarios. Pocos.
Elena pela papas. Nadie más.

"¿Necesitás ayuda?"

Sofía te mira. Evalúa.

* ["Puedo pelar, cortar, lo que sea."] -> sofia_aceptar_ayuda
* ["Solo pasaba a saludar."] -> sofia_solo_saludar

=== sofia_aceptar_ayuda ===

~ ayude_en_olla = true
~ sofia_relacion += 1

"Agarrá un cuchillo. Las zanahorias."

Trabajás en silencio.
El ruido de los cuchillos, el burbujeo de la olla.
Un ritmo.

// Chequeo físico: el trabajo en la olla es pesado
# DADOS:CHEQUEO
~ temp resultado_sofia_olla_fisico = chequeo_completo_fisico(1, 4)
{ resultado_sofia_olla_fisico == 2:
    Las manos se mueven solas. Encontrás el ritmo de la cocina.
    Sofía te mira de reojo. Impresionada.
    "Tenés mano para esto."
    ~ sofia_relacion += 1
    ~ subir_conexion(1)
}
{ resultado_sofia_olla_fisico == 1:
    Cortás, pelás, revolvés. El cuerpo responde.
    No es elegante, pero es trabajo honesto.
}
{ resultado_sofia_olla_fisico == 0:
    Te cansás rápido. Las manos no rinden.
    Sofía no dice nada. Pero te pasa las tareas más livianas.
    "Andá separando los platos."
}
{ resultado_sofia_olla_fisico == -1:
    Se te resbala el cuchillo. Casi te cortás.
    "¡Cuidado!" Sofía te frena la mano.
    "Despacio. La olla no tiene apuro."
    Te tiemblan las manos. El cuerpo no da más.
}

* [...]
-

Sofía habla mientras revuelve.

"Mi vieja ya revolvía esta misma olla en el 2002. Ella me enseñó que cuando el Estado se retira, el barrio tiene que avanzar. Vi los 'Centros Sociales' que prometieron volverse cáscaras vacías, llenas de carteles pero sin comida. Nosotros no tenemos carteles, pero tenemos fuego."

"¿Es agotador, no?"

"Agotador es esperar que alguien te salve. Cocinar es resistencia."

~ subir_conexion(1)
~ activar_hay_cosas_juntos()

* [...]
-

Llegan los primeros. Vecinos, familias, gente del barrio.
Caras conocidas. Algunos vienen desde hace años.

Sofía sirve. Una sonrisa para cada uno.
El cansancio no le quita eso.

->->

=== sofia_solo_saludar ===

"Ah. Bueno."

No hay reproche en su voz.
Solo cansancio.

"Cualquier cosa, acá estamos."

Volvés a la calle.
La olla sigue hirviendo.

->->

// --- CONVERSACION PROFUNDA ---

=== sofia_conversacion_profunda ===

~ hable_con_sofia_profundo = true

Es de noche. La olla terminó.
Sofía limpia. Sola.

"¿Te ayudo?"

"Ya casi termino."

* [...]
-

Pero aceptás un trapo igual.
Secan los platos juntos.

"¿Por qué hacés esto, Sofía?"

Se detiene. Piensa.

"Porque alguien tiene que hacerlo."

"Podrías no hacerlo. Cuidar a tus hijos y ya."

"Mis hijos comen de acá también."

Silencio.
# PAUSA

"Cuando llegué al barrio, no tenía nada. Un bolso y los gurises.
Pero acá no me dieron limosna. Me dieron un lugar."

* [...]
-

"¿Y ahora vos salvás a otros?"

"No sé si salvo a nadie. Pero intento que nadie tenga que
pasar lo que pasé yo."

~ sofia_relacion += 1
~ subir_conexion(1)

* ["Sos muy fuerte."] -> sofia_respuesta_fuerte
* ["¿No te cansás?"] -> sofia_respuesta_cansancio
* ["¿Qué pasó cuando llegaste?"] -> sofia_historia

=== sofia_respuesta_fuerte ===

"No soy fuerte. Estoy cansada todo el tiempo.
Pero no tengo opción."

* [...]
-

Sigue secando.

"Los gurises dependen de mí. El barrio depende de esto.
Si yo paro, ¿quién sigue?"

No tiene respuesta. Nadie la tiene.

->->

=== sofia_respuesta_cansancio ===

"Todos los días."

Te mira. Ojos rojos.

"A veces quiero irme. Dejarlo todo.
Pero ¿adónde? ¿Con qué?"

"No tenés que hacerlo sola."

"No estoy sola. Pero a veces se siente así."

~ sofia_estado = "agotada"

->->

=== sofia_historia ===

"Matías, el padre de los gurises, ya no está. Nos separamos hace años, cuando volvimos de Barcelona."

Aprieta el trapo.

* [...]
-

"Él hizo su vida en otro barrio. A veces manda una pensión, a veces no. No es mala gente, solo... eligió otro camino. Y yo me quedé acá, con la casa de mi vieja y la olla."

"¿Y cómo empezaste con esto?"

* [...]
-

"Llegué al barrio destruida. La Chola estaba enferma y yo no sabía cómo manejar todo sola. Elena me vio en la plaza un día, calculando cuánto me duraba la leche para Nico."

"¿Qué hizo?"

"Se acercó y me dijo: 'Si tenés manos, servís'. Me trajo acá. Me dio un cuchillo y una bolsa de papas."

Pausa.
# PAUSA

"Ese día comimos. Pero lo importante fue que ese día cociné.
Dejé de esperar y empecé a hacer. La olla me salvó a mí antes que yo a ella."

~ sofia_relacion += 1

->->

// --- HISTORIA PROFUNDA DE SOFÍA ---

=== sofia_sobre_madre ===
// La muerte de la Chola

~ sofia_hablo_de_madre = true

Es de noche. La olla está vacía.
Sofía mira la imagen de la Virgen de Guadalupe en la pared.

"La puso mi vieja. La Chola."

* [...]
-

"Ella empezó todo esto. En los 90. Dando merienda a los gurises en su casa. De a poco fue creciendo."

"¿Y vos?"

"Yo me fui. Conseguí beca, estudié afuera. Era la 'chica brillante' del barrio. La que 'salió'."

* [...]
-

Pausa. Sofía mira la imagen de la Virgen.

"Cuando mi vieja se enfermó, vine a 'ayudar seis meses'. Nunca volví a España."

"¿Por qué?"

* [...]
-

"Porque ella me tomó la mano en el hospital y me dijo: 'La olla no se apaga'. Y después me dijo otra cosa."

"¿Qué?"

"'No seas boluda, Sofía. La olla sos vos ahora. Pero no sola. Nunca sola'."

* [...]
-

Se le humedecen los ojos. No llora. Ya no llora por esto.
# PAUSA

"Se murió tres semanas después. Y yo me quedé."

~ subir_conexion(1)
~ sofia_relacion += 1

->->

=== sofia_oferta_alemania ===
// La beca que rechazó

~ sofia_hablo_de_alemania = true

"¿Sabés qué me llegó hace unos meses?"

"¿Qué?"

"Un mail de mi ex director de tesis. Una beca postdoctoral en Heidelberg. Alemania. Condiciones excelentes."

* [...]
-

"¿En serio? ¿Y qué hiciste?"

"Le respondí que no en una semana."

"¿Por qué?"

* [...]
-

Sofía se ríe. Pero no es una risa alegre.

"Porque si me iba ahora, mi vieja me tiraba el mate desde el cielo."

* [...]
-

Pausa.
# PAUSA

"A veces, en los congresos, veo a compañeros que siguieron la carrera 'en serio'. Publicando papers, viajando a conferencias. Y siento un poco de envidia."

"Es normal."

"Sí. Pero después me acuerdo de la risa de los gurises cuando hay postre en la olla. Y se me pasa."

* [...]
-

Hace una pausa más larga.
# PAUSA

"Casi siempre se me pasa."

~ subir_conexion(1)
~ sofia_relacion += 1

->->

=== sofia_martin_papas ===
// El compañero de laboratorio pelando papas

~ sofia_hablo_de_martin = true

"¿Te conté de Martín?"

"¿Quién es Martín?"

"Un compañero del laboratorio. Especialista en química de alimentos."

* [...]
-

"Un invierno vino a la olla. 'A ver de qué se trata', dijo."

"¿Y?"

"Terminó pelando papas tres horas. Torpemente. Se manchó el jean entero."

* [...]
-

Sofía se ríe. Esta vez de verdad.

"En un momento dijo: 'Esto es más difícil que una cromatografía'. Y yo me reí por primera vez en semanas."

* [...]
-

"Ahora viene una vez por mes, cuando puede. No es mucho, pero ayuda."

"¿Y en la universidad no te miran raro por la olla?"

* [...]
-

"Al principio sí. '¿Olla popular? ¿Como en 2002?'. Pero con el tiempo varios entendieron."

Pausa.

"No es doble vida. Es vida integrada. Mis papers y mis papas."

~ subir_conexion(1)
~ sofia_relacion += 1

->->

=== sofia_catolicismo ===
// El catolicismo práctico

Notás la estampita de la Virgen de Guadalupe en el delantal de Sofía.

"¿Sos católica?"

"Sí. Como la Chola. No soy de ir a misa todos los domingos, pero rezo a veces."

* [...]
-

"Por eso les puse esos nombres a mis hijos. Nicolás y Guadalupe. Por ella."

Señala la imagen en la pared.

"Mi vieja la trajo de México cuando era joven. Decía que la Virgen de Guadalupe entiende a los pobres porque se apareció morena, hablándole a un indio."

* [...]
-

"No es una fe de discurso. Es una base silenciosa. Cuando no sé qué hacer, rezo. Y después sigo haciendo."

"¿Y funciona?"

"No sé si funciona. Pero me calma."

~ sofia_relacion += 1

->->

=== sofia_delantal_madre ===
// El delantal de la Chola

Notás que Sofía siempre usa el mismo delantal.
Viejo, manchado, remendado.

"Ese delantal..."

"Era de mi vieja."

* [...]
-

"No lo lavo. Bueno, lo lavo un poco. Pero no le saco las manchas viejas."

"¿Por qué?"

"Porque son sus manchas. Sus horas de cocina. Su trabajo."

* [...]
-

Se lo toca.

"A veces, cuando estoy muy quemada, me lo aprieto contra el pecho. Como si ella pudiera abrazarme."
# PAUSA

No dice más.
No hace falta.

~ subir_conexion(1)
~ sofia_relacion += 1

->->

// --- SOFIA PIDE AYUDA ---

=== sofia_pide_ayuda ===

~ sofia_me_pidio_ayuda = true

Sofía te busca. Cosa rara.

"Che. Necesito pedirte algo."

"¿Qué pasa?"

* [...]
-

"La olla. No nos da. Tenemos deudas con el almacén.
Si no pagamos, no nos fían más."

"¿Cuánto es?"

"Dieciocho mil pesos. Para ayer."

* [...]
-

Dieciocho mil pesos.
No los tenés. O sí, pero son para el alquiler.

* [Ofrecer ayudar a conseguir donaciones] -> sofia_ayuda_donaciones
* [Dar lo que tenés] -> sofia_dar_plata
* [Decir que no podés] -> sofia_no_puedo

=== sofia_ayuda_donaciones ===

"Plata no tengo. Pero puedo ayudar a conseguir."

"¿Cómo?"

"No sé. Golpear puertas. Hablar con comercios.
Algo se me ocurre."

Sofía te mira. Evaluando.

// Chequeo social: convencer a Sofia de que podés ayudar
# DADOS:CHEQUEO
~ temp resultado_sofia_persuadir = chequeo_completo_social(sofia_relacion, 4)
{ resultado_sofia_persuadir == 2:
    Sofía te mira distinto. Algo en tu voz la convenció.
    "Sabés qué, sí. Necesito alguien que me ayude a hablar con los comercios de la zona. Tengo una lista."
    Te pasa un papel arrugado. Nombres, direcciones.
    "Juntos capaz que los convencemos."
    ~ sofia_relacion += 2
    ~ subir_conexion(1)
}
{ resultado_sofia_persuadir == 1:
    "Dale. Cualquier cosa sirve."
    ~ sofia_relacion += 1
}
{ resultado_sofia_persuadir == 0:
    "Mirá... no es por desconfiar. Pero ya vinieron otros con eso y después no aparecieron."
    "Yo voy a aparecer."
    "Bueno. Veremos."
    No te cierra la puerta. Pero tampoco la abre del todo.
}
{ resultado_sofia_persuadir == -1:
    "Mirá, te agradezco. Pero la verdad... no te conozco tanto."
    El rechazo duele. Pero Sofía no puede darse el lujo de confiar en cualquiera.
    Tiene sesenta bocas que dependen de ella.
    ~ bajar_conexion(1)
}

->->

=== sofia_dar_plata ===

Le das lo que tenés.
No son dieciocho mil. Pero es algo.

"No puedo aceptar esto."

"Aceptalo. Después veo cómo hago."

* [...]
-

~ sofia_relacion += 2
~ subir_conexion(2)

Sofía no dice gracias.
Te abraza.
Fuerte.

->->

=== sofia_no_puedo ===

"No puedo, Sofía. Lo siento."

"Está bien. Entiendo."

No hay reproche. Solo resignación.
Ella sabe lo que es no poder.

->->

// --- FRAGMENTO NOCTURNO DE SOFIA ---

// --- TUNNELS PARA DIAS ---

=== sofia_primer_encuentro ===
// Tunnel: Primer encuentro del dia con Sofia
// Uso: -> sofia_primer_encuentro ->

Sofía te ve.

{conte_a_alguien && vinculo == "sofia":
    "Viniste."
    No es pregunta. Es confirmación.
- else:
    "¿Qué hacés acá a esta hora?"
}

->->

=== sofia_invitar_ayudar ===
// Tunnel: Sofia invita a ayudar
// Uso: -> sofia_invitar_ayudar ->

"Si querés ayudar, sobran cosas para hacer."

No es obligación.
Es invitación.

->->

=== sofia_agradecimiento ===
// Tunnel: Sofia agradece la ayuda
// Uso: -> sofia_agradecimiento ->

"Gracias", dice Sofía.
"Mañana si podés..."

Deja la frase ahí.
No es obligación. Es invitación.

->->

=== sofia_reunion_crisis ===
// Tunnel: Sofia en reunion por la crisis
// Uso: -> sofia_reunion_crisis ->

Sofía está hablando con otros.
La discusión es intensa pero en voz baja.

"No tenemos para hoy."
"Algo hay que hacer."
"¿Pedimos prestado?"
"¿A quién?"

->->

=== sofia_pedir_ideas ===
// Tunnel: Sofia pide ideas
// Uso: -> sofia_pedir_ideas ->

Sofía te hace una seña para que te acerques.
"Justo vos. Necesitamos ideas."

~ sofia_relacion += 1

->->

=== sofia_llamar ===
// Tunnel: Llamar a Sofia
// Uso: -> sofia_llamar ->

Llamás a Sofía.

"Hola."

"Hola. ¿Cómo estás?"

"Cansada. Pero bien. ¿Vos?"

"Igual. Cansado pero... no sé. Distinto."

->->

=== sofia_conversacion_telefono ===
// Tunnel: Conversacion telefonica con Sofia
// Uso: -> sofia_conversacion_telefono ->

Hablan un rato.
De la olla.
De la semana.
De vos.

"Gracias por ayudar esta semana. De verdad."

"Gracias por dejarme ayudar."

~ subir_conexion(1)

->->

=== sofia_fragmento_pensar ===
// Tunnel: Sofia pensando de noche
// Uso: -> sofia_fragmento_pensar ->

Piensa en pedir prestado.
Piensa en golpear puertas.
Piensa en cerrar.

No puede cerrar.
Hay gente que depende de esto.

{ayude_en_olla:
    Piensa en vos.
    En que viniste a ayudar.
    En que quizás no está sola.
}

->->

=== sofia_fragmento_asamblea ===
// Tunnel: Sofia despues de la asamblea
// Uso: -> sofia_fragmento_asamblea ->

Sofía cierra la olla.

La asamblea fue bien.
Mejor de lo esperado.

Hay gente nueva.
Gente que quiere ayudar.
Vos.

No es solución.
Pero es algo.

->->

// --- FRAGMENTO NOCTURNO ORIGINAL ---

=== sofia_fragmento_noche ===

Sofía mira a sus hijos dormir.
Nico y Lupe, dos cuerpos en un colchón y medio.

Lupe tiene tos.
Otra vez.
No hay plata para el médico.

{sofia_hijos_enfermos:
    Mañana va a tener que elegir.
    Remedios o comida.
    Siempre eligiendo.
}

Piensa en la olla.
En las sesenta bocas.
En el almacén que no les quiere fiar.

¿Cuánto más puede seguir?

Se acuesta. El colchón es duro.

Cierra los ojos.

{sofia_estado == "agotada":
    No puede dormir.
    Las cuentas dan vueltas en su cabeza.
    Los números nunca cierran.
}

{ayude_en_olla:
    Piensa en vos.
    Al menos hoy hubo una mano más.
    Al menos hoy no estuvo tan sola.
}

A las seis suena el despertador.
Otra vez.
Siempre otra vez.

->->

// === SOFÍA SE QUIEBRA ===

=== sofia_momento_quiebre ===
// Sofía admite que no puede más
// Trigger: viernes, después de auditoría Claudia, si sofia_relacion >= 3

La olla está vacía.
Todos se fueron.

Sofía está sentada en un banco. Sola.
No te vio entrar.

* [Acercarte]
    -> sofia_quiebre_encuentro
* [Observar desde lejos]
    -> sofia_quiebre_observar

=== sofia_quiebre_observar ===

Tiene la cabeza entre las manos.

Los hombros le tiemblan.

# PAUSA

Nunca la viste así.
Sofía siempre es la que sostiene.
La que tiene respuestas.
La que sigue.

* [Acercarte ahora]
    -> sofia_quiebre_encuentro
* [Dejarla sola]
    Te vas sin hacer ruido.
    Hay cosas que se procesan solas.
    ->->

=== sofia_quiebre_encuentro ===

"Sofía."

Se sobresalta. Se limpia la cara rápido.

"Ah. Sos vos."

* ["¿Estás bien?"]
    "Sí, sí. Bien."
    Mentira evidente.
    -> sofia_quiebre_presion
* [Sentarte al lado sin decir nada]
    Te sentás.
    Silencio.
    Ella respira hondo.
    -> sofia_quiebre_admision
* ["No tenés que estar bien."]
    -> sofia_quiebre_admision

=== sofia_quiebre_presion ===

"En serio, Sofía."

# PAUSA

Silencio largo.

Después, muy bajo:

-> sofia_quiebre_admision

=== sofia_quiebre_admision ===

"No sé si puedo seguir."

# PAUSA

Lo dijo.

"La Chola me dejó esto. Me dijo 'la olla sos vos ahora'. Y yo dije que sí porque no podía decir que no."

* [...]
-

"Pero yo no soy ella. Ella tenía... no sé. Fe. Yo solo tengo miedo."

* ["¿Miedo de qué?"]
    -> sofia_miedo
* [Escuchar]
    -> sofia_miedo

=== sofia_miedo ===

"De que cierre. De que mañana no haya comida. De Claudia y sus planillas."

Se frota la cara.

"De fallarles a todos."

# PAUSA

"Hay días que llego a casa y no tengo ilusión de nada. Nada."

* [...]
-

"Los gurises me hablan y yo estoy pensando en los números. En si mañana hay para cocinar. En si alguien va a venir a ayudar."

Se le quiebra un poco la voz.

"Me dicen que soy fuerte. Que soy un ejemplo. Pero yo no me siento fuerte. Me siento vacía."

# PAUSA

"Sesenta personas vienen acá. Sesenta. Y yo no sé si la semana que viene voy a poder darles un plato."

* ["No estás sola."]
    -> sofia_no_sola
* ["Cerrá entonces."]
    -> sofia_cerrar_provocacion
* [Quedarte en silencio]
    -> sofia_silencio

=== sofia_no_sola ===

"Ya sé. Elena, Diego, vos... pero al final la que firma soy yo. La que responde soy yo. La que no duerme soy yo."

Pausa.

"Mi vieja murió haciendo esto. ¿Sabés? Literalmente. Se murió cocinando."

# PAUSA

"Y yo a veces pienso: ¿para qué?"

* [...]
-

-> sofia_cierre_quiebre

=== sofia_cerrar_provocacion ===

Sofía te mira. Dura.

"¿Vos me estás cargando?"

"No. En serio. Si no podés, cerrá. Nadie te obliga."

# PAUSA

Silencio.

"No puedo cerrar. Eso es lo peor. No puedo."

-> sofia_cierre_quiebre

=== sofia_silencio ===

No decís nada.

A veces no hay nada que decir.

Sofía respira. Una vez. Dos.

# PAUSA

-> sofia_cierre_quiebre

=== sofia_cierre_quiebre ===

Después de un rato, dice:

"Gracias por no decirme que todo va a estar bien."

* ["No sé si va a estar bien."]
    "No. Yo tampoco."
    -> sofia_cierre_final
* ["Capaz que no. Pero estamos."]
    Sofía asiente.
    -> sofia_cierre_final
* [...]
    -> sofia_cierre_final

=== sofia_cierre_final ===

Se para. Se acomoda el pelo.

"Bueno. Mañana hay asamblea. Hay que preparar."

La máscara vuelve.
Pero ahora sabés lo que hay abajo.

~ sofia_estado = "quebrando"
~ sofia_relacion += 1
~ subir_conexion(1)

"¿Me ayudás a cerrar?"

"Sí."

Cierran la olla juntos.

->->

// --- FRAGMENTOS NOCTURNOS DE SOFIA ---

=== fragmento_sofia_cocina ===
Sofía lava los platos de la olla.
Sola. Los pibes duermen.

El agua corre. Las manos le duelen.
Pero la cocina queda limpia.

Se hace un café. De los buenos.
Una amiga le está enseñando: granos, molienda, temperatura.
"Tenés que olerlo primero", le dice siempre.
Sofía lo huele. Sonríe.
Un lujo chiquito en medio del caos.

{sofia_relacion >= 3:
    Piensa en vos.
    "Ojalá venga mañana", murmura.
}

Mañana hay que cocinar de vuelta.
Siempre hay que cocinar de vuelta.

->->

=== fragmento_sofia_pibes ===
Los pibes de Sofía duermen.
Ella los mira desde la puerta.

El grande tiene un examen mañana.
El chico tose.

{olla_en_crisis:
    Si la olla cierra, no sabe qué van a comer.
    No lo dice. No hace falta.
    Los pibes no necesitan saber que el mundo se tambalea.
}

Les acomoda las frazadas.
Se acuesta sin cenar.

->->

=== fragmento_sofia_asamblea ===
{participe_asamblea:
    Sofía repasa la lista de la asamblea.
    Quién dijo qué. Quién se comprometió.
    Quién no vino.

    {sofia_relacion >= 4:
        Tu nombre está en la lista de los que vinieron.
        Sonríe.
    }

    Mañana hay que hacer lo que se dijo.
    No el lunes. Mañana.
- else:
    Sofía mira la lista vacía de voluntarios.
    Suspira.

    "¿Para qué hago asambleas si nadie viene?"
}

->->
