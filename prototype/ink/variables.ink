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
VAR idea_red_sostiene = false       // "La red sostiene" (de conocer la coordinación entre ollas)

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
VAR conoce_red_ollas = false
VAR vio_momento_magico = false
VAR conocio_a_ramon = false

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
// Simplificado: sin marcos_estado abstracto

VAR marcos_relacion = 1               // 0-5
VAR marcos_revelo_despido = false     // Nos contó que también lo echaron (viernes plaza)
VAR marcos_vino_a_asamblea = false
VAR hable_con_marcos_profundo = false
VAR marcos_era_militante = false
VAR intente_contactar_marcos = false
VAR marcos_acepto_ayuda = false       // Dejó que lo acompañemos

// Legacy - mantener para compatibilidad
VAR marcos_estado = "aislado"
VAR marcos_secreto = false

// === JUAN - Variables activas ===
// Compañero de trabajo - el que comparte tu situación de unipersonal
VAR juan_relacion = 2
VAR juan_sabe_de_mi_despido = false
VAR juan_sabe_mi_situacion = false
VAR juan_recuerdo_padre = false
VAR juan_hablo_de_laura = false
VAR juan_hablo_de_miedo = false
VAR juan_mostro_contradiccion = false
VAR juan_proceso_algo = false
VAR juan_estado = "normal"
VAR almorzamos_juntos = false
VAR fue_al_bar_con_juan = false
VAR hable_con_juan_sobre_rumores = false
// Juan - Arco "El que se va"
VAR juan_decidio_irse = false        // Decidió irse a España
VAR juan_se_despidio = false         // Se despidió del protagonista
VAR juan_mando_apoyo = false         // Mandó mensaje de apoyo el sábado (+1 llama)

// === JUAN - Variables legacy (mantener para compatibilidad) ===
VAR juan_migra = false               // Alias de juan_decidio_irse
VAR juan_tambien_despedido = false   // No usado pero mantener
VAR juan_ofrecio_changa = false      // No usado pero mantener
VAR juan_ofrecio_contacto = false    // No usado pero mantener
VAR juan_fue_a_olla = false          // No usado pero mantener

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

// --- OTROS ---

VAR es_vegano = false // TODO: mover elección a gameplay (ej: primera comida en olla)

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

// Nuevas sinergias con efectos mecánicos
VAR tiene_sinergia_colectiva_activa = false  // Ventaja en chequeos comunitarios
VAR tiene_sinergia_agencia = false           // Inercia game-over sube de 10 a 12

// Nueva idea de Ixchel
VAR idea_ayni = false  // "La reciprocidad es supervivencia" - ayudar recupera energía

// Tracking de inercia máxima (para final_despertar)
VAR inercia_maxima_alcanzada = 0

// --- BÚSQUEDA DE EMPLEO ---
VAR rechazos = 0                     // Rechazos totales recibidos
VAR rechazos_enviados = 0            // CVs enviados (al vacío)
VAR rechazos_ghosting = 0            // Veces que te ghostearon
VAR hizo_entrevista_startup = false
VAR hizo_entrevista_grande = false
VAR hizo_entrevista_grande_completa = false
VAR actualizo_linkedin = false
VAR publico_en_linkedin = false

// Ideas de búsqueda de empleo
VAR idea_no_soy_suficiente = false   // Idea involuntaria: "No soy suficiente" (peligrosa)
VAR idea_el_problema_no_soy_yo = false // Idea positiva: "El problema no soy yo"

// --- VARIABLES ADICIONALES FASE 2 ---
VAR tiago_se_queda = false
VAR cacho_momento_real = false

// Variables de tracking de personajes (agregadas por revisión de coherencia)
VAR cacho_encuentros = 0             // Cantidad de veces que cruzaste a Cacho
VAR sabe_de_bruno = false            // El protagonista conoce a Bruno
VAR tension_olla = false             // Hay tensión en la olla por la auditoría
VAR lucia_historia_conocida = false  // Lucía contó por qué dejó la carrera
VAR tiago_historia_inau = false      // Tiago contó algo del INAU
VAR bruno_contacto_tiago = false     // Bruno contactó a Tiago antes
VAR tiago_tentado_bruno = false      // Tiago está considerando la oferta de Bruno
VAR tiago_rechazo_bruno = false      // Tiago rechazó a Bruno
VAR elena_conto_bruno = false        // Elena contó la historia de Bruno
VAR cacho_quiebre_completo = false   // Cacho tuvo el quiebre profundo
VAR cacho_ayudo = false              // Cacho ayudó de verdad a la olla

// ============================================
// VARIABLES AGREGADAS - GAPS NARRATIVOS CERRADOS (2026-02-02)
// ============================================

// --- MARCOS: PROGRESIÓN GRADUAL ---
// Sistema de estados: ausente -> evitando -> respondiendo -> mirando -> reconectando
VAR marcos_mensajes_enviados = 0      // Contador de mensajes sin respuesta
VAR marcos_encuentros_evitados = 0    // Veces que Marcos evitó hablar
VAR marcos_acepto_cafe = false        // Si aceptó tomar café
VAR marcos_va_a_ayudar = false        // Si ofreció ayuda concreta
VAR marcos_ofrecio_ayuda = false      // Si ofreció conseguir algo (fideos/arroz)

// --- IXCHEL: EXPANSIÓN COMPLETA ---
VAR ixchel_enseno_receta = false      // Enseñó a hacer pepián
VAR ixchel_enseno_tortillas = false   // Enseñó a hacer tortillas
VAR ixchel_conto_tomas_infancia = false  // Historia de Tomás - infancia
VAR ixchel_conto_tomas_lider = false     // Historia de Tomás - líder
VAR ixchel_conto_tomas_ultimo = false    // Historia de Tomás - último día
VAR ixchel_hablo_guadalupe_profundo = false  // Conversación sobre la Virgen
VAR ixchel_hablo_buen_vivir = false   // Explicó el Ut'z Kaslemal
VAR vio_ixchel_hablando_kiche = false // Encontró a Ixchel hablando k'iche'
VAR aprendio_palabra_kiche = false    // Aprendió "saqarik" (amanecer)
VAR ixchel_fragmento_rio = false      // Vio fragmento del río
VAR ixchel_hablo_con_elena = false    // Interacción con Elena
VAR ixchel_hablo_elena_profundo = false  // Conversación profunda con Elena
VAR ixchel_hablo_con_diego = false    // Interacción con Diego
VAR ixchel_diego_hablaron_profundo = false  // Conversación profunda con Diego
VAR ixchel_aguanto_xenofobia_juan = false   // Juan dijo algo xenófobo
VAR juan_se_disculpo_ixchel = false   // Juan se disculpó
VAR ixchel_participo_asamblea = false // Intervino en asamblea
VAR ixchel_cierre_domingo = false     // Escena de cierre dominical

// --- JUAN: ARCO DE MIGRACIÓN ---
VAR juan_menciono_espana = false      // Lunes: mencionó prima en España
VAR juan_seed_migracion = false       // La idea de irse plantada
VAR juan_considerando_irse = false    // Martes: considerando seriamente
VAR juan_pregunto_si_me_iria = false  // Miércoles: "¿vos te irías?"
VAR juan_avanzo_migracion = false     // Jueves: Laura consiguió algo
VAR juan_encuentro_despedida = false  // Viernes: pidió encontrarse sábado
VAR juan_despedida_emotiva = false    // Si hubo abrazo en despedida
VAR juan_mando_mensaje_espana = false // Mensaje desde España

// --- LABURO POST-DESPIDO ---
VAR vio_a_gonzalez = false            // Vio a González en la olla

// --- IDEAS NUEVAS (IXCHEL) ---
VAR idea_comida_es_memoria = false    // "LA COMIDA ES MEMORIA" - del pepián
VAR idea_hay_otra_forma = false       // "HAY OTRA FORMA" - del Ut'z Kaslemal