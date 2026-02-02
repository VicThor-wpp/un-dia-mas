# Ajuste Final LA LLAMA - Balance de Ideas

**Fecha:** 2026-02-02

## Problema

El final épico "LA LLAMA" era prácticamente inalcanzable porque requería `tiene_todas_ideas()` que exigía las 4 ideas originales. Esto creaba una barrera muy alta.

## Solución Implementada

### 1. Función `contar_ideas_positivas()` (ya existía en ideas.ink)

Cuenta todas las ideas positivas disponibles:
- `idea_tengo_tiempo`
- `idea_pedir_no_debilidad`
- `idea_hay_cosas_juntos`
- `idea_red_o_nada`
- `idea_red_sostiene`
- `idea_ayni`
- `idea_no_es_individual`
- `idea_el_problema_no_soy_yo`

**Total: 8 ideas positivas posibles**

### 2. `evaluar_la_llama()` ajustada (recursos.ink)

```ink
=== function evaluar_la_llama() ===
    // Final épico - AJUSTADO: umbrales reducidos
    // Antes: conexion>=9, llama>=8, 4 ideas, 8 condiciones
    // Ahora: conexion>=7, llama>=6, 3 ideas positivas, 5 condiciones
    { conexion >= 7 && llama >= 6 && contar_ideas_positivas() >= 3 && participe_asamblea && veces_que_ayude >= 2:
        ~ return true
    }
    ~ return false
```

### 3. `tiene_todas_ideas()` (sin cambios)

Se mantiene para compatibilidad con otros usos, pero ya no se usa en `evaluar_la_llama()`:

```ink
=== function tiene_todas_ideas() ===
    ~ return idea_tengo_tiempo && idea_pedir_no_debilidad && idea_hay_cosas_juntos && idea_red_o_nada
```

## Resultado

| Antes | Después |
|-------|---------|
| conexion >= 9 | conexion >= 7 |
| llama >= 8 | llama >= 6 |
| 4 ideas específicas obligatorias | 3 de 8 ideas posibles |
| ~8 condiciones | 5 condiciones |

**Impacto:** El final sigue siendo difícil (requiere conexión alta, llama fuerte, participación activa y aprendizaje) pero ahora es alcanzable para jugadores comprometidos sin requerir perfección absoluta.
