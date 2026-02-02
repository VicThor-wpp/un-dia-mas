# Revisión de Coherencia de Finales

**Fecha:** 2026-02-02  
**Revisor:** Subagente udm-editor-finales

---

## Resumen Ejecutivo

Se encontraron **5 problemas** de inconsistencia entre el código y la documentación. Se aplicaron correcciones.

---

## Problemas Encontrados

### 1. ❌ Solapamiento REPRESIÓN/HUELGA

**Problema:** Con `diego_relacion = 3`, ambos finales son alcanzables:
- REPRESIÓN: `diego_relacion < 4` → true
- HUELGA: `diego_relacion >= 3` → true

Como REPRESIÓN se evalúa primero, HUELGA nunca se alcanza con diego=3.

**Causa:** El código de HUELGA dice `diego_relacion >= 3`, pero la documentación dice `>= 4`.

**Corrección:** Cambiar `evaluar_huelga()` a requerir `diego_relacion >= 4`.

### 2. ❌ Documentación desactualizada: OCUPACIÓN

**Documentación dice:**
```
conexion >= 7 AND llama >= 7 AND veces_que_ayude >= 3
```

**Código dice:**
```
conexion >= 6 AND llama >= 6 AND veces_que_ayude >= 2
```

**Corrección:** Actualizar documentación (el código tiene comentario "AJUSTADO").

### 3. ❌ Documentación desactualizada: LA_LLAMA

**Documentación dice:**
```
conexion >= 9 AND llama >= 8 AND tiene_todas_ideas() AND marcos_vino AND sofia >= 4 AND elena >= 4 AND veces_que_ayude >= 3
```

**Código dice:**
```
conexion >= 7 AND llama >= 6 AND contar_ideas_positivas() >= 3 AND participe_asamblea AND veces_que_ayude >= 2
```

**Corrección:** Actualizar documentación (el código tiene comentario "AJUSTADO").

### 4. ❌ Documentación desactualizada: RED

**Documentación dice:**
```
conexion >= 7 AND llama >= 5
```

**Código dice:**
```
conexion >= 5 AND llama >= 4
```

**Corrección:** Actualizar documentación.

### 5. ❌ Documentación desactualizada: TEJIDO

**Documentación dice:**
```
ixchel_relacion >= 4
```

**Código dice:**
```
ixchel_relacion >= 3
```

**Corrección:** Actualizar documentación.

---

## Verificaciones OK ✅

### Consistencia de llamadas
Todas las funciones `evaluar_*()` existen en `recursos.ink`:
- ✅ `evaluar_resistencia_silenciosa()`
- ✅ `evaluar_despertar()`
- ✅ `evaluar_juan_migrante()`
- ✅ `evaluar_huelga()`
- ✅ `evaluar_ocupacion()`
- ✅ `evaluar_tejido()`
- ✅ `evaluar_la_llama()`
- ✅ `evaluar_lucha_colectiva()`
- ✅ `evaluar_red()`
- ✅ `evaluar_vulnerabilidad()`
- ✅ `evaluar_pequeno_cambio()`
- ✅ `contar_ideas_positivas()` (en ideas.ink)

### Orden de prioridad
El orden es correcto:
1. Game overs (APAGADO, SIN_LLAMA)
2. Especiales (RESISTENCIA_SILENCIOSA, DESPERTAR, JUAN_MIGRANTE, REPRESIÓN)
3. Épicos (HUELGA, OCUPACIÓN, TEJIDO, LA_LLAMA, LUCHA_COLECTIVA)
4. Positivos (RED, DESERCIÓN, VULNERABILIDAD)
5. Negativos (SOLO, GRIS, PEQUEÑO_CAMBIO)
6. Fallback (QUIZÁS, INCIERTO)

### Exclusividad de finales (después de correcciones)

**HUELGA vs OCUPACIÓN vs REPRESIÓN:**
- REPRESIÓN: `participe_asamblea && conexion>=5 && llama>=5 && inercia<=4 && (veces_que_ayude<2 || diego_relacion<4)`
- HUELGA: `participe_asamblea && veces_que_ayude>=2 && llama>=6 && conexion>=6 && diego_relacion>=4` (CORREGIDO)
- OCUPACIÓN: `participe_asamblea && conexion>=6 && llama>=6 && veces_que_ayude>=2`

Con la corrección:
- Si diego >= 4 y demás condiciones → HUELGA
- Si diego < 4 pero demás OK → REPRESIÓN primero, luego posible OCUPACIÓN
- OCUPACIÓN es el fallback si no tienes a Diego

**LA_LLAMA vs LUCHA_COLECTIVA vs RED:**
- LA_LLAMA: conexion>=7, llama>=6, ideas>=3, asamblea, ayude>=2
- LUCHA_COLECTIVA: asamblea, ayude>=2, llama>=5, conexion>=6
- RED: conexion>=5, llama>=4, ayude_en_olla

Orden correcto: LA_LLAMA (más exigente) → LUCHA_COLECTIVA → RED (menos exigente)

---

## Correcciones Aplicadas

### 1. recursos.ink: evaluar_huelga()
```diff
- { participe_asamblea && veces_que_ayude >= 2 && llama >= 6 && conexion >= 6 && diego_relacion >= 3:
+ { participe_asamblea && veces_que_ayude >= 2 && llama >= 6 && conexion >= 6 && diego_relacion >= 4:
```

### 2. finales.md: Actualización de condiciones
- OCUPACIÓN: actualizado a conexion>=6, llama>=6, veces_que_ayude>=2
- LA_LLAMA: actualizado a conexion>=7, llama>=6, contar_ideas_positivas()>=3
- RED: actualizado a conexion>=5, llama>=4
- TEJIDO: actualizado a ixchel_relacion>=3

---

## Estado Final

✅ **Sistema coherente** después de las correcciones.

Todos los finales son mutuamente exclusivos o tienen prioridad correcta.
La documentación refleja el código actual.
