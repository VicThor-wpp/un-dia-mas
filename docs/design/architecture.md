# Arquitectura Técnica - Un Día Más

## Visión General

El proyecto usa una arquitectura modular basada en el patrón de **tunnels** de Ink, permitiendo separar la lógica narrativa en archivos reutilizables.

## Principios de Diseño

### 1. Separación de Responsabilidades

```
main.ink          → Punto de entrada y creación de personaje
variables.ink     → Estado global del juego
mecanicas/        → Sistemas de juego (dados, recursos)
ubicaciones/      → Escenas por lugar físico
personajes/       → Diálogos y arcos de NPCs
dias/             → Flujo temporal (routing)
```

### 2. Variables Centralizadas

Todas las variables globales están en `variables.ink`:

```ink
// NO hacer esto en módulos:
VAR mi_variable = false  // ❌ Causa errores de duplicación

// SÍ hacer esto - solo en variables.ink:
VAR mi_variable = false  // ✓
```

### 3. Tunnels para Reutilización

Los módulos devuelven control al llamador con `->->`:

```ink
// ubicaciones/casa.ink
=== casa_despertar ===
El despertador suena.
{tiene_laburo: Otro día de laburo.}
{not tiene_laburo: No hay despertador. Te despertás igual.}
->->  // Retorna al llamador

// dias/lunes.ink
=== lunes_amanecer ===
-> casa_despertar ->      // Llama al tunnel
-> lunes_siguiente        // Continúa aquí después
```

## Estructura de Archivos

### main.ink

```ink
// Includes en orden de dependencia
INCLUDE mecanicas/dados.ink      // Primero: funciones básicas
INCLUDE mecanicas/recursos.ink   // Segundo: usa dados
INCLUDE variables.ink            // Tercero: estado global
INCLUDE ubicaciones/*.ink        // Cuarto: escenas
INCLUDE personajes/*.ink         // Quinto: NPCs
INCLUDE dias/*.ink               // Sexto: flujo
INCLUDE fragmentos/fragmentos.ink
INCLUDE finales/finales.ink

-> inicio  // Punto de entrada
```

### mecanicas/dados.ink

Sistema de tiradas:

```ink
// Tirada básica
=== function d6() ===
    ~ return RANDOM(1, 6)

// Chequeo con modificador
// Retorna: 2=crítico, 1=éxito, 0=fallo, -1=pifia
=== function chequeo(modificador, dificultad) ===
    ~ temp tirada = d6()
    ~ ultima_tirada = tirada
    { tirada == 6: ~ return 2 }
    { tirada == 1: ~ return -1 }
    { tirada + modificador >= dificultad: ~ return 1 }
    ~ return 0
```

### mecanicas/recursos.ink

Gestión de recursos con límites:

```ink
=== function ajustar(ref variable, cantidad, minimo, maximo) ===
    ~ variable += cantidad
    { variable < minimo: ~ variable = minimo }
    { variable > maximo: ~ variable = maximo }

=== function subir_conexion(cantidad) ===
    ~ ajustar(conexion, cantidad, 0, 10)
```

### dias/*.ink

Solo routing, las escenas están en módulos:

```ink
=== lunes_amanecer ===
~ dia_actual = 1
~ energia = 4

-> casa_despertar ->
-> lunes_salir

=== lunes_salir ===
-> casa_salir ->
-> lunes_parada_bondi

=== lunes_parada_bondi ===
-> bondi_esperar_parada ->
{ultima_tirada == 1:
    -> lunes_llegada_tarde
- else:
    -> lunes_llegada
}
```

### ubicaciones/*.ink

Escenas reutilizables por lugar:

```ink
// ubicaciones/olla.ink
=== olla_llegada ===
La olla del barrio.
Un galpón con mesas largas.
Olor a comida.
{olla_en_crisis: Hay tensión en el ambiente.}
->->

=== olla_ayudar_cocina ===
Te ponés a ayudar.
~ ayude_en_olla = true
~ veces_que_ayude += 1
~ subir_conexion(1)
->->
```

### personajes/*.ink

Cada NPC tiene:
- Encuentros casuales
- Conversaciones profundas
- Fragmentos nocturnos (perspectiva del NPC)

```ink
// personajes/sofia.ink
=== sofia_encuentro_casual ===
Sofía cruza la calle.
Lleva bolsas. Siempre lleva bolsas.
->->

=== sofia_fragmento_noche ===
// Perspectiva de Sofía mientras el protagonista duerme
Sofía no puede dormir.
Los números de la olla no cierran.
->->
```

## Flujo de Juego

```
inicio
  ↓
creacion_personaje
  ↓
elegir_perdida → elegir_atadura → elegir_posicion
  ↓
asignar_vinculo (aleatorio)
  ↓
lunes_amanecer → ... → domingo_noche
  ↓
evaluar_final
  ↓
final_X (según variables)
```

## Condicionales Comunes

### Por día del despido

```ink
{dia_actual >= 4:
    // Después del miércoles (despedido)
}
{tiene_laburo:
    // Antes del despido
}
```

### Por relación con NPCs

```ink
{sofia_relacion >= 4:
    Sofía te sonríe.
}
{vinculo == "sofia":
    // Sofia es tu vínculo especial
}
```

### Por estado de la olla

```ink
{olla_en_crisis:
    La situación es crítica.
}
{ayude_en_olla:
    Ya conocés a la gente.
}
```

## Tags de Ink

Usamos tags para:

```ink
# LUNES                    // Título de sección
# LA OLLA - TARDE          // Subtítulo

# IDEA DISPONIBLE          // Mecánica especial
```

## Patrones de Decisión

### Decisión simple

```ink
* [Opción A] -> resultado_a
* [Opción B] -> resultado_b
```

### Decisión condicional

```ink
* {energia >= 2} [Opción costosa]
    ~ energia -= 2
    -> resultado
* [Opción gratuita] -> otro_resultado
```

### Decisión con dados

```ink
~ temp resultado = chequeo(0, 4)
{resultado == 2:
    // Crítico
}{resultado == 1:
    // Éxito
}{resultado == 0:
    // Fallo
}{resultado == -1:
    // Pifia
}
```

## Testing

Para probar cambios:

1. Compilar: `inklecate -o test.json ink/main.ink`
2. Verificar errores de compilación
3. Probar flujo en Inky o web

### Errores Comunes

| Error | Causa | Solución |
|-------|-------|----------|
| `Variable already declared` | VAR duplicado | Mover a variables.ink |
| `not found: knot_name` | Tunnel faltante | Crear en módulo correspondiente |
| `Expected ->->` | Tunnel sin retorno | Agregar `->->` al final |

## Extensión

### Agregar nuevo NPC

1. Crear `personajes/nombre.ink`
2. Agregar variables en `variables.ink`
3. Agregar `INCLUDE` en `main.ink`
4. Referenciar desde `dias/*.ink`

### Agregar nueva ubicación

1. Crear `ubicaciones/lugar.ink`
2. Definir tunnels con `->->` al final
3. Agregar `INCLUDE` en `main.ink`
4. Llamar desde días con `-> lugar_escena ->`

### Agregar nuevo final

1. Agregar knot en `finales/finales.ink`
2. Agregar condición en `domingo.ink` → `evaluar_final`
