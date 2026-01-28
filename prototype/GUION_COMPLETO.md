# UN DÍA MÁS - GUIÓN TÉCNICO COMPLETO
Generated: 1/28/2026, 1:44:39 AM
Contains all logic, variables, and system files.


# FILE: main.ink

// ============================================
// UN DÍA MÁS - Prototipo Modular
// ============================================

// --- INCLUDES: MECÁNICAS ---

## FILE: mecanicas/dados.ink

// ============================================
// SISTEMA DE DADOS
// ============================================

// Variable temporal para guardar resultado de última tirada
VAR ultima_tirada = 0
VAR ultimo_resultado = 0

// Tirar un dado de 6
=== function d6() ===
    ~ return RANDOM(1, 6)

// Tirar 2d6
=== function dos_d6() ===
    ~ return RANDOM(1, 6) + RANDOM(1, 6)

// Tirar dados y sumar (para pools de hasta 3 dados)
=== function tirar_dados(cantidad) ===
    ~ temp total = 0
    { cantidad >= 1:
        ~ total += RANDOM(1, 6)
    }
    { cantidad >= 2:
        ~ total += RANDOM(1, 6)
    }
    { cantidad >= 3:
        ~ total += RANDOM(1, 6)
    }
    ~ return total

// Chequeo simple: tirar d6, sumar modificador, comparar con dificultad
// Devuelve: 2 = éxito crítico (6), 1 = éxito, 0 = fallo, -1 = fallo crítico (1)
=== function chequeo(modificador, dificultad) ===
    ~ temp tirada = d6()
    ~ ultima_tirada = tirada
    { tirada == 6:
        ~ ultimo_resultado = 2
        ~ return 2
    }
    { tirada == 1:
        ~ ultimo_resultado = -1
        ~ return -1
    }
    { tirada + modificador >= dificultad:
        ~ ultimo_resultado = 1
        ~ return 1
    }
    ~ ultimo_resultado = 0
    ~ return 0

// Chequeo con ventaja (tira 2, usa el mejor)
=== function chequeo_ventaja(modificador, dificultad) ===
    ~ temp t1 = d6()
    ~ temp t2 = d6()
    ~ temp tirada = t1
    { t2 > t1:
        ~ tirada = t2
    }
    ~ ultima_tirada = tirada
    { tirada == 6:
        ~ return 2
    }
    { tirada == 1 && t1 == 1:  // Solo crítico si ambos son 1
        ~ return -1
    }
    { tirada + modificador >= dificultad:
        ~ return 1
    }
    ~ return 0

// Chequeo con desventaja (tira 2, usa el peor)
=== function chequeo_desventaja(modificador, dificultad) ===
    ~ temp t1 = d6()
    ~ temp t2 = d6()
    ~ temp tirada = t1
    { t2 < t1:
        ~ tirada = t2
    }
    ~ ultima_tirada = tirada
    { tirada == 6 && t1 == 6:  // Solo crítico si ambos son 6
        ~ return 2
    }
    { tirada == 1 && t1 <= 3 && t2 <= 3:  // Pifia si ambos dados son bajos (reduce de 30.6% a ~14%)
        ~ return -1
    }
    { tirada + modificador >= dificultad:
        ~ return 1
    }
    ~ return 0

// Probabilidad: devuelve true con X% de chance
=== function chance(porcentaje) ===
    ~ temp tirada = RANDOM(1, 100)
    ~ return tirada <= porcentaje

// Elegir entre opciones con pesos
// Uso: ~ temp resultado = elegir_peso(40, 40, 20) // 40% opción 1, 40% opción 2, 20% opción 3
=== function elegir_peso(peso1, peso2, peso3) ===
    ~ temp tirada = RANDOM(1, 100)
    { tirada <= peso1:
        ~ return 1
    }
    { tirada <= peso1 + peso2:
        ~ return 2
    }
    ~ return 3

// ============================================
// CONTEXTUAL DICE FUNCTIONS
// ============================================

// Chequeo contextual: elige ventaja/desventaja segun estado del personaje
// Uso: chequeo_contexto(modificador, dificultad, "social")
// Contextos: "social", "fisico", "mental", "comunitario"
=== function chequeo_social(modificador, dificultad) ===
    // Social checks: advantage if connected, disadvantage if isolated
    { conexion >= 6:
        ~ return chequeo_ventaja(modificador, dificultad)
    }
    { conexion <= 2:
        ~ return chequeo_desventaja(modificador, dificultad)
    }
    ~ return chequeo(modificador, dificultad)

=== function chequeo_fisico(modificador, dificultad) ===
    // Physical checks: advantage if rested, disadvantage if exhausted
    { energia >= 4:
        ~ return chequeo_ventaja(modificador, dificultad)
    }
    { energia <= 1:
        ~ return chequeo_desventaja(modificador, dificultad)
    }
    ~ return chequeo(modificador, dificultad)

=== function chequeo_mental(modificador, dificultad) ===
    // Mental checks: advantage if healthy, disadvantage if breaking down
    { salud_mental >= 4:
        ~ return chequeo_ventaja(modificador, dificultad)
    }
    { salud_mental <= 1:
        ~ return chequeo_desventaja(modificador, dificultad)
    }
    ~ return chequeo(modificador, dificultad)

=== function chequeo_comunitario(modificador, dificultad) ===
    // Community checks: advantage if flame is alive, disadvantage if dying
    { llama >= 6:
        ~ return chequeo_ventaja(modificador, dificultad)
    }
    { llama <= 2:
        ~ return chequeo_desventaja(modificador, dificultad)
    }
    ~ return chequeo(modificador, dificultad)

// --- CONSECUENCIAS DE CRITICOS ---

// Aplicar consecuencia de éxito crítico según contexto
=== function critico_exito_social() ===
    ~ subir_conexion(1)
    ~ pequenas_victorias += 1

=== function critico_exito_fisico() ===
    ~ recuperar_energia(1)
    ~ pequenas_victorias += 1

=== function critico_exito_mental() ===
    ~ subir_salud_mental(1)
    ~ pequenas_victorias += 1

=== function critico_exito_comunitario() ===
    ~ subir_llama(1)
    ~ pequenas_victorias += 1

// Aplicar consecuencia de fallo crítico según contexto
=== function critico_fallo_social() ===
    ~ bajar_conexion(1)

=== function critico_fallo_fisico() ===
    ~ energia -= 1
    { energia < 0:
        ~ energia = 0
    }

=== function critico_fallo_mental() ===
    ~ bajar_salud_mental(1)

=== function critico_fallo_comunitario() ===
    ~ bajar_llama(1)

// --- HELPER: Chequeo completo con consecuencias ---
// Hace un chequeo contextual Y aplica consecuencias de criticos automaticamente
// Devuelve el resultado del chequeo (2, 1, 0, -1)

=== function chequeo_completo_social(modificador, dificultad) ===
    ~ temp resultado = chequeo_social(modificador, dificultad)
    { resultado == 2:
        ~ critico_exito_social()
    }
    { resultado == -1:
        ~ critico_fallo_social()
    }
    ~ return resultado

=== function chequeo_completo_fisico(modificador, dificultad) ===
    ~ temp resultado = chequeo_fisico(modificador, dificultad)
    { resultado == 2:
        ~ critico_exito_fisico()
    }
    { resultado == -1:
        ~ critico_fallo_fisico()
    }
    ~ return resultado

=== function chequeo_completo_mental(modificador, dificultad) ===
    ~ temp resultado = chequeo_mental(modificador, dificultad)
    { resultado == 2:
        ~ critico_exito_mental()
    }
    { resultado == -1:
        ~ critico_fallo_mental()
    }
    ~ return resultado

=== function chequeo_completo_comunitario(modificador, dificultad) ===
    ~ temp resultado = chequeo_comunitario(modificador, dificultad)
    { resultado == 2:
        ~ critico_exito_comunitario()
    }
    { resultado == -1:
        ~ critico_fallo_comunitario()
    }
    ~ return resultado


## FILE: mecanicas/recursos.ink

// ============================================
// SISTEMA DE RECURSOS
// ============================================

// --- RECURSOS PRINCIPALES ---

// ENERGÍA: Capacidad de hacer cosas hoy (3-5)
VAR energia = 4
VAR energia_max = 5

// CONEXIÓN: Tu lugar en el tejido del barrio (0-10)
// Inicial: 3 (conocés pero no pertenecés todavía)
VAR conexion = 3

// DIGNIDAD: Lo que el sistema te saca de a poco (0-10)
VAR dignidad = 5

// LA LLAMA: Capacidad colectiva de esperanza (0-10)
// Inicial: 5 (frágil pero presente)
VAR llama = 5

// SALUD MENTAL: Baja con eventos difíciles (0-5)
// Empezamos en 3, ya venimos con desgaste de la vida
VAR salud_mental = 3

// --- SITUACIÓN MATERIAL ---
// NOTA: No hay indemnización - el protagonista era unipersonal forzado

VAR tiene_laburo = true
VAR dia_actual = 1

// --- FUNCIONES DE RECURSOS ---

// Mostrar estado de recursos (para debug o UI)
=== function mostrar_recursos() ===
    ~ return "E:{energia} C:{conexion} D:{dignidad} L:{llama}"

// Gastar energía con validación
=== function gastar_energia(cantidad) ===
    { energia >= cantidad:
        ~ energia -= cantidad
        ~ return true
    }
    ~ return false

// Recuperar energía (para nuevo día)
=== function recuperar_energia(cantidad) ===
    ~ energia += cantidad
    { energia > energia_max:
        ~ energia = energia_max
    }

// Ajustar recurso sin pasarse de límites
=== function ajustar(ref variable, cantidad, minimo, maximo) ===
    ~ variable += cantidad
    { variable < minimo:
        ~ variable = minimo
    }
    { variable > maximo:
        ~ variable = maximo
    }

// --- FUNCIONES ESPECÍFICAS ---

=== function subir_conexion(cantidad) ===
    ~ temp conexion_antes = conexion
    ~ ajustar(conexion, cantidad, 0, 10)
    // Feedback narrativo en thresholds
    {
    - conexion >= 7 && conexion_antes < 7:
        # STAT_THRESHOLD
        Algo cambió.
        Ya no te sentís tan solo.
        El barrio te conoce. Vos conocés al barrio.
    - conexion >= 5 && conexion_antes < 5:
        # STAT_THRESHOLD
        Hay gente.
        No muchos. Pero hay.
    }

=== function bajar_conexion(cantidad) ===
    ~ temp conexion_antes = conexion
    ~ ajustar(conexion, -cantidad, 0, 10)
    // Feedback narrativo en thresholds críticos
    {
    - conexion <= 2 && conexion_antes > 2:
        # STAT_THRESHOLD
        El aislamiento se siente físico.
        Pasás por la calle y nadie te mira.
        O quizás vos no mirás.
    }

=== function subir_dignidad(cantidad) ===
    ~ ajustar(dignidad, cantidad, 0, 10)

=== function bajar_dignidad(cantidad) ===
    ~ ajustar(dignidad, -cantidad, 0, 10)

=== function subir_llama(cantidad) ===
    ~ temp llama_antes = llama
    ~ ajustar(llama, cantidad, 0, 10)
    // Feedback narrativo en thresholds
    {
    - llama >= 7 && llama_antes < 7:
        # STAT_THRESHOLD
        La llama arde.
        No es solo esperanza.
        Es algo más. Algo colectivo.
    - llama >= 5 && llama_antes < 5:
        # STAT_THRESHOLD
        Hay una llama.
        Pequeña. Pero viva.
    }

=== function bajar_llama(cantidad) ===
    ~ temp llama_antes = llama
    ~ ajustar(llama, -cantidad, 0, 10)
    // Feedback narrativo en thresholds críticos
    {
    - llama <= 2 && llama_antes > 2:
        # STAT_THRESHOLD
        La llama se apaga.
        El frío entra.
        Es difícil creer en algo.
    }

=== function bajar_salud_mental(cantidad) ===
    ~ salud_mental = salud_mental - cantidad
    {salud_mental < 0:
        ~ salud_mental = 0
    }

=== function subir_salud_mental(cantidad) ===
    ~ temp salud_antes = salud_mental
    ~ salud_mental = salud_mental + cantidad
    {salud_mental > 5:
        ~ salud_mental = 5
    }
    // Feedback narrativo en thresholds
    {
    - salud_mental >= 3 && salud_antes < 3:
        # STAT_THRESHOLD
        Algo se afloja en el pecho.
        No estás bien. Pero estás un poco mejor.
    }

// --- CHEQUEOS DE ESTADO ---

=== function esta_agotado() ===
    ~ return energia <= 0

=== function esta_cansado() ===
    ~ return energia <= 2

=== function esta_conectado() ===
    ~ return conexion >= 6

=== function esta_aislado() ===
    ~ return conexion <= 3

=== function salud_mental_baja() ===
    ~ return salud_mental <= 2

=== function llama_viva() ===
    ~ return llama >= 5

=== function llama_apagandose() ===
    ~ return llama <= 2

=== function tiene_todas_ideas() ===
    ~ return idea_tengo_tiempo && idea_pedir_no_debilidad && idea_hay_cosas_juntos && idea_red_o_nada

// --- CHEQUEO TEMPRANO DE GAME-OVER ---
// Tunnel: llamar en momentos críticos del día con -> check_game_over ->

=== check_game_over ===
{salud_mental <= 0:
    -> final_apagado
}
{llama <= 0:
    -> final_sin_llama
}
->->

// --- EVALUACION DE FINALES ---

=== function evaluar_pequeno_cambio() ===
    // Hiciste poco pero algo cambió en vos
    { conexion >= 4 && conexion < 7 && pequenas_victorias >= 5:
        ~ return true
    }
    ~ return false

=== function evaluar_vulnerabilidad() ===
    // Mostraste vulnerabilidad genuina
    { conte_a_alguien && salud_mental >= 2 && salud_mental <= 3:
        ~ return true
    }
    ~ return false

=== function evaluar_lucha_colectiva() ===
    // Participaste activamente en la lucha colectiva
    { participe_asamblea && veces_que_ayude >= 3 && llama >= 7 && conexion >= 7:
        ~ return true
    }
    ~ return false


## FILE: mecanicas/ideas.ink

// ============================================
// SISTEMA DE IDEAS
// Tracking de ideas internalizadas y sinergias
// ============================================

// --- FUNCIONES DE ACTIVACION ---

=== function activar_tengo_tiempo() ===
    { not idea_tengo_tiempo:
        ~ idea_tengo_tiempo = true
        ~ ideas_activas += 1
        ~ check_sinergias()
    }

=== function activar_pedir_no_debilidad() ===
    { not idea_pedir_no_debilidad:
        ~ idea_pedir_no_debilidad = true
        ~ ideas_activas += 1
        ~ check_sinergias()
    }

=== function activar_hay_cosas_juntos() ===
    { not idea_hay_cosas_juntos:
        ~ idea_hay_cosas_juntos = true
        ~ ideas_activas += 1
        ~ check_sinergias()
    }

=== function activar_red_o_nada() ===
    { not idea_red_o_nada:
        ~ idea_red_o_nada = true
        ~ ideas_activas += 1
        ~ check_sinergias()
    }

=== function activar_quien_soy() ===
    { not idea_quien_soy:
        ~ idea_quien_soy = true
        ~ ideas_activas += 1
        ~ check_sinergias()
    }

=== function activar_esto_es_lo_que_hay() ===
    { not idea_esto_es_lo_que_hay:
        ~ idea_esto_es_lo_que_hay = true
        ~ ideas_activas += 1
        ~ check_sinergias()
    }

// --- FUNCIONES DE SINERGIA ---

=== function check_sinergias() ===
    // Sinergia colectiva: hay_cosas_juntos + pedir_no_debilidad + red_o_nada
    ~ sinergia_colectiva = 0
    { idea_hay_cosas_juntos:
        ~ sinergia_colectiva += 1
    }
    { idea_pedir_no_debilidad:
        ~ sinergia_colectiva += 1
    }
    { idea_red_o_nada:
        ~ sinergia_colectiva += 1
    }
    // Sinergia individual: tengo_tiempo + quien_soy
    ~ sinergia_individual = 0
    { idea_tengo_tiempo:
        ~ sinergia_individual += 1
    }
    { idea_quien_soy:
        ~ sinergia_individual += 1
    }

// --- FUNCIONES DE CONSULTA ---

=== function count_ideas() ===
    ~ return ideas_activas

=== function tiene_sinergia_colectiva() ===
    ~ return sinergia_colectiva >= 2

=== function tiene_sinergia_individual() ===
    ~ return sinergia_individual >= 2


// --- INCLUDES: VARIABLES ---

## FILE: variables.ink

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



// --- INCLUDES: UBICACIONES ---

## FILE: ubicaciones/casa.ink

// ============================================
// UBICACIÓN: LA CASA
// Escenas en el hogar del protagonista
// ============================================

// --- DESPERTAR ---

=== casa_despertar ===
// Llamar al inicio de cada día

El despertador.
{dia_actual == 1: Las 6:30.}
{dia_actual >= 4 && not tiene_laburo: No hay despertador. Te despertás igual.}

{tiene_laburo:
    El cuerpo no quiere pero se levanta igual.
    Otra semana.
}
{not tiene_laburo:
    No hay razón para madrugar.
    Pero el cuerpo ya tiene el ritmo.
}

* [Levantarte de una] # EFECTO:dignidad+
    -> casa_levantarse_rapido
* [Cinco minutos más] # COSTO:1 # EFECTO:dignidad?
    -> casa_cinco_mas
* {tiene_laburo} [Apagar el despertador y quedarte] # COSTO:1 # EFECTO:dignidad-
    -> casa_quedarse
* {not tiene_laburo} [Quedarte en la cama] # COSTO:1 # EFECTO:conexion-
    -> casa_quedarse_sin_laburo

=== casa_levantarse_rapido ===

Te levantás de una.
La disciplina del cuerpo que ya no pregunta.

{tiene_laburo: Años de lo mismo. El cuerpo sabe.}
{not tiene_laburo: El cuerpo todavía no sabe que ya no hace falta.}

~ pequenas_victorias += 1

-> casa_banarse

=== casa_cinco_mas ===

Cinco minutos más.
El techo.
La luz que entra.

{perdida == "familiar": Por un segundo pensás en tu vieja. O en tu viejo. En las mañanas de antes.}
{perdida == "relacion": La cama está vacía del otro lado. Ya te acostumbraste. Casi.}
{perdida == "futuro": Pensás en todo lo que ibas a ser. Y en esto que sos.}
{perdida == "vacio": Hay algo que falta. Nunca sabés qué.}

Los cinco minutos se estiran.
Son diez.

~ energia -= 1

{tiene_laburo:
    Mierda. Vas a llegar tarde.
    * [Levantarte apurado] -> casa_mate_apurado
}
{not tiene_laburo:
    No importa.
    No hay a dónde llegar.
    * [Levantarte] -> casa_banarse
}

=== casa_quedarse ===

Apagás el despertador.
Te quedás.

El techo.
El silencio.
La pregunta de siempre: ¿para qué?

...

No. Hay que ir.
Hay cuentas que pagar.
Hay un sistema que te necesita funcionando.

~ energia -= 1

Te levantás. Tarde.

* [Apurarte] -> casa_mate_apurado

=== casa_quedarse_sin_laburo ===

Te quedás en la cama.
No hay apuro.

~ energia -= 1

El techo.
El silencio.
Los pensamientos.

{salud_mental <= 4:
    ¿Quién sos ahora?
    ¿Qué hacés?
    ¿Para qué te levantás?
}

Eventualmente, el cuerpo pide moverse.

* [Levantarte] -> casa_banarse

=== casa_banarse ===

{dias_sin_ducha == 1: Ayer no te duchaste.}
{dias_sin_ducha == 2: Hace dos días que no te duchás.}
{dias_sin_ducha >= 3: Hace {dias_sin_ducha} días que no te duchás. Se nota.}

* [Ducharte]
    -> casa_ducha
* [Lavarte la cara nomás]
    -> casa_lavarse

=== casa_ducha ===

Te duchás.
El agua caliente.
Unos minutos de paz.

{tiene_laburo: El cuerpo despierta.}
{not tiene_laburo: No hay apuro. Podés tomarte tu tiempo.}

Te secás.
Te vestís.

~ dias_sin_ducha = 0
~ pequenas_victorias += 1

-> casa_desayuno

=== casa_lavarse ===

Un lavado de cara.
El agua fría te despeja un poco.

{tiene_laburo: No hay tiempo para más.}
{not tiene_laburo: No tenés ganas de nada elaborado.}

~ dias_sin_ducha += 1

-> casa_desayuno

=== casa_desayuno ===

* [Hacer café]
    -> casa_mate
* [Salir de una]
    -> casa_sin_cafe

=== casa_mate ===

# EL CAFÉ

El café de especialidad en la prensa francesa.
El ritual que te despierta y te sostiene.

* [...]
-

Agua caliente. Molienda. Cuatro minutos.
Un vaso térmico para llevarte el resto.
{tiene_laburo: Cinco minutos de paz antes de salir.}
{not tiene_laburo: Todo el tiempo del mundo. Demasiado tiempo.}

{atadura == "responsabilidad":
    Pensás en quién depende de vos.
    {tiene_laburo: Otra razón para ir.}
    {not tiene_laburo: Otra razón para encontrar algo.}
}

{posicion == "quemado":
    Antes el café era para pensar en cosas.
    Ahora es para no pensar.
}

* [...]
-

No es gusto.
Es sostén energético.
Una forma de sobrevivir a la mañana.

// Chequeo mental: cómo arranca el día
~ temp despertar = chequeo_mental(0, 3)
{ despertar == 2:
    El café te despierta de verdad. Sentís que hoy podés con lo que venga.
    ~ pequenas_victorias += 1
}
{ despertar == 1:
    Algo en el café te despierta. Hoy se puede.
}
{ despertar == 0:
    El café no basta. La cabeza sigue nublada.
}
{ despertar == -1:
    Te quemás con el café. El vaso se cae, te salpica la mano.
    El día arranca mal.
    ~ bajar_salud_mental(1)
}

El café se termina.

->->

=== casa_mate_apurado ===

No hay tiempo para café.
Un vaso de agua y listo.

El día empieza mal.
Pero empieza.

->->

=== casa_sin_cafe ===

Sin café.
Un vaso de agua y a la calle.

{tiene_laburo: El café se toma en el bondi. O no se toma.}
{not tiene_laburo: Total, ¿para qué apurarse?}

->->

// --- SALIR DE CASA ---

=== casa_salir ===
// Momento de salir, encuentros en el barrio

# LA SALIDA

El barrio temprano.
Gente yendo a {tiene_laburo: laburar|sus cosas}, pibes a la escuela.
El kiosco de la esquina abriendo.

{vinculo == "sofia":
    Sofía está sacando a los pibes.
    "¡Buen día!"
    Le devolvés el saludo.
}

{vinculo == "elena":
    Elena está en la vereda.
    Barriendo, como siempre.
    Te mira, asiente.
}

{vinculo == "diego":
    Diego viene caminando por la otra vereda.
    {tiene_laburo: También va al bondi.}
    Se cruzan la mirada.
    "¿Qué onda?"
    "Ahí vamos."
}

{vinculo == "marcos":
    Marcos no está.
    Nunca está a esta hora.
}

->->

// --- VOLVER A CASA (NOCHE) ---

=== casa_llegada_noche ===
// Cuando llegás a casa de noche

# NOCHE

Llegás a casa.

{energia <= 1: Estás destruido. No das para nada.}
{energia == 2: Estás cansado. Pero se puede.}
{energia >= 3: Todavía tenés algo de energía.}

* {energia >= 2} [Cocinar algo decente] # COSTO:1 # EFECTO:dignidad+
    -> casa_cocinar
* [Comer cualquier cosa] # EFECTO:dignidad-
    -> casa_comer_rapido
* {energia >= 2} [Llamar a alguien] # COSTO:1 # STAT:conexion # EFECTO:conexion+
    -> casa_llamar_noche
* [Tele y a dormir] # EFECTO:conexion-
    -> casa_tele

=== casa_cocinar ===

~ energia -= 1

Cocinás algo.
Nada elaborado.
Pero comida de verdad.

Mientras cocinás, pensás.
{tiene_laburo: En el laburo. En lo que viene.}
{not tiene_laburo: En lo que no tenés. En lo que tenés que buscar.}

Comés.
No está mal.

~ pequenas_victorias += 1

-> casa_noche_final

=== casa_comer_rapido ===

Cualquier cosa.
Lo que haya.
Pan con algo.
Sobras.

Comés parado, mirando el celular.
Las noticias.
Las redes.
Nada bueno.

-> casa_noche_final

=== casa_llamar_noche ===

~ energia -= 1

Llamás a alguien.

{vinculo == "sofia":
    ~ ultima_tirada = d6()
    {ultima_tirada >= 4:
        Sofía contesta. Hablan un rato.
        De los pibes, de la olla, de la vida.
        ~ subir_conexion(1)
    - else:
        Sofía no contesta. Está acostando a los pibes.
    }
}
{vinculo == "elena":
    Elena contesta. Siempre contesta.
    Hablan un rato. Te hace bien.
    ~ subir_conexion(1)
}
{vinculo == "diego":
    Diego contesta.
    Hablan boludeces. Está bien.
    ~ subir_conexion(1)
}
{vinculo == "marcos":
    Marcos no contesta.
    Como siempre.
}

-> casa_noche_final

=== casa_tele ===

Prendés la tele.
Canales.
Noticias.

* [...]
-

"La situación económica..."
"Despidos en el sector..."
"El gobierno anunció..."

{d6() <= 3:
    Apagás la tele.
    Mejor no.
- else:
    Dejás la tele prendida.
    Ruido de fondo.
    Compañía falsa.
}

-> casa_noche_final

=== casa_noche_final ===

La noche avanza.

Te acostás.

{tiene_laburo:
    Mañana hay que ir.
    Siempre hay que ir.
}
{not tiene_laburo:
    Mañana no hay que ir a ningún lado.
    Eso debería ser un alivio.
    No lo es.
}

Cerrás los ojos.
El sueño tarda en venir.

Pero viene.

->->

// --- FIN DE SEMANA / DÍA LIBRE ---

=== casa_dia_libre ===
// Para días sin laburo o fines de semana

La mañana.
{dia_actual == 6 || dia_actual == 7: Fin de semana.}
{not tiene_laburo && dia_actual < 6: Un día más sin laburo.}

No hay apuro.
Pero tampoco hay nada.

* [Quedarte en casa] # COSTO:1 # STAT:conexion
    -> casa_quedarse_dia
* [Salir]
    ->->  // El día maneja a dónde

=== casa_quedarse_dia ===

~ energia -= 1
~ bajar_conexion(1)

Te quedás.
Tele.
Celular.
Nada.

Las horas pasan.
No hacés nada.
No hablás con nadie.

Es fácil quedarse.
Demasiado fácil.

{salud_mental <= 4:
    Los pensamientos vienen solos.
    ¿Para qué?
    ¿Quién sos?
    ¿Qué estás haciendo?
}

->->


## FILE: ubicaciones/bondi.ink

// ============================================
// UBICACIÓN: EL BONDI
// Escenas de transporte público
// ============================================

// --- VIAJE DE IDA (mañana) ---

=== bondi_esperar_parada ===
// Llamar desde el día: -> bondi_esperar_parada

La parada del bondi.
Hay gente esperando.
Cada uno en su mundo.

* [Esperar tranquilo] # DADOS
    -> bondi_esperar_tranquilo
* [Mirar el celular] # DADOS # EFECTO:dignidad?
    -> bondi_esperar_celular
* {energia >= 3} [Hablar con alguien] # COSTO:1 # DADOS:conexion # EFECTO:conexion+
    -> bondi_esperar_hablar

=== bondi_esperar_tranquilo ===

Esperás.
El bondi tarda.
Siempre tarda.

La gente mira el celular o el vacío.

~ ultima_tirada = d6()

{ultima_tirada == 6:
    El bondi llega rápido. Día de suerte.
    -> bondi_subir
}
{ultima_tirada == 1:
    El bondi tarda una eternidad.
    ~ energia -= 1
    -> bondi_subir_tarde
}

El bondi llega.
Normal.

-> bondi_subir

=== bondi_esperar_celular ===

Mirás el celular.
Noticias.

~ ultima_tirada = d6()

{ultima_tirada <= 2:
    "Empresa X despide a 200 trabajadores."
    "La inflación de este mes..."

    Cerrás las noticias.
    Mejor no saber.
}
{ultima_tirada >= 5:
    Un meme. Un video de un gato.
    Por un segundo, sonreís.
}

El bondi llega.

-> bondi_subir

=== bondi_esperar_hablar ===

~ energia -= 1

Hay una señora que siempre está a esta hora.
Nunca hablaste con ella.

"Buen día."

* [...]
-

"Buen día." Te mira sorprendida. "¿Todo bien?"

"Sí, sí. Esperando el bondi nomás."

"Como todos."

* [...]
-

~ ultima_tirada = d6()

{ultima_tirada >= 4:
    "Yo trabajo acá cerca hace 20 años. Antes el bondi venía cada 10 minutos. Ahora..."
    Se encoge de hombros.
    "Todo empeora de a poco. Uno se acostumbra."
    No es una conversación feliz.
    Pero es una conversación.
    ~ subir_conexion(1)
}

El bondi llega.

-> bondi_subir

=== bondi_correr_para_agarrar ===
// Cuando llegás tarde y el bondi está por irse

El bondi está por irse.
Corrés.

// Chequeo físico: llegar al bondi a tiempo
~ temp carrera = chequeo_fisico(0, 3)
{ carrera == 2:
    Lo agarrás de taquito. El chofer te ve llegar corriendo y espera.
    "Dale, subí." Ni transpirado estás.
    -> bondi_subir
}
{ carrera == 1:
    Lo agarrás justo.
    El chofer te mira con cara de "siempre lo mismo".
    Pero te deja subir.
    -> bondi_subir
}
{ carrera == 0:
    Se va.
    El bondi se va en tu cara.

    Mierda.

    * [Esperar el próximo] # COSTO:1
        -> bondi_esperar_otro
    * [Caminar] # COSTO:1
        -> bondi_caminar_alternativa
}
{ carrera == -1:
    Corrés y te torcés el tobillo en la vereda rota.
    El bondi se va.

    Mierda. Mierda.

    ~ gastar_energia(1)

    * [Esperar el próximo renqueando] # COSTO:1
        -> bondi_esperar_otro
    * [Caminar como puedas] # COSTO:1
        -> bondi_caminar_alternativa
}

=== bondi_esperar_otro ===

Esperás el próximo.
20 minutos.

~ energia -= 1

Llegás tarde.

-> bondi_subir_tarde

=== bondi_caminar_alternativa ===

Decidís caminar.
40 minutos, más o menos.

~ energia -= 1

Es un día {d6() >= 4: lindo|gris} al menos.
Caminás.

Llegás tarde.
Pero llegás.

-> bondi_llegada_destino_tarde

=== bondi_subir ===

# EN EL BONDI

El bondi lleno.
Cuerpos apretados.
Olor a cuerpos, a sudor de madrugada, a cansancio acumulado.

* [...]
-

Conseguís un lugar donde agarrarte.

* [Mirar por la ventana] -> bondi_ventana
* [Cerrar los ojos] -> bondi_ojos_cerrados
* [Escuchar conversaciones] -> bondi_escuchar

=== bondi_subir_tarde ===

# EN EL BONDI (tarde)

Subís al bondi.
Ya es tarde.
El estrés se suma al cansancio.

El bondi va más vacío a esta hora, al menos.
Te sentás.

-> bondi_ventana

=== bondi_ventana ===

La ciudad pasa.
Los edificios.
La gente en las veredas.

* [...]
-

Los carteles de "Se alquila", "Se vende", "Cerrado".

{dia_actual == 1: Cada vez más carteles de esos.}
{dia_actual >= 4 && not tiene_laburo: Los carteles se sienten diferentes ahora. Más cercanos.}

-> bondi_llegada_destino

=== bondi_ojos_cerrados ===

Cerrás los ojos.
El ruido del bondi.
El movimiento.

* [...]
-

Por un segundo, casi te dormís.

...

* [...]
-

{d6() >= 4:
    Tu parada. Justo a tiempo.
- else:
    Alguien te empuja.
    Casi te pasás.
}

-> bondi_llegada_destino

=== bondi_escuchar ===

Dos personas atrás hablan:

~ ultima_tirada = d6()

{ultima_tirada <= 2:
    "...y le dijeron que no renovaban. Así nomás. Diez años en la empresa."
    "Está jodida la cosa."
    "Está jodidísima."
    {tiene_laburo: Las palabras quedan. Podrías ser vos.}
    {not tiene_laburo: Ya sos vos.}
}
{ultima_tirada == 3 || ultima_tirada == 4:
    "...el nene tiene fiebre y no puedo faltar..."
    "Es una mierda."
    "Es lo que hay."
    Problemas de todos.
}
{ultima_tirada >= 5:
    "...y entonces le dije que no, que así no..."
    Se ríen.
    Una conversación normal.
    Eso también existe.
}

-> bondi_llegada_destino

=== bondi_llegada_destino ===

Tu parada.
Bajás.

->->
// El día que llama debe continuar el flujo después de esto

=== bondi_llegada_destino_tarde ===

Tu parada.
Bajás.
Tarde.

->->

// --- VIAJE DE VUELTA (tarde) ---

=== bondi_vuelta ===
// Llamar cuando volvés del laburo

El bondi de vuelta.
Menos lleno que a la mañana.

Te sentás.

* [...]
-

Mirás por la ventana.
La ciudad de tarde.

{tiene_laburo:
    Otro día.
    Mañana lo mismo.
}
{not tiene_laburo:
    La ciudad sigue.
    Vos no sabés bien hacia dónde vas.
}

* [Pensar en el día] -> bondi_vuelta_pensar
* [Desconectar] -> bondi_vuelta_desconectar
* [Mirar a la gente] -> bondi_vuelta_gente

=== bondi_vuelta_pensar ===

Pensás en el día.

{dia_actual == 1 && hable_con_juan_sobre_rumores:
    En lo que dijo Juan.
    En los despidos.
    En la reunión.
}

* [...]
-

{not tiene_laburo:
    En que no tenés laburo.
    En que no hay colchón. Nada.
    Unipersonal. Sin derechos.
}

El bondi llega al barrio.

-> bondi_llegada_barrio

=== bondi_vuelta_desconectar ===

Desconectás.
Música en los auriculares.
O nada.

* [...]
-

Solo el ruido del bondi.

Por un rato, no pensás.

El bondi llega al barrio.

-> bondi_llegada_barrio

=== bondi_vuelta_gente ===

Mirás a la gente.

Un viejo con bolsas.
Una mina con uniforme de trabajo.
Un pibe con la mochila del colegio.

* [...]
-

Todos volviendo a algún lado.
Todos con sus cosas.

El bondi llega al barrio.

-> bondi_llegada_barrio

=== bondi_llegada_barrio ===

Tu parada.
El barrio.

Bajás.

->->


## FILE: ubicaciones/laburo.ink

// ============================================
// UBICACIÓN: EL LABURO
// Escenas en el trabajo
// ============================================

// --- LLEGADA ---

=== laburo_llegada ===

# EL LABURO

Llegás.
8:05.
Justo.

El edificio de siempre.
La puerta de siempre.
El ascensor de siempre.

* [...]
-

"Buen día."
"Buen día."
"Buen día."

Todos dicen buen día.
Nadie pregunta si lo es.

->->

=== laburo_llegada_tarde ===

# EL LABURO

Llegás.
8:25.
Tarde.

El jefe te ve entrar.
No dice nada.
Anota algo.

Mierda.

~ bajar_salud_mental(1)

->->

// --- MAÑANA DE TRABAJO ---

=== laburo_manana ===

# LA MAÑANA

El escritorio.
La computadora.
Los mails.

Lo de siempre.

// Chequeo mental: concentración en el laburo
~ temp concentracion = chequeo_mental(0, 3)
{ concentracion == 2:
    Hoy estás afilado. Todo sale rápido y bien.
    El jefe pasa y asiente. Bien.
    ~ pequenas_victorias += 1
}
{ concentracion == 1:
    Estás enfocado. El trabajo sale. Las horas pasan sin dolor.
}
{ concentracion == 0:
    Te cuesta concentrarte. Releés el mismo mail tres veces.
    El cansancio pesa.
}
{ concentracion == -1:
    Cometés un error estúpido. Un mail al cliente equivocado.
    El jefe se da cuenta. "Prestá atención."
    ~ bajar_salud_mental(1)
}

->->

=== laburo_trabajo_rutina ===

Las horas pasan.

Mails.
Planillas.

* [...]
-

Reuniones que podrían ser mails.
Mails que podrían ser nada.

{d6() <= 3:
    -> laburo_evento_tension
- else:
    {d6() <= 2:
        El jefe pasa por tu escritorio.
        Te mira.
        No dice nada.
        Sigue.

        ¿Qué mierda fue eso?
        ~ bajar_salud_mental(1)
    }
}

->->

=== laburo_evento_tension ===

~ temp evento = d6()

{ evento:
- 1:
    Vas al baño.
    Escuchás a alguien llorando en el cubículo del fondo.
    Tratás de no hacer ruido.
    Te lavás las manos rápido y salís.
    El sonido del llanto te sigue hasta el escritorio.
    ~ bajar_salud_mental(1)

- 2:
    La impresora se traba.
    Vas a destrabarla y ves un papel que quedó a medias.
    "LISTA DE REVISIÓN DE PUESTOS - CONFIDENCIAL"
    Alguien te lo arranca de la mano antes de que leas nombres.
    "Dámelo." Es la secretaria de RRHH.
    ~ bajar_salud_mental(1)

- 3:
    Reunión de equipo.
    Falta una silla.
    "¿Y Gómez?"
    "Gómez... ya no está con nosotros."
    Nadie pregunta más.
    El aire acondicionado está demasiado frío.

- 4:
    Tu computadora se reinicia sola.
    Por un segundo, la pantalla negra te devuelve tu reflejo.
    Cara de miedo.
    "¿Será hoy?", pensás.
    No, hoy no. Reinicia.
    Pero el miedo queda.

- 5:
    Café en la cocina.
    Dos gerentes hablan bajito.
    Cuando entrás, se callan.
    Te sonríen. Una sonrisa de plástico.
    "Todo bien, ¿no?"
    "Sí, sí."
    Salís con el café ardiendo en la mano.

- 6:
    Un mail general.
    "Celebramos los resultados del trimestre."
    Gráficos en subida. Números verdes.
    Abajo, en letra chica: "Continuaremos optimizando recursos."
    Optimizar.
    Vos sos un recurso.
}

->->

// --- ALMUERZO ---

=== laburo_almuerzo ===

# ALMUERZO

12:30.
Hora de comer.

* [Almorzar acompañado] # DADOS # STAT:conexion # EFECTO:conexion+
    -> laburo_almuerzo_acompanado
* [Almorzar solo] # EFECTO:conexion-
    -> laburo_almuerzo_solo
* [Saltear el almuerzo] # COSTO:1 # EFECTO:dignidad-
    -> laburo_almuerzo_saltear

=== laburo_almuerzo_acompanado ===

Bajás al comedor.
Sacás el tupper de la mochila.

Lo que trajiste de casa.
Lo que pudiste armar anoche.

~ ultima_tirada = d6()
{ultima_tirada <= 2: Arroz con huevo. Otra vez.}
{ultima_tirada == 3 || ultima_tirada == 4: Fideos con tuco de ayer.}
{ultima_tirada >= 5: Milanesa fría. Lujo.}

Te sentás con alguien.

// Chequeo social: conversación en el almuerzo
~ temp charla_almuerzo = chequeo_social(0, 3)
{ charla_almuerzo == 2:
    Enganchás una charla copada. Se ríen. Por un rato, olvidás todo.
    ~ subir_conexion(1)
}
{ charla_almuerzo == 1:
    Hablás de cosas. Por un rato, te olvidás de los problemas.
}
{ charla_almuerzo == 0:
    Hablás de cosas. Pero los problemas siguen ahí.
}
{ charla_almuerzo == -1:
    Metés la pata con un comentario. Silencio incómodo.
    Te levantás antes de tiempo.
    ~ bajar_conexion(1)
}

~ subir_conexion(1)

->->

=== laburo_almuerzo_solo ===

Comés solo.
En un rincón del comedor.
El tupper sobre la mesa.

A veces está bien.
El silencio.
No tener que hablar.

* [...]
-

Mirás a los demás.
Cada uno con su vianda.
Algunos solos, otros en grupo.

¿Cuántos estiran la comida como vos?

->->

=== laburo_almuerzo_saltear ===

~ energia -= 1

No comés.
Seguís laburando.

El estómago protesta pero la cabeza dice que hay que demostrar compromiso.
Que te vean.
Que sepan que sos valioso.

* [...]
-

...

A las 3 te morís de hambre.
Comprás algo en la máquina.

No sirvió de nada.

->->

// --- TARDE ---

=== laburo_tarde ===

# LA TARDE

La tarde es larga.
El cuerpo pide siesta.
La computadora pide atención.

Más mails.
Más tareas.
Más de lo mismo.

{d6() == 1:
    Un error. Algo que hiciste mal.
    El jefe te llama.
    "Esto está mal."
    "Sí, perdón. Lo corrijo."
    ~ bajar_dignidad(1)
}

->->

// --- REUNIONES ---

=== laburo_reunion_general ===
// Reunión de reestructuración

El salón grande.
Toda la oficina.
30, 40 personas.

El jefe y alguien de RRHH al frente.

* [...]
-

"Buenas tardes. Queríamos informarles..."

El aire se tensa.

"...que la empresa está atravesando un proceso de reestructuración."

Ahí está.

* [...]
-

"No podemos dar detalles todavía, pero habrá cambios en las próximas semanas. Les pedimos paciencia y compromiso."

Eso es todo.
No dicen quién.
No dicen cuándo.
Solo que algo viene.

* [Mirar a un compañero] -> laburo_reunion_mirar_companero
* [Mirar al piso] -> laburo_reunion_mirar_piso
* [Mirar al jefe] -> laburo_reunion_mirar_jefe

=== laburo_reunion_mirar_companero ===

Mirás a tu compañero.
Él te mira.

Sin palabras, entienden.
Esto es real.

Hay miedo en sus ojos.
Probablemente en los tuyos también.

-> laburo_reunion_fin

=== laburo_reunion_mirar_piso ===

Mirás el piso.
No querés ver a nadie.
No querés que te vean.

El miedo se huele.
30 personas pensando lo mismo.
¿Seré yo?

-> laburo_reunion_fin

=== laburo_reunion_mirar_jefe ===

Mirás al jefe.
Está serio.
No mira a nadie en particular.

¿Él decide quién se va?
¿Él ya sabe?

No te mira.
No sabés si eso es bueno o malo.

-> laburo_reunion_fin

=== laburo_reunion_fin ===

La reunión termina.
Todos vuelven a sus puestos.
Nadie habla.

~ bajar_salud_mental(1)

->->

// --- CITACIÓN A RRHH ---

=== laburo_citacion_rrhh ===

Te llaman.

"Mañana a las 11, en RRHH."

No dicen para qué.

* [Preguntar para qué]
    "¿Para qué?"
    "Es una reunión de rutina."
    No suena a rutina.
    -> laburo_citacion_fin
* [Asentir]
    Asentís.
    No preguntás.
    A veces es mejor no saber.
    -> laburo_citacion_fin

=== laburo_citacion_fin ===

~ bajar_salud_mental(1)

Aunque ya sabés.
O creés saber.

->->

// --- EL DESPIDO ---

=== laburo_despido ===

# LA REUNIÓN

La oficina de RRHH.
Dos personas que no conocés bien.
Un papel sobre la mesa.

"La empresa está reestructurando."

Ah.

* [...]
-

"Tu puesto fue afectado."

Así que era eso.

"Dejamos de necesitar tus servicios. Gracias por tu colaboración."

* [Escuchar] # FALSA
    No hay liquidación. No hay indemnización.
    Sos unipersonal. Facturás. "Independiente."
    Así te contrataron hace tres años.
    Así te echan hoy.
    -> laburo_despido_firmar

* [Aceptar] -> laburo_despido_firmar
* [Preguntar por qué] # EFECTO:dignidad?
    -> laburo_despido_preguntar

=== laburo_despido_preguntar ===

"¿Por qué yo?"

Se miran entre ellos.

"No es personal. Es reestructuración."

"Pero trabajo acá hace tres años."

* [...]
-

"Trabajás con nosotros. Facturás. Es diferente."

Claro. Siempre fue diferente cuando les convenía.
Nunca es personal.
Es el sistema funcionando como fue diseñado.

* [Irte] -> laburo_despido_firmar

=== laburo_despido_firmar ===

No hay nada que firmar.
Sos unipersonal. Simplemente dejás de facturar.

Te dan una caja para tus cosas.
No tenés muchas cosas.

* [...]
-

El escritorio se vacía rápido.

~ fui_despedido = true
~ tiene_laburo = false
~ bajar_salud_mental(1)

->->

// --- SALIDA DEL LABURO ---

=== laburo_salida ===

# LA SALIDA

5 de la tarde.
El laburo terminó.
Por hoy.

Caminás a la parada.
El cuerpo cansado.
La cabeza {d6() >= 4: cansada también|peor}.

->->

=== laburo_salida_despedido ===

# LA CALLE

Salís con tu caja.

La calle está igual que siempre.
El sol es el mismo sol.
La gente camina como si nada.

* [Seguir caminando] # FALSA
    Pero vos estás parado acá con una caja.
    A las 11:30 de la mañana de un miércoles.
    Sin laburo.

* [...]
-

Tenés tres meses de colchón.
No te estás muriendo.
Pero algo murió.

¿Quién sos ahora que no tenés laburo?

* [...]
-

~ idea_quien_soy = true

# IDEA: "¿QUIÉN SOY SIN LABURO?"

No la elegiste. Llegó sola.
Como un zumbido en la cabeza que no para.

->->

// --- INTERACCIÓN CON EL JEFE ---

=== laburo_hablar_con_jefe ===

~ energia -= 1

Te levantás.
Vas a la oficina del jefe.

"¿Puedo?"

"Sí, pasá. ¿Qué necesitás?"

"Nada, quería saber si... si estaba todo bien con mi trabajo."

Te mira.

~ ultima_tirada = d6()

{ultima_tirada >= 4:
    "Sí, todo bien. ¿Por?"

    "No, por nada. Rumores nomás."

    "No hagas caso a los rumores. Concentrate en tu trabajo."

    Salís.
    No fue tan malo.
    Pero tampoco te dijo nada.
    ->->
- else:
    "Mirá, ahora no es el momento para hablar de eso. Después vemos."

    ¿Después vemos qué?

    "Bueno. Gracias."

    Salís.
    Peor que antes.
    ~ bajar_salud_mental(1)
    ->->
}


## FILE: ubicaciones/barrio.ink

// ============================================
// UBICACION: EL BARRIO
// Escenas generales del barrio
// ============================================

// --- CAMINAR POR EL BARRIO ---

=== barrio_caminar ===
// Tunnel para caminar por el barrio
// Llamar: -> barrio_caminar ->

# EL BARRIO

Caminás por el barrio.

Las veredas rotas de siempre.
Los autos estacionados.
Los perros callejeros.

{tiene_laburo:
    Todo igual que siempre.
- else:
    Todo igual. Pero vos no.
    La calle se siente más ancha cuando no tenés adónde ir.
}

// Chequeo social: encuentro en el barrio
~ temp encuentro_barrio = chequeo_social(0, 3)
{ encuentro_barrio == 2:
    Un vecino que no conocías te para. "¿Sos nuevo por acá?" "No, de toda la vida." Se ríen.
    "Soy el Carlos. Del 14." Te da la mano. Un tipo más que te conoce.
    ~ subir_conexion(1)
}
{ encuentro_barrio == 1:
    Cruzás saludos con un par de vecinos. El barrio te conoce.
}
{ encuentro_barrio == 0:
    Nadie te saluda. O capaz no miraste.
}
{ encuentro_barrio == -1:
    Un tipo te mira mal desde la esquina. No sabés por qué.
    Apurás el paso. El barrio a veces no es fácil.
    ~ bajar_salud_mental(1)
}

~ ultima_tirada = d6()

{ultima_tirada == 1:
    -> barrio_encuentro_vecino_molesto ->
}
{ultima_tirada == 2:
    -> barrio_encuentro_perro ->
}
{ultima_tirada == 6:
    -> barrio_encuentro_positivo ->
}

El barrio sigue.
Vos seguís.

->->

=== barrio_encuentro_vecino_molesto ===

Un vecino te para.

"Che, ¿vos no viste quién me raya el auto?"

"No, ni idea."

"Siempre lo mismo en este barrio de mierda."

Se va enojado.

->->

=== barrio_encuentro_perro ===

Un perro callejero te sigue un rato.
Flaco.
Con cara de hambre.

{d6() >= 4:
    Le tirás algo que tenés en el bolsillo.
    Un pedazo de galletita.
    El perro come y se va.
- else:
    No tenés nada para darle.
    El perro se aburre y se va.
}

->->

=== barrio_encuentro_positivo ===

Una vecina te saluda.
"¡Buen día!"

"Buen día."

{d6() >= 4:
    "¿Todo bien?"
    "Sí, ahí andamos."
    "Bueno. Cuidate."

    Una conversación breve.
    Pero humana.
    ~ subir_conexion(1)
- else:
    Sigue caminando.
    Pero te saludó.
    Eso está bien.
}

->->

// --- LA PLAZA ---

=== barrio_plaza ===
// Tunnel para ir a la plaza
// Llamar: -> barrio_plaza ->

# LA PLAZA

La plaza del barrio.

Un par de bancos, algunos árboles, los juegos oxidados.

* [...]
-

Pibes jugando a la pelota.
Viejos sentados.
Madres con cochecitos.

~ veces_en_plaza += 1

{veces_en_plaza == 1:
    No venías hace rato.
}

{not tiene_laburo:
    Antes solo venías los fines de semana.
    Ahora tenés todo el tiempo del mundo.
}

* [Sentarte en un banco] # EFECTO:dignidad+ -> barrio_plaza_banco ->
    ->->
* [Caminar por la plaza] -> barrio_plaza_caminar ->
    ->->
* [Mirar a los pibes jugar] # EFECTO:conexion? -> barrio_plaza_pibes ->
    ->->
* [Irte] ->->

=== barrio_plaza_banco ===

Te sentás en un banco.

El sol.
El ruido de los pibes.
El viento.

* [...]
-

Por un rato, no pensás en nada.

{d6() >= 5:
    Alguien se sienta al lado tuyo.
    Un viejo.

    "Linda tarde."

    "Sí."

    Se quedan en silencio.
    No hace falta más.

    ~ subir_conexion(1)
}

->->

=== barrio_plaza_caminar ===

Caminás por la plaza.

Dando vueltas.
Sin rumbo.

{not tiene_laburo:
    Esto hacés ahora.
    Caminar.
    Sin saber a dónde.
}

{d6() <= 2:
    Una pelota te pega en el pie.
    Un pibe viene corriendo.
    "¡Perdón, señor!"
    Se la devolvés.
    "Tranquilo."
}

->->

=== barrio_plaza_pibes ===

Mirás a los pibes jugar.

Picado en la tierra.
Gritos.
Peleas por goles.

{d6() >= 4:
    Uno hace un golazo.
    Los otros putean.
    "¡Era offside!"
    "¡Offside las pelotas!"

    Te reís.
    No te reías hace rato.
}

{not tiene_laburo:
    Cuando eras pibe, todo era más simple.
    O eso te parece ahora.
}

->->

// --- EL KIOSCO ---

=== barrio_kiosco ===
// Tunnel para ir al kiosco
// Llamar: -> barrio_kiosco ->

# EL KIOSCO

El kiosco de la esquina.

Esas viejas, caramelos, cigarrillos.

* [...]
-

Revistas que nadie compra.
Un cartel de Coca-Cola de hace 20 años.

{not conozco_al_kiosquero:
    El kiosquero es un tipo de unos 60.
    Bigote.
    Cara de pocos amigos.
    ~ conozco_al_kiosquero = true
- else:
    El kiosquero está ahí, como siempre.
}

"¿Qué va a ser?"

* [Comprar algo] -> barrio_kiosco_comprar ->
    ->->
* [Solo saludar]
    "Nada, pasaba nomás. Buen día."
    Te mira raro pero no dice nada.
    ->->

=== barrio_kiosco_comprar ===

~ ultima_tirada = d6()

{ultima_tirada <= 2:
    "Un agua."
    "50."
    Pagás. Te da el agua.
}
{ultima_tirada == 3 || ultima_tirada == 4:
    "Un atado."
    Te da el atado. Pagás.
    {d6() >= 4:
        "Cada vez más caros, eh."
        "Todo sube."
        "Todo sube."
    }
}
{ultima_tirada >= 5:
    "Dame un alfajor de esos."
    Te da el alfajor.
    "40."
    Pagás.
}

{d6() == 6:
    El kiosquero te mira.
    "¿Todo bien? Te veo medio caído."

    * ["Sí, todo bien."]
        "Sí, todo bien."
        "Bueno."
        ->->
    * ["Ahí andamos."]
        "Ahí andamos. Perdí el laburo."
        "Uh. Está jodido."
        "Está jodido."
        "Bueno. Suerte."
        ->->
- else:
    ->->
}

// --- EL TIPO DEL BANCO ---

=== barrio_tipo_del_banco ===
// Tunnel para encontrar al tipo que duerme en el banco
// Llamar: -> barrio_tipo_del_banco ->

# EL BANCO DE LA ESQUINA

El tipo que duerme en el banco.

Siempre está ahí.
Con sus bolsas, sus cartones, su mundo.

* [...]
-

{not hable_con_el_del_banco:
    Nunca le hablaste.
    Nadie le habla.
    Pasa la gente y no lo mira.
}

* [...]
-

{not tiene_laburo:
    Ahora lo mirás distinto.
    ¿Cuántos pasos hay entre vos y él?
    Unipersonal. Sin indemnización. Sin seguro.
    Muy pocos pasos.
}

* [Acercarte] -> barrio_banco_acercarse
* [Dejarlo tranquilo]
    Lo dejás tranquilo.
    Él no pidió que lo molesten.
    ->->

=== barrio_banco_acercarse ===

Te acercás.

Está despierto.
Te mira.

* [...]
-

Ojos cansados.
Barba de días.
Ropa sucia pero no tanto.

{not hable_con_el_del_banco:
    "¿Qué querés?"

    No suena agresivo.
    Solo cansado.

    * [Preguntarle si necesita algo]
        "¿Necesitás algo?"

        Te mira.

        "¿Y vos qué me vas a dar?"

        No sabés qué decir.

        "Un café, si querés."

        "Bueno."

        ~ hable_con_el_del_banco = true
        ~ nombre_del_banco = "Roberto"

        -> barrio_banco_cafe

    * [Sentarte cerca]
        Te sentás en el otro extremo del banco.

        Se quedan en silencio.

        "Me llamo Roberto."

        "Yo soy {vinculo == "sofia": Martín|Diego}."

        "Bueno."

        ~ hable_con_el_del_banco = true
        ~ nombre_del_banco = "Roberto"

        Silencio.
        No hace falta más.

        ->->

    * [Irte]
        "Nada. Perdón."
        "Está bien."
        ->->

- else:
    "Ah, vos otra vez."

    {nombre_del_banco != "": "¿Cómo andás, {nombre_del_banco}?"}

    "Acá. Siempre acá."

    * [Ofrecerle un café] -> barrio_banco_cafe
    * [Sentarte un rato] -> barrio_banco_charla
    * [Irte]
        "Bueno. Nos vemos."
        "Chau."
        ->->
}

=== barrio_banco_cafe ===

Le traés un café del kiosco.

"Gracias."

Toma.

* [...]
-

{d6() >= 4:
    "Yo laburaba, ¿sabés? En una fábrica. Hace años."
    No preguntaste.
    Pero te cuenta.
    "Después cerró. Y bueno. Una cosa lleva a la otra."
    Toma el café.
    "Pero no estoy mal. Tengo mis cosas. Conozco gente. Vivo."
    ~ subir_conexion(1)
}

->->

=== barrio_banco_charla ===

Te sentás.

{nombre_del_banco}: "¿Vos qué hacés?"

{tiene_laburo:
    "Laburo. En una oficina."
    "Ah. Bien."
- else:
    "Nada. Perdí el laburo hace poco."

    Te mira.

    "Uh. ¿Y cómo la llevás?"

    "Ahí."

    "Sí. Ahí se lleva."
}

Silencio.

{d6() >= 4:
    "¿Sabés qué es lo peor? No es el frío. No es el hambre. Es que la gente no te mira."

    "Te miran como si no existieras."

    Pensás en todas las veces que no miraste.

    ~ subir_conexion(1)
}

->->

// --- ENCUENTROS ALEATORIOS ---

=== barrio_encuentro_aleatorio ===
// Tunnel para encuentros random en el barrio
// Llamar: -> barrio_encuentro_aleatorio ->

~ ultima_tirada = d6()

{ultima_tirada == 1:
    -> barrio_encuentro_sofia ->
}
{ultima_tirada == 2:
    -> barrio_encuentro_musica ->
}
{ultima_tirada == 3:
    -> barrio_encuentro_discusion ->
}
{ultima_tirada == 4:
    -> barrio_encuentro_nenes ->
}
{ultima_tirada == 5:
    -> barrio_encuentro_vieja ->
}
{ultima_tirada == 6:
    -> ixchel_encuentro_casual ->
}

->->

=== barrio_encuentro_sofia ===

{vinculo == "sofia":
    Sofía viene por la vereda con los pibes.

    "¡Ey! ¿Qué hacés por acá?"

    "Nada. Caminando."

    "¿Todo bien?"

    * ["Sí, todo bien."] # STAT:conexion
        "Sí, todo bien."
        "Bueno. Cualquier cosa..."
        "Sí, ya sé."
        ~ subir_conexion(1)
        ->->
    * ["Más o menos."] # STAT:conexion
        "Más o menos."
        "Uh. ¿Querés hablar?"
        "Después. Ahora no."
        "Bueno. Sabés dónde estoy."
        ~ subir_conexion(1)
        ->->
- else:
    Una vecina pasa.
    Te saluda.
    "Buen día."
    "Buen día."
    ->->
}

=== barrio_encuentro_musica ===

De una casa sale música.
Cumbia.
A todo lo que da.

{d6() >= 4:
    Por un segundo, el barrio se siente vivo.
    No todo es gris.
- else:
    Es temprano para tanta música.
    Pero bueno. Cada uno.
}

->->

=== barrio_encuentro_discusion ===

En una esquina, dos tipos discuten.

"¡Te dije que no!"
"¡Y yo te digo que sí!"

No sabés de qué hablan.
Pasás de largo.

{d6() == 1:
    Uno te mira.
    "¡¿Qué mirás?!"
    "Nada."
    Seguís caminando.
    ~ bajar_salud_mental(1)
}

->->

=== barrio_encuentro_nenes ===

Pibes jugando en la vereda.
Con lo que hay.
Una pelota medio desinflada.
Chapitas.
Palitos.

{d6() >= 5:
    Uno te saluda.
    "¡Hola, señor!"
    "Hola."
    Te hace sonreír.
}

->->

=== barrio_encuentro_vieja ===

Una vieja camina despacio.
Con bolsas del super.
Le cuesta.

* [Ayudarla] # STAT:conexion # EFECTO:conexion+
    "¿La ayudo?"
    "Ay, sí. Gracias, m'hijo."

    Le llevás las bolsas hasta la esquina.

    "Dios te bendiga."

    ~ subir_conexion(1)
    ->->
* [Seguir] # EFECTO:conexion-
    Seguís caminando.
    Ella sigue caminando.
    Cada uno con lo suyo.
    ->->

=== barrio_encuentro_silencio ===

Por un momento, todo está en silencio.

No hay gente.
No hay autos.
No hay nada.

* [...]
-

Solo vos y el barrio.

{not tiene_laburo:
    ¿Esto es la vida ahora?
    ¿Caminar por el barrio sin rumbo?
}

* [...]
-

El momento pasa.
Un auto pasa.
Todo sigue.

->->

// --- BARRIO DE NOCHE ---

=== barrio_noche ===
// Tunnel para el barrio de noche
// Llamar: -> barrio_noche ->

# EL BARRIO DE NOCHE

El barrio de noche.

Pocas luces.
Perros ladrando.

* [...]
-

La televisión prendida en las casas.

* [...]
-

{d6() <= 2:
    Hay un grupo de pibes en la esquina.
    Fumando.
    Hablando.
    Te miran cuando pasás.
    Seguís caminando.
}

{d6() == 6:
    Las estrellas se ven.
    A veces se olvida que están ahí.
    El barrio no es tan malo de noche.
}

->->

// --- BARRIO DOMINGO ---

=== barrio_domingo ===
// Tunnel para el barrio en domingo
// Llamar: -> barrio_domingo ->

# EL BARRIO EN DOMINGO

Domingo.
El barrio más tranquilo que nunca.

* [...]
-

Los negocios cerrados.
Poca gente en la calle.

* [...]
-

Alguien pasea un perro.
Un viejo toma café en un vaso térmico en la vereda.

{d6() >= 5:
    El olor a asado viene de algún lado.
    Domingos en familia.
    Vos no tenés eso hoy.
}

->->

// --- GRUPO DE LA OLLA ---

=== barrio_grupo_olla ===
// Tunnel para encontrar al grupo de la olla en la calle
// Llamar: -> barrio_grupo_olla ->

El grupo de la olla.
Sofía, Elena, otros.

Hablando en la vereda.
Tomando café.

* [...]
-

"¿Todo bien?", te preguntan.

Te quedás un rato.
Escuchando.
Siendo parte.

~ subir_conexion(1)

->->

// --- CAMINAR SIN RUMBO ---

=== barrio_caminar_sin_rumbo ===
// Tunnel para caminar sin destino
// Llamar: -> barrio_caminar_sin_rumbo ->

Caminás sin rumbo.

No hay a donde ir.
No hay a donde volver.

* [...]
-

El barrio te conoce.
Pero hoy te siente distinto.

* [...]
-

{not tiene_laburo:
    Sin laburo, las calles son diferentes.
    Antes eran camino al trabajo.
    Ahora son solo calles.
}

* [...]
-

Las horas pasan.
Caminando.
Pensando.

->->

// --- BARRIO SABADO ---

=== barrio_sabado ===
// Tunnel para el ambiente del sábado
// Llamar: -> barrio_sabado ->

# SABADO EN EL BARRIO

Sábado.
El barrio más relajado.

* [...]
-

La gente hace compras.
Los pibes juegan en la calle.
Algún asado se prepara.

{d6() >= 4:
    Pasás por la ferretería.
    Cerrada.
    "Se vende" dice el cartel.
    Otro negocio que cierra.
}

->->

// --- CAMINAR DE TARDE ---

=== barrio_caminar_tarde ===
// Tunnel para caminar de tarde
// Llamar: -> barrio_caminar_tarde ->

La tarde en el barrio.

El sol bajando.
Las sombras largas.

* [...]
-

Gente volviendo de trabajar.
Gente saliendo a caminar.

{d6() >= 5:
    Un vecino te saluda.
    "¿Qué tal?"
    "Ahí andamos."
    El intercambio de siempre.
}

->->

// --- CAMINAR DE MANANA ---

=== barrio_caminar_manana ===
// Tunnel para caminar de mañana
// Llamar: -> barrio_caminar_manana ->

La mañana en el barrio.

El sol recién saliendo.
El rocío en los autos.

* [...]
-

Gente yendo a trabajar.
Pibes yendo a la escuela.

{not tiene_laburo:
    Antes eras uno de ellos.
    Los que van al laburo.
    Ahora mirás pasar.
}

{d6() >= 5:
    Un vecino te saluda.
    "¡Buen día!"
    "Buen día."
    El saludo de siempre.
}

->->


## FILE: ubicaciones/olla.ink

// ============================================
// UBICACION: LA OLLA POPULAR
// Escenas en la olla del barrio
// ============================================

// --- LLEGADA A LA OLLA ---

=== olla_llegada ===
// Llamar cuando el protagonista va a la olla

# LA OLLA

La olla popular del barrio.
Un galponcito con chapas, mesas largas, ollas enormes.
El olor a comida que se siente desde la esquina.

    Sofía está en el medio de todo.
    Coordinando, hablando, moviendo ollas.
    No para.

{olla_en_crisis:
    Hay poca gente cocinando.
    Las ollas están casi vacías.
    Se nota la tensión.
- else:
    Hay movimiento. Gente cocinando, gente sirviendo.
    Funciona.
}

* [Acercarte a ayudar] # EFECTO:conexion+
    -> olla_ofrecer_ayuda
* [Quedarte mirando] -> olla_observar
* {olla_en_crisis} [Preguntar qué pasa] # EFECTO:conexion?
    -> olla_preguntar_crisis
* [Irte] # EFECTO:conexion-
    -> olla_irse

=== olla_irse ===

Te vas.
Todavía no estás listo para esto.

->->

=== olla_observar ===

Te quedás mirando desde afuera.

La gente. Viejos, familias, pibes.
No es una fila de espera pasiva. Se habla. Se comparte.
Vecinos. Gente que conocés de vista.

{not tiene_laburo:
    Ahí está la red.
    La que te empieza a faltar a vos.
}

Una señora te mira.
"¿Vas a comer o a mirar?"

* [Ofrecer ayuda] -> olla_ofrecer_ayuda
* [Irte]
    "No, nada. Perdón."
    Te vas.
    ->->

=== olla_ofrecer_ayuda ===

"Disculpá, ¿necesitan una mano?"

Sofía te mira de arriba abajo.

{veces_que_ayude == 0:
    "¿Sabés pelar papas?"
    "Sí."
    "Entonces vení."
- else:
    "Ah, volviste. Bien. Metete en {d6() >= 4: las papas|el reparto}."
}

-> olla_ayudar_menu

=== olla_ayudar_menu ===

# AYUDANDO EN LA OLLA

¿Qué hacés?

* [Pelar papas] # COSTO:1 # DADOS # EFECTO:conexion+
    -> olla_pelar_papas
* [Servir] # COSTO:1 # DADOS # EFECTO:conexion+
    -> olla_servir
* [Limpiar] # COSTO:1 # DADOS # STAT:conexion # EFECTO:conexion+
    -> olla_limpiar
* {energia <= 1} [Decir que te vas]
    -> olla_despedirse

=== olla_pelar_papas ===

~ energia -= 1
~ ayude_en_olla = true
~ veces_que_ayude += 1

Te sentás en un banquito con un balde de papas.
Pelás.

Hay una señora al lado tuyo. Es Elena, la veterana del barrio. No la habías visto en esta tarea antes, o quizás sí y no te dabas cuenta.

* [...]
-

// Chequeo comunitario: pelar papas en la olla
~ temp pelada = chequeo_comunitario(0, 3)
{ pelada == 2:
    Te sale natural. La cáscara sale en una tira larga, casi perfecta.
    Elena te mira de reojo. No sonríe, pero asiente.
    "Mi viejo pelaba así", dice. "En el 2002. Cuando tuvimos que cerrar el taller."
    Es la primera vez que menciona el taller. El cuchillo sigue moviéndose.
    Historias que se cuentan mirando para abajo.
    ~ subir_conexion(1)
}
{ pelada == 1:
    Pelás. El movimiento repetitivo calma algo en tu cabeza.
    Elena habla del precio del aceite. De que no alcanza.
    "Es cíclico", dice. "Cada diez años nos rompen las piernas. Y aprendemos a caminar de nuevo."
    Te pasa otra papa sin mirarte.
    "Aprendemos."
}
{ pelada == 0:
    Se te caen un par de papas. Tenés las manos torpes, desacostumbradas al trabajo manual.
    Elena las levanta sin decir nada. Las lava. Te las devuelve.
    "Despacio", dice. "Nadie nos corre."
    Pero el hambre sí corre.
}
{ pelada == -1:
    El cuchillo se resbala. Te cortás el dedo. La sangre gotea sobre una papa lavada.
    "¡Trapo!"
    Elena te venda rápido. Tiene práctica.
    "La sangre se lava. El hambre no", murmura alguien.
    Sentís la vergüenza arder más que el corte.
    ~ bajar_salud_mental(1)
}

Las papas se acaban. Tus manos huelen a tierra y almidón.

* [Seguir ayudando] -> olla_ayudar_menu
* [Irte] -> olla_despedirse

=== olla_servir ===

~ energia -= 1
~ ayude_en_olla = true
~ veces_que_ayude += 1

Te ponés atrás de la mesa.
Cucharón en mano.

La gente avanza.
Platos, platos, platos.

* [...]
-

// Chequeo comunitario: servir en la olla
~ temp servicio = chequeo_comunitario(0, 3)
{ servicio == 2:
    El ritmo es perfecto. Cucharón, plato, sonrisa. Cucharón, plato, sonrisa.
    Ves una cara conocida. González. De contabilidad.
    Te ve. Baja la vista.
    Le servís un poco más de carne.
    Él asiente, rápido, y se va sin mirar atrás.
    La dignidad es un cristal frágil. Hoy vos lo cuidaste.
    ~ subir_conexion(1)
}
{ servicio == 1:
    Servís. Las manos se estiran. Manos curtidas, manos de oficina, manos de pibes.
    Una nena te da un dibujo a cambio del plato. Un sol negro.
    "Gracias", dice.
    Te guardás el dibujo en el bolsillo. Quema.
}
{ servicio == 0:
    Calculaste mal. Le diste mucho a los primeros, ahora tenés que escatimar.
    Un viejo te mira el cucharón medio vacío.
    "¿Eso es todo?"
    "Hay que estirar, abuelo."
    Te odiás por decir eso. Te odiás mucho.
}
{ servicio == -1:
    Se te vuelca el cucharón sobre la mesa.
    "¡Eh, cuidado!"
    Es comida caliente. Es comida que falta.
    Sofía viene con un trapo. No te reta. Su silencio es peor.
    "Tomate un respiro", te dice.
    Te apartás, con las manos temblando.
    ~ bajar_salud_mental(1)
}

{not tiene_laburo:
    Del otro lado del mesón, las caras cambian.
    Pero los ojos son los mismos.
    Miedo.
    El mismo miedo que tenés vos cuando te despertás a las 4 de la mañana.
}

La fila se termina.

* [Seguir ayudando] -> olla_ayudar_menu
* [Irte] -> olla_despedirse

=== olla_limpiar ===

~ energia -= 1
~ ayude_en_olla = true
~ veces_que_ayude += 1

Limpiás.
Mesas, ollas, pisos.

El trabajo físico te vacía la cabeza.
Por un rato no pensás en nada.
Solo en la mugre y en sacarla.

* [...]
-

{d6() >= 5:
    Sofía está haciendo cuentas en una libreta.
    Muerde la lapicera.
    "No cierran", murmura. "Nunca cierran."
    Te ve limpiando. Cierra la libreta de golpe.
    "Dejá eso. Vení."
    Te da un mate. Está frío.
    "Gracias por venir. La mayoría viene una vez, se saca la foto moral y no vuelve."
    Te mira fijo.
    "No desaparezcas."
    ~ subir_conexion(1)
}

Terminás de limpiar. El piso brilla, o eso te parece.

* [Seguir ayudando] -> olla_ayudar_menu
* [Irte] -> olla_despedirse

=== olla_despedirse ===

"Me voy yendo."

{veces_que_ayude >= 2:
    Sofía asiente.
    "Gracias por la mano. La olla es de todos."

    ~ subir_conexion(1)
- else:
    "Bueno. Gracias."
}

Salís de la olla.
El olor a comida te sigue un rato.

->->

// --- ESCENAS DE CRISIS ---

=== olla_preguntar_crisis ===

"¿Qué pasó? ¿Por qué tan vacío?"

Sofía suspira.

"No hay donaciones. El municipio se borró. El super cerró."

* [...]
-

Mira las ollas casi vacías.

"Hoy damos, pero mañana... no sé."

* [Ofrecer plata] -> olla_ofrecer_plata
* [Ofrecer ayuda] -> olla_ofrecer_ayuda_crisis
* [No decir nada]
    No sabés qué decir.
    Ella tampoco espera que digas nada.
    ->->

=== olla_ofrecer_plata ===

{not tiene_laburo:
    No tenés nada. Sin indemnización.
    Lo poco que tenés es lo que juntaste.
    Pero...
}

"¿Puedo aportar algo? Plata, digo."

Sofía te mira.

"Todo suma, pibe. Todo suma."

* [Dar algo chico]
    Le das lo que tenés en el bolsillo.
    No es mucho.
    "Gracias."
    ->->
* [Dar algo más] # COSTO:1 # STAT:conexion
    Le das un billete más grande.
    ~ energia -= 1
    "Gracias. En serio."
    ~ subir_conexion(1)
    ->->
* [Pensarlo mejor]
    "Después te traigo algo."
    "Bueno."
    No suena convencida.
    ->->

=== olla_ofrecer_ayuda_crisis ===

"¿Qué puedo hacer?"

"Conseguir donaciones. Hablar con gente. Mover contactos."

{not tiene_laburo:
    Tenés tiempo, al menos.
}

"Hay una asamblea el viernes. Si querés venir..."

* [Decir que vas a ir]
    "Voy."
    "Bien."
    ->->
* [Decir que vas a ver]
    "Voy a ver si puedo."
    "Bueno."
    ->->

=== olla_crisis_sin_comida ===
// Llamar cuando la crisis es grave

# LA OLLA (en crisis)

Llegás a la olla.
Está cerrada.

Un cartel en la puerta:
"HOY NO HAY COMIDA. MAÑANA INTENTAMOS."

* [...]
-

~ olla_en_crisis = true

Hay gente parada afuera.
Mirando el cartel.
Sin saber qué hacer.

* [...]
-

Una señora con un nene.
Un viejo con bastón.
Dos pibes que no tienen más de 15.

{not tiene_laburo:
    Vos tenés tres meses de colchón.
    Ellos no tienen nada.
}

* [Quedarte un rato] -> olla_crisis_quedarse
* [Irte]
    Te vas.
    No hay nada que hacer.
    O sí, pero no sabés qué.
    ->->

=== olla_crisis_quedarse ===

Te quedás.
No sabés para qué.

Sofía sale del galpón.
Tiene los ojos rojos.

* [...]
-

"Mañana capaz que conseguimos algo. Hoy no hay."

La gente se va de a poco.
Vos te quedás.

* [...]
-

"¿Querés ayudar de verdad?"

"Sí."

"Entonces vení el viernes a la asamblea."

->->

// --- ASAMBLEA ---

=== olla_asamblea ===
// Llamar cuando hay asamblea en la olla

# ASAMBLEA EN LA OLLA

Viernes de noche.
El galpón de la olla lleno de gente.

No solo los que ayudan.
Vecinos.
Gente del barrio que nunca viste.

* [...]
-

Sofía está al frente.

"Bueno, gracias por venir. Esto es de todos. Hablamos todos."

~ participe_asamblea = true

* [Escuchar]
    -> olla_asamblea_escuchar
* [Hablar] # COSTO:1 # STAT:conexion
    -> olla_asamblea_hablar

=== olla_asamblea_escuchar ===

Escuchás.

Una señora: "Mi marido perdió el laburo. Somos cuatro. No llegamos."

Un tipo: "El kiosco de la esquina cerró. ¿Quién nos va a donar ahora?"

Otra señora: "La municipalidad no responde. Llamé veinte veces."

* [...]
-

Un pibe joven: "Hay que hacer algo. No podemos quedarnos esperando."

Sofía: "Por eso estamos acá. Para decidir qué hacemos."

{not tiene_laburo:
    Pensás en tu propia situación.
    Tres meses.
    No es nada comparado con esto.
    O es lo mismo, pero en cámara lenta.
}

-> olla_asamblea_propuestas

=== olla_asamblea_hablar ===

~ energia -= 1

Levantás la mano.

"Yo... hace poco perdí el laburo. No estoy en la misma que ustedes, todavía. Pero quiero ayudar."

* [...]
-

La gente te mira.

Sofía asiente.

"Todo el mundo aporta lo que puede. Eso está bien."

~ subir_conexion(1)

-> olla_asamblea_propuestas

=== olla_asamblea_propuestas ===

Se discuten propuestas.

"Hay que hacer una colecta."
"Hay que ir a la municipalidad."
"Hay que hablar con los comercios que quedan."
"Hay que organizarse mejor."

* [...]
-

{d6() >= 4:
    Al final, algo se decide.
    Un plan. Tareas.
    Vos te anotás para algo.

    ~ ayude_en_olla = true
- else:
    Al final, no se decide mucho.
    Pero algo se mueve.
    Al menos la gente habló.
}

La asamblea termina.
La gente se va de a poco.

Sofía te ve.

"Gracias por venir."

->->

// --- ESCENA ESPECIAL: COMIENDO EN LA OLLA ---

=== olla_comer ===
// Si el protagonista decide comer en la olla

# COMIENDO EN LA OLLA

{veces_que_ayude >= 2:
    Sofía te ve.
    "¿Hoy comés?"

    * [Sí]
        "Sí."
        "Sentate."
        -> olla_comer_plato
    * [No, solo vine a ayudar]
        "No, vine a ayudar nomás."
        "Bueno. Vení."
        -> olla_ayudar_menu
- else:
    Hacés la cola.
    Como todos.
    -> olla_comer_cola
}

=== olla_comer_cola ===

La cola.
Adelante tuyo, una señora con tres pibes.
Atrás, un viejo solo.

Nadie habla.

* [...]
-

{not tiene_laburo:
    ¿Es esto tu futuro?
    Quizás.
    Pero si es esto, al menos no estás solo.
}

* [...]
-

Te toca.
Te dan un plato.
Guiso.

-> olla_comer_plato

=== olla_comer_plato ===

Guiso.
Papas, carne (poca), verduras.
Comida de verdad.

Te sentás en una mesa larga.
Comés.

* [...]
-

{d6() >= 4:
    Alguien al lado tuyo te habla.
    "¿Primera vez?"
    "Sí."
    "Está bien la comida."
    "Sí."
    No dicen más.
    Pero es algo.
}

Terminás de comer.

->->

// --- AMBIENTE NORMAL ---

=== olla_ambiente_normal ===
// Tunnel para el ambiente normal de la olla
// Llamar: -> olla_ambiente_normal ->

La olla funcionando.

Ollas en el fuego.
Gente preparando.
El olor a comida.

Lo de siempre.
Pero hay tensión.
Se nota en las caras.

->->

// --- AYUDAR EN COCINA ---

=== olla_ayudar_cocina ===
// Tunnel para ayudar en la cocina
// Llamar: -> olla_ayudar_cocina ->

Te ponés a ayudar.

Pelás papas.
Cortás verduras.
Revolvés la olla.

* [...]
-

No es difícil.
Pero es necesario.

~ ayude_en_olla = true
~ veces_que_ayude += 1
~ subir_conexion(1)

->->

// --- ESCUCHAR CRISIS ---

=== olla_escuchar_crisis ===
// Tunnel para escuchar sobre la crisis
// Llamar: -> olla_escuchar_crisis ->

"No hay para mañana."

Sofía lo dice bajito.
Pero todos escuchan.

* [...]
-

"Las donaciones no llegan."
"El municipio no contesta."
"Los comercios ya no dan."

~ olla_en_crisis = true

* [...]
-

Silencio.
¿Qué se hace?

->->

// --- AMBIENTE CRISIS ---

=== olla_ambiente_crisis ===
// Tunnel para el ambiente de crisis
// Llamar: -> olla_ambiente_crisis ->

La olla está distinta hoy.

Menos movimiento.
Más caras largas.

Se siente la tensión.
Algo no está bien.

{olla_en_crisis:
    Ya sabés lo que es.
    No hay recursos.
}

->->

// --- COLECTA CALLEJERA ---

=== olla_colecta_callejera ===
// Tunnel para hacer colecta en la calle
// Llamar: -> olla_colecta_callejera ->

# LA COLECTA

Salís a la calle.
A pedir.

Es difícil.
Pararte en una esquina.
Explicar.
Pedir.

* [...]
-

~ energia -= 1
~ subir_dignidad(1)
~ subir_llama(1)

Pero lo hacés.
No bajás la cabeza. Mirás a los ojos.
Esto es trabajo digno. Es sostener.

* [...]
-

Algunos dan.
La mayoría no.
Pero algunos sí.

~ subir_llama(1)

->->

// --- PEDIR A VECINOS ---

=== olla_pedir_vecinos ===
// Tunnel para pedir comida a vecinos
// Llamar: -> olla_pedir_vecinos ->

# PUERTA A PUERTA

Vas por las casas.
Golpeando puertas.
Pidiendo comida.

"Lo que tengan. Una papa. Un tomate."

~ energia -= 1

{d6() >= 3:
    Algunos dan.
    Una bolsa acá, otra allá.
    Se junta algo.
    ~ subir_conexion(1)
}

{d6() < 3:
    Pocas puertas se abren.
    La gente también está mal.
}

->->

// --- RESULTADO COLECTA ---

=== olla_resultado_colecta ===
// Tunnel para el resultado de la colecta
// Llamar: -> olla_resultado_colecta ->

Vuelven todos.
Se cuenta lo que hay.

{d6() >= 4:
    "Algo juntamos."
    No es mucho.
    Pero es algo.
    ~ subir_llama(1)
}

{d6() < 4:
    "No alcanza."
    Pero hay que cocinar igual.
    Con lo que hay.
}

->->

// --- PREPARAR ASAMBLEA ---

=== olla_preparar_asamblea ===
// Tunnel para la preparación de la asamblea
// Llamar: -> olla_preparar_asamblea ->

La olla se prepara para la asamblea.

Sillas en círculo.
Termo de café.
Papeles con números.

Hoy se habla de todo.
De cómo seguir.
De si se puede seguir.

->->

// --- INICIO ASAMBLEA ---

=== olla_asamblea_inicio ===
// Tunnel para el inicio de la asamblea
// Llamar: -> olla_asamblea_inicio ->

# LA ASAMBLEA

~ participe_asamblea = true

La gente se sienta.
Sofía abre.

"Bueno. Estamos todos los que estamos."
"Gracias por venir."

* [...]
-

Elena sirve café.
Alguien trae bizcochos.

"Hay que hablar de cómo seguimos."

->->

// --- DISCUSION ASAMBLEA ---

=== olla_asamblea_discusion ===
// Tunnel para la discusión de la asamblea
// Llamar: -> olla_asamblea_discusion ->

La discusión empieza.

Ideas van y vienen:
- "Hacer más colectas."
- "Buscar comercios nuevos."
- "Ir al municipio de vuelta."
- "Organizar una feria."

* [...]
-

Nadie tiene la respuesta.
Pero todos buscan.

->->

// --- FIN ASAMBLEA ---

=== olla_asamblea_fin ===
// Tunnel para el fin de la asamblea
// Llamar: -> olla_asamblea_fin ->

La asamblea termina.

No hay solución mágica.
Pero hay un plan.
Más o menos.

* [...]
-

La gente se va yendo.
Algunos se quedan a limpiar.

"Gracias por venir", dice Sofía.

~ subir_conexion(1)

->->

// --- CERRAR NOCHE ---

=== olla_cerrar_noche ===
// Tunnel para cerrar la olla de noche
// Llamar: -> olla_cerrar_noche ->

La olla cierra.

Las ollas vacías.
Las mesas limpias.
Las luces se apagan.

* [...]
-

Sofía es la última en irse.
Siempre.

Mañana hay que volver a empezar.

->->

// --- ECO: ELENA RECUERDA ---

=== viernes_olla_elena_eco ===
// Tunnel: Elena recuerda si te conto su historia
// Llamar: -> viernes_olla_elena_eco ->

{elena_conto_historia:
    Elena te ve llegar.
    "Viniste."
    No es sorpresa.
    Es algo más.
    Como si hubiera esperado que vinieras.
    Como si la historia del 2002 hubiera funcionado.
    ~ elena_relacion += 1
}

->->

// --- HISTORIA FUNDACIONAL DE LA OLLA ---

=== olla_historia_fundacion ===
// La historia de cómo empezó la olla

~ escuche_historia_olla = true

Elena está sentada en un rincón.
Sofía revuelve la olla.
Hay un momento de calma.

"¿Cómo empezó todo esto?", preguntás.

Elena y Sofía se miran.

"La Chola", dicen las dos al mismo tiempo.

* [...]
-

Elena habla primero.

"La mamá de Sofía. Empezó en los 90, dando merienda a los gurises en su casa."

Sofía asiente.

"Quince porciones. Con lo que había. Nada más."

* [...]
-

"En el 2002 explotó. De quince a ochenta porciones. La Chola y Elena cocinaban turnándose."

Elena se ríe.

"Terminábamos a las cuatro de la mañana. Y a las siete ya estábamos pelando de nuevo."

* [...]
-

"Después de la crisis, bajó un poco. Veinte, treinta porciones. La Chola se puso vieja. Sofía estaba en España."

"Y después vino la pandemia", dice Sofía.

"Y de treinta pasamos a cien. Y acá estamos."

* [...]
-

Mirás el galponcito. Las paredes de bloque, el techo de chapa.

"Todo esto lo construyeron ustedes."

"Entre todos", corrige Elena. "Nunca nadie solo."

~ subir_conexion(1)

->->

=== olla_virgen_guadalupe ===
// La imagen de la Virgen

Notás una imagen en la pared.
La Virgen de Guadalupe. Colores vivos. Flores dibujadas alrededor.

"La puso la Chola", dice Sofía sin que preguntes.

* [...]
-

"La trajo de un viaje a México. Decía que era la patrona de los pobres."

"¿Vos creés en eso?"

* [...]
-

Sofía se encoge de hombros.

"Creo en lo que funciona. Y esa imagen lleva ahí veinte años. La gente la mira cuando entra. Algunos rezan. Otros no. Pero todos la ven."

* [...]
-

Mirás la imagen.
Morena, con rayos dorados.
Parece vigilar todo.

{ixchel_me_conto_de_tomas:
    Pensás en Ixchel.
    Ella también tiene una estampita de la Virgen.
    La misma Virgen en dos continentes.
    La misma lucha.
}

->->

=== olla_grupo_whatsapp ===
// El grupo de WhatsApp

El celular de Sofía no para de sonar.

"El grupo", explica. "Ahí coordinamos todo."

"¿Cuántos son?"

"Ocho. Los que siempre estamos."

* [...]
-

"Diego avisa cuando consigue donaciones. Yo anoto quién trae qué. Las vecinas confirman si pueden venir."

"¿Y Elena?"

* [...]
-

Sofía se ríe.

"Elena no tiene WhatsApp. Dice que es 'para pendejos'. Yo le cuento todo."

"¿Y funciona?"

"Más o menos. A veces los mensajes se pierden. A veces la gente no lee. Pero es mejor que nada."

->->

// --- ECONOMÍA COLECTIVA ---

=== olla_sobre_donaciones ===
// Cómo funcionan las donaciones

"¿De dónde sale todo esto?", preguntás mirando las ollas, los cajones de verdura.

Sofía cuenta con los dedos.

"El Plan ABC de la Intendencia. Insumos básicos: arroz, fideos, aceite. Pero llega irregular."

* [...]
-

"Don Rubén, del almacén de la esquina. Nos da lo que está por vencer. Y a veces algo más."

"La verdulería de los paraguayos. Dejan cajones los viernes."

* [...]
-

"Vecinos que aportan. Desde cien pesos hasta dos mil. Todo va a una caja que administra Elena."

"¿Y vos?"

* [...]
-

Sofía duda.

"Yo pongo entre diez y quince mil por mes. Más cuando hay emergencias."

"Eso es mucho."

"Sí. Pero no alcanza para mantenerlo sola. Esto es colectivo o no es."

~ subir_conexion(1)

->->

=== olla_don_ruben ===
// El almacenero Don Rubén

Llega un hombre mayor cargando bolsas.

"Don Rubén", lo saluda Sofía. "Gracias."

"De nada, m'hija. Esto iba a la basura pero todavía está bueno."

* [...]
-

Don Rubén se va.

"Siempre nos ayuda", dice Sofía. "Desde el 2002."

"¿Por qué?"

* [...]
-

"Dice que él también estuvo en la cola cuando era chico. En otra olla, en otro barrio. Ahora le toca dar."

"Qué grande."

"Es el barrio. Así funciona. Los que pueden dan, los que necesitan reciben. Y a veces es lo mismo."

->->

=== olla_verduleria_paraguayos ===
// La verdulería de los paraguayos

Es viernes.
Llegan cajones de verdura.

"De la verdulería de los paraguayos", explica Diego. "Siempre los viernes."

* [...]
-

"¿Por qué ayudan?"

"Porque son de acá también. Aunque algunos no los vean así."

* [...]
-

Diego baja la voz.

"A veces los molestan. Les dicen cosas. Pero siguen viniendo, siguen donando."

"Qué hijos de puta los que los molestan."

"Sí. Pero ellos son más fuertes que eso."

~ subir_conexion(1)

->->

=== olla_plan_abc ===
// El Plan ABC de la Intendencia

Sofía revisa unas cajas.

"El Plan ABC llegó", anuncia.

"¿Qué es?"

* [...]
-

"El plan de la Intendencia de Montevideo. Nos dan insumos: arroz, fideos, aceite. A veces lentejas."

"¿Y alcanza?"

* [...]
-

Sofía se ríe sin gracia.

"Alcanza para un día y medio. Y llega una vez por mes. Cuando llega."

"¿Cómo que cuando llega?"

* [...]
-

"A veces se demoran. A veces falta algo. Una vez nos mandaron arroz para tres meses pero nada de aceite. ¿Qué hacés con arroz sin aceite?"

Suspira.

"Pero es algo. Más de lo que teníamos antes de 2020."

->->

=== olla_caja_elena ===
// La caja que administra Elena

Elena saca una caja de lata de debajo de la mesa.

"La caja", dice.

"¿Qué tiene?"

* [...]
-

"Los aportes de los vecinos. Los que pueden, ponen algo. Cien pesos, quinientos, lo que tengan."

Abre la caja. Billetes doblados, monedas, un papelito con anotaciones.

* [...]
-

"Todo se anota. Yo llevo la cuenta acá, Sofía tiene un backup en el celular."

"¿Y cuánto hay?"

Elena cuenta.

"Mil trescientos. Alcanza para una garrafa y algo de verdura."

* [...]
-

Cierra la caja.

"No es mucho. Pero es nuestro. Nadie nos lo regaló."

~ subir_conexion(1)

->->



// --- INCLUDES: PERSONAJES ---

## FILE: personajes/juan.ink

// ============================================
// PERSONAJE: JUAN
// Compañero de trabajo (Juan)
// ============================================

// --- ENCUENTRO EN EL LABURO ---

=== juan_saludo_manana ===

Juan está en el escritorio de al lado.
Compañero hace tres años.
El único con el que hablás de verdad acá.

{
- dia_actual == 1:
    -> juan_pregunta_piso4
- dia_actual == 2:
    Te mira.
    "¿Cómo dormiste?"
    "Mal."
    "Yo también."
}

->->

=== juan_pregunta_piso4 ===
"Che, ¿viste lo del piso 4?"

* ["¿Qué pasó?"] -> juan_rumor
* ["No, ¿qué?"] -> juan_rumor
* ["No quiero saber."] -> juan_ignorar

=== juan_rumor ===

Juan baja la voz.

"Echaron a tres. El viernes. Sin aviso."

"¿En serio?"

"Reestructuración, dijeron. Pero mirá..."

* [...]
-

Mira para los costados.

"Los de RRHH andan raros. Reuniones todo el tiempo. Algo pasa."

~ hable_con_juan_sobre_rumores = true

* ["¿Creés que nos toca?"] -> juan_preocupacion
* ["Siempre hay rumores."] -> juan_minimizar
* ["Hay que cuidarse."] -> juan_cuidarse

=== juan_ignorar ===

"Como quieras."

Juan vuelve a su pantalla.
Un poco ofendido.

~ juan_relacion -= 1

Mejor no saber.
O no.

->->

=== juan_preocupacion ===

"No sé. Espero que no. Pero..."

Se encoge de hombros.

"Yo tengo el alquiler, la cuota del auto... Si me echan, cago fuego."

"Yo también."

// Chequeo social: navegar la conversación delicada en el trabajo
# DADOS:CHEQUEO
~ temp resultado_juan_social = chequeo_completo_social(juan_relacion, 3)
{ resultado_juan_social == 2:
    -> juan_preocupacion_critico
}
{ resultado_juan_social == 1:
    -> juan_preocupacion_exito
}
{ resultado_juan_social == 0:
    -> juan_preocupacion_fallo
}
-> juan_preocupacion_crit_fallo

= juan_preocupacion_critico
* [...]
-

Un momento de honestidad. Raro en la oficina.
Los dos saben que son descartables.

Juan baja la voz aún más.

"Che, ¿sabés qué me dijo Martínez antes de que lo rajaran? Que vio una lista. Con nombres. En el escritorio de RRHH."

"¿Una lista?"

"No sé si es verdad. Pero si es así... tenemos que cuidarnos."

El dato queda. No sabés si es real.
Pero la confianza de Juan sí lo es.

~ juan_relacion += 2
~ subir_conexion(1)

"Bueno. A laburar. Que nos vean laburando."
->->

= juan_preocupacion_exito
* [...]
-

Un momento de honestidad.
Los dos saben que son descartables.
Que la "independencia" de la unipersonal era solo una forma de que la empresa se ahorre nuestros derechos.
Todos lo somos.

~ juan_relacion += 1

"Bueno. A laburar. Que nos vean laburando."
->->

= juan_preocupacion_fallo
* [...]
-

Juan mira para los costados. Nervioso.

"Mejor no hablar de esto acá."

Vuelve a su pantalla.
La conversación se cortó. Pero el miedo quedó.

"Bueno. A laburar."
->->

= juan_preocupacion_crit_fallo
* [...]
-

Juan se pone pálido.

"Pará, pará. ¿Vos creés que nos van a echar a todos?"

"No, no dije eso..."

"No, ya sé. Pero..."

Se levanta. Nervioso. Se va al baño.
Le metiste más miedo del que ya tenía.

~ bajar_salud_mental(1)
->->

=== juan_minimizar ===

"Siempre hay rumores, Juan. Todos los meses dicen que van a echar gente."

"Sí, pero esta vez..."

"Esta vez también. Tranqui."

Juan no parece convencido.
Vos tampoco.
Pero hay que seguir.

->->

=== juan_cuidarse ===

"Hay que cuidarse. No llegar tarde, no bardear, hacer lo que piden."

"¿Vos creés que eso alcanza?"

"No sé. Pero peor es no hacer nada."

Juan asiente.
Los dos saben que es mentira.
Cuando quieren echarte, te echan.
No importa lo que hagas.

->->

// --- ALMUERZO CON JUAN ---

=== juan_almuerzo ===

~ almorzamos_juntos = true
~ juan_relacion += 1

Bajan juntos.
El comedor de la empresa.

"¿Qué hay hoy?"

~ ultima_tirada = d6()
{ultima_tirada <= 3: "Guiso."|"Milanesa con puré."}

"Podría ser peor."

Se sientan.
Comen.

Juan habla de su novia, de las vacaciones que quieren hacer, del partido del domingo.
Cosas normales.
Cosas de gente normal.

* [...]
-

Por un rato, te olvidás de los rumores.

~ subir_conexion(1)

"Che, si pasa algo... digo, si alguno de los dos... nos avisamos, ¿no?"

"Obvio."

No saben qué más decir.
Pero el pacto está.

->->

// --- DESPUÉS DE LA REUNIÓN ---

=== juan_post_reunion ===

Juan se acerca.

"Esta semana va a ser jodida."

"Sí."

No hay más que decir.

* [Preguntarle si quiere ir al bar] -> juan_invitar_bar
* [Irte] ->->

=== juan_invitar_bar ===

"Che, Juan. ¿Vamos a tomar algo?"

~ ultima_tirada = d6()

{ultima_tirada >= 3:
    "Dale. Una cerveza no viene mal."
    -> juan_bar
- else:
    "No puedo, tengo cosas. Otro día."
    "Dale. Otro día."
    Se va.
    ->->
}

=== juan_bar ===

~ fue_al_bar_con_juan = true

Van al bar de la esquina.
Dos cervezas.

~ energia -= 1
~ juan_relacion += 1
~ subir_conexion(1)

"¿Vos qué harías si te echan?", pregunta Juan.

* ["No sé. Buscar otra cosa."]
"A veces siento que estoy corriendo en una cinta, uruguayo. Mis viejos se rompieron el lomo para sacarme del barrio, para que yo fuera 'alguien'. Y acá estoy, facturando como si fuera un empresario mientras rezo que no me corten la luz. Si nos echan, volvemos al mismo barro del que ellos quisieron sacarnos."

Se quedan en silencio.
La cerveza está fría, pero el miedo calienta el aire.
    -> juan_bar_fin
* ["Tengo algo de ahorros. Aguantaría unos meses."]
    "Yo no. Si me echan, cago fuego."
    "Algo aparece, Juan."
    "Ojalá."
    -> juan_bar_fin
* ["Hay otros laburos. Hay otras cosas."]
    Juan te mira.
    "¿Cómo qué?"
    "No sé. Pero el mundo no se acaba."
    No suena convincente. Pero es algo.
    -> juan_bar_fin

=== juan_bar_fin ===

Terminan las cervezas.
Se despiden.

"Nos vemos mañana."
"Nos vemos."

~ activar_tengo_tiempo()

->->

// --- PREGUNTAR A JUAN ---

=== juan_preguntar_sobre_jefe ===

"Che, Juan. ¿Viste cómo me miró el jefe?"

"Sí. Raro."

"¿Qué onda?"

"No sé. Pero a Martínez lo miró así el jueves antes de que lo citaran."

Eso no ayuda.

~ bajar_salud_mental(1)

->->

// --- DESPUÉS DEL DESPIDO ---

=== juan_enterarse_despido ===
// Cuando Juan se entera de que te echaron

~ juan_sabe_de_mi_despido = true

{juan_relacion >= 3:
    Juan te busca.
    "Che, me enteré. La puta madre."
    "Sí."
    "¿Estás bien?"
    "No sé."

    Te da un abrazo torpe.
    No sabe qué más hacer.
    Nadie sabe.

    "Si necesitás algo..."
    "Gracias."

    ~ subir_conexion(1)
- else:
    Juan te manda un mensaje.
    "Me enteré. Qué bajón."
    No respondés.
}

->->

=== juan_despues_despido ===
// Intentar contactar a Juan después de perder el laburo

{dia_actual <= 5:
    Llamás a Juan.

    ~ ultima_tirada = d6()

    {ultima_tirada >= 4:
        Contesta.
        "Hola. ¿Cómo andás?"
        "Ahí. ¿Y vos? ¿Cómo está todo?"
        "Igual. Raro sin vos acá."

        {juan_relacion >= 4:
            "Che, tendríamos que juntarnos. Un día de estos."
            "Dale. Avisame."
        }

        Cortás.
        El laburo sigue sin vos.
        La vida sigue sin vos.
        ->->
    - else:
        No contesta.
        Debe estar laburando.
        Obvio.
        ->->
    }
}

{dia_actual > 5:
    Pensás en llamar a Juan.
    Pero... ¿para qué?
    Ya no comparten nada.
    Solo compartían el laburo.

    ~ juan_estado = "distante"
    ->->
}

// --- FRAGMENTO NOCTURNO DE JUAN ---

=== juan_fragmento_noche ===

Juan no puede dormir.

Su novia ya duerme.

Él mira el techo.

{dia_actual == 1:
    Piensa en el laburo.
    En los despidos.
    En vos.

    Si lo echan a él, el alquiler se complica.
    La cuota del auto.
    Los planes con la novia.

    Todo armado sobre algo que puede desaparecer mañana.
}

{dia_actual == 2:
    Mañana la reunión.
    ¿A quién le tocará?
    ¿A vos? ¿A él?

    No puede dejar de pensar.
}

{dia_actual >= 3 && fui_despedido:
    Piensa en vos.
    En que te echaron.
    En que podría ser él mañana.

    {juan_relacion >= 4:
        Tendría que llamarte.
        Pero no sabe qué decir.
    }
}

"¿Estás bien?", pregunta ella sin abrir los ojos.

"Sí. Dormí."

Miente.
Todos mienten.

->->

// --- EL PASADO ENTERRADO DE JUAN ---

=== juan_recuerdo_marchas ===

~ juan_recuerdo_padre = true

Están hablando de la situación laboral.
Juan está más callado que de costumbre.

De pronto dice:

"Mi viejo me llevaba a las marchas."

"¿Qué marchas?"

* [...]
-

"Del PIT-CNT. Cuando era chico. Cinco, seis años. Me ponía arriba de los hombros para que viera."

"No sabía."

"No lo cuento nunca."

* [...]
-

Pausa larga.

"No sé por qué me acordé recién. Hace años que no pienso en eso."

"¿Y por qué dejaste de ir?"

* [...]
-

"No sé. Crecí. Empecé a laburar. El viejo se jubiló, se volvió amargo. Ya no hablamos de política."

"¿Y vos?"

"Yo... no sé. Supongo que me dio miedo terminar como él. Toda la vida peleando y al final solo, en un monoambiente, viendo las noticias para putearse."

* [...]
-

Silencio.

"A veces sueño con esas marchas. Con el ruido. Con mi viejo joven. Y me despierto confundido."

~ subir_conexion(1)
~ juan_relacion += 1

->->

=== juan_sobre_laura ===
// Escenas con Laura (la esposa)

~ juan_hablo_de_laura = true

"¿Cómo está Laura?"

Juan suspira.

"Bien. Ella siempre está bien. Es más tranquila que yo."

* [...]
-

"A veces me dice: 'Dejá de ver tantas noticias que te hacés mala sangre'. Tiene razón. Pero no puedo parar."

"¿Por qué?"

"Porque si no miro, siento que algo me va a agarrar desprevenido. Que me van a cagar y no me voy a dar cuenta."

* [...]
-

"Ella quiere tener hijos. Yo le digo que 'todavía no estamos listos económicamente'. Pero la verdad es que tengo miedo."

"¿De qué?"

"De traer un guri a este quilombo. De no poder darle nada. De terminar como mi viejo: prometiendo cosas que no podés cumplir."

* [...]
-

Pausa.

"Si me echan del laburo, ¿qué le digo? '¿Perdón, amor, se me terminó el curro y ahora somos pobres'?"

"No sos pobre, Juan."

"Todavía no."

~ subir_conexion(1)
~ juan_relacion += 1

->->

=== juan_fascinado_diego ===
// Juan fascinado por las historias de Diego

Están en la olla. Diego cuenta una historia.
Juan lo escucha con la boca abierta.

"Hermano, eso es de película. Las cooperativas, el camión quemado, la huida..."

Diego se encoge de hombros.

"Es mi vida, no más."

* [...]
-

Después, cuando Diego se va, Juan te dice:

"Ese tipo vivió más en veintiocho años que yo en treinta y dos."

"¿Te parece?"

* [...]
-

"A mí nunca me pasó nada. Nunca tuve que huir de nada. Nunca arriesgué nada."

"Eso no es malo."

"No sé. A veces siento que mi vida es... gris. Chica. Sin épica."

* [...]
-

Pausa.

"Y después viene uno como Diego, que perdió todo y sigue laburando, sigue ayudando. Y yo acá quejándome del alquiler."

No sabés qué decirle.
Pero algo se movió adentro suyo.

~ subir_conexion(1)

->->

=== juan_procesando ===
// El procesamiento lento de Juan
// Esta escena ocurre DESPUÉS de una conversación anterior

~ juan_proceso_algo = true

Una semana después de la charla.
Juan te manda un mensaje.

"Che, ¿podemos vernos un rato?"

* [Aceptar]

    Se encuentran.
    Juan trae café.
    
    "Estuve pensando en lo que dijo Diego el otro día."
    
    "¿Qué cosa?"
    
    * [...]
    -
    
    "Eso de que el problema no es el inmigrante, es el empresario que nos explota a los dos."
    
    "¿Y qué pensás?"
    
    * [...]
    -
    
    Juan toma café. Piensa.
    
    "Creo que tiene razón. O sea... yo siempre repetía lo que escuchaba en las noticias. 'Vienen a sacarnos el laburo'. Pero Diego labura el doble que yo y le pagan la mitad."
    
    * [...]
    -
    
    "Y el que nos paga poco a los dos es el mismo. No es Diego. Es el patrón."
    
    Pausa larga.
    
    "No sé. Capaz que soy un boludo y recién estoy entendiendo cosas que todo el mundo sabe."
    
    "No sos boludo. Estás pensando. Eso ya es algo."
    
    ~ subir_conexion(2)
    ~ juan_relacion += 1
    ->->

* [No poder]
    "No puedo ahora, Juan. Después."
    "Dale."
    
    No sabés qué quería decirte.
    Pero algo le quedó dando vueltas.
    ->->

=== juan_sobre_miedo ===
// Juan confronta su propio miedo

~ juan_hablo_de_miedo = true

"¿Sabés qué me pasa?"

"¿Qué?"

"Que tengo miedo de todo. De perder el laburo, de que me roben, de que las cosas se vayan al carajo. Y el miedo me hace decir cosas que después me arrepiento."

* [...]
-

"Como lo del 'acá falta autoridad'. O lo de 'los que vienen de afuera'. Cosas que repito sin pensar."

"¿Y por qué las decís?"

"Porque si le echo la culpa a alguien, me siento menos en banda. Como si supiera qué está pasando."

// Chequeo mental: ayudar a Juan a procesar su miedo
# DADOS:CHEQUEO
~ temp resultado_juan_miedo = chequeo_completo_mental(juan_relacion, 4)
{ resultado_juan_miedo == 2:
    -> juan_miedo_critico
}
{ resultado_juan_miedo == 1:
    -> juan_miedo_exito
}
{ resultado_juan_miedo == 0:
    -> juan_miedo_fallo
}
-> juan_miedo_crit_fallo

= juan_miedo_critico
* [...]
-

Silencio.

"Pero la verdad es que no sé nada. Solo tengo miedo y repito lo que dicen en la tele."

"Eso ya es darse cuenta de algo."

Juan te mira. Y por primera vez, dice algo que no esperabas:

"¿Sabés qué? Creo que mi viejo decía las mismas cosas. En las marchas, el enemigo era claro. Ahora todo es confuso. Y en la confusión, repetimos lo primero que escuchamos."

"Pero estás dejando de repetir."

"Sí. Capaz que sí."

~ subir_conexion(2)
~ juan_relacion += 2
->->

= juan_miedo_exito
* [...]
-

Silencio.

"Pero la verdad es que no sé nada. Solo tengo miedo y repito lo que dicen en la tele."

"Eso ya es darse cuenta de algo."

"Sí. Pero darse cuenta no alcanza. Hay que hacer algo. Y no sé qué."

~ subir_conexion(1)
~ juan_relacion += 1
->->

= juan_miedo_fallo
* [...]
-

Juan se queda callado.

"La verdad es que no sé nada."

No sabés qué decirle. El miedo es contagioso.
Y vos también tenés el tuyo.

"Somos dos boludos con miedo."

Se ríe. Vos también.
No resuelve nada. Pero alivia.

~ juan_relacion += 1
->->

= juan_miedo_crit_fallo
* [...]
-

Juan se pone más nervioso.

"¿Ves? Ni vos sabés qué decir. Nadie sabe."

El miedo se multiplica. Hablaron del tema y quedaron peor.
A veces abrir la caja de Pandora no ayuda.

"Mejor dejemos de hablar de esto."

~ bajar_salud_mental(1)
->->

// --- ENCUENTRO DEL VIERNES ---
// Hook: si tenés buena relación con Juan, te llama el viernes

=== juan_llamado_viernes ===
// Llamar solo si juan_relacion >= 4

El teléfono vibra.
Juan.

"Che, ¿estás? ¿Podemos vernos un rato?"

* ["Sí, dale. ¿Dónde?"]
    "En el bar de la otra vez. Media hora."
    -> juan_encuentro_viernes
* ["No puedo ahora."]
    "Dale, entiendo. Otro día."
    Cortás.
    Algo en su voz te quedó.
    ->->

=== juan_encuentro_viernes ===

~ energia -= 1

El bar de la esquina.
Mismo lugar que el lunes.
Parece hace mil años.

Juan ya está.
Pide dos cervezas antes de que te sientes.

Está raro.
Nervioso.
O algo.

"¿Todo bien?", preguntás.

{llama >= 5 || conexion >= 5:
    -> juan_noticia_buena
- else:
    -> juan_noticia_mala
}

=== juan_noticia_buena ===

Juan respira.

"Sí. Mirá, te quería contar algo."

Toma un trago.

* [...]
-

"Mi cuñado tiene un taller. Arregla electrodomésticos, esas cosas."

"¿Y?"

"Necesita alguien. No es fijo, son changas. Pero paga."

* [...]
-

Te mira.

"Pensé en vos. Si te interesa, le digo."

* ["Sí, pasale mi número."]
    ~ subir_conexion(1)
    ~ subir_dignidad(1)
    ~ juan_ofrecio_changa = true
    "Dale, le digo. Capaz te llama la semana que viene."

    No es un laburo.
    Es una posibilidad.
    Pero viniendo de Juan, significa algo.

    "Gracias, Juan."
    "Para eso estamos."
    -> juan_encuentro_fin

* ["Dejame pensarlo."]
    "Dale, sin presión. Avisame."

    No sabés si querés eso.
    Pero que Juan haya pensado en vos...

    ~ subir_conexion(1)
    -> juan_encuentro_fin

* ["No, gracias. Voy a buscar otra cosa."]
    "Como quieras."

    Juan parece un poco dolido.
    Pero entiende.

    -> juan_encuentro_fin

=== juan_noticia_mala ===

~ juan_tambien_despedido = true
~ juan_estado = "despedido"

Juan no te mira.
Toma un trago largo.

"A mí también me echaron."

Silencio.

* [...]
-

"¿Cuándo?"

"Ayer. Mismo discurso. Reestructuración."

Unipersonal también.
Sin nada.
Como vos.

* [...]
-

"La puta madre, Juan."

"Sí."

Se queda mirando la cerveza.

"Tres años. Facturando como si fuera mi propio jefe, mientras ellos ponían las reglas y se llevaban la tajada. Me vendieron la del emprendedor y me compraron como insumo."

* ["No sos pelotudo. Nos cagaron a todos."]
    ~ subir_conexion(2)
    ~ bajar_salud_mental(1)

    "Es el sistema, Juan. Así funciona."

    "Ya sé. Pero igual duele."

    Toman en silencio.
    Dos tipos sin laburo.
    Pero juntos en esto.

    -> juan_encuentro_fin

* ["¿Y ahora qué vas a hacer?"]
    ~ subir_conexion(1)
    ~ bajar_salud_mental(1)

    "No sé. Buscar. Lo que sea."

    "Si escucho algo, te aviso."

    "Gracias."

    Es raro.
    Antes él era el que tenía todo armado.
    Ahora están igual.

    -> juan_encuentro_fin

* [Quedarte callado]
    ~ bajar_salud_mental(1)

    No sabés qué decir.
    ¿Qué se dice?

    Toman en silencio.

    -> juan_encuentro_fin

=== juan_encuentro_fin ===

Terminan las cervezas.
No piden otra.

"Bueno. Nos vemos."

"Nos vemos, Juan."

Se dan un abrazo torpe.
De esos que no se daban antes.

{juan_relacion >= 4:
    ~ juan_relacion += 1
}

Volvés a casa.
Con algo más.
O algo menos.
Depende cómo lo mires.

->->

// --- JUAN EN JUEVES-DOMINGO ---

=== juan_encuentro_jueves ===
// Juan te encuentra despues del despido
# PORTRAIT:juan,worried,left

Te suena el celular. Es Juan.

"Che, ¿estás bien? Me enteré de lo del laburo."

* ["Sí, ahí ando."]
    "No me vendas humo. ¿Necesitás algo?"
    ~ juan_relacion += 1
    ~ juan_sabe_mi_situacion = true
    ->->
* ["¿Cómo te enteraste?"]
    "El laburo es chico, se sabe todo."
    ~ juan_sabe_mi_situacion = true
    ->->
* [No contestar]
    Dejás sonar. No es el momento.
    ->->

=== juan_charla_viernes ===
// Juan en viernes
# PORTRAIT:juan,friendly,left

{juan_sabe_mi_situacion:
    Juan te manda un mensaje:
    "Tengo un contacto que busca gente. No es gran cosa pero es algo. ¿Querés que le pase tu número?"

    * ["Dale, pasale."]
        "Listo. Te aviso si me dice algo."
        ~ juan_ofrecio_contacto = true
        ~ juan_relacion += 1
        ->->
    * ["Dejá, ya veo."]
        "Bueno, pero si cambiás de idea avisame."
        ->->
- else:
    Juan te manda un mensaje genérico del grupo del laburo.
    No sabés si decirle lo que pasó.
    ->->
}

=== juan_invitar_olla_sabado ===
// Invitar a Juan a la olla
# PORTRAIT:juan,neutral,left

{ayude_en_olla && juan_sabe_mi_situacion:
    "Che Juan, hay una olla popular en el barrio. ¿Querés venir?"

    * ["Hay buena gente."]
        Juan duda.
        "¿Olla popular? No sé..."
        "Vení una vez. Si no te copa, no venís más."
        "Bueno. Dale."
        ~ juan_fue_a_olla = true
        ~ juan_relacion += 1
        ->->
    * [No insistir]
        "Ta, dejá. Era una idea."
        ->->
- else:
    No tiene sentido invitarlo todavía.
    ->->
}

=== fragmento_juan_noche ===
// Fragmento nocturno de Juan

Juan llega a su casa.
Un dos ambientes en la periferia. Más lejos, más barato.

Abre la heladera. Hay poco.
Piensa en el laburo. En que capaz que es el próximo.
En que los rumores siempre se cumplen.

{juan_sabe_mi_situacion:
    Piensa en vos.
    "Ojalá esté bien", murmura.
}

Se acuesta con la tele prendida.
El noticiero habla de desempleo.
Cambia de canal.

->->

// --- FRAGMENTOS NOCTURNOS DE JUAN ---

=== fragmento_juan_cena ===
Juan calienta una lata de atún.

Pan. Atún. Tele.
La rutina de los que viven solos.

{juan_sabe_mi_situacion:
    Piensa en vos.
    En que no contestaste el mensaje.
    O sí contestaste pero cortito.

    "Ojalá esté bien."
}

Lava el plato. Uno solo.
Se acuesta.

->->

=== fragmento_juan_curriculum ===
Juan actualiza su currículum.

Por las dudas.
Siempre por las dudas.

Después de lo que te pasó a vos...
Mejor tener todo listo.

"Experiencia laboral: 8 años en el mismo puesto."
"Habilidades: Excel, Word, aguantar."

Cierra la compu. Mañana hay que ir.
Mientras haya donde ir.

->->


## FILE: personajes/sofia.ink

// ============================================
// PERSONAJE: SOFIA
// Madre soltera, maneja la olla popular
// Cansada pero luchadora
// ============================================

// --- ENCUENTRO CASUAL EN EL BARRIO ---

=== sofia_encuentro_casual ===

Sofía sale del almacén con dos bolsas pesadas.
Madre soltera. Dos hijos: Nico y Lupe.
Organiza la olla popular desde hace dos años.

Tiene ojeras. Siempre tiene ojeras.

* [Saludar] -> sofia_saludo
* [Ofrecerte a ayudar con las bolsas] -> sofia_ayudar_bolsas
* [Seguir de largo] -> sofia_ignorar

=== sofia_saludo ===

"Hola, Sofía."

Te mira. Una sonrisa cansada.

"Hola. ¿Cómo andás?"

{sofia_sabe_mi_situacion:
    No esperás la pregunta de siempre.
    Ella sabe. No pregunta.
    "Ahí vamos."
    "Ahí vamos todos."
- else:
    "Bien. ¿Y vos?"
    "En la lucha."
}

Sigue caminando. No tiene tiempo.
Nadie tiene tiempo.

->->

=== sofia_ayudar_bolsas ===

"Dejame ayudarte."

Agarrás una bolsa. Pesa.
Papas, fideos, aceite.

"Gracias. Las piernas ya no me dan."

~ sofia_relacion += 1

Caminan juntos hacia el salón comunal.

"¿Para cuántos cocinan hoy?"

"Sesenta y pico. Cada semana son más."

Sesenta personas que dependen de esto.
De ella.

"¿Y la plata alcanza?"

Se ríe. Sin gracia.

"Nunca alcanza. Pero se estira."

->->

=== sofia_ignorar ===

Seguís de largo.
Ella ni se da cuenta.
Tiene demasiado en la cabeza.

->->

// --- EN LA OLLA POPULAR ---

=== sofia_en_olla ===

El salón comunal huele a guiso.
Sofía revuelve una olla enorme.

Hay voluntarios. Pocos.
Elena pela papas. Nadie más.

"¿Necesitás ayuda?"

Sofía te mira. Evalúa.

* ["Puedo pelar, cortar, lo que sea."] -> sofia_aceptar_ayuda
* ["Solo pasaba a saludar."] -> sofia_solo_saludar

=== sofia_aceptar_ayuda ===

~ ayude_en_olla = true
~ sofia_relacion += 1

"Agarrá un cuchillo. Las zanahorias."

Trabajás en silencio.
El ruido de los cuchillos, el burbujeo de la olla.
Un ritmo.

// Chequeo físico: el trabajo en la olla es pesado
# DADOS:CHEQUEO
~ temp resultado_sofia_olla_fisico = chequeo_completo_fisico(1, 4)
{ resultado_sofia_olla_fisico == 2:
    Las manos se mueven solas. Encontrás el ritmo de la cocina.
    Sofía te mira de reojo. Impresionada.
    "Tenés mano para esto."
    ~ sofia_relacion += 1
    ~ subir_conexion(1)
}
{ resultado_sofia_olla_fisico == 1:
    Cortás, pelás, revolvés. El cuerpo responde.
    No es elegante, pero es trabajo honesto.
}
{ resultado_sofia_olla_fisico == 0:
    Te cansás rápido. Las manos no rinden.
    Sofía no dice nada. Pero te pasa las tareas más livianas.
    "Andá separando los platos."
}
{ resultado_sofia_olla_fisico == -1:
    Se te resbala el cuchillo. Casi te cortás.
    "¡Cuidado!" Sofía te frena la mano.
    "Despacio. La olla no tiene apuro."
    Te tiemblan las manos. El cuerpo no da más.
}

* [...]
-

Sofía habla mientras revuelve.

"Mi vieja ya revolvía esta misma olla en el 2002. Ella me enseñó que cuando el Estado se retira, el barrio tiene que avanzar. Vi los 'Centros Sociales' que prometieron volverse cáscaras vacías, llenas de carteles pero sin comida. Nosotros no tenemos carteles, pero tenemos fuego."

"¿Es agotador, no?"

"Agotador es esperar que alguien te salve. Cocinar es resistencia."

~ subir_conexion(1)
~ activar_hay_cosas_juntos()

* [...]
-

Llegan los primeros. Viejos, niños, familias enteras.
Caras conocidas del barrio.

Sofía sirve. Una sonrisa para cada uno.
Aunque esté muerta de cansancio.

->->

=== sofia_solo_saludar ===

"Ah. Bueno."

No hay reproche en su voz.
Solo cansancio.

"Cualquier cosa, acá estamos."

Volvés a la calle.
La olla sigue hirviendo.

->->

// --- CONVERSACION PROFUNDA ---

=== sofia_conversacion_profunda ===

~ hable_con_sofia_profundo = true

Es de noche. La olla terminó.
Sofía limpia. Sola.

"¿Te ayudo?"

"Ya casi termino."

* [...]
-

Pero aceptás un trapo igual.
Secan los platos juntos.

"¿Por qué hacés esto, Sofía?"

Se detiene. Piensa.

"Porque alguien tiene que hacerlo."

"Podrías no hacerlo. Cuidar a tus hijos y ya."

"Mis hijos comen de acá también."

Silencio.

"Cuando llegué al barrio, no tenía nada. Un bolso y los gurises.
Pero acá no me dieron limosna. Me dieron un lugar."

* [...]
-

"¿Y ahora vos salvás a otros?"

"No sé si salvo a nadie. Pero intento que nadie tenga que
pasar lo que pasé yo."

~ sofia_relacion += 1
~ subir_conexion(1)

* ["Sos muy fuerte."] -> sofia_respuesta_fuerte
* ["¿No te cansás?"] -> sofia_respuesta_cansancio
* ["¿Qué pasó cuando llegaste?"] -> sofia_historia

=== sofia_respuesta_fuerte ===

"No soy fuerte. Estoy cansada todo el tiempo.
Pero no tengo opción."

* [...]
-

Sigue secando.

"Los gurises dependen de mí. El barrio depende de esto.
Si yo paro, ¿quién sigue?"

No tiene respuesta. Nadie la tiene.

->->

=== sofia_respuesta_cansancio ===

"Todos los días."

Te mira. Ojos rojos.

"A veces quiero irme. Dejarlo todo.
Pero ¿adónde? ¿Con qué?"

"No tenés que hacerlo sola."

"No estoy sola. Pero a veces se siente así."

~ sofia_estado = "agotada"

->->

=== sofia_historia ===

"El padre de los gurises se fue. De un día para otro.
Me dejó con la ropa que teníamos puesta y deudas."

Aprieta el trapo.

* [...]
-

"Llegué al barrio porque una prima me prestó una pieza.
No conocía a nadie. No tenía trabajo."

"¿Y la olla?"

* [...]
-

"Elena me vio en la plaza. Yo estaba sentada, calculando cuánto me duraba la leche.
Se acercó y me dijo: 'Si tenés manos, servís'. Me trajo acá. Me dio un cuchillo."

Pausa.

"Ese día comimos. Pero lo importante fue que ese día cociné.
Dejé de esperar y empecé a hacer."

~ sofia_relacion += 1

->->

// --- HISTORIA PROFUNDA DE SOFÍA ---

=== sofia_sobre_madre ===
// La muerte de la Chola

~ sofia_hablo_de_madre = true

Es de noche. La olla está vacía.
Sofía mira la imagen de la Virgen de Guadalupe en la pared.

"La puso mi vieja. La Chola."

* [...]
-

"Ella empezó todo esto. En los 90. Dando merienda a los gurises en su casa. De a poco fue creciendo."

"¿Y vos?"

"Yo me fui. Conseguí beca, estudié afuera. Era la 'chica brillante' del barrio. La que 'salió'."

* [...]
-

Pausa. Sofía mira la imagen de la Virgen.

"Cuando mi vieja se enfermó, vine a 'ayudar seis meses'. Nunca volví a España."

"¿Por qué?"

* [...]
-

"Porque ella me tomó la mano en el hospital y me dijo: 'La olla no se apaga'. Y después me dijo otra cosa."

"¿Qué?"

"'No seas boluda, Sofía. La olla sos vos ahora. Pero no sola. Nunca sola'."

* [...]
-

Se le humedecen los ojos. No llora. Ya no llora por esto.

"Se murió tres semanas después. Y yo me quedé."

~ subir_conexion(1)
~ sofia_relacion += 1

->->

=== sofia_oferta_alemania ===
// La beca que rechazó

~ sofia_hablo_de_alemania = true

"¿Sabés qué me llegó hace unos meses?"

"¿Qué?"

"Un mail de mi ex director de tesis. Una beca postdoctoral en Heidelberg. Alemania. Condiciones excelentes."

* [...]
-

"¿En serio? ¿Y qué hiciste?"

"Le respondí que no en una semana."

"¿Por qué?"

* [...]
-

Sofía se ríe. Pero no es una risa alegre.

"Porque si me iba ahora, mi vieja me tiraba el mate desde el cielo."

* [...]
-

Pausa.

"A veces, en los congresos, veo a compañeros que siguieron la carrera 'en serio'. Publicando papers, viajando a conferencias. Y siento un poco de envidia."

"Es normal."

"Sí. Pero después me acuerdo de la risa de los gurises cuando hay postre en la olla. Y se me pasa."

* [...]
-

Hace una pausa más larga.

"Casi siempre se me pasa."

~ subir_conexion(1)
~ sofia_relacion += 1

->->

=== sofia_martin_papas ===
// El compañero de laboratorio pelando papas

~ sofia_hablo_de_martin = true

"¿Te conté de Martín?"

"¿Quién es Martín?"

"Un compañero del laboratorio. Especialista en química de alimentos."

* [...]
-

"Un invierno vino a la olla. 'A ver de qué se trata', dijo."

"¿Y?"

"Terminó pelando papas tres horas. Torpemente. Se manchó el jean entero."

* [...]
-

Sofía se ríe. Esta vez de verdad.

"En un momento dijo: 'Esto es más difícil que una cromatografía'. Y yo me reí por primera vez en semanas."

* [...]
-

"Ahora viene una vez por mes, cuando puede. No es mucho, pero ayuda."

"¿Y en la universidad no te miran raro por la olla?"

* [...]
-

"Al principio sí. '¿Olla popular? ¿Como en 2002?'. Pero con el tiempo varios entendieron."

Pausa.

"No es doble vida. Es vida integrada. Mis papers y mis papas."

~ subir_conexion(1)
~ sofia_relacion += 1

->->

=== sofia_catolicismo ===
// El catolicismo práctico

Notás la estampita de la Virgen de Guadalupe en el delantal de Sofía.

"¿Sos católica?"

"Sí. Como la Chola. No soy de ir a misa todos los domingos, pero rezo a veces."

* [...]
-

"Por eso les puse esos nombres a mis hijos. Nicolás y Guadalupe. Por ella."

Señala la imagen en la pared.

"Mi vieja la trajo de México cuando era joven. Decía que la Virgen de Guadalupe entiende a los pobres porque se apareció morena, hablándole a un indio."

* [...]
-

"No es una fe de discurso. Es una base silenciosa. Cuando no sé qué hacer, rezo. Y después sigo haciendo."

"¿Y funciona?"

"No sé si funciona. Pero me calma."

~ sofia_relacion += 1

->->

=== sofia_delantal_madre ===
// El delantal de la Chola

Notás que Sofía siempre usa el mismo delantal.
Viejo, manchado, remendado.

"Ese delantal..."

"Era de mi vieja."

* [...]
-

"No lo lavo. Bueno, lo lavo un poco. Pero no le saco las manchas viejas."

"¿Por qué?"

"Porque son sus manchas. Sus horas de cocina. Su trabajo."

* [...]
-

Se lo toca.

"A veces, cuando estoy muy quemada, me lo aprieto contra el pecho. Como si ella pudiera abrazarme."

No dice más.
No hace falta.

~ subir_conexion(1)
~ sofia_relacion += 1

->->

// --- SOFIA PIDE AYUDA ---

=== sofia_pide_ayuda ===

~ sofia_me_pidio_ayuda = true

Sofía te busca. Cosa rara.

"Che. Necesito pedirte algo."

"¿Qué pasa?"

* [...]
-

"La olla. No nos da. Tenemos deudas con el almacén.
Si no pagamos, no nos fían más."

"¿Cuánto es?"

"Tres mil pesos. Para ayer."

* [...]
-

Tres mil pesos.
No los tenés. O sí, pero son para el alquiler.

* [Ofrecer ayudar a conseguir donaciones] -> sofia_ayuda_donaciones
* [Dar lo que tenés] -> sofia_dar_plata
* [Decir que no podés] -> sofia_no_puedo

=== sofia_ayuda_donaciones ===

"Plata no tengo. Pero puedo ayudar a conseguir."

"¿Cómo?"

"No sé. Golpear puertas. Hablar con comercios.
Algo se me ocurre."

Sofía te mira. Evaluando.

// Chequeo social: convencer a Sofia de que podés ayudar
# DADOS:CHEQUEO
~ temp resultado_sofia_persuadir = chequeo_completo_social(sofia_relacion, 4)
{ resultado_sofia_persuadir == 2:
    Sofía te mira distinto. Algo en tu voz la convenció.
    "Sabés qué, sí. Necesito alguien que me ayude a hablar con los comercios de la zona. Tengo una lista."
    Te pasa un papel arrugado. Nombres, direcciones.
    "Juntos capaz que los convencemos."
    ~ sofia_relacion += 2
    ~ subir_conexion(1)
}
{ resultado_sofia_persuadir == 1:
    "Dale. Cualquier cosa sirve."
    ~ sofia_relacion += 1
}
{ resultado_sofia_persuadir == 0:
    "Mirá... no es por desconfiar. Pero ya vinieron otros con eso y después no aparecieron."
    "Yo voy a aparecer."
    "Bueno. Veremos."
    No te cierra la puerta. Pero tampoco la abre del todo.
}
{ resultado_sofia_persuadir == -1:
    "Mirá, te agradezco. Pero la verdad... no te conozco tanto."
    El rechazo duele. Pero Sofía no puede darse el lujo de confiar en cualquiera.
    Tiene sesenta bocas que dependen de ella.
    ~ bajar_conexion(1)
}

->->

=== sofia_dar_plata ===

Le das lo que tenés.
No son tres mil. Pero es algo.

"No puedo aceptar esto."

"Aceptalo. Después veo cómo hago."

* [...]
-

~ sofia_relacion += 2
~ subir_conexion(2)

Sofía no dice gracias.
Te abraza.
Fuerte.

->->

=== sofia_no_puedo ===

"No puedo, Sofía. Lo siento."

"Está bien. Entiendo."

No hay reproche. Solo resignación.
Ella sabe lo que es no poder.

->->

// --- FRAGMENTO NOCTURNO DE SOFIA ---

// --- TUNNELS PARA DIAS ---

=== sofia_primer_encuentro ===
// Tunnel: Primer encuentro del dia con Sofia
// Uso: -> sofia_primer_encuentro ->

Sofía te ve.

{conte_a_alguien && vinculo == "sofia":
    "Viniste."
    No es pregunta. Es confirmación.
- else:
    "¿Qué hacés acá a esta hora?"
}

->->

=== sofia_invitar_ayudar ===
// Tunnel: Sofia invita a ayudar
// Uso: -> sofia_invitar_ayudar ->

"Si querés ayudar, sobran cosas para hacer."

No es obligación.
Es invitación.

->->

=== sofia_agradecimiento ===
// Tunnel: Sofia agradece la ayuda
// Uso: -> sofia_agradecimiento ->

"Gracias", dice Sofía.
"Mañana si podés..."

Deja la frase ahí.
No es obligación. Es invitación.

->->

=== sofia_reunion_crisis ===
// Tunnel: Sofia en reunion por la crisis
// Uso: -> sofia_reunion_crisis ->

Sofía está hablando con otros.
La discusión es intensa pero en voz baja.

"No tenemos para hoy."
"Algo hay que hacer."
"¿Pedimos prestado?"
"¿A quién?"

->->

=== sofia_pedir_ideas ===
// Tunnel: Sofia pide ideas
// Uso: -> sofia_pedir_ideas ->

Sofía te hace una seña para que te acerques.
"Justo vos. Necesitamos ideas."

~ sofia_relacion += 1

->->

=== sofia_llamar ===
// Tunnel: Llamar a Sofia
// Uso: -> sofia_llamar ->

Llamás a Sofía.

"Hola."

"Hola. ¿Cómo estás?"

"Cansada. Pero bien. ¿Vos?"

"Igual. Cansado pero... no sé. Distinto."

->->

=== sofia_conversacion_telefono ===
// Tunnel: Conversacion telefonica con Sofia
// Uso: -> sofia_conversacion_telefono ->

Hablan un rato.
De la olla.
De la semana.
De vos.

"Gracias por ayudar esta semana. De verdad."

"Gracias por dejarme ayudar."

~ subir_conexion(1)

->->

=== sofia_fragmento_pensar ===
// Tunnel: Sofia pensando de noche
// Uso: -> sofia_fragmento_pensar ->

Piensa en pedir prestado.
Piensa en golpear puertas.
Piensa en cerrar.

No puede cerrar.
Hay gente que depende de esto.

{ayude_en_olla:
    Piensa en vos.
    En que viniste a ayudar.
    En que quizás no está sola.
}

->->

=== sofia_fragmento_asamblea ===
// Tunnel: Sofia despues de la asamblea
// Uso: -> sofia_fragmento_asamblea ->

Sofía cierra la olla.

La asamblea fue bien.
Mejor de lo esperado.

Hay gente nueva.
Gente que quiere ayudar.
Vos.

No es solución.
Pero es algo.

->->

// --- FRAGMENTO NOCTURNO ORIGINAL ---

=== sofia_fragmento_noche ===

Sofía mira a sus hijos dormir.
Nico y Lupe, dos cuerpos en un colchón y medio.

Lupe tiene tos.
Otra vez.
No hay plata para el médico.

{sofia_hijos_enfermos:
    Mañana va a tener que elegir.
    Remedios o comida.
    Siempre eligiendo.
}

Piensa en la olla.
En las sesenta bocas.
En el almacén que no les quiere fiar.

¿Cuánto más puede seguir?

Se acuesta. El colchón es duro.

Cierra los ojos.

{sofia_estado == "agotada":
    No puede dormir.
    Las cuentas dan vueltas en su cabeza.
    Los números nunca cierran.
}

{ayude_en_olla:
    Piensa en vos.
    Al menos hoy hubo una mano más.
    Al menos hoy no estuvo tan sola.
}

A las seis suena el despertador.
Otra vez.
Siempre otra vez.

->->

// --- FRAGMENTOS NOCTURNOS DE SOFIA ---

=== fragmento_sofia_cocina ===
Sofía lava los platos de la olla.
Sola. Los pibes duermen.

El agua corre. Las manos le duelen.
Pero la cocina queda limpia.

{sofia_relacion >= 3:
    Piensa en vos.
    "Ojalá venga mañana", murmura.
}

Mañana hay que cocinar de vuelta.
Siempre hay que cocinar de vuelta.

->->

=== fragmento_sofia_pibes ===
Los pibes de Sofía duermen.
Ella los mira desde la puerta.

El grande tiene un examen mañana.
El chico tose.

{olla_en_crisis:
    Si la olla cierra, no sabe qué van a comer.
    No lo dice. No hace falta.
    Los pibes no necesitan saber que el mundo se tambalea.
}

Les acomoda las frazadas.
Se acuesta sin cenar.

->->

=== fragmento_sofia_asamblea ===
{participe_asamblea:
    Sofía repasa la lista de la asamblea.
    Quién dijo qué. Quién se comprometió.
    Quién no vino.

    {sofia_relacion >= 4:
        Tu nombre está en la lista de los que vinieron.
        Sonríe.
    }

    Mañana hay que hacer lo que se dijo.
    No el lunes. Mañana.
- else:
    Sofía mira la lista vacía de voluntarios.
    Suspira.

    "¿Para qué hago asambleas si nadie viene?"
}

->->


## FILE: personajes/elena.ink

// ============================================
// PERSONAJE: ELENA
// Veterana del barrio, vivió la crisis del 2002
// Sabia, memoria del barrio
// ============================================

// --- ENCUENTRO CASUAL EN EL BARRIO ---

=== elena_conversacion ===
// Hub principal llamado desde los días
// Llamada: -> elena_conversacion ->

# PORTRAIT:elena,neutral,right

Elena está sentada en el banco de la plaza.
Siempre el mismo banco. Siempre la misma hora.

{elena_relacion == 0:
    Setenta y pico. Llegó al barrio antes que todos.
    Vio todo. Recuerda todo.
    Mira pasar a la gente como quien lee un libro viejo.
}

+ [Sentarte a su lado] -> elena_menu_temas
+ [Saludar de lejos] -> elena_saludo_lejos
+ [Pasar de largo] -> elena_ignorar

=== elena_menu_temas ===

Te sentás a su lado.
{elena_relacion > 2:
    "¿Cómo andás, m'hijo?"
    Su voz es ronca pero amable.
- else:
    No dice nada. No hace falta.
}

- (opts)
* [Charlar del día a día] -> elena_charla_cotidiana
+ [Preguntar sobre el barrio] -> elena_menu_historia
+ {elena_relacion >= 3} [Hablar de cosas serias] -> elena_menu_profundo
+ {elena_relacion >= 4} [Preguntar por la olla] -> elena_sobre_olla
+ [Me tengo que ir]
    "Andá, andá. Que no se te haga tarde."
    ->->

=== elena_charla_cotidiana ===
"Ahí andamos todos."
# PORTRAIT:elena,remembering,right
Mira hacia la calle.
"¿Sabés cuántas veces escuché eso? 'Ahí ando'.
En el 2002 todo el mundo andaba 'ahí'."
-> elena_menu_temas.opts

=== elena_menu_historia ===
+ [Sobre el 2002] {not elena_conto_trueque}
    -> elena_trueque_2002 ->
    -> elena_menu_historia
+ [Sobre el trueque] {elena_conto_trueque and not escuche_sobre_2002}
    -> elena_sobre_2002 ->
    -> elena_menu_historia
+ [Sobre el banco] {elena_conto_trueque and not elena_conto_banco}
    -> elena_en_banco_2002 ->
    -> elena_menu_historia
+ [Sobre los García] {not elena_conto_desalojo}
    -> elena_desalojo_garcia ->
    -> elena_menu_historia
+ [Volver] -> elena_menu_temas.opts

=== elena_menu_profundo ===
+ [Sobre la Chola] {not elena_hablo_de_chola}
    -> elena_sobre_la_chola ->
    -> elena_menu_profundo
+ [Sobre política] {not elena_hablo_politica}
    -> elena_anarquismo ->
    -> elena_menu_profundo
+ [Volver] -> elena_menu_temas.opts

=== elena_sobre_olla ===
+ [La historia de la fundación] {not escuche_historia_olla}
    -> olla_historia_fundacion ->
    -> elena_sobre_olla
+ [Volver] -> elena_menu_temas.opts

=== elena_sentarse ===

Te sentás a su lado.
No dice nada. No hace falta.

El sol de la tarde. Los gurises jugando.
Un momento de paz en el quilombo.

"¿Cómo andás, m'hijo?"

Su voz es ronca. Años de café fuerte y cigarros.

* ["Ahí ando, Elena."] -> elena_ahi_ando
* ["Mal. Todo mal."] -> elena_todo_mal
* ["¿Y vos, Elena?"] -> elena_ella_como

=== elena_ahi_ando ===

"Ahí andamos todos."
# PORTRAIT:elena,remembering,right

Mira hacia la calle.

"¿Sabés cuántas veces escuché eso? 'Ahí ando'.
En el 2002 todo el mundo andaba 'ahí'.
Pero seguíamos."

* [...]
-

~ elena_relacion += 1

Silencio.
El silencio de Elena nunca es incómodo.

->->

=== elena_todo_mal ===
# PORTRAIT:elena,wise,right

"Mal es relativo, m'hijo."

Te mira. Ojos que vieron demasiado.

"¿Tenés techo? ¿Comiste hoy?"

"Sí."

"Entonces no está todo mal. Está jodido, pero no todo mal."

Tiene razón. O no.
Pero su certeza ayuda.

~ elena_relacion += 1

->->

=== elena_ella_como ===

"Vieja. Cada día más vieja."

Se ríe.

"Pero acá sigo. Como el banco este. Como el barrio."

Pausa.

"Mientras pueda caminar hasta acá, voy a venir.
El día que no venga, preocupate."

->->

=== elena_saludo_lejos ===

Levantás la mano.
Ella asiente.

Un saludo de barrio.
Sin palabras. Sin necesidad.

->->

=== elena_ignorar ===

Pasás de largo.
Ella ni se inmuta.

Ha visto gente pasar toda su vida.
Una persona más no cambia nada.

->->

// --- EN LA OLLA POPULAR ---

=== elena_en_olla ===

Elena pela papas.
Las manos arrugadas, pero firmes.
Años de práctica.

"Vení, sentate. Agarrá un cuchillo."

No es una pregunta.

~ ayude_en_olla = true

Pelás papas en silencio.
Ella habla cuando quiere. Nunca antes.

"¿Sabés quién empezó esta olla?"

* ["¿Usted?"] -> elena_historia_olla
* ["No."] -> elena_historia_olla
* [Seguir pelando en silencio] -> elena_silencio

=== elena_historia_olla ===

~ elena_conto_historia = true

"Yo y otras tres. En el 2002."

Sigue pelando. No mira.

* [...]
-

"No teníamos nada. Pero teníamos bronca y teníamos manos.
Cocinábamos en la calle para que nos vieran. Para que supieran que no nos íbamos a morir en silencio."

"¿Cuántos venían?"

* [...]
-

"Al principio, veinte. Después cien. Después doscientos."

Pausa.

"Cuando el país se cae, la gente se junta.
Es lo único que tenemos."

~ escuche_sobre_2002 = true
~ subir_conexion(1)

->->

=== elena_silencio ===

El silencio se estira.
No incómodo. Compartido.

Las papas se acumulan.
El trabajo sigue.

->->

// --- CONVERSACION PROFUNDA ---

=== elena_conversacion_profunda ===

~ visite_elena_en_casa = true

La casa de Elena es chica.
Fotos en las paredes. Gente que ya no está.

"Sentate. Voy a hacer café en la prensa francesa."

* [...]
-

No aceptás un no.
Los viejos del barrio no aceptan un no.

El café llega. Negro. Fuerte.

"¿Qué te pasa, m'hijo? Te veo raro."

* [Contarle tu situación] -> elena_escucha
* ["Nada. Solo quería visitarla."] -> elena_no_cuenta
* [Preguntarle sobre el 2002] -> elena_sobre_2002

=== elena_escucha ===

Le contás. Todo.
El laburo. La plata. El miedo.

Ella escucha. No interrumpe.
Cuando terminás, toma café. Piensa.

// Chequeo social: lograr que Elena se abra sobre el pasado
# DADOS:CHEQUEO
~ temp resultado_elena_abrir = chequeo_completo_social(elena_relacion, 4)
{ resultado_elena_abrir == 2:
    -> elena_escucha_critico
}
{ resultado_elena_abrir == 1:
    -> elena_escucha_exito
}
{ resultado_elena_abrir == 0:
    -> elena_escucha_fallo
}
-> elena_escucha_crit_fallo

= elena_escucha_critico
* [...]
-

Elena deja la taza. Te mira con ojos que vieron demasiado.

"¿Sabés qué aprendí en setenta años?"

"¿Qué?"

"Que nadie se salva solo. Lo aprendí a los golpes.
Cuando el barco se hunde, o armamos una balsa entre todos o nos ahogamos por separado."

* [...]
-

Hace una pausa larga. Algo se abre en ella.

"Raúl pasó lo mismo que vos. Exactamente. Lo echaron del frigorífico un martes. Llegó a casa blanco. No habló en tres días."

"¿Qué hicieron?"

"Lo que vamos a hacer con vos. Sostenerlo. Un día a la vez."

~ elena_me_aconsejo = true
~ elena_relacion += 2
~ subir_conexion(2)
~ activar_red_o_nada()

"Y vení a la olla. Siempre hay un plato."
->->

= elena_escucha_exito
* [...]
-

"¿Sabés qué aprendí en setenta años?"

"¿Qué?"

"Que nadie se salva solo. Lo aprendí a los golpes.
Cuando el barco se hunde, o armamos una balsa entre todos o nos ahogamos por separado."

* [...]
-

"¿Y qué hago?"

"Lo que puedas. Un día a la vez.
No pensés en mañana. Pensá en hoy."

~ elena_me_aconsejo = true
~ elena_relacion += 1
~ subir_conexion(1)
~ activar_red_o_nada()

"Y vení a la olla. Siempre hay un plato."
->->

= elena_escucha_fallo
* [...]
-

Elena asiente. Despacio.

"Es jodido. Lo sé."

No dice mucho más. Toma café.
El silencio se estira.

"Vení a la olla si querés. Siempre hay un plato."

No se abrió del todo. Pero la puerta quedó entreabierta.

~ elena_relacion += 1
->->

= elena_escucha_crit_fallo
* [...]
-

Elena se queda callada. Demasiado callada.

"M'hijo... todos tenemos problemas."

Algo se cerró. Quizás no era el momento.
Quizás hablar de tus problemas le trajo fantasmas de los suyos.

Toman café en un silencio incómodo.

"Disculpá. Estoy cansada hoy."
->->

=== elena_no_cuenta ===

"Mentira. Pero está bien. Cuando quieras hablar, acá estoy."

Toman café.
No hace falta hablar.
A veces la compañía alcanza.

~ elena_relacion += 1

->->

=== elena_sobre_2002 ===

~ escuche_sobre_2002 = true

"El 2002. La crisis."

Suspira. Los ojos se van lejos.

* [...]
-

"Fue peor que esto. Mucho peor.
La gente no tenía para comer. Literal.
Los bancos cerrados. Todo cerrado."

"¿Cómo sobrevivieron?"

"Organizándonos. No esperando.
Entendiendo que la vergüenza es de ellos, no nuestra."

* [...]
-

Toma café.

"Las ollas no eran caridad. Eran trincheras.
El trueque, las asambleas... eran formas de decir 'acá estamos y no nos vamos'."

"¿Y después?"

"Después volvió todo. El país se acomodó para los que siempre están bien. Los políticos se votaron sus propios aumentos y nos dijeron que la 'crisis había pasado'. Pero la crisis no pasa para el que perdió la casa o el que se le rompió la familia. Nosotros nos quedamos acá, sosteniendo los pedazos que ellos tiraron por la ventana."

~ elena_relacion += 1
~ subir_conexion(1)

->->

// --- LA CHOLA Y ELENA ---

=== elena_sobre_la_chola ===

~ elena_hablo_de_chola = true

"¿La Chola? ¿La mamá de Sofía?"

Elena sonríe. Es la primera vez que la ves sonreír así.

"La Chola era mi hermana. No de sangre. De vida."

* [...]
-

"Nos conocimos en la fábrica textil del Cerro. Año 75. Yo tenía veinticinco, ella veintitrés. Turnos de diez horas cosiendo zapatos."

"¿Y?"

"Y nada. Trabajábamos, tomábamos mate, puteábamos al capataz. Pero cuando vino la dictadura, nos juntamos de verdad."

* [...]
-

"Éramos compañeras de fábrica, de huelga, de mate y de velorio."

* ["¿De velorio?"]
    "Enterramos a mucha gente juntas. Compañeros que se llevaron. Algunos que aparecieron. Otros que no."
    
    Silencio largo.
    
    "Pero seguíamos. Siempre seguíamos."
    -> elena_chola_cont

* ["¿Cuarenta años juntas?"]
    "Más. Nos vimos envejecer. Nos vimos enterrar maridos. Nos vimos criar hijos. Y cuando ella se enfermó..."
    -> elena_chola_cont

=== elena_chola_cont ===

* [...]
-

"Cuando la Chola se enfermó, estuve con ella hasta el final. En el hospital, tomándole la mano."

"¿Qué le dijiste?"

"Que iba a cuidar la olla. Y que iba a cuidar a Sofía."

* [...]
-

Pausa larga.

"A veces le hablo todavía. A la foto que tengo en el aparador. Le cuento cómo está la olla. Le puteo cuando las cosas no salen."

Se ríe bajito.

"Ella me escucha. Estoy segura."

~ subir_conexion(1)
~ elena_relacion += 1

->->

=== elena_desalojo_garcia ===
// El desalojo de los García en los 90

~ elena_conto_desalojo = true

"¿Vos conociste a los García? Los que vivían en la esquina."

"No."

"Ya no están. Pero casi los sacan antes de tiempo."

* [...]
-

"Fue en el 98, creo. O 97. La mujer se había quedado sin laburo, el marido estaba enfermo. Debían tres meses de alquiler."

"¿Los iban a desalojar?"

"Vino la policía con el acta. A sacarlos a la calle. Con los gurises."

* [...]
-

Elena se toma el mate.

"Yo me enteré por la vecina de enfrente. Salí corriendo. Llamé a la Chola, a otras cuantas."

"¿Y qué hicieron?"

* [...]
-

"Nos paramos en la puerta. Yo adelante, con el mate en la mano y la mirada de alguien que no tiene nada que perder."

"¿Y la policía?"

"El oficial me dijo: 'Señora, apártese o la llevamos'. Yo le dije: 'Llevame entonces. Pero vas a tener que llevar a todas'."

* [...]
-

Sonríe. Una sonrisa feroz.

"Detrás mío había veinte mujeres del barrio. Y un par de tipos también, pero las que paraban la olla éramos nosotras."

"¿Funcionó?"

"El milico llamó por radio. No sé qué le dijeron. Pero se fueron. Los García se quedaron tres meses más, hasta que consiguieron otro lugar."

* [...]
-

Pausa.

"La propiedad privada se termina donde empieza el frío de un guri. Eso no lo escribió ningún filósofo. Eso lo aprendí ese día."

~ subir_dignidad(1)
~ elena_relacion += 1

->->

=== elena_trueque_2002 ===
// Detalle del trueque en 2002

~ elena_conto_trueque = true

"¿Sabés lo que es el trueque?"

"Más o menos. Cambiar cosas, ¿no?"

"Cambiar lo que tenés por lo que necesitás. Sin plata. Porque la plata no servía para nada."

* [...]
-

"En el 2002, once intendencias aceptaron trueque. Hasta pagaban impuestos con carne. ¿Te imaginás? Yendo a la intendencia con un pedazo de carne para pagar la patente."

"No me lo imagino."

* [...]
-

"Nosotras organizamos trueque acá en el barrio. En el gimnasio de la parroquia."

"¿Cómo funcionaba?"

"Cada uno llevaba lo que tenía. Ropa vieja, herramientas, comida casera, verduras del fondo. Y cambiaba por lo que necesitaba."

* [...]
-

Elena mira hacia la pared. La foto de su marido.

"Yo cambié la ropa de mi marido muerto por leche en polvo para los nietos de una vecina."

* [...]
-

"Recuerdo el olor de ese gimnasio. Humedad, desesperación... y solidaridad. Todo mezclado."

"¿Funcionó?"

"Funcionó hasta que la cosa se acomodó. Después todos fingimos que no había pasado. Pero yo me acuerdo. Yo siempre me acuerdo."

~ subir_conexion(1)
~ elena_relacion += 1

->->

=== elena_en_banco_2002 ===
// Escena del banco en 2002

~ elena_conto_banco = true

"Un día fui al Banco República a sacar mis ahorros. Cuarenta mil pesos. Todo lo que tenía."

"¿Y?"

"Me dijeron que no había efectivo. 'Vuelva mañana'. Volví al otro día. Lo mismo. 'Vuelva la semana que viene'."

* [...]
-

"Un viernes volví con la Chola y otras diez vecinas. No llevábamos martillos, pero sí la mirada de quien no tiene nada que perder."

"¿Y qué hicieron?"

* [...]
-

"Nos plantamos en el hall. No gritamos. No rompimos nada. Solo nos sentamos y nos quedamos mirando."

"¿Y?"

"El gerente llamó a un teléfono. Media hora después apareció el efectivo."

* [...]
-

Sonríe con satisfacción.

"A veces pararse es suficiente. Pero hay que saber pararse. Y hay que saber con quién."

~ subir_dignidad(1)
~ elena_relacion += 1

->->

=== elena_anarquismo ===
// El anarquismo visceral explícito

~ elena_hablo_politica = true

"Elena, ¿vos sos de algún partido?"

Se ríe con ganas.

"¿Partido? M'hijo, yo estuve en todos y en ninguno."

* [...]
-

"En los 70 estuve cerca del sindicato. Después de lo de la fábrica, me junté con los de la barriada. Después de la dictadura, voté al Frente algunas veces."

"Pero..."

"Pero aprendí que el de arriba siempre caga al de abajo. No importa el color de la bandera."

* [...]
-

Te mira fijo.

"Yo no soy anarquista de libro, m'hijo. Nunca leí a Bakunin. Pero sé una cosa: cada vez que alguien se pone por encima de otros, termina pisándolos."

"¿Entonces?"

* [...]
-

"Entonces la única defensa real es el compañero de al lado. No el partido. No el sindicato. No el Estado. El compañero."

* [...]
-

Hace una pausa.

"Los hombres hablan y miden quién la tiene más larga. Nosotras paramos la olla para que los gurises no se mueran. Esa es mi política."

~ subir_conexion(1)
~ elena_relacion += 1

->->

=== elena_frase_trinchera ===
// Tunnel: La olla como trinchera

Elena dice, mirando la olla:

"Esto no es caridad, m'hijo. Esto es trinchera."

Lo dice como quien dice una verdad eterna.

->->

// --- ELENA PREOCUPADA ---

=== elena_preocupada_olla_knot ===
# PORTRAIT:elena,worried,right

~ elena_preocupada_olla = true

Elena te busca. Cosa rara.
Ella nunca busca a nadie.

"Che. Necesito hablar."

"¿Qué pasa?"

* [...]
-

"La olla. Sofía está quemada.
Si ella cae, cae todo."

Te mira. Seria.

"Hay que ayudarla. Pero ella no pide."

"¿Qué puedo hacer?"

"Estar. Aparecer. Hacer lo que puedas.
A veces eso alcanza."

* ["Voy a ayudar."] -> elena_acepto_ayudar
* ["No sé si puedo."] -> elena_no_puedo_ayudar

=== elena_acepto_ayudar ===

"Bien."

No dice gracias. No hace falta.

// Chequeo mental: procesar la gravedad de la situación de la olla
# DADOS:CHEQUEO
~ temp resultado_elena_olla_futuro = chequeo_completo_mental(elena_relacion, 4)
{ resultado_elena_olla_futuro == 2:
    "Sofía es terca. Como yo.
    Pero necesita gente."

    Elena te mira fijo. Algo cambia en su cara.

    "¿Sabés qué, m'hijo? Vos me hacés acordar a cuando empezamos en el 2002. La misma cara de asustado. Pero estás acá. Y eso es lo que importa."

    "Vamos a sacar esto adelante. Como sacamos todo."

    ~ elena_relacion += 2
    ~ subir_llama(1)
}
{ resultado_elena_olla_futuro == 1:
    "Sofía es terca. Como yo.
    Pero necesita gente."

    ~ elena_relacion += 1
}
{ resultado_elena_olla_futuro == 0:
    "Sofía es terca. Como yo.
    Pero necesita gente."

    Se te hace un nudo en el estómago.
    La gravedad de la situación te cae encima.
    ¿Puede cerrar la olla? ¿Qué pasa con las sesenta personas?

    ~ elena_relacion += 1
}
{ resultado_elena_olla_futuro == -1:
    "Sofía es terca. Como yo."

    Elena te mira. Ve algo en tus ojos.
    Miedo. Parálisis.

    "No te congeles, m'hijo. Congelarse es lo peor."

    Pero ya estás congelado.
    La responsabilidad te aplasta.

    ~ bajar_salud_mental(1)
}

->->

=== elena_no_puedo_ayudar ===

"Nadie puede mucho. Pero todos pueden algo."

No hay reproche. Solo verdad.

"Pensalo."

Se va.
Las palabras quedan.

->->

// --- ELENA CUENTA SOBRE EL PASADO DEL BARRIO ---

=== elena_memoria_barrio ===

"¿Ves esa casa? Ahí vivía Don Ramón.
Carpintero. Hizo la mitad de los muebles del barrio."

"¿Qué le pasó?"

* [...]
-

"Se murió en el 2003. El corazón.
La crisis lo mató. Como a muchos."

Señala otra casa.

* [...]
-

"Ahí vivían los Fernández. Cinco hijos.
Se fueron a España en el 2002. Nunca volvieron."

El barrio es un cementerio de historias.
Elena es la única que las recuerda.

"¿Por qué me cuenta esto?"

"Porque alguien tiene que saber.
Cuando yo me vaya, ¿quién va a recordar?"

~ elena_relacion += 1
~ subir_conexion(1)

->->

// --- TUNNELS PARA DIAS ---

=== elena_en_casa ===
// Tunnel: Encuentro en casa de Elena
// Uso: -> elena_en_casa ->

~ subir_conexion(1)

Elena está en su casa.
Te hace pasar.

"¿Cómo estás?"

"No sé."

Ella asiente.
Pone la pava.

->->

=== elena_historia_2002 ===
// Tunnel: Elena cuenta del 2002
// Uso: -> elena_historia_2002 ->

"En el 2002, Raúl estuvo tres meses sin laburo. La olla nos salvó ese invierno."

No sabías eso.

"No te vas a morir. Pero va a ser duro. Y vas a necesitar gente."

->->

=== elena_hablar_barrio ===
// Tunnel: Elena habla del barrio
// Uso: -> elena_hablar_barrio ->

Elena habla del barrio, de antes.
De cómo la gente se ayudaba.

"Ahora cuesta más. Pero sigue pasando."

->->

=== elena_consejo ===
// Tunnel: Elena da un consejo
// Uso: -> elena_consejo ->

Elena habla:

"En el 2002 estuvimos peor. Y acá seguimos. La pregunta no es si vamos a seguir. Es cómo."

->->

=== elena_canastas ===
// Tunnel: Elena habla de las canastas
// Uso: -> elena_canastas ->

Elena habla:
"En el 2002 hacíamos canastas. Cada uno ponía lo que podía. Nadie daba mucho pero entre todos..."

Sofía asiente.
"Podemos probar."

~ activar_hay_cosas_juntos()

->->

=== elena_pedir ===
// Tunnel: Elena sabe pedir
// Uso: -> elena_pedir ->
Elena sabe cómo gestionar recursos.
No es mendigar.
Es sostener la red.
Es distinto.

"En el 2002 hacíamos esto todo el tiempo. Te acostumbrás."

->->

=== elena_llamar ===
// Tunnel: Llamar a Elena
// Uso: -> elena_llamar ->

Llamás a Elena.

"Hola, m'hijo."

Siempre te dice así.
Como si fueras de la familia.

"¿Cómo estás, Elena?"

"Acá. Como siempre. ¿Y vos? ¿Cómo llevás la semana?"

"Raro. Todo raro."

"Es normal. Dale tiempo."

->->

=== elena_conversacion_telefono ===
// Tunnel: Conversacion telefonica con Elena
// Uso: -> elena_conversacion_telefono ->

Hablan de cosas.
Ella te cuenta del barrio.
De antes.
De ahora.

"Vos vas a estar bien. Sos de los que se bancan."

No sabés si es verdad.
Pero ayuda escucharlo.

~ subir_conexion(1)

->->

// --- FRAGMENTO NOCTURNO DE ELENA ---

=== elena_fragmento_noche ===

Elena no duerme mucho.
Los viejos no duermen.

Se sienta en la cocina.
Café recalentado. Radio bajita. Las voces de siempre.

{escuche_sobre_2002:
    Piensa en el 2002.
    En los que no sobrevivieron.
    En los que se fueron.
    En los que quedaron.
}

Mira las fotos de la pared.
Su marido. Muerto hace quince años.
Sus hijos. Uno en Buenos Aires. Otro en España.
No vienen nunca.

{elena_preocupada_olla:
    Piensa en Sofía.
    En la olla.
    En que la historia se repite.

    Ella ya no tiene fuerzas para cargar todo.
    Pero puede sostener un poco.
}

La radio habla de economía.
Números que no entiende.
Palabras que ya escuchó antes.

"Otra vez", murmura.
"Siempre otra vez."

{elena_relacion >= 4:
    Piensa en vos.
    En que hay gente nueva que entiende.
    En que tal vez el barrio sobreviva.
}

A las cuatro se acuesta.
El sueño de los viejos.
Liviano. Interrumpido.
Lleno de fantasmas.

->->

// --- FRAGMENTOS NOCTURNOS DE ELENA ---

=== fragmento_elena_banco ===
Elena está en su casa.
La tele prendida. El mate frío.

Mira la foto de Raúl en la repisa.
"Vos me entenderías", le dice.

En el 2002 estaban todos en la calle.
Ahora cada uno en su casa.
Con su pantalla. Con su soledad.

Se acuesta.
El banco de la plaza la espera mañana.

->->

=== fragmento_elena_recuerdo ===
Elena no puede dormir.

Piensa en la olla de 2002.
En cómo empezó con tres ollas y un fogón.
En cómo terminaron siendo cincuenta.

{elena_relacion >= 3:
    Piensa en vos.
    "Tiene algo", se dice. "Algo de los de antes."
}

Se da vuelta en la cama.
El insomnio de los setenta es diferente.
No es ansiedad. Es inventario.

->->

=== fragmento_elena_cartas ===
Elena relee una carta vieja.
De su hermana en Buenos Aires.

"Venite, Elena. Acá hay trabajo."
La carta es de 2003.

Nunca se fue.
El barrio la necesitaba.
O ella necesitaba al barrio.
Da igual.

Guarda la carta. Apaga la luz.

->->


## FILE: personajes/diego.ink

// ============================================
// PERSONAJE: DIEGO
// Venezolano, llegó hace poco
// Trabaja en depósito, situación precaria
// ============================================

// --- ENCUENTRO CASUAL EN EL BARRIO ---

=== diego_encuentro_casual ===

Diego camina rápido.
Siempre camina rápido.

Venezolano. Llegó hace ocho meses.
Trabaja en el depósito de la zona industrial.
Turnos de doce horas. Pago en negro.

Tiene la mirada de los que no pueden parar.

* [Saludar] -> diego_saludo
* [Preguntarle cómo le va] -> diego_como_va
* [Seguir caminando] -> diego_ignorar

=== diego_saludo ===

"Hey, Diego."

Se frena. Sorprendido.
No mucha gente le habla.

"Hola, ¿cómo estás?"

El acento. Suave pero presente.

"Bien. ¿Y vos? ¿El laburo?"

"Ahí. Cansado, pero bien."

Siempre dice que está bien.
Aunque no esté.

->->

=== diego_como_va ===

"Diego. ¿Cómo te va?"

Se detiene. Piensa.

"Bien... bueno, más o menos."

Mira para los lados. Como si alguien pudiera escuchar.

"El trabajo está raro. Nos quieren tratar como piezas de repuesto. Pero ya vi venir esto antes."

"¿Te preocupa?"

"Preocuparse es perder el tiempo. Hay que moverse. La red sostiene, hermano, pero uno tiene que ser parte del nudo."

~ diego_relacion += 1

->->

=== diego_ignorar ===

Diego sigue caminando.
No nota que pasaste.
O finge no notar.

Cada uno con sus problemas.

->->

// --- EN EL BARRIO ---

=== diego_encuentro_barrio ===
// Tunnel: Encuentro casual en el barrio

~ subir_conexion(1)

Encontrás a Diego.
Está saliendo del depósito.

"¿Qué hacés acá? ¿No laburabas?"

->->

=== diego_caminar_juntos ===
// Tunnel: Caminar juntos

~ energia -= 1
~ subir_conexion(1)

Caminan.
Hablan de boludeces.
Por un rato, casi te olvidás.

->->

// --- EN LA OLLA POPULAR ---

=== diego_en_olla ===

Diego está descargando cajones.
Camisa arremangada. Transpirado.
Se mueve rápido, como siempre.

~ diego_viene_a_olla = true

"No sabía que venías acá."

"Vengo a dar una mano. Los domingos no trabajo y...
bueno, hay que hacer algo."

* ["Qué grande, Diego."] -> diego_tranquilizar
* ["¿Te tratan bien?"] -> diego_pregunta_situacion
* [Asentir y seguir] -> diego_no_presionar

=== diego_tranquilizar ===

"Qué grande, Diego. Hace falta gente."

Sonríe. Se seca la frente.

"En Venezuela yo organizaba los operativos de comida en Petare. Sé cómo es la logística cuando no hay nada. Acá les faltaba alguien que supiera estirar los recursos."

"Siempre falta gente."

"Falta organización. Brazos sobran, lo que falta es saber hacia dónde empujarlos."

Te hace una seña. Hay cajones para descargar.

// Chequeo físico: trabajar a la par de Diego
# DADOS:CHEQUEO
~ temp resultado_diego_fisico = chequeo_completo_fisico(1, 4)
{ resultado_diego_fisico == 2:
    Agarrás un cajón de papas. Pesado. Lo cargás sin parar.
    Diego te mira con respeto.
    "Sos fuerte, hermano. Si todos empujaran así..."
    Trabajan juntos. A la par. Sin hablar.
    El trabajo dice lo que las palabras no.
    ~ diego_relacion += 2
    ~ subir_conexion(1)
}
{ resultado_diego_fisico == 1:
    Ayudás a cargar. Cuesta, pero se puede.
    Diego asiente. Trabajan juntos.
    ~ diego_relacion += 1
}
{ resultado_diego_fisico == 0:
    Intentás cargar un cajón. Es más pesado de lo que parece.
    Diego agarra el otro lado sin decir nada.
    "Entre los dos es más fácil."
    No es debilidad. Es equipo.
    ~ diego_relacion += 1
}
{ resultado_diego_fisico == -1:
    Agarrás un cajón. Se te resbala.
    Las papas se desparraman por el piso.
    "Tranquilo, tranquilo." Diego se agacha a juntar.
    Te agachás con él. Rojo de vergüenza.
    "A todos nos pasa. Las papas son traicioneras."
    Sonríe. No te juzga.
}

Sofía le pasa una botella de agua.
Él sigue cargando cosas.
No para.

->->

=== diego_pregunta_situacion ===

"¿Está muy jodido?"

Baja la voz.

"El mes pasado no pude mandar plata a mi familia.
Primer mes en ocho que no mando."

~ diego_familia_en_venezuela = true

* [...]
-

Su mamá. Su hermana. Allá.
Esperando.

"Lo siento, Diego."

"Está bien. Voy a poder. Siempre se puede.
Tengo unos panas que venden comida. Capaz me sumo."

Ya está pensando en la siguiente jugada.
No se queda quieto. No puede.

~ diego_relacion += 1

->->

=== diego_no_presionar ===

Asentís. Seguís.
Diego sigue laburando.
Carga dos bolsa de papa como si fueran plumas.
La fuerza de la costumbre.

->->

=== diego_colecta ===
// Tunnel: Diego en la colecta

Vas con Diego y otra persona.
Recorren la zona.

"Para la olla del barrio. Lo que pueda."

Diego sabe hacer esto.
No tiene vergüenza.
O la esconde bien.

->->

// --- CONVERSACION PROFUNDA ---

=== diego_conversacion_profunda ===

~ hable_con_diego_profundo = true

Es de noche. Diego fuma en la esquina.
Único momento de descanso.

"¿Puedo?"

Te hace lugar.

"¿Fumás?"

"No. Solo... quería hablar."

Silencio.

"¿De qué?"

* ["De vos. ¿Cómo llegaste acá?"] -> diego_historia
* ["De la situación. ¿Cómo la ves?"] -> diego_opinion
* ["De nada. Solo compañía."] -> diego_compania

=== diego_historia ===

Diego mira el cigarrillo.

// Chequeo social: lograr que Diego confíe lo suficiente para contar su historia
# DADOS:CHEQUEO
~ temp resultado_diego_confianza = chequeo_completo_social(diego_relacion, 4)
{ resultado_diego_confianza == 2:
    ~ diego_me_conto_historia = true

    Diego te mira. Algo se abre.

    "En Caracas, antes de venirme, yo creía. De verdad creía. Estuve en una cooperativa agrícola en el llano. Metíamos las manos en la tierra pensando que por fin era nuestra, que el socialismo de abajo iba a funcionar."

    "¿Y qué pasó?"

    "Pasó que la revolución tiene muchos estómagos y pocas manos. La corrupción se comió las semillas, y el autoritarismo se comió a los que preguntábamos dónde estaba el fertilizante."

    Pausa larga. Diego mira sus manos.

    "Vine acá para dejar de pelear, pero el hambre es el mismo monstruo con distinto acento."

    Se queda callado un momento. Después agrega algo que nunca le contó a nadie:

    "Mi viejo todavía está allá. Enfermo. No puedo ir a verlo porque si cruzo la frontera no me dejan volver. Y si no vuelvo, quién les manda plata."

    La voz se le quiebra. Un instante. Después se recompone.

    ~ diego_relacion += 2
    ~ subir_conexion(2)
    ~ activar_pedir_no_debilidad()
}
{ resultado_diego_confianza == 1:
    ~ diego_me_conto_historia = true

    "En Caracas, antes de venirme, yo creía. De verdad creía. Estuve en una cooperativa agrícola en el llano. Metíamos las manos en la tierra pensando que por fin era nuestra, que el socialismo de abajo iba a funcionar."

    "¿Y qué pasó?"

    "Pasó que la revolución tiene muchos estómagos y pocas manos. La corrupción se comió las semillas, y el autoritarismo se comió a los que preguntábamos dónde estaba el fertilizante. Destruyeron lo que construimos, y de paso borraron el trabajo de los que estaban antes de ellos, que tampoco eran santos, pero al menos dejaban algo en pie."

    Pausa larga. Diego mira sus manos, curtidas por dos tierras distintas.

    "Vine acá para dejar de pelear, pero el hambre es el mismo monstruo con distinto acento. A veces... a veces ya ni me da la cabeza para imaginar que la cosa se acomode. Es como si el futuro fuera un idioma que dejé de hablar."

    Comunidad.
    En el medio de la nada, se tienen entre ellos.

    ~ diego_relacion += 1
    ~ subir_conexion(1)
    ~ activar_pedir_no_debilidad()
}
{ resultado_diego_confianza == 0:
    Diego fuma. Piensa.

    "Vine de Venezuela. Ya sabés eso."

    Pausa.

    "Algún día te cuento bien. Hoy no me da."

    No insistís. Hay cosas que necesitan su tiempo.

    ~ diego_relacion += 1
}
{ resultado_diego_confianza == -1:
    Diego se cierra. Tirás del cigarrillo.

    "No me gusta hablar de eso."

    "Perdón. No quería..."

    "Está bien. Pero... no hoy."

    El silencio se vuelve incómodo.
    Quizás preguntaste demasiado pronto.
}

->->

=== diego_opinion ===

"La situación está jodida. Para todos."

Fuma.

* [...]
-

"Pero ustedes no saben lo que es jodido de verdad.
Cuando la luz se va diez horas. Cuando no hay agua.
Cuando un kilo de arroz cuesta un sueldo."

"¿Y esto?"

"Esto es difícil. Pero no es Venezuela.
Y acá... acá se siente distinto.
La gente todavía se mira.
En Caracas, al final, cada uno miraba su propio plato."

Hace una pausa.

"Por eso vengo a la olla.
No por el plato. Yo sé hacerme el mío.
Sino porque acá el hambre se combate con asamblea, no con silencio.
Eso lo aprendí allá: el que come solo, muere solo."

* [...]
-

Pausa.

"Aunque a veces... a veces me pregunto si vine
para terminar igual. Pobre en otro lado."

~ diego_relacion += 1

->->

=== diego_compania ===

"Está bien."

Fuman en silencio.
O él fuma. Vos mirás la calle.

No hace falta hablar.
A veces solo estar alcanza.

~ diego_relacion += 1

->->

// --- HISTORIA DE CECOSESOLA ---

=== diego_historia_cecosesola ===

~ diego_conto_cecosesola = true

Es domingo. Diego tiene el día libre.
Están sentados en la plaza del barrio.

"¿Sabés qué hacía yo en Venezuela, antes de todo?"

"No. ¿Qué?"

"Organizaba ferias. Ferias de verdad."

* [...]
-

"Mi familia estaba en CECOSESOLA. Central Cooperativa de Servicios Sociales de Lara. Suena a burocracia, pero era todo lo contrario."

"¿Qué era?"

"La red cooperativa más vieja del país. Fundada en el 67, antes de Chávez, antes de todo. Mi abuelo fue de los primeros. Mi padre también. Yo nací en eso."

* [...]
-

Diego mira al cielo. Sonríe por primera vez en mucho tiempo.

"Las ferias de consumo familiar. Imaginate: los productores llevaban la cosecha directo a la feria. Tomates, pimentones, yuca, plátano. Sin intermediarios. Los precios eran treinta por ciento menos que en el mercado."

"¿Treinta por ciento?"

"Porque no había patrón. No había jefe. Todos ganábamos lo mismo: el que cargaba, el que vendía, el que contaba la plata. Rotábamos los cargos. Nadie se quedaba arriba."

* ["Eso suena a cuento."]
    "Suena, sí. Pero funcionó sesenta años. Todavía funciona, aunque destruyeron la mitad."
    -> diego_cecosesola_cont
    
* ["¿Y cómo funcionaba?"]
    "Con asambleas. Todo se decidía entre todos. Si había problema, hablábamos. Si alguien se mandaba un moco, lo corregíamos. No había despidos, había conversaciones."
    -> diego_cecosesola_cont

=== diego_cecosesola_cont ===

* [...]
-

"También teníamos un centro de salud. Propio. Con quirófanos. Lo construimos nosotros. No esperamos que el gobierno nos lo diera."

"La puta madre."

* [...]
-

Diego se pone serio.

"¿Sabés cuál es la diferencia entre la cooperativa de verdad y la que quería imponer el Estado?"

"¿Cuál?"

"El Estado quería que dependiéramos de él. Créditos estatales, contratos oficiales, consejos comunales alineados al partido. Nosotros dijimos que no. CECOSESOLA nunca aceptó plata del gobierno. Preferíamos ser pobres y libres."

* [...]
-

"Y eso nos hizo enemigos."

~ subir_conexion(1)
~ diego_relacion += 1

->->

=== diego_sobre_camion ===
// La historia del camión quemado

~ diego_conto_camion = true

Diego baja la voz.

"¿Sabés por qué me fui?"

"Por la situación, ¿no? El hambre, la inflación..."

"No. Bueno, también. Pero hubo algo más."

* [...]
-

"Cuando el gobierno empezó a presionar a CECOSESOLA, nos negamos a alinearnos. No queríamos distribuir las cajas CLAP."

"¿Qué eran las CLAP?"

"Paquetes de comida que controlaba el partido. Si estabas con ellos, comías. Si no, te jodías. Era control político, no ayuda."

* [...]
-

"Un funcionario le dijo a mi viejo: 'O entran al sistema o los vamos a asfixiar'. Empezaron a negarnos permisos. A demorarnos los insumos."

"Hijos de puta."

* [...]
-

Diego mira sus manos.

"Una noche quemaron un camión de la cooperativa. Lleno de verduras para la feria del sábado. Nadie investigó. El mensaje era claro."

* [...]
-

Silencio largo.

"Mi vieja me dijo: 'Vos tenés que irte antes de que te toque a vos'. Me dieron los ahorros de toda la vida. Que no eran nada, por la inflación. Pero era todo lo que tenían."

* ["Lo siento."]
    "No hay nada que sentir. Es la historia de miles. Millones. Nos robaron el futuro antes de que existiera."
    ~ subir_conexion(1)
    ~ diego_relacion += 1
    ->->

* [Quedarte callado]
    No hay palabras.
    Diego tampoco las espera.
    ~ diego_relacion += 1
    ->->

=== diego_libreta_semillas ===
// La libreta con semillas

Notás que Diego tiene una libretita gastada.
Anota todo ahí: gastos, horarios, nombres.

"¿Qué tenés en esa libreta?"

Diego sonríe.

"Cosas de feria. Costumbre vieja."

* ["¿Puedo ver?"]
    
    Diego duda. Después te la muestra.
    
    En las últimas páginas hay una lista distinta.
    No son números. Son nombres de plantas.
    
    "Pimentón larence. Tomate perita. Ají dulce. Cilantro cimarrón."
    
    "¿Qué es esto?"
    
    * [...]
    -
    
    "Semillas de mi tierra. Las que aprendí a sembrar con mi abuelo."
    
    Pasa el dedo por la lista.
    
    "Ninguna crece igual acá. El clima es distinto. La tierra es distinta."
    
    * [...]
    -
    
    "A veces la leo como quien lee una carta de un muerto."
    
    Guarda la libreta.
    
    "Pero la guardo. Por si algún día..."
    
    No termina la frase.
    No hace falta.
    
    ~ subir_conexion(1)
    ~ diego_relacion += 1
    ->->

* ["No, perdón. Es personal."]
    "Está bien. Capaz otro día."
    ->->

=== diego_y_marcos ===
// Tensión/diálogo con Marcos sobre organización

Marcos está hablando de "la orga". De cuando él militaba.
De la estructura, de las células, de la disciplina.

Diego lo escucha con cara rara.

"¿Y quién controlaba a la orga?"

Marcos se frena.

"¿Cómo?"

"¿Quién decidía quién subía y quién bajaba? ¿Quién manejaba la plata? ¿Había asambleas o había jefes?"

* [...]
-

Marcos no sabe qué decir.

"Había... había dirección. Cuadros. Gente formada..."

"O sea, jefes."

* [...]
-

Diego no lo dice con bronca. Lo dice con tristeza.

"Yo vi el cooperativismo de verdad ser aplastado por el cooperativismo del Estado. El problema no era la idea. Era que alguien arriba se creía con derecho a decidir por todos."

* [...]
-

Marcos se queda callado.

Diego sigue:

"Sin la asamblea, sos solo otro tipo con libros y buenas intenciones. Y eso no alcanza."

Silencio incómodo.

Pero Marcos no se va.
Algo le quedó sonando.

->->

// --- DIEGO Y EL DESPIDO ---

=== diego_enterarse_despido ===
// Tunnel: Diego se entera del despido del protagonista

{conte_a_alguien:
    "Ya te conté. Me echaron."
    "Mierda, sí. ¿Cómo andás?"
- else:
    "Me echaron ayer."
    ~ conte_a_alguien = true
    "La puta madre."
}

Diego te mira.
Él sabe lo que es no tener nada seguro.

"Si necesitás algo..."

"Gracias."

No hay mucho que decir.
Pero estar con alguien ayuda.

->->

// --- DIEGO PIERDE EL TRABAJO ---

=== diego_pierde_laburo ===

~ diego_perdio_laburo = true
~ diego_estado = "desesperado"

Diego está en la plaza.
Medio día. Debería estar trabajando.

"Diego. ¿Qué hacés acá?"

"Me echaron."

Corto. Seco.

* [...]
-

"¿Cuándo?"

"Ayer. Sin aviso. 'Ya no te necesitamos'."

Mira el piso.

* [...]
-

"Ocho meses. Nunca falté. Nunca llegué tarde.
Y me echaron como si nada."

* ["Lo siento mucho."] -> diego_consolar
* ["¿Tenés algo ahorrado?"] -> diego_preguntar_ahorros
* ["¿Qué vas a hacer?"] -> diego_que_hacer

=== diego_consolar ===

"Lo siento, Diego."

"Sí. Yo también."

No hay más que decir.

~ diego_relacion += 1

->->

=== diego_preguntar_ahorros ===

"¿Tenés algo ahorrado?"

Sonríe. Sin gracia.

"¿Con lo que pagaban? Apenas daba para el cuarto y mandar algo."

"{diego_familia_en_venezuela:
    "Mi vieja va a tener que esperar.
    Pero ella entiende. Es una guerrera.
    Ya pasó por peores."
}

->->

=== diego_que_hacer ===

"No sé. Buscar otra cosa. Hay un depósito en Sayago.
Capaz que necesitan gente."

"¿Y si no?"

"No sé. Algo aparece. Siempre aparece algo."

Es lo que se dice.
Aunque no siempre sea verdad.

->->

// --- AYUDAR A DIEGO ---

=== diego_ayuda ===

~ ayude_a_diego = true

{diego_perdio_laburo:
    "Diego. Mirá, no es mucho, pero..."

    Le das lo que podés.
    Poco. Pero algo.

    "No, hermano. Vos también estás jodido."

    "Tomalo. Después me pagás."

    No va a pagar. Los dos lo saben.
    Pero la ficción ayuda.

    ~ diego_relacion += 2
    ~ subir_conexion(1)
    ~ diego_estado = "esperanzado"

    "Gracias. En serio."

    ->->
- else:
    "Si necesitás algo, avisame."

    Diego asiente.

    "Gracias. Lo mismo digo.
    Si vos te quedás en banda, el grupo se mueve.
    No te vamos a dejar caer."

    ~ diego_relacion += 1

    ->->
}

// --- TELEFONO ---

=== diego_llamar ===
// Tunnel: Llamar a Diego

Llamás a Diego.

"¿Qué onda?"

"Nada. Domingo. ¿Vos?"

"Acá, en la pieza. Mirando el techo."

->->

=== diego_conversacion_telefono ===
// Tunnel: Conversacion telefonica con Diego

Hablan.
De nada.
De todo.

Diego también está solo.
Pero ahora están solos juntos, aunque sea por teléfono.

"La semana que viene hay que buscar laburo en serio."

"Sí. Hay que."

"Mañana salimos juntos. Recorremos."

"Dale."

~ subir_conexion(1)

->->

// --- FRAGMENTO NOCTURNO DE DIEGO ---

=== diego_fragmento_noche ===

Diego mira el techo del cuarto.
Paredes finas. Se escucha todo.

Un cuarto compartido con otro venezolano.
Seis metros cuadrados.
Casa. Por ahora.

Debajo de la almohada tiene una franela vieja.
El logo de CECOSESOLA: una mano sosteniendo espigas.
Ya no la usa, pero la guarda.

{diego_perdio_laburo:
    Mañana tiene que buscar trabajo.
    Tiene que encontrar algo.
    No hay opción.

    Piensa en su mamá.
    En la llamada que tiene que hacer.
    En las palabras que no encuentra.

    "Este mes no puedo mandar."
    ¿Cómo se dice eso?
- else:
    El despertador suena a las cuatro.
    Turno de seis a seis.
    Doce horas.
    Después repetir.
}

{diego_familia_en_venezuela:
    Piensa en Caracas.
    En las calles que caminaba.
    En la casa de su mamá.

    A veces sueña que vuelve.
    Que todo se arregló.
    Que puede volver.

    Después despierta.
}

{diego_conto_cecosesola:
    Piensa en la cooperativa.
    En 2022, CECOSESOLA ganó el Right Livelihood Award.
    El "Nobel Alternativo", le dicen.
    
    Lo vio por internet, desde este mismo cuarto.
    
    Lloró de orgullo.
    La cooperativa sobrevivió. Sigue funcionando.
    Pero su familia tuvo que irse.
    
    Lloró también de rabia.
}

{diego_viene_a_olla:
    Al menos mañana hay olla.
    Al menos va a estar ocupado.
    Cansarse hace bien. Ayuda a no pensar.
    
    Además, en la olla se siente útil.
    Organizando logística, estirando recursos.
    Sus manos recuerdan cómo se hace.
}

{ayude_a_diego:
    Piensa en vos.
    En que estás empezando a entender que la "clase media" era un cuento que te contabas para no sentirte parte de nosotros.

    Se ríe bajito en la oscuridad.
    "Uruguayo loco", piensa.
    "Bienvenido a la resistencia. Acá no se factura, acá se sostiene."
}

Saca la libretita del bolsillo del pantalón.
La lista de semillas en la última página.
Pimentón larence. Tomate perita. Ají dulce.

"Algún día", murmura.

Afuera, la ciudad duerme.
Él no.

Los inmigrantes no duermen.
Calculan.
Planean.
Sobreviven.

Guarda la libreta.
Aprieta la franela bajo la almohada.
Cierra los ojos.

->->

// --- FRAGMENTOS NOCTURNOS DE DIEGO ---

=== fragmento_diego_llamada ===
Diego llama a su mamá en Caracas.

La señal va y viene.
"¿Comiste, mijo?"
"Sí, mamá."
Mentira. Hoy no comió.

Le manda la mitad de lo que gana.
Se queda con la otra mitad.
A veces alcanza. A veces no.

"Te quiero, mijo."
"Yo también, mamá."

Corta. Se queda mirando el techo.

->->

=== fragmento_diego_permiso ===
Diego revisa los papeles de residencia.
Todo en orden. Más o menos.

{diego_relacion >= 3:
    Piensa en el barrio.
    En que alguien le habló hoy sin pedirle los papeles primero.
    Eso vale.
}

El trámite es el jueves.
Si sale bien, puede trabajar en blanco.
Si sale mal...

No piensa en eso. Mañana.

->->

=== fragmento_diego_mate ===
Diego intenta cebar mate.

Le sale lavado. Otra vez.

{diego_relacion >= 2:
    "Mañana le pido al vecino que me enseñe."
}

En Venezuela el café es otra cosa.
Acá todo es mate.
Mate dulce, mate amargo, mate con yuyos.
Un idioma nuevo que todavía no domina.

Se toma el mate lavado igual.
Algo caliente es algo caliente.

->->



## FILE: personajes/marcos.ink

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

"Mal. No duermo. No salgo. No hago nada."

* [...]
-

Pausa.

"Estoy podrido de todo."

~ marcos_relacion += 1

->->

=== marcos_porque ===

"¿Por qué te alejaste? Del barrio, de la olla, de todo."

Silencio largo.

"Porque me quemé los ojos de ver cómo nos usaban. Diez años en la mesa chica de la militancia. Asambleas de trasnoche, marchas con la garganta rota, colectas para compañeros que después te vendían por un puesto en el ministerio."

Mira el piso.

"Cansado de ver cómo la estructura se morphaba el espíritu. Peleamos contra el sistema de afuera y nos terminó ganando el sistema de adentro. Al final, los de mi clase siguen igual, y los que hablaban en su nombre tienen auto nuevo. Me cansé de pelear para nada, uruguayo."

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
    ~ bajar_salud_mental(1)
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


## FILE: personajes/ixchel.ink

// ============================================
// PERSONAJE: IXCHEL
// Nombre significa "mujer de la luna" en maya
// Migrante guatemalteca, indígena Maya-K'iche'
// Representa la dignidad, el trabajo invisible,
// la cosmovisión ancestral y la resistencia global.
// ============================================

// --- ENCUENTRO CASUAL EN EL BARRIO ---

=== ixchel_encuentro_casual ===

Ves a una mujer barriendo la vereda frente a la mercería.
Es Ixchel. Siempre lleva un huipil colorido bajo el delantal de trabajo.
Se mueve con una parsimonia que contrasta con el ritmo frenético del barrio.

* [Saludar] -> ixchel_saludo
* [Ofrecerte a ayudarla] -> ixchel_ayudar
* [Seguir de largo] -> ixchel_ignorar

=== ixchel_saludo ===

"Buen día, Ixchel."

Ella levanta la vista. Sus ojos son profundos, como si vieran más allá de la calle rota.

"Buen día para quien sabe caminarlo", dice con una leve sonrisa.

{not tiene_laburo:
    "Lo veo cargando mucho peso en los hombros, joven. No todo lo que pesa es mochila."
- else:
    "Que la prisa no le quite el camino."
}

->->

=== ixchel_ayudar ===

"¿Te doy una mano con eso?"

Ixchel te entrega la escoba sin dudar.
"La limpieza es un acto sagrado. Gracias."

~ subir_conexion(1)
~ ixchel_estado = "ayudando"

Barrés juntos un rato. El sonido de la paja contra el cemento es hipnótico.

"¿Hace mucho que te viniste de Guatemala?"

"Guatemala vive en mi ombligo, joven. Mi familia cuidaba los cerros, defendiendo la tierra de los que venían con máquinas y papeles a decirnos que el agua tenía dueño."

* [...]
-

"Me vine hace cinco años, cuando los líderes empezaron a no volver a casa."

Hace una pausa. Sus manos siguen barriendo, pero sus ojos miran algo lejano.

"Mi tierra no sabe de fronteras, solo de heridas que aún supuran."

->->

=== ixchel_ignorar ===

Pasás rápido.
Ixchel sigue barriendo.
Para ella, el tiempo no es algo que se gasta, es algo que se habita.

->->

// --- EN LA OLLA ---

=== ixchel_en_olla ===

Ixchel está en un rincón, separando legumbres con una velocidad asombrosa.
Parece que sus manos tienen ojos propios.

"La diversidad es lo que hace al guiso", dice sin mirarte.

* ["¿Cómo hacés tan rápido?"]
    "Aprendí de mis abuelas. Ellas decían que el alimento se prepara primero con la intención y después con las manos."
    Te invita a sentarte a su lado. A separar lentejas.
    -> ixchel_cocinar_juntos
* ["Parece un laburo pesado."]
    "El trabajo duro es el que se hace solo, joven. Dios nos dio manos para compartir la carga. Entre muchos, es celebración."
    Te hace un lugar. Te pone un balde de legumbres adelante.
    -> ixchel_cocinar_juntos

=== ixchel_cocinar_juntos ===

// Chequeo físico: cocinar a la par de Ixchel
# DADOS:CHEQUEO
~ temp resultado_ixchel_cocinar = chequeo_completo_fisico(0, 3)
{ resultado_ixchel_cocinar == 2:
    Tus manos encuentran el ritmo. Rápido. Preciso.
    Ixchel te mira sorprendida.

    "Tiene buenas manos, joven. Mi abuela diría que el maíz lo eligió."

    Trabajan juntos en silencio. Un silencio sagrado.
    El guiso toma forma.

    ~ ixchel_relacion += 1
    ~ subir_llama(1)
    ~ subir_conexion(1)
}
{ resultado_ixchel_cocinar == 1:
    Separás lentejas. No tan rápido como ella, pero sin parar.
    Ixchel asiente. Conforme.

    El trabajo compartido habla por los dos.

    ~ subir_llama(1)
}
{ resultado_ixchel_cocinar == 0:
    Confundís lentejas con piedritas. Dos veces.
    Ixchel las saca sin decir nada.

    "Despacio. La lenteja no tiene apuro."

    Aprendés. Lento, pero aprendés.

    ~ subir_llama(1)
}
{ resultado_ixchel_cocinar == -1:
    Se te cae el balde. Las lentejas ruedan por el piso.

    "Ay, perdón..."

    Ixchel se ríe. Sin maldad. Con ternura.

    "Mi hermano Tomás hacía lo mismo. Manos de elefante, decía mi abuela."

    Juntan las lentejas del piso. Las lavan de vuelta.
    El desastre se convirtió en recuerdo compartido.

    ~ ixchel_relacion += 1
}

->->

=== ixchel_primer_encuentro_olla ===
// Tunnel: Primer encuentro con Ixchel en la olla
// Uso: -> ixchel_primer_encuentro_olla ->

Sofía te presenta a una mujer de rasgos indígenas.
Piel morena, cabello negro trenzado.
Bajo el delantal de cocina asoma un bordado colorado.

"Ella es Ixchel. Viene de Guatemala. Cocina mejor que todas nosotras juntas."

Ixchel sonríe con modestia.

"Mucho gusto, joven. Bienvenido a la olla."

Te dice "usted" aunque no parece mucho mayor que vos.
Es una formalidad antigua, respetuosa.

->->

// --- ESCENAS DE PROFUNDIDAD ---

=== ixchel_historia_tomas ===
// Historia del hermano desaparecido

~ hable_con_ixchel_profundo = true
~ ixchel_me_conto_de_tomas = true

Es de noche. La olla ya cerró.
Ixchel lava los platos en silencio.
Vos secás.

El silencio es cómodo hasta que ella lo rompe.

"Tenía un hermano. Tomás."

* [...]
-

"Era catequista, pero no solo de fe. Organizaba a la comunidad. Era vocero del Consejo de Pueblos K'iche'."

"¿Consejo?"

"Los que defendíamos la tierra de las mineras. Goldcorp, una empresa canadiense, vino a sacarnos el oro. Pero el oro estaba debajo de nuestras casas, de nuestros ríos."

* [...]
-

Sus manos siguen lavando, pero más lento.

"Tomás organizaba las consultas. Le preguntábamos al pueblo: ¿quieren la mina? Noventa y ocho por ciento dijo que no. Pero el gobierno ya había dado el permiso. Sin preguntarnos."

"¿Y qué pasó?"

* [...]
-

Silencio largo.

"Un día salió a una reunión y no volvió. Lo encontraron tres días después. La policía dijo 'ajuste de cuentas'. Nadie investigó."

Sigue lavando.

* ["Lo siento mucho."] -> ixchel_tomas_respuesta
* [Quedarte en silencio] -> ixchel_tomas_silencio

=== ixchel_tomas_respuesta ===

"Lo siento, Ixchel."

"Dios lo tiene en su gloria. Y yo lo tengo acá."

Se toca el pecho.

"Cada vez que barró, cada vez que cocino, hago lo que él hacía: cuidar a la comunidad. Eso no lo pueden matar."

~ subir_conexion(1)
~ ixchel_relacion += 1

->->

=== ixchel_tomas_silencio ===

No decís nada.
A veces las palabras sobran.

Ixchel sigue lavando.
Vos seguís secando.

El silencio dice lo que la boca no puede.

~ subir_conexion(1)
~ ixchel_relacion += 1

->->

=== ixchel_sobre_mina_marlin ===
// Historia de la Mina Marlin y la resistencia

~ ixchel_hablo_de_mina = true

"¿Sabés lo que es una mina a cielo abierto?"

No esperás la pregunta.

"Más o menos."

"Es cuando le arrancan la piel a la montaña. Usan cianuro para sacar el oro. El cianuro envenena el agua."

* [...]
-

"Mi comunidad, San Miguel Ixtahuacán, está sobre oro. Por eso vinieron. La empresa se llamaba Goldcorp. Canadiense."

"¿Canadá?"

"Sí. Los de lejos vienen a sacar lo de acá. Siempre fue así."

* [...]
-

"El agua empezó a enfermar a la gente. Las explosiones agrietaban las casas. Pero el gobierno decía que era progreso."

Sus ojos se endurecen por un momento.

"Nosotros hicimos consultas. Miles de personas votaron que no querían la mina. Pero los papeles del gobierno valen más que la voz del pueblo."

* ["¿Y qué hicieron?"]
    "Resistir. Marchar. Bloquear. Y algunos... algunos pagaron con la vida."
    
    Piensa en Tomás. No lo dice, pero vos sabés.
    
    ~ subir_dignidad(1)
    ->->

* ["Eso es horrible."]
    "Es la realidad, joven. Acá y allá, los de arriba toman y los de abajo aguantan. Pero el agua tiene memoria. La tierra tiene memoria. Nosotros también."
    
    ~ subir_conexion(1)
    ->->

=== ixchel_llegada_uruguay ===
// Historia de cómo llegó a Uruguay

~ ixchel_conto_llegada = true

"¿Cómo llegaste acá? ¿A Uruguay, digo?"

Ixchel sonríe, pero sin alegría.

"No lo elegí yo. Lo eligió un formulario."

* [...]
-

"Después de lo de Tomás, empecé a recibir amenazas. Notas debajo de la puerta. Llamadas donde nadie hablaba."

"La puta madre."

* [...]
-

"Una organización, SERPAJ, me contactó. Dijeron que podían sacarme del país por ACNUR. Refugiada."

"Y viniste acá."

"'Uruguay' era un nombre en un papel. No sabía ni dónde quedaba. Solo sabía que era lejos."

* [...]
-

Hace una pausa.

"El primer invierno casi me muero. Ocho grados me parecían el fin del mundo. Una vecina de la pensión me prestó una campera. Nunca se la pude devolver. Se mudó."

Se mira las manos.

"Pero acá estoy. Un día más lejos de la montaña. Un día más cerca de... no sé de qué. Pero sigo."

~ subir_conexion(1)
~ ixchel_relacion += 1

->->

=== ixchel_sobre_huipil ===
// El huipil como identidad

~ ixchel_hablo_de_huipil = true

Notás el bordado que asoma bajo su uniforme de limpieza.

"Eso que llevás... ¿qué es?"

Ixchel sonríe.

"Es mi huipil. La ropa de mi pueblo. Este diseño es de San Miguel Ixtahuacán. Las líneas rojas son el maíz. Las verdes, la montaña."

* [...]
-

"Lo uso debajo del uniforme de trabajo. Nadie lo ve."

"¿Por qué lo usás si nadie lo ve?"

* [...]
-

"Porque yo sé que está ahí."

Se toca el pecho, donde el bordado queda oculto.

"Cuando limpio oficinas, soy invisible. Pero debajo del delantal soy Ixchel Batz Ixcoy, maya-k'iche', hija de la montaña."

* [...]
-

"Ellos ven una empleada. Yo sé quién soy."

Es una armadura invisible.
Te das cuenta de que nunca pensaste en eso.

~ subir_dignidad(1)
~ subir_conexion(1)

->->

=== ixchel_sobre_xenofobia ===
// Respuesta a la xenofobia

Un vecino pasó y dijo algo ofensivo sobre "los que vienen de afuera".
Ixchel no bajó la cabeza. Ni siquiera dejó de separar las lentejas.

"¿No te jode?", preguntás.

"Él tiene el corazón nublado. Que el Señor lo perdone, porque no sabe que la tierra no le pertenece por un papel. La tierra es de Dios, nosotros solo la caminamos."

Te mira fijo.

"Ustedes los uruguayos a veces tienen miedo de ser nosotros. Pero en el hambre, todos tenemos la misma cara."

* [...]
-

"Además..."

Sonríe levemente.

"Yo estuve frente a soldados con fusiles. Un señor que dice tonterías en la calle no me quita el sueño."

~ subir_dignidad(1)
~ subir_conexion(1)

->->

=== ixchel_cosmovision ===
// La cosmovisión maya en lo cotidiano

Ixchel está pelando papas. Murmura algo en un idioma que no entendés.

"¿Qué decías?"

"Le hablaba a la papa."

* ["¿A la papa?"]
    "El maíz, la papa, el frijol... son seres, joven. No solo comida. Les pedimos permiso antes de comerlos."
    -> ixchel_cosmovision_cont
    
* [Sonreír]
    Ixchel nota tu sonrisa.
    
    "Le parece raro."
    
    "Un poco."
    
    "Es porque ustedes olvidaron. Nosotros todavía recordamos."
    -> ixchel_cosmovision_cont

=== ixchel_cosmovision_cont ===

"Mi abuela decía: 'El maíz no crece para nosotros. Crece con nosotros. Somos parientes'."

* [...]
-

"Por eso cuando cocino, no estoy solo trabajando. Estoy... ¿cómo se dice? Honrando."

* [...]
-

"Acá, en la olla, hacemos lo mismo. Convertimos comida en comunidad. Eso es sagrado."

~ subir_llama(1)

->->

=== ixchel_sincretismo ===
// El sincretismo religioso

Ixchel tiene una estampita de la Virgen de Guadalupe en su delantal.

"¿Sos católica?"

"Sí. Y también soy maya."

* ["¿No es contradictorio?"]

    "El Señor es grande. Tiene muchos nombres. Los españoles trajeron a María, pero ella se apareció morena, en el cerro del Tepeyac, hablando náhuatl."
    
    * [...]
    -
    
    "Guadalupe no es solo de ellos. Es de nosotros también. Es la madre tierra con otro vestido."
    
    ~ subir_conexion(1)
    ->->

* ["Entiendo."]

    "No hace falta elegir. Mi abuela rezaba el Padre Nuestro y después le hablaba a la montaña. Dios es grande, joven. Cabe todo."
    
    ->->

// --- TUNNELS PARA DÍAS ---

=== ixchel_en_cocina ===
// Tunnel: Ixchel cocinando
// Uso: -> ixchel_en_cocina ->

Ixchel corta verduras con una precisión de cirujano.
No parece esforzarse. Es natural, como respirar.

"La prisa es de los que olvidaron a dónde van", dice sin levantar la vista.

->->

=== ixchel_sirviendo ===
// Tunnel: Ixchel sirviendo comida
// Uso: -> ixchel_sirviendo ->

Ixchel sirve los platos con cuidado.
Un poco más para los que tienen cara de hambre.
Una sonrisa para cada uno.

"Buen provecho. Que Dios bendiga."

->->

=== ixchel_pelando ===
// Tunnel: Ixchel pelando papas
// Uso: -> ixchel_pelando ->

Ixchel pela papas.
Sus manos se mueven solas, como si supieran lo que hacen sin que ella les diga.

Te hace lugar en el banco.

"Siéntese. Hay papas para todos."

->->

=== ixchel_llamar ===
// Tunnel: Llamar a Ixchel
// Uso: -> ixchel_llamar ->

Llamás a Ixchel.
Tarda en contestar.

"¿Aló?"

"Hola, Ixchel. ¿Cómo estás?"

"Bien, gracias a Dios. ¿Y usted, joven?"

Siempre tan formal.
Siempre tan respetuosa.

->->

=== ixchel_conversacion_telefono ===
// Tunnel: Conversación telefónica con Ixchel
// Uso: -> ixchel_conversacion_telefono ->

Hablan un rato.
Ella cuenta de su trabajo, de la pensión, de las llamadas a Guatemala que salen carísimas.

"Pero mientras haya maíz, hay esperanza."

Su frase favorita.
Te queda sonando.

~ subir_conexion(1)

->->

// --- FRAGMENTO NOCTURNO ---

=== ixchel_fragmento_noche ===

Ixchel prende una vela pequeña en su cuarto.
El olor a copal llena el aire, tapando el olor a humedad de la pensión.

Frente a la vela hay una estampita de la Virgen de Guadalupe.
Al lado, una foto vieja de un hombre joven con camisa blanca.
Tomás.

* [...]
-

Reza en voz baja.
Primero en español. Después en k'iche'.
Las palabras se mezclan, como se mezclaron siempre.

{ixchel_me_conto_de_tomas:
    "Hermano, otro día más lejos. Pero no te olvido."
    "Cada plato que sirvo es para vos también."
}

* [...]
-

{ixchel_estado == "ayudando":
    Piensa en el joven.
    En cómo agarró la escoba.
    En que todavía hay manos que no tienen miedo de tocar la tierra.
    
    "Tal vez hay esperanza, Tomás."
}

* [...]
-

Mira la foto de las montañas en la pared.
Los volcanes de su tierra. El lago Atitlán al fondo.

"Un día más lejos de la montaña", murmura.
"Pero un día más cerca de Su voluntad y de la comunidad."

* [...]
-

Se envuelve en su rebozo.
Apaga la vela.

{ixchel_hablo_de_huipil:
    Debajo de la ropa de dormir, sigue llevando el huipil.
    Nadie lo ve.
    Pero ella sabe que está ahí.
}

Mañana hay que barrer de nuevo.
Mañana hay que sostener de nuevo.
Mañana hay que seguir siendo Ixchel.

->->

// --- RELACION CON OTROS PERSONAJES ---

=== ixchel_y_elena ===
// Interacción especial con Elena

Elena le pasa el mate a Ixchel.

"Tomá, m'hija."

Ixchel acepta con las dos manos, ceremonial.

"Gracias, doña Elena."

Elena la mira.

"Vos sabés lo que es que te quieran romper. Se te ve en los ojos."

"Usted también, doña."

* [...]
-

Se miran.
Dos guerreras de distintas guerras.
Pero la misma guerra.

"Los de arriba siempre quieren pisarnos", dice Elena.
"Pero acá seguimos. Como las piedras."

Ixchel asiente.

"Como las piedras."

~ subir_conexion(1)

->->

=== ixchel_y_diego ===
// Interacción especial con Diego

Diego e Ixchel descargan cajones juntos.
No hablan mucho. No hace falta.

Los dos saben lo que es huir.
Los dos saben lo que es empezar de cero.
Los dos saben lo que dejaron atrás.

"¿Extrañás Venezuela?", pregunta Ixchel.

"Todos los días."

"Yo también extraño Guatemala. Todos los días."

* [...]
-

Silencio.

"Pero acá estamos", dice Diego.

"Acá estamos", confirma Ixchel.

Es suficiente.

~ subir_conexion(1)

->->

=== ixchel_y_juan ===
// Interacción especial con Juan

Juan le pregunta a Ixchel sobre Guatemala.
Como si fuera un documental.

"¿Y los mayas todavía existen? Creía que..."

Ixchel lo mira.
No con enojo. Con paciencia.

"Existimos, sí. Millones. Y seguimos hablando nuestra lengua, tejiendo nuestra ropa, sembrando nuestro maíz."

* [...]
-

Juan se pone un poco incómodo.

"Ah. No sabía. Perdón si..."

"No hay nada que perdonar, joven. Solo aprender."

Le sonríe.
Juan no sabe qué decir.
Pero algo se mueve adentro suyo.

->->

=== ixchel_frase_maiz ===
// Tunnel: Frase del maíz
// Uso cuando alguien se desespera

Ixchel dice, pausada:

"Mientras haya maíz, hay esperanza."

Simple.
Profundo.
Te queda sonando.

->->

// --- IXCHEL EN LA OLLA (JUEVES-SABADO) ---

=== ixchel_encuentro_olla ===
// Encuentro en la olla
# PORTRAIT:elena,neutral,right

{ixchel_estado == "desconocida":
    Hay una mujer que no conocés.
    Morena, pelo largo y negro. Trabaja en silencio.
    Pela papas más rápido que nadie.

    * [Acercarte]
        "Hola. ¿Primera vez?"
        Te mira. Ojos oscuros, profundos.
        "No. Vengo hace un mes."
        ~ ixchel_estado = "conocida"
        ~ ixchel_relacion += 1
        ->->
    * [Seguir de largo]
        ->->
- else:
    Ixchel está en la cocina. Como siempre.

    * [Saludarla]
        "Hola, Ixchel."
        Sonríe apenas. "Hola."
        ~ ixchel_relacion += 1
        ->->
    * [Trabajar cerca]
        Te ponés a pelar al lado de ella.
        No hace falta hablar.
        ->->
}

=== ixchel_conversacion_profunda ===
// Conversacion cuando hay confianza
# PORTRAIT:elena,neutral,right

{ixchel_relacion >= 3:
    Ixchel te mira diferente hoy.
    "¿Puedo contarte algo?"

    * ["Claro."]
        // Chequeo social: comunicación intercultural, entender su mundo
        # DADOS:CHEQUEO
        ~ temp resultado_ixchel_comunicar = chequeo_completo_social(ixchel_relacion, 4)
        { resultado_ixchel_comunicar == 2:
            "Allá, en Quetzaltenango, mi abuela tejía.
            Huipiles con pájaros y montañas.
            Cada color tenía un significado."

            Pausa.

            "Acá limpio grasa. Pero sigo tejiendo.
            No con hilos. Con esto."

            Señala la olla. La gente.

            "La comunidad es un tejido. ¿Entendés?"

            Algo te cruza. No solo entendés. Lo sentís.

            "Sí. Y cada uno de nosotros es un hilo."

            Ixchel sonríe. Amplia. Real.

            "Exacto. Ya entendés, joven."

            ~ ixchel_conto_historia = true
            ~ ixchel_relacion += 2
            ~ subir_conexion(2)
            ~ activar_esto_es_lo_que_hay()
        }
        { resultado_ixchel_comunicar == 1:
            "Allá, en Quetzaltenango, mi abuela tejía.
            Huipiles con pájaros y montañas.
            Cada color tenía un significado."

            Pausa.

            "Acá limpio grasa. Pero sigo tejiendo.
            No con hilos. Con esto."

            Señala la olla. La gente.

            "La comunidad es un tejido. ¿Entendés?"

            ~ ixchel_conto_historia = true
            ~ ixchel_relacion += 1
            ~ subir_conexion(1)
            ~ activar_esto_es_lo_que_hay()
        }
        { resultado_ixchel_comunicar == 0:
            "Allá, en Quetzaltenango, mi abuela tejía.
            Huipiles con pájaros y montañas."

            Pausa.

            "Acá es diferente. Pero sigo intentando."

            No entendés del todo. Pero escuchás.
            A veces eso alcanza.

            ~ ixchel_relacion += 1
        }
        { resultado_ixchel_comunicar == -1:
            "Allá, en Quetzaltenango..."

            Se detiene. Te mira.

            "No importa. Son cosas mías."

            Algo en tu cara la frenó. Quizás incomprensión.
            Quizás distancia.
            El mundo de Ixchel queda lejos. Demasiado lejos hoy.
        }
        ->->
    * ["Ahora no puedo."]
        Asiente. Sin ofenderse.
        "Otro día."
        ->->
- else:
    Ixchel está ocupada. No es momento.
    ->->
}

=== ixchel_fragmento_noche_tejido ===
// Fragmento nocturno de Ixchel - tejido

Ixchel cierra la puerta de su pieza.
Un cuarto compartido con dos mujeres más.

Se sienta en la cama.
Saca un hilo de colores de debajo de la almohada.

Teje.

Un patrón que su abuela le enseñó.
Pájaros que nunca vio en Montevideo.
Montañas que están a miles de kilómetros.

{ixchel_relacion >= 2:
    Hoy alguien le habló en la olla.
    No como "la boliviana".
    Como Ixchel.
    Eso vale más que el sueldo de un mes.
}

Teje hasta que se le cierran los ojos.
El hilo se cae al piso.

En sueños, está en Quetzaltenango.

->->

// --- FRAGMENTOS NOCTURNOS DE IXCHEL ---

=== fragmento_ixchel_cocina ===
Ixchel se lava las manos.
Rojas del agua caliente del restaurante.

El encargado gritó de vuelta.
"Boliviana" de vuelta.

No es boliviana. No importa.
Para ellos todos son lo mismo.

Se mira las manos.
Manos de su abuela. De su madre.
Manos que saben tejer y cocinar y sobrevivir.

Se duerme con las manos doloridas.
Mañana será otro día.

->->

=== fragmento_ixchel_altar ===
Ixchel tiene un altar pequeño.
Debajo de la cama, donde las otras no ven.

Una vela. Una foto de su abuela.
Un hilo de colores.

Reza en K'iche'.
Palabras que no entiende nadie en este país.
Palabras que la sostienen.

{ixchel_relacion >= 2:
    Hoy alguien la llamó por su nombre.
    No "boliviana". No "india".
    Ixchel.
    Agrega eso a la oración.
}

La vela se apaga. Se duerme.

->->



// --- INCLUDES: DÍAS ---

## FILE: dias/lunes.ink

// ============================================
// LUNES - ROUTING CON TUNNELS
// Solo controla el flujo, las escenas están en módulos
// ============================================

=== lunes_amanecer ===

~ dia_actual = 1
~ energia = 4

# LUNES

// Despertar en casa (tunnel)
-> casa_despertar ->

// Después de despertar, continúa con la salida
-> lunes_salir

=== lunes_salir ===
// Salir de casa

-> casa_salir ->

// La parada del bondi
-> lunes_parada_bondi

=== lunes_parada_bondi ===

-> bondi_esperar_parada ->

// Después del bondi, verificar si llegó tarde
{ultima_tirada == 1:
    -> lunes_llegada_tarde
- else:
    -> lunes_llegada
}

=== lunes_llegada ===

-> laburo_llegada ->

-> lunes_manana

=== lunes_llegada_tarde ===

-> laburo_llegada_tarde ->

-> lunes_manana

=== lunes_manana ===

-> laburo_manana ->

// Encuentro con Juan
-> juan_saludo_manana ->

// Trabajo de la mañana
-> laburo_trabajo_rutina ->

// Verificar si hay escena adicional con Juan
{hable_con_juan_sobre_rumores:
    -> lunes_pre_almuerzo_decision
- else:
    -> lunes_almuerzo
}

=== lunes_pre_almuerzo_decision ===

¿Qué hacés con la mirada del jefe?

* [Seguir laburando]
    -> lunes_almuerzo
* [Preguntarle a Juan] # STAT:conexion # EFECTO:conexion+
    -> juan_preguntar_sobre_jefe ->
    -> lunes_almuerzo
* {energia >= 2} [Hablar con el jefe] # COSTO:1 # DADOS:dignidad # EFECTO:dignidad?
    -> laburo_hablar_con_jefe ->
    -> lunes_almuerzo

=== lunes_almuerzo ===

# ALMUERZO

12:30.
Hora de comer.

* [Almorzar con Juan] # EFECTO:conexion+
    -> juan_almuerzo ->
    -> lunes_tarde
* [Almorzar solo] # EFECTO:conexion-
    -> laburo_almuerzo_solo ->
    -> lunes_tarde
* [Saltear el almuerzo] # EFECTO:dignidad-
    -> laburo_almuerzo_saltear ->
    -> lunes_tarde

=== lunes_tarde ===

-> laburo_tarde ->

// La reunión de reestructuración
A las 4, el jefe llama a una reunión.
"Todos al salón grande."

* [Ir con los demás] -> lunes_reunion

=== lunes_reunion ===

-> laburo_reunion_general ->

-> juan_post_reunion ->

// Si fueron al bar, ya se despidieron ahí - ir directo al bondi
{fue_al_bar_con_juan:
    -> lunes_bondi_vuelta
}

A las 5, te vas.

-> laburo_salida ->

-> lunes_bondi_vuelta

=== lunes_bondi_vuelta ===

-> bondi_vuelta ->

El bondi llega al barrio.

* [Ir directo a casa] # EFECTO:conexion-
    -> lunes_ir_casa
* {energia >= 2} [Pasar por algún lado] # COSTO:1 # EFECTO:conexion?
    -> lunes_pasar

=== lunes_pasar ===

¿A dónde?

* [Por la olla] # COSTO:1 # EFECTO:llama+
    -> lunes_olla
* [Por lo de tu vínculo] # COSTO:1 # EFECTO:conexion+
    -> lunes_visita_vinculo
* [Por el kiosco] # COSTO:1
    -> lunes_kiosco

=== lunes_kiosco ===

~ energia -= 1

Pasás por el kiosco.
Comprás algo. Un alfajor. Una coca.

El kiosquero te conoce de vista.

* [...]
-

"¿Qué tal? Cara de cansado hoy."

"Día largo."

// Chequeo social: charla con el kiosquero
~ temp kiosco_charla = chequeo_social(0, 3)
{ kiosco_charla == 2:
    "¿Sabés qué? Tomá." Te da otro alfajor.
    "No te cobro ese. Cara de que lo necesitás."
    Le agradecés. A veces la gente te sorprende.
    ~ subir_conexion(1)
}
{ kiosco_charla == 1:
    "Son todos largos." Se queda un rato. "Pero se bancan."
    Asentiás. Se bancan.
}
{ kiosco_charla == 0:
    "Son todos largos."
    Silencio. Nada más.
}
{ kiosco_charla == -1:
    "Son todos largos. Y cada vez peor."
    Te mira y se da vuelta. Conversación terminada.
    Te vas sintiéndote peor que antes.
    ~ bajar_salud_mental(1)
}

-> lunes_ir_casa

=== lunes_visita_vinculo ===

~ energia -= 1

{vinculo == "sofia": -> lunes_visita_sofia}
{vinculo == "elena": -> lunes_visita_elena}
{vinculo == "diego": -> lunes_visita_diego}
{vinculo == "marcos": -> lunes_visita_marcos}

=== lunes_visita_sofia ===

Pasás por lo de Sofía.
Está en la puerta, los pibes adentro.

"¿Todo bien?"

* [Contarle del laburo] # STAT:conexion # EFECTO:conexion+
    ~ subir_conexion(1)
    Le contás. Los rumores. La reunión.
    "En la olla estamos peor", dice. "Pero entiendo."
    -> lunes_ir_casa
* ["Sí, todo bien."] # EFECTO:conexion-
    "Si necesitás algo..."
    -> lunes_ir_casa

=== lunes_visita_elena ===
    -> elena_conversacion ->
    -> lunes_ir_casa

=== lunes_visita_diego ===

Encontrás a Diego en la esquina.

"¿Qué onda?"
"Acá. Saliendo del depósito."

Hablan un rato.
Diego también tiene miedo.

~ subir_conexion(1)

-> lunes_ir_casa

=== lunes_visita_marcos ===

Llamás a Marcos.
No contesta.

"Visto."
No responde.

-> lunes_ir_casa

=== lunes_olla ===

~ energia -= 1

Pasás por la olla.
Sofía está adentro.

"¿Buscás algo?"

* ["Pasaba nomás."]
    "Si alguna vez querés sumarte a construir..."
    -> lunes_ir_casa
* ["¿Puedo ayudar?"] # COSTO:1 # STAT:conexion # EFECTO:conexion+ # EFECTO:llama+
    ~ subir_conexion(1)
    ~ subir_llama(1)
    ~ energia -= 1
    Te ponen a ordenar cosas.
    No es mucho. Pero es algo.
    -> lunes_ir_casa

=== lunes_ir_casa ===

-> casa_llegada_noche ->

-> lunes_dormir

=== lunes_dormir ===

* [Dormir] -> lunes_fragmentos

=== lunes_fragmentos ===

# MIENTRAS DORMÍS

-> juan_fragmento_noche ->

// Fragmento del vínculo
{vinculo == "sofia": -> fragmento_sofia_lunes}
{vinculo == "elena": -> fragmento_elena_lunes}
{vinculo == "diego": -> fragmento_diego_lunes}
{vinculo == "marcos": -> fragmento_marcos_lunes}
-> lunes_cliffhanger

=== fragmento_sofia_lunes ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Sofía está agotada.

    Piensa en vos.
    En cómo te arrastraste hoy.
    En cómo aceptaste todo.

    "Así termina la gente", piensa.
    "Aceptando cualquier cosa."

    ~ bajar_salud_mental(1)
    * [Continuar] -> lunes_cliffhanger
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Sofía cierra la olla temprano.

    Nadie vino.
    Otra vez nadie vino.

    "¿Para qué?", se pregunta.

    Mañana quizás tampoco abra.

    ~ bajar_llama(1)
    * [Continuar] -> lunes_cliffhanger
}

// FRAGMENTO NORMAL
Sofía tampoco duerme bien.

Los números de la olla no cierran.
Hace tres meses que no cierran.

Mañana hay que seguir.

* [Continuar] -> lunes_cliffhanger

=== fragmento_elena_lunes ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Elena te vio hoy.

    Te vio aceptar.
    Te vio agachar la cabeza.
    Te vio convertirte en lo que no eras.

    "El 2002 también quebró gente así", piensa.
    "Los que se dejaron quebrar."

    ~ bajar_salud_mental(1)
    * [Continuar] -> lunes_cliffhanger
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Elena prende la radio.

    Hablan de la crisis.
    De los despidos.
    De la gente sola.

    Apaga la radio.
    Ella también está sola.

    "Ya nadie se cuida", piensa.

    ~ bajar_llama(1)
    * [Continuar] -> lunes_cliffhanger
}

// FRAGMENTO NORMAL
Elena no puede dormir.

La radio dice cosas.
"Antes nos cuidábamos más", piensa.

Apaga la radio.

* [Continuar] -> lunes_cliffhanger

=== fragmento_diego_lunes ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Diego piensa en vos.

    En cómo te vio hoy.
    Roto. Doblado.

    "Yo también voy a terminar así", piensa.
    "Todos terminamos así."

    Llama a su madre.
    Cuelga antes de que atienda.

    ~ bajar_salud_mental(1)
    * [Continuar] -> lunes_cliffhanger
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Diego está solo en su pieza.

    Nadie lo llamó hoy.
    Nadie lo llamó ayer.
    Nadie lo va a llamar mañana.

    Piensa en Venezuela.
    Allá estaba solo.
    Acá está solo.

    No hay diferencia.

    ~ bajar_llama(1)
    * [Continuar] -> lunes_cliffhanger
}

// FRAGMENTO NORMAL
Diego está despierto.

Piensa en su madre.
En Venezuela.
En todo lo que dejó.

* [Continuar] -> lunes_cliffhanger

=== fragmento_marcos_lunes ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Marcos te reconoce.

    Ahora sos como él.
    Quebrado. Funcional. Vacío.

    "Bienvenido", piensa.
    Pero no siente nada.

    Ya no queda nada que sentir.

    ~ bajar_salud_mental(1)
    * [Continuar] -> lunes_cliffhanger
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Marcos está solo.

    Dejó de esperar que cambie.
    Dejó de esperar que alguien llame.
    Dejó de esperar.

    La gente no se junta.
    La gente no se organiza.
    La gente no hace nada.

    Nunca lo hizo. Nunca lo hará.

    ~ bajar_llama(1)
    * [Continuar] -> lunes_cliffhanger
}

// FRAGMENTO NORMAL
Marcos está solo.
Como siempre.

No es felicidad.
Es funcionar.

* [Continuar] -> lunes_cliffhanger

=== lunes_cliffhanger ===

El celular vibra.

Un mensaje de grupo del laburo.

"Mañana reunión de área. Obligatoria."

No dice más.

* [Dormir inquieto] -> transicion_lunes_martes

=== transicion_lunes_martes ===
// Chequeo de colapso mental antes de continuar
{salud_mental <= 0:
    -> final_apagado
}

// Chequeo de destrucción del tejido social
{llama <= 0:
    -> final_sin_llama
}

-> martes_amanecer


## FILE: dias/martes.ink

// ============================================
// MARTES - LA TENSIÓN CRECE
// Routing con tunnels, contenido específico del día
// ============================================

=== martes_amanecer ===

~ dia_actual = 2
~ energia = 4

# MARTES

// --- Ecos del lunes ---
{almorzamos_juntos:
    Juan te saluda de lejos al llegar.
    Ayer almorzaron juntos.
    Hoy hay algo distinto en el saludo. Más cercano.
}
{conozco_al_kiosquero:
    Pasás por el kiosco. El tipo te saluda.
    "¿Lo de siempre?"
    Parece que ya tenés rutina.
}

// Despertar en casa
-> casa_despertar ->

// En el bondi, la gente habla de despidos
-> martes_bondi_tension

=== martes_bondi_tension ===

-> bondi_esperar_parada ->

// Contenido específico del martes: la tensión en el aire
Pero algo se siente diferente hoy.

En el micro, la gente habla de despidos.
En otras empresas, en otros lados.
"La cosa está jodida", dice alguien.

Vos escuchás.
No pensás que te toque a vos.

* [Ir al laburo] -> martes_laburo

=== martes_laburo ===

-> laburo_llegada ->

// El laburo hoy está raro - contenido específico del martes
El laburo hoy está raro.

El jefe no te mira.
Los de RRHH entran y salen.
Hay reuniones que no te incluyen.

// Chequeo mental: aguantar la tensión del martes
~ temp aguante = chequeo_mental(0, 4)
{ aguante == 2:
    Respirás hondo. Te concentrás en lo tuyo. Si pasa algo, pasa. Pero hoy estás entero.
    ~ pequenas_victorias += 1
}
{ aguante == 1:
    Intentás no pensar en eso. Te concentrás en la pantalla. Más o menos funciona.
}
{ aguante == 0:
    No podés dejar de mirar la puerta de RRHH. Cada vez que se abre, el estómago se cierra.
}
{ aguante == -1:
    Las manos te tiemblan. No podés concentrarte en nada. El miedo te paraliza.
    ~ bajar_salud_mental(1)
}

-> laburo_manana ->

// Encuentro con Juan
-> juan_saludo_manana ->

// Trabajo de rutina
-> laburo_trabajo_rutina ->

// A la tarde, la citación
-> martes_citacion

=== martes_citacion ===

A la tarde, te llaman.

-> laburo_citacion_rrhh ->

-> martes_tarde

=== martes_tarde ===

~ energia -= 1

-> laburo_tarde ->

El resto del día es largo.
Las horas no pasan.

Pensás en mañana.
En lo que puede ser.
En lo que probablemente sea.

-> laburo_salida ->

-> martes_bondi_vuelta

=== martes_bondi_vuelta ===

-> bondi_vuelta ->

A las 5 te vas.

* [Ir a casa] # EFECTO:conexion-
    -> martes_casa
* {energia >= 2} [Buscar a alguien] # COSTO:1 # STAT:conexion # EFECTO:conexion+
    -> martes_buscar

=== martes_buscar ===

~ energia -= 1

Necesitás hablar con alguien.
O solo estar con alguien.

// Chequeo social: encontrar a tu vínculo
~ temp busqueda = chequeo_social(0, 3)
{ busqueda == 2:
    Salís y te los cruzás enseguida. Como si el barrio supiera que necesitás a alguien.
}
{ busqueda == 1:
    Caminás un rato. Los encontrás.
}
{ busqueda == 0:
    Tardás en encontrar a alguien. El barrio se siente vacío hoy.
}
{ busqueda == -1:
    Caminás y caminás. No hay nadie. Estás por volverte cuando los ves a lo lejos.
    La soledad pega más fuerte cuando la buscás romper y no podés.
    ~ bajar_salud_mental(1)
}

{vinculo == "sofia": -> martes_buscar_sofia}
{vinculo == "elena": -> martes_buscar_elena}
{vinculo == "diego": -> martes_buscar_diego}
{vinculo == "marcos": -> martes_buscar_marcos}

=== martes_buscar_sofia ===

Pasás por la olla.
Sofía está cerrando.

"Hoy saliste temprano."

"Mañana tengo una reunión."

Ella te mira.
Entiende.

"Si necesitás algo..."

"Gracias."

No decís más.
No hay más que decir.

~ subir_conexion(1)

-> martes_casa

=== martes_buscar_elena ===

Pasás por lo de Elena.
Está en la vereda.

"¿Todo bien?"

"Mañana tengo una reunión en el laburo."

Elena te mira.
Ha visto esto antes.

"Vení, tomá algo."

Te sentás.
Ella no dice nada esperanzador.
No dice que todo va a estar bien.
"Acá estamos", dice. "Resistiendo."
Solo está.

~ subir_conexion(1)

-> martes_casa

=== martes_buscar_diego ===

Encontrás a Diego saliendo del depósito.

"¿Qué onda?"

"Nada. Mañana tengo una reunión."

Diego entiende.
Él vive con eso todos los días.
La precariedad.

"Si pasa algo, avisame."

"Dale."

~ subir_conexion(1)

-> martes_casa

=== martes_buscar_marcos ===

Llamás a Marcos.
No contesta.

Mandás mensaje.
"Visto" pero no responde.

Así es Marcos ahora.
Presente pero ausente.

-> martes_casa

=== martes_casa ===

-> casa_llegada_noche ->

// Contenido específico de la noche del martes: la tensión
Llegás a casa.
La noche es larga.

No dormís bien.

* [...]
-

En lo que viene.

// La angustia de la precariedad
Pensás en lo que viene. Si te echan, no hay nada. 
La "unipersonal" fue el invento perfecto: les diste tres años de tu vida y ellos no te deben ni el saludo. 
Sin indemnización. Sin despido. Sin red.
Solo una factura que ya no vas a emitir.
* [Intentar dormir] -> fragmento_martes

=== fragmento_martes ===

# MIENTRAS DORMÍS

// El fragmento de martes muestra la tensión de todos

{vinculo == "sofia": -> fragmento_sofia_martes}
{vinculo == "elena": -> fragmento_elena_martes}
{vinculo == "diego": -> fragmento_diego_martes}
{vinculo == "marcos": -> fragmento_marcos_martes}
-> fragmento_martes_default

=== fragmento_martes_default ===

La noche pasa despacio.
El barrio duerme.
Vos no.

* [...]
-

Pensás en el laburo.
En lo que significa.
En lo que sos sin él.

* [...]
-

¿Quién sos sin eso?
Mañana vas a saber.

* [Continuar] -> martes_cliffhanger

=== fragmento_sofia_martes ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Sofía piensa en vos.

    En cómo te vio hoy.
    Roto antes de tiempo.

    "Así empiezan a caer", piensa.
    "Primero la dignidad. Después todo."

    Conoció a tantos que terminaron así.
    Ahora vos también.

    ~ bajar_salud_mental(1)
    * [Continuar] -> martes_cliffhanger
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Sofía está sola en la olla.

    Nadie ayudó hoy.
    Nadie preguntó.

    "El barrio se muere", piensa.

    Antes la gente se juntaba.
    Ahora cada uno en su casa.
    Cada uno solo.

    ~ bajar_llama(1)
    * [Continuar] -> martes_cliffhanger
}

// FRAGMENTO NORMAL
# SOFÍA

Sofía tampoco duerme bien.

La olla necesita cosas.
Siempre necesita cosas.
Y cada vez hay menos.

* [...]
-

Piensa en mañana.
En la comida que hay que conseguir.
En la gente que viene.

* [...]
-

El barrio la necesita.
Eso la mantiene despierta.

* [Continuar] -> martes_cliffhanger

=== fragmento_elena_martes ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Elena prende la radio.

    Hablan de despidos masivos.
    De gente que se rompe.

    Piensa en vos.
    En lo que vio en tu cara.

    "El 2002 quebró a muchos así", piensa.
    "Los que aceptaron todo hasta que no quedó nada."

    Raúl también estuvo cerca.
    Muy cerca.

    ~ bajar_salud_mental(1)
    * [Continuar] -> martes_cliffhanger
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Elena mira por la ventana.

    El barrio oscuro.
    Todas las ventanas cerradas.

    "Ya nadie se conoce", piensa.
    "Ya nadie toca el timbre del vecino."

    Cuando Raúl murió, tres vecinos vinieron.
    Tres.

    Antes hubiera sido el barrio entero.

    ~ bajar_llama(1)
    * [Continuar] -> martes_cliffhanger
}

// FRAGMENTO NORMAL
# ELENA

Elena está con la radio.

Las noticias hablan de ajustes.
De despidos.
De lo que viene.

Ella ya vio esto antes.
Sabe cómo termina.
Sabe que solo juntos se sale.

Apaga la radio.
Mañana hay que estar atentos.

* [Continuar] -> martes_cliffhanger

=== fragmento_diego_martes ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Diego piensa en vos.

    En lo que te vi aceptar hoy.
    Todo. Sin pelear.

    "Yo voy a terminar igual", piensa.

    Dejó Venezuela para esto.
    Para terminar roto en otro país.
    Igual de roto.
    Igual de solo.

    Su madre preguntó cómo estaba.
    Mintió.

    ~ bajar_salud_mental(1)
    * [Continuar] -> martes_cliffhanger
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Diego cuenta sus contactos.

    Tres personas hablan con él.
    Tres.

    En Venezuela no tenía muchos.
    Acá tiene menos.

    "Vine a estar solo en otro idioma", piensa.

    La pieza alquilada.
    El depósito.
    Nadie.

    ~ bajar_llama(1)
    * [Continuar] -> martes_cliffhanger
}

// FRAGMENTO NORMAL
# DIEGO

Diego mira el techo.

El depósito anda raro.
Hablan de "reestructuración".
Él sabe qué significa eso.

Piensa en su madre.
En Venezuela.
En todo lo que dejó para venir acá.

No puede perder esto también.

* [Continuar] -> martes_cliffhanger

=== fragmento_marcos_martes ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Marcos te reconoce en la distancia.

    Ahora sos como él.
    Alguien que acepta.
    Alguien que se dobla.

    "Bienvenido", piensa.

    Antes también era diferente.
    Antes también tenía dignidad.

    Ahora solo funciona.
    Vos también vas a funcionar.
    Solo funcionar.

    ~ bajar_salud_mental(1)
    * [Continuar] -> martes_cliffhanger
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Marcos mira los mensajes sin leer.

    Quince personas que intentaron.
    Quince personas que dejó de lado.

    La asamblea del barrio.
    La olla.
    Los amigos.

    Todo se cayó.
    Todo se va a seguir cayendo.

    La gente no cambia nada.
    Nunca cambió nada.

    ~ bajar_llama(1)
    * [Continuar] -> martes_cliffhanger
}

// FRAGMENTO NORMAL
# MARCOS

Marcos está despierto.

La tele encendida.
El celular con mensajes sin leer.
No quiere hablar con nadie.

Antes era diferente.
Antes tenía ganas.
Ahora solo funciona.

Mañana será igual.
Siempre es igual.

* [Continuar] -> martes_cliffhanger

=== martes_cliffhanger ===

El celular vibra.

Es de RRHH.

"Confirmamos reunión mañana 11 AM. Sala 3."

No dice más.
Pero sabés que no es bueno.

* [Intentar dormir] -> transicion_martes_miercoles

=== transicion_martes_miercoles ===
// Chequeo de colapso mental antes de continuar
{salud_mental <= 0:
    -> final_apagado
}

// Chequeo de destrucción del tejido social
{llama <= 0:
    -> final_sin_llama
}

-> miercoles_amanecer


## FILE: dias/miercoles.ink

// ============================================
// MIÉRCOLES - EL DESPIDO
// Routing con tunnels, contenido específico del día
// ============================================

=== miercoles_amanecer ===

~ dia_actual = 3
~ energia = 3  // La tensión te afecta

# MIÉRCOLES

// Despertar - contenido específico del miércoles
No dormiste bien.
Hoy es la reunión con RRHH.

* [...]
-

-> casa_despertar ->

{energia < 4: Te levantás con menos energía que ayer. La tensión se siente en el cuerpo.}

* [...]
-

El café no calienta igual, o vos no sentís el calor igual.

Sabés que algo viene. No sabés qué.

* [Ir al laburo] -> miercoles_laburo

=== miercoles_laburo ===

-> bondi_esperar_parada ->

-> laburo_llegada ->

// Contenido específico: la tensión antes de la reunión
Llegás. Todo parece normal.
Los compañeros hacen lo de siempre.
Pero hay algo en el aire.

* [...]
-

El jefe no te mira. Eso es raro.

A las 11 te llaman.

* [Ir a la reunión] -> miercoles_reunion

=== miercoles_reunion ===

# LA REUNIÓN

// El despido - contenido específico del miércoles
// Usamos el módulo de laburo para la mecánica del despido
-> laburo_despido ->

// Chequeo mental: encajar el golpe del despido
~ temp golpe = chequeo_mental(0, 4)
{ golpe == 2:
    Algo en vos se endurece. No se quiebra. Se endurece.
    "Esto no me define", pensás. Y por ahora, lo creés.
    ~ pequenas_victorias += 1
}
{ golpe == 1:
    Respirás. Tragás. Seguís caminando.
    No está bien, pero podés con esto. Ahora.
}
{ golpe == 0:
    El pasillo se siente largo. Las piernas pesan.
    La cabeza repite: "tu puesto fue afectado."
    Fue. Afectado. Como si fuera algo que pasó solo.
}
{ golpe == -1:
    Se te nubla la vista. Tenés que parar en el baño.
    Te mirás al espejo. No te reconocés.
    Las manos tiemblan. El aire no entra bien.
    ~ bajar_salud_mental(1)
}

// Después del despido, contenido específico
Alguien te dice "suerte" sin mirarte a los ojos.

Salís.

* [Ir a la calle] -> miercoles_salida

=== miercoles_salida ===

-> laburo_salida_despedido ->

-> miercoles_flashback ->

// La idea involuntaria se activa
{idea_quien_soy:
    # IDEA: "¿QUIÉN SOY SIN LABURO?"

    No la elegiste. Llegó sola.
    La empresa te convenció de que eras un "socio estratégico".
    Ahora sos solo un número que ya no suma.

    La pregunta quema. ¿Sos lo que hacés o lo que sos cuando nadie te paga?
}

// Chequeo temprano: el despido puede destruirte
-> check_game_over ->

¿Qué hacés?

* [Ir a casa a procesar] # COSTO:1 # EFECTO:conexion-
    -> miercoles_casa
* [Caminar sin rumbo] # COSTO:1
    -> miercoles_caminar
* [Ir al barrio, buscar a alguien] # EFECTO:conexion+
    -> miercoles_barrio

=== miercoles_flashback ===

Salís del edificio.
El sol pega.
Es mediodía.

* [...]
-

{perdida == "familiar":
    Por un segundo, ves a tu vieja en la calle.
    No es ella. No puede ser.
    Pero por un segundo...
    Recordás cuando te dijo:
    "Mientras tengas laburo, estás bien."
    Ya no tenés laburo.
    El fantasma se desvanece.
}

{perdida == "relacion":
    Pensás en llamar a alguien.
    Por un segundo, tu dedo va al contacto.
    Todavía está ahí.
    No lo borraste.
    No llamás.
    Pero por un segundo, quisiste.
}

{perdida == "futuro":
    Recordás cuando tenías un plan.
    Ibas a ser algo.
    Tenías una forma.
    Ahora no hay forma.
    Solo hay esto.
    Un mediodía, sin laburo.
}

{perdida == "vacio":
    Hay algo.
    No sabés qué.
    Ese vacío que siempre estuvo.
    Ahora más grande.
    O quizás siempre fue así de grande.
    Y recién ahora lo ves.
}

->->

=== miercoles_casa ===

~ energia -= 1

-> casa_dia_libre ->

// Contenido específico: la casa vacía a las 12
Llegás a casa.
La casa vacía a las 12 del mediodía.
Nunca la viste así a esta hora.

* [...]
-

Te sentás.
No prendés la tele.
No hacés nada.

Solo te sentás.

{energia <= 1: Estás destruido. No podés hacer nada más hoy.}

* {energia > 1} [Llamar a alguien] -> miercoles_llamar
* [Quedarte ahí] -> miercoles_noche

=== miercoles_caminar ===

~ energia -= 1

Caminás.
No sabés bien a dónde.
Las calles de siempre pero distintas.

* [...]
-

Porque ahora tenés tiempo.
Demasiado tiempo.

Pasás por la plaza.

* [...]
-

El tipo que duerme en el banco sigue ahí.
Lo viste mil veces. Hoy lo mirás diferente.

No estás como él. Tenés tres meses.
Pero la distancia se siente más corta.

* [Seguir caminando] -> miercoles_barrio
* [Ir a casa] -> miercoles_casa

=== miercoles_barrio ===

El barrio.
Tu barrio.

A esta hora hay gente.
Gente que no ves normalmente porque estás laburando.

* [...]
-

Sofía está saliendo de su casa.
Te ve.

* [Acercarte] # STAT:conexion # EFECTO:conexion+
    -> miercoles_sofia
* [Evitarla, seguir de largo] # EFECTO:conexion-
    -> miercoles_evitar

=== miercoles_evitar ===

~ bajar_conexion(1)

Bajás la cabeza.
Seguís de largo.
No querés hablar con nadie.

Pero Sofía te vio.
Y vos la viste ver.

* [Ir a casa] -> miercoles_noche

=== miercoles_sofia ===

"¿Qué hacés acá a esta hora? ¿No tenías laburo?"

La pregunta pega.

* [Contar lo que pasó] # STAT:conexion # EFECTO:conexion+
    -> miercoles_contar
* [Evadir: "Salí temprano hoy"] # EFECTO:conexion-
    -> miercoles_evadir

=== miercoles_evadir ===

"Salí temprano hoy."

Sofía te mira.
No te cree, pero no insiste.

"Bueno. Si necesitás algo..."

Deja la frase ahí.

~ conte_a_alguien = false

* [Ir a casa] -> miercoles_noche

=== miercoles_contar ===

~ conte_a_alguien = true
~ subir_conexion(1)

"Me echaron."

Sofía no dice nada por un momento.
Después:

"Mierda."

"Sí."

"¿Estás bien?"

"No sé."

// Chequeo social: abrirte con alguien después del golpe
~ temp abrirse = chequeo_social(0, 3)
{ abrirse == 2:
    Se queda un rato. No dice nada esperanzador, no dice que todo va a estar bien.
    Pero algo en su silencio te sostiene. Sentís que podés con esto.
    ~ subir_conexion(1)
}
{ abrirse == 1:
    Se queda un momento. No te abraza, no te dice que todo va a estar bien.
    Eso lo agradecés.
}
{ abrirse == 0:
    Se queda un momento. Pero se nota que tiene la cabeza en otro lado.
    La olla, los pibes, todo lo que la aplasta a ella también.
}
{ abrirse == -1:
    Se te quiebra la voz. Mierda. No querías llorar.
    Sofía te mira. No dice nada. Esperás que no le cuente a nadie.
    ~ bajar_salud_mental(1)
}

* [...]
-

"Mirá, la olla anda complicada, pero si querés venir a dar una mano... a veces ayuda hacer algo."

* [Decir que sí] # STAT:conexion # EFECTO:conexion+ # EFECTO:llama+
    -> miercoles_si_olla
* [Decir que no sabés] # EFECTO:conexion-
    -> miercoles_nosabe_olla
* [Preguntar qué pasa con la olla]
    -> miercoles_pregunta_olla

=== miercoles_pregunta_olla ===

"¿Qué pasa con la olla?"

Sofía suspira.

"No tenemos para el viernes. Las donaciones bajaron. Estamos viendo qué hacer."

~ olla_en_crisis = true

Otra cosa que cae.
Todo cae junto.

* [Ofrecer ayuda] # EFECTO:conexion+ # EFECTO:llama+
    -> miercoles_si_olla
* [Decir que no sabés si podés] # EFECTO:conexion-
    -> miercoles_nosabe_olla

=== miercoles_si_olla ===

~ subir_conexion(1)
~ subir_llama(1)

"Puedo venir. Ahora tengo tiempo."

Sofía medio sonríe.
No es una sonrisa feliz.
Es una sonrisa de "al menos algo".

"Mañana a la tarde estamos. Si te da."

Asiente y se va.
Tenés algo para mañana.
No es mucho. Pero es algo.

* [Ir a casa] -> miercoles_noche

=== miercoles_nosabe_olla ===

"No sé si puedo. Tengo que... no sé."

Sofía asiente.

"Obvio. Si necesitás algo, avisá."

Se va.

Te quedás solo.

* [Ir a casa] -> miercoles_noche

=== miercoles_llamar ===

¿A quién llamás?

* {vinculo == "sofia"} [A Sofía] -> miercoles_llamar_sofia
* {vinculo == "elena"} [A Elena] -> miercoles_llamar_elena
* {vinculo == "diego"} [A Diego] -> miercoles_llamar_diego
* {vinculo == "marcos"} [A Marcos] -> miercoles_llamar_marcos
* [A nadie. Mejor no.] -> miercoles_noche

=== miercoles_llamar_elena ===

~ subir_conexion(1)
~ conte_a_alguien = true

Elena contesta al segundo ring.

"¿Qué pasó?"

Le contás. Ella escucha.
Cuando terminás, hay silencio.

* [...]
-

"En el 2002 cerraron el frigorífico donde laburaba Raúl."

Raúl era su marido.

* [...]
-

"Tres meses estuvo sin laburo. Yo trabajaba limpiando. Los pibes eran chicos. La olla del barrio nos salvó ese invierno."

"No sabía."

"No lo contamos mucho. Pero pasó. Y acá seguimos."

* ["¿Cómo hicieron?"] -> miercoles_elena_como
* ["Gracias por contarme."] -> miercoles_elena_gracias

=== miercoles_elena_como ===

"¿Cómo hicieron?"

"Juntos. No había otra. La gente se juntó. Los que tenían compartían con los que no. No fue lindo. Pero fue lo que hubo."

~ idea_red_o_nada = true

# IDEA DISPONIBLE: "LA RED O LA NADA"

Es una idea heredada. De Elena. De Raúl. De los que estuvieron antes.

* [Internalizar]
    ~ idea_red_o_nada = true
    La internalizás. La red o la nada.
    No es optimismo. Es lo único que hay.
    -> miercoles_elena_fin
* [Dejar pasar]
    -> miercoles_elena_fin

=== miercoles_elena_gracias ===

"Gracias por contarme."

"Para eso estamos."

-> miercoles_elena_fin

=== miercoles_elena_fin ===

Cortás.
Te sentís un poco menos solo.

* [Ir a la noche] -> miercoles_noche

=== miercoles_llamar_sofia ===

~ subir_conexion(1)
~ conte_a_alguien = true

Llamás a Sofía. Contesta enseguida, de fondo se escuchan los pibes gritando.

"Hola. ¿Todo bien?"

Le contás. La reunión, el despido, el frío en el pecho.

"Puta madre. Lo siento mucho, de verdad."

Pausa. Se escucha que le dice a uno de los hijos que se baje de la mesa.

"Mirá, hoy estamos a mil, pero mañana venite a la olla. A veces lo mejor es tener las manos ocupadas para que la cabeza no piense tanto."

* ["Voy a ir."] -> miercoles_si_olla
* ["No sé si puedo."] -> miercoles_nosabe_olla

=== miercoles_llamar_diego ===

~ subir_conexion(1)
~ conte_a_alguien = true

Diego contesta.

"¿Hola?"

"Diego, soy yo."

"¿Qué onda? ¿No estás laburando?"

Le contás.

"La puta madre."

"Sí."

"¿Estás bien?"

"No sé."

Hay un silencio.

"Yo tengo miedo de que me pase lo mismo. En el depósito andan raros también."

Diego también tiene miedo.
No estás solo en eso.

"Si necesitás algo, avisá. No tengo mucho pero..."

"Gracias, Diego."

* [Ir a la noche] -> miercoles_noche

=== miercoles_llamar_marcos ===

Marcos no contesta.
El teléfono suena y suena.

Bueno.
No esperabas otra cosa.

* [Ir a la noche] -> miercoles_noche

=== miercoles_noche ===

# MIÉRCOLES - NOCHE

~ energia = 0

-> check_game_over ->

-> casa_llegada_noche ->

// Contenido específico de la noche del miércoles
La noche llega.
Primer día sin laburo.

Te acostás pero no dormís.
La cabeza no para.

* [...]
-

La tarjeta. El alquiler. La obra social.
Tenés tres meses. Tres meses para resolver algo.

La cuenta regresiva empezó.

{conte_a_alguien: Al menos alguien sabe. No estás completamente solo.}
{not conte_a_alguien: No le contaste a nadie. El peso es solo tuyo.}

// Fragmento nocturno
-> fragmento_miercoles

=== fragmento_miercoles ===

# MIENTRAS DORMÍS (o intentás)

// El fragmento depende de las decisiones del día
{conte_a_alguien && vinculo == "sofia":
    -> fragmento_sofia_miercoles
}
{conte_a_alguien && vinculo == "diego":
    -> fragmento_diego_miercoles
}
{conte_a_alguien && vinculo == "elena":
    -> fragmento_elena_miercoles
}
{conte_a_alguien && vinculo == "marcos":
    -> fragmento_marcos_miercoles
}
// Default
{vinculo == "marcos": -> fragmento_marcos_miercoles}
{vinculo == "sofia": -> fragmento_sofia_miercoles}
{vinculo == "elena": -> fragmento_elena_miercoles}
-> fragmento_diego_miercoles

=== fragmento_sofia_miercoles ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Sofía piensa en vos.

    En cómo te vio salir del edificio.
    Vacío. Roto.

    "Así empiezan todos", piensa.
    "Primero el despido. Después la nada."

    La olla está llena de gente así.
    Gente que era otra cosa.
    Ahora solo sobreviven.

    Vos vas a ser uno más.

    ~ bajar_salud_mental(1)
    * [Continuar] -> transicion_miercoles_jueves
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Sofía está en la olla vacía.

    Hoy nadie vino a ayudar.
    Mañana tampoco van a venir.

    "El barrio se deshace", piensa.

    Cada uno con su problema.
    Cada uno solo.
    Ya nadie viene.

    La olla va a cerrar.
    Es cuestión de tiempo.

    ~ bajar_llama(1)
    * [Continuar] -> transicion_miercoles_jueves
}

// FRAGMENTO NORMAL
Sofía tampoco puede dormir.

Está en la cocina, con la calculadora.
Los números de la olla no cierran.
Nunca cierran.

* [...]
-

Piensa en vos.
Otro que cayó.
Pero también: otra persona que puede ayudar.

* [...]
-

No es que se alegre de que te echaron.
Pero hay algo en que no estés solo.
En que quizás vengas mañana.

Apaga la luz.
Mañana hay que seguir.

* [Continuar] -> transicion_miercoles_jueves

=== fragmento_diego_miercoles ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Diego piensa en vos.

    En cómo te vio hoy.
    Destruido. Humillado.

    "Yo también voy a terminar así", piensa.
    "Todos los que venimos de afuera terminamos así."

    Dejó todo en Venezuela.
    Para esto.
    Para ver cómo te rompen en otro país.

    Su madre preguntó cómo estaba.
    "Bien, má."
    Mentira.

    Todo es mentira.

    ~ bajar_salud_mental(1)
    * [Continuar] -> transicion_miercoles_jueves
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Diego está solo en su pieza.

    Llegó hace dos años.
    Tiene tres contactos en el celular.
    Tres.

    "Vine acá para estar solo en otro idioma", piensa.

    En Venezuela no tenía a nadie.
    Acá no tiene a nadie.

    No hay diferencia.
    Nunca hubo.

    ~ bajar_llama(1)
    * [Continuar] -> transicion_miercoles_jueves
}

// FRAGMENTO NORMAL
Diego está en su pieza.
Alquilada, chica, con olor a humedad.

Piensa en vos.
En lo que le contaste.
En que podría ser él mañana.

* [...]
-

Llama a su madre.
"Sí, má, todo bien."
Miente.

Cuelga.
Mira el techo.

* [...]
-

No sabe qué hacer.
Quiere ayudarte pero no sabe cómo.
Quiere ayudarse pero no sabe cómo.

Mañana te va a buscar.
No sabe para qué. Pero te va a buscar.

* [Continuar] -> transicion_miercoles_jueves

=== fragmento_elena_miercoles ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Elena piensa en Raúl.

    Él también se rompió.
    En el 2002, cuando cerró el frigorífico.

    Por tres meses fue otra persona.
    Vacía. Derrotada.

    Piensa en vos.
    En tu voz hoy.

    "Ya empezó a romperse", piensa.
    Y sabe que es difícil volver de eso.

    Raúl nunca volvió del todo.
    Murió un poco roto.

    ~ bajar_salud_mental(1)
    * [Continuar] -> transicion_miercoles_jueves
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Elena está sola.

    Raúl murió hace tres años.
    Los hijos viven lejos.

    El barrio ya no es lo que era.
    Ya nadie se junta.
    Ya nadie toca timbre.

    "Nos volvimos un país de solos", piensa.

    Antes había red.
    Ahora hay puertas cerradas.

    ~ bajar_llama(1)
    * [Continuar] -> transicion_miercoles_jueves
}

// FRAGMENTO NORMAL
Elena no puede dormir.

Piensa en Raúl.
En el 2002.
En cómo pensó que no iban a salir.
Y salieron. Juntos.

Piensa en vos.
En lo que le contaste.
En la voz que tenías.

Mañana te va a llamar.
Va a ver cómo estás.
Es lo que se hace.

Prende la radio bajito.
Algo de compañía en la oscuridad.

* [Continuar] -> transicion_miercoles_jueves

=== fragmento_marcos_miercoles ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Marcos piensa en vos.

    Ahora somos iguales. 
    Dos descartes del sistema.

    "Ya vas a entender", piensa.
    "Que no importa cuánto te esfuerces."
    "Al final, sos solo una pieza que se cambia."

    Él ya no pelea. 
    Espera que vos tampoco lo hagas. 
    Es más fácil así.

    ~ bajar_salud_mental(1)
    * [Continuar] -> transicion_miercoles_jueves
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Marcos mira el teléfono. 
    
    Vio tu llamada perdida. 
    Vio el mensaje.
    
    No respondió. 
    
    "Para qué", se pregunta. 
    "Un despedido consolando a otro despedido."
    "Una miseria compartida no es menos miseria."
    
    Mejor el silencio. 
    En el silencio no hay que fingir nada.

    ~ bajar_llama(1)
    * [Continuar] -> transicion_miercoles_jueves
}

// FRAGMENTO NORMAL
Marcos mira la tele. 
Programas de política que ya no le dicen nada. 
Gente de traje hablando de "macroeconomía" mientras el barrio se cae a pedazos.

Piensa en vos. 
En que te echaron. 
En que ahora sabés lo que se siente.

"Cagaste, uruguayo", murmura para el cuarto vacío. 

Pero hay algo en su mirada. 
Un resto de bronca que todavía no se convirtió en ceniza.

Mañana será otro día.

* [Continuar] -> transicion_miercoles_jueves

=== transicion_miercoles_jueves ===
// Chequeo de colapso mental antes de continuar
{salud_mental <= 0:
    -> final_apagado
}

// Chequeo de destrucción del tejido social
{llama <= 0:
    -> final_sin_llama
}

-> jueves_amanecer


## FILE: dias/jueves.ink

// ============================================
// JUEVES - EL PRIMER DIA SIN LABURO
// Patron modular con tunnels
// ============================================

// Tunnels usados de otros modulos:
// - escenas/olla.ink: olla_llegada, olla_ayudar_cocina, olla_escuchar_crisis
// - escenas/barrio.ink: barrio_caminar_manana, barrio_caminar_sin_rumbo
// - personajes/sofia.ink: sofia_primer_encuentro, sofia_invitar_ayudar, sofia_agradecimiento
// - personajes/elena.ink: elena_historia_2002
// - personajes/diego.ink: diego_encuentro_barrio, diego_enterarse_despido, diego_caminar_juntos
// - personajes/marcos.ink: marcos_no_esta

=== jueves_amanecer ===

~ dia_actual = 4
~ energia = 4  // Dormiste mal, pero el cuerpo se adapta

# JUEVES

// --- Ecos del miércoles ---
{conte_a_alguien:
    El celular tiene un mensaje.
    {vinculo == "sofia": Sofía: "¿Cómo amaneciste?"}
    {vinculo == "elena": Elena: "Pensé en vos anoche. Pasá si querés."}
    {vinculo == "diego": Diego: "Che, cualquier cosa avisá."}
    {vinculo == "marcos": Marcos no escribió. Pero vos sabés que sabe.}
    {vinculo == "ixchel": Ixchel: "Buenos días. Hoy cocino temprano si querés venir."}
}
{not conte_a_alguien:
    Silencio.
    El celular no suena.
    Nadie sabe.
    Nadie va a preguntar.
}

Te despertás.
Por un segundo, pensás que tenés que ir a laburar.

Después te acordás.

* [...]
-

Ya no tenés laburo.

El despertador no sonó porque lo apagaste.
¿Para qué madrugar?

~ tiene_laburo = false

* [Levantarte igual] # EFECTO:dignidad+
    -> jueves_manana
* [Quedarte en la cama] # COSTO:1 # EFECTO:dignidad-
    -> jueves_cama

=== jueves_cama ===

~ energia -= 1

Te quedás.
Mirás el techo.
Pensás.

¿Cuánto duran tres meses?
¿Cuánto tarda en aparecer otro laburo?
¿Qué pasa si no aparece?

La cabeza no para.

Eventualmente te levantás.
El cuerpo no aguanta más la cama.

-> jueves_manana_tarde

=== jueves_manana ===

Te levantás.
El café.
La rutina, pero vacía.

Moler.
Agua caliente.
Prensa francesa.

* [...]
-

El único mecanismo de supervivencia que hoy parece confiable.

Antes el café era apurado, entre ducharte y salir.
Ahora tenés todo el tiempo del mundo.

* [...]
-

Demasiado tiempo.

-> jueves_manana_tarde

=== jueves_manana_tarde ===

Son las 10 de la mañana.
Normalmente estarías laburando.

Ahora estás acá.
En tu casa.
Sin saber qué hacer.

{conte_a_alguien: Al menos alguien sabe. No estás completamente solo en esto.}
{not conte_a_alguien: Nadie sabe todavía. El peso es solo tuyo.}

¿Qué hacés hoy?

* [Buscar laburo online] # COSTO:1 # STAT:dignidad # EFECTO:dignidad-
    -> jueves_buscar_laburo
* [Ir al barrio] # EFECTO:conexion?
    -> jueves_barrio
* [Quedarte en casa] # COSTO:1 # STAT:conexion # EFECTO:conexion-
    -> jueves_quedarse

=== jueves_buscar_laburo ===

~ energia -= 1

Abrís las páginas de empleo.
Hay ofertas.
Pocas que sirvan.

* [...]
-

"Se busca. Experiencia mínima 5 años."
"Se busca. Hasta 25 años."
"Se busca. Disponibilidad full time. Pago por productividad."

* [...]
-

Mandás algunos CVs.
No esperás respuesta.
Pero hay que hacer algo.

~ bajar_dignidad(1)

{energia > 0: Todavía podés hacer algo más hoy.}

* {energia > 0} [Salir al barrio] -> jueves_barrio
* [Ya fue, quedarse] -> jueves_noche

=== jueves_quedarse ===

~ energia -= 1
~ bajar_conexion(1)

Te quedás.
La tele.
El celular.
Nada.

Las horas pasan.
No hacés nada.
No hablás con nadie.

Es fácil quedarse.
Demasiado fácil.

* [Ir a la noche] -> jueves_noche

=== jueves_barrio ===

// Contexto del barrio
Salís.
-> barrio_caminar_manana ->
// Continua con opciones del dia

* [Ir a la olla] # EFECTO:llama+
    -> jueves_olla
* [Caminar nomás] -> jueves_caminar
* [Buscar a tu vínculo] # EFECTO:conexion+
    -> jueves_buscar_vinculo

=== jueves_caminar ===

// Usar tunnel del barrio
-> barrio_caminar_sin_rumbo ->

// Contenido específico del día
El tipo que duerme en la plaza sigue ahí.
Lo viste mil veces.
Hoy lo mirás diferente.

* [...]
-

No sos él.
Tenés tres meses.
Pero la distancia se siente más corta.

* [Volver a casa] -> jueves_noche
* [Ir a la olla] -> jueves_olla

=== jueves_olla ===

~ fui_a_olla_jueves = true

// Llegada a la olla
-> olla_llegada ->

Sofía está ahí.
Y otra gente que no conocés bien.

// Encuentro con Sofia
-> sofia_primer_encuentro ->

{conte_a_alguien && vinculo == "sofia":
    -> jueves_olla_ayudar
}

{not conte_a_alguien || vinculo != "sofia":
    * ["Me echaron ayer."]
        ~ conte_a_alguien = true
        // Chequeo social: abrirte ante desconocidos en la olla
        # DADOS:CHEQUEO
        ~ temp resultado_jueves_abrirte = chequeo_completo_social(0, 4)
        { resultado_jueves_abrirte == 2:
            Sofía asiente. Algo en tu voz fue real. Crudo.
            "Gracias por contarlo. No es fácil."
            Te pone una mano en el hombro. Firme.
            "Acá nadie juzga. ¿Querés dar una mano?"
            ~ subir_conexion(2)
            ~ subir_salud_mental(1)
        }
        { resultado_jueves_abrirte == 1:
            Sofía asiente. No dice "qué bajón" ni "vas a conseguir algo".
            Solo asiente.
            "Bueno. ¿Querés dar una mano?"
            ~ subir_conexion(1)
        }
        { resultado_jueves_abrirte == 0:
            Sofía te mira. Asiente.
            "Está jodido. Lo sé."
            No hay mucho más. Pero no te rechaza.
        }
        { resultado_jueves_abrirte == -1:
            Las palabras salen mal. Entrecortadas.
            Sofía te mira sin entender del todo.
            "¿Perdón?"
            "Nada. Nada."
            La vergüenza te traga. No podés ni decirlo en voz alta.
            ~ bajar_salud_mental(1)
        }
        -> jueves_olla_pregunta
    * ["Tenía el día libre."]
        Sofía te mira.
        No te cree.
        Pero no insiste.
        -> sofia_invitar_ayudar ->
        -> jueves_olla_pregunta
}

=== jueves_olla_pregunta ===

¿Querés ayudar?

* [Sí] # EFECTO:conexion+ # EFECTO:llama+
    -> jueves_olla_ayudar
* [Solo vine a ver] # EFECTO:conexion-
    -> jueves_olla_ver

=== jueves_olla_ver ===

"Solo vine a ver."

Sofía asiente.
"Bueno. Cuando quieras."

// Ambiente normal de trabajo
-> olla_ambiente_normal ->

// NUEVO: Avistamiento de Marcos
{not vino_marcos:
    De reojo, ves a alguien en la esquina.
    Campera oscura. Cabeza gacha.
    
    Es Marcos.
    
    Está mirando la olla desde lejos.
    Como si quisiera entrar pero una pared invisible lo frenara.
    
    * [Salir a buscarlo]
        Salís rápido.
        Pero Marcos te ve venir.
        Gira y se va. Casi corriendo.

        La vergüenza es más rápida que vos.
        -> jueves_olla_ver_post
    * [Dejarlo mirar]
        Lo dejás estar.
        A veces, mirar es el primer paso.

        Se queda un minuto más. Y se va.
        -> jueves_olla_ver_post
}

= jueves_olla_ver_post

* [Irte] -> jueves_noche

=== jueves_olla_ayudar ===

// Tunnel de ayudar en la cocina
-> olla_ayudar_cocina ->

// Encuentro con Ixchel en la cocina de la olla
{ixchel_relacion == 0:
    En la cocina hay alguien que no conocés.

    Una mujer baja, morena, pelo largo recogido.
    Pica verduras con una precisión que parece innata.

    -> ixchel_primer_encuentro_olla ->
}
{ixchel_relacion >= 1:
    Ixchel está en la cocina.
    Te saluda con un gesto breve.

    -> ixchel_en_olla ->
}

// Escuchar sobre la crisis
-> olla_escuchar_crisis ->

"Si no conseguimos algo para el viernes, no sé qué hacemos", dice alguien.

// Sofia en silencio ante la crisis
Sofía no dice nada.
Solo sigue cocinando.

{idea_tengo_tiempo == false:
    # IDEA DISPONIBLE: "AHORA TENGO TIEMPO"

    Antes no podías.
    Laburabas, llegabas cansado, no había espacio.
    Ahora sí.

    * [Internalizar la idea]
        ~ idea_tengo_tiempo = true
        Ahora tenés tiempo.
        No es consuelo. Pero es algo que podés dar.
        -> jueves_olla_fin
    * [Dejar pasar]
        -> jueves_olla_fin
- else:
    -> jueves_olla_fin
}

=== jueves_olla_fin ===

Terminás de ayudar.
Son las 3 de la tarde.

// Agradecimiento de Sofia
-> sofia_agradecimiento ->

* [Ir a casa] -> jueves_noche

=== jueves_buscar_vinculo ===

{vinculo == "sofia": -> jueves_olla}
{vinculo == "elena": -> jueves_elena}
{vinculo == "diego": -> jueves_diego}
{vinculo == "marcos": -> jueves_marcos}

=== jueves_elena ===

// Ir a buscar a Elena lleva a la olla donde está ayudando
Buscás a Elena.
No está en la plaza. No está en su casa.

Probás en la olla.

# LA OLLA

Ahí está.
Sentada en un banquito.
Pelando papas.

"Ah, m'hijo. Vos acá."

* [Sentarte a pelar con ella]
    -> jueves_charla_elena
* [Solo saludar y mirar]
    "Solo pasaba a saludar."
    "Bueno. Cuando quieras, agarrá un cuchillo."
    -> jueves_noche

=== jueves_charla_elena ===

~ ayude_en_olla = true

Te sentás a su lado.
Agarrás un cuchillo.
Un balde de papas entre los dos.

Estás en la cocina de la olla.
Elena pela papas a tu lado.

* [...]
-

// Preparar el chequeo de dados
~ temp modificador = 0

{elena_relacion >= 3:
    ~ modificador = 1
}

{escuche_sobre_2002:
    ~ modificador = modificador + 1
}

~ temp resultado = chequeo(modificador, 4)

{
- resultado == 2:  // Crítico
    # PORTRAIT:elena,remembering,right

    Pelás en silencio un rato.

    Elena para de pelar.
    Te mira.

    "Vos me hacés acordar a Raúl."

    Pausa larga.

    "Él también se sentaba así. Pelando. Sin decir nada.
    Pero estando."

    Se le humedecen los ojos.
    No dice más.
    No hace falta.

    ~ elena_relacion += 2
    ~ subir_conexion(1)

    {idea_pedir_no_debilidad == false:
        # IDEA DISPONIBLE: "PEDIR AYUDA NO ES DEBILIDAD"

        Hay algo en el silencio compartido.
        En estar sin tener que explicar.
        En ayudar sin que te lo pidan.

        * [Internalizar la idea]
            ~ idea_pedir_no_debilidad = true

            # IDEA: "PEDIR AYUDA NO ES DEBILIDAD"

            Pedir ayuda no es debilidad.
            Estar para alguien no es caridad.
            Es lo que se hace.
            -> jueves_elena_fin
        * [Dejar pasar]
            -> jueves_elena_fin
    - else:
        -> jueves_elena_fin
    }

- resultado == 1:  // Éxito
    # PORTRAIT:elena,wise,right

    Elena te mira las manos.
    "No aprietes tanto, m'hijo. La papa siente que tenés miedo."
    
    Se ríe, pero con cariño.
    
    "Estás acá ayudando, sí. Pero te veo los ojos.
    Tenés miedo de terminar necesitando el plato vos también."
    
    Te quedás helado. Elena ve todo.
    
    "En el 2002 nos pasaba lo mismo.
    Nos daba vergüenza caer. Como si fuera culpa nuestra."
    
    Te muestra cómo pela ella.
    Rápido. Eficiente. Memoria muscular de la crisis.
    
    "Pero escuchame bien:
    Esto no es un pozo donde caés.
    Es una trinchera donde nos juntamos."
    
    "El de arriba te quiere con vergüenza y solo.
    Acá te queremos con orgullo y juntos."

    -> elena_historia_2002 ->

    Hay algo cómodo en el silencio compartido.
    Las manos ocupadas. La mente quieta.

    ~ elena_relacion += 1
    ~ subir_conexion(1)

    -> jueves_elena_fin

- resultado == -1:  // Fumble
    # PORTRAIT:elena,worried,right

    Pelás apurado.
    Sin concentrarte.

    Te cortás el dedo con el cuchillo.

    "¡Pará, pará!"

    Elena deja todo.
    Te cura con alcohol.
    Duele.

    "Despacio, pibe. Esto no es carrera."

    Te venda el dedo con un trapo limpio.

    Es un momento íntimo.
    Raro. Pero íntimo.

    Como si fueras su hijo.
    Como si ella fuera tu abuela.

    ~ elena_relacion += 1

    -> jueves_elena_fin

- else:  // Fallo normal
    # PORTRAIT:elena,neutral,right

    Pelás en silencio.
    Elena también.

    El trabajo fluye.
    Sin palabras.

    No está mal.
    A veces el silencio es suficiente.

    Las papas se acumulan.
    El tiempo pasa.

    // En el fallo normal, Elena habla del barrio
    -> elena_hablar_barrio ->

    -> jueves_elena_fin
}

=== jueves_elena_fin ===

Terminás de ayudar.
Las manos mojadas. El olor a papa.

Elena asiente.
"Gracias por la mano, m'hijo."

* [Irte] -> jueves_noche

=== jueves_diego ===

// Encuentro casual con Diego
-> diego_encuentro_barrio ->

// Diego se entera del despido
-> diego_enterarse_despido ->

* [Caminar juntos un rato]
    // Tunnel de caminar juntos
    -> diego_caminar_juntos ->
    -> jueves_noche
* [Irte]
    -> jueves_noche

=== jueves_marcos ===

// Marcos no está disponible
-> marcos_no_esta ->

* [Irte] -> jueves_noche

=== jueves_noche ===

# JUEVES - NOCHE

~ energia = 0

-> check_game_over ->

Primer día completo sin laburo.

Te acostás temprano.
¿Para qué quedarse despierto?

* [...]
-

La cabeza sigue dando vueltas.
Tres meses.
Noventa días.
La cuenta regresiva.

// Chequeo mental: enfrentar la primera noche sin laburo
# DADOS:CHEQUEO
~ temp resultado_jueves_noche = chequeo_completo_mental(0, 4)
{ resultado_jueves_noche == 2:
    Pero algo te frena el espiral.
    Un pensamiento claro entre la niebla:
    "Hoy pasó el primer día. Y seguís acá."
    No es mucho. Pero es suficiente para cerrar los ojos.
    ~ subir_dignidad(1)
}
{ resultado_jueves_noche == 1:
    {ayude_en_olla: Pero hoy hiciste algo. Ayudaste en la olla. Eso es algo.}
    {fui_a_olla_jueves && not ayude_en_olla: Fuiste a la olla. Viste algo. Quizás mañana.}
    {not fui_a_olla_jueves: No saliste mucho. Mañana quizás.}
}
{ resultado_jueves_noche == 0:
    {ayude_en_olla: Ayudaste en la olla. Pero no alcanza para silenciar la cabeza.}
    {not ayude_en_olla: El día pasó. No hiciste mucho. La culpa no deja dormir.}
    Las tres de la mañana. Seguís despierto. Mirando el techo.
}
{ resultado_jueves_noche == -1:
    La cabeza no para. No para. No para.
    ¿Qué hice mal? ¿Podría haber hecho algo distinto?
    ¿Voy a terminar en la calle?
    El pensamiento se repite en loop. Hasta las cinco de la mañana.
    ~ bajar_salud_mental(1)
}

// Juan te llama
{vinculo == "sofia" || vinculo == "elena" || vinculo == "diego":
    -> juan_encuentro_jueves ->
}

El viernes viene.
La olla necesita resolver algo.
Vos también.

* [Dormir] -> fragmento_jueves

=== fragmento_jueves ===

# MIENTRAS DORMÍS

{vinculo == "sofia": -> fragmento_sofia_jueves ->}
{vinculo == "elena": -> fragmento_elena_jueves ->}
{vinculo == "diego": -> fragmento_diego_jueves ->}
{vinculo == "marcos": -> fragmento_marcos_jueves ->}

-> fragmento_comun_jueves

=== fragmento_marcos_jueves ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Marcos piensa en vos.

    Ya sos como él.
    Roto. Funcional. Vacío.

    "Ahora entendés", piensa.

    No hay salida.
    Solo hay aceptar.
    Aceptar que esto es todo.
    Que nunca fue más.

    Mañana va a ser igual.
    Siempre igual.

    { chance(50):
        ~ bajar_salud_mental(1)
    }
    ->->
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Marcos mira el celular.

    Veinte mensajes sin leer.
    La asamblea del barrio.
    Invitaciones.
    Gente que intenta.

    "Para qué", piensa.

    La gente no cambia nada.
    Nunca cambió nada.
    Nunca va a cambiar nada.

    Mejor solo.
    Mejor apagado.

    { chance(60):
        ~ bajar_llama(1)
    }
    ->->
}

// FRAGMENTO NORMAL
# MARCOS

Marcos tampoco duerme.

El departamento vacío.
La tele encendida sin sonido.
Los mensajes sin responder.

Pensó en ir a la asamblea.
No fue.
Es más fácil no ir.

Mañana es otro día igual.

->->

=== fragmento_sofia_jueves ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Sofía mira la olla vacía.

    Piensa en toda la gente que pasó por acá.
    Gente que llegó rota.
    Gente que se fue más rota.

    Vos sos uno más.

    "No sé si puedo seguir viendo esto", piensa.

    Cada día llega alguien más destruido.
    Cada día la olla alcanza para menos.

    Todo cae.
    Todo se rompe.

    { chance(50):
        ~ bajar_salud_mental(1)
    }
    ->->
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Sofía está sola en la cocina.

    Hoy vino poca gente.
    Mañana va a venir menos.

    "La olla se muere", piensa.

    Cuando empezó, el barrio se juntaba.
    Ahora cada uno se salva solo.

    O no se salva.

    La llama se apaga.
    Y ella no sabe cómo volver a prenderla.

    { chance(60):
        ~ bajar_llama(1)
    }
    ->->
}

// FRAGMENTO NORMAL
# SOFÍA

// Fragmento nocturno de Ixchel
-> ixchel_fragmento_noche ->

// Sofia pensando
-> sofia_fragmento_pensar ->

Mañana hay que buscar soluciones.

->->

=== fragmento_elena_jueves ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Elena piensa en toda la gente que vio romperse.

    En el 2002 fueron muchos.
    Gente que no volvió a ser la misma.

    Raúl también se rompió.
    Siguió funcionando.
    Pero algo murió en él.

    Vos también te estás rompiendo.
    Ella lo ve.

    "Ojalá alcance el tejido para sostenerlo", piensa.
    Pero no está segura.

    { chance(50):
        ~ bajar_salud_mental(1)
    }
    ->->
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Elena prende la radio.

    Hablan de la crisis.
    De cómo la gente ya no se ayuda.

    "Tienen razón", piensa.

    El barrio ya no es barrio.
    Son casas una al lado de la otra.
    Nada más.

    Cuando Raúl murió, tres vecinos vinieron.
    Antes hubiera sido el barrio entero.

    Ya no hay barrio.
    Ya no hay nada.

    { chance(60):
        ~ bajar_llama(1)
    }
    ->->
}

// FRAGMENTO NORMAL
# ELENA

// Fragmento nocturno de Elena
-> elena_fragmento_noche ->

->->

=== fragmento_diego_jueves ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Diego piensa en Venezuela.

    Dejó todo para venir acá.
    Para esto.
    Para ver cómo te humillan en otro idioma.

    Su madre pregunta cómo está.
    "Bien, má."
    Mentira.

    Piensa en vos.
    En cómo te vio hoy.
    Destruido.

    "Yo voy a terminar igual", piensa.
    "Todos terminamos igual."

    { chance(50):
        ~ bajar_salud_mental(1)
    }
    * [Continuar] -> jueves_cliffhanger
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Diego cuenta.

    Tres personas le hablan en Uruguay.
    Tres.

    Su familia está en Venezuela.
    Sus amigos quedaron allá.

    Acá no tiene a nadie.

    "Crucé un continente para estar solo", piensa.

    En Venezuela estaba solo.
    Acá está solo.

    No hay diferencia.

    { chance(60):
        ~ bajar_llama(1)
    }
    ->->
}

// FRAGMENTO NORMAL
# DIEGO

// Fragmento nocturno de Diego
-> diego_fragmento_noche ->

->->

=== fragmento_comun_jueves ===

// Olla cerrada de noche
-> olla_cerrar_noche ->

// Fragmento de Ixchel (si no fue visto en Sofia)
{fui_a_olla_jueves && vinculo != "sofia":
    -> ixchel_fragmento_noche ->
}

El barrio duerme.
Los problemas no.

* [Continuar] -> jueves_cliffhanger

// Fragmento de Ixchel (ex Yulimar)
{fui_a_olla_jueves:
    -> ixchel_fragmento_noche ->
}

* [Continuar] -> jueves_cliffhanger

=== jueves_cliffhanger ===

{conte_a_alguien && vinculo != "marcos":
    El celular vibra.

    {vinculo == "sofia":
        Sofía: "Mañana necesito hablar. Es sobre la olla. Urgente."
    }
    {vinculo == "elena":
        Elena: "Mañana te llamo temprano. Hay algo."
    }
    {vinculo == "diego":
        Diego: "Che, mañana te busco. Tengo una idea."
    }
}

* [Dormir] -> transicion_jueves_viernes

=== transicion_jueves_viernes ===
// Chequeo de colapso mental antes de continuar
{salud_mental <= 0:
    -> recovery_mental_jueves
}
- (post_recovery_jueves)

// Chequeo de destrucción del tejido social
{llama <= 0:
    -> final_sin_llama
}

-> viernes_amanecer

=== recovery_mental_jueves ===
Todo se pone oscuro. La cabeza no funciona.

* [...]
-

{conexion <= 1 && llama <= 1:
    No hay nada.
    No hay nadie.
    No hay razón.

    -> final_apagado
}

Pero algo te sostiene. Un recuerdo. Una cara. Algo.

~ salud_mental = 1

No estás bien. Pero seguís.

-> transicion_jueves_viernes.post_recovery_jueves


## FILE: dias/viernes.ink

// ============================================
// VIERNES - LA CRISIS DE LA OLLA
// Patron modular con tunnels
// ============================================

// Tunnels usados de otros modulos:
// - escenas/olla.ink: olla_llegada, olla_ambiente_crisis, olla_colecta_callejera,
//                     olla_pedir_vecinos, olla_resultado_colecta, olla_servir
// - escenas/barrio.ink: barrio_caminar_tarde
// - personajes/sofia.ink: sofia_reunion_crisis, sofia_pedir_ideas
// - personajes/elena.ink: elena_canastas, elena_pedir
// - personajes/diego.ink: diego_colecta

=== viernes_amanecer ===

~ dia_actual = 5
~ energia = 4

# VIERNES

// --- Ecos del jueves ---
{fui_a_olla_jueves:
    Te acordás de ayer en la olla.
    Las manos con olor a cebolla.
    Las caras.
    Hoy hay que volver.
}
{ayude_a_diego:
    Diego te mandó un mensaje anoche: "Gracias por la mano, che."
}

Dos días sin laburo.
Se siente más largo.

El viernes antes era el mejor día.
Fin de semana, descanso, algo de plata.

* [...]
-

Ahora es solo otro día.

{fui_a_olla_jueves: Sofía dijo que hoy necesitaban resolver algo. La olla está en crisis.}

* [Levantarte] -> viernes_manana

=== viernes_manana ===

El café.
La mañana.

El sostén energético más honesto: algo caliente y amargo que te hace funcionar.

{olla_en_crisis:
    Pensás en la olla.
    En que dijeron que no tenían para hoy.
    En que hay gente que depende de eso.
}

¿Qué hacés hoy?

* [Ir a la olla temprano] # EFECTO:llama+
    -> viernes_olla_temprano
* [Buscar laburo primero] # COSTO:1 # STAT:dignidad # EFECTO:dignidad-
    -> viernes_buscar
* [Ver qué pasa]
    -> viernes_barrio

=== viernes_buscar ===

~ energia -= 1
~ bajar_dignidad(1)

Abrís la compu.
Más CVs.
Más portales.

Hay una oferta que parece real.
Mandás.

No esperás respuesta.
Pero hay que seguir intentando.

{energia > 1:
    Todavía es temprano. Podés ir a la olla.
    * [Ir a la olla]
        -> viernes_olla_temprano
    * [Quedarte buscando] # COSTO:1
        ~ energia -= 1
        Seguís buscando.
        Las horas pasan.
        A las 3 dejás.
        -> viernes_tarde
}

* [Ir a la tarde] -> viernes_tarde

=== viernes_barrio ===

Salís a caminar.
El barrio.

A esta hora la gente hace sus cosas.
Compras, trámites, vida.

Pasás por la olla.
Hay movimiento.

* [Entrar] -> viernes_olla_temprano
* [Seguir de largo] -> viernes_tarde

=== viernes_olla_temprano ===

~ energia -= 1

// Llegada a la olla
-> olla_llegada ->

// Eco: Elena recuerda si le contaste tu historia
-> viernes_olla_elena_eco ->

// Ambiente de crisis
-> olla_ambiente_crisis ->

// Reunion de crisis con Sofia
-> sofia_reunion_crisis ->

Te ven.

{ayude_en_olla:
    // Sofia pide ideas
    -> sofia_pedir_ideas ->
    -> viernes_reunion
- else:
    Sofía te mira.
    "¿Venís a ayudar o a mirar?"
    * ["A ayudar."] # STAT:conexion
        ~ ayude_en_olla = true
        ~ subir_conexion(1)
        "Bien. Porque estamos en el horno."
        -> viernes_reunion
    * ["Solo pasaba."]
        "Bueno. Si te animás, acá estamos."
        -> viernes_tarde
}

=== viernes_reunion ===

# LA REUNION DE LA OLLA

Están: Sofía, Elena, dos o tres más que no conocés bien.

El problema es simple:
No hay plata para la comida de hoy.
Vienen 30 personas a comer.
No tienen qué darles.

* [...]
-

"Las donaciones no llegaron."
"El municipio no contesta."
"Los comercios ya dijeron que no."

Silencio.

¿Qué se puede hacer?

* [Proponer una colecta rápida] # EFECTO:dignidad+ # EFECTO:llama+
    -> viernes_colecta
* [Proponer pedir a vecinos] # EFECTO:dignidad+ # EFECTO:llama+
    -> viernes_vecinos
* [Proponer cancelar por hoy] # EFECTO:llama- # EFECTO:dignidad+
    -> viernes_cancelar_olla
* [Quedarte callado, escuchar] -> viernes_escuchar

=== viernes_escuchar ===

No decís nada.
Escuchás.

Los demás discuten.
Ideas van y vienen.

// Elena propone las canastas
-> elena_canastas ->

-> viernes_plan

=== viernes_colecta ===

"¿Y si hacemos una colecta? Rápida. Hoy."

Te miran.

"¿Cómo?"

"No sé. Golpear puertas. Pedir en la calle. Algo."

Sofía lo piensa.
"Es arriesgado. Pero no hay mucho más."

Elena:
"En el 2002 hacíamos eso. Funcionaba."

~ idea_hay_cosas_juntos = true

-> viernes_plan

=== viernes_vecinos ===

"¿Y los vecinos? ¿Los que no vienen a la olla pero conocen?"

"Ya les pedimos."
"Algunos dieron. No alcanza."

"¿Y si pedimos distinto? No plata. Comida directa. Lo que tengan."

Sofía lo piensa.
"Puede ser. Es más fácil dar una papa que cien pesos."

~ idea_hay_cosas_juntos = true

-> viernes_plan

=== viernes_cancelar_olla ===

"Capaz que... capaz que hoy no."

Silencio.

Sofía te mira.

"¿Cancelar?"

"No podemos dar lo que no tenemos. Mejor cerrar hoy que... que improvisar mal."

~ bajar_llama(2)
~ subir_dignidad(1)
~ vos_propusiste_cerrar = true

Elena suspira.
"Tiene razón. Una vez cerramos en el 2002. Fue un día. Volvimos al otro."

Sofía se sienta.
Tiene la cara de alguien que no durmió.

* [...]
-

"Okay. Cerramos."

~ olla_cerro_viernes = true

Diego no dice nada.
Nadie dice nada.

El silencio pesa.

* [Quedarte con ellos] -> viernes_quedarse_cerrado
* [Irte] -> viernes_irte_cerrado

=== viernes_quedarse_cerrado ===

Te quedás.
No hay mucho que hacer.
Pero te quedás.

Sofía hace café.
Elena mira por la ventana.
Diego ordena sillas vacías.

* [...]
-

Es raro estar acá cuando no hay comida.
Cuando no hay gente.

Pero estás.

~ subir_conexion(1)

* [Pasar la tarde] -> viernes_noche

=== viernes_irte_cerrado ===

Te vas.
No hay nada que hacer acá.

Caminás por el barrio.
Pasás por la plaza.
El tipo del banco sigue ahí.

Hoy no hay olla.
Mañana capaz que sí.
Capaz que no.

* [Ir a casa] -> viernes_noche

=== viernes_plan ===

# EL PLAN

Deciden hacer las dos cosas:
- Pedir comida directa a vecinos
- Colecta rápida en la zona

* [...]
-

Se dividen.

"¿Vos podés ayudar?", pregunta Sofía.

* [Sí, voy con la colecta] # EFECTO:conexion+ # EFECTO:llama+
    -> viernes_colecta_accion
* [Sí, voy a pedir a vecinos] # EFECTO:conexion+ # EFECTO:llama+
    -> viernes_vecinos_accion
* [No puedo, tengo que hacer otra cosa] # EFECTO:conexion-
    -> viernes_no_ayudar

=== viernes_no_ayudar ===

~ bajar_conexion(1)

"No puedo. Tengo que... buscar laburo."

Sofía asiente.
No dice nada.
Pero algo se enfría.

"Bueno. Si podés más tarde..."

Te vas.
Sabés que podrías haber ayudado.
Elegiste no hacerlo.

-> viernes_tarde

=== viernes_colecta_accion ===

// Tunnel de colecta callejera
-> olla_colecta_callejera ->

// Diego en la colecta
-> diego_colecta ->

Diego se mueve diferente.
No pide con lástima. Pide con encanto.
Habla con las viejas. Les sonríe.

"Es un arte", te dice.
"Si das lástima, te dan sobras.
Si das alegría, te dan lo que tienen."

// Chequeo comunitario: la colecta depende de la fuerza del tejido social
# DADOS:CHEQUEO
~ temp resultado_viernes_colecta = chequeo_completo_comunitario(1, 4)
{ resultado_viernes_colecta == 2:
    Aprendés algo nuevo.
    El rebusque no es solo pedir. Es conectar.

    La gente responde. Más de lo esperado.
    Un almacenero da dos bolsas llenas. "Para los gurises", dice.
    Una vecina trae una olla de arroz ya hecho.

    Al final de la tarde, entre todos:
    Hay de sobra. Por primera vez en semanas.

    ~ subir_llama(1)
    ~ subir_conexion(1)
}
{ resultado_viernes_colecta == 1:
    Aprendés algo nuevo.
    El rebusque no es solo pedir. Es conectar.

    Al final de la tarde, entre todos:
    Hay para comprar verduras.
    No es mucho. Pero es algo.
}
{ resultado_viernes_colecta == 0:
    Aprendés, pero cuesta.
    La gente mira para otro lado. O da monedas.

    Al final de la tarde, entre todos:
    Apenas alcanza. Justo.
    Diego no dice nada. Pero se le nota en la cara.
}
{ resultado_viernes_colecta == -1:
    La gente no da. O da con desprecio.
    "Siempre pidiendo", dice uno.
    Diego aprieta los dientes. Vos también.

    Al final de la tarde:
    Casi nada. No alcanza.
    Van a tener que improvisar.

    ~ bajar_llama(1)
}

-> viernes_olla_tarde

=== viernes_vecinos_accion ===

// Tunnel de pedir a vecinos
-> olla_pedir_vecinos ->

// Elena sabe pedir
-> elena_pedir ->

// Chequeo social: convencer a los vecinos de donar
# DADOS:CHEQUEO
~ temp resultado_viernes_vecinos = chequeo_completo_social(elena_relacion, 4)
{ resultado_viernes_vecinos == 2:
    Los vecinos responden. Con ganas.
    Volvés con bolsas llenas. Papas, cebollas, fideos, hasta un pollo.
    Elena sonríe. "¿Viste? La gente es buena. Solo hay que saber pedir."
    ~ subir_conexion(1)
    ~ subir_llama(1)
}
{ resultado_viernes_vecinos == 1:
    Volvés con bolsas.
    No es mucho. Pero es algo.
}
{ resultado_viernes_vecinos == 0:
    Volvés con poco. Unas papas. Un paquete de arroz.
    "Está jodido para todos", dice Elena.
    No culpa a nadie. Pero la preocupación se le nota.
}
{ resultado_viernes_vecinos == -1:
    Casi nadie abre la puerta. Los que abren dicen que no.
    "No tenemos", dice una vecina. Y cierra.
    Volvés con las manos casi vacías.
    Elena no dice nada. Pero camina más lento.
    ~ bajar_llama(1)
}

-> viernes_olla_tarde

=== viernes_olla_tarde ===

# LA OLLA - TARDE

Vuelven todos.

// Resultado de la colecta
-> olla_resultado_colecta ->

La cocina empieza.
Todos ayudan.

// Ixchel durante la crisis - sigue cocinando con lo que hay
{ixchel_relacion >= 1:
    Ixchel está en la cocina.
    No dice nada. Pero sigue cocinando.
    Con lo que hay. Con lo que queda.

    "Siempre se puede con menos", murmura.
    "En mi pueblo, con menos se hacía más."

    ~ ixchel_relacion += 1
}

{energia > 0:
    Te quedás ayudando.
    Pelás, cortás, revolvés.
    Sos parte de esto.
    ~ subir_conexion(1)
}

// Servir la comida
A las 7 la olla abre.
-> olla_servir ->

{veces_que_ayude == 1:
    ~ subir_salud_mental(1)
}

-> viernes_noche

=== viernes_tarde ===

~ energia -= 1

-> check_game_over ->

// Caminar por el barrio de tarde
-> barrio_caminar_tarde ->

// Mensaje de Juan
{juan_sabe_mi_situacion:
    -> juan_charla_viernes ->
}

{olla_en_crisis && not ayude_en_olla:
    Te preguntás cómo les habrá ido a los de la olla.
    Si resolvieron.
    Si cerraron.
}

El barrio sigue.
Vos seguís.
Pero algo falta.

* [Ir a casa] -> viernes_noche

=== viernes_noche ===

# VIERNES - NOCHE

-> check_game_over ->

{ayude_en_olla:
    Estás destruido.
    Pero hiciste algo.
    La olla funcionó hoy.
    Mañana hay que ver de vuelta.

    ~ subir_llama(1)
}

{not ayude_en_olla && olla_en_crisis:
    Te quedaste afuera.
    No sabés cómo les fue.
    Quizás deberías haber ido.
}

// Hook de Juan: si tenés buena relación, te llama
{juan_relacion >= 4 && energia >= 1:
    -> juan_llamado_viernes ->
    
    Te quedás pensando en Juan.
    Siempre pareció el más seguro.
    Pero hoy su voz temblaba un poco.
    
    "Tengo miedo de ser el próximo", dijo.
    
    El miedo no respeta antigüedad.
}

~ energia = 0

Mañana es sábado.
Hay una asamblea en el barrio.
Para hablar de la olla, de la situación.

{ayude_en_olla: Te invitaron. Podés ir.}
{not ayude_en_olla: Escuchaste que hay. Quizás podrías ir.}

// Fragmento nocturno
-> seleccionar_fragmento_viernes ->

* [Dormir] -> fragmento_viernes

=== fragmento_viernes ===

# MIENTRAS DORMÍS

{vinculo == "sofia": -> fragmento_sofia_viernes}
{vinculo == "elena": -> fragmento_elena_viernes}
{vinculo == "diego": -> fragmento_diego_viernes}
{vinculo == "marcos": -> fragmento_marcos_viernes}
-> fragmento_viernes_default

=== fragmento_sofia_viernes ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Sofía está destruida.

    Hoy vio gente rota pidiendo comida.
    Vos entre ellos.

    "Todos terminan así", piensa.

    La olla no salva a nadie.
    Solo alarga la caída.
    Un plato de comida.
    Y mañana otra vez.

    Hasta que no hay mañana.

    { chance(50):
        ~ bajar_salud_mental(1)
    }
    * [Continuar] -> transicion_viernes_sabado
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Sofía mira la olla vacía.

    Hoy vino menos gente.
    Mañana va a venir menos.

    "Se termina", piensa.

    El barrio se dispersa.
    Cada uno solo.
    La olla va a cerrar.

    No hay tejido que sostenga esto.
    Ya no hay nada.

    { chance(60):
        ~ bajar_llama(1)
    }
    * [Continuar] -> transicion_viernes_sabado
}

// FRAGMENTO NORMAL
# SOFÍA

Sofía está agotada.

{ayude_en_olla:
    Pero hoy funcionó.
    Entre todos, funcionó.
- else:
    Hoy apenas alcanzó.
    No sabe si mañana va a dar.
}

Mañana es la asamblea.
Hay que hablar de todo.
De cómo seguir.

* [Continuar] -> transicion_viernes_sabado

=== fragmento_elena_viernes ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Elena piensa en Raúl.

    En cómo el 2002 lo rompió.
    Nunca se recuperó del todo.

    Piensa en vos.
    "Ya está roto", piensa.

    El mismo proceso.
    Primero la humillación.
    Después la nada.

    Raúl murió un poco roto.
    Vos también vas a morir roto.
    Todos mueren rotos.

    { chance(50):
        ~ bajar_salud_mental(1)
    }
    * [Continuar] -> transicion_viernes_sabado
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Elena está sola.

    Raúl murió.
    Los hijos lejos.
    Los vecinos ya ni saludan.

    "Nos convertimos en extraños", piensa.

    El barrio murió.
    La red se cortó.
    Ahora es cada uno solo.

    Hasta el final.
    Siempre solo.

    { chance(60):
        ~ bajar_llama(1)
    }
    * [Continuar] -> transicion_viernes_sabado
}

// FRAGMENTO NORMAL
# ELENA

Elena piensa en Raúl.

En el 2002, él tampoco dormía.
Pero salieron.
Juntos, salieron.

Mañana hay asamblea.
Ella va a ir.
Tiene cosas que decir.

* [Continuar] -> transicion_viernes_sabado

=== fragmento_diego_viernes ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Diego cuenta la plata.

    No alcanza.

    Piensa en su madre.
    En cómo le miente.
    "Estoy bien, má."

    No está bien.

    Dejó Venezuela para esto.
    Para ver cómo te destruyen en otro país.
    En otro idioma.

    Pero la destrucción es igual.
    Siempre igual.

    { chance(50):
        ~ bajar_salud_mental(1)
    }
    * [Continuar] -> transicion_viernes_sabado
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Diego está solo en su pieza.

    Tres contactos en el celular.
    Su familia en Venezuela.

    "Crucé el continente para estar solo", piensa.

    La olla.
    El barrio.
    Todo le queda lejos.

    En Venezuela estaba solo.
    Acá está solo.

    No hay diferencia.

    { chance(60):
        ~ bajar_llama(1)
    }
    * [Continuar] -> transicion_viernes_sabado
}

// FRAGMENTO NORMAL
# DIEGO

Diego cuenta la plata.

No alcanza.
Nunca alcanza.
Pero hoy trabajó fuerte.

{ayude_en_olla:
    Y vos estuviste ahí.
    Cargando cajones a la par.
}

"La gente piensa que venimos a pedir", piensa.
"No venimos a pedir."
"Venimos a ser parte de algo."

Eso alimenta más que el guiso.
Casi.

Mañana sigue.

* [Continuar] -> transicion_viernes_sabado

=== fragmento_marcos_viernes ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Marcos piensa en vos.

    Ahora entendés.
    Ahora sabés lo que es.

    No hay dignidad.
    Nunca la hubo.
    Solo hay funcionar.

    Aceptar.
    Agachar la cabeza.
    Sobrevivir.

    "Bienvenido", piensa.

    Ya sos como él.
    Ya no queda nada más.

    { chance(50):
        ~ bajar_salud_mental(1)
    }
    * [Continuar] -> transicion_viernes_sabado
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Marcos mira desde lejos.

    La gente se junta.
    Hablan de cambiar cosas.

    "No van a cambiar nada", piensa.

    Nunca cambió nada.
    La gente no tiene poder.
    Nunca lo tuvo.

    Mejor solo.
    Mejor apagado.
    Mejor no intentar.

    { chance(60):
        ~ bajar_llama(1)
    }
    * [Continuar] -> transicion_viernes_sabado
}

// FRAGMENTO NORMAL
# MARCOS

Marcos vio la asamblea desde lejos.

No entró.
No quiso.
O no pudo.

La gente hace cosas.
Él solo mira.

Quizás mañana.
Siempre quizás mañana.

* [Continuar] -> transicion_viernes_sabado

=== fragmento_viernes_default ===

El barrio duerme.
Los problemas siguen.

Mañana hay asamblea.
Para hablar de cómo seguir.

* [Continuar] -> transicion_viernes_sabado

=== transicion_viernes_sabado ===
// Chequeo de colapso mental antes de continuar
{salud_mental <= 0:
    -> recovery_mental_viernes
}
- (post_recovery_viernes)

// Chequeo de destrucción del tejido social
{llama <= 0:
    -> final_sin_llama
}

-> sabado_amanecer

=== recovery_mental_viernes ===
Todo se pone oscuro. Otra vez. Peor.

* [...]
-

{conexion <= 1 && llama <= 1:
    No queda nada.
    Ni gente. Ni fuego. Ni razón.

    -> final_apagado
}

Pero algo queda. Alguien dijo tu nombre hoy. Alguien te vio.

~ salud_mental = 1

No estás bien. Pero todavía estás.

-> transicion_viernes_sabado.post_recovery_viernes


## FILE: dias/sabado.ink

// ============================================
// SABADO - LA ASAMBLEA
// Patron modular con tunnels
// ============================================

// Tunnels usados de otros modulos:
// - escenas/olla.ink: olla_preparar_asamblea, olla_asamblea_inicio,
//                     olla_asamblea_discusion, olla_asamblea_fin, olla_cerrar_noche
// - escenas/barrio.ink: barrio_sabado, barrio_plaza
// - personajes/sofia.ink: sofia_fragmento_asamblea
// - personajes/elena.ink: elena_consejo
// - personajes/marcos.ink: marcos_contesta, marcos_encuentro_plaza,
//                          marcos_revelar_despido, marcos_hablar_precariedad,
//                          marcos_invitar_asamblea, marcos_en_asamblea, marcos_se_fue,
//                          marcos_idea_esto_es_lo_que_hay

=== sabado_amanecer ===

~ dia_actual = 6
~ energia = 4  // Fin de semana, dormiste un poco más

# SABADO

// --- Ecos del viernes ---
{olla_cerro_viernes:
    Ayer la olla cerró.
    Es sábado y todavía te pesa.
    40 personas que no comieron.
    ¿O sí comieron? ¿Dónde?
}
{not olla_cerro_viernes && ayude_en_olla:
    Ayer la olla funcionó.
    Con lo justo. Pero funcionó.
    Hoy hay asamblea.
}

Sábado.
Antes era descanso.
Ahora todos los días son iguales.

* [...]
-

{ayude_en_olla: Hoy es la asamblea. A las 5 en la olla.}

* [Levantarte] -> sabado_manana

=== sabado_manana ===

La mañana de sábado.
El barrio más tranquilo.

{salud_mental <= 4: La cabeza sigue dando vueltas. Tres días sin laburo y ya parece una eternidad.}

// Invitar a Juan a la olla
{juan_sabe_mi_situacion && ayude_en_olla:
    -> juan_invitar_olla_sabado ->
}

¿Qué hacés con la mañana?

* [Llamar a alguien] # EFECTO:conexion?
    -> sabado_llamar
* [Salir a caminar] # COSTO:1
    -> sabado_caminar
* [Quedarte en casa] # COSTO:1 # STAT:conexion # EFECTO:conexion-
    -> sabado_casa

=== sabado_llamar ===

¿A quién llamás?

* {vinculo == "marcos"} [A Marcos (otra vez)]
    -> sabado_marcos
* [A tu vieja / tu viejo] # COSTO:1
    -> sabado_familia
* [A nadie, mejor no] -> sabado_casa

=== sabado_marcos ===

// Marcos contesta (raro)
-> marcos_contesta ->

"Dale. En la plaza. En una hora."

* [Ir] -> sabado_marcos_plaza

=== sabado_marcos_plaza ===

// Encuentro en la plaza con Marcos
-> marcos_encuentro_plaza ->

"Me echaron."

// Marcos revela que tambien lo echaron
-> marcos_revelar_despido ->

"¿Cómo la llevás?"

// Marcos sobre funcionar
-> marcos_funcionar ->

// Hablar de la precariedad
-> marcos_hablar_precariedad ->

// Idea involuntaria al ver a Marcos
-> marcos_idea_esto_es_lo_que_hay ->

// Invitar a Marcos a la asamblea
-> marcos_invitar_asamblea ->

* ["Vamos juntos."] # EFECTO:conexion+
    "Hace mucho que no voy. Siempre es lo mismo."
    "Hoy no. Hoy vamos nosotros."
    Marcos te mira. Hay algo ahí. Una duda.
    "Vamos a ver", dice. Pero va.
    ~ marcos_estado = "mirando"
    -> sabado_tarde
* ["No importa, era por decir."] # EFECTO:conexion-
    "Mejor no. No estoy para eso."
    "Bueno."
    -> sabado_tarde

=== sabado_familia ===

~ energia -= 1

Llamás a tu familia.

"Hola, má."

Hablás.
De todo y de nada.

* [...]
-

No le contás lo del laburo.
O sí, depende.

* [Contarle]
    ~ conte_a_alguien = true
    "Má, me echaron."
    Silencio.
    "¿Estás bien? ¿Necesitás plata?"
    "No sé. Era unipersonal. No hay indemnización. No hay nada."
    "¿Cómo que no hay nada?"
    "Así me contrataron. Facturaba. Como si fuera mi propia empresa."
    Ella no entiende. Pero te escucha.
    -> sabado_tarde
* [No contarle]
    Hablás de otras cosas.
    El clima. Los vecinos. Boludeces.
    No querés preocuparla.
    O no querés tener que explicar.
    -> sabado_tarde

=== sabado_caminar ===

~ energia -= 1

Salís a caminar.

// Ambiente de sabado
-> barrio_sabado ->

* [Volver a casa] -> sabado_casa
* [Pasar por la olla] -> sabado_olla_temprano

=== sabado_olla_temprano ===

Pasás por la olla.

// Preparando asamblea
-> olla_preparar_asamblea ->

Sofía te ve.

"¿Venís a la asamblea?"

* ["Sí, vengo más tarde."]
    "Bien. A las 5."
    -> sabado_tarde
* ["No sé si puedo."]
    Sofía asiente.
    "Bueno. Si podés, acá estamos."
    -> sabado_tarde

=== sabado_casa ===

~ energia -= 1
~ bajar_conexion(1)

Te quedás en casa.
Tele.
Celular.
Nada.

Las horas pasan.

* [Ir a la asamblea igual] # EFECTO:llama+
    -> sabado_asamblea
* [No ir] # EFECTO:conexion- # EFECTO:llama-
    -> sabado_noche_solo

=== sabado_tarde ===

-> check_game_over ->

La tarde.

A las 5 es la asamblea.

{energia >= 1:
    Podés ir.
    * [Ir a la asamblea] -> sabado_asamblea
    * [No ir] -> sabado_noche_solo
- else:
    Estás muy cansado.
    No das más.
    * [Intentar ir igual]
        ~ energia = 0
        Te arrastrás hasta la olla.
        -> sabado_asamblea
    * [Quedarte] -> sabado_noche_solo
}

=== sabado_noche_solo ===

~ bajar_conexion(2)
~ bajar_llama(1)

No vas.

Te quedás en casa.
Pensás en que deberías haber ido.
Pero no fuiste.

* [...]
-

La asamblea pasa sin vos.
No sabés qué decidieron.
No sabés qué viene.

Estás afuera.

* [Dormir] -> fragmento_sabado

=== sabado_asamblea_post_cierre ===
// Consecuencias del cierre de la olla el viernes

El aire está raro.
Ayer la olla cerró.
Primera vez en meses.

* [...]
-

Sofía está callada.
Elena tiene cara de preocupación.

"Bueno... tenemos que hablar de lo de ayer."

* [...]
-

Sofía suspira.

"Ayer cerramos. Lo saben.
La pregunta es: ¿qué hacemos para que no pase de nuevo?"

{vos_propusiste_cerrar:
    Te miran.
    Vos propusiste cerrar.
    Ahora te toca proponer qué sigue.

    * [Proponer sistema de reserva de emergencia]
        "Necesitamos un fondo. Aunque sea chico. Para días así."
        Sofía asiente. "Tiene sentido."
        La discusión sigue.
        -> sabado_asamblea_continua

    * [Proponer red de donantes fijos]
        "Necesitamos gente que se comprometa a dar todos los meses."
        Elena: "En el 2002 así empezamos."
        La idea prende.
        -> sabado_asamblea_continua

    * [Quedarte callado]
        No decís nada.
        Sofía te mira. Esperaba más.
        ~ bajar_dignidad(1)
        -> sabado_asamblea_continua
- else:
    La discusión sigue sin que nadie te mire especialmente.
    -> sabado_asamblea_continua
}

=== sabado_asamblea_continua ===
// Continúa después de resolver el tema del cierre

La conversación se amplía.
No es solo lo de ayer.
Es todo.

* [Seguir] -> sabado_asamblea_discusion_normal

=== sabado_asamblea ===

// Ecos: los NPCs recuerdan tus acciones pasadas
-> sabado_ver_sofia ->
-> sabado_ver_diego ->

// Inicio de la asamblea
-> olla_asamblea_inicio ->

// Si la olla cerró ayer, eso domina la conversación
{olla_cerro_viernes:
    -> sabado_asamblea_post_cierre
}

-> sabado_asamblea_discusion_normal

=== sabado_asamblea_discusion_normal ===
// Discusión normal de la asamblea (sin cierre previo)

// Discusion de la asamblea
-> olla_asamblea_discusion ->

// Elena da consejo
-> elena_consejo ->

// Marcos en la asamblea (si vino)
-> marcos_en_asamblea ->

// Ixchel en la asamblea - su intervención desde la experiencia
{ixchel_relacion >= 2:
    Ixchel está al fondo.
    No habla. Pero escucha.

    En un momento, cuando alguien dice "esto se cae",
    ella dice, bajito:

    "En mi comunidad votaron 98% que no.
    Y la mina abrió igual.
    Pero no dejamos de juntarnos."

    Silencio.

    "Juntarse es lo primero. Lo demás viene después."

    ~ ixchel_relacion += 1
    ~ subir_llama(1)
}

¿Qué hacés?

* [Hablar] # STAT:dignidad # EFECTO:dignidad+
    -> sabado_hablar
* [Escuchar]
    -> sabado_escuchar_asamblea
* [Proponer algo] # STAT:dignidad # STAT:llama # EFECTO:dignidad+ # EFECTO:llama+
    -> sabado_asamblea_proponer

=== sabado_escuchar_asamblea ===

Escuchás.

Las ideas van y vienen.
- Hacer más colectas.
- Buscar comercios que donen.
- Pedir al municipio de vuelta.
- Organizar una feria.

No hay solución mágica.
Solo ideas.
Solo gente tratando.

-> sabado_asamblea_fin

=== sabado_hablar ===

Hablás.

"Yo... hace tres días me quedé sin laburo. No sé bien qué puedo aportar. Pero tengo tiempo ahora. Y quiero ayudar."

// Chequeo comunitario: hablar frente a la asamblea, conectar con el grupo
# DADOS:CHEQUEO
~ temp resultado_sabado_hablar = chequeo_completo_comunitario(conexion, 4)
{ resultado_sabado_hablar == 2:
    -> sabado_hablar_critico
}
{ resultado_sabado_hablar == 1:
    -> sabado_hablar_exito
}
{ resultado_sabado_hablar == 0:
    -> sabado_hablar_fallo
}
-> sabado_hablar_crit_fallo

= sabado_hablar_critico
Te miran.

* [...]
-

Silencio. Y después algo inesperado: aplausos. Pocos, pero sinceros.

Sofía tiene los ojos húmedos.
Elena asiente con fuerza.

"Eso. Eso es lo que necesitamos. Gente que diga la verdad."

Tu voz encontró algo. Un nervio. Un lugar real.

~ subir_dignidad(2)
~ subir_conexion(1)
~ subir_llama(1)
-> sabado_asamblea_fin

= sabado_hablar_exito
Te miran.

* [...]
-

Sofía asiente.
Elena sonríe.

"Eso es lo que necesitamos. Gente."

~ subir_dignidad(1)
-> sabado_asamblea_fin

= sabado_hablar_fallo
Te miran.

* [...]
-

Algunos asienten. Otros miran para otro lado.
No es un discurso brillante. Pero es honesto.

Sofía dice: "Gracias."
Y sigue la reunión.

~ subir_dignidad(1)
-> sabado_asamblea_fin

= sabado_hablar_crit_fallo
Te miran.

* [...]
-

Se te corta la voz. Te trabás.

"Bueno... eso."

Te sentás. Rojo.
Nadie dice nada. Lo que es peor que si dijeran algo.

Sofía pasa a otro tema. Con suavidad.
Pero el silencio te quema.
-> sabado_asamblea_fin

// DEPRECATED: Replaced by sabado_asamblea_proponer (dice-based version)
// This knot is no longer called and kept only for reference
/*
=== sabado_proponer ===

~ subir_dignidad(1)
~ subir_llama(1)

"¿Y si hacemos algo más grande? Una jornada. Invitamos a todo el barrio. Mostramos lo que hace la olla. Pedimos ayuda abiertamente."

Silencio.

"Es mucho laburo."
"Pero puede funcionar."
"Hay que organizarlo."

Sofía:
"¿Vos te animás a ayudar con eso?"

* ["Sí."] # STAT:conexion # EFECTO:conexion+
    ~ subir_conexion(1)
    "Sí. Ahora tengo tiempo."
    Risas nerviosas.
    Pero es real.
    Ahora tenés tiempo.
    -> sabado_asamblea_fin
* ["No sé si puedo."] # EFECTO:conexion-
    "Bueno. La idea queda."
    -> sabado_asamblea_fin
*/

=== sabado_asamblea_proponer ===
Te levantás.
Todos te miran.

~ temp modificador = 0
{ veces_que_ayude >= 2:
    ~ modificador += 1  // Tenés credibilidad
}
{ participe_asamblea:
    ~ modificador += 1
}
{ sofia_relacion >= 4:
    ~ modificador += 1
}

~ temp resultado = chequeo(modificador, 5)

{
- resultado == 2:  // Crítico
    Las palabras salen.
    No sabés de dónde.
    Pero salen.

    Hablás de la semana.
    De lo que perdiste.
    De lo que encontraste.

    Cuando terminás, hay silencio.
    Después, aplausos.

    Sofía tiene lágrimas.

    ~ subir_llama(2)
    ~ subir_conexion(2)
    ~ subir_dignidad(1)

    -> asamblea_exito_total

- resultado == 1:  // Éxito
    Proponés algo.
    Un sistema de turnos.
    Una red de ayuda.
    Algo.

    La gente asiente.
    No es revolución.
    Pero es algo.

    ~ subir_llama(1)
    ~ subir_conexion(1)

    -> asamblea_exito

- resultado == 0:  // Fallo
    Empezás a hablar.
    Te trabás.

    Sofía interviene, suave.
    "Gracias. ¿Alguien más?"

    Te sentás.
    No estuvo mal.
    Pero tampoco estuvo bien.

    -> asamblea_continua

- else:  // Fumble
    Te levantás.
    Abrís la boca.

    Nada sale.

    Te sentás de nuevo.
    Nadie dice nada.

    ~ bajar_dignidad(1)

    -> asamblea_continua
}

=== asamblea_exito_total ===
// Stub: Consecuencias de éxito crítico en propuesta

El resto de la asamblea fluye diferente.
Tu intervención cambió algo.

-> sabado_asamblea_fin

=== asamblea_exito ===
// Stub: Consecuencias de éxito en propuesta

La asamblea continúa.
Tu idea se suma a las demás.

-> sabado_asamblea_fin

=== asamblea_continua ===
// Stub: La asamblea sigue sin mayor impacto de tu intervención

La asamblea sigue.
Otras voces hablan.

-> sabado_asamblea_fin

=== sabado_asamblea_fin ===

// Cierre de la asamblea
-> olla_asamblea_fin ->

~ subir_salud_mental(1)

{idea_hay_cosas_juntos == false:
    # IDEA DISPONIBLE: "HAY COSAS QUE SE HACEN JUNTOS"

    La asamblea te mostró algo.
    No es que alguien tiene la respuesta.
    Es que entre todos se busca.

    * [Internalizar]
        ~ idea_hay_cosas_juntos = true
        Hay cosas que se hacen juntos.
        O no se hacen.
        -> sabado_noche
    * [Dejar pasar]
        -> sabado_noche
- else:
    -> sabado_noche
}

=== sabado_noche ===

# SABADO - NOCHE

~ energia = 0
~ subir_llama(1)

-> check_game_over ->

Volvés a casa.
Cansado pero distinto.

Cuatro días sin laburo.
Tres meses de colchón.
La cuenta regresiva sigue.

* [...]
-

Pero hoy estuviste en una asamblea.
Hoy fuiste parte de algo.

No resuelve nada.
Pero cambia algo.

// Marcos se fue de la asamblea
-> marcos_se_fue ->

// Fragmento nocturno
-> seleccionar_fragmento_sabado ->

* [Dormir] -> fragmento_sabado

=== fragmento_sabado ===

# MIENTRAS DORMÍS

{vinculo == "sofia": -> fragmento_sofia_sabado}
{vinculo == "elena": -> fragmento_elena_sabado}
{vinculo == "diego": -> fragmento_diego_sabado}
{vinculo == "marcos": -> fragmento_marcos_sabado}
-> fragmento_sabado_default

=== fragmento_sofia_sabado ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Sofía está destruida.

    Hoy vio gente en la asamblea.
    Gente rota que intenta seguir.

    Vos también estabas ahí.
    Roto.

    "¿Para qué seguir?", piensa.

    La olla no salva a nadie.
    Solo retrasa lo inevitable.
    Un día más.
    Hasta que no hay más días.

    ~ bajar_salud_mental(1)
    * [Continuar] -> transicion_sabado_domingo
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Sofía está sola en la olla.

    Hoy hubo asamblea.
    Vino poca gente.

    "El barrio se muere", piensa.

    Cada vez menos gente.
    Cada vez más solos.

    La olla va a cerrar.
    Es cuestión de tiempo.

    Y nadie va a hacer nada.

    ~ bajar_llama(1)
    * [Continuar] -> transicion_sabado_domingo
}

// FRAGMENTO NORMAL
# SOFÍA

Sofía finalmente duerme.

{participe_asamblea:
    La asamblea salió bien.
    Hay un plan.
    No es mucho, pero es algo.
- else:
    La asamblea pasó.
    Ella siguió sola.
}

Mañana es domingo.
Un día para respirar.
Después sigue la lucha.

* [Continuar] -> transicion_sabado_domingo

=== fragmento_elena_sabado ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Elena sueña con Raúl.

    Está en el frigorífico.
    El día que lo echaron.

    Vuelve a casa roto.
    Ya no es el mismo.

    "Nunca volvió a ser el mismo", piensa Elena.

    Despierta.
    Piensa en vos.

    Vos tampoco vas a volver a ser el mismo.
    Nadie vuelve.

    ~ bajar_salud_mental(1)
    * [Continuar] -> transicion_sabado_domingo
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Elena está sola.

    Raúl murió.
    El barrio se dispersó.

    "Nos convertimos en islas", piensa.

    Cuando Raúl murió, tres vecinos vinieron.
    Antes hubiera sido el barrio entero.

    Ahora ni eso.
    Ahora solo puertas cerradas.

    ~ bajar_llama(1)
    * [Continuar] -> transicion_sabado_domingo
}

// FRAGMENTO NORMAL
# ELENA

Elena sueña con Raúl.

Están en el barrio.
Hace calor.
Él sonríe.

"¿Viste? Siempre salimos."

Se despierta.
Es un buen sueño.

* [Continuar] -> transicion_sabado_domingo

=== fragmento_diego_sabado ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Diego habló con su madre.

    "Estoy bien, má."
    Mentira.

    No está bien.

    Dejó Venezuela para esto.
    Para ver cómo te humillan.
    Para terminar roto.

    En otro país.
    En otro idioma.

    Pero la humillación es la misma.
    Siempre la misma.

    ~ bajar_salud_mental(1)
    * [Continuar] -> transicion_sabado_domingo
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Diego está solo.

    Tres contactos en Uruguay.
    Su familia en Venezuela.

    "Crucé un continente para seguir solo", piensa.

    La asamblea.
    El barrio.
    Todo le queda lejos.

    Siempre le quedó lejos.
    Siempre va a quedar lejos.

    ~ bajar_llama(1)
    * [Continuar] -> transicion_sabado_domingo
}

// FRAGMENTO NORMAL
# DIEGO

Diego habló con su madre.

"Estoy bien, má."
Mentira piadosa.
O quizás no.

{participe_asamblea:
    Hoy fue a una asamblea.
    No entendió todo.
    Pero sintió algo.
}

Mañana sigue.

* [Continuar] -> transicion_sabado_domingo

=== fragmento_marcos_sabado ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Marcos piensa.

    Vos ahora entendés.
    Ya sos como él.

    No hay dignidad.
    Nunca la hubo.

    Solo hay funcionar.
    Aceptar.
    Agachar la cabeza.

    "Bienvenido", piensa.

    Ya no queda nada más.
    Nunca quedó.

    ~ bajar_salud_mental(1)
    * [Continuar] -> transicion_sabado_domingo
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Marcos mira la asamblea desde lejos.

    Gente que se junta.
    Gente que habla de cambiar cosas.

    "No van a cambiar nada", piensa.

    La gente nunca cambió nada.
    Los de arriba ganan.
    Siempre ganan.

    Mejor solo.
    Mejor no intentar.
    Mejor apagarse.

    ~ bajar_llama(1)
    * [Continuar] -> transicion_sabado_domingo
}

// FRAGMENTO NORMAL
# MARCOS

{marcos_estado == "mirando":
    Marcos fue a la asamblea.
    Se sentó atrás.
    No habló.
    Pero estuvo.

    Es más de lo que hizo en meses.
- else:
    Marcos no fue.
    Como siempre.

    La vida pasa.
    Él mira.
}

Mañana es domingo.

* [Continuar] -> transicion_sabado_domingo

// --- ECOS: NPCs RECUERDAN TUS ACCIONES ---

=== sabado_ver_sofia ===
// Tunnel: Sofia recuerda si ayudaste en la olla

Sofía te ve llegar.

{ayude_en_olla && veces_que_ayude >= 2:
    "Che, gracias por el viernes. No sé cómo hubiéramos hecho sin vos."

    Alguien notó.
    Alguien se acuerda.

    ~ sofia_relacion += 1
}
{ayude_en_olla && veces_que_ayude == 1:
    "Qué bueno que viniste."

    Un reconocimiento simple.
    Pero real.
}
{not ayude_en_olla:
    "Hola."

    Nada más.
    No hay mucho que decir.
}

->->

=== sabado_ver_diego ===
// Tunnel: Diego recuerda si hablaste con el

Diego está en la asamblea.

{hable_con_diego_profundo:
    Te ve y se acerca.

    "Che, lo que hablamos el otro día... me quedó dando vueltas.
    Creo que tenías razón."

    ~ diego_relacion += 1
}
{conte_a_alguien && vinculo == "diego":
    Diego asiente cuando te ve.

    Hay algo compartido ahí.
    Un secreto. Tu despido.
    Él sabe. Y vos sabés que él sabe.
}

->->

// --- FRAGMENTOS DE NOCHE ---

=== fragmento_sabado_default ===

El barrio duerme.
La asamblea pasó.
Mañana es domingo.

La semana que viene empieza todo de vuelta.
Pero quizás no igual.

* [Continuar] -> transicion_sabado_domingo

=== transicion_sabado_domingo ===
// Chequeo de colapso mental antes de continuar
{salud_mental <= 0:
    -> recovery_mental_sabado
}
- (post_recovery_sabado)

// Chequeo de destrucción del tejido social
{llama <= 0:
    -> final_sin_llama
}

-> domingo_amanecer

=== recovery_mental_sabado ===
La oscuridad viene de nuevo. Más fuerte.

* [...]
-

{conexion <= 1 && llama <= 1:
    No hay red. No hay llama. No hay mañana.

    -> final_apagado
}

{participe_asamblea:
    La asamblea. Las voces. Algo de eso queda.
- else:
    Una cara. Un gesto. Algo mínimo.
}

~ salud_mental = 1

Mañana es domingo. Último día. Algo tiene que pasar.

-> transicion_sabado_domingo.post_recovery_sabado


## FILE: dias/domingo.ink

// ============================================
// DOMINGO - EL FIN DE LA SEMANA
// Patron modular con tunnels
// Conecta con finales/finales.ink
// ============================================

// Tunnels usados de otros modulos:
// - ubicaciones/barrio.ink: barrio_domingo, barrio_grupo_olla
// - personajes/sofia.ink: sofia_llamar, sofia_conversacion_telefono
// - personajes/elena.ink: elena_llamar, elena_conversacion_telefono
// - personajes/diego.ink: diego_llamar, diego_conversacion_telefono
// - personajes/marcos.ink: marcos_llamar, marcos_conversacion_telefono, marcos_domingo_olla

=== domingo_amanecer ===

~ dia_actual = 7
~ energia = 5  // Domingo, descansaste

# DOMINGO

// --- Ecos del sábado ---
{participe_asamblea:
    La asamblea de ayer fue... algo.
    {marcos_vino_a_asamblea: Marcos estaba. No dijiste nada. Pero estaba.}
    Hoy es domingo.
    Último día de la semana.
}
{not participe_asamblea:
    Domingo.
    Ayer no fuiste a nada.
    Hoy tampoco hay nada.
    O capaz que sí, pero no te enteraste.
}

Una semana.

Hace una semana eras otra persona.
Tenías laburo.
Tenías rutina.
Tenías algo.

* [...]
-

Ahora no tenés nada. Unipersonal.
Sin derechos. Sin colchón. Sin respuestas.

* [Levantarte] -> domingo_manana

=== domingo_manana ===

Domingo.
El día más lento.

{participe_asamblea: Ayer fue la asamblea. Hoy es día de procesar.}
{not participe_asamblea: No fuiste a la asamblea. No sabés qué pasó.}

La mañana está ahí.
Esperando.

¿Qué hacés?

* [Quedarte en casa, pensar] # EFECTO:conexion-
    -> domingo_pensar
* [Salir al barrio] # COSTO:1 # EFECTO:conexion?
    -> domingo_barrio
* [Llamar a tu vínculo] # EFECTO:conexion+
    -> domingo_llamar

=== domingo_pensar ===

Te quedás.
Pensás.

La semana que pasó.
Lo que viene.

// Chequeo mental: la reflexión final del domingo
# DADOS:CHEQUEO
~ temp resultado_domingo_reflexion = chequeo_completo_mental(conexion, 4)
{ resultado_domingo_reflexion == 2:
    La cabeza se aquieta. Por primera vez en días.

    Algo se acomoda. No es una respuesta. Es una calma.

    Una semana atrás eras otro. Tenías laburo y nada más.
    Ahora no tenés laburo. Pero tenés algo que antes no tenías.

    {conexion >= 6: Gente. Caras. Nombres. Una red que no sabías que existía.}
    {conexion < 6: Algo. Todavía no sabés qué. Pero algo.}

    ~ subir_dignidad(1)
    ~ salud_mental = salud_mental + 1
}
{ resultado_domingo_reflexion == 1:
    {salud_mental <= 4:
        La cabeza no para.
        ¿Quién sos ahora?
        ¿Qué hacés?
        ¿Qué viene?
    }

    {conexion >= 6:
        Pero no estás solo.
        Esta semana conociste gente.
        O reconectaste con gente.
        Eso es algo.
    }

    {conexion < 4:
        Estás bastante solo.
        Esta semana no conectaste mucho.
        La soledad pesa.
    }
}
{ resultado_domingo_reflexion == 0:
    La cabeza da vueltas.
    No llegás a ningún lado.

    {conexion >= 4: Al menos hay gente. Eso debería alcanzar. Pero hoy no alcanza.}
    {conexion < 4: Estás solo. Y el domingo es el peor día para estar solo.}

    La tarde va a ser larga.
}
{ resultado_domingo_reflexion == -1:
    La cabeza explota.

    Todo se mezcla. El laburo. La plata. La olla. Las caras.
    ¿Qué sentido tiene? ¿Para qué?

    El domingo es un espejo. Y no te gusta lo que ves.

    ~ bajar_salud_mental(1)
}

* [Ir a la tarde] -> domingo_tarde

=== domingo_barrio ===

~ energia -= 1

Salís.

// Ambiente de domingo
-> barrio_domingo ->

// Marcos en la olla - domingo
{marcos_vino_a_asamblea && marcos_relacion >= 4:
    -> marcos_domingo_olla ->
}

-> domingo_encuentro_grupo

=== domingo_encuentro_grupo ===

Pasás por la olla.
No hay reunión hoy. Pero hay gente.

* [...]
-

{participe_asamblea && ayude_en_olla:
    Sofía está afuera.
    Elena toma mate en la vereda.
    Diego ordena cosas.
    {marcos_vino_a_asamblea: Marcos está parado lejos, pero ahí.}
    Te ven.

    * [Acercarte]
        -> domingo_cierre_red
    * [Saludar de lejos y seguir]
        -> domingo_cierre_distante
}
{participe_asamblea && not ayude_en_olla:
    Hay gente.
    Te miran.
    Saludan, pero...
    Hay algo raro.
    No sos parte. No del todo.

    * [Acercarte igual] -> domingo_cierre_intento
    * [Seguir de largo] -> domingo_cierre_distante
}
{not participe_asamblea:
    La olla está cerrada.
    No hay nadie.
    O quizás hay, pero no te ven.
    O no te buscan.

    * [Seguir] -> domingo_tarde
}

=== domingo_cierre_red ===

Te acercás.

Sofía te pasa un mate.
Elena te hace lugar en el banco.
Diego asiente.

* [...]
-

{marcos_vino_a_asamblea:
    Marcos te mira desde lejos.
    Levanta la mano.
    Es un gesto mínimo.
    Pero es algo.
}

* [...]
-

Nadie dice nada importante.
Pero están.
Y vos estás.

Esto es algo.

~ subir_conexion(1)

* [Quedarte un rato] -> domingo_tarde

=== domingo_cierre_distante ===

Saludás de lejos.
Seguís caminando.

Hay distancia.
Elegiste que la haya.
O la distancia te eligió.

* [Seguir] -> domingo_tarde

=== domingo_cierre_intento ===

Te acercás.

Sofía te mira.
Elena asiente.
Diego dice algo.

Pero no estás. No del todo.
Faltó algo. Ayudar, quizás.
O solo estar más.

No te rechazan.
Pero tampoco te llaman.

* [Quedarte un poco] -> domingo_tarde

=== domingo_llamar ===

{vinculo == "sofia": -> domingo_llamar_sofia}
{vinculo == "elena": -> domingo_llamar_elena}
{vinculo == "diego": -> domingo_llamar_diego}
{vinculo == "marcos": -> domingo_llamar_marcos}

// Fallback (should never reach)
-> domingo_tarde

=== domingo_llamar_sofia ===

// Llamar a Sofia
-> sofia_llamar ->

// Conversacion telefonica
-> sofia_conversacion_telefono ->

-> domingo_tarde

=== domingo_llamar_elena ===

// Llamar a Elena
-> elena_llamar ->

// Conversacion telefonica
-> elena_conversacion_telefono ->

-> domingo_tarde

=== domingo_llamar_diego ===

// Llamar a Diego
-> diego_llamar ->

// Conversacion telefonica
-> diego_conversacion_telefono ->

-> domingo_tarde

=== domingo_llamar_marcos ===

// Llamar a Marcos
-> marcos_llamar ->

// Conversacion telefonica
-> marcos_conversacion_telefono ->

-> domingo_tarde

=== domingo_tarde ===

# DOMINGO - TARDE

La tarde.
El sol baja.

Mañana es lunes.
Pero no hay laburo al que ir.

* [...]
-

La semana que viene:
- Hay que buscar laburo.
- Hay que ver qué pasa con la olla.
- Hay que seguir viviendo.

{conexion >= 6: Al menos no estás solo.}
{conexion < 4: Estás bastante solo. Quizás la semana que viene...}

{llama >= 5: Hay algo de esperanza. Pequeña, pero ahí.}
{llama < 3: Todo se ve gris. Pero mañana es otro día.}

* [Ir a la noche] -> domingo_noche

=== domingo_noche ===

# DOMINGO - NOCHE

El final de la semana.

Te sentás.
Pensás en todo.

* [...]
-

Una semana.
{fui_despedido: Te echaron.}
{ayude_en_olla: Ayudaste en la olla.}
{participe_asamblea: Fuiste a una asamblea.}
{conte_a_alguien: Le contaste a alguien.}

* [...]
-

{not conte_a_alguien && not ayude_en_olla: Estuviste bastante solo esta semana.}

{juan_sabe_mi_situacion: Juan sabe lo que pasó. Te bancó a su manera.}

// Fragmento nocturno final
-> seleccionar_fragmento_domingo ->

-> domingo_resumen_ideas

=== domingo_resumen_ideas ===

Las ideas que internalizaste:
{idea_tengo_tiempo: - "Ahora tengo tiempo para esto."}
{idea_pedir_no_debilidad: - "Pedir ayuda no es debilidad."}
{idea_hay_cosas_juntos: - "Hay cosas que se hacen juntos."}
{idea_red_o_nada: - "La red o la nada."}
{idea_quien_soy: - "¿Quién soy sin laburo?" (involuntaria)}
{idea_esto_es_lo_que_hay: - "Esto es lo que hay." (involuntaria)}

La semana termina.
El juego también.
Por ahora.

* [Ver el final] -> sintesis_ideas

=== sintesis_ideas ===

~ idea_momento_sintesis = true
~ check_sinergias()

{ideas_activas >= 1:
    Un momento de silencio.
    Las ideas de la semana se acomodan.
}

{sinergia_colectiva >= 2:
    Algo se armó esta semana. No fue solo vos.
    Pedir ayuda, hacer juntos, sostener la red.
    Esas tres cosas se cruzan. Se sostienen.
}

{sinergia_individual >= 2:
    Algo cambió adentro. Todavía no sabés qué.
    Pero el tiempo y las preguntas dejaron marca.
}

{ideas_activas >= 4:
    Fue una semana entera. No una semana cualquiera.
    Algo se movió. En vos. En el barrio. En los dos.
}

{ideas_activas == 0:
    La semana pasó.
    No sabés si algo cambió.
}

* [...] -> evaluar_final

=== evaluar_final ===

// Evaluamos variables para determinar el final
// Los finales estan definidos en finales/finales.ink

// FINAL MÁS DURO - Colapso mental individual
{salud_mental <= 0:
    -> final_apagado
}

// FINAL DESTRUCCIÓN TEJIDO SOCIAL - Colapso colectivo
{llama <= 0:
    -> final_sin_llama
}

// FINAL IXCHEL - Requiere vínculo con Ixchel
{vinculo == "ixchel" && ixchel_relacion >= 4 && ixchel_conto_historia && ayude_en_olla:
    -> final_tejido
}

// FINAL OCULTO - Requiere perfección
{conexion >= 9 && llama >= 8 && veces_que_ayude >= 3 && participe_asamblea && marcos_vino_a_asamblea && sofia_relacion >= 4 && elena_relacion >= 4 && tiene_todas_ideas():
    -> final_la_llama
}

// FINAL LUCHA COLECTIVA - Participación activa
{evaluar_lucha_colectiva():
    -> final_lucha_colectiva
}

// FINAL RED - Comunidad como red
{conexion >= 7 && llama >= 5 && ayude_en_olla:
    -> final_red
}

// FINAL VULNERABILIDAD - Apertura emocional genuina
{evaluar_vulnerabilidad():
    -> final_vulnerabilidad_honesta
}

// FINAL SOLO - Aislamiento completo
{conexion <= 3 && llama <= 2:
    -> final_solo
}

// FINAL GRIS - Depresión y soledad
{salud_mental <= 2 && conexion <= 4:
    -> final_gris
}

// FINAL PEQUEÑO CAMBIO - Algo movió adentro
{evaluar_pequeno_cambio():
    -> final_pequeno_cambio
}

// Default: segun nivel de conexion
{conexion >= 5:
    -> final_quizas
- else:
    -> final_incierto
}


// --- INCLUDES: OTROS ---

## FILE: fragmentos/fragmentos.ink

// ============================================
// FRAGMENTOS - Sistema de perspectivas alternas
// ============================================

// Los fragmentos son ventanas a la vida de otros personajes.
// Ocurren durante la noche, cuando el protagonista duerme.
// El jugador no controla estas escenas, solo las observa.

// La mayoría de los fragmentos están integrados en cada día
// para mantener el contexto narrativo.

// Este archivo contiene fragmentos compartidos y utilidades.

// ============================================
// FRAGMENTOS DE IXCHEL (la guatemalteca)
// ============================================

=== fragmento_ixchel_intro ===

// Ixchel aparece a partir del jueves
// Reemplaza el lugar que ocupaba la "venezolana" genérica

Ixchel termina de limpiar la cocina del restaurante.
Sus manos están rojas por el agua caliente y el detergente.

"Dale, bolita, apurate que cerramos", grita el encargado.

No es boliviana. Es guatemalteca. Maya-K'iche'.
Se lo dijo tres veces. Él sigue diciendo "bolita".
Para él, todos los indígenas son lo mismo.

Ixchel no contesta.
Su dignidad es un silencio antiguo.

Piensa en su abuela en Quetzaltenango.
En el tejido que le enseñó.
Acá no hay tejidos. Solo grasa y platos sucios.

Sale a la calle. El frío de Montevideo le corta la cara.
Le duele la espalda.
Pero sigue de pie.

"Mañana será otro día", dice en su lengua.
Nadie la escucha.
Nadie la entiende.
Pero ella se entiende.

->->

// ============================================
// FRAGMENTOS DE LA CIUDAD
// ============================================

=== fragmento_ciudad_noche ===

// Fragmento genérico de la ciudad de noche

La ciudad duerme.
O finge dormir.

Los que no tienen techo buscan donde quedarse.
Los que tienen techo tratan de no verlos.

Las luces de la rambla.
Los edificios de Pocitos.
Los cantegriles al fondo.

Todo convive.
Todo ignora.

La misma ciudad.
Mundos distintos.

->->

// ============================================
// NOTAS DE DISEÑO
// ============================================

// Los fragmentos sirven para:
// 1. Mostrar que otros personajes tienen sus propias vidas
// 2. Dar información que el protagonista no tiene
// 3. Crear empatía con la comunidad
// 4. Mostrar las consecuencias sistémicas

// Reglas de los fragmentos:
// - El jugador NO puede actuar durante un fragmento
// - Los fragmentos son cortos (50-100 palabras)
// - Cada fragmento muestra UN momento, UNA perspectiva
// - Los fragmentos dependen de las acciones del día

// ============================================
// FRAGMENTO DE JUAN EN EL LABURO
// ============================================

=== fragmento_juan_laburo ===
// Fragmento de Juan en el laburo sin vos

Juan llega al laburo.
Tu escritorio está vacío.

Nadie dice nada. Pero todos miran.

El jefe pasa como si nada. "Buenos días."

Juan aprieta los dientes.
Sigue laburando.

->->

// ============================================
// FRAGMENTO DE IXCHEL TEJIENDO
// ============================================

=== fragmento_ixchel_tejido ===
// Fragmento de Ixchel tejiendo de noche

En un cuarto pequeño, Ixchel teje.

Los colores son de allá. Los movimientos son de acá.
Un puente entre mundos que nadie ve.

"Ri qa tzij, ri qa k'aslemal."
Nuestras palabras, nuestra vida.

->->

// ============================================
// SISTEMA DE SELECCION DE FRAGMENTOS
// ============================================

=== seleccionar_fragmento_viernes ===
// Elige un fragmento para la noche del viernes
{ayude_en_olla:
    -> fragmento_sofia_cocina ->
- else:
    {vinculo == "marcos":
        -> fragmento_marcos_insomnio ->
    - else:
        -> fragmento_ciudad_noche ->
    }
}
->->

=== seleccionar_fragmento_sabado ===
// Elige un fragmento para la noche del sabado
{participe_asamblea:
    -> fragmento_sofia_asamblea ->
- else:
    {vinculo == "elena":
        -> fragmento_elena_recuerdo ->
    - else:
        {vinculo == "diego":
            -> fragmento_diego_llamada ->
        - else:
            -> fragmento_marcos_balcon ->
        }
    }
}
->->

=== seleccionar_fragmento_domingo ===
// Fragmento final - basado en vinculo
{vinculo == "sofia":
    -> fragmento_sofia_pibes ->
}
{vinculo == "elena":
    -> fragmento_elena_banco ->
}
{vinculo == "diego":
    -> fragmento_diego_mate ->
}
{vinculo == "marcos":
    -> fragmento_marcos_musica ->
}
{vinculo == "juan":
    -> fragmento_juan_cena ->
}
{vinculo == "ixchel":
    -> fragmento_ixchel_altar ->
}
// Fallback
-> fragmento_ciudad_noche ->
->->


## FILE: finales/finales.ink

// ============================================
// FINALES
// ============================================

=== final_la_llama ===
# ENDING:final_la_llama

# FINAL: LA LLAMA

El lunes llega.

No tenés laburo.
Pero tenés algo que pocos tienen.

* [...]
-

La olla no solo sobrevivió.
Creció.

La asamblea no fue solo un evento.
Fue el principio.

* [...]
-

Sofía te mira diferente ahora.
"Sos parte del equipo."

Elena te dijo: "Raúl estaría orgulloso."

Diego ya no se siente tan solo.
"Gracias por bancarme."

{marcos_vino_a_asamblea:
    Marcos volvió.
    De a poco. Pero volvió.
    "Capaz que hay algo," dijo ayer.
    Capaz.
}

Y hay una llama.

No es esperanza ingenua.
No es ilusión.

* [...]
-

Es conocimiento.
De que juntos, hay algo.

* [...]
-

El sistema no cambió.
No va a cambiar mañana.
Quizás nunca.

Pero ustedes sí cambiaron.

* [...]
-

Y la llama no se apaga.

Los tres meses empiezan.
No sabés qué viene.
Pero sabés con quién vas.

{pequenas_victorias >= 8:
    No salvaste el mundo.
    No cambiaste el sistema.

    Pero te levantaste.
    Te bañaste.
    Cocinaste.
    Saliste.

    Eso, a veces, es todo.
}

# FIN - "Prendimos fuego"

-> END

=== final_red ===
# ENDING:final_red

# FINAL: LA RED

El lunes llega.
No tenés laburo.
Pero tenés algo.

* [...]
-

La olla te espera.
Sofía te espera.
El barrio te espera.

* [...]
-

No es solución.
No hay trabajo mágico.
No hay plata que aparece.

* [...]
-

Pero hay una red.
Gente que te conoce.
Gente que sabe que existís.
Gente con la que hacés cosas.

* [...]
-

Los tres meses van a pasar.
Quizás consigas algo.
Quizás no.

Pero no estás solo.

{idea_red_o_nada: Elena tenía razón. La red o la nada.}

{llama >= 7:
    Y hay algo más.
    Un fuego pequeño.
    Una llama que no se apaga.
    La esperanza de que las cosas pueden ser diferentes.
    No mejor. Diferentes.
}

Esto no termina.
Es el principio de otra cosa.

{pequenas_victorias >= 8:
    No salvaste el mundo.
    No cambiaste el sistema.

    Pero te levantaste.
    Te bañaste.
    Cocinaste.
    Saliste.

    Eso, a veces, es todo.
}

# FIN

-> END

=== final_solo ===
# ENDING:final_solo

# FINAL: SOLO

El lunes llega.
No tenés laburo.
No tenés mucho.

* [...]
-

La semana pasó.
No conectaste.
No ayudaste.
No estuviste.

* [...]
-

El barrio sigue.
La olla sigue.
Pero sin vos.

* [...]
-

Los tres meses van a pasar.
Vas a buscar laburo.
Quizás consigas.
Quizás no.

* [...]
-

Pero vas a estar solo.
Como antes.
Como siempre.

* [...]
-

No es el fin del mundo.
Solo es gris.
Todo gris.

{idea_quien_soy: ¿Quién sos sin laburo? Todavía no sabés.}

{pequenas_victorias >= 8:
    No salvaste el mundo.
    No cambiaste el sistema.

    Pero te levantaste.
    Te bañaste.
    Cocinaste.
    Saliste.

    Eso, a veces, es todo.
}

# FIN

-> END

=== final_quizas ===
# ENDING:final_quizas

# FINAL: QUIZÁS

El lunes llega.
No tenés laburo.
Pero pasaron cosas.

* [...]
-

Conociste gente.
O reconectaste.
Algo se movió.

* [...]
-

No es suficiente todavía.
Pero es algo.

* [...]
-

Los tres meses van a pasar.
No sabés qué viene.
Pero hay un "quizás" que antes no había.

* [...]
-

Quizás la olla.
Quizás el barrio.
Quizás algo.

No es esperanza.
Es posibilidad.

{llama >= 4:
    Y eso, a veces, alcanza.
}

{pequenas_victorias >= 8:
    No salvaste el mundo.
    No cambiaste el sistema.

    Pero te levantaste.
    Te bañaste.
    Cocinaste.
    Saliste.

    Eso, a veces, es todo.
}

# FIN

-> END

=== final_incierto ===
# ENDING:final_incierto

# FINAL: INCIERTO

El lunes llega.
No tenés laburo.
No sabés qué tenés.

* [...]
-

La semana fue rara.
Pasaron cosas.
No pasó nada.

* [...]
-

Los tres meses empiezan a correr.
La cuenta regresiva.

* [...]
-

No sabés qué viene.
No sabés quién sos.
No sabés nada.

* [...]
-

Pero estás vivo.
Eso es algo.
¿No?

{pequenas_victorias >= 8:
    No salvaste el mundo.
    No cambiaste el sistema.

    Pero te levantaste.
    Te bañaste.
    Cocinaste.
    Saliste.

    Eso, a veces, es todo.
}

# FIN

-> END

=== final_sin_llama ===
# ENDING:final_sin_llama

# FINAL: SIN LLAMA

El barrio está en silencio.

No el silencio de la noche.
El silencio de la rendición.

* [...]
-

La olla cerró.
No por falta de ganas.
Por falta de gente que crea.

* [...]
-

Sofía se rindió.
"Para qué", dijo.
"Si nadie viene."

Elena ya no habla del 2002.
Ahora solo dice: "Era otra época."

Diego dejó de buscar.
"No hay nada que hacer."

* [...]
-

Marcos tenía razón desde el principio.
No hay llama.
Nunca la hubo.

* [...]
-

El tejido social no se rompe de golpe.
Se deshilacha.
Persona por persona.
Día por día.

* [...]
-

Hasta que no queda nada.

Y reconstruirlo toma generaciones.
No días.
No semanas.

Generaciones.

* [...]
-

{idea_hay_cosas_juntos:
    Hay cosas que solo se hacen juntos.

    Pero ya no hay "juntos".
}

{idea_red_o_nada:
    La red o la nada.

    Elegiste la nada.
    Sin querer. Sin darte cuenta.
    Pero la elegiste.
}

La llama se apagó.

# FIN - "El tejido social se destruyó"

-> END

=== final_apagado ===
# ENDING:final_apagado

# FINAL: APAGADO

La pantalla del teléfono te ilumina la cara en la oscuridad.

3:47 AM.

* [...]
-

Mañana tenés turno con la psiquiatra.
O pasado.
No te acordás.

* [...]
-

El antidepresivo está en el cajón.
"Tomar con alimentos."

No comiste nada desde... ayer? anteayer?

Da igual.

* [...]
-

Lo que no te dicen es que el problema no está en tu cabeza.

El problema está en que no podés pagar el alquiler trabajando 60 horas.

El problema está en que "flexibilidad laboral" significa que no sabés si comés el jueves.

El problema está en que "resiliencia" es la palabra que usan cuando quieren que aguantes lo inaguantable.

* [...]
-

No estás enfermo.

El sistema está enfermo.

* [...]
-

Pero ellos te venden la pastilla.

Y vos te la tomás.

Porque mañana hay que levantarse igual.

* [...]
-

{idea_quien_soy:
    ¿Quién sos sin laburo?

    Nadie.
    Eso es lo que el sistema te dice.
}

{idea_esto_es_lo_que_hay:
    Esto es lo que hay.

    Y lo que hay te está matando de a poco.
}

La luz del teléfono se apaga.

# FIN - "El realismo capitalista"

-> END

=== final_tejido ===
# ENDING:final_tejido

# FINAL: EL TEJIDO

El lunes llega.
No tenés laburo.
Pero tenés hilos.

* [...]
-

Ixchel te enseñó algo que no tiene nombre en castellano.

Que la comunidad es un tejido.
Que cada persona es un hilo.
Que cuando uno se rompe, los demás sostienen.

* [...]
-

No es la olla. No es la asamblea.
Es algo más antiguo.

Un saber que cruzó océanos y fronteras.
Que sobrevivió a todo lo que quisieron matarlo.

* [...]
-

"Ri qa tzij, ri qa k'aslemal", dice Ixchel.
Nuestras palabras, nuestra vida.

No entendés el idioma.
Pero entendés el gesto.

{ixchel_conto_historia:
    Los pájaros y las montañas del huipil.
    El tejido que conecta.
    Lo que sobrevive.
}

* [...]
-

Mañana hay olla.
Mañana hay tejido.
Mañana hay comunidad.

No lo arregla. No lo soluciona.
Pero lo sostiene.

# FIN - "El tejido que conecta"

-> END

=== final_gris ===
# ENDING:final_gris

# FINAL: GRIS

El lunes llega.

Todo pesa.
El cuerpo.
La cabeza.
Todo.

* [...]
-

{salud_mental <= 1:
    La salud mental se desgastó.
    No es una cosa.
    Son muchas.
    El despido.
    La soledad.
    Las preguntas sin respuesta.
}

Los tres meses están ahí.
Pero no los sentís como colchón.
Los sentís como cuenta regresiva.

* [...]
-

No hay final feliz.
No hay final triste.
Solo hay mañana.
Y pasado.
Y el otro día.

* [...]
-

Uno atrás del otro.
Hasta que algo cambie.
O no.

{idea_esto_es_lo_que_hay: Esto es lo que hay. Por ahora.}

{pequenas_victorias >= 8:
    No salvaste el mundo.
    No cambiaste el sistema.

    Pero te levantaste.
    Te bañaste.
    Cocinaste.
    Saliste.

    Eso, a veces, es todo.
}

# FIN

-> END

=== final_pequeno_cambio ===
# ENDING:final_pequeno_cambio

# FINAL: PEQUEÑO CAMBIO

El lunes llega.
No tenés laburo.
Pero algo es distinto.

* [...]
-

No es grande. No es histórico.
No cambia el mundo.

Pero vos cambiaste.

* [...]
-

Un poco. Apenas.
Como cuando girás la cabeza y ves algo que siempre estuvo ahí.

{conte_a_alguien:
    Le contaste a alguien. Eso cambió algo.
    No en el mundo. En vos.
}

{ayude_en_olla:
    Pelaste papas. Serviste guiso.
    No es revolución. Es presencia.
}

* [...]
-

Los tres meses empiezan.
No sabés qué viene.

Pero algo se movió.
Adentro. Donde importa.

{pequenas_victorias >= 5:
    Pequeñas victorias.
    Levantarse. Bañarse. Salir.
    Hablar. Escuchar. Estar.

    Eso, a veces, es el cambio.
}

# FIN - "Algo se movió"

-> END

=== final_vulnerabilidad_honesta ===
# ENDING:final_vulnerabilidad_honesta

# FINAL: VULNERABILIDAD

El lunes llega.
No tenés laburo.
Pero dejaste de fingir.

* [...]
-

Le dijiste a alguien que estabas mal.
No es heroísmo. Es honestidad.

* [...]
-

{conte_a_alguien:
    Dijiste "estoy mal" y no se cayó el mundo.
    La persona te escuchó.
    No te arregló. No te salvó.
    Te escuchó.
    Y eso alcanzó.
}

{salud_mental <= 3:
    La cabeza sigue pesando.
    Pero ya no pesás solo.

    Alguien sabe.
    Alguien vio.
    Eso cambia las cosas.
    No las arregla. Las cambia.
}

* [...]
-

Los tres meses empiezan.
La incertidumbre sigue.

Pero hay una grieta en el muro.
Una grieta por donde entra algo de luz.

No es esperanza. Es aire.

{idea_pedir_no_debilidad:
    Pedir ayuda no es debilidad.
    Lo aprendiste esta semana.
    Duele. Pero funciona.
}

# FIN - "La grieta por donde entra la luz"

-> END

=== final_lucha_colectiva ===
# ENDING:final_lucha_colectiva

# FINAL: LUCHA COLECTIVA

El lunes llega.
No tenés laburo.
Pero tenés un plan.

* [...]
-

La asamblea no fue solo hablar.
Salieron cosas.
Propuestas. Ideas. Gente que se comprometió.

* [...]
-

{participe_asamblea:
    En la asamblea dijeron:
    "Esto no se arregla solo."
    "Esto se arregla juntos."
    Y por primera vez, creíste.
}

{veces_que_ayude >= 3:
    Ayudaste tantas veces que ya te conocen.
    "El nuevo", dicen. Pero con cariño.
    Sos parte.
}

* [...]
-

La olla no es caridad.
Es organización.

La asamblea no es queja.
Es acción.

El barrio no es geografía.
Es decisión.

* [...]
-

Los tres meses empiezan.
Pero esta vez no son solo tuyos.

{llama >= 7:
    La llama arde.
    No como incendio. Como fogón.
    Como reunión. Como olla.
    Como lo que pasa cuando la gente decide
    que sola no puede,
    pero junta sí.
}

Mañana hay asamblea de nuevo.
Y vos vas a estar.

# FIN - "La organización es esperanza"

-> END


// ============================================
// INICIO DEL JUEGO
// ============================================

-> inicio

=== inicio ===

# UN DÍA MÁS
# AUDIO:bgm_rutina

Suena el despertador. Todavía está oscuro afuera.
El colchón tiene un hundimiento que ya tiene la forma de tu cuerpo.
En la cocina, la canilla gotea. Siempre gotea.

Otra semana que empieza. Otra semana como todas.
Todavía no sabés lo que viene.

* [Levantarse] -> creacion_personaje

=== creacion_personaje ===

# ANTES DE EMPEZAR

Te mirás en el espejo del baño. El vidrio tiene una rajadura en la esquina.
Treinta y algo. Ojeras que ya son parte de tu cara.

* [...]
-

Laburás. Pagás las cuentas. Más o menos.
A veces llegás justo. A veces no llegás.

* [...]
-

Vivís en el barrio.
Conocés a la gente de vista, de cruce, de historia compartida.
El almacenero que te fía. La vecina que barre la vereda a las siete.
El perro que ladra siempre en la misma esquina.

* [...]
-

Pero hay cosas que solo vos sabés.
Cosas que cargás cuando caminás por la calle.
Cosas que no se ven.

-> elegir_perdida

=== elegir_perdida ===

# ALGO FALTA.

* [Un plato que nadie más usa en la alacena.]
    ~ perdida = "familiar"
    La última vez que lo vi estaba en la cama del hospital, flaco como nunca.
    Me apretó la mano. No dijo nada. No hacía falta.
    Me dejó cosas: una caja de fotos, una deuda con el banco, la costumbre de mirar el teléfono a las ocho.
    -> elegir_atadura

* [Una taza de café que sobra todas las mañanas.]
    ~ perdida = "relacion"
    Se fue un martes. O un jueves. Ya no importa el día.
    Dejó un cepillo de dientes que tardé meses en tirar.
    A veces la veo en el almacén de la vuelta. Nos saludamos como desconocidos.
    El barrio quedó partido al medio.
    -> elegir_atadura

* [Un diploma que junta polvo arriba del ropero.]
    ~ perdida = "futuro"
    Me acuerdo del día que rendí el último examen.
    Pensé: "Ahora empieza todo". Todavía estoy esperando.
    A veces agarro el cartón, le saco el polvo. Lo vuelvo a guardar.
    El pibe que lo consiguió ya no existe.
    -> elegir_atadura

* [Una foto donde no reconozco mi propia sonrisa.]
    ~ perdida = "vacio"
    No sé cuándo pasó. No hubo un día, un momento.
    Solo a veces me miro al espejo y veo a alguien cansado.
    Algo se fue. O capaz nunca estuvo.
    Sigo buscando.
    -> elegir_atadura

=== elegir_atadura ===

# PERO NO TE VAS.

* [Una alarma en el celular que dice "llamar a mamá".]
    ~ atadura = "responsabilidad"
    Suena todos los días a las ocho. A veces la ignoro. Después me siento mal.
    Vive sola desde que murió mi viejo. No me pide nada. Pero sé que espera.
    Hay días que pienso en irme lejos. Después pienso en ella sola en esa casa.
    -> elegir_posicion

* [La marca de mi altura en el marco de la puerta.]
    ~ atadura = "barrio"
    Crecí en estas calles. Conozco cada baldosa floja, cada perro que ladra.
    Mi viejo pintó esta casa. Mi abuelo plantó el árbol de la vereda.
    Irme sería como arrancarme un pedazo. No sé cuál.
    -> elegir_posicion

* [Una valija que armé hace dos años y nunca abrí.]
    ~ atadura = "inercia"
    Está debajo de la cama, juntando polvo.
    A veces la miro. Pienso: mañana. Pasado.
    Pero mañana llega y yo sigo acá, mirando la valija.
    -> elegir_posicion

* [El olor a pan de la panadería de la esquina.]
    ~ atadura = "algo"
    No sé explicarlo. Hay algo en este lugar.
    El saludo del almacenero. La vecina que siempre tiene yerba de más.
    Pequeñas cosas. Casi nada. Pero algo.
    -> elegir_posicion

=== elegir_posicion ===

# ¿Y MAÑANA?

* [El mismo camino al laburo, las mismas baldosas flojas.]
    ~ posicion = "ajeno"
    Mañana va a ser igual que hoy. Y pasado igual que mañana.
    No es queja. Es lo que hay.
    Algunos le dicen resignación. Yo le digo realismo.
    -> asignar_vinculo

* [Una planta que riego todas las mañanas.]
    ~ posicion = "esperanzado"
    La compré cuando me mudé. Casi se me muere dos veces.
    Pero ahí sigue. Cada tanto le sale una hoja nueva.
    Pequeñas cosas. Capaz que con todo es así.
    -> asignar_vinculo

* [Un mensaje de grupo que tengo silenciado.]
    ~ posicion = "quemado"
    Antes opinaba. Discutía. Me calentaba.
    Ahora leo por arriba y sigo de largo.
    Ya vi esta película. Sé cómo termina.
    -> asignar_vinculo

* [La gotera del techo que nunca arreglo.]
    ~ posicion = "ambiguo"
    Pongo el balde. Se llena. Lo vacío.
    Podría arreglarlo. Podría no arreglarlo.
    A veces me pregunto si importa.
    -> asignar_vinculo

=== asignar_vinculo ===

# HAY ALGUIEN.

En el barrio hay gente. Caras conocidas, nombres que recordás a medias.

Pero un momento te vuelve siempre.

* [Un tupper de guiso que apareció en tu puerta. "Sobró", te dijeron. Mentira.]
    ~ vinculo = "sofia"
    Era Sofía. La de la olla popular.
    Sus pibes iban a la misma escuela. O iban.
    Nunca hablaron de ese tupper.
    Pero desde entonces se miran distinto.
    -> confirmar_inicio

* [Un banco de plaza. Una vieja que te dijo "mirá qué grande estás", como si te conociera de siempre.]
    ~ vinculo = "elena"
    Era Elena. La veterana.
    Conoció a tu familia. O vos la ayudaste una vez.
    Te mira como esperando algo.
    No sabés si podés dárselo.
    -> confirmar_inicio

* [Un tipo con una mochila, mirando un papel con una dirección. Le señalaste el camino.]
    ~ vinculo = "diego"
    Era Diego. Había llegado hacía poco.
    Te buscó después. Preguntó cosas. Confió en vos.
    No sabés si merecés esa confianza.
    -> confirmar_inicio

* [Un portón cerrado. Sabés quién vive ahí. Hace rato que no lo ves.]
    ~ vinculo = "marcos"
    Es Marcos. El que se alejó.
    Antes eran cercanos. Antes de que él se quemara.
    Ahora se cruzan y es raro.
    Hay algo ahí que ninguno termina de cerrar.
    -> confirmar_inicio

* [Una mujer en la cocina de la olla. Pica verduras como si rezara. No la conocés todavía.]
    ~ vinculo = "ixchel"
    Es Ixchel. No sabés su nombre todavía.
    Pero algo en sus manos te llamó la atención.
    Una precisión antigua. Un silencio que dice cosas.
    Alguien te contó que vino de lejos.
    -> confirmar_inicio

=== confirmar_inicio ===

# LISTO

{perdida == "familiar": Perdiste a alguien. El hueco sigue.}
{perdida == "relacion": Perdiste una relación. Se disolvió.}
{perdida == "futuro": Perdiste un futuro. La forma que tenía tu vida.}
{perdida == "vacio": Perdiste algo que no sabés nombrar.}

{atadura == "responsabilidad": Te quedás por responsabilidad.}
{atadura == "barrio": Te quedás por el barrio.}
{atadura == "inercia": Te quedás por inercia.}
{atadura == "algo": Te quedás porque hay algo.}

{posicion == "ajeno": Nunca fuiste de política.}
{posicion == "quemado": Creías. Ya no.}
{posicion == "esperanzado": Todavía creés. Pero.}
{posicion == "ambiguo": No sabés qué creés.}

Tu historia está con {vinculo == "sofia": Sofía}{vinculo == "elena": Elena}{vinculo == "diego": Diego}{vinculo == "marcos": Marcos}{vinculo == "ixchel": Ixchel}.

La semana empieza.
Todavía no sabés lo que viene.

* [Empezar la semana] -> lunes_amanecer

