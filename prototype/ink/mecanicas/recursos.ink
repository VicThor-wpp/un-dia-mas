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
