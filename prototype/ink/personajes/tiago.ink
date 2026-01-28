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
