// ============================================
// VARIABLES GLOBALES - UN DÍA MÁS
// Todas las variables del juego consolidadas
// ============================================

// --- IDEAS INTERNALIZADAS ---

// Ideas elegidas
VAR idea_tengo_tiempo = false       // "Ahora tengo tiempo para esto"
VAR idea_pedir_no_debilidad = false // "Pedir ayuda no es debilidad"
VAR idea_hay_cosas_juntos = false   // "Hay cosas que se hacen juntos"
VAR idea_red_o_nada = false         // "La red o la nada" (de Elena)

// Ideas involuntarias (aparecen por estrés o eventos)
VAR idea_quien_soy = false          // "¿Quién soy sin laburo?"
VAR idea_esto_es_lo_que_hay = false // "Esto es lo que hay"

// Ideas políticas (se desbloquean por experiencias, no por acumulación)
VAR idea_no_es_individual = false   // "No es solo mi problema" - la precariedad es estructural
VAR idea_antagonismo_clase = false  // "Hay intereses opuestos" - patrones vs trabajadores
VAR idea_autonomia_posible = false  // "Podemos organizarnos sin jefes"
VAR idea_sabotaje_legitimo = false  // "A veces hay que romper para construir"

// Nuevas Ideas (Fase 2)
VAR idea_organizacion_real = false     // Lucía: "El resultado importa más que el discurso"
VAR idea_orden_autoritario = false     // Bruno: "Alguien tiene que poner orden"
VAR idea_salvacion_individual = false  // Cacho: "Si sos vivo te salvás"
VAR idea_numero_frio = false           // Claudia: "Somos números en un Excel"

// --- ESTADO DE LA OLLA ---

VAR olla_en_crisis = false
VAR ayude_en_olla = false
VAR veces_que_ayude = 0
VAR participe_asamblea = false
VAR olla_cerro_viernes = false
VAR vos_propusiste_cerrar = false

// --- ESTADO DEL BARRIO ---

VAR hable_con_el_del_banco = false
VAR nombre_del_banco = ""
VAR conozco_al_kiosquero = false
VAR veces_en_plaza = 0

// --- ESTADO DE SOFIA ---

VAR sofia_estado = "activa"           // activa, agotada, quebrando, ausente
VAR sofia_relacion = 2                // 0-5
VAR sofia_me_pidio_ayuda = false
VAR sofia_sabe_mi_situacion = false
VAR hable_con_sofia_profundo = false
VAR sofia_hijos_enfermos = false

// --- ESTADO DE ELENA ---

VAR elena_relacion = 2                // 0-5
VAR elena_conto_historia = false
VAR elena_me_aconsejo = false
VAR escuche_sobre_2002 = false
VAR elena_preocupada_olla = false
VAR visite_elena_en_casa = false

// --- ESTADO DE DIEGO ---

VAR diego_estado = "luchando"         // luchando, agotado, desesperado, esperanzado
VAR diego_relacion = 1                // 0-5
VAR diego_me_conto_historia = false
VAR ayude_a_diego = false
VAR diego_perdio_laburo = false
VAR diego_familia_en_venezuela = false
VAR hable_con_diego_profundo = false
VAR diego_viene_a_olla = false
VAR diego_mostro_contradiccion = false

// --- ESTADO DE MARCOS ---

VAR marcos_estado = "aislado"         // aislado, mirando, reconectando, ausente
VAR marcos_relacion = 1               // 0-5
VAR marcos_secreto = false            // Si sabemos que también lo echaron
VAR marcos_vino_a_asamblea = false
VAR hable_con_marcos_profundo = false
VAR marcos_era_militante = false
VAR intente_contactar_marcos = false

// --- ESTADO DE JUAN ---
// Compañero de trabajo - el que comparte tu situación de unipersonal

VAR juan_estado = "compañero"        // compañero, distante, despedido, perdido
VAR juan_relacion = 3                // 0-5
VAR almorzamos_juntos = false
VAR hable_con_juan_sobre_rumores = false
VAR fue_al_bar_con_juan = false
VAR juan_sabe_de_mi_despido = false
VAR juan_tambien_despedido = false   // Hook viernes: si lo echaron
VAR juan_ofrecio_changa = false      // Hook viernes: si ofreció contacto
VAR juan_ofrecio_contacto = false
VAR juan_fue_a_olla = false
VAR juan_sabe_mi_situacion = false
VAR juan_mostro_contradiccion = false

// --- ESTADO DE LUCÍA (Fase 2 Completo) ---
// Compañera de trabajo - la que politiza

VAR lucia_relacion = 0               // 0-5
VAR lucia_estado = "activa"
VAR hable_con_lucia_sobre_paro = false
VAR lucia_sigue_luchando = false
VAR lucia_consejo_sindical = false

// --- OTROS NPCs ---

VAR ixchel_estado = "trabajando"     // trabajando, ayudando
VAR ixchel_relacion = 0
VAR ixchel_me_conto_de_tomas = false
VAR ixchel_hablo_de_mina = false
VAR ixchel_conto_llegada = false
VAR ixchel_hablo_de_huipil = false
VAR ixchel_conto_historia = false
VAR ixchel_hablo_de_ayni = false

// --- NUEVOS PERSONAJES (Fase 2) ---

// Tiago (El Pibe)
VAR tiago_confianza = 0
VAR tiago_estado = "calle"
VAR tiago_captado_por_bruno = false

// Cacho (El Heredero)
VAR cacho_deuda = 0
VAR cacho_estado = "delirante"
VAR cacho_estafado = false

// Apóstol Bruno (El Fascista)
VAR bruno_tension = 0
VAR bruno_estado = "acechando"

// Claudia (La Burócrata)
VAR claudia_hostilidad = 0
VAR claudia_estado = "auditando"
VAR lista_entregada = false

// --- ESTADO DETALLADO NPCs (Fase 2) ---

// Diego
VAR diego_conto_cecosesola = false
VAR diego_conto_camion = false

// Elena
VAR elena_hablo_de_chola = false
VAR elena_conto_desalojo = false
VAR elena_conto_trueque = false
VAR elena_conto_banco = false
VAR elena_hablo_politica = false

// Marcos
VAR marcos_hablo_de_hijos = false
VAR marcos_hablo_de_zabalza = false
VAR marcos_conto_2009 = false
VAR marcos_conto_voto = false

// Juan
VAR juan_recuerdo_padre = false
VAR juan_hablo_de_laura = false
VAR juan_proceso_algo = false
VAR juan_hablo_de_miedo = false

// Sofia
VAR sofia_hablo_de_madre = false
VAR sofia_hablo_de_alemania = false
VAR sofia_hablo_de_martin = false
VAR hable_con_ixchel_profundo = false
VAR vino_marcos = false

// Olla
VAR escuche_historia_olla = false

// --- ELECCIONES DEL JUGADOR ---

VAR perdida = ""      // familiar, relacion, futuro, vacio
VAR atadura = ""      // responsabilidad, barrio, inercia, algo
VAR posicion = ""     // ajeno, quemado, esperanzado, ambiguo
VAR vinculo = ""      // sofia, elena, diego

// --- POSICIÓN SOCIAL (afecta experiencias concretas) ---

VAR genero = ""       // varon, mujer, no_binario
VAR raza = ""         // blanco, mestizo, afro, indigena
VAR es_vegano = false // convicción ética

// --- TRACKING DE EVENTOS ---

VAR fui_despedido = false
VAR conte_a_alguien = false
VAR fui_a_olla_jueves = false
VAR pequenas_victorias = 0
VAR dias_sin_ducha = 0

// --- TRACKING DE IDEAS ---
VAR ideas_activas = 0
VAR sinergia_colectiva = 0    // combo: hay_cosas_juntos + pedir_no_debilidad + red_o_nada
VAR sinergia_individual = 0    // combo: tengo_tiempo + quien_soy
VAR idea_momento_sintesis = false  // whether the synthesis scene has been shown

// --- VARIABLES ADICIONALES FASE 2 ---
VAR tiago_se_queda = false
VAR cacho_momento_real = false