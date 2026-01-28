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
