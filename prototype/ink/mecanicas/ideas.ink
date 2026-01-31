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

// --- FUNCION PARA IDEA AYNI (Ixchel) ---

=== function activar_ayni() ===
    { not idea_ayni:
        ~ idea_ayni = true
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
    // Activar sinergia colectiva si tiene las 3
    { sinergia_colectiva >= 3:
        ~ tiene_sinergia_colectiva_activa = true
    }

    // Sinergia individual: tengo_tiempo + quien_soy
    ~ sinergia_individual = 0
    { idea_tengo_tiempo:
        ~ sinergia_individual += 1
    }
    { idea_quien_soy:
        ~ sinergia_individual += 1
    }

    // Sinergia de agencia: tengo_tiempo + no_es_individual
    { idea_tengo_tiempo && idea_no_es_individual:
        ~ tiene_sinergia_agencia = true
    }

// --- FUNCIONES DE CONSULTA ---

=== function count_ideas() ===
    ~ return ideas_activas

=== function tiene_sinergia_colectiva() ===
    ~ return sinergia_colectiva >= 2

=== function tiene_sinergia_individual() ===
    ~ return sinergia_individual >= 2

// --- FUNCIONES DE ACTIVACION: IDEAS POLITICAS ---

=== function activar_no_es_individual() ===
    { not idea_no_es_individual:
        ~ idea_no_es_individual = true
        ~ ideas_activas += 1
        ~ check_sinergias()
    }

=== function activar_antagonismo_clase() ===
    { not idea_antagonismo_clase:
        ~ idea_antagonismo_clase = true
        ~ ideas_activas += 1
        ~ check_sinergias()
    }

=== function activar_autonomia_posible() ===
    { not idea_autonomia_posible:
        ~ idea_autonomia_posible = true
        ~ ideas_activas += 1
        ~ check_sinergias()
    }

=== function activar_sabotaje_legitimo() ===
    { not idea_sabotaje_legitimo:
        ~ idea_sabotaje_legitimo = true
        ~ ideas_activas += 1
        ~ check_sinergias()
    }

// --- SINERGIA POLITICA ---

=== function tiene_sinergia_politica() ===
    // Cuenta cuántas ideas políticas tiene
    ~ temp politicas = 0
    { idea_no_es_individual: 
        ~ politicas += 1 
    }
    { idea_antagonismo_clase: 
        ~ politicas += 1 
    }
    { idea_autonomia_posible: 
        ~ politicas += 1 
    }
    { idea_sabotaje_legitimo: 
        ~ politicas += 1 
    }
    ~ return politicas >= 2

=== function tiene_conciencia_radical() ===
    // Tiene las 3 ideas clave para acciones radicales
    ~ return idea_no_es_individual && idea_antagonismo_clase && idea_autonomia_posible

// --- EVALUACION DE IDEAS INVOLUNTARIAS ---
// Llamar en transiciones nocturnas

=== function evaluar_ideas_involuntarias() ===
    // idea_quien_soy: se activa con inercia alta
    { inercia >= 6 && not idea_quien_soy:
        ~ activar_quien_soy()
        # NOTIFICATION:negative:Una idea se instala: ¿Quién soy sin laburo?
    }
    // idea_esto_es_lo_que_hay: se activa con aislamiento + baja dignidad
    { conexion <= 2 && dignidad <= 3 && not idea_esto_es_lo_que_hay:
        ~ activar_esto_es_lo_que_hay()
        # NOTIFICATION:negative:Una idea se instala: Esto es lo que hay...
    }

// --- EFECTOS MECANICOS DE IDEAS ---

// Modificador para chequeos sociales (idea_pedir_no_debilidad)
=== function modificador_idea_social() ===
    { idea_pedir_no_debilidad:
        ~ return 1
    }
    ~ return 0

// Modificador negativo por ideas involuntarias
=== function penalizacion_idea_mental() ===
    // idea_esto_es_lo_que_hay penaliza chequeos mentales
    // PERO idea_no_es_individual lo contrarresta
    { idea_esto_es_lo_que_hay && not idea_no_es_individual:
        ~ return -1
    }
    ~ return 0

// Energia extra al inicio del día (idea_tengo_tiempo)
=== function bonus_energia_idea() ===
    { idea_tengo_tiempo:
        ~ return 1
    }
    ~ return 0

// Recuperación extra al ayudar (idea_hay_cosas_juntos + idea_ayni)
=== function recuperar_por_ayudar() ===
    ~ temp recuperado = 0
    { idea_hay_cosas_juntos:
        ~ recuperado += 1
    }
    { idea_ayni:
        ~ recuperado += 1
    }
    { recuperado > 0:
        ~ recuperar_energia(recuperado)
    }

// Reducción automática de inercia al final del día (idea_red_o_nada)
=== function efecto_red_o_nada() ===
    { idea_red_o_nada && conexion >= 5:
        ~ disminuir_inercia(1)
        # NOTIFICATION:positive:La red te sostiene
    }

// Inercia en noches solitarias (idea_quien_soy negativa)
// PERO idea_pedir_no_debilidad lo contrarresta
=== function efecto_noche_solitaria() ===
    { conexion <= 3:
        { idea_quien_soy && not idea_pedir_no_debilidad:
            ~ aumentar_inercia(1)
            # NOTIFICATION:negative:La pregunta vuelve: ¿quién sos?
        }
    }

// Protección de llama (idea_no_es_individual)
=== function proteccion_llama() ===
    ~ return idea_no_es_individual

// Cuenta ideas positivas (para finales)
=== function contar_ideas_positivas() ===
    ~ temp count = 0
    { idea_tengo_tiempo:
        ~ count += 1
    }
    { idea_pedir_no_debilidad:
        ~ count += 1
    }
    { idea_hay_cosas_juntos:
        ~ count += 1
    }
    { idea_red_o_nada:
        ~ count += 1
    }
    { idea_ayni:
        ~ count += 1
    }
    { idea_no_es_individual:
        ~ count += 1
    }
    ~ return count
