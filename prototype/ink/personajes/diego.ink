// ============================================
// PERSONAJE: DIEGO
// Venezolano, llegó hace poco
// Trabaja en depósito, situación precaria
// ============================================

// --- ENCUENTRO CASUAL EN EL BARRIO ---

=== diego_encuentro_casual ===

Diego camina rápido.
Siempre camina rápido.

Venezolano. Llegó hace dos años.
Trabaja en el depósito de la zona industrial.
Turnos de doce horas. Pago en negro.

Tiene la mirada de los que no pueden parar.

* [Saludar] -> diego_saludo
* [Preguntarle cómo le va] -> diego_como_va
* [Seguir caminando] -> diego_ignorar

=== diego_saludo ===

"Hey, Diego."

Se frena. Sorprendido.
No mucha gente le habla.

"Hola, ¿cómo estás?"

El acento. Suave pero presente.

"Bien. ¿Y vos? ¿El laburo?"

"Ahí. Cansado, pero bien."

Siempre dice que está bien.
Aunque no esté.

->->

=== diego_como_va ===

"Diego. ¿Cómo te va?"

Se detiene. Piensa.

"Bien... bueno, más o menos."

Mira para los lados. Como si alguien pudiera escuchar.

"El trabajo está raro. Nos quieren tratar como piezas de repuesto. Pero ya vi venir esto antes."

"¿Te preocupa?"

"Preocuparse es perder el tiempo. Hay que moverse. La red sostiene, hermano, pero uno tiene que ser parte del nudo."

~ diego_relacion += 1

->->

=== diego_ignorar ===

Diego sigue caminando.
No nota que pasaste.
O finge no notar.

Cada uno con sus problemas.

->->

// --- EN EL BARRIO ---

=== diego_encuentro_barrio ===
// Tunnel: Encuentro casual en el barrio

~ subir_conexion(1)

Encontrás a Diego.
Está saliendo del depósito.

"¿Qué hacés acá? ¿No laburabas?"

->->

=== diego_caminar_juntos ===
// Tunnel: Caminar juntos

~ energia -= 1
~ subir_conexion(1)

Caminan.
Hablan de boludeces.
Por un rato, casi te olvidás.

->->

// --- EN LA OLLA POPULAR ---

=== diego_en_olla ===

Diego está descargando cajones.
Camisa arremangada. Transpirado.
Se mueve rápido, como siempre.

~ diego_viene_a_olla = true

"No sabía que venías acá."

"Vengo a dar una mano. Los domingos no trabajo y...
bueno, hay que hacer algo."

* ["Qué grande, Diego."] -> diego_tranquilizar
* ["¿Te tratan bien?"] -> diego_pregunta_situacion
* [Asentir y seguir] -> diego_no_presionar

=== diego_tranquilizar ===

"Qué grande, Diego. Hace falta gente."

Sonríe. Se seca la frente.

"En Venezuela yo organizaba los operativos de comida en Petare. Sé cómo es la logística cuando no hay nada. Acá les faltaba alguien que supiera estirar los recursos."

"Siempre falta gente."

"Falta organización. Brazos sobran, lo que falta es saber hacia dónde empujarlos."

Te hace una seña. Hay cajones para descargar.

// Chequeo físico: trabajar a la par de Diego
# DADOS:CHEQUEO
~ temp resultado_diego_fisico = chequeo_completo_fisico(1, 4)
{ resultado_diego_fisico == 2:
    Agarrás un cajón de papas. Pesado. Lo cargás sin parar.
    Diego te mira con respeto.
    "Sos fuerte, hermano. Si todos empujaran así..."
    Trabajan juntos. A la par. Sin hablar.
    El trabajo dice lo que las palabras no.
    ~ diego_relacion += 2
    ~ subir_conexion(1)
}
{ resultado_diego_fisico == 1:
    Ayudás a cargar. Cuesta, pero se puede.
    Diego asiente. Trabajan juntos.
    ~ diego_relacion += 1
}
{ resultado_diego_fisico == 0:
    Intentás cargar un cajón. Es más pesado de lo que parece.
    Diego agarra el otro lado sin decir nada.
    "Entre los dos es más fácil."
    No es debilidad. Es equipo.
    ~ diego_relacion += 1
}
{ resultado_diego_fisico == -1:
    Agarrás un cajón. Se te resbala.
    Las papas se desparraman por el piso.
    "Tranquilo, tranquilo." Diego se agacha a juntar.
    Te agachás con él. Rojo de vergüenza.
    "A todos nos pasa. Las papas son traicioneras."
    Sonríe. No te juzga.
}

Sofía le pasa una botella de agua.
Él sigue cargando cosas.
No para.

->->

=== diego_pregunta_situacion ===

"¿Está muy jodido?"

Baja la voz.

"El mes pasado no pude mandar plata a mi familia.
Primer mes en ocho que no mando."

~ diego_familia_en_venezuela = true

* [...]
-

Su mamá. Su hermana. Allá.
Esperando.

"Lo siento, Diego."

"Está bien. Voy a poder. Siempre se puede.
Tengo unos panas que venden comida. Capaz me sumo."

Ya está pensando en la siguiente jugada.
No se queda quieto. No puede.

~ diego_relacion += 1

->->

=== diego_no_presionar ===

Asentís. Seguís.
Diego sigue laburando.
Carga dos bolsa de papa como si fueran plumas.
La fuerza de la costumbre.

->->

=== diego_colecta ===
// Tunnel: Diego en la colecta

Vas con Diego y otra persona.
Recorren la zona.

"Para la olla del barrio. Lo que pueda."

Diego sabe hacer esto.
No tiene vergüenza.
O la esconde bien.

->->

// --- CONVERSACION PROFUNDA ---

=== diego_conversacion_profunda ===

~ hable_con_diego_profundo = true

Es de noche. Diego fuma en la esquina.
Único momento de descanso.

"¿Puedo?"

Te hace lugar.

"¿Fumás?"

"No. Solo... quería hablar."

Silencio.

"¿De qué?"

* ["De vos. ¿Cómo llegaste acá?"] -> diego_historia
* ["De la situación. ¿Cómo la ves?"] -> diego_opinion
* ["De nada. Solo compañía."] -> diego_compania

=== diego_historia ===

Diego mira el cigarrillo.

// Chequeo social: lograr que Diego confíe lo suficiente para contar su historia
# DADOS:CHEQUEO
~ temp resultado_diego_confianza = chequeo_completo_social(diego_relacion, 4)
{ resultado_diego_confianza == 2:
    ~ diego_me_conto_historia = true

    Diego te mira. Algo se abre.

    "En Caracas, antes de venirme, yo creía. De verdad creía. Estuve en una cooperativa agrícola en el llano. Metíamos las manos en la tierra pensando que por fin era nuestra, que el socialismo de abajo iba a funcionar."

    "¿Y qué pasó?"

    "Pasó que la revolución tiene muchos estómagos y pocas manos. La corrupción se comió las semillas, y el autoritarismo se comió a los que preguntábamos dónde estaba el fertilizante."

    Pausa larga. Diego mira sus manos.

    "Vine acá para dejar de pelear, pero el hambre es el mismo monstruo con distinto acento."

    Se queda callado un momento. Después agrega algo que nunca le contó a nadie:

    "Mi viejo todavía está allá. Enfermo. No puedo ir a verlo porque si cruzo la frontera no me dejan volver. Y si no vuelvo, quién les manda plata."

    La voz se le quiebra. Un instante. Después se recompone.

    ~ diego_relacion += 2
    ~ subir_conexion(2)
    ~ activar_pedir_no_debilidad()
}
{ resultado_diego_confianza == 1:
    ~ diego_me_conto_historia = true

    "En Caracas, antes de venirme, yo creía. De verdad creía. Estuve en una cooperativa agrícola en el llano. Metíamos las manos en la tierra pensando que por fin era nuestra, que el socialismo de abajo iba a funcionar."

    "¿Y qué pasó?"

    "Pasó que la revolución tiene muchos estómagos y pocas manos. La corrupción se comió las semillas, y el autoritarismo se comió a los que preguntábamos dónde estaba el fertilizante. Destruyeron lo que construimos, y de paso borraron el trabajo de los que estaban antes de ellos, que tampoco eran santos, pero al menos dejaban algo en pie."

    Pausa larga. Diego mira sus manos, curtidas por dos tierras distintas.

    "Vine acá para dejar de pelear, pero el hambre es el mismo monstruo con distinto acento. A veces... a veces ya ni me da la cabeza para imaginar que la cosa se acomode. Es como si el futuro fuera un idioma que dejé de hablar."

    Comunidad.
    En el medio de la nada, se tienen entre ellos.

    ~ diego_relacion += 1
    ~ subir_conexion(1)
    ~ activar_pedir_no_debilidad()
}
{ resultado_diego_confianza == 0:
    Diego fuma. Piensa.

    "Vine de Venezuela. Ya sabés eso."

    Pausa.

    "Algún día te cuento bien. Hoy no me da."

    No insistís. Hay cosas que necesitan su tiempo.

    ~ diego_relacion += 1
}
{ resultado_diego_confianza == -1:
    Diego se cierra. Tirás del cigarrillo.

    "No me gusta hablar de eso."

    "Perdón. No quería..."

    "Está bien. Pero... no hoy."

    El silencio se vuelve incómodo.
    Quizás preguntaste demasiado pronto.
}

->->

=== diego_opinion ===

"La situación está jodida. Para todos."

Fuma.

* [...]
-

"Pero ustedes no saben lo que es jodido de verdad.
Cuando la luz se va diez horas. Cuando no hay agua.
Cuando un kilo de arroz cuesta un sueldo."

"¿Y esto?"

"Esto es difícil. Pero no es Venezuela.
Y acá... acá se siente distinto.
La gente todavía se mira.
En Caracas, al final, cada uno miraba su propio plato."

Hace una pausa.

"Por eso vengo a la olla.
No por el plato. Yo sé hacerme el mío.
Sino porque acá el hambre se combate con asamblea, no con silencio.
Eso lo aprendí allá: el que come solo, muere solo."

* [...]
-

Pausa.

"Aunque a veces... a veces me pregunto si vine
para terminar igual. Pobre en otro lado."

~ diego_relacion += 1

->->

=== diego_compania ===

"Está bien."

Fuman en silencio.
O él fuma. Vos mirás la calle.

No hace falta hablar.
A veces solo estar alcanza.

~ diego_relacion += 1

->->

// --- HISTORIA DE CECOSESOLA ---

=== diego_historia_cecosesola ===

~ diego_conto_cecosesola = true

Es domingo. Diego tiene el día libre.
Están sentados en la plaza del barrio.

"¿Sabés qué hacía yo en Venezuela, antes de todo?"

"No. ¿Qué?"

"Organizaba ferias. Ferias de verdad."

* [...]
-

"Mi familia estaba en CECOSESOLA. Central Cooperativa de Servicios Sociales de Lara. Suena a burocracia, pero era todo lo contrario."

"¿Qué era?"

"La red cooperativa más vieja del país. Fundada en el 67, antes de Chávez, antes de todo. Mi abuelo fue de los primeros. Mi padre también. Yo nací en eso."

* [...]
-

Diego mira al cielo. Sonríe por primera vez en mucho tiempo.

"Las ferias de consumo familiar. Imaginate: los productores llevaban la cosecha directo a la feria. Tomates, pimentones, yuca, plátano. Sin intermediarios. Los precios eran treinta por ciento menos que en el mercado."

"¿Treinta por ciento?"

"Porque no había patrón. No había jefe. Todos ganábamos lo mismo: el que cargaba, el que vendía, el que contaba la plata. Rotábamos los cargos. Nadie se quedaba arriba."

* ["Eso suena a cuento."]
    "Suena, sí. Pero funcionó sesenta años. Todavía funciona, aunque destruyeron la mitad."
    -> diego_cecosesola_cont
    
* ["¿Y cómo funcionaba?"]
    "Con asambleas. Todo se decidía entre todos. Si había problema, hablábamos. Si alguien se mandaba un moco, lo corregíamos. No había despidos, había conversaciones."
    -> diego_cecosesola_cont

=== diego_cecosesola_cont ===

* [...]
-

"También teníamos un centro de salud. Propio. Con quirófanos. Lo construimos nosotros. No esperamos que el gobierno nos lo diera."

"La puta madre."

* [...]
-

Diego se pone serio.

"¿Sabés cuál es la diferencia entre la cooperativa de verdad y la que quería imponer el Estado?"

"¿Cuál?"

"El Estado quería que dependiéramos de él. Créditos estatales, contratos oficiales, consejos comunales alineados al partido. Nosotros dijimos que no. CECOSESOLA nunca aceptó plata del gobierno. Preferíamos ser pobres y libres."

* [...]
-

"Y eso nos hizo enemigos."

~ subir_conexion(1)
~ diego_relacion += 1

->->

=== diego_sobre_camion ===
// La historia del camión quemado

~ diego_conto_camion = true

Diego baja la voz.

"¿Sabés por qué me fui?"

"Por la situación, ¿no? El hambre, la inflación..."

"No. Bueno, también. Pero hubo algo más."

* [...]
-

"Cuando el gobierno empezó a presionar a CECOSESOLA, nos negamos a alinearnos. No queríamos distribuir las cajas CLAP."

"¿Qué eran las CLAP?"

"Paquetes de comida que controlaba el partido. Si estabas con ellos, comías. Si no, te jodías. Era control político, no ayuda."

* [...]
-

"Un funcionario le dijo a mi viejo: 'O entran al sistema o los vamos a asfixiar'. Empezaron a negarnos permisos. A demorarnos los insumos."

"Hijos de puta."

* [...]
-

Diego mira sus manos.

"Una noche quemaron un camión de la cooperativa. Lleno de verduras para la feria del sábado. Nadie investigó. El mensaje era claro."

* [...]
-

Silencio largo.

"Mi vieja me dijo: 'Vos tenés que irte antes de que te toque a vos'. Me dieron los ahorros de toda la vida. Que no eran nada, por la inflación. Pero era todo lo que tenían."

* ["Lo siento."]
    "No hay nada que sentir. Es la historia de miles. Millones. Nos robaron el futuro antes de que existiera."
    ~ subir_conexion(1)
    ~ diego_relacion += 1
    ->->

* [Quedarte callado]
    No hay palabras.
    Diego tampoco las espera.
    ~ diego_relacion += 1
    ->->

=== diego_libreta_semillas ===
// La libreta con semillas

Notás que Diego tiene una libretita gastada.
Anota todo ahí: gastos, horarios, nombres.

"¿Qué tenés en esa libreta?"

Diego sonríe.

"Cosas de feria. Costumbre vieja."

* ["¿Puedo ver?"]
    
    Diego duda. Después te la muestra.
    
    En las últimas páginas hay una lista distinta.
    No son números. Son nombres de plantas.
    
    "Pimentón larence. Tomate perita. Ají dulce. Cilantro cimarrón."
    
    "¿Qué es esto?"
    
    * [...]
    -
    
    "Semillas de mi tierra. Las que aprendí a sembrar con mi abuelo."
    
    Pasa el dedo por la lista.
    
    "Ninguna crece igual acá. El clima es distinto. La tierra es distinta."
    
    * [...]
    -
    
    "A veces la leo como quien lee una carta de un muerto."
    
    Guarda la libreta.
    
    "Pero la guardo. Por si algún día..."
    
    No termina la frase.
    No hace falta.
    
    ~ subir_conexion(1)
    ~ diego_relacion += 1
    ->->

* ["No, perdón. Es personal."]
    "Está bien. Capaz otro día."
    ->->

=== diego_y_marcos ===
// Tensión/diálogo con Marcos sobre organización

Marcos está hablando de "la orga". De cuando él militaba.
De la estructura, de las células, de la disciplina.

Diego lo escucha con cara rara.

"¿Y quién controlaba a la orga?"

Marcos se frena.

"¿Cómo?"

"¿Quién decidía quién subía y quién bajaba? ¿Quién manejaba la plata? ¿Había asambleas o había jefes?"

* [...]
-

Marcos no sabe qué decir.

"Había... había dirección. Cuadros. Gente formada..."

"O sea, jefes."

* [...]
-

Diego no lo dice con bronca. Lo dice con tristeza.

"Yo vi el cooperativismo de verdad ser aplastado por el cooperativismo del Estado. El problema no era la idea. Era que alguien arriba se creía con derecho a decidir por todos."

* [...]
-

Marcos se queda callado.

Diego sigue:

"Sin la asamblea, sos solo otro tipo con libros y buenas intenciones. Y eso no alcanza."

Silencio incómodo.

Pero Marcos no se va.
Algo le quedó sonando.

->->

// --- DIEGO Y EL DESPIDO ---

=== diego_enterarse_despido ===
// Tunnel: Diego se entera del despido del protagonista

{conte_a_alguien:
    "Ya te conté. Me echaron."
    "Mierda, sí. ¿Cómo andás?"
- else:
    "Me echaron ayer."
    ~ conte_a_alguien = true
    "La puta madre."
}

Diego te mira.
Él sabe lo que es no tener nada seguro.

"Si necesitás algo..."

"Gracias."

No hay mucho que decir.
Pero estar con alguien ayuda.

->->

// --- DIEGO PIERDE EL TRABAJO ---

=== diego_pierde_laburo ===

~ diego_perdio_laburo = true
~ diego_estado = "desesperado"

Diego está en la plaza.
Medio día. Debería estar trabajando.

"Diego. ¿Qué hacés acá?"

"Me echaron."

Corto. Seco.

* [...]
-

"¿Cuándo?"

"Ayer. Sin aviso. 'Ya no te necesitamos'."

Mira el piso.

* [...]
-

"Ocho meses. Nunca falté. Nunca llegué tarde.
Y me echaron como si nada."

* ["Lo siento mucho."] -> diego_consolar
* ["¿Tenés algo ahorrado?"] -> diego_preguntar_ahorros
* ["¿Qué vas a hacer?"] -> diego_que_hacer

=== diego_consolar ===

"Lo siento, Diego."

"Sí. Yo también."

No hay más que decir.

~ diego_relacion += 1

->->

=== diego_preguntar_ahorros ===

"¿Tenés algo ahorrado?"

Sonríe. Sin gracia.

"¿Con lo que pagaban? Apenas daba para el cuarto y mandar algo."

"{diego_familia_en_venezuela:
    "Mi vieja va a tener que esperar.
    Pero ella entiende. Es una guerrera.
    Ya pasó por peores."
}

->->

=== diego_que_hacer ===

"No sé. Buscar otra cosa. Hay un depósito en Sayago.
Capaz que necesitan gente."

"¿Y si no?"

"No sé. Algo aparece. Siempre aparece algo."

Es lo que se dice.
Aunque no siempre sea verdad.

->->

// --- AYUDAR A DIEGO ---

=== diego_ayuda ===

~ ayude_a_diego = true

{diego_perdio_laburo:
    "Diego. Mirá, no es mucho, pero..."

    Le das lo que podés.
    Poco. Pero algo.

    "No, hermano. Vos también estás jodido."

    "Tomalo. Después me pagás."

    No va a pagar. Los dos lo saben.
    Pero la ficción ayuda.

    ~ diego_relacion += 2
    ~ subir_conexion(1)
    ~ diego_estado = "esperanzado"

    "Gracias. En serio."

    ->->
- else:
    "Si necesitás algo, avisame."

    Diego asiente.

    "Gracias. Lo mismo digo.
    Si vos te quedás en banda, el grupo se mueve.
    No te vamos a dejar caer."

    ~ diego_relacion += 1

    ->->
}

// --- TELEFONO ---

=== diego_llamar ===
// Tunnel: Llamar a Diego

Llamás a Diego.

"¿Qué onda?"

"Nada. Domingo. ¿Vos?"

"Acá, en la pieza. Mirando el techo."

->->

=== diego_conversacion_telefono ===
// Tunnel: Conversacion telefonica con Diego

Hablan.
De nada.
De todo.

Diego también está solo.
Pero ahora están solos juntos, aunque sea por teléfono.

"La semana que viene hay que buscar laburo en serio."

"Sí. Hay que."

"Mañana salimos juntos. Recorremos."

"Dale."

~ subir_conexion(1)

->->

// --- FRAGMENTO NOCTURNO DE DIEGO ---

=== diego_fragmento_noche ===

Diego mira el techo del cuarto.
Paredes finas. Se escucha todo.

Un cuarto compartido con otro venezolano.
Seis metros cuadrados.
Casa. Por ahora.

Debajo de la almohada tiene una franela vieja.
El logo de CECOSESOLA: una mano sosteniendo espigas.
Ya no la usa, pero la guarda.

{diego_perdio_laburo:
    Mañana tiene que buscar trabajo.
    Tiene que encontrar algo.
    No hay opción.

    Piensa en su mamá.
    En la llamada que tiene que hacer.
    En las palabras que no encuentra.

    "Este mes no puedo mandar."
    ¿Cómo se dice eso?
- else:
    El despertador suena a las cuatro.
    Turno de seis a seis.
    Doce horas.
    Después repetir.
}

{diego_familia_en_venezuela:
    Piensa en Caracas.
    En las calles que caminaba.
    En la casa de su mamá.

    A veces sueña que vuelve.
    Que todo se arregló.
    Que puede volver.

    Después despierta.
}

{diego_conto_cecosesola:
    Piensa en la cooperativa.
    En 2022, CECOSESOLA ganó el Right Livelihood Award.
    El "Nobel Alternativo", le dicen.
    
    Lo vio por internet, desde este mismo cuarto.
    
    Lloró de orgullo.
    La cooperativa sobrevivió. Sigue funcionando.
    Pero su familia tuvo que irse.
    
    Lloró también de rabia.
}

{diego_viene_a_olla:
    Al menos mañana hay olla.
    Al menos va a estar ocupado.
    Cansarse hace bien. Ayuda a no pensar.
    
    Además, en la olla se siente útil.
    Organizando logística, estirando recursos.
    Sus manos recuerdan cómo se hace.
}

{ayude_a_diego:
    Piensa en vos.
    En que estás empezando a entender que la "clase media" era un cuento que te contabas para no sentirte parte de nosotros.

    Se ríe bajito en la oscuridad.
    "Uruguayo loco", piensa.
    "Bienvenido a la resistencia. Acá no se factura, acá se sostiene."
}

Saca la libretita del bolsillo del pantalón.
La lista de semillas en la última página.
Pimentón larence. Tomate perita. Ají dulce.

"Algún día", murmura.

Afuera, la ciudad duerme.
Él no.

Los inmigrantes no duermen.
Calculan.
Planean.
Sobreviven.

Guarda la libreta.
Aprieta la franela bajo la almohada.
Cierra los ojos.

->->

// --- FRAGMENTOS NOCTURNOS DE DIEGO ---

=== fragmento_diego_llamada ===
Diego llama a su mamá en Caracas.

La señal va y viene.
"¿Comiste, mijo?"
"Sí, mamá."
Mentira. Hoy no comió.

Saca cuentas mentalmente. De los veintiocho mil pesos que sacó en el depósito, mandó doce mil ayer.
Le quedan dieciséis para el alquiler de la pieza y comer todo el mes.
A veces alcanza. A veces no.

"Te quiero, mijo."
"Yo también, mamá."

Corta. Se queda mirando el techo.

->->

=== fragmento_diego_permiso ===
Diego revisa los papeles de residencia.
Todo en orden. Más o menos.

{diego_relacion >= 3:
    Piensa en el barrio.
    En que alguien le habló hoy sin pedirle los papeles primero.
    Eso vale.
}

El trámite es el jueves.
Si sale bien, puede trabajar en blanco.
Si sale mal...

No piensa en eso. Mañana.

->->

=== fragmento_diego_mate ===
Diego intenta cebar mate.

Le sale lavado. Otra vez.

{diego_relacion >= 2:
    "Mañana le pido al vecino que me enseñe."
}

En Venezuela el café es otra cosa.
Acá todo es mate.
Mate dulce, mate amargo, mate con yuyos.
Un idioma nuevo que todavía no domina.

Se toma el mate lavado igual.
Algo caliente es algo caliente.

->->
