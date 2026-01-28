// ============================================
// PERSONAJE: JUAN
// Compañero de trabajo (Juan)
// ============================================

// --- ENCUENTRO EN EL LABURO ---

=== juan_saludo_manana ===

Juan está en el escritorio de al lado.
Compañero hace tres años.
El único con el que hablás de verdad acá.

{
- dia_actual == 1:
    -> juan_pregunta_piso4
- dia_actual == 2:
    Te mira.
    "¿Cómo dormiste?"
    "Mal."
    "Yo también."
}

->->

=== juan_pregunta_piso4 ===
"Che, ¿viste lo del piso 4?"

* ["¿Qué pasó?"] -> juan_rumor
* ["No, ¿qué?"] -> juan_rumor
* ["No quiero saber."] -> juan_ignorar

=== juan_rumor ===

Juan baja la voz.

"Echaron a tres. El viernes. Sin aviso."

"¿En serio?"

"Reestructuración, dijeron. Pero mirá..."

* [...]
-

Mira para los costados.

"Los de RRHH andan raros. Reuniones todo el tiempo. Algo pasa."

~ hable_con_juan_sobre_rumores = true

* ["¿Creés que nos toca?"] -> juan_preocupacion
* ["Siempre hay rumores."] -> juan_minimizar
* ["Hay que cuidarse."] -> juan_cuidarse

=== juan_ignorar ===

"Como quieras."

Juan vuelve a su pantalla.
Un poco ofendido.

~ juan_relacion -= 1

Mejor no saber.
O no.

->->

=== juan_preocupacion ===

"No sé. Espero que no. Pero..."

Se encoge de hombros.

"Yo tengo el alquiler, la cuota del auto... Si me echan, cago fuego."

Se frota la cara.

"Me hacen facturar cuarenta mil pesos, bo. Como unipersonal.
Descontale el BPS, el Fonasa... me quedan treinta y cinco en la mano.
Entre eso y lo que gana Laura apenas llegamos.
El alquiler ya nos come la mitad. Después la luz, internet, el préstamo de la moto..."

"Yo también."

// Chequeo social: navegar la conversación delicada en el trabajo
# DADOS:CHEQUEO
~ temp resultado_juan_social = chequeo_completo_social(juan_relacion, 3)
{ resultado_juan_social == 2:
    -> juan_preocupacion_critico
}
{ resultado_juan_social == 1:
    -> juan_preocupacion_exito
}
{ resultado_juan_social == 0:
    -> juan_preocupacion_fallo
}
-> juan_preocupacion_crit_fallo

= juan_preocupacion_critico
* [...]
-

Un momento de honestidad. Raro en la oficina.
Los dos saben que son descartables.

Juan baja la voz aún más.

"Che, ¿sabés qué me dijo Martínez antes de que lo rajaran? Que vio una lista. Con nombres. En el escritorio de RRHH."

"¿Una lista?"

"No sé si es verdad. Pero si es así... tenemos que cuidarnos."

El dato queda. No sabés si es real.
Pero la confianza de Juan sí lo es.

~ juan_relacion += 2
~ subir_conexion(1)

"Bueno. A laburar. Que nos vean laburando."
->->

= juan_preocupacion_exito
* [...]
-

Un momento de honestidad.
Los dos saben que son descartables.
Que la "independencia" de la unipersonal era solo una forma de que la empresa se ahorre nuestros derechos.
Todos lo somos.

~ juan_relacion += 1

"Bueno. A laburar. Que nos vean laburando."
->->

= juan_preocupacion_fallo
* [...]
-

Juan mira para los costados. Nervioso.

"Mejor no hablar de esto acá."

Vuelve a su pantalla.
La conversación se cortó. Pero el miedo quedó.

"Bueno. A laburar."
->->

= juan_preocupacion_crit_fallo
* [...]
-

Juan se pone pálido.

"Pará, pará. ¿Vos creés que nos van a echar a todos?"

"No, no dije eso..."

"No, ya sé. Pero..."

Se levanta. Nervioso. Se va al baño.
Le metiste más miedo del que ya tenía.

~ aumentar_peso(1)
->->

=== juan_minimizar ===

"Siempre hay rumores, Juan. Todos los meses dicen que van a echar gente."

"Sí, pero esta vez..."

"Esta vez también. Tranqui."

Juan no parece convencido.
Vos tampoco.
Pero hay que seguir.

->->

=== juan_cuidarse ===

"Hay que cuidarse. No llegar tarde, no bardear, hacer lo que piden."

"¿Vos creés que eso alcanza?"

"No sé. Pero peor es no hacer nada."

Juan asiente.
Los dos saben que es mentira.
Cuando quieren echarte, te echan.
No importa lo que hagas.

->->

// --- ALMUERZO CON JUAN ---

=== juan_almuerzo ===

~ almorzamos_juntos = true
~ juan_relacion += 1

Bajan juntos.
El comedor de la empresa.

"¿Qué hay hoy?"

~ ultima_tirada = d6()
{ultima_tirada <= 3: "Guiso."|"Milanesa con puré."}

"Podría ser peor."

Se sientan.
Comen.

Juan habla de su novia, de las vacaciones que quieren hacer, del partido del domingo.
Cosas normales.
Cosas de gente normal.

* [...]
-

Por un rato, te olvidás de los rumores.

~ subir_conexion(1)

"Che, si pasa algo... digo, si alguno de los dos... nos avisamos, ¿no?"

"Obvio."

No saben qué más decir.
Pero el pacto está.

->->

// --- DESPUÉS DE LA REUNIÓN ---

=== juan_post_reunion ===

Juan se acerca.

"Esta semana va a ser jodida."

"Sí."

No hay más que decir.

* [Preguntarle si quiere ir al bar] -> juan_invitar_bar
* [Irte] ->->

=== juan_invitar_bar ===

"Che, Juan. ¿Vamos a tomar algo?"

~ ultima_tirada = d6()

{ultima_tirada >= 3:
    "Dale. Una cerveza no viene mal."
    -> juan_bar
- else:
    "No puedo, tengo cosas. Otro día."
    "Dale. Otro día."
    Se va.
    ->->
}

=== juan_bar ===

~ fue_al_bar_con_juan = true

Van al bar de la esquina.
Dos cervezas.

~ energia -= 1
~ juan_relacion += 1
~ subir_conexion(1)

"¿Vos qué harías si te echan?", pregunta Juan.

* ["No sé. Buscar otra cosa."]
"A veces siento que estoy corriendo en una cinta, uruguayo. Mis viejos se rompieron el lomo para sacarme del barrio, para que yo fuera 'alguien'. Y acá estoy, facturando como si fuera un empresario mientras rezo que no me corten la luz. Si nos echan, volvemos al mismo barro del que ellos quisieron sacarnos."

Se quedan en silencio.
La cerveza está fría, pero el miedo calienta el aire.
    -> juan_bar_fin
* ["Tengo algo de ahorros. Aguantaría unos meses."]
    "Yo no. Si me echan, cago fuego."
    "Algo aparece, Juan."
    "Ojalá."
    -> juan_bar_fin
* ["Hay otros laburos. Hay otras cosas."]
    Juan te mira.
    "¿Cómo qué?"
    "No sé. Pero el mundo no se acaba."
    No suena convincente. Pero es algo.
    -> juan_bar_fin

=== juan_bar_fin ===

Terminan las cervezas.
Se despiden.

"Nos vemos mañana."
"Nos vemos."

~ activar_tengo_tiempo()

->->

// --- PREGUNTAR A JUAN ---

=== juan_preguntar_sobre_jefe ===

"Che, Juan. ¿Viste cómo me miró el jefe?"

"Sí. Raro."

"¿Qué onda?"

"No sé. Pero a Martínez lo miró así el jueves antes de que lo citaran."

Eso no ayuda.

~ aumentar_peso(1)

->->

// --- DESPUÉS DEL DESPIDO ---

=== juan_enterarse_despido ===
// Cuando Juan se entera de que te echaron

~ juan_sabe_de_mi_despido = true

{juan_relacion >= 3:
    Juan te busca.
    "Che, me enteré. La puta madre."
    "Sí."
    "¿Estás bien?"
    "No sé."

    Te da un abrazo torpe.
    No sabe qué más hacer.
    Nadie sabe.

    "Si necesitás algo..."
    "Gracias."

    ~ subir_conexion(1)
- else:
    Juan te manda un mensaje.
    "Me enteré. Qué bajón."
    No respondés.
}

->->

=== juan_despues_despido ===
// Intentar contactar a Juan después de perder el laburo

{dia_actual <= 5:
    Llamás a Juan.

    ~ ultima_tirada = d6()

    {ultima_tirada >= 4:
        Contesta.
        "Hola. ¿Cómo andás?"
        "Ahí. ¿Y vos? ¿Cómo está todo?"
        "Igual. Raro sin vos acá."

        {juan_relacion >= 4:
            "Che, tendríamos que juntarnos. Un día de estos."
            "Dale. Avisame."
        }

        Cortás.
        El laburo sigue sin vos.
        La vida sigue sin vos.
        ->->
    - else:
        No contesta.
        Debe estar laburando.
        Obvio.
        ->->
    }
}

{dia_actual > 5:
    Pensás en llamar a Juan.
    Pero... ¿para qué?
    Ya no comparten nada.
    Solo compartían el laburo.

    ~ juan_estado = "distante"
    ->->
}

// --- FRAGMENTO NOCTURNO DE JUAN ---

=== juan_fragmento_noche ===

Juan no puede dormir.

Su novia ya duerme.

Él mira el techo.

{dia_actual == 1:
    Piensa en el laburo.
    En los despidos.
    En vos.

    Si lo echan a él, el alquiler se complica.
    La cuota del auto.
    Los planes con la novia.

    Todo armado sobre algo que puede desaparecer mañana.
}

{dia_actual == 2:
    Mañana la reunión.
    ¿A quién le tocará?
    ¿A vos? ¿A él?

    No puede dejar de pensar.
}

{dia_actual >= 3 && fui_despedido:
    Piensa en vos.
    En que te echaron.
    En que podría ser él mañana.

    {juan_relacion >= 4:
        Tendría que llamarte.
        Pero no sabe qué decir.
    }
}

"¿Estás bien?", pregunta ella sin abrir los ojos.

"Sí. Dormí."

Miente.
Todos mienten.

->->

// --- EL PASADO ENTERRADO DE JUAN ---

=== juan_recuerdo_marchas ===

~ juan_recuerdo_padre = true

Están hablando de la situación laboral.
Juan está más callado que de costumbre.

De pronto dice:

"Mi viejo me llevaba a las marchas."

"¿Qué marchas?"

* [...]
-

"Del PIT-CNT. Cuando era chico. Cinco, seis años. Me ponía arriba de los hombros para que viera."

"No sabía."

"No lo cuento nunca."

* [...]
-

Pausa larga.

"No sé por qué me acordé recién. Hace años que no pienso en eso."

"¿Y por qué dejaste de ir?"

* [...]
-

"No sé. Crecí. Empecé a laburar. El viejo se jubiló, se volvió amargo. Ya no hablamos de política."

"¿Y vos?"

"Yo... no sé. Supongo que me dio miedo terminar como él. Toda la vida peleando y al final solo, en un monoambiente, viendo las noticias para putearse."

* [...]
-

Silencio.

"A veces sueño con esas marchas. Con el ruido. Con mi viejo joven. Y me despierto confundido."

~ subir_conexion(1)
~ juan_relacion += 1

->->

=== juan_sobre_laura ===
// Escenas con Laura (la esposa)

~ juan_hablo_de_laura = true

"¿Cómo está Laura?"

Juan suspira.

"Bien. Ella siempre está bien. Es más tranquila que yo."

* [...]
-

"A veces me dice: 'Dejá de ver tantas noticias que te hacés mala sangre'. Tiene razón. Pero no puedo parar."

"¿Por qué?"

"Porque si no miro, siento que algo me va a agarrar desprevenido. Que me van a cagar y no me voy a dar cuenta."

* [...]
-

"Ella quiere tener hijos. Yo le digo que 'todavía no estamos listos económicamente'. Pero la verdad es que tengo miedo."

"¿De qué?"

"De traer un guri a este quilombo. De no poder darle nada. De terminar como mi viejo: prometiendo cosas que no podés cumplir."

* [...]
-

Pausa.

"Si me echan del laburo, ¿qué le digo? '¿Perdón, amor, se me terminó el curro y ahora somos pobres'?"

"No sos pobre, Juan."

"Todavía no."

~ subir_conexion(1)
~ juan_relacion += 1

->->

=== juan_fascinado_diego ===
// Juan fascinado por las historias de Diego

Están en la olla. Diego cuenta una historia.
Juan lo escucha con la boca abierta.

"Hermano, eso es de película. Las cooperativas, el camión quemado, la huida..."

Diego se encoge de hombros.

"Es mi vida, no más."

* [...]
-

Después, cuando Diego se va, Juan te dice:

"Ese tipo vivió más en veintiocho años que yo en treinta y dos."

"¿Te parece?"

* [...]
-

"A mí nunca me pasó nada. Nunca tuve que huir de nada. Nunca arriesgué nada."

"Eso no es malo."

"No sé. A veces siento que mi vida es... gris. Chica. Sin épica."

* [...]
-

Pausa.

"Y después viene uno como Diego, que perdió todo y sigue laburando, sigue ayudando. Y yo acá quejándome del alquiler."

No sabés qué decirle.
Pero algo se movió adentro suyo.

~ subir_conexion(1)

->->

=== juan_procesando ===
// El procesamiento lento de Juan
// Esta escena ocurre DESPUÉS de una conversación anterior

~ juan_proceso_algo = true

Una semana después de la charla.
Juan te manda un mensaje.

"Che, ¿podemos vernos un rato?"

* [Aceptar]

    Se encuentran.
    Juan trae café.
    
    "Estuve pensando en lo que dijo Diego el otro día."
    
    "¿Qué cosa?"
    
    * [...]
    -
    
    "Eso de que el problema no es el inmigrante, es el empresario que nos explota a los dos."
    
    "¿Y qué pensás?"
    
    * [...]
    -
    
    Juan toma café. Piensa.
    
    "Creo que tiene razón. O sea... yo siempre repetía lo que escuchaba en las noticias. 'Vienen a sacarnos el laburo'. Pero Diego labura el doble que yo y le pagan la mitad."
    
    * [...]
    -
    
    "Y el que nos paga poco a los dos es el mismo. No es Diego. Es el patrón."
    
    Pausa larga.
    
    "No sé. Capaz que soy un boludo y recién estoy entendiendo cosas que todo el mundo sabe."
    
    "No sos boludo. Estás pensando. Eso ya es algo."
    
    ~ subir_conexion(2)
    ~ juan_relacion += 1
    ->->

* [No poder]
    "No puedo ahora, Juan. Después."
    "Dale."
    
    No sabés qué quería decirte.
    Pero algo le quedó dando vueltas.
    ->->

=== juan_sobre_miedo ===
// Juan confronta su propio miedo

~ juan_hablo_de_miedo = true

"¿Sabés qué me pasa?"

"¿Qué?"

"Que tengo miedo de todo. De perder el laburo, de que me roben, de que las cosas se vayan al carajo. Y el miedo me hace decir cosas que después me arrepiento."

* [...]
-

"Como lo del 'acá falta autoridad'. O lo de 'los que vienen de afuera'. Cosas que repito sin pensar."

"¿Y por qué las decís?"

"Porque si le echo la culpa a alguien, me siento menos en banda. Como si supiera qué está pasando."

// Chequeo mental: ayudar a Juan a procesar su miedo
# DADOS:CHEQUEO
~ temp resultado_juan_miedo = chequeo_completo_mental(juan_relacion, 4)
{ resultado_juan_miedo == 2:
    -> juan_miedo_critico
}
{ resultado_juan_miedo == 1:
    -> juan_miedo_exito
}
{ resultado_juan_miedo == 0:
    -> juan_miedo_fallo
}
-> juan_miedo_crit_fallo

= juan_miedo_critico
* [...]
-

Silencio.

"Pero la verdad es que no sé nada. Solo tengo miedo y repito lo que dicen en la tele."

"Eso ya es darse cuenta de algo."

Juan te mira. Y por primera vez, dice algo que no esperabas:

"¿Sabés qué? Creo que mi viejo decía las mismas cosas. En las marchas, el enemigo era claro. Ahora todo es confuso. Y en la confusión, repetimos lo primero que escuchamos."

"Pero estás dejando de repetir."

"Sí. Capaz que sí."

~ subir_conexion(2)
~ juan_relacion += 2
->->

= juan_miedo_exito
* [...]
-

Silencio.

"Pero la verdad es que no sé nada. Solo tengo miedo y repito lo que dicen en la tele."

"Eso ya es darse cuenta de algo."

"Sí. Pero darse cuenta no alcanza. Hay que hacer algo. Y no sé qué."

~ subir_conexion(1)
~ juan_relacion += 1
->->

= juan_miedo_fallo
* [...]
-

Juan se queda callado.

"La verdad es que no sé nada."

No sabés qué decirle. El miedo es contagioso.
Y vos también tenés el tuyo.

"Somos dos boludos con miedo."

Se ríe. Vos también.
No resuelve nada. Pero alivia.

~ juan_relacion += 1
->->

= juan_miedo_crit_fallo
* [...]
-

Juan se pone más nervioso.

"¿Ves? Ni vos sabés qué decir. Nadie sabe."

El miedo se multiplica. Hablaron del tema y quedaron peor.
A veces abrir la caja de Pandora no ayuda.

"Mejor dejemos de hablar de esto."

~ aumentar_peso(1)
->->

// --- ENCUENTRO DEL VIERNES ---
// Hook: si tenés buena relación con Juan, te llama el viernes

=== juan_llamado_viernes ===
// Llamar solo si juan_relacion >= 4

El teléfono vibra.
Juan.

"Che, ¿estás? ¿Podemos vernos un rato?"

* ["Sí, dale. ¿Dónde?"]
    "En el bar de la otra vez. Media hora."
    -> juan_encuentro_viernes
* ["No puedo ahora."]
    "Dale, entiendo. Otro día."
    Cortás.
    Algo en su voz te quedó.
    ->->

=== juan_encuentro_viernes ===

~ energia -= 1

El bar de la esquina.
Mismo lugar que el lunes.
Parece hace mil años.

Juan ya está.
Pide dos cervezas antes de que te sientes.

Está raro.
Nervioso.
O algo.

"¿Todo bien?", preguntás.

{llama >= 5 || conexion >= 5:
    -> juan_noticia_buena
- else:
    -> juan_noticia_mala
}

=== juan_noticia_buena ===

Juan respira.

"Sí. Mirá, te quería contar algo."

Toma un trago.

* [...]
-

"Mi cuñado tiene un taller. Arregla electrodomésticos, esas cosas."

"¿Y?"

"Necesita alguien. No es fijo, son changas. Pero paga."

* [...]
-

Te mira.

"Pensé en vos. Si te interesa, le digo."

* ["Sí, pasale mi número."]
    ~ subir_conexion(1)
    ~ subir_dignidad(1)
    ~ juan_ofrecio_changa = true
    "Dale, le digo. Capaz te llama la semana que viene."

    No es un laburo.
    Es una posibilidad.
    Pero viniendo de Juan, significa algo.

    "Gracias, Juan."
    "Para eso estamos."
    -> juan_encuentro_fin

* ["Dejame pensarlo."]
    "Dale, sin presión. Avisame."

    No sabés si querés eso.
    Pero que Juan haya pensado en vos...

    ~ subir_conexion(1)
    -> juan_encuentro_fin

* ["No, gracias. Voy a buscar otra cosa."]
    "Como quieras."

    Juan parece un poco dolido.
    Pero entiende.

    -> juan_encuentro_fin

=== juan_noticia_mala ===

~ juan_tambien_despedido = true
~ juan_estado = "despedido"

Juan no te mira.
Toma un trago largo.

"A mí también me echaron."

Silencio.

* [...]
-

"¿Cuándo?"

"Ayer. Mismo discurso. Reestructuración."

Unipersonal también.
Sin nada.
Como vos.

* [...]
-

"La puta madre, Juan."

"Sí."

Se queda mirando la cerveza.

"Tres años. Facturando como si fuera mi propio jefe, mientras ellos ponían las reglas y se llevaban la tajada. Me vendieron la del emprendedor y me compraron como insumo."

* ["No sos pelotudo. Nos cagaron a todos."]
    ~ subir_conexion(2)
    ~ aumentar_peso(1)

    "Es el sistema, Juan. Así funciona."

    "Ya sé. Pero igual duele."

    Toman en silencio.
    Dos tipos sin laburo.
    Pero juntos en esto.

    -> juan_encuentro_fin

* ["¿Y ahora qué vas a hacer?"]
    ~ subir_conexion(1)
    ~ aumentar_peso(1)

    "No sé. Buscar. Lo que sea."

    "Si escucho algo, te aviso."

    "Gracias."

    Es raro.
    Antes él era el que tenía todo armado.
    Ahora están igual.

    -> juan_encuentro_fin

* [Quedarte callado]
    ~ aumentar_peso(1)

    No sabés qué decir.
    ¿Qué se dice?

    Toman en silencio.

    -> juan_encuentro_fin

=== juan_encuentro_fin ===

Terminan las cervezas.
No piden otra.

"Bueno. Nos vemos."

"Nos vemos, Juan."

Se dan un abrazo torpe.
De esos que no se daban antes.

{juan_relacion >= 4:
    ~ juan_relacion += 1
}

Volvés a casa.
Con algo más.
O algo menos.
Depende cómo lo mires.

->->

// --- JUAN EN JUEVES-DOMINGO ---

=== juan_encuentro_jueves ===
// Juan te encuentra despues del despido
# PORTRAIT:juan,worried,left

Te suena el celular. Es Juan.

"Che, ¿estás bien? Me enteré de lo del laburo."

* ["Sí, ahí ando."]
    "No me vendas humo. ¿Necesitás algo?"
    ~ juan_relacion += 1
    ~ juan_sabe_mi_situacion = true
    ->->
* ["¿Cómo te enteraste?"]
    "El laburo es chico, se sabe todo."
    ~ juan_sabe_mi_situacion = true
    ->->
* [No contestar]
    Dejás sonar. No es el momento.
    ->->

=== juan_charla_viernes ===
// Juan en viernes
# PORTRAIT:juan,friendly,left

{juan_sabe_mi_situacion:
    Juan te manda un mensaje:
    "Tengo un contacto que busca gente. No es gran cosa pero es algo. ¿Querés que le pase tu número?"

    * ["Dale, pasale."]
        "Listo. Te aviso si me dice algo."
        ~ juan_ofrecio_contacto = true
        ~ juan_relacion += 1
        ->->
    * ["Dejá, ya veo."]
        "Bueno, pero si cambiás de idea avisame."
        ->->
- else:
    Juan te manda un mensaje genérico del grupo del laburo.
    No sabés si decirle lo que pasó.
    ->->
}

=== juan_invitar_olla_sabado ===
// Invitar a Juan a la olla
# PORTRAIT:juan,neutral,left

{ayude_en_olla && juan_sabe_mi_situacion:
    "Che Juan, hay una olla popular en el barrio. ¿Querés venir?"

    * ["Hay buena gente."]
        Juan duda.
        "¿Olla popular? No sé..."
        "Vení una vez. Si no te copa, no venís más."
        "Bueno. Dale."
        ~ juan_fue_a_olla = true
        ~ juan_relacion += 1
        ->->
    * [No insistir]
        "Ta, dejá. Era una idea."
        ->->
- else:
    No tiene sentido invitarlo todavía.
    ->->
}

=== fragmento_juan_noche ===
// Fragmento nocturno de Juan

Juan llega a su casa.
Un dos ambientes en la periferia. Más lejos, más barato.

Abre la heladera. Hay poco.
Piensa en el laburo. En que capaz que es el próximo.
En que los rumores siempre se cumplen.

{juan_sabe_mi_situacion:
    Piensa en vos.
    "Ojalá esté bien", murmura.
}

Se acuesta con la tele prendida.
El noticiero habla de desempleo.
Cambia de canal.

->->

// --- FRAGMENTOS NOCTURNOS DE JUAN ---

=== fragmento_juan_cena ===
Juan calienta una lata de atún.

Pan. Atún. Tele.
La rutina de los que viven solos.

{juan_sabe_mi_situacion:
    Piensa en vos.
    En que no contestaste el mensaje.
    O sí contestaste pero cortito.

    "Ojalá esté bien."
}

Lava el plato. Uno solo.
Se acuesta.

->->

=== fragmento_juan_curriculum ===
Juan actualiza su currículum.

Por las dudas.
Siempre por las dudas.

Después de lo que te pasó a vos...
Mejor tener todo listo.

"Experiencia laboral: 8 años en el mismo puesto."
"Habilidades: Excel, Word, aguantar."

Cierra la compu. Mañana hay que ir.
Mientras haya donde ir.

->->

// --- ESCENA CLAVE: CONTRADICCIÓN DE JUAN ---
// Juan retrocede después de que Lucía propone el paro


=== juan_contradiccion ===
// Juan retrocede después de hablar de organizarse

~ juan_mostro_contradiccion = true

Es viernes. Juan te llama aparte.

"Che. Sobre lo que hablamos el otro día..."

"¿Lo de juntarnos a hablar con otros?"

"Sí. Mirá..."

* [...]
-

Juan mira para los costados.

"La verdad, no sé si me conviene."

* [...]
-

"Si se enteran de que andamos juntando gente... sabés cómo son.
Te marcan. Y cuando hay despidos, sos el primero de la lista."

Te mira. Vergüenza.

"Tengo el alquiler. Laura. Los planes..."

* ["Te entiendo."]
    "No te juzgo, Juan. Cada uno tiene su situación."
    
    Juan suspira. Aliviado.
    
    "Gracias. Me siento un cagón, ¿sabés? Hablar de la injusticia y después..."
    -> juan_contradiccion_cierre
    
* ["Pero vos dijiste..."]
    "Sí, ya sé lo que dije. En el bar es fácil."
    
    Juan se frota la cara.
    
    "Después llegás a casa y pensás en Laura preguntando cómo pagamos el alquiler."
    -> juan_contradiccion_cierre
    
* [Quedarte callado]
    No decís nada.
    
    Juan tampoco.
    
    El silencio dice lo que las palabras no.
    -> juan_contradiccion_cierre

=== juan_contradiccion_cierre ===

"Si sale algo más tranqui... algo sin tanto riesgo..."

"Dale. Te aviso."

* [...]
-

Juan vuelve a su escritorio.

No es cobarde. Es que tiene mucho que perder.
Las revoluciones las hacen los que pueden darse el lujo de perder.
O los que ya perdieron todo.

Juan está en el medio.
Como la mayoría.

->->
