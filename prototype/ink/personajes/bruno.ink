// EL APÓSTOL BRUNO - El Fascista Territorial
// ============================================
// Expandido: aparición temprana, conflicto con Elena, más presencia

// === APARICIÓN TEMPRANA (MARTES/MIÉRCOLES) ===

=== bruno_camioneta_martes ===
// Escena Martes: Primera aparición - solo la camioneta

Cuando doblás la esquina, la ves.
Una camioneta negra. 4x4. Vidrios polarizados.
Estacionada frente a la iglesia evangélica.

No la conocés. Pero algo te eriza la nuca.

{elena_relacion >= 2:
    Elena está en el banco de siempre.
    Mira la camioneta.
    Su cara cambia.
    
    * [Preguntar.]
        "¿De quién es?"
        
        Elena no te mira.
        "De problemas."
        
        No dice más.
        Pero su silencio dice todo.
        
        ~ sabe_de_bruno = true
        ->->
    
    * [No preguntar.]
        ->->
- else:
    Los pibes de la esquina miran la camioneta.
    Uno dice: "El Apóstol."
    Otro se ríe nervioso.
    
    ~ sabe_de_bruno = true
    ->->
}

=== bruno_mencion_miercoles ===
// Escena Miércoles: Escuchás hablar de él

En la olla, mientras ayudás a pelar papas, escuchás:

"El Bruno anda reclutando de nuevo."

Sofía tensa la mandíbula.
No dice nada. Pero pela más fuerte.

"¿Bruno?", preguntás.

* [...]
-

Diego baja la voz.
"El 'Apóstol'. Tiene una chacra en las afueras.
Dice que rehabilita adictos. Pero..."

Se calla.

Sofía habla sin mirar:
"Pero nadie vuelve igual. Los que vuelven."

* ["¿Qué les hace?"]
    Diego mira a Sofía. Sofía sigue pelando.
    
    "Trabajo. Todo el día. Bloques. Leña.
    Les da comida y techo. Les saca todo lo demás."
    
    ~ sabe_de_bruno = true
    ~ unlock_idea(idea_orden_autoritario)
    ->->

* [No preguntar más.]
    El silencio te da la respuesta.
    
    ~ sabe_de_bruno = true
    ->->

=== bruno_y_tiago_miercoles ===
// Escena Miércoles tarde: Bruno se acerca a Tiago

{sabe_de_bruno:
    Ves la camioneta negra en la esquina.
    Y a Tiago hablando con alguien por la ventanilla.
    
    No podés escuchar qué dicen.
    Pero Tiago mira unas zapatillas que le muestran.
    
    La camioneta se va.
    Tiago se queda mirando sus zapatillas rotas.
    
    ~ bruno_contacto_tiago = true
    ->->
- else:
    ->->
}

// === BRUNO Y ELENA: EL PASADO ===

=== elena_sobre_bruno ===
// Escena: Elena te cuenta sobre Bruno
// Requiere: elena_relacion >= 3 y sabe_de_bruno

{elena_relacion >= 3 && sabe_de_bruno:
    
    "Elena, ¿qué onda con Bruno?"
    
    Elena deja de pelar.
    Cosa rara.
    
    "Lo conozco de antes."
    
    * ["¿De dónde?"]
        -> elena_historia_bruno
    
    * [Esperar.]
        -> elena_historia_bruno
- else:
    ->->
}

=== elena_historia_bruno ===

Elena mira hacia la calle.
# PAUSA

"En la dictadura había un milico joven. De los nuevos.
No era el que torturaba. Era el que miraba.
El que tomaba nota."

* [...]
-

"Después de la democracia, muchos se reciclaron.
Seguridad privada. Política. Religión."

Te mira.

"Bruno era un gurí cuando yo ya tenía arrugas.
Pero tiene los mismos ojos que aquellos.
Los ojos de los que miran y anotan."

* ["¿Usted cree que es el mismo?"]
    "No sé si es el mismo. Pero es del mismo palo.
    Orden. Disciplina. Control.
    Las palabras cambian. La mirada no."
    
    ~ elena_conto_bruno = true
    ~ bruno_tension += 1
    ->->

* ["¿Por qué no lo denuncia?"]
    Elena se ríe. Amarga.
    
    "¿Denunciar qué? ¿Que ayuda a los pobres?
    Tiene fotos con diputados, m'hijo.
    Nosotras tenemos una olla y un cucharón."
    
    ~ elena_conto_bruno = true
    ->->

=== elena_confronta_bruno ===
// Escena Sábado: Elena y Bruno cara a cara
// Requiere: bruno_tension >= 2 y elena_relacion >= 3

{bruno_tension >= 2 && elena_relacion >= 3:
    
    Bruno entra a la olla.
    Sin invitación. Como quien entra a su casa.
    
    Elena lo ve.
    Se levanta despacio. Las rodillas le crujen.
    
    "Bruno."
    
    Bruno sonríe.
    "Doña Elena. Cuánto tiempo."
    
    * [Observar.]
        -> elena_bruno_dialogo
    
    * [Intervenir.]
        "Bruno, ¿qué necesitás?"
        
        Bruno te mira. No le gustó la interrupción.
        
        "Hablaba con la doña. Cosas de antes."
        
        Elena: "Ya terminamos de hablar."
        
        ~ subir_dignidad(1)
        ->->
- else:
    ->->
}

=== elena_bruno_dialogo ===

Elena se para frente a Bruno.
Él le saca dos cabezas. Pero ella no retrocede.

"Todavía te acordás de mí", dice Bruno.

"Me acuerdo de todos."

* [...]
-

Bruno mira alrededor.
"Lindo lugar. Pero precario. Yo podría ayudar."

Elena no parpadea.
"Tu ayuda tiene un precio. Siempre lo tuvo."

Bruno se ríe.
"Todo tiene un precio, doña. Ustedes también cobran. En dignidad."

* [...]
-

Elena da un paso adelante.
Bruno, por primera vez, retrocede.

"La dignidad no se cobra, Bruno. Se construye.
Vos no sabés de eso."

Bruno achica los ojos.
"Nos vamos a ver de nuevo, doña."

"Ya lo sé. Siempre vuelven."

Bruno se va.
Elena se sienta. Las manos le tiemblan.
Pero no de miedo.

~ bruno_tension += 1
~ subir_dignidad(2)
~ elena_relacion += 1

->->

// === BRUNO: ENCUENTRO PRINCIPAL ===

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

* {elena_conto_bruno} [Mencionarle a Elena.]
    "Elena me contó de vos."
    
    Bruno deja de sonreír.
    Por un segundo.
    
    "La doña tiene buena memoria. Lástima que recuerda mal."
    
    Se va sin despedirse.
    
    ~ bruno_tension += 2
    ->->

// === BRUNO Y TIAGO ===

=== bruno_recluta_tiago ===
// Escena Sábado: Si la olla falló o Tiago está solo

Ves a Bruno hablando con Tiago.
Le muestra unas zapatillas nuevas.

"Son talle 40. Te van bien."

Tiago mira las zapatillas. Mira la olla cerrada.

* [Intervenir.]
    "Tiago, no agarres viaje."
    
    Bruno se interpone.
    "Dejalo decidir al pibe. Él quiere futuro. Vos no tenés nada para darle."
    
    {tiago_confianza >= 2:
        Tiago te mira. Duda.
        "¿Y qué me das vos?"
        
        * * ["Nada. Pero te doy la verdad."]
            "La verdad no llena la panza, vecino."
            
            Bruno pone las zapatillas en las manos de Tiago.
            
            "Pensalo, pibe. Yo no te apuro."
            
            Se va. Tiago se queda con las zapatillas.
            
            ~ tiago_tentado_bruno = true
            ->->
        
        * * ["Que no estés solo."]
            Tiago baja la cabeza.
            Le devuelve las zapatillas a Bruno.
            
            "Paso."
            
            Bruno las recibe. Sonríe igual.
            "La oferta sigue en pie."
            
            Se va.
            
            ~ tiago_rechazo_bruno = true
            ~ subir_conexion(1)
            ->->
    - else:
        ->->
    }
    ->->

* [Dejarlo ir.]
    Tiago agarra las zapatillas.
    Sube a la camioneta.

    Perdiste.
    El barrio perdió.

    ~ tiago_captado_por_bruno = true
    ~ bajar_llama(2)
    ->->

=== bruno_presion_tiago ===
// Escena Jueves: Bruno presiona a Tiago
// Más explícita la manipulación

{sabe_de_bruno:
    
    Lo ves desde lejos.
    Bruno acorralando a Tiago contra una pared.
    
    No grita. No amenaza.
    Peor: convence.
    
    "Tu vieja está internada. No tenés a nadie.
    Yo te doy familia. Propósito. Orden."
    
    Tiago tiene los ojos mojados.
    
    * [Acercarte.]
        Caminás hacia ellos.
        Bruno te ve. No se inmuta.
        
        "Vecino. Estamos hablando."
        
        "Tiago, ¿estás bien?"
        
        Tiago asiente. Pero no te mira.
        
        Bruno sonríe.
        "El pibe está bien. Mejor que nunca."
        
        ~ bruno_tension += 1
        ~ tiago_confianza += 1
        ->->
    
    * [No intervenir.]
        Te quedás mirando.
        
        Bruno palmea a Tiago en la espalda.
        Como un padre.
        O como un dueño.
        
        ~ tiago_tentado_bruno = true
        ~ aumentar_inercia(1)
        ->->
- else:
    ->->
}

// === BRUNO MARCA TERRITORIO ===

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

// === BRUNO VS SOFÍA ===

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

// === OFERTA AL PROTAGONISTA (INERCIA ALTA) ===

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

=== bruno_oferta_seguridad ===
// Escena alternativa: Oferta de "seguridad"
// Para inercia >= 5 pero < 7

{inercia >= 5 && inercia < 7:
    Bruno te encuentra.
    
    "Che. Tengo una propuesta distinta."
    
    No sonríe esta vez. Es directo.
    
    "En el barrio hay cada vez más quilombo.
    Necesito gente que cuide las cosas.
    Seguridad. Nada raro."
    
    * ["¿Seguridad de qué?"]
        "De mis cosas. Mi gente. Mi territorio."
        
        La palabra 'territorio' te eriza.
        
        "Pagás por protección. Yo protejo.
        Es un negocio honesto."
        
        * * [Rechazar.]
            "No, Bruno. Paso."
            
            "Lástima. Tenés cara de confiable."
            
            Se va.
            
            ~ subir_dignidad(1)
            ->->
        
        * * [Pedir tiempo.]
            "Dejame pensarlo."
            
            "No hay mucho tiempo, vecino.
            Las oportunidades pasan."
            
            ~ aumentar_inercia(1)
            ->->
    
    * [Irte sin responder.]
        Te das vuelta.
        Caminás.
        
        "Vas a volver", dice a tu espalda.
        
        No te das vuelta.
        
        ~ subir_dignidad(1)
        ->->
- else:
    ->->
}

// === FRAGMENTO NOCTURNO ===

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

=== fragmento_bruno_sermon ===
// Fragmento: Bruno dando sermón

Bruno predica.

"¡La vagancia es pecado!
¡La dependencia es esclavitud!
¡Solo el trabajo dignifica!"

Los hombres de la chacra asienten.
Cansados. Quebrados. Pero asienten.

"¡Afuera les dan pescado! ¡Acá les doy propósito!"

Aplauden.
No porque quieran.
Porque es lo que se espera.

Bruno sonríe.
Otro día de cosecha.

->->

// === RESULTADO DOMINGO ===

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

=== bruno_y_claudia ===
// Escena potencial: Bruno y Claudia se cruzan
// Dos formas de control

{bruno_tension >= 2 && claudia_hostilidad >= 1:
    
    Los ves hablando.
    Bruno y Claudia. En la esquina.
    
    Ella con su carpeta. Él con su cruz.
    
    No sabés qué dicen.
    Pero asienten.
    
    Dos formas de orden.
    Dos formas de control.
    
    Ninguna te incluye.
    
    ~ olla_en_crisis = true
    ->->
- else:
    ->->
}

// === VARIABLES DE BRUNO ===
// bruno_tension: nivel de conflicto con Bruno (0-5)
// sabe_de_bruno: el protagonista conoce a Bruno
// bruno_contacto_tiago: Bruno contactó a Tiago antes
// tiago_tentado_bruno: Tiago está considerando la oferta
// tiago_rechazo_bruno: Tiago rechazó a Bruno
// tiago_captado_por_bruno: Bruno se llevó a Tiago
// elena_conto_bruno: Elena contó la historia de Bruno
