// ============================================
// PERSONAJE: MARCOS
// Se alejó del barrio, quemado políticamente
// Aislado, desencantado
// ============================================

// --- ENCUENTRO CASUAL EN EL BARRIO ---

=== marcos_encuentro_casual ===

Marcos cruza la calle.
Rápido. Cabeza gacha.
Como si no quisiera que lo vean.

Lo conocés de antes.
Del barrio. De la época de las asambleas.
Ahora no viene nunca.

* [Llamarlo] -> marcos_llamar_calle
* [Dejarlo pasar] -> marcos_ignorar

=== marcos_llamar_calle ===

"¡Marcos!"

Se frena. Mira.
Por un segundo, parece que va a seguir de largo.
Pero se queda.

"Ah. Hola."

Incómodo. Distante.

"Hace rato que no te veo por acá."

"Sí. Ando en otra cosa."

Mentira. No anda en nada.
Pero no vas a decirlo.

* ["¿Cómo estás?"] -> marcos_como_estas
* ["Te extrañamos en la olla."] -> marcos_olla_mencion
* ["Bueno, nos vemos."] -> marcos_despedida_corta

=== marcos_como_estas ===

"¿Cómo estás?"

Pausa larga.

"Estoy."

No dice más.
No hace falta.

~ marcos_relacion += 1

->->

=== marcos_olla_mencion ===

"Te extrañamos en la olla. Sofía pregunta por vos."

Se tensa.

"Dile que estoy bien. Que... después paso."

No va a pasar.
Los dos lo saben.

->->

=== marcos_despedida_corta ===

"Bueno, nos vemos."

"Sí. Nos vemos."

Se va.
Rápido. Como antes.

->->

=== marcos_ignorar ===

Lo dejás pasar.
No te ve. O finge.

Marcos ya no es parte del barrio.
O no quiere serlo.

->->

// --- INTENTAR CONTACTAR A MARCOS ---

=== marcos_no_esta ===
// Tunnel: Marcos no está disponible

~ intente_contactar_marcos = true

Tocás timbre.
Nada.

Llamás.
No contesta.

Quizás no está.
Quizás no quiere atender.

Con Marcos nunca sabés.

->->

=== marcos_contesta ===
// Tunnel: Marcos contesta (raro)

Llamás a Marcos.
Esta vez contesta.

"Hola."

"Marcos, soy yo. ¿Podemos vernos?"

Silencio.

"¿Para qué?"

"No sé. Para hablar."

Más silencio.

* ["Estoy preocupado por vos."] -> marcos_acepta_verse
* ["Necesito hablar con alguien."] -> marcos_acepta_verse
* ["Nada, olvidate."] -> marcos_rechaza

=== marcos_acepta_verse ===

Suspira.

"Dale. En la plaza. En una hora."

Corta.

Algo es algo.

->->

=== marcos_rechaza ===

"No. Ahora no puedo. Después te llamo."

No va a llamar.

"Dale."

Cortás.

->->

// --- ENCUENTRO EN LA PLAZA ---

=== marcos_encuentro_plaza ===

~ subir_conexion(1)
~ energia -= 1

Marcos está sentado en un banco.
Más flaco que antes.
Más cansado.
Barba de días.

"Viniste."

"Te dije que venía."

Se sientan.
Silencio largo.

"¿Qué onda?", pregunta al fin.

* ["¿Cómo estás de verdad?"] -> marcos_verdad
* ["¿Por qué te alejaste?"] -> marcos_porque
* ["Nada. Solo quería verte."] -> marcos_solo_ver

=== marcos_verdad ===

"¿Cómo estás de verdad, Marcos?"

Te mira. Ojos cansados.

"Mal. ¿Querés que te mienta?"

"No."

"Mal. No duermo. No salgo. No hago nada."

Pausa.

"Estoy podrido de todo."

~ marcos_relacion += 1

->->

=== marcos_porque ===

"¿Por qué te alejaste? Del barrio, de la olla, de todo."

Silencio largo.

"Porque me quemé."

"¿Cómo?"

"Diez años en la militancia. Asambleas, marchas, colectas.
Y al final... nada cambió."

Mira el piso.

"Me cansé de pelear para nada."

~ marcos_era_militante = true
~ marcos_relacion += 1

->->

=== marcos_solo_ver ===

"Nada. Solo quería verte."

Asiente.

"Gracias."

No dice más.
Pero se queda.

A veces estar alcanza.

~ marcos_relacion += 1

->->

// --- CONVERSACION PROFUNDA ---

=== marcos_conversacion_profunda ===

~ hable_con_marcos_profundo = true

Es de tarde. El sol baja.
Marcos sigue en el banco.

"¿Por qué seguís viniendo a hablar conmigo?"

Buena pregunta.

* ["Porque me importás."] -> marcos_importa
* ["Porque yo también estoy solo."] -> marcos_solo
* ["No sé."] -> marcos_no_se

=== marcos_importa ===

"Porque me importás, Marcos."

Te mira. Sorprendido.

"¿Por qué? No hice nada por vos."

"No tiene que ser transaccional."

Silencio.

"Hace mucho que nadie me dice eso."

~ marcos_relacion += 1
~ subir_conexion(1)

->->

=== marcos_solo ===

"Porque yo también estoy solo. Y vos entendés."

Asiente.

"Sí. Entiendo."

Los dos solos.
Juntos en la soledad.

~ marcos_relacion += 1
~ subir_conexion(1)

->->

=== marcos_no_se ===

"No sé. Capaz porque sí."

"Eso no es una respuesta."

"Es la única que tengo."

Se ríe. Por primera vez.
Una risa corta, rota.
Pero risa.

~ marcos_relacion += 1

->->

// --- MARCOS REVELA SU SITUACION ---

=== marcos_revelar_despido ===

~ marcos_secreto = true

Están hablando. De nada.
De pronto, Marcos dice:

"Me echaron."

"¿Cuándo?"

"Hace seis meses. No se lo conté a nadie."

Ah.
Por eso estaba tan ausente.
Por eso se aisló.

"¿Por qué no dijiste nada?"

"Vergüenza. Orgullo. No sé.
Después de todo lo que hablaba sobre dignidad del trabajador...
y me echaron como a cualquiera."

~ marcos_relacion += 1
~ subir_conexion(1)

* ["A mí también me echaron."] -> marcos_compartir
* ["No tenés que avergonzarte."] -> marcos_sin_verguenza
* [Solo escuchar] -> marcos_escuchar

=== marcos_compartir ===

"A mí también me echaron."

Te mira. Sorprendido.

"¿En serio?"

"Hace poco. También me da vergüenza."

"Bienvenido al club."

Una sonrisa amarga.
Pero compartida.

~ marcos_estado = "mirando"

->->

=== marcos_sin_verguenza ===

"No tenés que avergonzarte, Marcos. Le pasa a todo el mundo."

"Sí. Pero duele igual."

"Lo sé."

Silencio.

"Gracias por escuchar."

~ marcos_estado = "mirando"

->->

=== marcos_escuchar ===

No decís nada.
Solo escuchás.

Marcos habla.
De la rabia, de la impotencia, del vacío.

A veces eso es lo que hace falta.
Que alguien escuche.

~ marcos_estado = "mirando"

->->

// --- INVITAR A MARCOS ---

=== marcos_invitar_asamblea ===

"Hay una asamblea hoy. En la olla. ¿Querés venir?"

Marcos lo piensa.
Largo.

"No sé. Hace mucho que no..."

* ["Solo vení a mirar. Sin compromiso."] -> marcos_acepta_asamblea
* ["Entiendo. Otra vez será."] -> marcos_rechaza_asamblea

=== marcos_acepta_asamblea ===

"Solo a mirar. No tenés que hacer nada."

Pausa.

"Dale. Pero me voy cuando quiera."

"Obvio."

~ marcos_vino_a_asamblea = true
~ marcos_estado = "mirando"

->->

=== marcos_rechaza_asamblea ===

"No. Todavía no estoy listo."

"Está bien. Cuando quieras."

"Gracias."

->->

=== marcos_en_asamblea ===
// Tunnel: Marcos en la asamblea

{marcos_vino_a_asamblea:
    Marcos está en el fondo.
    Mirando.
    No habla.
    Pero está.

    Sofía lo ve. Lo saluda de lejos.
    Elena asiente.
    Todos saben que es un paso.
}

->->

=== marcos_se_fue ===
// Tunnel: Marcos se fue de la asamblea

{marcos_vino_a_asamblea:
    Marcos se fue antes de que terminara.
    Pero estuvo.
    Quizás eso es algo.
}

->->

// --- TELEFONO ---

=== marcos_llamar ===
// Tunnel: Llamar a Marcos

Llamás a Marcos.

Para variar, contesta.

"Hola."

"Hola. Quería ver cómo estabas."

Silencio.

"Estoy. Es lo que hay."

->->

=== marcos_conversacion_telefono ===
// Tunnel: Conversacion telefonica con Marcos

{marcos_vino_a_asamblea:
    "Ayer fuiste a la asamblea."
    "Sí. No sé por qué. Pero fui."
    "Estuvo bien que fueras."
    "No sé. Quizás."
}

Hablan un rato.
Marcos sigue distante.
Pero un poco menos.

~ subir_conexion(1)

->->

=== marcos_hablar_precariedad ===
// Tunnel: Hablar de la precariedad

Hablan un rato.
De la precariedad.
De cómo todo se cae.
De cómo seguir.

Marcos no tiene respuestas.
Pero al menos no estás solo.

->->

=== marcos_funcionar ===
// Tunnel: Marcos sobre funcionar

"¿Cómo la llevás?"

"No la llevo. Funciono. Es distinto."

Funcionar.
Hacer lo mínimo.
Sobrevivir sin vivir.

Conocés la sensación.

->->

// --- IDEAS INVOLUNTARIAS ---

=== marcos_idea_esto_es_lo_que_hay ===
// Tunnel: Idea involuntaria al ver a Marcos

// Idea involuntaria: "ESTO ES LO QUE HAY"

No la elegiste.
Llegó sola.
Mirando a Marcos.
Viendo el futuro posible.

~ idea_esto_es_lo_que_hay = true

->->

// --- FRAGMENTO NOCTURNO DE MARCOS ---

=== marcos_fragmento_noche ===

Marcos mira la tele.
Sin sonido.
Las imágenes pasan.

Su departamento es chico. Desordenado.
Platos sucios. Ropa en el piso.
La entropía de la depresión.

{marcos_secreto:
    Piensa en el laburo que perdió.
    En los compañeros que ya no llaman.
    En la vida que se fue deshaciendo.
}

{marcos_era_militante:
    Piensa en las asambleas de antes.
    En cuando creía que se podía cambiar algo.
    En la energía que tenía.

    ¿Adónde fue todo eso?
    ¿Adónde fue él?
}

{marcos_vino_a_asamblea:
    Piensa en hoy.
    En la olla. En la gente.
    En que se sintió raro volver.

    Pero también se sintió...
    ¿Algo?

    Quizás hay algo todavía.
}

{marcos_relacion >= 3:
    Piensa en vos.
    En que alguien insiste.
    En que alguien no se rindió con él.

    No sabe por qué.
    Pero agradece.
}

A las tres de la mañana apaga la tele.
Se acuesta sin desvestirse.

Mañana es otro día.
Igual que hoy.
Igual que ayer.

Pero quizás no.
Quizás algo cambie.

{marcos_estado == "mirando":
    Por primera vez en meses,
    se duerme con algo parecido a la esperanza.
- else:
    Se duerme con el vacío de siempre.
    El vacío que ya es familiar.
}

->->
