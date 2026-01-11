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
    { tirada == 1:
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
