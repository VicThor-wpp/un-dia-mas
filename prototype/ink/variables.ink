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

// --- OTROS NPCs ---

VAR ixchel_estado = "trabajando"     // trabajando, ayudando
VAR ixchel_relacion = 0
VAR ixchel_me_conto_de_tomas = false
VAR ixchel_hablo_de_mina = false
VAR ixchel_conto_llegada = false
VAR ixchel_hablo_de_huipil = false
VAR ixchel_conto_historia = false

// --- ESTADO DETALLADO NPCs (Fase 2) ---

// Diego
VAR diego_conto_cecosesola = false
VAR diego_conto_camion = false    // TODO(fase2): pendiente de lectura en narrativa

// Elena
VAR elena_hablo_de_chola = false
VAR elena_conto_desalojo = false
VAR elena_conto_trueque = false
VAR elena_conto_banco = false
VAR elena_hablo_politica = false

// Marcos
VAR marcos_hablo_de_hijos = false    // TODO(fase2): pendiente de lectura en narrativa
VAR marcos_hablo_de_zabalza = false  // TODO(fase2): pendiente de lectura en narrativa
VAR marcos_conto_2009 = false        // TODO(fase2): pendiente de lectura en narrativa
VAR marcos_conto_voto = false        // TODO(fase2): pendiente de lectura en narrativa

// Juan
VAR juan_recuerdo_padre = false     // TODO(fase2): pendiente de lectura en narrativa
VAR juan_hablo_de_laura = false     // TODO(fase2): pendiente de lectura en narrativa
VAR juan_proceso_algo = false       // TODO(fase2): pendiente de lectura en narrativa
VAR juan_hablo_de_miedo = false     // TODO(fase2): pendiente de lectura en narrativa

// Sofia
VAR sofia_hablo_de_madre = false     // TODO(fase2): pendiente de lectura en narrativa
VAR sofia_hablo_de_alemania = false  // TODO(fase2): pendiente de lectura en narrativa
VAR sofia_hablo_de_martin = false    // TODO(fase2): pendiente de lectura en narrativa
VAR hable_con_ixchel_profundo = false // TODO(fase2): pendiente de lectura en narrativa
VAR vino_marcos = false

// Olla
VAR escuche_historia_olla = false

// --- ELECCIONES DEL JUGADOR ---

VAR perdida = ""      // familiar, relacion, futuro, vacio
VAR atadura = ""      // responsabilidad, barrio, inercia, algo
VAR posicion = ""     // ajeno, quemado, esperanzado, ambiguo
VAR vinculo = ""      // sofia, elena, diego

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

