# Corrección: Evaluación de finales inline → funciones

**Fecha:** 2026-02-02  
**Archivo modificado:** `prototype/ink/dias/domingo.ink`  
**Archivo de referencia:** `prototype/ink/mecanicas/recursos.ink`

## Problema

Las condiciones para evaluar finales en `evaluar_final` (domingo.ink) usaban umbrales inline que no coincidían con las funciones `evaluar_*()` definidas en `recursos.ink`. Las funciones tienen umbrales más bajos (ajustados para mejor balance).

## Cambios realizados

### 1. `final_huelga`
**ANTES:**
```ink
{participe_asamblea && veces_que_ayude >= 2 && llama >= 6 && conexion >= 6 && diego_relacion >= 4:
    -> final_huelga
}
```
**DESPUÉS:**
```ink
{evaluar_huelga():
    -> final_huelga
}
```
**Diferencia:** `diego_relacion >= 4` → `diego_relacion >= 3`

### 2. `final_ocupacion`
**ANTES:**
```ink
{participe_asamblea && conexion >= 7 && llama >= 7 && veces_que_ayude >= 3:
    -> final_ocupacion
}
```
**DESPUÉS:**
```ink
{evaluar_ocupacion():
    -> final_ocupacion
}
```
**Diferencia:** `conexion >= 7 && llama >= 7 && veces_que_ayude >= 3` → `conexion >= 6 && llama >= 6 && veces_que_ayude >= 2`

### 3. `final_tejido` (Ixchel)
**ANTES:**
```ink
{vinculo == "ixchel" && ixchel_relacion >= 4 && ixchel_conto_historia && ayude_en_olla:
    -> final_tejido
}
```
**DESPUÉS:**
```ink
{evaluar_tejido():
    -> final_tejido
}
```
**Diferencia:** `ixchel_relacion >= 4` → `ixchel_relacion >= 3`

### 4. `final_la_llama`
**ANTES:**
```ink
{conexion >= 9 && llama >= 8 && veces_que_ayude >= 3 && participe_asamblea && marcos_vino_a_asamblea && sofia_relacion >= 4 && elena_relacion >= 4 && tiene_todas_ideas():
    -> final_la_llama
}
```
**DESPUÉS:**
```ink
{evaluar_la_llama():
    -> final_la_llama
}
```
**Diferencia:** Umbrales reducidos significativamente:
- `conexion >= 9` → `conexion >= 7`
- `llama >= 8` → `llama >= 6`
- `tiene_todas_ideas()` → `contar_ideas_positivas() >= 3`
- Se eliminaron requisitos de `marcos_vino_a_asamblea`, `sofia_relacion >= 4`, `elena_relacion >= 4`

### 5. `final_red`
**ANTES:**
```ink
{conexion >= 7 && llama >= 5 && ayude_en_olla:
    -> final_red
}
```
**DESPUÉS:**
```ink
{evaluar_red():
    -> final_red
}
```
**Diferencia:** `conexion >= 7 && llama >= 5` → `conexion >= 5 && llama >= 4`

## Beneficios

1. **Unificación:** Una sola fuente de verdad para los umbrales (recursos.ink)
2. **Balance:** Los finales positivos son más alcanzables
3. **Mantenibilidad:** Cambiar umbrales solo requiere editar recursos.ink
