// ============================================
// PERSONAJE: DIEGO
// Venezolano, llegó hace poco
// Trabaja en depósito, situación precaria
// ============================================

// --- ENCUENTRO CASUAL EN EL BARRIO ---

=== diego_encuentro_casual ===

Diego camina rápido.
Siempre camina rápido.

Venezolano. Llegó hace ocho meses.
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

* [...]
-

~ diego_relacion += 1

Sofía le pasa una botella de agua. Se miran con respeto, como dos veteranos de una guerra que no termina.

~ diego_relacion += 1

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

~ diego_me_conto_historia = true

Diego mira el cigarrillo.

"En Caracas, antes de venirme, yo creía. De verdad creía. Estuve en una cooperativa agrícola en el llano. Metíamos las manos en la tierra pensando que por fin era nuestra, que el socialismo de abajo iba a funcionar."

"¿Y qué pasó?"

"Pasó que la revolución tiene muchos estómagos y pocas manos. La corrupción se comió las semillas, y el autoritarismo se comió a los que preguntábamos dónde estaba el fertilizante. Destruyeron lo que construimos, y de paso borraron el trabajo de los que estaban antes de ellos, que tampoco eran santos, pero al menos dejaban algo en pie."

Pausa larga. Diego mira sus manos, curtidas por dos tierras distintas.

"Vine acá para dejar de pelear, pero el hambre es el mismo monstruo con distinto acento. A veces... a veces ya ni me da la cabeza para imaginar que la cosa se acomode. Es como si el futuro fuera un idioma que dejé de hablar."

Comunidad.
En el medio de la nada, se tienen entre ellos.

~ diego_relacion += 1
~ subir_conexion(1)

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

{diego_viene_a_olla:
    Al menos mañana hay olla.
    Al menos va a estar ocupado.
    Cansarse hace bien. Ayuda a no pensar.
}

{ayude_a_diego:
    Piensa en vos.
En que estás empezando a entender que la 'clase media' era un cuento que te contabas para no sentirte parte de nosotros.

Se ríe bajito en la oscuridad.
"Uruguayo loco", piensa.
"Bienvenido a la resistencia. Acá no se factura, acá se sostiene."
}

Afuera, la ciudad duerme.
Él no.

Los inmigrantes no duermen.
Calculan.
Planean.
Sobreviven.

->->
