// CACHO - El Lumpen Iluso
// ============================================
// Expandido: más alivio cómico, quiebre de fachada, redención

// === ENCUENTROS TEMPRANOS (ALIVIO CÓMICO) ===

=== cacho_primer_cruce ===
// Escena Martes/Miércoles: Lo cruzás en la calle

"¡Vecino! ¡Justo vos!"

Cacho viene hacia vos.
Camisa que fue buena. Zapatos que fueron lustrados.
Todo en pasado.

"¿Cómo andás? Yo, espectacular.
Cerrando unos negocios."

Son las diez de la mañana.
Viene de la olla.

* [Seguirle el juego.]
    "Me alegro, Cacho. Ojalá salgan."
    
    "Van a salir. El mindset, vecino. Es todo mindset."
    
    Te palmea el hombro.
    Se va silbando.
    
    ~ cacho_encuentros += 1
    ->->

* [Ser directo.]
    "Cacho, venís de la olla."
    
    No pierde la sonrisa.
    
    "Sí, pero es temporal. Networking, le dicen.
    Hay que estar donde está la gente."
    
    ~ cacho_encuentros += 1
    ->->

=== cacho_explicacion_cripto ===
// Escena Miércoles: Cacho te explica cripto

Cacho te ve sentado en el banco.
Se sienta al lado. Sin preguntar.

"¿Vos sabés lo que es el bitcoin?"

* ["Más o menos."]
    "Más o menos no alcanza.
    Hay que entender. El futuro es digital."
    
    -> cacho_cripto_explicacion
    
* ["No."]
    "¡Por eso estás donde estás!"
    
    Se ríe. No es ofensivo. Es triste.
    
    -> cacho_cripto_explicacion

* [Levantarte e irte.]
    "Perdón, Cacho. Tengo que hacer algo."
    
    "¡Dale! Después te cuento. ¡Es una oportunidad!"
    
    ~ cacho_encuentros += 1
    ->->

=== cacho_cripto_explicacion ===

"El bitcoin es plata, pero digital.
Y sube. Siempre sube."

"¿Y vos tenés bitcoin?"

"Tuve. Vendí en el momento equivocado.
Pero voy a volver a comprar. Cuando tenga liquidez."

La liquidez de Cacho es un plato de guiso.
Pero no le decís nada.

* ["Suena bien."]
    "¿Viste? El tema es la visión.
    Vos tenés que pensar como inversor."
    
    ~ cacho_encuentros += 1
    ~ unlock_idea(idea_salvacion_individual)
    ->->

* ["Cacho, eso no..."]
    "No, no. Escuchame. Yo sé lo que digo.
    Estudié. YouTube. Cursos gratis."
    
    Asiente con la cabeza. Convencido.
    
    No vale la pena discutir.
    
    ~ cacho_encuentros += 1
    ->->

=== cacho_en_la_fila ===
// Escena Viernes: En la fila de la olla

Cacho está en la fila.
Lleva una camisa que alguna vez fue buena, ahora tiene el cuello gastado.

"Yo vengo a buscar para mi tía", dice en voz alta, para que todos escuchen.
"Yo estoy bien. Estoy cerrando un negocio de cripto."

Nadie le cree. Nadie le dice nada.

* [Seguirle el juego.]
    "Claro, Cacho. Ojalá salga."
    
    Se afloja un poco.
    "Va a salir. Y cuando salga, les compro carne para todos."
    
    ~ cacho_deuda += 1
    ->->

* [Ignorarlo.]
    Mirás para adelante.
    La dignidad de Cacho es un castillo de naipes.
    Mejor no soplar.
    ->->

=== cacho_oferta_negocio ===
// Escena Jueves: Te cruza en la calle

"¡Vecino! ¡Justo a vos te quería ver!"

Cacho está en la vereda de su casa ruinosa.
Tiene una caja de cartón en las manos.

"Me enteré que estás libre. Mejor. El empleo es para los giles."

Abre la caja. Hay perfumes. O algo que parece perfume.

"Tengo un lote. Réplicas AAA. Se venden solas.
Vos ponés la cara, yo pongo el stock. Vamos a medias."

* [Rechazar con firmeza.]
    "No, Cacho. Paso."
    
    "Vos te lo perdés. La oportunidad es calva, papu."
    
    ~ subir_dignidad(1)
    ->->

* [Dudar... ¿y si funciona?]
    Mirás los frascos.
    Huelen a alcohol barato.
    
    "¿Seguro que se venden?"
    
    "Como pan caliente. Es cuestión de actitud."
    
    Te ves a vos mismo vendiendo esto en el bondi.
    
    ~ aumentar_inercia(1)
    ~ unlock_idea(idea_salvacion_individual)
    ->->

=== cacho_casa ===
// Escena Jueves: La casa de Cacho

Cacho te invita a pasar.

"Tengo algo que mostrarte."

La casa huele a humedad.
Revoque caído. Cables sueltos.
Pero Cacho camina como si fuera un palacio.

"Esto va a ser un emprendimiento, vecino.
Coworking. O Airbnb. Depende del mercado."

Señala una habitación llena de cajas.
"Stock. Inversión a futuro."

Abrís una caja.
Decodificadores viejos.

"Esos se arreglan y se venden como nuevos.
Es cuestión de actitud."

* [Seguirle el juego.]
    "Tenés razón, Cacho. Es cuestión de actitud."

    Sonríe.
    Por un segundo, parece feliz.

    "¡Eso! Vos entendés."

    ~ cacho_deuda += 1
    ->->

* [Ser honesto.]
    "Cacho, esto no es un negocio.
    Es una casa que se cae."

    Se queda callado.

    Después:
    "Ya lo sé.
    Pero si no me lo creo...
    ¿qué me queda?"

    Por un momento, ves al hombre detrás del personaje.

    ~ cacho_momento_real = true
    ->->

// === MÁS ESCENAS CÓMICAS ===

=== cacho_networking ===
// Escena Viernes: Cacho hace "networking" en la olla

Cacho está hablando con una señora.
Le muestra algo en el celular.

"Este es un esquema piramidal, pero de los buenos.
Vos metés a tres, esos tres meten a tres..."

La señora asiente por educación.
Agarra su plato.
Se va.

Cacho no se da cuenta.
Sigue explicando a nadie.

* [Acercarte.]
    "Cacho, dejá a la gente comer tranquila."
    
    "No, no. Estoy educando. Es distinto."
    
    "Es lo mismo."
    
    Te mira. Por un segundo, algo se quiebra.
    Después vuelve la sonrisa.
    
    "Vos no entendés el hustle."
    
    ~ cacho_encuentros += 1
    ->->

* [Dejarlo.]
    Hay cosas que no se arreglan.
    Cacho es una de ellas.
    
    ~ cacho_encuentros += 1
    ->->

=== cacho_linkedin ===
// Escena Jueves: Cacho y LinkedIn

Cacho te muestra el celular.
La pantalla está rota.

"¿Viste mi LinkedIn?"

"No tengo LinkedIn."

"¿¡Cómo no tenés LinkedIn!?
Es la red de los profesionales."

* [Mirar por educación.]
    Su perfil dice "CEO en Emprendimientos Varios".
    Tiene 12 conexiones.
    Todas son vendedores de seguros.
    
    "Impresionante, Cacho."
    
    "¿Viste? Networking."
    
    ~ cacho_encuentros += 1
    ->->

* [Pasar.]
    "No me interesa, Cacho."
    
    "Error. Grave error.
    El futuro es digital."
    
    Se va moviendo la cabeza.
    
    ~ cacho_encuentros += 1
    ->->

=== cacho_uber ===
// Escena: Cacho cuenta lo del Uber

"Yo manejaba Uber. ¿Sabías?"

"No."

"Sí. Fue mi mejor época. Independencia total.
Vos ponés los horarios. Vos sos el jefe."

"¿Y qué pasó?"

* [...]
-

"Choqué el auto."

Silencio.

"Pero no fue mi culpa. El otro se me cruzó."

Pausa.

"Bueno, capaz que iba un poco rápido.
Pero estaba laburando. El tiempo es dinero."

* ["¿Y el seguro?"]
    "No tenía. Es un gasto innecesario.
    Mentalidad de empleado, tener seguro."
    
    La lógica de Cacho es impenetrable.
    Como un agujero negro de autoengaño.
    
    ~ cacho_encuentros += 1
    ->->

* [No decir nada.]
    Hay historias que se cuentan solas.
    
    ~ cacho_encuentros += 1
    ->->

=== cacho_planeros ===
// Escena: Cacho critica a los "planeros"

Cacho mira la fila de la olla.

"Mirá eso. Planeros."

Está en la fila.
Esperando su plato.

* [Señalar la ironía.]
    "Cacho, vos estás en la fila."
    
    "Sí, pero yo es distinto.
    Yo tengo proyectos.
    Ellos no hacen nada."
    
    La disonancia cognitiva de Cacho
    podría alimentar una central nuclear.
    
    ->->

* [No decir nada.]
    A veces el silencio es la mejor respuesta.
    Y la más piadosa.
    
    ->->

// === EL QUIEBRE ===

=== cacho_sin_olla ===
// Escena Sábado: Si la olla cerró

{olla_en_crisis:
    Cacho está sentado en la vereda.
    Ya no tiene el discurso de siempre.

    "¿Cómo puede ser?"

    Te mira.

    "Yo les decía que esto no era sustentable.
    Que había que profesionalizar.
    Pero nadie me escuchaba."

    Siempre es culpa de otros.
    Nunca suya.

    * [No decir nada.]
        Te sentás a su lado.

        El silencio es más honesto que cualquier respuesta.

        ->->

    * [Confrontarlo.]
        "Vos tampoco hiciste nada, Cacho.
        Solo hablaste."

        Se queda mudo.

        "Tenés razón.
        Pero hablar es lo único que sé."

        ~ cacho_momento_real = true
        ->->
- else:
    ->->
}

=== cacho_fachada_cae ===
// Escena Viernes noche: La fachada se quiebra
// Requiere: cacho_encuentros >= 3

{cacho_encuentros >= 3:
    
    Lo encontrás en la vereda.
    Solo. Sin el discurso.
    
    "Cacho."
    
    No te mira.
    
    "Vecino."
    
    * [Sentarte a su lado.]
        Te sentás.
        
        Pasa un rato.
        
        "¿Sabés qué día es hoy?", pregunta.
        
        "Viernes."
        
        "Es el cumpleaños de mi vieja."
        
        Pausa.
        
        "Falleció hace tres años.
        Me dejó la casa.
        Era lo único que tenía para dejarme."
        
        -> cacho_quiebre_profundo
    
    * [Dejarlo solo.]
        "Nos vemos, Cacho."
        
        "Sí. Nos vemos."
        
        Su voz suena vacía.
        Sin el show de siempre.
        
        ->->
- else:
    ->->
}

=== cacho_quiebre_profundo ===

"Yo le prometí que iba a hacer algo.
Que iba a ser alguien."

Se ríe. Pero no es risa.

"Y mirá. Cincuenta años.
Una casa que se cae.
Comiendo de la olla."

* [Escuchar.]
    No decís nada.
    A veces eso es lo mejor.
    
    -> cacho_quiebre_final

* ["No es tan grave, Cacho."]
    "Sí es. Dejame que lo diga.
    Una vez. Necesito decirlo una vez."
    
    -> cacho_quiebre_final

=== cacho_quiebre_final ===

"Todos mis negocios fueron mentira.
Los decodificadores. Los perfumes. Las cripto."

# PAUSA

"Me los creía yo para no pensar.
Para no ver que no sirvo para nada."

* [...]
-

Silencio largo.

"Mi vieja laburó toda la vida. Limpiando casas.
Yo no heredé eso. Solo la casa."

Te mira.

"¿Sabés qué es lo peor?
Que sigo necesitando creerme el cuento.
Porque si no me lo creo... no sé qué hacer."

~ cacho_momento_real = true
~ cacho_quiebre_completo = true

->->

// === REDENCIÓN ===

=== cacho_redencion ===
// Escena Domingo: Si conexion >= 7 y cacho_momento_real

{conexion >= 7 && cacho_momento_real:
    Cacho aparece con una bolsa.

    "Conseguí esto."

    Adentro hay verduras. Frescas.

    "Un amigo tenía de más.
    Bueno, se las cambié por unos cables."

    No preguntás de dónde salieron los cables.

    "No es mucho.
    Pero es algo."

    Por primera vez, Cacho ayuda de verdad.
    A su manera.

    ~ subir_conexion(1)
    ->->
- else:
    ->->
}

=== cacho_redencion_extendida ===
// Escena Domingo: Redención más completa
// Requiere: cacho_quiebre_completo y llama >= 5

{cacho_quiebre_completo && llama >= 5:
    
    Cacho aparece en la olla.
    No está en la fila.
    Está del otro lado.
    
    "¿Qué hacés ahí, Cacho?"
    
    "Sofía me puso a cortar verdura."
    
    Tiene un cuchillo. Corta papas.
    Mal, pero corta.
    
    "¿Y el negocio de las cripto?"
    
    Te mira. Sonríe. Distinto.
    
    "Capaz que esto es mejor negocio."
    
    * [...]
    -
    
    "No pagan. Pero al menos sé que sirve de algo."
    
    Sigue cortando.
    
    Elena lo mira desde la otra punta.
    Asiente.
    
    Hay redenciones silenciosas.
    A veces son las únicas que duran.
    
    ~ subir_conexion(1)
    ~ subir_llama(1)
    ->->
- else:
    ->->
}

=== cacho_contactos ===
// Escena Sábado: Cacho usa sus "contactos" para la olla
// Requiere: cacho_momento_real y olla_en_crisis

{cacho_momento_real && olla_en_crisis:
    
    Cacho te busca.
    
    "Vecino. Tengo algo."
    
    "¿Otro negocio?"
    
    "No. Escuchame."
    
    * [Escuchar.]
        -> cacho_contactos_reales
    
    * [Pasar.]
        "Ahora no, Cacho."
        
        "Está bien. Pero después no digas que no ayudé."
        
        Se va.
        
        ->->
- else:
    ->->
}

=== cacho_contactos_reales ===

"Un tipo que conozco del Uber.
Tiene una verdulería en el Cerro.
Siempre le sobra mercadería."

"¿Y?"

"Le pregunté si podía donar.
Dijo que sí. Pero hay que ir a buscar."

* [...]
-

"Yo no tengo auto. Pero capaz que Diego..."

Por primera vez, un contacto de Cacho sirve para algo.

"¿Por qué lo hiciste?"

Se encoge de hombros.

"Ustedes me dan de comer hace meses.
Algo tengo que devolver."

No es la gran cosa.
Pero es real.

~ cacho_ayudo = true
~ subir_conexion(1)

->->

// === FRAGMENTOS NOCTURNOS ===

=== fragmento_cacho_casa ===
// Cacho solo en su casa

Cacho cuenta las monedas en el frasco.
No alcanzan para nada.

Mira la foto de su madre.
Ella sí trabajó toda la vida.
Él no heredó eso.
Solo la casa.

"Mañana va a ser distinto."

Se lo dice todas las noches.
Todas las noches es mentira.

Pero la mentira lo deja dormir.
Es suficiente.

->->

=== fragmento_cacho_youtube ===
// Cacho mirando YouTube

Cacho mira videos en el celular.
La pantalla brilla en la oscuridad.

"10 SECRETOS de los MILLONARIOS"
"Cómo GANAR DINERO sin TRABAJAR"
"Mentalidad de TIBURÓN"

Los mira todos.
Toma notas.
En un cuaderno viejo.

A las dos de la mañana, se duerme.
El teléfono sigue reproduciendo.

"Tú puedes ser RICO si CREES en ti mismo..."

Cacho duerme.
Sueña con éxito.
Es el único lugar donde lo tiene.

->->

=== fragmento_cacho_espejo ===
// Cacho frente al espejo

Cacho se mira al espejo.
Se acomoda la camisa.
La misma de siempre.

"Hoy es el día", se dice.

Se lo dice hace veinte años.

Alguna vez fue joven.
Alguna vez tuvo esperanza real.
Ahora tiene rutinas de supervivencia.

Sale de la casa.
Cierra con llave.
Como si hubiera algo que robar.

->->

// === RESULTADO DOMINGO ===

=== cacho_domingo ===
// Escena Domingo: Cacho reflexiona

{cacho_momento_real:
    Cacho te cruza en la calle.

    "Vecino."

    No tiene el discurso de siempre.
    Se lo ve más... real.

    "Ayer pensé mucho.
    Capaz que tenés razón.
    Capaz que hay que dejar de mentirse."

    Pausa.

    "Pero cuesta, ¿sabés?"

    * [Acompañarlo.]
        "Sí. Cuesta."

        Se quedan un rato en silencio.
        A veces eso alcanza.

        ~ subir_conexion(1)
        ->->

    * [Dejarlo solo.]
        "Suerte, Cacho."

        Te vas.
        Algunos procesos son solitarios.

        ->->
- else:
    // Cacho sigue en su mundo
    Cacho te cruza en la calle.

    "¡Vecino! Tengo una oportunidad de oro.
    Cripto. NFTs. El futuro."

    Seguís de largo.
    Algunos nunca cambian.

    ->->
}

=== cacho_domingo_redencion ===
// Escena Domingo: Si Cacho ayudó de verdad

{cacho_ayudo:
    
    Ves a Cacho en la olla.
    Está hablando con Sofía.
    
    No le está vendiendo nada.
    Le está preguntando qué necesitan.
    
    "El de la verdulería puede traer más la semana que viene.
    Si le pagamos el flete, capaz que dona también fruta."
    
    Sofía asiente.
    
    "Bien pensado, Cacho."
    
    Es la primera vez que alguien le dice eso en serio.
    
    Cacho sonríe.
    No la sonrisa de vendedor.
    Otra. Más chica. Más real.
    
    ~ subir_llama(1)
    ->->
- else:
    ->->
}

// === VARIABLES DE CACHO ===
// cacho_encuentros: cantidad de veces que lo cruzaste
// cacho_deuda: veces que le seguiste el juego
// cacho_momento_real: Cacho mostró vulnerabilidad
// cacho_quiebre_completo: Cacho tuvo el quiebre profundo
// cacho_ayudo: Cacho ayudó de verdad a la olla
