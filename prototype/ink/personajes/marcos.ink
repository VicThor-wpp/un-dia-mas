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
# PAUSA

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

* [...]
-

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

"Mal. No duermo. El seguro de paro se me termina el mes que viene.
Y a mi edad, encontrar algo fijo es un chiste. Me estoy comiendo los ahorros."

* [...]
-

Pausa.
# PAUSA

"Estoy podrido de todo."

~ marcos_relacion += 1

->->

=== marcos_porque ===

"¿Por qué te alejaste? Del barrio, de la olla, de todo."

Silencio largo.

"Porque me quemé los ojos de ver cómo nos usaban. Diez años en la mesa chica de la militancia. Asambleas de trasnoche, marchas con la garganta rota, colectas para compañeros que después te vendían por un puesto en el ministerio."

Mira el piso.

"Cansado de ver cómo la estructura se morphaba el espíritu. Peleamos contra el sistema de afuera y nos terminó ganando el sistema de adentro. Al final, los de mi clase siguen igual, y los que hablaban en su nombre tienen auto nuevo. Me cansé de pelear para nada."

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

// Chequeo social: llegar emocionalmente a Marcos (difícil - está muy aislado)
# DADOS:CHEQUEO
~ temp resultado_marcos_reconectar = chequeo_completo_social(marcos_relacion, 5)
{ resultado_marcos_reconectar == 2:
    Silencio largo. Marcos mira el piso.

    Cuando levanta la vista, tiene los ojos húmedos.

    "Hace mucho que nadie me dice eso."

    Pausa.
    # PAUSA

    "¿Sabés qué es lo peor de alejarte? Que después no sabés cómo volver. Y cada día es más difícil."

    Se le quiebra la voz un segundo.

    "Gracias por insistir. De verdad."

    ~ marcos_relacion += 2
    ~ subir_conexion(2)
}
{ resultado_marcos_reconectar == 1:
    Silencio.

    "Hace mucho que nadie me dice eso."

    ~ marcos_relacion += 1
    ~ subir_conexion(1)
}
{ resultado_marcos_reconectar == 0:
    Marcos se queda callado.
    Asiente apenas.

    No te rechaza. Pero tampoco se abre.
    La pared sigue ahí. Un poco más baja, quizás.

    ~ marcos_relacion += 1
}
{ resultado_marcos_reconectar == -1:
    Marcos se pone de pie.

    "No hagás eso."

    "¿Qué cosa?"

    "Venirme con eso de que te importo. No me conocés. No sabés nada."

    Se va caminando rápido.
    La defensa de los que tienen miedo de que les importe algo.

    ~ bajar_conexion(1)
}

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

// --- LOS HIJOS DE MARCOS ---

=== marcos_sobre_hijos ===

~ marcos_hablo_de_hijos = true

"¿Y tus hijos, Marcos? ¿Cómo están?"

Silencio largo.

"Lejos."

* [...]
-

"Lucía está en Barcelona. Se fue en 2019. Trabaja en comunicación, algo de redes sociales. Volvió una vez, hace dos años."

"¿Y el otro?"

"Martín está en Madrid. Se fue detrás de la hermana en 2021. Estudia algo de tecnología. No entiendo bien qué hace."

* [...]
-

Pausa.

"Hablamos por WhatsApp. Cada tanto. Pero las conversaciones son... superficiales. '¿Cómo estás?' 'Bien'. '¿Y vos?' 'Bien'. Nada de verdad."

* ["¿Los extrañás?"]
    "No sé si extraño. No sé si tengo derecho a extrañar."
    -> marcos_hijos_cont
    
* ["Debe ser duro."]
    "Es lo que es. Ellos están mejor allá. Acá no hay nada para ellos."
    -> marcos_hijos_cont

=== marcos_hijos_cont ===

* [...]
-

"¿Sabés qué pienso a veces?"

"¿Qué?"

"Les dejamos un país del que se tienen que ir. Toda mi vida militando para construir algo mejor, y mis hijos se tienen que en Europa a lavar platos o programar boludeces."

* [...]
-

Su voz se quiebra un poco.
# PAUSA

"Cuando era joven, la política era todo. No aprendí a ser padre fuera de eso. Y ahora están lejos y no sé cómo hablarles."

* [...]
-

"A veces los veo en videollamada. Sonriendo. Felices. Lejos."

Pausa.

"Y no sé si siento alivio o fracaso."

~ subir_conexion(1)
~ marcos_relacion += 1

->->

=== marcos_sobre_zabalza ===
// Referencia a Jorge Zabalza

~ marcos_hablo_de_zabalza = true

"¿Conocés a Zabalza?"

"¿Jorge Zabalza? El tupamaro..."

"El que cuestiona la historia oficial. El que dice lo que nadie quiere decir."

* [...]
-

"Leí una entrevista suya. De las que da cada tanto. Y sentí que alguien decía en voz alta lo que yo pensaba en silencio."

"¿Qué pensás?"

* [...]
-

"Que la revolución se la comió la burocracia. Que los que empezaron peleando contra el sistema terminaron siendo el sistema. Que los que dormían en pensiones ahora viven en barrios privados."

* [...]
-

"Zabalza sigue hablando. Sigue poniendo el dedo en la llaga. Yo me callé."

"¿Por qué?"

"Porque cuando lo decís en voz alta, te quedás solo. Y yo ya estaba bastante solo."

~ subir_conexion(1)
~ marcos_relacion += 1

->->

=== marcos_noche_votos_2009 ===
// La noche de las internas 2009

~ marcos_conto_2009 = true

"¿Te acordás del 2009?"

"¿Qué pasó en el 2009?"

"Las internas del Frente. Cuando eligieron a Mujica."

* [...]
-

"Estuve en el festejo. En la sede. Era euforia. La gente saltando, gritando. El triunfo."

"¿Y?"

* [...]
-

"Y mientras la militancia de base festejaba, vi a los dirigentes en un rincón. Repartiéndose cargos. Hablando de quién iba a qué ministerio, quién se quedaba con qué secretaría."

"Como si fuera botín de guerra."

"Exacto. Botín."

* [...]
-

Marcos mira sus manos.

"Vi compañeros que dormían en pensiones brindando porque ahora iban a vivir en casas con alarma. Vi la transformación en tiempo real."

"¿Y qué hiciste?"

"Nada. Me quedé mirando. Y al otro día seguí militando. Tardé años en animarme a irme."

* [...]
-

"Ese fue el principio del fin. Solo que no lo supe hasta mucho después."

~ subir_conexion(1)
~ marcos_relacion += 1

->->

=== marcos_sobre_voto_blanco ===
// El voto en blanco

~ marcos_conto_voto = true

"¿Sabés qué hice la última elección?"

"¿Qué?"

"Voté en blanco."

* [...]
-

"Después de treinta años votando a la izquierda. Después de todo lo que militía. Fui al cuarto oscuro y no pude poner la cruz."

"¿Por qué?"

"Porque no podía votar a los que me traicionaron. Pero tampoco podía votar a la derecha. Entonces nada."

* [...]
-

"Me sentí sucio una semana entera. Como si hubiera traicionado a los compañeros muertos. A los que se jugaron la vida."

"¿Y ahora?"

"Ahora... ahora no sé. Capaz que votar en blanco fue lo más honesto que hice en años. O capaz que fue cobardía. No sé."

~ marcos_relacion += 1

->->

// --- MARCOS REVELA SU SITUACION ---

=== marcos_revelar_despido ===

~ marcos_secreto = true

Están hablando. De nada.
De pronto, Marcos dice:

"Me echaron."
# PAUSA

"¿Cuándo?"

"Hace seis meses. No se lo conté a nadie."

* [...]
-

Ah.
Por eso estaba tan ausente.
Por eso se aisló.

"¿Por qué no dijiste nada?"

* [...]
-

""Vergüenza. Orgullo. No sé.
Después de todo lo que hablaba sobre dignidad del trabajador...
y me echaron como a cualquiera."
# PAUSA"

~ marcos_relacion += 1
~ subir_conexion(1)
~ activar_quien_soy()

* ["A mí también me echaron."] -> marcos_compartir
* ["No tenés que avergonzarte."] -> marcos_sin_verguenza
* [Solo escuchar] -> marcos_escuchar

=== marcos_compartir ===

"A mí también me echaron."

Te mira. Sorprendido.

"¿En serio?"

"Hace poco. También me da vergüenza."

// Chequeo mental: conectar emocionalmente desde la vulnerabilidad compartida
# DADOS:CHEQUEO
~ temp resultado_marcos_emocional = chequeo_completo_mental(marcos_relacion, 5)
{ resultado_marcos_emocional == 2:
    "Bienvenido al club."

    Una sonrisa amarga. Pero compartida.

    Y entonces Marcos dice algo inesperado:

    "¿Sabés qué? Capaz que esto es lo que necesitaba. Que alguien que entiende me diga que no estoy loco."

    Se queda un momento.

    "Diez años de militancia y me echaron como a un trapo. La dignidad del trabajador, decía. Y miranos."

    Pero hay algo diferente en su voz. No amargura. Algo más tibio.

    ~ marcos_estado = "mirando"
    ~ marcos_relacion += 1
    ~ subir_conexion(1)
}
{ resultado_marcos_emocional == 1:
    "Bienvenido al club."

    Una sonrisa amarga.
    Pero compartida.

    ~ marcos_estado = "mirando"
}
{ resultado_marcos_emocional == 0:
    "Bienvenido al club."

    El tono es seco. Distante.
    Pero no se va.

    ~ marcos_estado = "mirando"
}
{ resultado_marcos_emocional == -1:
    "Bienvenido al club."

    Pero algo se apaga en su cara.

    "Qué mierda, ¿no? Todos iguales. Todos descartables."

    El intento de conectar se convierte en confirmación de lo peor.
    Para los dos.

    ~ marcos_estado = "mirando"
    ~ aumentar_inercia(1)
}

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

~ activar_esto_es_lo_que_hay()

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

// --- FRAGMENTOS NOCTURNOS DE MARCOS ---

=== fragmento_marcos_insomnio ===
Marcos no duerme.

El techo. Las paredes. El silencio.

Antes iba a las asambleas. Antes creía.
Antes había fuego.

{marcos_relacion >= 2:
    Hoy alguien le habló.
    No de política. De nada.
    Solo hablar.

    Eso jode. Porque es más difícil
    ser cínico cuando alguien te mira a los ojos.
}

Se da vuelta. Otra vez.
El insomnio de los desencantados es el peor.

->->

=== fragmento_marcos_balcon ===
Marcos sale al balcón.

Fuma.
La ciudad abajo.
Las luces de las casas.

{marcos_vino_a_asamblea:
    Fue a la asamblea. No sabe por qué.
    Capaz que por vos. Capaz que por curiosidad.

    No fue tan malo.
    Pero no lo va a admitir.
}

Tira el pucho.
Mañana es otro día.
Igual que todos.

->->

=== fragmento_marcos_musica ===
Marcos pone música.
Rock nacional. De los '80.

Charly cantando sobre demoler.
Los Redondos sobre la bestia.

Sube el volumen.
La vecina golpea la pared.
Baja el volumen.

Música. Cigarros. Insomnio.
Las tres constantes de su vida.

->->

// ============================================
// MARCOS - DOMINGO EN LA OLLA
// ============================================

=== marcos_domingo_olla ===
// Triggered from domingo.ink if marcos_vino_a_asamblea && marcos_relacion >= 4

Marcos está en la olla.

No en la puerta. No mirando de lejos.
Adentro.

Tiene las manos en los bolsillos.
La postura de alguien que no sabe dónde ponerse.

{marcos_secreto:
    Te ve.

    "No me mires así."

    "..."

    "Vine. No sé por qué. No me hagas explicar."
}
{not marcos_secreto:
    Te ve. Asiente.

    Algo cambió desde ayer.
    No sabés qué. Pero algo.
}

* [No decir nada. Estar.]
    No decís nada.
    Él tampoco.

    Se quedan así.
    Dos tipos en una olla popular un domingo.

    No es heroico.
    No es revolucionario.

    Pero está ahí.

    ~ marcos_estado = "reconectando"
    ~ marcos_relacion += 1
    ~ subir_conexion(1)
    ~ subir_llama(1)

    ->->

* [Pasarle un mate.]
    Le pasás un mate.

    Lo mira. Lo agarra.

    "Hace rato que no tomaba mate con alguien."

    Pausa.

    "Gracias."

    No es solo por el mate.

    ~ marcos_estado = "reconectando"
    ~ marcos_relacion += 1
    ~ subir_conexion(1)
    ~ subir_llama(1)

    ->->
