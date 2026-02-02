# Análisis: Lógica del Final REPRESIÓN

**Fecha:** 2026-02-02
**Archivo:** `dias/domingo.ink` → `evaluar_final`

## Condición Original

```ink
// FINAL REPRESIÓN - Intentaste luchar y te reprimieron
// Requiere intento de acción radical con mala suerte
{participe_asamblea && conexion >= 5 && llama >= 5 && inercia <= 4:
    -> final_represion
}
```

## Problema Identificado

La condición requiere **buen estado** (alta conexión, alta llama, baja inercia) pero produce un **final negativo**. A primera vista parece invertido.

### ¿Es intencional?

**SÍ**, la lógica narrativa es correcta:
- La represión es consecuencia de **luchar activamente**
- Precisamente porque te involucraste (conexión alta = red social, llama alta = esperanza/motivación, inercia baja = activo), te **expusiste** al aparato represivo
- El texto del final lo confirma: "La huelga duró tres días. La policía entró al cuarto día."

### El problema real: Orden de evaluación y solapamiento

```ink
// ORDEN ACTUAL:
6. final_represion  ← conexion>=5, llama>=5, inercia<=4
7. final_huelga     ← conexion>=6, llama>=6, diego>=4, veces_que_ayude>=2
8. final_ocupacion  ← conexion>=7, llama>=7, veces_que_ayude>=3
```

El `final_represion` se evalúa **ANTES** que `final_huelga` y `final_ocupacion`, lo que significa que puede "tragarse" casos que deberían llegar a esos finales más positivos.

**Ejemplo problemático:**
- Jugador con conexion=6, llama=6, inercia=3, veces_que_ayude=2, diego_relacion=4
- Califica para AMBOS: represión (condición más laxa) y huelga (más específico)
- Resultado: obtiene represión aunque merecía huelga

### El comentario dice algo que no se implementa

```ink
// Requiere intento de acción radical con mala suerte
```

No existe variable que represente "mala suerte" o "acción radical fallida".

## Solución Aplicada

### 1. Agregar condición diferenciadora

La represión ocurre cuando **intentaste luchar pero la organización no era suficientemente fuerte**:

```ink
// FINAL REPRESIÓN - Intentaste luchar pero la organización no alcanzó
// La represión golpea cuando hay acción sin suficiente base organizativa
{participe_asamblea && conexion >= 5 && llama >= 5 && inercia <= 4 && (veces_que_ayude < 2 || diego_relacion < 4):
    -> final_represion
}
```

**Lógica narrativa:**
- `veces_que_ayude < 2`: No construiste suficiente confianza/presencia
- `diego_relacion < 4`: Diego es el organizador; sin él, la acción es más vulnerable

### 2. Reordenar evaluación

Mover `final_represion` **después** de `final_huelga` y `final_ocupacion`. Así los finales positivos de lucha tienen prioridad cuando las condiciones se cumplen completamente.

### 3. Agregar comentario explicativo

Documentar en el código por qué las condiciones "positivas" llevan a un final "negativo".

## Cambios en el código

**Archivo:** `dias/domingo.ink`

```ink
// FINAL REPRESIÓN - Intentaste luchar pero la organización no alcanzó
// NOTA: Requiere "buenos" estados (conexion alta, llama alta, inercia baja)
// porque la represión es consecuencia de INVOLUCRARSE activamente.
// La diferencia con huelga/ocupación es que acá faltó base organizativa
// (pocas veces ayudando o sin Diego de aliado).
{participe_asamblea && conexion >= 5 && llama >= 5 && inercia <= 4 && (veces_que_ayude < 2 || diego_relacion < 4):
    -> final_represion
}
```

## Resultado

| Escenario | Antes | Después |
|-----------|-------|---------|
| Conexion=6, llama=6, diego=4, ayude=2 | REPRESIÓN ❌ | HUELGA ✅ |
| Conexion=5, llama=5, diego=2, ayude=1 | REPRESIÓN | REPRESIÓN ✅ |
| Conexion=7, llama=7, ayude=3 | REPRESIÓN ❌ | OCUPACIÓN ✅ |

La represión ahora representa correctamente: "luchaste pero sin suficiente organización, y te aplastaron".
