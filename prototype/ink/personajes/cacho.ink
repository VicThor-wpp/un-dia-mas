// CACHO - El Heredero Iluso
// ============================================

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
