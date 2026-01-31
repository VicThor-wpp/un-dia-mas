// ============================================
// SISTEMA DE RECURSOS
// ============================================

// --- RECURSOS PRINCIPALES ---

// ENERGÍA: Capacidad de hacer cosas hoy (3-5)
// CAMBIO: Empieza en 5 (antes 4)
VAR energia = 5
VAR energia_max = 5

// CONEXIÓN: Tu lugar en el tejido del barrio (0-10)
// Inicial: 3 (conocés pero no pertenecés todavía)
VAR conexion = 3

// DIGNIDAD: Lo que el sistema te saca de a poco (0-10)
VAR dignidad = 5

// LA LLAMA: Capacidad colectiva de esperanza (0-10)
// Inicial: 5 (frágil pero presente)
VAR llama = 5

// PESO ESTRUCTURAL: Reemplazado por INERCIA
// INERCIA: Resistencia al cambio y automatismo (0-10)
// 0: Despierto, agencia total
// 10: Zombi, parálisis total
VAR inercia = 5

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

// Recuperación diaria contextual (llamar al inicio de cada día)
=== function recuperar_energia_diaria() ===
    ~ energia = 4
    // Bonus por conexión alta (red de apoyo = mejor descanso)
    { conexion >= 5:
        ~ energia += 1
    }
    // Bonus por idea_tengo_tiempo
    { idea_tengo_tiempo:
        ~ energia += 1
    }
    // Penalización por inercia alta (agotamiento mental)
    { inercia >= 7:
        ~ energia -= 1
    }
    // Limitar a máximo
    { energia > energia_max:
        ~ energia = energia_max
    }
    { energia < 1:
        ~ energia = 1
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
    ~ temp cantidad_real = cantidad

    // Protección: idea_no_es_individual limita la caída a 1 por día
    { idea_no_es_individual && cantidad > 1:
        ~ cantidad_real = 1
    }

    // Piso temporal: no puede bajar de 2 hasta el sábado
    ~ temp nueva_llama = llama - cantidad_real
    { dia_actual < 6 && nueva_llama < 2:
        ~ llama = 2
        # NOTIFICATION:info:La llama titila pero resiste
    - else:
        ~ ajustar(llama, -cantidad_real, 0, 10)
    }

    // Feedback narrativo en thresholds críticos
    {
    - llama <= 2 && llama_antes > 2:
        # STAT_THRESHOLD
        La llama se apaga.
        El frío entra.
        Es difícil creer en algo.
    }

=== function aumentar_inercia(cantidad) ===
    ~ ajustar(inercia, cantidad, 0, 10)
    // Trackear máxima inercia alcanzada (para final_despertar)
    { inercia > inercia_maxima_alcanzada:
        ~ inercia_maxima_alcanzada = inercia
    }
    { inercia >= 8:
        # STAT_THRESHOLD:inercia,critical
    }
    { inercia >= 5 && inercia < 8:
        # STAT_THRESHOLD:inercia,high
    }

=== function disminuir_inercia(cantidad) ===
    ~ ajustar(inercia, -cantidad, 0, 10)
    { inercia <= 2:
        # STAT_THRESHOLD:inercia,low
    }

// Reducir inercia por acción específica (con notificación)
=== function reducir_inercia_accion(cantidad) ===
    ~ disminuir_inercia(cantidad)
    # NOTIFICATION:positive:Algo se afloja

// --- CHEQUEOS DE ESTADO ---

=== function esta_agotado() ===
    ~ return energia <= 0

=== function esta_cansado() ===
    ~ return energia <= 2

=== function esta_conectado() ===
    ~ return conexion >= 6

=== function esta_aislado() ===
    ~ return conexion <= 3

=== function inercia_alta() ===
    ~ return inercia >= 8

=== function llama_viva() ===
    ~ return llama >= 5

=== function llama_apagandose() ===
    ~ return llama <= 2

=== function tiene_todas_ideas() ===
    ~ return idea_tengo_tiempo && idea_pedir_no_debilidad && idea_hay_cosas_juntos && idea_red_o_nada

// --- CHEQUEO TEMPRANO DE GAME-OVER ---
// Tunnel: llamar en momentos críticos del día con -> check_game_over ->

=== check_game_over ===
// Umbral de inercia: 10 normal, 12 con sinergia_agencia
~ temp umbral_inercia = 10
{ tiene_sinergia_agencia:
    ~ umbral_inercia = 12
}

{inercia >= umbral_inercia:
    // Segunda oportunidad: si el vínculo tiene buena relación, interviene
    { vinculo == "sofia" && sofia_relacion >= 3:
        -> intervencion_vinculo ->
    }
    { vinculo == "elena" && elena_relacion >= 3:
        -> intervencion_vinculo ->
    }
    { vinculo == "diego" && diego_relacion >= 3:
        -> intervencion_vinculo ->
    }
    { vinculo == "marcos" && marcos_relacion >= 3:
        -> intervencion_vinculo ->
    }
    // Sin red de apoyo = game over
    -> final_apagado
}
{llama <= 0:
    // Segunda oportunidad en domingo si ayudaste en olla
    { dia_actual == 7 && ayude_en_olla && sofia_relacion >= 3:
        -> chispa_emergencia ->
    }
    -> final_sin_llama
}
->->

// --- INTERVENCIONES DE SEGUNDA OPORTUNIDAD ---

=== intervencion_vinculo ===
# CLEAR
El teléfono suena.

{ vinculo == "sofia":
    Es Sofía.
    "¿Estás bien? No te vi en la olla."
}
{ vinculo == "elena":
    Es Elena.
    "Pibe, ¿qué pasa? Hace días que no sabemos de vos."
}
{ vinculo == "diego":
    Es Diego.
    "Hermano, ¿todo bien? Me preocupé."
}
{ vinculo == "marcos":
    Es Marcos.
    "Che... sé que no hablamos mucho. Pero me acordé de vos."
}

No sabés qué decir.
Pero la voz al otro lado espera.

~ disminuir_inercia(3)
# NOTIFICATION:positive:Alguien te encontró

->->

=== chispa_emergencia ===
# CLEAR
El teléfono suena. Es Sofía.

"Te necesitamos en la olla. Hoy más que nunca."

La llama casi se apagó.
Pero alguien la está soplando.

~ llama = 2
# NOTIFICATION:positive:Una chispa resiste

->->

// --- EFECTOS DE DIGNIDAD ---

=== function evaluar_dignidad_nocturna() ===
    // Baja dignidad aumenta inercia (si no tiene idea protectora)
    { dignidad <= 2 && not idea_pedir_no_debilidad:
        ~ aumentar_inercia(1)
    }
    // Alta dignidad reduce inercia
    { dignidad >= 8:
        ~ disminuir_inercia(1)
    }

// --- EVALUACION DE FINALES ---

=== function evaluar_pequeno_cambio() ===
    // Hiciste poco pero algo cambió en vos
    { conexion >= 4 && conexion < 7 && pequenas_victorias >= 5:
        ~ return true
    }
    ~ return false

=== function evaluar_vulnerabilidad() ===
    // Mostraste vulnerabilidad genuina
    { conte_a_alguien && inercia <= 6:
        ~ return true
    }
    ~ return false

=== function evaluar_lucha_colectiva() ===
    // Participaste activamente en la lucha colectiva
    // AJUSTADO: umbrales reducidos (antes 7/7, ahora 5/6)
    { participe_asamblea && veces_que_ayude >= 2 && llama >= 5 && conexion >= 6:
        ~ return true
    }
    ~ return false

=== function evaluar_resistencia_silenciosa() ===
    // Ayudaste sin ir a la asamblea
    { not participe_asamblea && veces_que_ayude >= 3 && conexion >= 4:
        ~ return true
    }
    ~ return false

=== function evaluar_despertar() ===
    // Te recuperaste de una espiral
    { inercia_maxima_alcanzada >= 8 && inercia <= 4 && conexion >= 5:
        ~ return true
    }
    ~ return false

=== function evaluar_juan_migrante() ===
    // Juan se fue y te despediste
    { juan_relacion >= 4 && juan_decidio_irse && juan_se_despidio:
        ~ return true
    }
    ~ return false

=== function evaluar_la_llama() ===
    // Final épico - AJUSTADO: umbrales reducidos
    // Antes: conexion>=9, llama>=8, 4 ideas, 8 condiciones
    // Ahora: conexion>=7, llama>=6, 3 ideas positivas, 5 condiciones
    { conexion >= 7 && llama >= 6 && contar_ideas_positivas() >= 3 && participe_asamblea && veces_que_ayude >= 2:
        ~ return true
    }
    ~ return false

=== function evaluar_red() ===
    // AJUSTADO: umbrales reducidos (antes 7/5, ahora 5/4)
    { conexion >= 5 && llama >= 4 && ayude_en_olla:
        ~ return true
    }
    ~ return false

=== function evaluar_tejido() ===
    // Final de Ixchel - AJUSTADO
    { vinculo == "ixchel" && ixchel_relacion >= 3 && ixchel_conto_historia && ayude_en_olla:
        ~ return true
    }
    ~ return false

=== function evaluar_huelga() ===
    // AJUSTADO: condiciones reducidas
    { participe_asamblea && veces_que_ayude >= 2 && llama >= 6 && conexion >= 6 && diego_relacion >= 3:
        ~ return true
    }
    ~ return false

=== function evaluar_ocupacion() ===
    // AJUSTADO: umbrales reducidos (antes 7/7/3, ahora 6/6/2)
    { participe_asamblea && conexion >= 6 && llama >= 6 && veces_que_ayude >= 2:
        ~ return true
    }
    ~ return false

// ============================================
// TRACKING DE AYUDAS
// ============================================

=== function registrar_ayuda() ===
    ~ veces_que_ayude += 1
    { veces_que_ayude == 2:
        # NOTIFICATION:positive:Segunda vez ayudando
    }
    { veces_que_ayude == 3:
        # NOTIFICATION:positive:Ya sos parte del equipo
        # STAT_THRESHOLD:ayuda,milestone
    }
    { veces_que_ayude >= 4:
        # NOTIFICATION:positive:El barrio te reconoce
    }
