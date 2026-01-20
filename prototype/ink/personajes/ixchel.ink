// ============================================
// PERSONAJE: IXCHEL
// Nombre significa "mujer de la luna" en maya
// Migrante guatemalteca, indígena Maya-K'iche'
// Representa la dignidad, el trabajo invisible,
// la cosmovisión ancestral y la resistencia global.
// ============================================

// --- ENCUENTRO CASUAL EN EL BARRIO ---

=== ixchel_encuentro_casual ===

Ves a una mujer barriendo la vereda frente a la mercería.
Es Ixchel. Siempre lleva un huipil colorido bajo el delantal de trabajo.
Se mueve con una parsimonia que contrasta con el ritmo frenético del barrio.

* [Saludar] -> ixchel_saludo
* [Ofrecerte a ayudarla] -> ixchel_ayudar
* [Seguir de largo] -> ixchel_ignorar

=== ixchel_saludo ===

"Buen día, Ixchel."

Ella levanta la vista. Sus ojos son profundos, como si vieran más allá de la calle rota.

"Buen día para quien sabe caminarlo", dice con una leve sonrisa.

{not tiene_laburo:
    "Lo veo cargando mucho peso en los hombros, joven. No todo lo que pesa es mochila."
- else:
    "Que la prisa no le quite el camino."
}

->->

=== ixchel_ayudar ===

"¿Te doy una mano con eso?"

Ixchel te entrega la escoba sin dudar.
"La limpieza es un acto sagrado. Gracias."

~ subir_conexion(1)
~ ixchel_estado = "ayudando"

Barrés juntos un rato. El sonido de la paja contra el cemento es hipnótico.

"¿Hace mucho que te viniste de Guatemala?"

"Guatemala vive en mi ombligo, joven. Mi familia cuidaba los cerros, defendiendo la tierra de los que venían con máquinas y papeles a decirnos que el agua tenía dueño."

* [...]
-

"Me vine hace cinco años, cuando los líderes empezaron a no volver a casa."

Hace una pausa. Sus manos siguen barriendo, pero sus ojos miran algo lejano.

"Mi tierra no sabe de fronteras, solo de heridas que aún supuran."

->->

=== ixchel_ignorar ===

Pasás rápido.
Ixchel sigue barriendo.
Para ella, el tiempo no es algo que se gasta, es algo que se habita.

->->

// --- EN LA OLLA ---

=== ixchel_en_olla ===

Ixchel está en un rincón, separando legumbres con una velocidad asombrosa.
Parece que sus manos tienen ojos propios.

"La diversidad es lo que hace al guiso", dice sin mirarte.

* ["¿Cómo hacés tan rápido?"]
    "Aprendí de mis abuelas. Ellas decían que el alimento se prepara primero con la intención y después con las manos."
* ["Parece un laburo pesado."]
    "El trabajo duro es el que se hace solo, joven. Dios nos dio manos para compartir la carga. Entre muchos, es celebración."

* [...]
-

~ subir_llama(1)

->->

=== ixchel_primer_encuentro_olla ===
// Tunnel: Primer encuentro con Ixchel en la olla
// Uso: -> ixchel_primer_encuentro_olla ->

Sofía te presenta a una mujer de rasgos indígenas.
Piel morena, cabello negro trenzado.
Bajo el delantal de cocina asoma un bordado colorado.

"Ella es Ixchel. Viene de Guatemala. Cocina mejor que todas nosotras juntas."

Ixchel sonríe con modestia.

"Mucho gusto, joven. Bienvenido a la olla."

Te dice "usted" aunque no parece mucho mayor que vos.
Es una formalidad antigua, respetuosa.

->->

// --- ESCENAS DE PROFUNDIDAD ---

=== ixchel_historia_tomas ===
// Historia del hermano desaparecido

~ hable_con_ixchel_profundo = true
~ ixchel_me_conto_de_tomas = true

Es de noche. La olla ya cerró.
Ixchel lava los platos en silencio.
Vos secás.

El silencio es cómodo hasta que ella lo rompe.

"Tenía un hermano. Tomás."

* [...]
-

"Era catequista, pero no solo de fe. Organizaba a la comunidad. Era vocero del Consejo de Pueblos K'iche'."

"¿Consejo?"

"Los que defendíamos la tierra de las mineras. Goldcorp, una empresa canadiense, vino a sacarnos el oro. Pero el oro estaba debajo de nuestras casas, de nuestros ríos."

* [...]
-

Sus manos siguen lavando, pero más lento.

"Tomás organizaba las consultas. Le preguntábamos al pueblo: ¿quieren la mina? Noventa y ocho por ciento dijo que no. Pero el gobierno ya había dado el permiso. Sin preguntarnos."

"¿Y qué pasó?"

* [...]
-

Silencio largo.

"Un día salió a una reunión y no volvió. Lo encontraron tres días después. La policía dijo 'ajuste de cuentas'. Nadie investigó."

Sigue lavando.

* ["Lo siento mucho."] -> ixchel_tomas_respuesta
* [Quedarte en silencio] -> ixchel_tomas_silencio

=== ixchel_tomas_respuesta ===

"Lo siento, Ixchel."

"Dios lo tiene en su gloria. Y yo lo tengo acá."

Se toca el pecho.

"Cada vez que barró, cada vez que cocino, hago lo que él hacía: cuidar a la comunidad. Eso no lo pueden matar."

~ subir_conexion(1)
~ ixchel_relacion += 1

->->

=== ixchel_tomas_silencio ===

No decís nada.
A veces las palabras sobran.

Ixchel sigue lavando.
Vos seguís secando.

El silencio dice lo que la boca no puede.

~ subir_conexion(1)
~ ixchel_relacion += 1

->->

=== ixchel_sobre_mina_marlin ===
// Historia de la Mina Marlin y la resistencia

~ ixchel_hablo_de_mina = true

"¿Sabés lo que es una mina a cielo abierto?"

No esperás la pregunta.

"Más o menos."

"Es cuando le arrancan la piel a la montaña. Usan cianuro para sacar el oro. El cianuro envenena el agua."

* [...]
-

"Mi comunidad, San Miguel Ixtahuacán, está sobre oro. Por eso vinieron. La empresa se llamaba Goldcorp. Canadiense."

"¿Canadá?"

"Sí. Los de lejos vienen a sacar lo de acá. Siempre fue así."

* [...]
-

"El agua empezó a enfermar a la gente. Las explosiones agrietaban las casas. Pero el gobierno decía que era progreso."

Sus ojos se endurecen por un momento.

"Nosotros hicimos consultas. Miles de personas votaron que no querían la mina. Pero los papeles del gobierno valen más que la voz del pueblo."

* ["¿Y qué hicieron?"]
    "Resistir. Marchar. Bloquear. Y algunos... algunos pagaron con la vida."
    
    Piensa en Tomás. No lo dice, pero vos sabés.
    
    ~ subir_dignidad(1)
    ->->

* ["Eso es horrible."]
    "Es la realidad, joven. Acá y allá, los de arriba toman y los de abajo aguantan. Pero el agua tiene memoria. La tierra tiene memoria. Nosotros también."
    
    ~ subir_conexion(1)
    ->->

=== ixchel_llegada_uruguay ===
// Historia de cómo llegó a Uruguay

~ ixchel_conto_llegada = true

"¿Cómo llegaste acá? ¿A Uruguay, digo?"

Ixchel sonríe, pero sin alegría.

"No lo elegí yo. Lo eligió un formulario."

* [...]
-

"Después de lo de Tomás, empecé a recibir amenazas. Notas debajo de la puerta. Llamadas donde nadie hablaba."

"La puta madre."

* [...]
-

"Una organización, SERPAJ, me contactó. Dijeron que podían sacarme del país por ACNUR. Refugiada."

"Y viniste acá."

"'Uruguay' era un nombre en un papel. No sabía ni dónde quedaba. Solo sabía que era lejos."

* [...]
-

Hace una pausa.

"El primer invierno casi me muero. Ocho grados me parecían el fin del mundo. Una vecina de la pensión me prestó una campera. Nunca se la pude devolver. Se mudó."

Se mira las manos.

"Pero acá estoy. Un día más lejos de la montaña. Un día más cerca de... no sé de qué. Pero sigo."

~ subir_conexion(1)
~ ixchel_relacion += 1

->->

=== ixchel_sobre_huipil ===
// El huipil como identidad

~ ixchel_hablo_de_huipil = true

Notás el bordado que asoma bajo su uniforme de limpieza.

"Eso que llevás... ¿qué es?"

Ixchel sonríe.

"Es mi huipil. La ropa de mi pueblo. Este diseño es de San Miguel Ixtahuacán. Las líneas rojas son el maíz. Las verdes, la montaña."

* [...]
-

"Lo uso debajo del uniforme de trabajo. Nadie lo ve."

"¿Por qué lo usás si nadie lo ve?"

* [...]
-

"Porque yo sé que está ahí."

Se toca el pecho, donde el bordado queda oculto.

"Cuando limpio oficinas, soy invisible. Pero debajo del delantal soy Ixchel Batz Ixcoy, maya-k'iche', hija de la montaña."

* [...]
-

"Ellos ven una empleada. Yo sé quién soy."

Es una armadura invisible.
Te das cuenta de que nunca pensaste en eso.

~ subir_dignidad(1)
~ subir_conexion(1)

->->

=== ixchel_sobre_xenofobia ===
// Respuesta a la xenofobia

Un vecino pasó y dijo algo ofensivo sobre "los que vienen de afuera".
Ixchel no bajó la cabeza. Ni siquiera dejó de separar las lentejas.

"¿No te jode?", preguntás.

"Él tiene el corazón nublado. Que el Señor lo perdone, porque no sabe que la tierra no le pertenece por un papel. La tierra es de Dios, nosotros solo la caminamos."

Te mira fijo.

"Ustedes los uruguayos a veces tienen miedo de ser nosotros. Pero en el hambre, todos tenemos la misma cara."

* [...]
-

"Además..."

Sonríe levemente.

"Yo estuve frente a soldados con fusiles. Un señor que dice tonterías en la calle no me quita el sueño."

~ subir_dignidad(1)
~ subir_conexion(1)

->->

=== ixchel_cosmovision ===
// La cosmovisión maya en lo cotidiano

Ixchel está pelando papas. Murmura algo en un idioma que no entendés.

"¿Qué decías?"

"Le hablaba a la papa."

* ["¿A la papa?"]
    "El maíz, la papa, el frijol... son seres, joven. No solo comida. Les pedimos permiso antes de comerlos."
    -> ixchel_cosmovision_cont
    
* [Sonreír]
    Ixchel nota tu sonrisa.
    
    "Le parece raro."
    
    "Un poco."
    
    "Es porque ustedes olvidaron. Nosotros todavía recordamos."
    -> ixchel_cosmovision_cont

=== ixchel_cosmovision_cont ===

"Mi abuela decía: 'El maíz no crece para nosotros. Crece con nosotros. Somos parientes'."

* [...]
-

"Por eso cuando cocino, no estoy solo trabajando. Estoy... ¿cómo se dice? Honrando."

* [...]
-

"Acá, en la olla, hacemos lo mismo. Convertimos comida en comunidad. Eso es sagrado."

~ subir_llama(1)

->->

=== ixchel_sincretismo ===
// El sincretismo religioso

Ixchel tiene una estampita de la Virgen de Guadalupe en su delantal.

"¿Sos católica?"

"Sí. Y también soy maya."

* ["¿No es contradictorio?"]

    "El Señor es grande. Tiene muchos nombres. Los españoles trajeron a María, pero ella se apareció morena, en el cerro del Tepeyac, hablando náhuatl."
    
    * [...]
    -
    
    "Guadalupe no es solo de ellos. Es de nosotros también. Es la madre tierra con otro vestido."
    
    ~ subir_conexion(1)
    ->->

* ["Entiendo."]

    "No hace falta elegir. Mi abuela rezaba el Padre Nuestro y después le hablaba a la montaña. Dios es grande, joven. Cabe todo."
    
    ->->

// --- TUNNELS PARA DÍAS ---

=== ixchel_en_cocina ===
// Tunnel: Ixchel cocinando
// Uso: -> ixchel_en_cocina ->

Ixchel corta verduras con una precisión de cirujano.
No parece esforzarse. Es natural, como respirar.

"La prisa es de los que olvidaron a dónde van", dice sin levantar la vista.

->->

=== ixchel_sirviendo ===
// Tunnel: Ixchel sirviendo comida
// Uso: -> ixchel_sirviendo ->

Ixchel sirve los platos con cuidado.
Un poco más para los que tienen cara de hambre.
Una sonrisa para cada uno.

"Buen provecho. Que Dios bendiga."

->->

=== ixchel_pelando ===
// Tunnel: Ixchel pelando papas
// Uso: -> ixchel_pelando ->

Ixchel pela papas.
Sus manos se mueven solas, como si supieran lo que hacen sin que ella les diga.

Te hace lugar en el banco.

"Siéntese. Hay papas para todos."

->->

=== ixchel_llamar ===
// Tunnel: Llamar a Ixchel
// Uso: -> ixchel_llamar ->

Llamás a Ixchel.
Tarda en contestar.

"¿Aló?"

"Hola, Ixchel. ¿Cómo estás?"

"Bien, gracias a Dios. ¿Y usted, joven?"

Siempre tan formal.
Siempre tan respetuosa.

->->

=== ixchel_conversacion_telefono ===
// Tunnel: Conversación telefónica con Ixchel
// Uso: -> ixchel_conversacion_telefono ->

Hablan un rato.
Ella cuenta de su trabajo, de la pensión, de las llamadas a Guatemala que salen carísimas.

"Pero mientras haya maíz, hay esperanza."

Su frase favorita.
Te queda sonando.

~ subir_conexion(1)

->->

// --- FRAGMENTO NOCTURNO ---

=== ixchel_fragmento_noche ===

Ixchel prende una vela pequeña en su cuarto.
El olor a copal llena el aire, tapando el olor a humedad de la pensión.

Frente a la vela hay una estampita de la Virgen de Guadalupe.
Al lado, una foto vieja de un hombre joven con camisa blanca.
Tomás.

* [...]
-

Reza en voz baja.
Primero en español. Después en k'iche'.
Las palabras se mezclan, como se mezclaron siempre.

{ixchel_me_conto_de_tomas:
    "Hermano, otro día más lejos. Pero no te olvido."
    "Cada plato que sirvo es para vos también."
}

* [...]
-

{ixchel_estado == "ayudando":
    Piensa en el joven.
    En cómo agarró la escoba.
    En que todavía hay manos que no tienen miedo de tocar la tierra.
    
    "Tal vez hay esperanza, Tomás."
}

* [...]
-

Mira la foto de las montañas en la pared.
Los volcanes de su tierra. El lago Atitlán al fondo.

"Un día más lejos de la montaña", murmura.
"Pero un día más cerca de Su voluntad y de la comunidad."

* [...]
-

Se envuelve en su rebozo.
Apaga la vela.

{ixchel_hablo_de_huipil:
    Debajo de la ropa de dormir, sigue llevando el huipil.
    Nadie lo ve.
    Pero ella sabe que está ahí.
}

Mañana hay que barrer de nuevo.
Mañana hay que sostener de nuevo.
Mañana hay que seguir siendo Ixchel.

->->

// --- RELACION CON OTROS PERSONAJES ---

=== ixchel_y_elena ===
// Interacción especial con Elena

Elena le pasa el mate a Ixchel.

"Tomá, m'hija."

Ixchel acepta con las dos manos, ceremonial.

"Gracias, doña Elena."

Elena la mira.

"Vos sabés lo que es que te quieran romper. Se te ve en los ojos."

"Usted también, doña."

* [...]
-

Se miran.
Dos guerreras de distintas guerras.
Pero la misma guerra.

"Los de arriba siempre quieren pisarnos", dice Elena.
"Pero acá seguimos. Como las piedras."

Ixchel asiente.

"Como las piedras."

~ subir_conexion(1)

->->

=== ixchel_y_diego ===
// Interacción especial con Diego

Diego e Ixchel descargan cajones juntos.
No hablan mucho. No hace falta.

Los dos saben lo que es huir.
Los dos saben lo que es empezar de cero.
Los dos saben lo que dejaron atrás.

"¿Extrañás Venezuela?", pregunta Ixchel.

"Todos los días."

"Yo también extraño Guatemala. Todos los días."

* [...]
-

Silencio.

"Pero acá estamos", dice Diego.

"Acá estamos", confirma Ixchel.

Es suficiente.

~ subir_conexion(1)

->->

=== ixchel_y_juan ===
// Interacción especial con Juan

Juan le pregunta a Ixchel sobre Guatemala.
Como si fuera un documental.

"¿Y los mayas todavía existen? Creía que..."

Ixchel lo mira.
No con enojo. Con paciencia.

"Existimos, sí. Millones. Y seguimos hablando nuestra lengua, tejiendo nuestra ropa, sembrando nuestro maíz."

* [...]
-

Juan se pone un poco incómodo.

"Ah. No sabía. Perdón si..."

"No hay nada que perdonar, joven. Solo aprender."

Le sonríe.
Juan no sabe qué decir.
Pero algo se mueve adentro suyo.

->->

=== ixchel_frase_maiz ===
// Tunnel: Frase del maíz
// Uso cuando alguien se desespera

Ixchel dice, pausada:

"Mientras haya maíz, hay esperanza."

Simple.
Profundo.
Te queda sonando.

->->

