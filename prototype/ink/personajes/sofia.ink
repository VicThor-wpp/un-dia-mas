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

Caminan juntos hacia el salón comunal.

"¿Para cuántos cocinan hoy?"

"Sesenta y pico. Cada semana son más."

Sesenta personas que dependen de esto.
De ella.

"¿Y la plata alcanza?"

Se ríe. Sin gracia.

"Nunca alcanza. Pero se estira."

->->

=== sofia_ignorar ===

Seguís de largo.
Ella ni se da cuenta.
Tiene demasiado en la cabeza.

->->

// --- EN LA OLLA POPULAR ---

=== sofia_en_olla ===

El salón comunal huele a guiso.
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

* [...]
-

Sofía habla mientras revuelve.

"Mi vieja ya revolvía esta misma olla en el 2002. Ella me enseñó que cuando el Estado se retira, el barrio tiene que avanzar. Vi los 'Centros Sociales' que prometieron volverse cáscaras vacías, llenas de carteles pero sin comida. Nosotros no tenemos carteles, pero tenemos fuego."

"¿Es agotador, no?"

"Agotador es esperar que alguien te salve. Cocinar es resistencia."

~ subir_conexion(1)

* [...]
-

Llegan los primeros. Viejos, niños, familias enteras.
Caras conocidas del barrio.

Sofía sirve. Una sonrisa para cada uno.
Aunque esté muerta de cansancio.

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

"El padre de los gurises se fue. De un día para otro.
Me dejó con la ropa que teníamos puesta y deudas."

Aprieta el trapo.

* [...]
-

"Llegué al barrio porque una prima me prestó una pieza.
No conocía a nadie. No tenía trabajo."

"¿Y la olla?"

* [...]
-

"Elena me vio en la plaza. Yo estaba sentada, calculando cuánto me duraba la leche.
Se acercó y me dijo: 'Si tenés manos, servís'. Me trajo acá. Me dio un cuchillo."

Pausa.

"Ese día comimos. Pero lo importante fue que ese día cociné.
Dejé de esperar y empecé a hacer."

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

"A veces, en los congresos, veo a compañeros que siguieron la carrera 'en serio'. Publicando papers, viajando a conferencias. Y siento un poco de envidia."

"Es normal."

"Sí. Pero después me acuerdo de la risa de los gurises cuando hay postre en la olla. Y se me pasa."

* [...]
-

Hace una pausa más larga.

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

"Tres mil pesos. Para ayer."

* [...]
-

Tres mil pesos.
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

"Dale. Cualquier cosa sirve."

~ sofia_relacion += 1

->->

=== sofia_dar_plata ===

Le das lo que tenés.
No son tres mil. Pero es algo.

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
