// ============================================
// SISTEMA DE RECURSOS
// ============================================

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
    ~ temp dignidad_antes = dignidad
    ~ ajustar(dignidad, cantidad, 0, 10)
    // Feedback narrativo en thresholds
    {
    - dignidad >= 8 && dignidad_antes < 8:
        # STAT_THRESHOLD
        Algo vuelve.
        No es orgullo. Es algo más tranquilo.
        Te reconocés.
    - dignidad >= 5 && dignidad_antes < 5:
        # STAT_THRESHOLD
        Todavía estás acá.
        Eso ya es algo.
    }

=== function bajar_dignidad(cantidad) ===
    ~ temp dignidad_antes = dignidad
    ~ ajustar(dignidad, -cantidad, 0, 10)
    // Feedback narrativo en thresholds críticos
    {
    - dignidad <= 2 && dignidad_antes > 2:
        # STAT_THRESHOLD
        Algo se rompe adentro.
        No es que no valés. Es que empezás a creerlo.
    }

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

    ~ ajustar(llama, -cantidad_real, 0, 10)

    // Feedback narrativo en thresholds críticos
    {
    - llama <= 2 && llama_antes > 2:
        # STAT_THRESHOLD
        La llama se apaga.
        El frío entra.
        Es difícil creer en algo.
    }

=== function aumentar_inercia(cantidad) ===
    // Techo por fase. Antes del despido la semana te desgasta hasta el borde,
    // pero el colapso pertenece a lo que viene después: sin este techo la
    // inercia llegaba a 10 el miércoles y el jueves solo servía para morirse
    // el primer día en que el juego te daba con qué defenderte.
    ~ temp techo_inercia = 10
    { dia_actual < 4:
        ~ techo_inercia = 8
    }
    ~ ajustar(inercia, cantidad, 0, techo_inercia)
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

// Desgaste de fondo del laburo: el jefe que pasa sin decir nada, el evento
// menor de tensión. Se dispara todos los días laborales, así que como suma
// fija era una cuenta regresiva. La primera vez pega; para la tercera ya es
// la misma nota repetida y el cuerpo se acostumbra. Los golpes con causa
// —la reunión, la citación, la firma— siguen sumando siempre.
=== function desgaste_rutina() ===
    ~ desgaste_rutina_acumulado += 1
    { desgaste_rutina_acumulado <= 2:
        ~ aumentar_inercia(1)
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

// El juego no puede matarte antes del jueves. La olla, la asamblea y los
// vínculos recién abren el día 4: hasta entonces no hay ninguna herramienta
// para bajar la inercia, y morir sin haber podido elegir entre encerrarse y
// salir contradice aquello de lo que trata el juego. La inercia se sigue
// acumulando; lo que queda en suspenso es el colapso.
{ dia_actual < 4:
    ~ umbral_inercia = 99
}

{inercia >= umbral_inercia:
    // Segunda oportunidad, una sola vez por partida: el vínculo aparece y te
    // saca del borde. Antes esto hacía el túnel y caía en final_apagado igual,
    // así que la escena existía pero no salvaba a nadie.
    { not vinculo_intervino && vinculo_esta_cerca():
        ~ vinculo_intervino = true
        -> intervencion_vinculo ->
        ->->
    }
    // Sin red de apoyo = game over
    -> final_apagado
}
{llama <= 0:
    // Segunda oportunidad en domingo si ayudaste en olla
    { not chispa_usada && dia_actual == 7 && ayude_en_olla && sofia_relacion >= 3:
        ~ chispa_usada = true
        -> chispa_emergencia ->
        ->->
    }
    -> final_sin_llama
}
->->

// ¿Tu vínculo tiene relación suficiente como para aparecer cuando te caés?
=== function vinculo_esta_cerca() ===
    { vinculo == "sofia":
        ~ return sofia_relacion >= 3
    }
    { vinculo == "elena":
        ~ return elena_relacion >= 3
    }
    { vinculo == "diego":
        ~ return diego_relacion >= 3
    }
    { vinculo == "marcos":
        ~ return marcos_relacion >= 3
    }
    { vinculo == "juan":
        ~ return juan_relacion >= 3
    }
    { vinculo == "ixchel":
        ~ return ixchel_relacion >= 3
    }
    ~ return false

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
{ vinculo == "juan":
    Es Juan.
    "Che, ¿estás bien? Me llegó que andabas mal."
}
{ vinculo == "ixchel":
    Es Ixchel.
    "Hermano, te estuve buscando. Vine a verte."
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
        # NOTIFICATION:negative:La vergüenza pesa
    }
    // Alta dignidad reduce inercia
    { dignidad >= 8:
        ~ disminuir_inercia(1)
        # NOTIFICATION:positive:Dormís más tranquilo
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
    // NOTA: diego_relacion >= 4 para evitar solapamiento con REPRESIÓN (que usa < 4)
    { participe_asamblea && veces_que_ayude >= 2 && llama >= 6 && conexion >= 6 && diego_relacion >= 4:
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
    ~ recuperar_por_ayudar()
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
