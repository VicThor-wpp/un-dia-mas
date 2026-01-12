// ============================================
// PERSONAJE: RENZO
// Compañero de trabajo
// ============================================

// --- ENCUENTRO EN EL LABURO ---

=== renzo_saludo_manana ===

Renzo está en el escritorio de al lado.
Compañero hace tres años.
El único con el que hablás de verdad acá.

{dia_actual == 1:
    "Che, ¿viste lo del piso 4?"
    * ["¿Qué pasó?"] -> renzo_rumor
    * ["No, ¿qué?"] -> renzo_rumor
    * ["No quiero saber."] -> renzo_ignorar
}

{dia_actual == 2:
    Te mira.
    "¿Cómo dormiste?"
    "Mal."
    "Yo también."
    ->->
}

->->

=== renzo_rumor ===

Renzo baja la voz.

"Echaron a tres. El viernes. Sin aviso."

"¿En serio?"

"Reestructuración, dijeron. Pero mirá..."

Mira para los costados.

"Los de RRHH andan raros. Reuniones todo el tiempo. Algo pasa."

~ hable_con_renzo_sobre_rumores = true

* ["¿Creés que nos toca?"] -> renzo_preocupacion
* ["Siempre hay rumores."] -> renzo_minimizar
* ["Hay que cuidarse."] -> renzo_cuidarse

=== renzo_ignorar ===

"Como quieras."

Renzo vuelve a su pantalla.
Un poco ofendido.

~ renzo_relacion -= 1

Mejor no saber.
O no.

->->

=== renzo_preocupacion ===

"No sé. Espero que no. Pero..."

Se encoge de hombros.

"Yo tengo el alquiler, la cuota del auto... Si me echan, cago fuego."

"Yo también."

Un momento de honestidad.
Los dos saben que son descartables.
Todos lo son.

~ renzo_relacion += 1

"Bueno. A laburar. Que nos vean laburando."

->->

=== renzo_minimizar ===

"Siempre hay rumores, Renzo. Todos los meses dicen que van a echar gente."

"Sí, pero esta vez..."

"Esta vez también. Tranqui."

Renzo no parece convencido.
Vos tampoco.
Pero hay que seguir.

->->

=== renzo_cuidarse ===

"Hay que cuidarse. No llegar tarde, no bardear, hacer lo que piden."

"¿Vos creés que eso alcanza?"

"No sé. Pero peor es no hacer nada."

Renzo asiente.
Los dos saben que es mentira.
Cuando quieren echarte, te echan.
No importa lo que hagas.

->->

// --- ALMUERZO CON RENZO ---

=== renzo_almuerzo ===

~ almorzamos_juntos = true
~ renzo_relacion += 1

Bajan juntos.
El comedor de la empresa.

"¿Qué hay hoy?"

~ ultima_tirada = d6()
{ultima_tirada <= 3: "Guiso."|"Milanesa con puré."}

"Podría ser peor."

Se sientan.
Comen.

Renzo habla de su novia, de las vacaciones que quieren hacer, del partido del domingo.
Cosas normales.
Cosas de gente normal.

Por un rato, te olvidás de los rumores.

~ subir_conexion(1)

"Che, si pasa algo... digo, si alguno de los dos... nos avisamos, ¿no?"

"Obvio."

No saben qué más decir.
Pero el pacto está.

->->

// --- DESPUÉS DE LA REUNIÓN ---

=== renzo_post_reunion ===

Renzo se acerca.

"Esta semana va a ser jodida."

"Sí."

No hay más que decir.

* [Preguntarle si quiere ir al bar] -> renzo_invitar_bar
* [Irte] ->->

=== renzo_invitar_bar ===

"Che, Renzo. ¿Vamos a tomar algo?"

~ ultima_tirada = d6()

{ultima_tirada >= 3:
    "Dale. Una cerveza no viene mal."
    -> renzo_bar
- else:
    "No puedo, tengo cosas. Otro día."
    "Dale. Otro día."
    Se va.
    ->->
}

=== renzo_bar ===

Van al bar de la esquina.
Dos cervezas.

~ energia -= 1
~ renzo_relacion += 1
~ subir_conexion(1)

"¿Vos qué harías si te echan?", pregunta Renzo.

* ["No sé. Buscar otra cosa."]
    "Sí, yo también. Pero está difícil."
    "Está difícil."
    Se quedan en silencio.
    Dos tipos con miedo compartido.
    -> renzo_bar_fin
* ["Tengo algo de ahorros. Aguantaría unos meses."]
    "Yo no. Si me echan, cago fuego."
    "Algo aparece, Renzo."
    "Ojalá."
    -> renzo_bar_fin
* ["Hay otros laburos. Hay otras cosas."]
    Renzo te mira.
    "¿Cómo qué?"
    "No sé. Pero el mundo no se acaba."
    No suena convincente. Pero es algo.
    -> renzo_bar_fin

=== renzo_bar_fin ===

Terminan las cervezas.
Se despiden.

"Nos vemos mañana."
"Nos vemos."

->->

// --- PREGUNTAR A RENZO ---

=== renzo_preguntar_sobre_jefe ===

"Che, Renzo. ¿Viste cómo me miró el jefe?"

"Sí. Raro."

"¿Qué onda?"

"No sé. Pero a Martínez lo miró así el jueves antes de que lo citaran."

Eso no ayuda.

~ subir_trauma(1)

->->

// --- DESPUÉS DEL DESPIDO ---

=== renzo_enterarse_despido ===
// Cuando Renzo se entera de que te echaron

~ renzo_sabe_de_mi_despido = true

{renzo_relacion >= 3:
    Renzo te busca.
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
    Renzo te manda un mensaje.
    "Me enteré. Qué bajón."
    No respondés.
}

->->

=== renzo_despues_despido ===
// Intentar contactar a Renzo después de perder el laburo

{dia_actual <= 5:
    Llamás a Renzo.

    ~ ultima_tirada = d6()

    {ultima_tirada >= 4:
        Contesta.
        "Hola. ¿Cómo andás?"
        "Ahí. ¿Y vos? ¿Cómo está todo?"
        "Igual. Raro sin vos acá."

        {renzo_relacion >= 4:
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
    Pensás en llamar a Renzo.
    Pero... ¿para qué?
    Ya no comparten nada.
    Solo compartían el laburo.

    ~ renzo_estado = "distante"
    ->->
}

// --- FRAGMENTO NOCTURNO DE RENZO ---

=== renzo_fragmento_noche ===

Renzo no puede dormir.

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

    {renzo_relacion >= 4:
        Tendría que llamarte.
        Pero no sabe qué decir.
    }
}

"¿Estás bien?", pregunta ella sin abrir los ojos.

"Sí. Dormí."

Miente.
Todos mienten.

->->
