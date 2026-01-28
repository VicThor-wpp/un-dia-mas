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
