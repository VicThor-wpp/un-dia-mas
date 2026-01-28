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
    { idea_no_es_individual: ~ politicas += 1 }
    { idea_antagonismo_clase: ~ politicas += 1 }
    { idea_autonomia_posible: ~ politicas += 1 }
    { idea_sabotaje_legitimo: ~ politicas += 1 }
    ~ return politicas >= 2

=== function tiene_conciencia_radical() ===
    // Tiene las 3 ideas clave para acciones radicales
    ~ return idea_no_es_individual && idea_antagonismo_clase && idea_autonomia_posible
