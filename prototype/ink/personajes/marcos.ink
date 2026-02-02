// ============================================
// PERSONAJE: MARCOS "EL CUADRO QUEMADO"
// Ex-tupamaro, 48 años, divorciado, hijos en Europa
// Se alejó del barrio, quemado políticamente
// Aislado, desencantado, depresión política
// ============================================

// --- ESTADOS DE MARCOS ---
// marcos_estado: "ausente" -> "evitando" -> "respondiendo" -> "mirando" -> "reconectando"
// Progresión gradual, no saltos abruptos

// ============================================
// FASE 1: AUSENTE / EVITANDO
// ============================================

// --- ENCUENTRO CASUAL EN EL BARRIO (EVITA) ---

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
Manos en los bolsillos.
Mirando para otro lado.

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
~ marcos_estado = "evitando"

->->

=== marcos_olla_mencion ===

"Te extrañamos en la olla. Sofía pregunta por vos."

Se tensa.
Algo cruza su cara. ¿Culpa? ¿Nostalgia?

"Dile que estoy bien. Que... después paso."

No va a pasar.
Los dos lo saben.

~ marcos_estado = "evitando"

->->

=== marcos_despedida_corta ===

"Bueno, nos vemos."

"Sí. Nos vemos."

Se va.
Rápido. Como antes.
Sin mirar atrás.

~ marcos_estado = "evitando"

->->

=== marcos_ignorar ===

Lo dejás pasar.
No te ve. O finge.

Marcos ya no es parte del barrio.
O no quiere serlo.

->->

// --- SEGUNDO ENCUENTRO: EVITA HABLAR ---

=== marcos_encuentro_evita ===
// Trigger: marcos_estado == "evitando"

Lo ves en el almacén.
De espaldas.
Eligiendo algo. O fingiendo.

Cuando te acercás, apura.
Paga sin contar el vuelto.
Sale rápido.

"¡Marcos!"

Se frena en la puerta.
No se da vuelta.

"Después hablamos."

Y se va.

No es que no quiera.
Es que no puede.
Todavía no.

~ marcos_encuentros_evitados += 1

->->

=== marcos_supermercado ===
// Encuentro accidental

Lo ves en el pasillo de las latas.
Mirando precios.
Comparando. Contando monedas mentalmente.

Cuando te ve, se pone rígido.

* [Saludar de lejos] 
    Levantás la mano. 
    Él asiente.
    Se va para otro pasillo.
    
    Al menos no salió corriendo.
    ~ marcos_estado = "evitando"
    ->->

* [Acercarte]
    "Hola Marcos."
    
    "Hola."
    
    Silencio. Incómodo.
    
    "¿Todo bien?"
    
    "Sí. Haciendo las compras."
    
    Obvio. Estás en un supermercado.
    
    "Bueno. Nos vemos."
    
    Se va antes de que puedas decir algo más.
    ~ marcos_estado = "evitando"
    ->->

* [Dejarlo tranquilo]
    Fingís no verlo.
    Él finge no verte.
    
    A veces la distancia es lo que hace falta.
    ->->

// ============================================
// FASE 2: MENSAJES DE TEXTO
// ============================================

=== marcos_mensaje_no_responde ===
// Túnel: Marcos no responde mensaje

~ marcos_mensajes_enviados += 1

Le mandás un mensaje.
"Hola, ¿cómo andás?"

Tilde azul.
Lo leyó.

Nada.

Una hora después. Nada.
Dos horas. Nada.

Quizás mañana.
Quizás nunca.

->->

=== marcos_mensaje_responde_tarde ===
// Trigger: marcos_mensajes_enviados >= 2 && día miércoles o jueves
// Marcos finalmente responde

El celular vibra.
Mensaje de Marcos.

"Hola. Perdón, recién veo."

Mentira. Lo vio hace dos días.
Pero algo lo hizo responder.

* [Responder casual]
    "Tranqui. ¿Todo bien?"
    
    Tres puntos. Escribiendo.
    Desaparecen.
    Vuelven.
    
    "Más o menos. Vos?"
    
    "También más o menos."
    
    Silencio digital.
    Después:
    
    "Es lo que hay."
    
    Es lo que hay.
    La frase favorita del desencanto.
    
    ~ marcos_estado = "respondiendo"
    ~ marcos_relacion += 1
    ->->

* [Preguntarle algo concreto]
    "¿Tenés el número de Diego? Perdí el celular."
    
    Respuesta rápida esta vez.
    
    "No. Hace meses que no hablo con él."
    
    Pausa.
    
    "¿Está bien Diego?"
    
    Ahí. Un destello de interés.
    De conexión con los otros.
    
    "Sí, está bien. Anda con la cooperativa."
    
    "Ah. Bien."
    
    Silencio.
    
    "Después te llamo."
    
    No va a llamar. Pero dijo "después".
    Eso es algo.
    
    ~ marcos_estado = "respondiendo"
    ~ marcos_relacion += 1
    ->->

=== marcos_mensaje_noche ===
// Marcos manda mensaje de noche

Son las 2 AM.
El celular vibra.

Mensaje de Marcos.
"¿Estás despierto?"

* [Responder]
    "Sí. ¿Qué onda?"
    
    Tres puntos.
    Largo rato.
    
    "Nada. Insomnio."
    
    Pausa.
    
    "¿Vos por qué estás despierto?"
    
    "También insomnio."
    
    "El club de los que no duermen."
    
    Un emoji. El primero que manda.
    Una carita cansada.
    
    "Mañana tomamos un café?"
    
    * * ["Dale."]
        "Dale."
        
        "A las 5 en el bar de la esquina. Si no aparezco, no me esperes."
        
        "Va a aparecer", pensás.
        Algo cambió.
        
        ~ marcos_estado = "respondiendo"
        ~ marcos_acepto_cafe = true
        ~ marcos_relacion += 1
        ->->
        
    * * ["Cuando quieras."]
        "Cuando quieras."
        
        "Mañana te aviso."
        
        No va a avisar.
        Pero preguntó.
        Eso cuenta.
        
        ~ marcos_estado = "respondiendo"
        ->->

* [No responder]
    Son las 2 AM.
    Mañana respondés.
    
    (A la mañana, el mensaje dice "visto".)
    (Marcos no vuelve a escribir en una semana.)
    ->->

// ============================================
// FASE 3: CONVERSACIONES CORTAS
// ============================================

=== marcos_cafe_bar ===
// Trigger: marcos_acepto_cafe == true

Está en el bar.
Ya tiene un café adelante.
Frío, por el tiempo que lleva esperando.

"Pensé que no venías."

"Te dije que venía."

* [...]
-

Se sienta.
Silencio incómodo.
El ruido del bar llena el vacío.

"¿Y? ¿Cómo andás de verdad?"

"Mal."

Lo dice sin drama.
Como quien dice que llueve.

"¿Qué pasó?"

* [...]
-

"Nada pasó. Ese es el problema. Nada pasa. Los días son iguales. Me levanto, como algo, miro noticias, me indigno, no hago nada, me acuesto. Repeat."

Toma el café frío.

"¿Sabés qué es lo peor? Que sé exactamente qué está mal. Lo puedo analizar. Lo puedo explicar. Pero no puedo moverme."

* ["Parálisis por análisis."]
    "Parálisis por análisis. Sí. Muy gracioso."
    
    Pero hay algo en su voz. Un reconocimiento.
    
    "El problema de entender demasiado es que ves todas las consecuencias. Y entonces no hacés nada."
    
    ~ marcos_relacion += 1
    -> marcos_cafe_cont

* ["¿Y si dejás de analizar?"]
    "¿Y si dejás de analizar y hacés algo?"
    
    Te mira. Duro.
    
    "¿Qué querés que haga? ¿Que vaya a la olla a pelar papas como si eso cambiara algo?"
    
    "Capaz que sí cambia algo."
    
    "No cambia nada. Es un parche. Un analgésico. La estructura sigue igual."
    
    "Pero la gente come."
    
    Silencio.
    
    ~ marcos_relacion += 1
    -> marcos_cafe_cont

* [Solo escuchar]
    No decís nada.
    A veces eso es lo que hace falta.
    
    -> marcos_cafe_cont

=== marcos_cafe_cont ===

Pasan unos minutos.
Pide otro café.

"¿Sabés algo de los pibes?"

* ["¿Tus hijos?"]
    "Sí. ¿Sabés algo?"
    
    "¿No hablás con ellos?"
    
    Silencio.
    
    "Hablamos. Por WhatsApp. Cada tanto."
    
    Pausa larga.
    
    "Pero no sé hablar con ellos. No sé qué decirles. Cuando era joven la política era todo. No aprendí a ser padre fuera de eso."
    
    ~ marcos_hablo_de_hijos = true
    ~ marcos_relacion += 1
    ->->

* ["Están bien. Sofía habló con Lucía."]
    "Ah. Bien."
    
    Aliviado. Y triste.
    
    "¿Sofía habla con ella?"
    
    "Sí. Por Instagram o algo."
    
    "Qué bueno. Que alguien mantenga el contacto."
    
    No dice "yo no puedo".
    Pero está ahí.
    
    ~ marcos_hablo_de_hijos = true
    ->->

=== marcos_menciona_hijos_casual ===
// Versión corta - mención al pasar

Están hablando de otra cosa.
De pronto, Marcos dice:

"Martín me mandó foto del departamento nuevo. En Madrid."

* [...]
-

"Chiquito pero lindo. Tiene balcón."

Pausa.

"Está bien allá. Los dos están bien."

Lo dice como si tratara de convencerse.

"Me alegro", decís.

"Sí. Yo también."

Pero hay algo roto en su voz.
El orgullo y el fracaso mezclados.

~ marcos_hablo_de_hijos = true

->->

// ============================================
// MARCOS Y "LA ORGA" - CRÍTICA CON NOSTALGIA
// ============================================

=== marcos_critica_orga ===
// Trigger: conversación sobre política

"¿Sabés qué me jode?"

"¿Qué?"

"Que tenían razón en algunas cosas. La orga. El análisis de clase, la necesidad de organización, todo eso. Tenían razón."

* [...]
-

"Pero la cagaron. La cagamos. Nos convertimos en lo que criticábamos. Burócratas con discurso revolucionario."

Enciende un cigarrillo.
Le tiembla un poco la mano.

"Diez años de mi vida. Asambleas de trasnoche. Marchas. Colectas. Todo para que los que hablaban de la dignidad del trabajador terminaran con auto nuevo y casa en la costa."

* ["Pero había cosas buenas también."]
    "Había. Las había."
    
    Su voz cambia. Más suave.
    
    "La solidaridad era real. Al principio. Cuando éramos todos pobres juntos, cuando nadie tenía nada, cuando compartíamos todo."
    
    Pausa.
    
    "Extraño eso. No la orga. La mística. El creer que se podía."
    
    ~ marcos_relacion += 1
    -> marcos_critica_cont

* ["Suena a que extrañás algo."]
    Se queda callado.
    
    "Extraño... no sé. Extraño creer en algo. Extraño tener compañeros. Extraño que las reuniones importaran."
    
    Pausa larga.
    
    "No extraño la orga. Extraño lo que la orga prometía. Lo que nunca fue."
    
    ~ marcos_relacion += 1
    -> marcos_critica_cont

* [Dejar que siga]
    -> marcos_critica_cont

=== marcos_critica_cont ===

"Zabalza tenía razón. Sigue teniendo razón. Todo lo que dice sobre cómo se pudrió todo."

* ["¿Por qué no hacés algo entonces?"]
    "¿Qué querés que haga? ¿Que salga a denunciar? Ya lo hicieron otros. Y mirá cómo les fue."
    
    "No hablo de denunciar. Hablo de hacer algo. Cualquier cosa."
    
    Silencio.
    
    "No sé si puedo."
    
    "Capaz que podés."
    
    No responde.
    Pero no dice que no.
    
    ~ marcos_estado = "respondiendo"
    ->->

* [Solo escuchar]
    No decís nada.
    A veces las palabras sobran.
    
    Marcos apaga el cigarrillo.
    
    "Perdón. Te descargué todo encima."
    
    "Está bien."
    
    "No. No está bien. Pero gracias por escuchar."
    
    ~ marcos_relacion += 1
    ->->

// ============================================
// DIEGO DESCOLOCA A MARCOS
// ============================================

=== marcos_diego_encuentro ===
// Trigger: Diego y Marcos coinciden

Diego está en la olla.
Marcos apareció (por primera vez en semanas).
Se miran.

"Marcos."
"Diego."

Silencio incómodo.
Dos historias diferentes de desencanto.

* [Observar]
    -> marcos_diego_charla

=== marcos_diego_charla ===

Diego está pelando papas.
Marcos lo mira.

"¿Seguís con lo de la cooperativa?"

"Sigo."

"¿Y? ¿Funciona?"

Diego deja de pelar.
Lo mira directo.

"Define funciona."

* [...]
-

Marcos no esperaba eso.

"No sé. ¿Genera impacto? ¿Cambia algo?"

Diego sigue pelando.

"Hoy comieron quince pibes que no iban a comer. Mañana capaz son veinte. ¿Eso es impacto suficiente para vos?"

Marcos se queda callado.

* [...]
-

"Vos hablás de 'la orga' y de 'la estructura' y del 'sistema'", sigue Diego. "Yo hablo de papas. De ajo. De que mañana hay que conseguir más arroz."

Pausa.

"¿Sabés cuál es la diferencia?"

"¿Cuál?"

"Que las papas se comen. Las teorías no."

* [...]
-

Marcos no responde.
Pero algo se mueve en su cara.
Algo que no veías hace tiempo.

Diego le pasa un cuchillo.

"¿Sabés pelar?"

Marcos lo mira.
Al cuchillo.
A Diego.

* ["Pelá, Marcos."]
    "Pelá, Marcos."
    
    Silencio largo.
    
    Marcos agarra el cuchillo.
    Se sienta.
    Empieza a pelar.
    
    No dice nada.
    Pero está ahí.
    Con las manos en algo concreto.
    
    ~ marcos_estado = "mirando"
    ~ marcos_relacion += 2
    ~ subir_conexion(1)
    ->->

* [Dejar que decida]
    Silencio.
    
    Marcos mira el cuchillo.
    Largo rato.
    
    Lo agarra.
    
    "Hacía años que no pelaba una papa."
    
    "Se acuerda el cuerpo."
    
    ~ marcos_estado = "mirando"
    ~ marcos_relacion += 1
    ->->

=== marcos_diego_pregunta_practica ===
// Diego descoloca a Marcos con pregunta práctica

Marcos está hablando.
De la coyuntura. De la correlación de fuerzas.
Del análisis estructural.

Diego lo interrumpe.

"¿Cuántos kilos de fideos necesitamos para el domingo?"

"¿Qué?"

"Fideos. Para la olla del domingo. ¿Cuántos kilos calculás?"

* [...]
-

Marcos parpadea.
Descolocado.

"No sé. ¿Veinte? ¿Treinta?"

"Veinticinco. Y tenemos diez. ¿De dónde sacamos los otros quince?"

Silencio.

"No... no sé."

"Bueno. Eso es lo que hay que resolver. No la correlación de fuerzas. Los fideos."

* [...]
-

Marcos se queda callado.
Largo rato.

"Puedo... puedo averiguar en el mayorista."

Diego asiente.

"Eso sí sirve."

Primera vez que Marcos ofrece algo concreto.
Algo práctico.
Sin teoría.

~ marcos_estado = "respondiendo"
~ marcos_relacion += 1
~ marcos_ofrecio_ayuda = true

->->

// ============================================
// MARCOS Y ELENA - TEORÍA VS PRAXIS
// ============================================

=== marcos_elena_conflicto ===
// Trigger: Marcos y Elena coinciden

Elena está revolviendo la olla.
Marcos está mirando.

"¿Vas a ayudar o vas a mirar?"

"Estoy pensando."

"Pensando. Qué lujo."

* [...]
-

Elena deja la cuchara.
Se da vuelta.

"Mirá Marcos. Yo te aprecio. De verdad. Pero estoy podrida de que vengas a filosofar mientras nosotros trabajamos."

"No estoy filosofando. Estoy analizando."

"Es lo mismo."

"No es lo mismo. Sin análisis repetimos los errores de siempre."

* [Intervenir]
    "Che, paren."
    
    Los dos te miran.
    
    "Marcos, agarrá eso y revolvé. Elena, dejalo respirar."
    
    Silencio tenso.
    
    Marcos agarra la cuchara.
    Elena bufa pero se corre.
    
    ~ marcos_relacion += 1
    -> marcos_elena_cont

* [Dejar que sigan]
    -> marcos_elena_cont

=== marcos_elena_cont ===

Silencio incómodo.
Marcos revuelve.
Elena ordena.

"¿Sabés qué, Marcos?"

"¿Qué?"

"En el 2002 no teníamos tiempo de analizar. Veíamos un pibe con hambre y le dábamos de comer. Después pensábamos."

* [...]
-

Marcos sigue revolviendo.
Más lento.

"Yo no estuve en el 2002. Estaba en reuniones."

"Lo sé."

Pausa larga.

"Por eso no me banco los discursos. Porque yo estuve acá. Con las manos en la olla. Y vos estabas analizando."

* [...]
-

Marcos deja la cuchara.

"Tenés razón."

Elena lo mira. Sorprendida.

"En algo tenés razón. Yo hablaba. Ustedes hacían. Y capaz por eso ustedes siguen acá y yo estoy... donde estoy."

* [...]
-

Elena se ablanda. Un poco.

"No digo que el análisis no sirva. Digo que sirve más si viene con las manos sucias."

"Lo sé."

"¿Entonces?"

Marcos mira sus manos.
Limpias.
Demasiado limpias.

"Enséñame a pelar papas, Elena."

Es un chiste. Y no lo es.

Elena le pasa un cuchillo.

"Esto es una papa. Esto es un cuchillo. ¿Necesitás un marco teórico o podemos empezar?"

~ marcos_estado = "mirando"
~ marcos_relacion += 1
~ subir_conexion(1)

->->

=== marcos_elena_respeto ===
// Momento de respeto mutuo

Elena está cansada.
Fue un día largo.

Marcos le trae un mate.

"Tomá."

Lo mira. Sorprendida.

"Gracias."

* [...]
-

Se sientan. En silencio.

"Elena."

"¿Qué?"

"Lo que hacés acá... importa. Más que todo lo que yo hice en diez años de militancia."

Ella no dice nada.
Pero asiente.

"Vos también podrías hacer algo, Marcos. Si quisieras."

"Lo sé."

"¿Y?"

"Estoy pensando."

"Menos pensar, más hacer."

"Lo sé."

Pero esta vez lo dice diferente.
Como si lo estuviera considerando de verdad.

~ marcos_estado = "mirando"
~ marcos_relacion += 1

->->

// ============================================
// FRAGMENTOS NOCTURNOS DE MARCOS
// ============================================

=== fragmento_marcos_noticias ===
// Marcos en su cueva leyendo noticias

La cueva.
Así le dice a su departamento.
Chico. Oscuro. Desordenado.

Marcos está en el sillón.
Notebook en las piernas.
Scrolleando noticias.

Inflación sube. Salarios bajan.
Otro ajuste. Otro recorte.
Otra marcha que no va a cambiar nada.

Comenta en Twitter. @MarxistaAmargado.
Doscientos seguidores que piensan igual que él.
Una cámara de eco perfecta.

Cierra la notebook.
La abre de nuevo.
Más noticias. Más indignación.
Menos acción.

El mate está frío.
No lo calienta.

A las 3 AM se acuesta.
Mañana es igual.

->->

=== fragmento_marcos_fotos_hijos ===
// Marcos mirando fotos de los hijos

El celular.
Galería de fotos.

Lucía y Martín.
Chiquitos. Cumpleaños. Navidades.
La época en que todo tenía sentido.

Desliza.

Lucía grande. Graduación.
Martín adolescente. Incómodo.
La época en que empezó a perderlos.

Desliza más.

La última foto juntos.
2019. Antes de que se fueran.
Sonríen. Él también.

¿Cuándo dejó de sonreír?

* [...]
-

Abre WhatsApp.
Conversación con Lucía.
Último mensaje: hace tres semanas.
"Todo bien por acá. Vos?"
"Bien."

Quiere escribir algo.
"Te extraño."
"Perdón por no saber ser padre."
"Perdón por dejarte un país del que te tuviste que ir."

No escribe nada.

Cierra el celular.

Mañana. Capaz que mañana.

->->

=== fragmento_marcos_mensaje_no_envia ===
// Marcos escribiendo mensaje que no envía

Son las 2 AM.
Marcos tiene el celular en la mano.

Conversación con Martín.
Escribe:

"Hijo, sé que no hablamos mucho. Sé que no fui el mejor padre. Estaba siempre en reuniones, siempre en la militancia, siempre en otra cosa que no eras vos. Quiero que sepas que..."

Se detiene.
¿Que sepas qué?
¿Que te quiero? Suena vacío.
¿Que lo lamento? Suena a excusa.

Borra todo.

Escribe:

"¿Cómo estás?"

Muy poco.

Borra.

"Estaba pensando en vos."

Muy raro.

Borra.

"Martín, llamame cuando puedas."

Demasiado demandante.

Borra.

El cursor parpadea.
Vacío.

Cierra el celular.

Mañana. Capaz que mañana escribe.
(No va a escribir mañana.)

->->

=== fragmento_marcos_insomnio ===
Marcos no duerme.

El techo. Las paredes. El silencio.
El ventilador que hace ruido.
El vecino que ronca.

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

Prende la tele. Sin sonido.
Imágenes que pasan.
Publicidades de cosas que no puede comprar.
Noticias de cosas que no puede cambiar.

A las 4 AM se rinde.
Se levanta.
Hace café.
Espera el amanecer.

->->

=== fragmento_marcos_balcon ===
Marcos sale al balcón.

Fuma.
La ciudad abajo.
Las luces de las casas.
Alguien más está despierto. Siempre hay alguien.

{marcos_vino_a_asamblea:
    Fue a la asamblea. No sabe por qué.
    Capaz que por vos. Capaz que por curiosidad.

    No fue tan malo.
    Pero no lo va a admitir.
}

{marcos_estado == "mirando":
    Piensa en la olla. En Elena. En Diego.
    En las papas que peló.
    
    Ridículo. Pelar papas.
    Como si eso cambiara algo.
    
    Pero se sintió bien.
    Las manos haciendo algo.
    Sin teoría. Sin análisis.
    Solo papas.
}

Tira el pucho.
Mañana es otro día.
Igual que todos.

¿O no?

->->

=== fragmento_marcos_musica ===
Marcos pone música.
Rock nacional. De los '80.

Charly cantando sobre demoler.
Los Redondos sobre la bestia.
Spinetta sobre el alma.

Sube el volumen.
La vecina golpea la pared.
Baja el volumen.

Cuando era joven, esta música significaba algo.
Revolución. Cambio. Futuro.

Ahora es nostalgia.
Música para viejos que recuerdan cuando creían.

Música. Cigarros. Insomnio.
Las tres constantes de su vida.

Apaga la música.
El silencio es peor.
La prende de nuevo.

Spinetta canta sobre jardines.
Sobre algo que se perdió.

Marcos cierra los ojos.

->->

=== fragmento_marcos_libros ===
// Marcos mirando sus libros

La biblioteca.
Polvo.

El Capital de Marx.
Subrayado con lapicera azul.
Notas al margen que ya no entiende.

El Estado y la Revolución de Lenin.
Subrayado con verde.
"Esto es fundamental" escribió hace veinte años.
Ya no sabe qué era fundamental.

El 18 Brumario.
"La historia se repite: primero como tragedia, luego como farsa."

Ahora todo es farsa.

Agarra uno de los libros.
Lo abre al azar.
Lee un párrafo.
Las palabras suenan vacías.
O él se vació.

Cierra el libro.
Lo usa para nivelar la mesa.

Afuera está amaneciendo.
Otro día igual.

->->

// ============================================
// FASE 4: INTENTAR CONTACTAR
// ============================================

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

~ marcos_estado = "respondiendo"

->->

=== marcos_rechaza ===

"No. Ahora no puedo. Después te llamo."

No va a llamar.

"Dale."

Cortás.

->->

// ============================================
// FASE 5: ENCUENTROS CARA A CARA
// ============================================

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
~ marcos_estado = "respondiendo"

->->

=== marcos_porque ===

"¿Por qué te alejaste? Del barrio, de la olla, de todo."

Silencio largo.

"Porque me quemé los ojos de ver cómo nos usaban. Diez años en la mesa chica de la militancia. Asambleas de trasnoche, marchas con la garganta rota, colectas para compañeros que después te vendían por un puesto en el ministerio."

Mira el piso.

"Cansado de ver cómo la estructura se morphaba el espíritu. Peleamos contra el sistema de afuera y nos terminó ganando el sistema de adentro. Al final, los de mi clase siguen igual, y los que hablaban en su nombre tienen auto nuevo. Me cansé de pelear para nada."

~ marcos_era_militante = true
~ marcos_relacion += 1
~ marcos_estado = "respondiendo"

->->

=== marcos_solo_ver ===

"Nada. Solo quería verte."

Asiente.

"Gracias."

No dice más.
Pero se queda.

A veces estar alcanza.

~ marcos_relacion += 1
~ marcos_estado = "respondiendo"

->->

// ============================================
// CONVERSACIONES PROFUNDAS
// ============================================

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
    ~ marcos_estado = "mirando"
    ~ subir_conexion(2)
}
{ resultado_marcos_reconectar == 1:
    Silencio.

    "Hace mucho que nadie me dice eso."

    ~ marcos_relacion += 1
    ~ marcos_estado = "mirando"
    ~ subir_conexion(1)
}
{ resultado_marcos_reconectar == 0:
    Marcos se queda callado.
    Asiente apenas.

    No te rechaza. Pero tampoco se abre.
    La pared sigue ahí. Un poco más baja, quizás.

    ~ marcos_relacion += 1
    ~ marcos_estado = "respondiendo"
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
~ marcos_estado = "mirando"
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
~ marcos_estado = "respondiendo"

->->

// ============================================
// SOBRE LOS HIJOS
// ============================================

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

"Les dejamos un país del que se tienen que ir. Toda mi vida militando para construir algo mejor, y mis hijos se tienen que ir a Europa a lavar platos o programar boludeces."

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

// ============================================
// REFERENCIAS HISTÓRICAS
// ============================================

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

// ============================================
// REVELACIÓN DEL DESPIDO
// ============================================

=== viernes_marcos_plaza ===
// Escena clave: Encuentro en la plaza el viernes
// Marcos revela que también lo echaron

Lo ves sentado en un banco de la plaza.
Tiene la misma cara que vos el miércoles.

* [Acercarte]
    Te sentás al lado. Silencio largo.

    "A mí también me echaron" — dice sin mirarte.
    "Hace una semana. No se lo conté a nadie."

    ~ marcos_revelo_despido = true
    ~ marcos_relacion += 2
    ~ subir_conexion(1)

    * * [Contarle que a vos también]
        "Somos dos entonces."
        Por primera vez, te mira.
        ~ marcos_acepto_ayuda = true
        ~ marcos_estado = "mirando"
        ~ reducir_inercia_accion(1)
        ->->
    * * [Solo escuchar]
        Asentís. A veces no hay nada que decir.
        ~ marcos_relacion += 1
        ~ marcos_estado = "mirando"
        ->->

* [Dejarlo tranquilo]
    Parece que necesita estar solo.
    ->->

=== marcos_revelar_despido ===

~ marcos_secreto = true
~ marcos_revelo_despido = true

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

"Vergüenza. Orgullo. No sé.
Después de todo lo que hablaba sobre dignidad del trabajador...
y me echaron como a cualquiera."
# PAUSA

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

// ============================================
// FASE 6: INVITAR A LA ASAMBLEA
// ============================================

=== marcos_invitar_asamblea ===
// Requires: marcos_estado == "mirando"

"Hay una asamblea hoy. En la olla. ¿Querés venir?"

Marcos lo piensa.
Largo.

"No sé. Hace mucho que no..."

* ["Solo vení a mirar. Sin compromiso."] -> marcos_acepta_mirar
* ["Podrías ayudar con algo concreto."] -> marcos_acepta_ayudar
* ["Entiendo. Otra vez será."] -> marcos_rechaza_asamblea

=== marcos_acepta_mirar ===

"Solo a mirar. No tenés que hacer nada."

Pausa.

"Dale. Pero me voy cuando quiera."

"Obvio."

~ marcos_vino_a_asamblea = true
~ marcos_estado = "mirando"

->->

=== marcos_acepta_ayudar ===

"Podrías ayudar con los números. Cuánta gente viene, cuánto sale la comida. Eso que sabés hacer."

Lo piensa.

"¿Hacer una planilla?"

"Algo así. Diego está medio perdido con eso."

"Diego no sabe ni sumar."

Primera vez que hace un chiste.
Pequeño. Pero chiste.

"¿Entonces?"

"Dale. Llevo la notebook."

~ marcos_vino_a_asamblea = true
~ marcos_va_a_ayudar = true
~ marcos_estado = "mirando"

->->

=== marcos_rechaza_asamblea ===

"No. Todavía no estoy listo."

"Está bien. Cuando quieras."

"Gracias."

->->

// ============================================
// FASE 7: EN LA ASAMBLEA (PROGRESIÓN)
// ============================================

=== marcos_asamblea_lejos ===
// Primera vez: mira de lejos

Marcos está afuera.
Del otro lado de la calle.
Mirando.

No entra.
Pero vino.

Cuando lo ves, hace un gesto.
Algo entre saludo y disculpa.

Después de un rato, se va.
Pero estuvo.

~ marcos_estado = "mirando"

->->

=== marcos_asamblea_puerta ===
// Segunda vez: en la puerta

Marcos está en la puerta.
Adentro pero afuera.
Un pie en cada mundo.

Sofía lo ve. Le hace seña.
Él niega con la cabeza.

"Solo vine a ver."

Mira un rato.
La gente hablando.
Elena revolviendo.
Diego con las papas.

Se va antes de que termine.
Pero se quedó más que la vez anterior.

~ marcos_estado = "mirando"

->->

=== marcos_en_asamblea ===
// Tercera vez: adentro

{marcos_vino_a_asamblea:
    Marcos está en el fondo.
    Mirando.
    No habla.
    Pero está.

    Sofía lo ve. Lo saluda de lejos.
    Elena asiente.
    Todos saben que es un paso.
    
    {marcos_va_a_ayudar:
        Tiene la notebook abierta.
        Anota cosas.
        Hace cuentas.
        
        Diego se acerca.
        "¿Cuánto salió todo?"
        "Tres mil doscientos. Dividido quince porciones, son doscientos trece por cabeza."
        "Eso está mal."
        "¿Por qué?"
        "Porque la mitad no puede pagar nada."
        
        Marcos se queda callado.
        Cierra la notebook.
        
        "Tenés razón. ¿Cómo hacen entonces?"
        "Los que pueden ponen más. Los que no, ponen lo que pueden."
        "Eso no es sustentable."
        "Capaz que no. Pero nadie se queda sin comer."
        
        Marcos asiente.
        Algo se mueve en su cabeza.
        Teoría vs realidad.
        Números vs personas.
        
        ~ marcos_estado = "reconectando"
    }
}

->->

=== marcos_se_fue ===
// Túnel: Marcos se fue de la asamblea

{marcos_vino_a_asamblea:
    Marcos se fue antes de que terminara.
    Pero estuvo.
    
    {marcos_estado == "mirando":
        Más que la vez anterior.
        Eso es algo.
    }
    
    {marcos_estado == "reconectando":
        Antes de irse, se acercó a Elena.
        "¿Necesitan algo para el domingo?"
        
        Elena lo miró. Sorprendida.
        "Arroz. Siempre falta arroz."
        
        "Veo qué puedo conseguir."
        
        No prometió nada.
        Pero preguntó.
    }
}

->->

// ============================================
// FASE 8: RECONEXIÓN
// ============================================

=== marcos_trae_arroz ===
// Marcos aparece con arroz

Domingo.
Marcos aparece.

Trae dos bolsas de arroz.
Cinco kilos cada una.

"Conseguí en el mayorista. Me hicieron precio."

Elena lo mira.
No dice nada.
Pero asiente.

"Ponelo ahí."

Marcos pone las bolsas.
Se queda.

"¿Qué hago?"

"Lavate las manos y vení a ayudar."

Marcos se lava las manos.
Por primera vez en meses, hace algo.

~ marcos_estado = "reconectando"
~ marcos_relacion += 1
~ subir_conexion(1)

->->

=== marcos_domingo_olla ===
// Marcos en la olla - reconectando

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

=== marcos_ayuda_cocina ===
// Marcos ayudando en la cocina

Marcos está pelando papas.
Lento. Torpe.
Hace mucho que no hace esto.

Elena pasa.

"Más finas las cáscaras. Desperdiciás papa."

"Estoy aprendiendo."

"Aprendé más rápido."

Pero hay algo en su voz.
No es bronca.
Es... algo parecido al afecto.

Marcos sonríe.
Pequeño. Pero sonríe.

"Sí, jefa."

"No me digas jefa."

"Sí, compañera."

Elena para.
Lo mira.

"Hacía mucho que no escuchaba esa palabra sin ironía."

"Capaz que la ironía se me está gastando."

"Mejor."

Siguen trabajando.
En silencio.
Pero juntos.

~ marcos_estado = "reconectando"
~ marcos_relacion += 1
~ subir_conexion(1)

->->

// ============================================
// TELÉFONO
// ============================================

=== marcos_llamar ===
// Túnel: Llamar a Marcos

Llamás a Marcos.

{marcos_estado == "ausente":
    Suena. Suena. Suena.
    Buzón de voz.
    No dejás mensaje.
}

{marcos_estado == "evitando":
    Suena dos veces.
    Corta.
    
    Un minuto después, mensaje:
    "Ahora no puedo. Después hablamos."
}

{marcos_estado == "respondiendo":
    Contesta.
    "Hola."
    
    "Hola. Quería ver cómo estabas."
    
    Silencio.
    
    "Estoy. Es lo que hay."
}

{marcos_estado == "mirando" || marcos_estado == "reconectando":
    Contesta al primer tono.
    
    "Hola. ¿Todo bien?"
    
    Su voz suena diferente.
    Menos apagada.
}

->->

=== marcos_conversacion_telefono ===
// Túnel: Conversación telefónica con Marcos

{marcos_vino_a_asamblea:
    "Ayer fuiste a la asamblea."
    "Sí. No sé por qué. Pero fui."
    "Estuvo bien que fueras."
    "No sé. Quizás."
}

{marcos_estado == "reconectando":
    "¿Vas el domingo?"
    Pausa.
    "Capaz. Veo cómo ando."
    "Dale. Cualquier cosa me avisás."
    "Dale."
}

Hablan un rato.
Marcos sigue distante.
Pero un poco menos.

~ subir_conexion(1)

->->

=== marcos_hablar_precariedad ===
// Túnel: Hablar de la precariedad

Hablan un rato.
De la precariedad.
De cómo todo se cae.
De cómo seguir.

Marcos no tiene respuestas.
Pero al menos no estás solo.

->->

=== marcos_funcionar ===
// Túnel: Marcos sobre funcionar

"¿Cómo la llevás?"

"No la llevo. Funciono. Es distinto."

Funcionar.
Hacer lo mínimo.
Sobrevivir sin vivir.

Conocés la sensación.

->->

// ============================================
// IDEAS INVOLUNTARIAS
// ============================================

=== marcos_idea_esto_es_lo_que_hay ===
// Túnel: Idea involuntaria al ver a Marcos

// Idea involuntaria: "ESTO ES LO QUE HAY"

No la elegiste.
Llegó sola.
Mirando a Marcos.
Viendo el futuro posible.

~ activar_esto_es_lo_que_hay()

->->

// ============================================
// FRAGMENTO NOCTURNO PRINCIPAL
// ============================================

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

{marcos_estado == "reconectando":
    Por primera vez en meses,
    se duerme con algo parecido a la esperanza.
}
{marcos_estado == "mirando":
    Se duerme con algo diferente.
    No esperanza. Pero tampoco el vacío de siempre.
    Algo intermedio.
}
{marcos_estado != "reconectando" && marcos_estado != "mirando":
    Se duerme con el vacío de siempre.
    El vacío que ya es familiar.
}

->->

// ============================================
// FIN DEL ARCHIVO
// ============================================
