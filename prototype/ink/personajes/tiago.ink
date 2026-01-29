// TIAGO - El Pibe de Logística
// ============================================

=== tiago_primer_encuentro ===
// Escena Jueves/Viernes en la Olla

Un pibe flaco, con gorra, está moviendo cajones de verdura.
No parece tener más de 16 años.
Los brazos son pura fibra y nervio.

Te ve mirando.
"¿Qué mirás? ¿Ayudás o estorbás?"

* [Ofrecer ayuda.]
    "Vengo a dar una mano."
    
    Te tira una bolsa de papas. Pesada.
    "Ponela ahí. Que no toque el piso, que chupa humedad."
    
    Sabe lo que hace.
    
    ~ tiago_confianza += 1
    ->->

* [Preguntar quién es.]
    "Soy el que mueve las cosas para que coman."
    
    Sigue laburando. No le interesa charlar.
    
    ->->

=== tiago_conflicto_comida ===
// Escena Viernes: El conflicto con Claudia por la porción

Tiago se acerca a la olla con un tupper sucio.
"Es para la vieja. No puede venir."

Claudia (la auditora) se interpone.
"No se puede retirar comida. Es para consumo en el local."

Tiago te mira a vos. Los ojos inyectados de bronca.
"¿Le vas a decir algo a la cheta esta o qué?"

* [Defender a Tiago.]
    Te plantás frente a Claudia.
    "La abuela de Tiago existe. Vive a dos cuadras. Lleváselo, pibe."
    
    Tiago no espera. Agarra el tupper y desaparece.
    Claudia anota algo en su carpeta.
    
    ~ tiago_confianza += 2
    ~ claudia_hostilidad += 1
    ~ disminuir_inercia(1)
    ->->

* [No intervenir.]
    Te quedás callado.

    Tiago tira el tupper al piso.
    "Métanse el guiso en el orto."

    Se va pateando una silla.

    ~ tiago_estado = "ido"
    ~ aumentar_inercia(1)
    ->->

=== tiago_se_abre ===
// Escena Viernes/Sábado: Si tiago_confianza >= 2

{tiago_confianza >= 2:
    Tiago se sienta a tu lado.
    No dice nada.

    Después de un rato:

    "Mi vieja está internada.
    En el Vilardebó."
    # PAUSA

    No te mira.

    "No voy a visitarla.
    No puedo."
    # PAUSA

    * [Escuchar en silencio.]
        No decís nada.

        A veces el silencio es el único respeto.

        Tiago asiente.
        "Gracias por no decir nada."

        ~ tiago_confianza += 2
        ->->

    * [Decir algo de apoyo.]
        "Está bien no poder."

        Tiago te mira.
        Por primera vez, sin desafío.

        "¿Vos creés?"

        "Sí."

        ~ tiago_confianza += 1
        ->->
- else:
    ->->
}

=== tiago_decision_final ===
// Escena Sábado/Domingo: La encrucijada

{tiago_confianza >= 3:
    Tiago te busca.

    "Bruno me ofreció llevarme a la chacra.
    Zapatillas. Comida. Un lugar."

    Te mira.

    "¿Qué hago?"

    * [Decirle que se quede.]
        "Quedate, Tiago.
        Acá también hay lugar.
        No es una chacra, pero es real."

        Tiago piensa.

        "¿Y si no alcanza?"

        "Vamos a hacer que alcance.
        Pero juntos."

        Tiago asiente.

        ~ tiago_se_queda = true
        ~ subir_llama(2)
        ~ subir_conexion(1)
        ->->

    * [Dejarlo decidir.]
        "No sé, Tiago.
        Es tu vida."

        Tiago baja la cabeza.

        "Nadie me dijo eso nunca."

        Se queda pensando.

        {llama >= 6:
            "Me quedo. Por ahora."
            ~ tiago_se_queda = true
        - else:
            "Voy a ir. A ver qué onda."
            ~ tiago_captado_por_bruno = true
            ~ bajar_llama(2)
        }
        ->->
- else:
    ->->
}

=== fragmento_tiago_techo ===
// Tiago en un techo, mirando el barrio

Tiago está en el techo de la olla.
Se subió por la canaleta.

Desde arriba, el barrio parece distinto.
Más ordenado.
Menos caótico.

Piensa en la chacra de Bruno.
Piensa en la olla.
Piensa en la calle.

Tres opciones.
Ninguna buena.

Se queda mirando las estrellas.
Las mismas de siempre.
Las únicas que no cambian.

->->

=== tiago_domingo ===
// Escena Domingo: Resultado de la decisión de Tiago

{tiago_se_queda:
    Tiago está en la olla.
    Barriendo. Ordenando.

    No habla mucho.
    Pero está.

    "¿Todo bien?", preguntás.

    "Más o menos."

    Pausa.

    "Pero estoy acá. Es algo."

    ~ subir_conexion(1)
    ->->
}

{tiago_captado_por_bruno:
    Pasás por la esquina.
    La camioneta de Bruno está ahí.

    Adentro, Tiago.
    Mira para otro lado cuando te ve.

    Ya no es del barrio.
    Ya no es de nadie.

    ~ bajar_llama(1)
    ->->
}

->->

=== tiago_en_asamblea ===
// Escena Sábado: Tiago en la asamblea (si se quedó)

{tiago_se_queda && participe_asamblea:
    Tiago está en el fondo.
    No habla. Escucha.

    Cuando alguien propone algo sobre los pibes del barrio,
    levanta la mano.

    "Yo puedo ayudar con eso."

    Primera vez que lo ves participar.

    ~ tiago_confianza += 1
    ~ subir_llama(1)
    ->->
- else:
    ->->
}
