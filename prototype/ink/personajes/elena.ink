// ============================================
// PERSONAJE: ELENA
// Veterana del barrio, vivió la crisis del 2002
// Sabia, memoria del barrio
// ============================================

// --- ENCUENTRO CASUAL EN EL BARRIO ---

=== elena_encuentro_casual ===
# PORTRAIT:elena,neutral,right

Elena está sentada en el banco de la plaza.
Siempre el mismo banco. Siempre la misma hora.

Setenta y pico. Llegó al barrio antes que todos.
Vio todo. Recuerda todo.

Mira pasar a la gente como quien lee un libro viejo.

* [Sentarte a su lado] -> elena_sentarse
* [Saludar de lejos] -> elena_saludo_lejos
* [Pasar de largo] -> elena_ignorar

=== elena_sentarse ===

Te sentás a su lado.
No dice nada. No hace falta.

El sol de la tarde. Los gurises jugando.
Un momento de paz en el quilombo.

"¿Cómo andás, m'hijo?"

Su voz es ronca. Años de café fuerte y cigarros.

* ["Ahí ando, Elena."] -> elena_ahi_ando
* ["Mal. Todo mal."] -> elena_todo_mal
* ["¿Y usted?"] -> elena_ella_como

=== elena_ahi_ando ===

"Ahí andamos todos."
# PORTRAIT:elena,remembering,right

Mira hacia la calle.

"¿Sabés cuántas veces escuché eso? 'Ahí ando'.
En el 2002 todo el mundo andaba 'ahí'.
Pero seguíamos."

~ elena_relacion += 1

Silencio.
El silencio de Elena nunca es incómodo.

->->

=== elena_todo_mal ===
# PORTRAIT:elena,wise,right

"Mal es relativo, m'hijo."

Te mira. Ojos que vieron demasiado.

"¿Tenés techo? ¿Comiste hoy?"

"Sí."

"Entonces no está todo mal. Está jodido, pero no todo mal."

Tiene razón. O no.
Pero su certeza ayuda.

~ elena_relacion += 1

->->

=== elena_ella_como ===

"Vieja. Cada día más vieja."

Se ríe.

"Pero acá sigo. Como el banco este. Como el barrio."

Pausa.

"Mientras pueda caminar hasta acá, voy a venir.
El día que no venga, preocupate."

->->

=== elena_saludo_lejos ===

Levantás la mano.
Ella asiente.

Un saludo de barrio.
Sin palabras. Sin necesidad.

->->

=== elena_ignorar ===

Pasás de largo.
Ella ni se inmuta.

Ha visto gente pasar toda su vida.
Una persona más no cambia nada.

->->

// --- EN LA OLLA POPULAR ---

=== elena_en_olla ===

Elena pela papas.
Las manos arrugadas, pero firmes.
Años de práctica.

"Vení, sentate. Agarrá un cuchillo."

No es una pregunta.

~ ayude_en_olla = true

Pelás papas en silencio.
Ella habla cuando quiere. Nunca antes.

"¿Sabés quién empezó esta olla?"

* ["¿Usted?"] -> elena_historia_olla
* ["No."] -> elena_historia_olla
* [Seguir pelando en silencio] -> elena_silencio

=== elena_historia_olla ===

~ elena_conto_historia = true

"Yo y otras tres. En el 2002."

Sigue pelando. No mira.

"No teníamos nada. Ollas prestadas. Verduras de descarte.
Cocinábamos en la calle porque no había salón."

"¿Cuántos venían?"

"Al principio, veinte. Después cien. Después doscientos."

Pausa.

"Cuando el país se cae, la gente se junta.
Es lo único que tenemos."

~ escuche_sobre_2002 = true
~ subir_conexion(1)

->->

=== elena_silencio ===

El silencio se estira.
No incómodo. Compartido.

Las papas se acumulan.
El trabajo sigue.

->->

// --- CONVERSACION PROFUNDA ---

=== elena_conversacion_profunda ===

~ visite_elena_en_casa = true

La casa de Elena es chica.
Fotos en las paredes. Gente que ya no está.

"Sentate. Voy a hacer café en la prensa francesa."

No aceptás un no.
Los viejos del barrio no aceptan un no.

El café llega. Negro. Fuerte.

"¿Qué te pasa, m'hijo? Te veo raro."

* [Contarle tu situación] -> elena_escucha
* ["Nada. Solo quería visitarla."] -> elena_no_cuenta
* [Preguntarle sobre el 2002] -> elena_sobre_2002

=== elena_escucha ===

Le contás. Todo.
El laburo. La plata. El miedo.

Ella escucha. No interrumpe.
Cuando terminás, toma café. Piensa.

"¿Sabés qué aprendí en setenta años?"

"¿Qué?"

"Que todo pasa. Lo bueno y lo malo.
El problema es que cuando estás en lo malo,
parece que no va a terminar nunca."

"¿Y qué hago?"

"Lo que puedas. Un día a la vez.
No pensés en mañana. Pensá en hoy."

~ elena_me_aconsejo = true
~ elena_relacion += 1
~ subir_conexion(1)

"Y vení a la olla. Siempre hay un plato."

->->

=== elena_no_cuenta ===

"Mentira. Pero está bien. Cuando quieras hablar, acá estoy."

Toman café.
No hace falta hablar.
A veces la compañía alcanza.

~ elena_relacion += 1

->->

=== elena_sobre_2002 ===

~ escuche_sobre_2002 = true

"El 2002. La crisis."

Suspira. Los ojos se van lejos.

"Fue peor que esto. Mucho peor.
La gente no tenía para comer. Literal.
Los bancos cerrados. Todo cerrado."

"¿Cómo sobrevivieron?"

"Juntos. No había otra."

Toma café.

"Las ollas, el trueque, las asambleas.
La gente se organizó porque el Estado no existía."

"¿Y después?"

"Después volvió todo. El país se acomodó.
Pero los que nos quedamos acá, no olvidamos."

~ elena_relacion += 1
~ subir_conexion(1)

->->

// --- ELENA PREOCUPADA ---

=== elena_preocupada_olla_knot ===
# PORTRAIT:elena,worried,right

~ elena_preocupada_olla = true

Elena te busca. Cosa rara.
Ella nunca busca a nadie.

"Che. Necesito hablar."

"¿Qué pasa?"

"La olla. Sofía está quemada.
Si ella cae, cae todo."

Te mira. Seria.

"Hay que ayudarla. Pero ella no pide."

"¿Qué puedo hacer?"

"Estar. Aparecer. Hacer lo que puedas.
A veces eso alcanza."

* ["Voy a ayudar."] -> elena_acepto_ayudar
* ["No sé si puedo."] -> elena_no_puedo_ayudar

=== elena_acepto_ayudar ===

"Bien."

No dice gracias. No hace falta.

"Sofía es terca. Como yo.
Pero necesita gente."

~ elena_relacion += 1

->->

=== elena_no_puedo_ayudar ===

"Nadie puede mucho. Pero todos pueden algo."

No hay reproche. Solo verdad.

"Pensalo."

Se va.
Las palabras quedan.

->->

// --- ELENA CUENTA SOBRE EL PASADO DEL BARRIO ---

=== elena_memoria_barrio ===

"¿Ves esa casa? Ahí vivía Don Ramón.
Carpintero. Hizo la mitad de los muebles del barrio."

"¿Qué le pasó?"

"Se murió en el 2003. El corazón.
La crisis lo mató. Como a muchos."

Señala otra casa.

"Ahí vivían los Fernández. Cinco hijos.
Se fueron a España en el 2002. Nunca volvieron."

El barrio es un cementerio de historias.
Elena es la única que las recuerda.

"¿Por qué me cuenta esto?"

"Porque alguien tiene que saber.
Cuando yo me vaya, ¿quién va a recordar?"

~ elena_relacion += 1
~ subir_conexion(1)

->->

// --- TUNNELS PARA DIAS ---

=== elena_en_casa ===
// Tunnel: Encuentro en casa de Elena
// Uso: -> elena_en_casa ->

~ subir_conexion(1)

Elena está en su casa.
Te hace pasar.

"¿Cómo estás?"

"No sé."

Ella asiente.
Pone la pava.

->->

=== elena_historia_2002 ===
// Tunnel: Elena cuenta del 2002
// Uso: -> elena_historia_2002 ->

"En el 2002, Raúl estuvo tres meses sin laburo. La olla nos salvó ese invierno."

No sabías eso.

"No te vas a morir. Pero va a ser duro. Y vas a necesitar gente."

->->

=== elena_hablar_barrio ===
// Tunnel: Elena habla del barrio
// Uso: -> elena_hablar_barrio ->

Elena habla del barrio, de antes.
De cómo la gente se ayudaba.

"Ahora cuesta más. Pero sigue pasando."

->->

=== elena_consejo ===
// Tunnel: Elena da un consejo
// Uso: -> elena_consejo ->

Elena habla:

"En el 2002 estuvimos peor. Y acá seguimos. La pregunta no es si vamos a seguir. Es cómo."

->->

=== elena_canastas ===
// Tunnel: Elena habla de las canastas
// Uso: -> elena_canastas ->

Elena habla:
"En el 2002 hacíamos canastas. Cada uno ponía lo que podía. Nadie daba mucho pero entre todos..."

Sofía asiente.
"Podemos probar."

~ idea_hay_cosas_juntos = true

->->

=== elena_pedir ===
// Tunnel: Elena sabe pedir
// Uso: -> elena_pedir ->

Elena sabe cómo pedir.
No es mendigar.
Es pedir a vecinos.
Es distinto.

"En el 2002 hacíamos esto todo el tiempo. Te acostumbrás."

->->

=== elena_llamar ===
// Tunnel: Llamar a Elena
// Uso: -> elena_llamar ->

Llamás a Elena.

"Hola, m'hijo."

Siempre te dice así.
Como si fueras de la familia.

"¿Cómo estás, Elena?"

"Acá. Como siempre. ¿Y vos? ¿Cómo llevás la semana?"

"Raro. Todo raro."

"Es normal. Dale tiempo."

->->

=== elena_conversacion_telefono ===
// Tunnel: Conversacion telefonica con Elena
// Uso: -> elena_conversacion_telefono ->

Hablan de cosas.
Ella te cuenta del barrio.
De antes.
De ahora.

"Vos vas a estar bien. Sos de los que se bancan."

No sabés si es verdad.
Pero ayuda escucharlo.

~ subir_conexion(1)

->->

// --- FRAGMENTO NOCTURNO DE ELENA ---

=== elena_fragmento_noche ===

Elena no duerme mucho.
Los viejos no duermen.

* [Sentarse en la cocina] # FALSA
    Se sienta en la cocina.
    Café recalentado. Radio bajita. Las voces de siempre.

{escuche_sobre_2002:
    Piensa en el 2002.
    En los que no sobrevivieron.
    En los que se fueron.
    En los que quedaron.
}

Mira las fotos de la pared.
Su marido. Muerto hace quince años.
Sus hijos. Uno en Buenos Aires. Otro en España.
No vienen nunca.

{elena_preocupada_olla:
    Piensa en Sofía.
    En la olla.
    En que la historia se repite.

    Ella ya no tiene fuerzas para cargar todo.
    Pero puede sostener un poco.
}

La radio habla de economía.
Números que no entiende.
Palabras que ya escuchó antes.

* [Murmurar] # FALSA
    "Otra vez", murmura.
    "Siempre otra vez."

{elena_relacion >= 4:
    Piensa en vos.
    En que hay gente nueva que entiende.
    En que tal vez el barrio sobreviva.
}

A las cuatro se acuesta.
El sueño de los viejos.
Liviano. Interrumpido.
Lleno de fantasmas.

->->
