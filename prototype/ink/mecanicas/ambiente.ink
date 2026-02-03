// ============================================
// SISTEMA DE AMBIENTE - EL URUGUAY GRIS
// Clima, Radio y Sensaciones Físicas
// ============================================

=== ambiente_amanecer ===
// Llamar al inicio de cada día para setear el ambiente

// Resetear variables diarias
~ escucho_radio = false
~ noticia_del_dia = ""

// Probabilidad de evento climático (aumenta si no hubo ayer)
{ RANDOM(1, 100) <= 40:
    -> generar_clima ->
- else:
    ~ clima_actual = "gris"
    ~ humedad_nivel = RANDOM(4, 7)
}

// Probabilidad de radio (aumenta si tenés luz)
{ RANDOM(1, 100) <= 50:
    -> generar_radio ->
}

->->

=== generar_clima ===

{ RANDOM(1, 6):
    - 1: // HUMEDAD EXTREMA
        ~ clima_actual = "humedad"
        ~ humedad_nivel = 9
        # AMBIENTE:humedad
        El aire pesa. Las baldosas están mojadas aunque no llovió.
        La ropa en la silla está húmeda.
        Montevideo es una pecera sucia hoy.
        (La humedad te va a costar más energía moverte).
        
    - 2: // VIENTO SUR
        ~ clima_actual = "viento_sur"
        ~ humedad_nivel = 4
        # AMBIENTE:viento
        Viento del sur. Ese que corta la cara.
        Las ventanas chiflan.
        Dan ganas de no salir nunca más.
        
    - 3: // LLUVIA CERRADA
        ~ clima_actual = "lluvia"
        ~ humedad_nivel = 8
        # AMBIENTE:lluvia
        Llueve. Lluvia mansa pero constante.
        Gris sobre gris.
        El ruido de las gotas contra la chapa es lo único que se escucha.
        
    - 4: // SOL FLACO
        ~ clima_actual = "sol_frio"
        ~ humedad_nivel = 5
        # AMBIENTE:sol
        Salió el sol. Un sol de invierno, blanco, que no calienta nada.
        Pero al menos hay luz.
        
    - 5: // NIEBLA
        ~ clima_actual = "niebla"
        ~ humedad_nivel = 9
        No se ve la vereda de enfrente.
        La niebla se comió al barrio.
        Los bondis pasan como fantasmas con luces amarillas.
        
    - 6: // ALERTA
        ~ clima_actual = "alerta"
        ~ humedad_nivel = 6
        El cielo está negro a las 8 de la mañana.
        Se viene una fea.
        "Alerta Naranja", dirían en la tele.
}

->->

=== generar_radio ===

// Genera una noticia de fondo
~ escucho_radio = true

{ RANDOM(1, 5):
    - 1: 
        ~ noticia_del_dia = "Paro de transporte sorpresa"
        La radio avisa: paro sorpresivo de transporte a partir del mediodía.
        "Medidas gremiales por el despido de dos trabajadores."
        
    - 2:
        ~ noticia_del_dia = "Suba de tarifas"
        "...el aumento del 8% en la tarifa de luz se hará efectivo el próximo mes..."
        Otra más.
        
    - 3:
        ~ noticia_del_dia = "Fútbol"
        "...polémica por el penal no cobrado a Nacional. La hinchada reclama..."
        El país se cae a pedazos pero el penal sigue siendo tema.
        
    - 4:
        ~ noticia_del_dia = "Policiales"
        "...operativo en la zona oeste termina con tres detenidos..."
        La voz del locutor es monótona. Como si leyera la lista del súper.
        
    - 5:
        ~ noticia_del_dia = "Pronóstico"
        "...se esperan vientos fuertes para la tarde noche. Recomendamos no sacar la basura..."
}

->->

=== ambiente_efecto_energia ===
// Aplicar penalizadores climáticos al gastar energía
// Llamar en acciones físicas

{ clima_actual == "humedad" or clima_actual == "viento_sur":
    // 30% de chance de costo extra
    { RANDOM(1, 3) == 1:
        ~ energia -= 1
        (El clima te cobra peaje. Estás más cansado de lo normal).
    }
}

->->

=== ambiente_descripcion_calle ===
// Descripción sensorial al salir a la calle

{ clima_actual:
    - "humedad":
        Caminás y sentís el aire pegajoso.
        La gente camina lento, como nadando.
        El pelo se pega a la frente.
    
    - "viento_sur":
        Caminás encorvado, mentón al pecho.
        El viento te empuja para atrás.
        Nadie te mira. Todos miran al piso para protegerse los ojos.
        
    - "lluvia":
        Esquivando baldosas flojas. El deporte nacional.
        Pisás una y te escupe agua sucia en el pantalón.
        "La puta madre", pensás. Pero seguís.
        
    - "sol_frio":
        La gente sale a la vereda a "lagartear" un poco.
        Caras pálidas buscando vitamina D.
        
    - "niebla":
        El mundo termina a los veinte metros.
        Escuchás cosas que no ves.
        Un perro. Un motor. Un grito.
        
    - "alerta":
        Viento arremolinado. Papeles volando.
        La gente camina rápido.
        Todos quieren llegar a algún lado antes de que se rompa el cielo.
        
    - "gris":
        El cielo es una panza de burro.
        Ni sol ni lluvia. Nada.
        La espera eterna.
}

->->

=== objeto_domestico_roto ===
// Evento aleatorio: cosas que se rompen en casa

{ RANDOM(1, 100) <= 20:
    -> romper_algo ->
}

->->

=== romper_algo ===

{ RANDOM(1, 3):
    - 1: // CALEFÓN
        Vas a lavar los platos. El agua sale helada.
        El calefón.
        La luz piloto está apagada.
        Intentás prenderlo. Nada.
        (Baño de agua fría o calentar ollas. La gloria).
        
    - 2: // GARRAFA
        El mate se queda a medias.
        Se terminó el gas.
        La garrafa de 13kg.
        Y no tenés repuesto.
        
    - 3: // GOTA
        Plic. Plic. Plic.
        Una gotera nueva en el techo.
        Justo arriba de la mesa.
        Ponés un balde. Ahora tu casa tiene banda sonora.
}

->->
