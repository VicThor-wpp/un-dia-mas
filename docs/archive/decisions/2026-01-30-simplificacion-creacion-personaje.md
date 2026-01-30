# Simplificación de Creación de Personaje

**Fecha:** 2026-01-30

## Resumen

Se simplificó el flujo de creación de personaje para hacerlo más claro y directo, reduciendo de 10 pasos a 7.

## Cambios Realizados

### 1. Género - Ahora explícito

**Antes (confuso):**
```ink
* [El espejo devuelve la imagen de siempre.]        → varón
* [El espejo muestra más de lo que el mundo ve.]    → mujer
* [El espejo no dice nada que me defina.]           → no binario
```

**Después (claro):**
```ink
* [Soy varón.]
* [Soy mujer.]
* [No soy ninguna de esas cosas. O soy las dos.]
```

**Razón:** Las opciones anteriores no comunicaban qué género estabas eligiendo. El jugador descubría la elección después de hacerla.

### 2. Veganismo - Removido de creación

**Antes:** Pregunta obligatoria durante creación de personaje con texto largo y panfletario.

**Después:** Eliminado de la creación. La variable `es_vegano` queda en `false` por defecto. TODO: mover la elección a un momento de gameplay (ej: primera comida en la olla).

**Razón:**
- Rompía el flujo emocional (género → raza → ¿comés carne? → pérdida)
- Texto excesivamente largo y didáctico
- Puede introducirse más orgánicamente durante el juego

### 3. Sección `creacion_rutina` - Fusionada

**Antes:** Dos pantallas con `[...]` sin elección real, solo texto de transición.

**Después:** Fusionado en una sola sección `transicion_barrio` más compacta.

**Razón:** Alargaba sin sumar. El texto de contexto se condensó.

## Flujo Resultante

| Paso | Sección | Qué elige |
|------|---------|-----------|
| 1 | `inicio` | Nada (intro) |
| 2 | `creacion_personaje` | Género (3 opciones claras) |
| 3 | `creacion_cuerpo` | Raza/etnia (4 opciones) |
| 4 | `transicion_barrio` | Nada (transición breve) |
| 5 | `elegir_perdida` | La pérdida (4 opciones) |
| 6 | `elegir_atadura` | Por qué se queda (4 opciones) |
| 7 | `elegir_posicion` | Posición política (4 opciones) |
| 8 | `asignar_vinculo` | El vínculo (5 opciones) |
| 9 | `confirmar_inicio` | Nada (resumen) |

**Total:** 9 pantallas (antes 10), elecciones más claras.

## Archivos Modificados

- `prototype/ink/main.ink` - Flujo de creación
- `prototype/ink/variables.ink` - Comentario en `es_vegano`

## Trabajo Pendiente

- [ ] Implementar elección de veganismo durante gameplay (sugerido: primera visita a la olla)
