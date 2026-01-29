// EL APÓSTOL BRUNO - El Fascista Territorial
// ============================================

=== bruno_primer_encuentro ===
// Escena Jueves/Viernes: La 4x4

Una camioneta negra, vidrios polarizados, estaciona en la esquina.
Baja un tipo. Camisa blanca impecable, cruz de madera grande en el pecho.
Pero se mueve como un policía.

Es el "Apóstol" Bruno.

Mira la fila de la olla. Niega con la cabeza.

"Mucha miseria, hermano. Mucha oscuridad."

Se acerca a vos.

"Vos tenés cara de querer salir de esto.
En mi chacra no damos pescado. Enseñamos a pescar.
Con disciplina. Con orden."

* [Confrontarlo.]
    "Acá nadie pide pescado, Bruno. La gente tiene hambre."
    
    Se ríe. No le molesta.
    "El hambre se cura trabajando. La vagancia no."
    
    Te palmea el hombro. Fuerte.
    "Cuando te canses de jugar a la revolución, buscame."
    
    ~ bruno_tension += 1
    ->->

* [Escuchar en silencio.]
    "¿Y qué hay que hacer?"
    
    "Trabajar. Bloques. Leña. Limpieza.
    Te doy techo, comida y orden.
    A cambio de tu voluntad."
    
    Suena tentador. El orden suena tentador cuando todo es caos.
    
    ~ aumentar_inercia(1)
    ~ unlock_idea(idea_orden_autoritario)
    ->->

=== bruno_recluta_tiago ===
// Escena Sábado: Si la olla falló

Ves a Bruno hablando con Tiago.
Le muestra unas zapatillas nuevas.

"Son talle 40. Te van bien."

Tiago mira las zapatillas. Mira la olla cerrada.

* [Intervenir.]
    "Tiago, no agarres viaje."
    
    Bruno se interpone.
    "Dejalo decidir al pibe. Él quiere futuro. Vos no tenés nada para darle."
    
    ->->

* [Dejarlo ir.]
    Tiago agarra las zapatillas.
    Sube a la camioneta.

    Perdiste.
    El barrio perdió.

    ~ tiago_captado_por_bruno = true
    ~ bajar_llama(2)
    ->->

=== bruno_la_visita ===
// Escena Jueves tarde: Bruno marca territorio

La camioneta negra aparece en la esquina.
Motor encendido. Vidrios polarizados.

Los pibes de la vereda se alejan.
Saben quién es.

El vidrio baja. Solo un poco.

"Buenas tardes."

No es un saludo.
Es un aviso.

Bruno mira la fila de la olla.
Cuenta cabezas.
Toma nota mental.

El vidrio sube.
La camioneta se va.

Pero el mensaje quedó.
Él estuvo acá.
Está mirando.

->->

=== bruno_confronta_sofia ===
// Escena Viernes: El conflicto ideológico

Bruno se baja de la camioneta.
Camina hacia Sofía.

"Vecina. ¿Cuántos platos hoy?"

Sofía no lo mira.
Sigue revolviendo.

"Los que hagan falta."

Bruno sonríe.
"Eso es bonito. Pero no es sustentable."

Se acerca más.
"Ustedes dan pescado. Yo enseño a pescar.
Con disciplina. Con orden. Con Dios."

Sofía suelta el cucharón.
Lo mira.

"Tu Dios no lava los platos, Bruno.
Ni pela las papas.
Acá laburamos todos."

Bruno retrocede.
Pero sigue sonriendo.

"Vamos a ver cuánto dura esto sin orden."

Se sube a la camioneta.
Se va.

~ bruno_tension += 2

->->

=== bruno_oferta_protagonista ===
// Escena Sábado/Domingo: Si inercia >= 7

{inercia >= 7:
    Bruno te encuentra solo.

    "Te vi estos días. Andás perdido."

    Te pone la mano en el hombro.
    Firme. Como un policía.

    "En mi chacra hay trabajo de verdad.
    Orden. Techo. Comida.
    Y un propósito."

    * [Rechazarlo con fuerza.]
        Sacás su mano de tu hombro.

        "No necesito tu orden, Bruno.
        Necesito trabajo. No un jefe que rece."

        Bruno achica los ojos.
        "Todos necesitan orden. Algunos lo entienden antes.
        Otros... después."

        ~ disminuir_inercia(2)
        ~ subir_dignidad(2)
        ->->

    * [Escuchar más.]
        "¿Qué hay que hacer?"

        "Trabajar. Obedecer. Creer.
        No es difícil si dejás el orgullo afuera."

        Te da una tarjeta.
        "Pensalo. Pero no pienses mucho."

        ~ aumentar_inercia(2)
        ~ unlock_idea(idea_orden_autoritario)
        ->->

    * [Quedarte callado.]
        No decís nada.

        Bruno espera.
        Después se ríe.

        "El silencio también es respuesta.
        Ya vas a venir."

        Se va.
        ->->
- else:
    ->->
}

=== fragmento_bruno_chacra ===
// Fragmento nocturno: Bruno en su chacra

Bruno camina entre los barracones.
Veinte camas. Todas ocupadas.

"Descanso a las diez. Trabajo a las cinco."

Nadie responde.
Nadie tiene que responder.

Entra a su oficina.
Las fotos con diputados. El crucifijo.
El mapa del barrio con las ollas marcadas.

"Uno por uno", murmura.

Apaga la luz.
Dios descansa.
Él también.

->->

=== bruno_domingo ===
// Escena Domingo: El resultado del conflicto con Bruno

{tiago_captado_por_bruno:
    // Bruno ganó a Tiago
    La camioneta de Bruno pasa por el barrio.
    Despacio. Como patrullando.

    Adentro, Tiago mira al frente.
    Como soldado.

    Bruno baja el vidrio.
    Te mira.
    Sonríe.

    "Gracias por nada, vecino."

    El vidrio sube.
    Se van.

    ~ bruno_tension += 1
    ->->
}

{tiago_se_queda && bruno_tension >= 2:
    // Bruno perdió a Tiago pero no se rinde
    Bruno aparece en la esquina.
    Solo. Sin camioneta.

    "Me sacaste al pibe."

    * [Confrontarlo.]
        Te plantás.

        "No te lo saqué. Él eligió."

        Bruno achica los ojos.
        "Nadie elige en este barrio.
        Solo sobreviven o no."

        Se va.
        Pero sabés que va a volver.

        ~ subir_dignidad(1)
        ->->

    * [Ignorarlo.]
        Seguís caminando.

        "Esto no termina", dice a tu espalda.

        No te das vuelta.

        ->->
- else:
    ->->
}

=== bruno_amenaza_olla ===
// Escena Sábado tarde: Bruno amenaza la olla directamente

{bruno_tension >= 3 && not lista_entregada:
    Bruno entra a la olla.
    Sin golpear. Sin permiso.

    "Escuché que tienen problemas con la municipalidad."

    Sofía se tensa.

    "Yo tengo contactos. Puedo ayudar.
    Pero necesito algo a cambio."

    * [Rechazarlo.]
        "No necesitamos tu ayuda, Bruno."

        "Todos necesitan ayuda.
        La pregunta es de quién la aceptan."

        Se va.

        ~ subir_dignidad(2)
        ~ bruno_tension += 1
        ->->

    * [Escuchar su propuesta.]
        "¿Qué querés?"

        "La lista. Los nombres de quienes vienen.
        Para mis... estadísticas."

        Sofía niega con la cabeza.

        "Piénsenlo."

        Se va.

        ~ olla_en_crisis = true
        ->->
- else:
    ->->
}
