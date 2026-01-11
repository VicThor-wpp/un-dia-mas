// ============================================
// SISTEMA DE RECURSOS
// ============================================

// --- RECURSOS PRINCIPALES ---

// ENERGÍA: Capacidad de hacer cosas hoy (3-5)
VAR energia = 4
VAR energia_max = 5

// CONEXIÓN: Tu lugar en el tejido del barrio (0-10)
VAR conexion = 5

// DIGNIDAD: Lo que el sistema te saca de a poco (0-10)
VAR dignidad = 5

// LA LLAMA: Capacidad colectiva de esperanza (0-10)
VAR la_llama = 3

// ACUMULACIÓN: Complicidad con la lógica del capital (0-10, oculto)
VAR acumulacion = 0

// TRAUMA: Se acumula, nunca baja (0-10)
VAR trauma = 0

// --- SITUACIÓN MATERIAL ---

VAR indemnizacion = 0
VAR tiene_laburo = true
VAR dia_actual = 1

// --- FUNCIONES DE RECURSOS ---

// Mostrar estado de recursos (para debug o UI)
=== function mostrar_recursos() ===
    ~ return "E:{energia} C:{conexion} D:{dignidad} L:{la_llama}"

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
    ~ ajustar(conexion, cantidad, 0, 10)

=== function bajar_conexion(cantidad) ===
    ~ ajustar(conexion, -cantidad, 0, 10)

=== function subir_dignidad(cantidad) ===
    ~ ajustar(dignidad, cantidad, 0, 10)

=== function bajar_dignidad(cantidad) ===
    ~ ajustar(dignidad, -cantidad, 0, 10)

=== function subir_llama(cantidad) ===
    ~ ajustar(la_llama, cantidad, 0, 10)

=== function bajar_llama(cantidad) ===
    ~ ajustar(la_llama, -cantidad, 0, 10)

=== function subir_acumulacion(cantidad) ===
    ~ ajustar(acumulacion, cantidad, 0, 10)

=== function subir_trauma(cantidad) ===
    ~ ajustar(trauma, cantidad, 0, 10)

// --- CHEQUEOS DE ESTADO ---

=== function esta_agotado() ===
    ~ return energia <= 0

=== function esta_cansado() ===
    ~ return energia <= 2

=== function esta_conectado() ===
    ~ return conexion >= 6

=== function esta_aislado() ===
    ~ return conexion <= 3

=== function esta_traumatizado() ===
    ~ return trauma >= 4

=== function llama_viva() ===
    ~ return la_llama >= 5

=== function llama_apagandose() ===
    ~ return la_llama <= 2
