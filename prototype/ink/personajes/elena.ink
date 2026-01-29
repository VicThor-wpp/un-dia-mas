// ============================================
// PERSONAJE: ELENA
// Veterana del barrio, vivió la crisis del 2002
// Sabia, memoria del barrio
// ============================================

// --- ENCUENTRO CASUAL EN EL BARRIO ---

=== elena_conversacion ===
// Hub principal llamado desde los días
// Llamada: -> elena_conversacion ->

# PORTRAIT:elena,neutral,right

Elena está sentada en el banco de la plaza.
Siempre el mismo banco. Siempre la misma hora.

{elena_relacion == 0:
    Setenta y pico. Llegó al barrio antes que todos.
    Vio todo. Recuerda todo.
    Mira pasar a la gente como quien lee un libro viejo.
}

+ [Sentarte a su lado] -> elena_menu_temas
+ [Saludar de lejos] -> elena_saludo_lejos
+ [Pasar de largo] -> elena_ignorar

=== elena_menu_temas ===

Te sentás a su lado.
{elena_relacion > 2:
    "¿Cómo andás, m'hijo?"
    Su voz es ronca pero amable.
- else:
    No dice nada. No hace falta.
}

- (opts)
* [Charlar del día a día] -> elena_charla_cotidiana
+ [Preguntar sobre el barrio] -> elena_menu_historia
+ {elena_relacion >= 3} [Hablar de cosas serias] -> elena_menu_profundo
+ {elena_relacion >= 4} [Preguntar por la olla] -> elena_sobre_olla
+ [Me tengo que ir]
    "Andá, andá. Que no se te haga tarde."
    ->->

=== elena_charla_cotidiana ===
"Ahí andamos todos."
# PORTRAIT:elena,remembering,right
Mira hacia la calle.
"¿Sabés cuántas veces escuché eso? 'Ahí ando'.
En el 2002 todo el mundo andaba 'ahí'."
-> elena_menu_temas.opts

=== elena_menu_historia ===
+ [Sobre el 2002] {not elena_conto_trueque}
    -> elena_trueque_2002 ->
    -> elena_menu_historia
+ [Sobre el trueque] {elena_conto_trueque and not escuche_sobre_2002}
    -> elena_sobre_2002 ->
    -> elena_menu_historia
+ [Sobre el banco] {elena_conto_trueque and not elena_conto_banco}
    -> elena_en_banco_2002 ->
    -> elena_menu_historia
+ [Sobre los García] {not elena_conto_desalojo}
    -> elena_desalojo_garcia ->
    -> elena_menu_historia
+ [Volver] -> elena_menu_temas.opts

=== elena_menu_profundo ===
+ [Sobre la Chola] {not elena_hablo_de_chola}
    -> elena_sobre_la_chola ->
    -> elena_menu_profundo
+ [Sobre política] {not elena_hablo_politica}
    -> elena_anarquismo ->
    -> elena_menu_profundo
+ [Volver] -> elena_menu_temas.opts

=== elena_sobre_olla ===
+ [La historia de la fundación] {not escuche_historia_olla}
    -> olla_historia_fundacion ->
    -> elena_sobre_olla
+ [Volver] -> elena_menu_temas.opts

=== elena_sentarse ===

Te sentás a su lado.
No dice nada. No hace falta.

El sol de la tarde. Los gurises jugando.
Un momento de paz en el quilombo.

"¿Cómo andás, m'hijo?"

Su voz es ronca. Años de café fuerte y cigarros.

* ["Ahí ando, Elena."] -> elena_ahi_ando
* ["Mal. Todo mal."] -> elena_todo_mal
* ["¿Y vos, Elena?"] -> elena_ella_como

=== elena_ahi_ando ===

"Ahí andamos todos."
# PORTRAIT:elena,remembering,right

Mira hacia la calle.

"¿Sabés cuántas veces escuché eso? 'Ahí ando'.
En el 2002 todo el mundo andaba 'ahí'.
Pero seguíamos."

* [...]
-

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

{es_vegano:
    "Y no me pongas cara con el guiso, m'hijo. Yo sé que vos tenés tus ideas, pero el estómago es un traidor que no sabe de ética cuando aprieta de verdad."
}

Tiene razón. O no.
Pero su certeza ayuda.

~ elena_relacion += 1

->->

=== elena_ella_como ===

"Vieja. Cada día más vieja."

Se ríe.

"Y peleando con la mínima. Diecinueve mil pesos que se van en remedios y la cuenta de la luz antes de que pueda verlos.
Pero acá sigo. Como el banco este. Como el barrio."

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

* [...]
-

"No teníamos nada. Pero teníamos bronca y teníamos manos.
Cocinábamos en la calle para que nos vieran. Para que supieran que no nos íbamos a morir en silencio."

"¿Cuántos venían?"

* [...]
-

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

* [...]
-

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

// Chequeo social: lograr que Elena se abra sobre el pasado
# DADOS:CHEQUEO
~ temp resultado_elena_abrir = chequeo_completo_social(elena_relacion, 4)
{ resultado_elena_abrir == 2:
    -> elena_escucha_critico
}
{ resultado_elena_abrir == 1:
    -> elena_escucha_exito
}
{ resultado_elena_abrir == 0:
    -> elena_escucha_fallo
}
-> elena_escucha_crit_fallo

= elena_escucha_critico
* [...]
-

Elena deja la taza. Te mira con ojos que vieron demasiado.

"¿Sabés qué aprendí en setenta años?"

"¿Qué?"

"Que nadie se salva solo. Lo aprendí a los golpes.
Cuando el barco se hunde, o armamos una balsa entre todos o nos ahogamos por separado."

* [...]
-

Hace una pausa larga. Algo se abre en ella.
# PAUSA

"Raúl pasó lo mismo que vos. Exactamente. Lo echaron del frigorífico un martes. Llegó a casa blanco. No habló en tres días."

"¿Qué hicieron?"

"Lo que vamos a hacer con vos. Sostenerlo. Un día a la vez."

~ elena_me_aconsejo = true
~ elena_relacion += 2
~ subir_conexion(2)
~ activar_red_o_nada()

"Y vení a la olla. Siempre hay un plato."
->->

= elena_escucha_exito
* [...]
-

"¿Sabés qué aprendí en setenta años?"

"¿Qué?"

"Que nadie se salva solo. Lo aprendí a los golpes.
Cuando el barco se hunde, o armamos una balsa entre todos o nos ahogamos por separado."

* [...]
-

"¿Y qué hago?"

"Lo que puedas. Un día a la vez.
No pensés en mañana. Pensá en hoy."

~ elena_me_aconsejo = true
~ elena_relacion += 1
~ subir_conexion(1)
~ activar_red_o_nada()

"Y vení a la olla. Siempre hay un plato."
->->

= elena_escucha_fallo
* [...]
-

Elena asiente. Despacio.

"Es jodido. Lo sé."

No dice mucho más. Toma café.
El silencio se estira.

"Vení a la olla si querés. Siempre hay un plato."

No se abrió del todo. Pero la puerta quedó entreabierta.

~ elena_relacion += 1
->->

= elena_escucha_crit_fallo
* [...]
-

Elena se queda callada. Demasiado callada.

"M'hijo... todos tenemos problemas."

Algo se cerró. Quizás no era el momento.
Quizás hablar de tus problemas le trajo fantasmas de los suyos.

Toman café en un silencio incómodo.

"Disculpá. Estoy cansada hoy."
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

* [...]
-

"Fue peor que esto. Mucho peor.
La gente no tenía para comer. Literal.
Los bancos cerrados. Todo cerrado."

"¿Cómo sobrevivieron?"

"Organizándonos. No esperando.
Entendiendo que la vergüenza es de ellos, no nuestra."

* [...]
-

Toma café.

"Las ollas no eran caridad. Eran trincheras.
El trueque, las asambleas... eran formas de decir 'acá estamos y no nos vamos'."

"¿Y después?"

"Después volvió todo. El país se acomodó para los que siempre están bien. Los políticos se votaron sus propios aumentos y nos dijeron que la 'crisis había pasado'. Pero la crisis no pasa para el que perdió la casa o el que se le rompió la familia. Nosotros nos quedamos acá, sosteniendo los pedazos que ellos tiraron por la ventana."

~ elena_relacion += 1
~ subir_conexion(1)

->->

// --- LA CHOLA Y ELENA ---

=== elena_sobre_la_chola ===

~ elena_hablo_de_chola = true

"¿La Chola? ¿La mamá de Sofía?"

Elena sonríe. Es la primera vez que la ves sonreír así.

"La Chola era mi hermana. No de sangre. De vida."

* [...]
-

"Nos conocimos en la fábrica textil del Cerro. Año 75. Yo tenía veinticinco, ella veintitrés. Turnos de diez horas cosiendo zapatos."

"¿Y?"

"Y nada. Trabajábamos, tomábamos mate, puteábamos al capataz. Pero cuando vino la dictadura, nos juntamos de verdad."

* [...]
-

"Éramos compañeras de fábrica, de huelga, de mate y de velorio."

* ["¿De velorio?"]
    "Enterramos a mucha gente juntas. Compañeros que se llevaron. Algunos que aparecieron. Otros que no."
    
    Silencio largo.
    # PAUSA

    "Pero seguíamos. Siempre seguíamos."
    -> elena_chola_cont

* ["¿Cuarenta años juntas?"]
    "Más. Nos vimos envejecer. Nos vimos enterrar maridos. Nos vimos criar hijos. Y cuando ella se enfermó..."
    -> elena_chola_cont

=== elena_chola_cont ===

* [...]
-

"Cuando la Chola se enfermó, estuve con ella hasta el final. En el hospital, tomándole la mano."

"¿Qué le dijiste?"

"Que iba a cuidar la olla. Y que iba a cuidar a Sofía."

* [...]
-

Pausa larga.
# PAUSA

"A veces le hablo todavía. A la foto que tengo en el aparador. Le cuento cómo está la olla. Le puteo cuando las cosas no salen."

Se ríe bajito.

"Ella me escucha. Estoy segura."

~ subir_conexion(1)
~ elena_relacion += 1

->->

=== elena_desalojo_garcia ===
// El desalojo de los García en los 90

~ elena_conto_desalojo = true

"¿Vos conociste a los García? Los que vivían en la esquina."

"No."

"Ya no están. Pero casi los sacan antes de tiempo."

* [...]
-

"Fue en el 98, creo. O 97. La mujer se había quedado sin laburo, el marido estaba enfermo. Debían tres meses de alquiler."

"¿Los iban a desalojar?"

"Vino la policía con el acta. A sacarlos a la calle. Con los gurises."

* [...]
-

Elena se toma el mate.

"Yo me enteré por la vecina de enfrente. Salí corriendo. Llamé a la Chola, a otras cuantas."

"¿Y qué hicieron?"

* [...]
-

"Nos paramos en la puerta. Yo adelante, con el mate en la mano y la mirada de alguien que no tiene nada que perder."

"¿Y la policía?"

"El oficial me dijo: 'Señora, apártese o la llevamos'. Yo le dije: 'Llevame entonces. Pero vas a tener que llevar a todas'."

* [...]
-

Sonríe. Una sonrisa feroz.

"Detrás mío había veinte mujeres del barrio. Y un par de tipos también, pero las que paraban la olla éramos nosotras."

"¿Funcionó?"

"El milico llamó por radio. No sé qué le dijeron. Pero se fueron. Los García se quedaron tres meses más, hasta que consiguieron otro lugar."

* [...]
-

Pausa.
# PAUSA

"La propiedad privada se termina donde empieza el frío de un guri. Eso no lo escribió ningún filósofo. Eso lo aprendí ese día."

~ subir_dignidad(1)
~ elena_relacion += 1

->->

=== elena_trueque_2002 ===
// Detalle del trueque en 2002

~ elena_conto_trueque = true

"¿Sabés lo que es el trueque?"

"Más o menos. Cambiar cosas, ¿no?"

"Cambiar lo que tenés por lo que necesitás. Sin plata. Porque la plata no servía para nada."

* [...]
-

"En el 2002, once intendencias aceptaron trueque. Hasta pagaban impuestos con carne. ¿Te imaginás? Yendo a la intendencia con un pedazo de carne para pagar la patente."

"No me lo imagino."

* [...]
-

"Nosotras organizamos trueque acá en el barrio. En el gimnasio de la parroquia."

"¿Cómo funcionaba?"

"Cada uno llevaba lo que tenía. Ropa vieja, herramientas, comida casera, verduras del fondo. Y cambiaba por lo que necesitaba."

* [...]
-

Elena mira hacia la pared. La foto de su marido.

"Yo cambié la ropa de mi marido muerto por leche en polvo para los nietos de una vecina."
# PAUSA

* [...]
-

"Recuerdo el olor de ese gimnasio. Humedad, desesperación... y solidaridad. Todo mezclado."

"¿Funcionó?"

"Funcionó hasta que la cosa se acomodó. Después todos fingimos que no había pasado. Pero yo me acuerdo. Yo siempre me acuerdo."

~ subir_conexion(1)
~ elena_relacion += 1

->->

=== elena_en_banco_2002 ===
// Escena del banco en 2002

~ elena_conto_banco = true

"Un día fui al Banco República a sacar mis ahorros. Cuarenta mil pesos. Todo lo que tenía."

"¿Y?"

"Me dijeron que no había efectivo. 'Vuelva mañana'. Volví al otro día. Lo mismo. 'Vuelva la semana que viene'."

* [...]
-

"Un viernes volví con la Chola y otras diez vecinas. No llevábamos martillos, pero sí la mirada de quien no tiene nada que perder."

"¿Y qué hicieron?"

* [...]
-

"Nos plantamos en el hall. No gritamos. No rompimos nada. Solo nos sentamos y nos quedamos mirando."

"¿Y?"

"El gerente llamó a un teléfono. Media hora después apareció el efectivo."

* [...]
-

Sonríe con satisfacción.

"A veces pararse es suficiente. Pero hay que saber pararse. Y hay que saber con quién."

~ subir_dignidad(1)
~ elena_relacion += 1

->->

=== elena_anarquismo ===
// El anarquismo visceral explícito

~ elena_hablo_politica = true

"Elena, ¿vos sos de algún partido?"

Se ríe con ganas.

"¿Partido? M'hijo, yo estuve en todos y en ninguno."

* [...]
-

"En los 70 estuve cerca del sindicato. Después de lo de la fábrica, me junté con los de la barriada. Después de la dictadura, voté al Frente algunas veces."

"Pero..."

"Pero aprendí que el de arriba siempre caga al de abajo. No importa el color de la bandera."

* [...]
-

Te mira fijo.

"Yo no soy anarquista de libro, m'hijo. Nunca leí a Bakunin. Pero sé una cosa: cada vez que alguien se pone por encima de otros, termina pisándolos."

"¿Entonces?"

* [...]
-

"Entonces la única defensa real es el compañero de al lado. No el partido. No el sindicato. No el Estado. El compañero."

* [...]
-

Hace una pausa.

"Los hombres hablan y miden quién la tiene más larga. Nosotras paramos la olla para que los gurises no se mueran. Esa es mi política."

~ subir_conexion(1)
~ elena_relacion += 1

->->

=== elena_frase_trinchera ===
// Tunnel: La olla como trinchera

Elena dice, mirando la olla:

"Esto no es caridad, m'hijo. Esto es trinchera."

Lo dice como quien dice una verdad eterna.

->->

// --- ELENA PREOCUPADA ---

=== elena_preocupada_olla_knot ===
# PORTRAIT:elena,worried,right

~ elena_preocupada_olla = true

Elena te busca. Cosa rara.
Ella nunca busca a nadie.

"Che. Necesito hablar."

"¿Qué pasa?"

* [...]
-

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

// Chequeo mental: procesar la gravedad de la situación de la olla
# DADOS:CHEQUEO
~ temp resultado_elena_olla_futuro = chequeo_completo_mental(elena_relacion, 4)
{ resultado_elena_olla_futuro == 2:
    "Sofía es terca. Como yo.
    Pero necesita gente."

    Elena te mira fijo. Algo cambia en su cara.

    "¿Sabés qué, m'hijo? Vos me hacés acordar a cuando empezamos en el 2002. La misma cara de asustado. Pero estás acá. Y eso es lo que importa."

    "Vamos a sacar esto adelante. Como sacamos todo."

    ~ elena_relacion += 2
    ~ subir_llama(1)
}
{ resultado_elena_olla_futuro == 1:
    "Sofía es terca. Como yo.
    Pero necesita gente."

    ~ elena_relacion += 1
}
{ resultado_elena_olla_futuro == 0:
    "Sofía es terca. Como yo.
    Pero necesita gente."

    Se te hace un nudo en el estómago.
    La gravedad de la situación te cae encima.
    ¿Puede cerrar la olla? ¿Qué pasa con las sesenta personas?

    ~ elena_relacion += 1
}
{ resultado_elena_olla_futuro == -1:
    "Sofía es terca. Como yo."

    Elena te mira. Ve algo en tus ojos.
    Miedo. Parálisis.

    "No te congeles, m'hijo. Congelarse es lo peor."

    Pero ya estás congelado.
    La responsabilidad te aplasta.

    ~ aumentar_inercia(1)
}

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

* [...]
-

"Se murió en el 2003. El corazón.
La crisis lo mató. Como a muchos."

Señala otra casa.

* [...]
-

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

~ activar_hay_cosas_juntos()

->->

=== elena_pedir ===
// Tunnel: Elena sabe pedir
// Uso: -> elena_pedir ->
Elena sabe cómo gestionar recursos.
No es mendigar.
Es sostener la red.
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

// === PROTAGONISTA SE QUIEBRA ===

=== protagonista_pide_ayuda ===
// El protagonista finalmente muestra vulnerabilidad
// Trigger: jueves o viernes, si ayudó en olla y tiene inercia alta

Elena está pelando papas.

Movimientos lentos, seguros. Años de práctica.

Te sentás al lado. Agarrás un cuchillo.

* [Pelar en silencio]
    -> pelar_silencio
* ["Elena, ¿puedo preguntarte algo?"]
    -> elena_pregunta_directa

=== pelar_silencio ===

Pelan.

El ruido del cuchillo contra la cáscara.

# PAUSA

"¿Qué te pasa, gurí?"

Elena no te mira. Sigue pelando.

* ["Nada."]
    "Mentira."
    Sigue pelando.
    -> protagonista_admision
* ["No sé."]
    -> protagonista_admision
* [Dejar el cuchillo]
    Dejás el cuchillo.
    Elena espera.
    -> protagonista_admision

=== elena_pregunta_directa ===

"Preguntá."

* ["¿Cómo hacés?"]
    "¿Cómo hago qué?"
    "Para seguir. Cuando todo se va a la mierda."
    -> protagonista_admision
* ["¿Alguna vez quisiste dejar todo?"]
    Elena deja de pelar. Te mira.
    "¿Vos querés dejar todo?"
    -> protagonista_admision

=== protagonista_admision ===

# PAUSA

"No sé qué estoy haciendo."

Lo dijiste.

"Me echaron. No tengo guita. No tengo plan. Vengo acá y ayudo pero no sé por qué. No sé si sirve de algo."

# PAUSA

Elena sigue pelando.

"Y tengo miedo. Todo el tiempo. De que se me acabe la plata, de no conseguir nada, de terminar..."

No terminás la frase.

* [...]
-

Silencio.

-> elena_respuesta_quiebre

=== elena_respuesta_quiebre ===

Elena termina una papa. Agarra otra.

"En el 2002 perdí todo."

# PAUSA

"El laburo, los ahorros, casi la casa. Raúl estaba enfermo. Los gurises chicos."

* [...]
-

"¿Sabés qué hice? Vine acá. A esta misma olla. Que en ese momento era un fogón en la calle."

"¿Y?"

# PAUSA

"Y pelé papas. Porque no sabía qué más hacer."

-> elena_consejo_quiebre

=== elena_consejo_quiebre ===

Te mira por primera vez.

"No tenés que saber qué estás haciendo. Solo tenés que seguir haciendo."

* ["¿Y si no alcanza?"]
    "Nunca alcanza. Pero hacemos igual."
    -> elena_cierre_quiebre
* ["Suena a resignación."]
    "No. Resignación es quedarte en tu casa esperando que alguien te salve. Esto es otra cosa."
    -> elena_cierre_quiebre
* [Asentir]
    -> elena_cierre_quiebre

=== elena_cierre_quiebre ===

"El miedo no se va, gurí. Se acompaña."

# PAUSA

Te pasa una papa.

"Dale. Que estas no se pelan solas."

~ elena_relacion += 1
~ subir_conexion(1)
~ disminuir_inercia(1)

Pelás.

El miedo sigue ahí.
Pero estás pelando papas.
Por ahora, alcanza.

->->

// --- FRAGMENTO NOCTURNO DE ELENA ---

=== elena_fragmento_noche ===

Elena no duerme mucho.
Los viejos no duermen.

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

// --- FRAGMENTOS NOCTURNOS DE ELENA ---

=== fragmento_elena_banco ===
Elena está en su casa.
La tele prendida. El mate frío.

Mira la foto de Raúl en la repisa.
"Vos me entenderías", le dice.

En el 2002 estaban todos en la calle.
Ahora cada uno en su casa.
Con su pantalla. Con su soledad.

Se acuesta.
El banco de la plaza la espera mañana.

->->

=== fragmento_elena_recuerdo ===
Elena no puede dormir.

Piensa en la olla de 2002.
En cómo empezó con tres ollas y un fogón.
En cómo terminaron siendo cincuenta.

{elena_relacion >= 3:
    Piensa en vos.
    "Tiene algo", se dice. "Algo de los de antes."
}

Se da vuelta en la cama.
El insomnio de los setenta es diferente.
No es ansiedad. Es inventario.

->->

=== fragmento_elena_cartas ===
Elena relee una carta vieja.
De su hermana en Buenos Aires.

"Venite, Elena. Acá hay trabajo."
La carta es de 2003.

Nunca se fue.
El barrio la necesitaba.
O ella necesitaba al barrio.
Da igual.

Guarda la carta. Apaga la luz.

->->
