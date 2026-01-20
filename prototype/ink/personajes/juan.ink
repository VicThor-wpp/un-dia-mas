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

"Yo también."

* [...]
-

Un momento de honestidad.
Los dos saben que son descartables.
Todos lo son.

~ juan_relacion += 1

"Bueno. A laburar. Que nos vean laburando."

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
    "Sí, yo también. Pero está difícil."
    "Está difícil."
    Se quedan en silencio.
    Dos tipos con miedo compartido.
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

->->

// --- PREGUNTAR A JUAN ---

=== juan_preguntar_sobre_jefe ===

"Che, Juan. ¿Viste cómo me miró el jefe?"

"Sí. Raro."

"¿Qué onda?"

"No sé. Pero a Martínez lo miró así el jueves antes de que lo citaran."

Eso no ayuda.

~ bajar_salud_mental(1)

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

* [Seguir mirando el techo] # FALSA
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

* [Mentir] # FALSA
    "Sí. Dormí."

    Miente.
    Todos mienten.

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

"Tres años. Facturando como pelotudo. Creyendo que era distinto."

* ["No sos pelotudo. Nos cagaron a todos."]
    ~ subir_conexion(2)
    ~ bajar_salud_mental(1)

    "Es el sistema, Juan. Así funciona."

    "Ya sé. Pero igual duele."

    Toman en silencio.
    Dos tipos sin laburo.
    Pero juntos en esto.

    -> juan_encuentro_fin

* ["¿Y ahora qué vas a hacer?"]
    ~ subir_conexion(1)
    ~ bajar_salud_mental(1)

    "No sé. Buscar. Lo que sea."

    "Si escucho algo, te aviso."

    "Gracias."

    Es raro.
    Antes él era el que tenía todo armado.
    Ahora están igual.

    -> juan_encuentro_fin

* [Quedarte callado]
    ~ bajar_salud_mental(1)

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
