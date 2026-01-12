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

"El trabajo está raro. Dicen que van a echar gente."

"¿A vos?"

"No sé. Ojalá que no."

Si lo echan, no tiene nada.
Ni papeles. Ni red. Ni nada.

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

Diego está en la fila.
Trata de pasar desapercibido.
No lo logra.

~ diego_viene_a_olla = true

"No sabía que venías acá."

Se pone tenso. Vergüenza.

"A veces. Cuando no... cuando está difícil."

* ["No hay drama. Todos venimos."] -> diego_tranquilizar
* ["¿Está muy jodido?"] -> diego_pregunta_situacion
* [Asentir y seguir] -> diego_no_presionar

=== diego_tranquilizar ===

"No hay drama, Diego. Para eso está esto."

Relaja un poco.

"En Venezuela yo ayudaba en comedores.
Nunca pensé que iba a estar del otro lado."

"Las cosas cambian."

"Sí. Cambian."

~ diego_relacion += 1

Sofía le sirve. Porción grande.
Ella sabe quién necesita más.

->->

=== diego_pregunta_situacion ===

"¿Está muy jodido?"

Baja la voz.

"El mes pasado no pude mandar plata a mi familia.
Primer mes en ocho que no mando."

~ diego_familia_en_venezuela = true

Su mamá. Su hermana. Allá.
Esperando.

"Lo siento, Diego."

"Está bien. Voy a poder. Siempre se puede."

No suena convencido.

~ diego_relacion += 1

->->

=== diego_no_presionar ===

Asentís. Seguís.
A veces el silencio es respeto.

Diego come solo.
En una esquina.
Mirando el plato.

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

"Salí de Caracas hace dos años. Bus hasta Colombia.
De Colombia a Ecuador. De Ecuador a Perú."

Pausa.

"En Perú estuve seis meses. Vendiendo café en la calle.
Después me vine para acá. Un amigo me dijo que había trabajo."

"¿Y había?"

"Más o menos. El depósito paga poco. Pero paga."

Tira el cigarrillo.

"Dejé a mi mamá, a mi hermana. Mi vida entera.
Allá no se puede vivir. Pero acá..."

No termina la frase.

"Acá tampoco es fácil."

"No. Pero al menos hay comida en los supermercados."

Perspectiva.
Lo que para vos es crisis, para él es progreso.

~ diego_relacion += 1
~ subir_conexion(1)

->->

=== diego_opinion ===

"La situación está jodida. Para todos."

Fuma.

"Pero ustedes no saben lo que es jodido de verdad.
Cuando la luz se va diez horas. Cuando no hay agua.
Cuando un kilo de arroz cuesta un sueldo."

"¿Y esto?"

"Esto es difícil. Pero no es Venezuela."

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

"¿Cuándo?"

"Ayer. Sin aviso. 'Ya no te necesitamos'."

Mira el piso.

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

{diego_familia_en_venezuela:
    "Mi vieja va a tener que esperar.
    No sé cómo le voy a decir."
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

    "Gracias. Lo mismo digo."

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

* [Seguir mirando] # FALSA
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
    Al menos hay un plato seguro.
    Al menos hay gente.
}

{ayude_a_diego:
    Piensa en vos.
    En que hay uruguayos que lo ven.
    Que no es invisible.

    Eso vale más que la plata.
}

Afuera, la ciudad duerme.
Él no.

* [Calcular] # FALSA
    Los inmigrantes no duermen.
    Calculan.
    Planean.
    Sobreviven.

->->
