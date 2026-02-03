// ============================================
// PERSONAJE: IXCHEL
// Nombre significa "mujer de la luna" en maya
// Migrante guatemalteca, indígena Maya-K'iche'
// Representa la dignidad, el trabajo invisible,
// la cosmovisión ancestral y la resistencia global.
// ============================================

// --- ENCUENTRO CASUAL EN EL BARRIO ---

=== ixchel_encuentro_casual ===

Ves a una mujer acomodando tejidos sobre un paño en la vereda.
Es Ixchel. Vende bordados y, cuando la dejan, tamales.
Un día bueno saca mil pesos. Un día malo, vuelve con la canasta llena.
Se mueve con una parsimonia que contrasta con el ritmo frenético del barrio.

* [Saludar] -> ixchel_saludo
* [Ofrecerte a ayudarla] -> ixchel_ayudar
* [Seguir de largo] -> ixchel_ignorar

=== ixchel_saludo ===

"Buen día, Ixchel."

Ella levanta la vista. Te mira directo, sin adornos.

"Buen día", dice seca. Sigue barriendo.

{not tiene_laburo:
    "Lo veo cargando mucho peso en los hombros, joven. No todo lo que pesa es mochila."
- else:
    "Que la prisa no le quite el camino."
}

->->

=== ixchel_ayudar ===

"¿Te doy una mano con eso?"

Ixchel te entrega la escoba sin dudar.
"Gracias. Hay mucho que hacer."

~ subir_conexion(1)
~ ixchel_estado = "ayudando"

Barrés juntos un rato. El sonido de la paja contra el cemento es hipnótico.

"¿Hace mucho que te viniste de Guatemala?"

"Guatemala vive en mi ombligo, joven. Mi familia cuidaba los cerros, defendiendo la tierra de los que venían con máquinas y papeles a decirnos que el agua tenía dueño."

* [...]
-

"Me vine hace cinco años, cuando los líderes empezaron a no volver a casa."
# PAUSA

Hace una pausa. Sus manos siguen barriendo, pero sus ojos miran algo lejano.

"Mi tierra no sabe de fronteras, solo de heridas que aún supuran."

->->

=== ixchel_ignorar ===

Pasás rápido.
Ixchel sigue barriendo.
No te mira. Tiene cosas que hacer.

->->

// --- EN LA OLLA ---

=== ixchel_en_olla ===

Ixchel está en un rincón, separando legumbres con una velocidad asombrosa.
Parece que sus manos tienen ojos propios.

"La diversidad es lo que hace al guiso", dice sin mirarte.

* ["¿Cómo hacés tan rápido?"]
    "Aprendí de mis abuelas. Ellas decían que el alimento se prepara primero con la intención y después con las manos."
    Te invita a sentarte a su lado. A separar lentejas.
    -> ixchel_cocinar_juntos
* ["Parece un laburo pesado."]
    "El trabajo duro es el que se hace solo, joven. Dios nos dio manos para compartir la carga. Entre muchos, es celebración."
    Te hace un lugar. Te pone un balde de legumbres adelante.
    -> ixchel_cocinar_juntos

=== ixchel_cocinar_juntos ===

// Chequeo físico: cocinar a la par de Ixchel
# DADOS:CHEQUEO
~ temp resultado_ixchel_cocinar = chequeo_completo_fisico(0, 3)
{ resultado_ixchel_cocinar == 2:
    Tus manos encuentran el ritmo. Rápido. Preciso.
    Ixchel te mira sorprendida.

    "Tiene buenas manos, joven. Mi abuela diría que el maíz lo eligió."

    Trabajan juntos en silencio. Un silencio sagrado.
    El guiso toma forma.

    ~ ixchel_relacion += 1
    ~ subir_llama(1)
    ~ subir_conexion(1)
}
{ resultado_ixchel_cocinar == 1:
    Separás lentejas. No tan rápido como ella, pero sin parar.
    Ixchel asiente. Conforme.

    El trabajo compartido habla por los dos.

    ~ subir_llama(1)
}
{ resultado_ixchel_cocinar == 0:
    Confundís lentejas con piedritas. Dos veces.
    Ixchel las saca sin decir nada.

    "Despacio. La lenteja no tiene apuro."

    Aprendés. Lento, pero aprendés.

    ~ subir_llama(1)
}
{ resultado_ixchel_cocinar == -1:
    Se te cae el balde. Las lentejas ruedan por el piso.

    "Ay, perdón..."

    Ixchel se ríe. Sin maldad. Con ternura.

    "Mi hermano Tomás hacía lo mismo. Manos de elefante, decía mi abuela."

    Juntan las lentejas del piso. Las lavan de vuelta.
    El desastre se convirtió en recuerdo compartido.

    ~ ixchel_relacion += 1
}

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

// --- ESCENA DE COCINA: IXCHEL ENSEÑA UNA RECETA ---

=== ixchel_ensena_pepian ===
// Escena donde Ixchel enseña a cocinar pepián

~ ixchel_enseno_receta = true

Ixchel está en la cocina de la olla antes que nadie.
El aire huele distinto. A especias que no conocés.

"Hoy voy a cocinar pepián", anuncia.

"¿Pepián?"

"Un guiso de mi tierra. Con pepitoria, ajonjolí, chile pasa... lo que haya."

* ["¿Puedo aprender?"]
    Ixchel te mira sorprendida. Después sonríe.
    "Venga. Le enseño."
    -> ixchel_pepian_clase
* ["Suena complicado."]
    "Todo parece complicado hasta que se hace. Después es solo manos y paciencia."
    -> ixchel_pepian_observar

=== ixchel_pepian_clase ===

Te pone delante de una tabla de cortar.

"Primero el tomate. Se asa. No se hierve. El fuego le saca el alma."

* [...]
-

Te muestra cómo poner el tomate directamente sobre la hornalla.
La piel se chamusca. El olor es increíble.

"En Guatemala usamos comal. Acá hay que improvisar."

* [...]
-

"Ahora la pepitoria. Semilla de calabaza. Se tuesta en seco."

Agarra un puñado de semillas y las pone en una sartén sin aceite.
El crepitar llena la cocina.

"Mi abuela me enseñó esto cuando tenía seis años. Yo quería jugar afuera. Ella me dijo: 'La cocina también es juego. Solo que después te lo comés'."

* [...]
-

"¿Y el secreto del pepián?"

Ixchel sonríe.

"El secreto es tiempo. En Guatemala dejamos que hierva horas. Acá no tenemos horas. Pero le ponemos intención. Y la intención cocina más que el fuego."

* [...]
-

Te pasa la cuchara.

"Revuelva. Despacio. Siempre para el mismo lado."

"¿Por qué para el mismo lado?"

"Porque así me enseñó mi abuela. Y ella no mentía."

// Chequeo físico: aprender a cocinar pepián
# DADOS:CHEQUEO
~ temp resultado_pepian = chequeo_completo_fisico(ixchel_relacion, 3)
{ resultado_pepian == 2:
    Revolvés con ritmo. El guiso empieza a espesar.
    Ixchel prueba con la cuchara. Cierra los ojos.
    
    "Le quedó bien, joven. Tiene mano para esto."
    
    Es el primer cumplido directo que te hace.
    
    ~ ixchel_relacion += 2
    ~ subir_conexion(1)
}
{ resultado_pepian == 1:
    Revolvés. Se pega un poco.
    Ixchel agrega agua sin decir nada.
    
    "La próxima vez, más despacio. Pero va bien."
    
    ~ ixchel_relacion += 1
}
{ resultado_pepian == 0:
    Se te quema el fondo.
    
    "No importa", dice Ixchel raspando. "Lo quemado también tiene sabor."
    
    No estás seguro de si es verdad o si te está consolando.
}
{ resultado_pepian == -1:
    Volcás la olla. Por suerte estaba casi vacía.
    
    Ixchel suspira. Pero no se enoja.
    
    "Empezamos de nuevo. En la cocina siempre se puede empezar de nuevo."
}

* [...]
-

"¿Sabés qué es lo mejor del pepián?"

"¿Qué?"

"Que sabe a casa. Aunque estés a miles de kilómetros."

# PAUSA

Prueba el guiso otra vez.

"Sí. Este sabe a casa."

Y vos entendés que no está hablando solo de especias.

~ subir_llama(1)
~ activar_comida_es_memoria()

->->

=== ixchel_pepian_observar ===

Mirás desde el costado mientras Ixchel cocina.

Sus manos se mueven con certeza absoluta.
No mide nada. No necesita receta.
Es memoria del cuerpo.

"En mi comunidad, las mujeres cocinan juntas. Cada una trae algo. Nadie cocina sola."

* [...]
-

"Acá es distinto. Cada casa es una isla. Cada cocina es un secreto."

Revuelve el guiso.

"Pero la olla es diferente. Acá cocinamos juntas. Como debe ser."

~ subir_conexion(1)

->->

=== ixchel_ensena_tortillas ===
// Escena adicional: tortillas de maíz

~ ixchel_enseno_tortillas = true

"¿Alguna vez hizo tortillas?"

"De las de paquete."

Ixchel niega con la cabeza. Casi ofendida.

"Eso no es tortilla. Le voy a enseñar."

* [...]
-

Saca un paquete de harina de maíz. "No es nixtamal de verdad, pero se puede."

Te enseña a amasar. A formar bolitas. A aplastarlas con la palma.

"En Guatemala usamos prensa. Acá, las manos. Las manos siempre sirven."

* [...]
-

La primera te queda deforme.
La segunda, irregular.
La tercera... casi.

"Así se aprende. Haciendo."

Pone tu tortilla en el comal.

"Ahora espere. Cuando se infle, está."

* [...]
-

La tortilla se infla. Un globito de maíz.

"¡Eso es! Ya sabe. Ahora puede hacerlas solo."

Arrancás un pedazo. Todavía caliente.

El sabor es distinto a todo lo que conocés.
Simple pero profundo.

"El maíz es sagrado", dice Ixchel. "Los mayas somos hijos del maíz. El Popol Vuh dice que los dioses nos hicieron de masa."

* ["Entonces somos parientes del maíz."]
    Ixchel sonríe. Amplia.
    "Sí. Somos parientes. Por eso hay que tratarlo con respeto."
    ~ ixchel_relacion += 1
    ->->
* ["Qué loco."]
    "¿Loco? Es más loco pensar que somos polvo de estrellas y no darle las gracias al cielo."
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

# PAUSA
Silencio largo.

"Un día salió a una reunión y no volvió. Lo encontraron tres días después. La policía dijo 'ajuste de cuentas'. Nadie investigó."

Sigue lavando.

* ["Lo siento mucho."] -> ixchel_tomas_respuesta
* [Quedarte en silencio] -> ixchel_tomas_silencio

=== ixchel_tomas_respuesta ===

"Lo siento, Ixchel."

"Dios lo tiene en su gloria. Y yo lo tengo acá."
# PAUSA

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

=== ixchel_tomas_infancia ===
// Historia de Tomás - la infancia compartida

~ ixchel_conto_tomas_infancia = true

"¿Tomás era mayor que vos?"

"Tres años mayor. Pero parecía de otra generación."

* [...]
-

"Cuando éramos niños, él me llevaba al cerro. A ver amanecer."

Ixchel sonríe. Un recuerdo dulce entre tanto dolor.

"Yo me quejaba del frío. Y él me decía: 'El frío es el abrazo de la montaña. No te resistas'."

* [...]
-

"Era así con todo. Sabía ver lo sagrado en lo que otros veían como molestia."

"Suena a alguien especial."

"Lo era. Por eso lo eligieron vocero. Y por eso lo mataron."

# PAUSA

"Pero eso ya se lo conté. Hoy le cuento de cuando éramos felices."

* [...]
-

"Una vez robamos mangos del árbol del vecino. Nos descubrieron. Mi papá quería pegarnos. Tomás dijo que había sido solo él. Que yo no sabía nada."

"Te protegía."

"Siempre me protegió."

La voz se le quiebra un segundo. Después se recompone.

"Por eso estoy acá. Porque él me dijo que me fuera. La última orden que me dio."

~ subir_conexion(1)
~ ixchel_relacion += 1

->->

=== ixchel_tomas_lider ===
// Historia de Tomás - cuando se convirtió en líder

~ ixchel_conto_tomas_lider = true

"¿Cuándo empezó Tomás con la resistencia?"

Ixchel piensa.

"No hubo un día. Fue como el río. Empezó con gotitas."

* [...]
-

"Primero ayudaba en la iglesia. Catequesis para los niños. Después empezó a hablar con los ancianos. A preguntar."

"¿A preguntar qué?"

"Por qué el agua del río estaba cambiando de color. Por qué había gente enferma. Por qué las casas se agrietaban con las explosiones de la mina."

* [...]
-

"Después empezó a leer. Leía todo. Derecho, historia, el Convenio 169... Decía que teníamos que saber nuestros derechos para defenderlos."

"¿Y la comunidad lo siguió?"

* [...]
-

"Al principio dudaban. 'No te metás con los poderosos', le decían. Pero Tomás respondía: 'Si no nos metemos, ellos se meten solos'."

Hace una pausa.

"Cuando hizo la primera consulta comunitaria, votaron más de diez mil personas. Noventa y ocho por ciento contra la mina."

"Increíble."

"Pero el gobierno lo ignoró. Y entonces Tomás entendió que el papel no alcanza. Que hay que organizarse."

# PAUSA

"Decía: 'El poder de ellos es el dinero. El nuestro es estar juntos'."

~ subir_dignidad(1)
~ subir_conexion(1)

->->

=== ixchel_tomas_ultimo_dia ===
// Historia de Tomás - el día que desapareció

~ ixchel_conto_tomas_ultimo = true

Es tarde. Casi todos se fueron.
Ixchel está mirando por la ventana. Como buscando algo en la distancia.

"¿En qué pensás?"

* [...]
-

Silencio largo.
# PAUSA

"En la última vez que lo vi."

No hace falta preguntar a quién.

* [...]
-

"Era martes. Iba a una reunión del Consejo en Huehuetenango."

"¿Lejos?"

"Tres horas en bus. Pero él siempre volvía."

* [...]
-

"Se puso su mejor camisa. La celeste. Yo le dije que estaba arrugada. Él se rio y dijo 'los arrugas son las arrugas de la lucha, hermanita'."

Sonríe. Pero los ojos se le humedecen.

* [...]
-

"Antes de salir se dio vuelta y me dijo: 'Cuídate'."

"¿Y vos?"

"Le dije: 'Vos también'. Él me sonrió y dijo: 'Siempre me cuido'."

# PAUSA

Silencio largo.

"Pero no se cuidó. O sí, pero no alcanzó."

* ["No fue culpa tuya."]
    "Ya sé. Es culpa de los que lo mataron. Pero a veces... a veces pienso que si le hubiera dicho algo más..."
    -> ixchel_tomas_ultimo_cont
* [Quedarte en silencio]
    -> ixchel_tomas_ultimo_cont

=== ixchel_tomas_ultimo_cont ===

"Lo encontraron tres días después. En una cuneta. Golpeado."

# PAUSA

"Mi mamá no quería que lo viera. Pero yo fui igual."

Las lágrimas caen ahora. No las detiene.

"Tenía la camisa celeste. Rota. Manchada."

* [...]
-

"Después de eso empezaron las amenazas. Notas debajo de la puerta. Llamadas donde nadie hablaba."

"Y te fuiste."

"Me fui. Pero una parte de mí se quedó en esa cuneta."

# PAUSA

Se seca los ojos con el dorso de la mano.

"Perdón. No sé por qué le cuento esto."

* ["Porque necesitabas contarlo."]
    "Sí. Capaz que sí."
    ~ ixchel_relacion += 2
    ~ subir_conexion(2)
    ->->
* ["No tenés que pedir perdón."]
    "Es que acá nadie sabe. Nadie pregunta. Soy 'la guatemalteca'. Nada más."
    ~ ixchel_relacion += 1
    ~ subir_conexion(1)
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
# PAUSA

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
# PAUSA

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

// --- COSMOVISIÓN Y ESPIRITUALIDAD ---

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

=== ixchel_virgen_guadalupe_profundo ===
// Conversación profunda sobre la Virgen de Guadalupe

~ ixchel_hablo_guadalupe_profundo = true

Es de noche. Ixchel está limpiando la estampita de la Virgen con un trapo.
Lo hace con reverencia, como si tocara algo vivo.

"¿Puedo preguntarte algo sobre la Virgen?"

"Pregunte."

* ["¿Por qué Guadalupe y no otra?"]
    -> ixchel_guadalupe_porque
* ["¿Desde cuándo la tenés?"]
    -> ixchel_guadalupe_historia
* ["¿Creés que te escucha?"]
    -> ixchel_guadalupe_escucha

=== ixchel_guadalupe_porque ===

"¿Por qué Guadalupe? Porque ella es como nosotros."

* [...]
-

"Mirela bien. Es morena. Tiene el cinto de las embarazadas. El manto lleno de estrellas. El sol atrás. La luna abajo."

"¿Y eso qué significa?"

"Que está parada sobre la luna. Más poderosa que los dioses aztecas. Pero al mismo tiempo, es humilde. Se le apareció a Juan Diego, un indio pobre."

* [...]
-

"Los españoles trajeron sus Vírgenes blancas, de pelo rubio. Pero Guadalupe se hizo morena. Habló en náhuatl. Se puso del lado de los de abajo."

Acaricia la estampita.

"Por eso mi gente la adoptó. No porque nos obligaran. Porque ella se hizo una de nosotros."

~ subir_conexion(1)
~ ixchel_relacion += 1

->->

=== ixchel_guadalupe_historia ===

"Esta estampita me la dio mi mamá cuando me fui."

* [...]
-

"Ella tenía dos. Una para ella, una para mí. Me dijo: 'Cuando te sientas sola, hablale. Ella entiende a las madres y a las hijas'."

"¿Le hablás?"

"Todas las noches. Le cuento del día. De lo que me pasó. De lo que extraño."

* [...]
-

"A veces le pido por mi mamá. Que esté bien allá. Que no se enferme."

Hace una pausa.
# PAUSA

"Y a veces le pido por Tomás. Que esté en paz. Que me perdone por haberme ido."

* ["No tenés nada que perdonarte."]
    "Ya sé. Pero el corazón no siempre escucha a la cabeza."
    ~ ixchel_relacion += 1
    ->->
* [Quedarte en silencio]
    A veces el silencio es la mejor respuesta.
    ->->

=== ixchel_guadalupe_escucha ===

"¿Si me escucha?"

Ixchel piensa.

"No sé si me escucha como usted me escucha. Pero cuando le hablo, algo cambia adentro mío."

* [...]
-

"Es como cuando uno le habla a los muertos. ¿Escuchan? No sé. Pero uno necesita hablarles."

"¿Le hablás a Tomás?"

"Todas las noches. A él y a ella."

* [...]
-

"Mi abuela decía que los santos son como teléfonos. Uno marca el número, pero quien contesta es Dios."

Se ríe bajito.

"Un teléfono muy viejo. A veces la línea está mala. Pero uno sigue intentando."

~ subir_conexion(1)

->->

=== ixchel_utz_kaslemal ===
// El concepto del buen vivir maya

~ ixchel_hablo_buen_vivir = true

"¿Alguna vez escuchaste del Ut'z Kaslemal?"

"¿Qué es eso?"

"Es... difícil de traducir. Algunos dicen 'buen vivir'. Pero es más que eso."

* [...]
-

"Es vivir en armonía. Con la comunidad. Con la tierra. Con los ancestros. Con uno mismo."

"Suena a utopía."

"No es utopía. Es cómo vivíamos antes de que vinieran a decirnos que había que 'progresar'."

* [...]
-

"El progreso de ellos es sacar, sacar, sacar. Oro, agua, madera. Dejar la tierra pelada y decir 'miren cuánto avanzamos'."

Hace una pausa.

"El Ut'z Kaslemal dice: tomá lo que necesitás, no lo que podés. Devolvé lo que tomaste. Cuida para los que vienen después."

* ["Como la olla."]
    Ixchel te mira. Sorprendida. Después sonríe.
    
    "Sí. Como la olla. Cada uno pone lo que puede. Cada uno toma lo que necesita. Nadie se lleva todo."
    
    ~ subir_conexion(1)
    ~ activar_hay_otra_forma()
    ->->
    
* ["Pero eso no funciona en el capitalismo."]
    "No. Por eso nos matan. Porque demostramos que hay otra forma."
    
    ~ subir_dignidad(1)
    ->->

// --- ESCENA: IXCHEL HABLA EN K'ICHE' SOLA ---

=== ixchel_hablando_kiche ===
// Escena donde el protagonista encuentra a Ixchel hablando en K'iche'

~ vio_ixchel_hablando_kiche = true

Es temprano. Casi no hay nadie en la olla.
Escuchás una voz desde la cocina. Canto. O rezo. No estás seguro.

Te acercás despacio.

* [Quedarte escuchando desde afuera]
    -> ixchel_kiche_escuchar
* [Entrar]
    -> ixchel_kiche_interrumpir

=== ixchel_kiche_escuchar ===

Ixchel está sola. De espaldas.
Habla en un idioma que no entendés.
Las palabras fluyen como agua de montaña.

"Ri uk'aslem... ri qa nan... ri loq'alaj..."

* [...]
-

No sabés qué dice, pero entendés algo.
Hay dolor en la voz. Y también paz.
Como si estuviera hablando con alguien que no está.

Después empieza a cantar. Bajito.
Una melodía que parece venir de muy lejos.

* [Quedarte hasta que termine]
    Te quedás. Inmóvil.
    La canción termina.
    Ixchel se da vuelta. Te ve.
    -> ixchel_kiche_descubierto
* [Irte sin que te vea]
    Te vas en silencio.
    Algunas cosas son privadas.
    Pero algo te quedó.
    El sonido de una lengua que no muere.
    ~ subir_conexion(1)
    ->->

=== ixchel_kiche_interrumpir ===

"Ixchel, ¿estás...?"

Se da vuelta. Sobresaltada.

"Ay. No lo escuché entrar."

Se limpia los ojos. ¿Estaba llorando?

-> ixchel_kiche_descubierto

=== ixchel_kiche_descubierto ===

"Perdón. No quería interrumpir."

"No interrumpió nada. Solo... hablaba con mis ancestros."

* ["¿En k'iche'?"]
    "Sí. Mi lengua materna. La lengua de mi abuela, de mi bisabuela..."
    -> ixchel_kiche_explicar
* ["¿Qué decías?"]
    "Les pedía fuerza para el día. Y les contaba cómo está la olla."
    -> ixchel_kiche_explicar

=== ixchel_kiche_explicar ===

* [...]
-

"Acá no hablo k'iche' con nadie. No hay nadie que entienda."

"Debe ser duro."

"Es como tener la mitad de la lengua atada. Puedo pensar, pero no puedo hablar."

* [...]
-

"Por eso hablo sola. Para no olvidar."

"¿Tenés miedo de olvidar?"

# PAUSA

"Todos los días olvido algo. Una palabra. Un sonido. Una forma de decir las cosas que no existe en español."

* [...]
-

"Mi abuela decía que cuando muere una lengua, muere una forma de ver el mundo. Yo no quiero que muera conmigo."

* ["¿Podés enseñarme algo?"]
    -> ixchel_kiche_ensenar
* ["Es muy valioso lo que hacés."]
    "Gracias. A veces me siento loca, hablando sola. Pero es lo que tengo."
    ~ ixchel_relacion += 1
    ~ subir_conexion(1)
    ->->

=== ixchel_kiche_ensenar ===

"¿Quiere aprender?"

"Una palabra. Al menos una."

Ixchel sonríe. Genuina.

"Saqarik. Significa 'amanecer'. Pero también significa 'nuevo comienzo'. Cada día es un saqarik."

"Sa-ka-rik."

"Casi. La 'q' suena más atrás. Como si viniera de la garganta."

Intentás de nuevo. Y otra vez.

"¡Eso! Muy bien."

* [...]
-

"Ahora sabe una palabra. Cuando la diga, piense en mí. Y en mi pueblo."

"Lo voy a hacer."

"Y yo voy a pensar que alguien acá sabe decir 'amanecer' en mi lengua."

Es poco. Pero es algo.
Un hilo que conecta dos mundos.

~ ixchel_relacion += 2
~ subir_conexion(1)
~ aprendio_palabra_kiche = true

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

// --- FRAGMENTOS NOCTURNOS ---

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

=== ixchel_fragmento_noche_tejido ===
// Fragmento nocturno de Ixchel - tejido

Ixchel cierra la puerta de su pieza.
Un cuarto compartido con dos mujeres más.

Se sienta en la cama.
Saca el telar de cintura de debajo del colchón.
Lo trajo de Guatemala. Lo único que no vendió.

Los hilos de colores brillan bajo la luz amarilla del foco.

* [...]
-

Empieza a tejer.
Un patrón que su abuela le enseñó.
Pájaros que nunca vio en Montevideo.
Montañas que están a miles de kilómetros.

El ritmo es hipnótico.
Adelante. Atrás. Apretar. Soltar.

* [...]
-

{ixchel_relacion >= 2:
    Hoy alguien le habló en la olla.
    No como "la boliviana" o "la guatemalteca".
    Como Ixchel.
    Eso vale más que el sueldo de un mes.
}

"Abuela", murmura mientras teje, "todavía me acuerdo. No me olvidé."

* [...]
-

Teje hasta que se le cierran los ojos.
El hilo se cae al piso.

En sueños, está en San Miguel Ixtahuacán.
El mercado lleno de colores.
El olor a incienso y maíz tostado.
La voz de su madre llamándola a comer.

Despierta con la mejilla mojada.

->->

=== ixchel_fragmento_noche_rio ===
// Fragmento nocturno de Ixchel - mirando el río

~ ixchel_fragmento_rio = true

Ixchel no puede dormir.
Sale de la pensión. Camina hasta el arroyo Pantanoso.

No es el río de su tierra. Ese era cristalino, frío, vivo.
Este huele a basura. Pero igual la llama.

* [...]
-

Se sienta en una piedra.
Mira el agua oscura moverse.

"Allá el río cantaba", dice en voz alta. A nadie. A todos.
"Este río susurra. Pero algo dice."

* [...]
-

Cierra los ojos.
Intenta escuchar.

Por un momento, el ruido de la ciudad desaparece.
Solo queda el agua.

"Tomás. ¿Estás ahí?"

* [...]
-

No hay respuesta. Nunca hay respuesta.
Pero el agua sigue fluyendo.

"El agua tiene memoria", le decía su abuela.
"Todo lo que tocó sigue en ella."

* [...]
-

Ixchel mete la mano en el agua.
Fría. Sucia. Pero viva.

"Aunque haya veneno", piensa, "sigue fluyendo."
"Como yo."

* [...]
-

{ixchel_me_conto_de_tomas:
    "Hermano, encontré gente acá. Gente buena."
    "No son de mi sangre. Pero son de mi camino."
}

Se queda un rato más.
Después vuelve a la pensión.

Mañana el río va a seguir ahí.
Y ella también.

->->

=== ixchel_fragmento_noche_rezo ===
// Fragmento nocturno expandido - rezando y hablando con Tomás

Ixchel prende el copal.
El humo sube en espirales.
Llena el cuarto de olor a montaña.

Frente a ella: la Virgen. La foto de Tomás. Una mazorca seca.

* [...]
-

"Ave María, llena de gracia..."

Empieza en español. Como le enseñaron en la escuela.

"...el Señor es contigo..."

Pero después las palabras cambian. Se vuelven k'iche'.

"Ri Ajaw kuk'ulaj chi awäch..."

* [...]
-

Termina el rezo. Abre los ojos.
Mira la foto de Tomás.

"Hermanito. Hoy pasó algo bueno."

* [...]
-

"Cociné pepián. ¿Te acordás del pepián de mamá? No quedó igual, pero se acercó."

Pausa.

"Hay un joven que me ayuda. No sé por qué, pero me escucha. No me mira como bicho raro."

* [...]
-

{ixchel_relacion >= 3:
    "Creo que hay gente buena acá, Tomás. Como la gente de la aldea."
    "Capaz que vos tenías razón. Capaz que la comunidad no es un lugar. Es cómo nos tratamos."
}

* [...]
-

"Te extraño. Todos los días te extraño."
# PAUSA

"Pero voy a seguir. Como me dijiste. Un día más."

Apaga el copal.
Se acuesta.

En la oscuridad, siente que Tomás sonríe.
Probablemente es imaginación.
Pero ayuda.

->->

// --- FRAGMENTOS NOCTURNOS ADICIONALES ---

=== fragmento_ixchel_cocina ===
Ixchel se lava las manos.
Rojas del agua caliente del restaurante.

El encargado gritó de vuelta.
"Boliviana" de vuelta.

No es boliviana. No importa.
Para ellos todos son lo mismo.

Se mira las manos.
Manos de su abuela. De su madre.
Manos que saben tejer y cocinar y sobrevivir.

Se duerme con las manos doloridas.
Mañana será otro día.

->->

=== fragmento_ixchel_altar ===
Ixchel tiene un altar pequeño.
Debajo de la cama, donde las otras no ven.

Una vela. Una foto de su abuela.
Un hilo de colores.

Reza en K'iche'.
Palabras que no entiende nadie en este país.
Palabras que la sostienen.

{ixchel_relacion >= 2:
    Hoy alguien la llamó por su nombre.
    No "boliviana". No "india".
    Ixchel.
    Agrega eso a la oración.
}

La vela se apaga. Se duerme.

->->

=== fragmento_ixchel_llamada_mama ===
// Llamada a Guatemala

Ixchel marca el número.
El de su mamá. El que sabe de memoria.

"¿Aló? ¿Mija?"

"Sí, mamá. Soy yo."

"¡Ay, m'hija! ¿Cómo estás?"

"Bien, mamá. Bien."

Mentira. Pero qué va a decir.

* [...]
-

Hablan quince minutos.
El máximo que puede pagar.

"¿Y allá cómo está todo?"

"Igual, m'hija. Igual."

Igual significa que sigue difícil.
Que la mina sigue funcionando.
Que nadie ha pagado por lo de Tomás.

* [...]
-

"Te quiero, mamá."

"Yo también, m'hija. Que Dios te cuide."

Corta.

Se queda mirando el teléfono.
Tan cerca y tan lejos al mismo tiempo.

->->

// --- RELACION CON OTROS PERSONAJES ---

=== ixchel_y_elena ===
// Interacción especial con Elena

~ ixchel_hablo_con_elena = true

Elena le pasa el mate a Ixchel.

"Tomá, m'hija."

Ixchel acepta con las dos manos, ceremonial.
El olor a yerba le recuerda al pericón de su abuela. No es igual, pero tiene algo.

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

=== ixchel_y_elena_profundo ===
// Interacción más profunda con Elena

~ ixchel_hablo_elena_profundo = true

Elena e Ixchel están solas en la cocina.
Pelan papas en silencio.

"¿Cuántos años tenés, m'hija?"

"Treinta y cinco, doña."

"Treinta y cinco. A tu edad yo ya había enterrado a mi padre y parido dos hijos."

* [...]
-

"¿Y usted cuántos tiene?"

"Setenta y tres. Y cada arruga es una batalla."

Ixchel sonríe.

"En mi pueblo decimos que las arrugas son los ríos del alma. Cuantos más ríos, más sabia el alma."

* [...]
-

Elena la mira. Diferente.

"¿Eso dicen?"

"Sí. Mi abuela tenía la cara llena de ríos. Era la más sabia de la aldea."

Elena se ríe. Ronco. Genuino.

"Me gusta eso. Ríos del alma."

* [...]
-

Silencio.

"Vos perdiste a alguien", dice Elena. No es pregunta.

"A mi hermano."

"Yo perdí a mi marido. Y a compañeros. Muchos compañeros."

* [...]
-

Elena deja de pelar. Mira a Ixchel.

"No te voy a decir que pasa. Porque no pasa. Pero se aprende a cargar."

"¿Cómo?"

"Con otros. Sola no se puede."

~ subir_conexion(1)
~ ixchel_relacion += 1
~ elena_relacion += 1

->->

=== ixchel_y_diego ===
// Interacción especial con Diego

~ ixchel_hablo_con_diego = true

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

=== ixchel_y_diego_profundo ===
// Interacción más profunda con Diego - migrantes

~ ixchel_diego_hablaron_profundo = true

Diego e Ixchel están sentados afuera.
Descanso de cinco minutos.

"¿Por qué te fuiste de Venezuela?"

Diego la mira.

"¿Por qué te fuiste de Guatemala?"

* [...]
-

Se ríen los dos. Amargo pero cómplice.

"No hace falta contar", dice Ixchel.

"No. Pero a veces ayuda."

* [...]
-

Silencio.

"A mi hermano lo mataron", dice Ixchel.

"A mi cooperativa la destruyeron", dice Diego.

No hay competencia. No hay comparación.
Solo dos heridas que se reconocen.

* [...]
-

"Los uruguayos no entienden", dice Diego.

"Algunos sí. Pero tienen que querer entender."

"¿Y si no quieren?"

* [...]
-

"Entonces seguimos sin ellos. Pero mejor con ellos."

Diego asiente.

"Vos sos sabia, Ixchel."

"No. Soy vieja antes de tiempo."

Se ríe. Diego también.

~ subir_conexion(1)
~ ixchel_relacion += 1
~ diego_relacion += 1

->->

=== ixchel_y_diego_reconocimiento ===
// Momento de reconocimiento entre migrantes

Es de noche. La olla terminó.
Diego e Ixchel lavan platos juntos.

"¿Sabés qué es lo más difícil?", pregunta Diego.

"¿Qué?"

"Que nadie te pregunte cómo estás de verdad."

* [...]
-

Ixchel asiente.

"Te preguntan '¿cómo estás?' pero no quieren escuchar la respuesta."

"Exacto. Quieren que digas 'bien'. Que sigas caminando."

* [...]
-

"En mi pueblo, cuando alguien vuelve de lejos, lo sientan. Le dan de comer. Le preguntan todo. Todo."

"¿Y acá?"

"Acá la gente tiene prisa. No hay tiempo para escuchar."

* [...]
-

Diego la mira.

"Yo te escucho."

"Yo también te escucho."

Silencio.

"Somos los que escuchamos", dice Ixchel.

"Porque sabemos lo que es que nadie te escuche."

Siguen lavando.
Pero algo cambió.
Ya no son dos solos.
Son dos juntos.

~ subir_conexion(2)
~ ixchel_relacion += 1
~ diego_relacion += 1

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

=== ixchel_y_juan_xenofobo ===
// Juan dice algo xenófobo y Ixchel responde con paciencia

~ ixchel_aguanto_xenofobia_juan = true

Están en la olla. Juan habla con otros.

"No, pero Ixchel es distinta. Ella trabaja, se esfuerza. No como otros que vienen a..."

Se da cuenta de que Ixchel está escuchando.
Se calla.

* [...]
-

Silencio incómodo.

Ixchel sigue pelando papas. Como si nada.

"Otros también trabajan", dice sin levantar la vista.

"No, yo no decía que..."

"Sé lo que decía, joven."

* [...]
-

Ahora sí lo mira.

"Cuando uno huye de su tierra, no es porque quiere. Es porque no puede quedarse."

"Ya sé, pero..."

"No. No sabe. Pero puede aprender."

* [...]
-

Juan se calla.
Ixchel vuelve a las papas.

"Yo también era como usted. Pensaba que los de la capital eran todos ladrones. Que los de la costa eran flojos."

"¿Y?"

"Y después conocí gente. Y aprendí que la gente es gente. No importa de dónde venga."

* [...]
-

Juan no dice nada.
Pero se queda.
No se va.

Eso ya es algo.

~ subir_conexion(1)

->->

=== ixchel_y_juan_despues ===
// Interacción posterior - Juan se disculpa

~ juan_se_disculpo_ixchel = true

Juan se acerca a Ixchel. Incómodo.

"Ixchel. Lo de ayer... lo que dije..."

"¿Sí?"

"Estuvo mal. Perdón."

* [...]
-

Ixchel lo mira. Evalúa.

"No me ofendió a mí, joven. Ofendió a los que no pueden defenderse."

"Ya sé. Por eso..."

"El perdón no se pide. Se gana."

* [...]
-

Juan no sabe qué decir.

"¿Cómo lo gano?"

"Tratando a todos como me trata a mí. No como 'distinta'. Como persona."

* [...]
-

Juan asiente. Serio.

"Lo voy a intentar."

"Intentar ya es algo."

Le pasa una papa y un cuchillo.

"Ahora ayude. Que hay mucho que hacer."

Juan empieza a pelar.
Torpemente. Pero empieza.

~ subir_conexion(1)
~ juan_relacion += 1

->->

// --- ESCENA CLAVE: CRÍTICA A LA IZQUIERDA ACADÉMICA ---

=== ixchel_critica_academica ===
// Esta escena muestra a Ixchel con agencia política crítica

~ ixchel_hablo_de_ayni = true

Están en la olla después del cierre.
Alguien trajo un libro de la facultad.

"Es sobre economía solidaria", dice. "Súper interesante."

Ixchel mira el libro. Se ríe bajito.

* [...]
-

"¿Qué pasa?", preguntás.

"Nada. Es que ustedes le ponen nombres nuevos a todo."

* [...]
-

"'Economía solidaria'. En mi comunidad se llama ayni. Se llama mink'a.
Lo venimos haciendo hace quinientos años.
Pero claro, si no tiene paper académico, no cuenta."

* [...]
-

Se cruza de brazos.

"Una vez vino una profesora de la universidad a mi pueblo.
A 'estudiar nuestras prácticas ancestrales'.
Tres semanas nos filmó, preguntó, anotó.

¿Sabés qué hizo después?"

"¿Qué?"

* [...]
-

"Publicó un libro. El libro costaba más de lo que ganamos en un mes.
Nosotros ni lo pudimos leer."

Silencio incómodo.

* [...]
-

"No digo que la solidaridad esté mal, joven.
Digo que algunos vienen a explicarnos lo que ya sabemos.
Y de paso se llevan el crédito."

* ["Tenés razón."]
    "No es cuestión de razón. Es cuestión de respeto."
    
    Pausa.
    
    "Pero bueno. Por lo menos acá se hace algo.
    Mejor hacer mal que explicar bien."
    
    ~ subir_dignidad(1)
    ~ subir_conexion(1)
    ->->
    
* [Quedarte callado]
    El silencio dice más que las palabras.
    
    Ixchel vuelve a ordenar.
    No hace falta respuesta.
    ->->

=== ixchel_sobre_ayni ===
// Escena sobre economías del cuidado

Ixchel te ve ayudando a cargar cosas.

"Ayni", dice.

"¿Eh?"

"En quechua. Mi abuela lo usaba.
Significa: 'Yo te doy, vos me das'.
No es trueque. No es préstamo.
Es ciclo. Como la luna. Como el agua."

* [...]
-

"Cuando cocinamos acá, no es caridad.
Es ayni. Los que tienen verduras traen verduras.
Los que tienen manos traen manos.
Los que tienen hambre traen hambre.
Todo sirve."

* [...]
-

"El capitalismo dice: 'Dame primero, después te doy'.
Ayni dice: 'Damos juntos, recibimos juntos'.

Suena simple. Pero cambiaría todo."

~ activar_autonomia_posible()
~ activar_ayni()

# IDEA DESBLOQUEADA: "LA RECIPROCIDAD ES SUPERVIVENCIA"

# IDEA DESBLOQUEADA: "PODEMOS ORGANIZARNOS SIN JEFES"

Otra forma de vivir ya existe.
Solo que la llaman "economía informal"
para que parezca menos peligrosa.

->->

// --- ESCENA CLAVE: MOMENTO DE ALEGRÍA COLECTIVA ---

=== ixchel_momento_alegria ===
// No todo es dolor - momentos de alegría colectiva

La olla terminó.
La olla cerró llena, todos comieron.
Sobró, incluso. Cosa rara.

Alguien puso música. Cumbia.

Ixchel se ríe.

"¡Esto me recuerda a las fiestas en mi pueblo!"

Se pone a bailar. Pequeños pasos, brazos en alto.
Los demás la miran sorprendidos. Después se suman.

* [Bailar]
    Te sumás. No sabés bailar cumbia. No importa.
    
    Diego te agarra del brazo y te marca el paso.
    "Así, así. Uno-dos, uno-dos."
    
    Sofía se ríe a carcajadas.
    Elena palmea desde la silla.
    
    Por un rato, solo existe esto.
    Cuerpos moviéndose. Risas. Música.
    
    ~ disminuir_inercia(1)
    ~ subir_conexion(1)
    ~ subir_llama(1)
    ->->

* [Quedarte mirando]
    Mirás desde afuera.
    
    Pero algo te toca igual.
    La alegría de los otros.
    
    Diego te hace señas para que te sumes.
    Negás con la cabeza.
    
    "¡Mañana!", dice.
    
    ~ disminuir_inercia(1)
    ->->

// --- IXCHEL EN LA OLLA (JUEVES-SABADO) ---

=== ixchel_encuentro_olla ===
// Encuentro en la olla
# PORTRAIT:elena,neutral,right

{ixchel_estado == "desconocida":
    Hay una mujer que no conocés.
    Morena, pelo largo y negro. Trabaja en silencio.
    Pela papas más rápido que nadie.

    * [Acercarte]
        "Hola. ¿Primera vez?"
        Te mira. Ojos oscuros, profundos.
        "No. Vengo hace un mes."
        ~ ixchel_estado = "conocida"
        ~ ixchel_relacion += 1
        ->->
    * [Seguir de largo]
        ->->
- else:
    Ixchel está en la cocina. Como siempre.

    * [Saludarla]
        "Hola, Ixchel."
        Sonríe apenas. "Hola."
        ~ ixchel_relacion += 1
        ->->
    * [Trabajar cerca]
        Te ponés a pelar al lado de ella.
        No hace falta hablar.
        ->->
}

=== ixchel_conversacion_profunda ===
// Conversacion cuando hay confianza
# PORTRAIT:elena,neutral,right

{ixchel_relacion >= 3:
    Ixchel te mira diferente hoy.
    "¿Puedo contarte algo?"

    * ["Claro."]
        // Chequeo social: comunicación intercultural, entender su mundo
        # DADOS:CHEQUEO
        ~ temp resultado_ixchel_comunicar = chequeo_completo_social(ixchel_relacion, 4)
        { resultado_ixchel_comunicar == 2:
            "Allá, en Quetzaltenango, mi abuela tejía.
            Huipiles con pájaros y montañas.
            Cada color tenía un significado."

            Pausa.

            "Acá limpio grasa. Pero sigo tejiendo.
            No con hilos. Con esto."

            Señala la olla. La gente.

            "La comunidad es un tejido. ¿Entendés?"

            Algo te cruza. No solo entendés. Lo sentís.

            "Sí. Y cada uno de nosotros es un hilo."

            Ixchel sonríe. Amplia. Real.

            "Exacto. Ya entendés, joven."

            ~ ixchel_conto_historia = true
            ~ ixchel_relacion += 2
            ~ subir_conexion(2)
            ~ activar_esto_es_lo_que_hay()
        }
        { resultado_ixchel_comunicar == 1:
            "Allá, en Quetzaltenango, mi abuela tejía.
            Huipiles con pájaros y montañas.
            Cada color tenía un significado."

            Pausa.

            "Acá limpio grasa. Pero sigo tejiendo.
            No con hilos. Con esto."

            Señala la olla. La gente.

            "La comunidad es un tejido. ¿Entendés?"

            ~ ixchel_conto_historia = true
            ~ ixchel_relacion += 1
            ~ subir_conexion(1)
            ~ activar_esto_es_lo_que_hay()
        }
        { resultado_ixchel_comunicar == 0:
            "Allá, en Quetzaltenango, mi abuela tejía.
            Huipiles con pájaros y montañas."

            Pausa.

            "Acá es diferente. Pero sigo intentando."

            No entendés del todo. Pero escuchás.
            A veces eso alcanza.

            ~ ixchel_relacion += 1
        }
        { resultado_ixchel_comunicar == -1:
            "Allá, en Quetzaltenango..."

            Se detiene. Te mira.

            "No importa. Son cosas mías."

            Algo en tu cara la frenó. Quizás incomprensión.
            Quizás distancia.
            El mundo de Ixchel queda lejos. Demasiado lejos hoy.
        }
        ->->
    * ["Ahora no puedo."]
        Asiente. Sin ofenderse.
        "Otro día."
        ->->
- else:
    Ixchel está ocupada. No es momento.
    ->->
}

// --- IXCHEL EN LA ASAMBLEA ---

=== ixchel_en_asamblea ===
// Participación de Ixchel en la asamblea

~ ixchel_participo_asamblea = true

La asamblea está tensa.
Todos hablan. Pocos escuchan.

Ixchel está en un rincón. Callada.
Como siempre.

Pero cuando hay un silencio, habla.

"Disculpen."

Todos se dan vuelta.

* [...]
-

"En mi comunidad, cuando hay asamblea, primero se escucha a los ancianos. Después a los jóvenes. Después se decide."

"¿Y?"

"Y acá todos hablan al mismo tiempo. Nadie escucha."

* [...]
-

Silencio incómodo.

Elena asiente.

"La guatemalteca tiene razón. A ver. De a uno."

* [...]
-

La asamblea se reordena.
No perfectamente. Pero mejor.

Ixchel no dice nada más.
No hace falta.
Su silencio pesa más que muchas palabras.

~ subir_conexion(1)

->->

=== ixchel_intervencion_asamblea ===
// Ixchel interviene en un momento clave de la asamblea

Están discutiendo si aceptar la ayuda del gobierno.
Las opiniones están divididas.

"Si aceptamos, nos van a controlar."
"Pero si no aceptamos, no llegamos a fin de mes."
"Prefiero cerrar antes que arrodillarme."

Ixchel levanta la mano. Cosa rara.

* [...]
-

"En Guatemala, las mineras también ofrecían 'ayuda'. Escuelas. Hospitales. Caminos."

"¿Y?"

"Y después nos cobraban la ayuda. 'Ya les dimos tanto, ahora dejen que saquemos el agua'."

* [...]
-

Pausa.

"No digo que sea lo mismo. Solo digo que hay que preguntarse: ¿qué van a pedir a cambio?"

Sofía asiente.

"Tiene razón. Hay que leer la letra chica."

* [...]
-

La asamblea sigue. Pero con otro tono.
Más cauteloso. Más sabio.

Ixchel vuelve a su silencio.
Pero dejó semilla.

~ subir_dignidad(1)
~ subir_conexion(1)

->->

// --- CIERRE DOMINICAL ---

=== ixchel_cierre_domingo_escena ===
// Escena de cierre en domingo

~ ixchel_cierre_domingo = true

Es domingo a la tarde.
La olla cerró.
Todo limpio. Todo guardado.

Ixchel está sentada afuera. Sola.
Mira el cielo.

Te sentás a su lado.

* [...]
-

"¿En qué pensás?"

"En mi mamá. Hoy es el cumpleaños de mi abuela. Ella murió hace diez años, pero mi mamá sigue haciendo tamales."

"Qué lindo."

"Sí. Y qué triste. Porque yo no estoy ahí para comerlos."

* [...]
-

Silencio.

"¿Sabés qué me dijo mi abuela antes de morir?"

"¿Qué?"

"'Ixchel, nunca te olvides de dónde venís. Pero tampoco te olvides de adónde vas'."

* [...]
-

"Creo que recién ahora entiendo."

"¿Qué entendés?"

"Que de dónde vengo está acá." Se toca el corazón.
"Y adónde voy... es con ustedes."

* [...]
-

Te mira.

"Gracias por escucharme esta semana. Sé que hablo mucho de Guatemala. Debe ser aburrido."

* ["No es aburrido. Es importante."]
    "Gracias, joven. De verdad."
    ~ ixchel_relacion += 1
    ~ subir_conexion(1)
    -> ixchel_cierre_domingo_fin
* ["Me gustaría ir algún día."]
    "Ojalá. Ojalá pueda volver yo también."
    ~ subir_conexion(1)
    -> ixchel_cierre_domingo_fin

=== ixchel_cierre_domingo_fin ===

Se para. Se sacude la pollera.

"Bueno. Hay que descansar. Mañana empieza otra semana."

"Otra semana."

"Otro saqarik."

{aprendio_palabra_kiche:
    Le sonreís. Saqarik. Amanecer. Nuevo comienzo.
    Ella sonríe de vuelta.
}

Se va caminando hacia la pensión.

La mirás irse.
Una mujer de la montaña, caminando por el Cerro.
Lejos de casa. Pero en casa.

Mientras haya maíz, hay esperanza.

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
