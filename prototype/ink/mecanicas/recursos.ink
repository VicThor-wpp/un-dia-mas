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
VAR llama = 3

// ACUMULACIÓN: Complicidad con la lógica del capital (0-10, oculto)
VAR acumulacion = 0

// SALUD MENTAL: Baja con eventos difíciles (0-5)
// Empezamos en 5, va bajando con el estrés
VAR salud_mental = 5

// --- SITUACIÓN MATERIAL ---

VAR indemnizacion = 0
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
    ~ ajustar(conexion, cantidad, 0, 10)

=== function bajar_conexion(cantidad) ===
    ~ ajustar(conexion, -cantidad, 0, 10)

=== function subir_dignidad(cantidad) ===
    ~ ajustar(dignidad, cantidad, 0, 10)

=== function bajar_dignidad(cantidad) ===
    ~ ajustar(dignidad, -cantidad, 0, 10)

=== function subir_llama(cantidad) ===
    ~ ajustar(llama, cantidad, 0, 10)

=== function bajar_llama(cantidad) ===
    ~ ajustar(llama, -cantidad, 0, 10)

=== function subir_acumulacion(cantidad) ===
    ~ ajustar(acumulacion, cantidad, 0, 10)

=== function bajar_salud_mental(cantidad) ===
    ~ salud_mental = salud_mental - cantidad
    ~ salud_mental = (salud_mental < 0) ? 0 : salud_mental

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
