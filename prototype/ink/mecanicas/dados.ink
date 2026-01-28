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
    // Mental checks: advantage if awake (low inertia), disadvantage if zombie (high inertia)
    { inercia <= 2:
        ~ return chequeo_ventaja(modificador, dificultad)
    }
    { inercia >= 8:
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
    ~ disminuir_inercia(1)
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
    ~ aumentar_inercia(1)

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
