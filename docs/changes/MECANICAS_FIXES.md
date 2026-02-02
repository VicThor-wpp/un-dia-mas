# MECANICAS_FIXES.md - Revisión Técnica de Mecánicas

**Fecha:** 2026-02-02
**Agente:** Subagente de Correcciones Técnicas

---

## 1. RESUMEN EJECUTIVO

Se realizó una revisión técnica de las mecánicas del juego "Un Día Más", verificando:
- Sistema de variables
- Evaluadores de finales
- Balance de recursos
- Flujo del domingo y conexión con finales

**Resultado general:** El sistema está bien implementado. Se encontraron inconsistencias menores documentadas abajo.

---

## 2. VARIABLES ANALIZADAS

### Variables Existentes (OK)
| Variable | Ubicación | Estado |
|----------|-----------|--------|
| `lucia_relacion` | variables.ink:95 | ✅ Existe |
| `bruno_tension` | variables.ink:129 | ✅ Existe (proxy para "conoce_a_bruno") |
| `tiago_captado_por_bruno` | variables.ink:123 | ✅ Existe |
| `inercia_maxima_alcanzada` | variables.ink:173 | ✅ Existe |

### Variables Sugeridas NO Necesarias
| Variable | Motivo |
|----------|--------|
| `rechazos` | No se usa en ningún lugar del código |
| `conoce_a_bruno` | `bruno_tension > 0` funciona como proxy |

### Variable Potencial a Agregar
| Variable | Uso | Estado |
|----------|-----|--------|
| `busque_laburo` | Tracking de intentos de búsqueda de empleo | OPCIONAL - no afecta finales |

---

## 3. ANÁLISIS DE FINALES

### 3.1 Flujo de Evaluación

El evaluador de finales (`evaluar_final` en domingo.ink) se ejecuta correctamente al final del domingo, después de:
1. `cierres_fase_2` (tunnels de personajes)
2. `sintesis_ideas` (momento de reflexión)

### 3.2 Tabla de Finales y Condiciones

| Final | Condiciones | Alcanzable | Notas |
|-------|-------------|------------|-------|
| `final_apagado` | inercia >= 10 | ✅ | Game-over mental |
| `final_sin_llama` | llama <= 0 | ✅ | Game-over colectivo (protección hasta sábado) |
| `final_resistencia_silenciosa` | !asamblea && ayudas >= 3 && conexion >= 4 | ✅ | Ruta clara |
| `final_despertar` | inercia_max >= 8 && inercia <= 4 && conexion >= 5 | ✅ | Requiere recuperarse de espiral |
| `final_juan_migrante` | juan_relacion >= 4 && juan_decidio_irse && juan_se_despidio | ⚠️ | Depende de arco de Juan |
| `final_represion` | asamblea && conexion >= 5 && llama >= 5 && inercia <= 4 | ⚠️ | Ver nota abajo |
| `final_huelga` | asamblea && ayudas >= 2 && llama >= 6 && conexion >= 6 && diego >= 4 | ✅ | Ruta organizada |
| `final_ocupacion` | asamblea && conexion >= 7 && llama >= 7 && ayudas >= 3 | ✅ | Ruta radical |
| `final_tejido` | vinculo == "ixchel" && ixchel >= 4 && historia && ayude | ⚠️ | Requiere elegir Ixchel como vínculo |
| `final_la_llama` | conexion >= 9 && llama >= 8 && muchas condiciones | ✅ | Final oculto, muy difícil |
| `final_lucha_colectiva` | asamblea && ayudas >= 2 && llama >= 5 && conexion >= 6 | ✅ | Ruta principal positiva |
| `final_red` | conexion >= 7 && llama >= 5 && ayude_en_olla | ✅ | Ruta comunitaria |
| `final_desercion` | !tiene_laburo && conexion >= 5 && inercia <= 4 | ✅ | Ver nota abajo |
| `final_vulnerabilidad` | conte_a_alguien && inercia <= 6 | ✅ | Ruta emocional |
| `final_solo` | conexion <= 3 && llama <= 2 | ✅ | Ruta aislamiento |
| `final_gris` | inercia >= 8 && conexion <= 4 | ✅ | Ruta depresiva |
| `final_pequeno_cambio` | conexion 4-6 && victorias >= 5 | ✅ | Cambio menor |
| `final_quizas` | conexion >= 5 (default positivo) | ✅ | Fallback esperanzado |
| `final_incierto` | conexion < 5 (default negativo) | ✅ | Fallback neutro |

### 3.3 Notas sobre Finales Específicos

#### `final_represion`
**Issue:** Las condiciones actuales (participación positiva + baja inercia) generan un resultado de represión policial de forma determinística. Esto no refleja la narrativa donde la represión debería ser consecuencia de una acción radical fallida.

**Recomendación:** Considerar agregar un flag `hubo_conflicto_radical` o hacerlo probabilístico con chequeo de dados.

#### `final_desercion`
**Nota:** La condición `!tiene_laburo` siempre es true al final (el protagonista fue despedido), por lo que este final es alcanzable por cualquier jugador con conexion >= 5 e inercia <= 4. Considerar si esto es intencional o si debería requerir una acción explícita de "deserción".

### 3.4 Finales Huérfanos
No se encontraron finales sin ruta de acceso.

---

## 4. INCONSISTENCIAS ENCONTRADAS

### 4.1 Funciones Evaluadoras No Usadas

En `recursos.ink` hay funciones evaluadoras que **NO se llaman** en el evaluador de domingo:

```ink
// DEFINIDAS pero NO USADAS en domingo.ink
evaluar_huelga()       // usa condiciones directas distintas
evaluar_ocupacion()    // usa condiciones directas distintas
evaluar_la_llama()     // usa condiciones directas distintas
evaluar_red()          // usa condiciones directas distintas
evaluar_tejido()       // usa condiciones directas distintas
```

**Impacto:** Las funciones tienen umbrales más bajos que las condiciones directas en domingo.ink. Por ejemplo:
- `evaluar_red()` en recursos.ink: `conexion >= 5 && llama >= 4`
- Condición directa en domingo.ink: `conexion >= 7 && llama >= 5`

**Recomendación:** Unificar usando las funciones o eliminar las funciones no usadas para evitar confusión.

### 4.2 Variable `tiene_laburo` ✅

~~La variable `tiene_laburo` se inicializa como `true` pero nunca se cambia explícitamente a `false` después del despido.~~

**Verificado:** En `ubicaciones/laburo.ink:489` se setea correctamente:
```ink
~ fui_despedido = true
~ tiene_laburo = false
```

No requiere corrección.

---

## 5. BALANCE DE RECURSOS

### 5.1 Energía

| Aspecto | Valor | Evaluación |
|---------|-------|------------|
| Energía inicial | 5 | ✅ Correcto |
| Máximo | 5 | ✅ Correcto |
| Recuperación diaria base | 4 | ✅ Correcto |
| Bonus por conexion >= 5 | +1 | ✅ Buena progresión |
| Bonus por idea_tengo_tiempo | +1 | ✅ Recompensa narrativa |
| Penalización por inercia >= 7 | -1 | ✅ Consecuencia mecánica |

**Conclusión:** Sistema de energía bien balanceado.

### 5.2 La Llama

| Aspecto | Valor | Evaluación |
|---------|-------|------------|
| Llama inicial | 5 | ✅ Frágil pero presente |
| Piso protegido | 2 (hasta sábado) | ✅ Evita game-over temprano |
| Protección por idea_no_es_individual | Limita caída a 1/día | ✅ Recompensa por conciencia |

**Conclusión:** La protección de la llama es una mecánica elegante que permite que el jugador experimente amenazas sin game-over prematuro.

### 5.3 Inercia

| Aspecto | Valor | Evaluación |
|---------|-------|------------|
| Inercia inicial | 5 | ✅ Punto medio |
| Umbral game-over | 10 (12 con sinergia) | ✅ Alcanzable pero no fácil |
| Segunda oportunidad | Intervención del vínculo | ✅ Red de seguridad narrativa |

**Conclusión:** El sistema de inercia está bien calibrado con safety nets apropiados.

---

## 6. VERIFICACIÓN DE SINERGIAS

Las sinergias de ideas funcionan correctamente:

| Sinergia | Componentes | Efecto |
|----------|-------------|--------|
| Colectiva | hay_cosas_juntos + pedir_no_debilidad + red_o_nada | Ventaja en chequeos comunitarios |
| Agencia | tengo_tiempo + no_es_individual | Umbral game-over sube a 12 |

---

## 7. VERIFICACIÓN DE TUNNELS (Fase 2)

Todos los tunnels de personajes de Fase 2 terminan correctamente con `->->`:

| Archivo | Tunnel | Estado |
|---------|--------|--------|
| tiago.ink | `tiago_domingo` | ✅ |
| tiago.ink | `tiago_en_asamblea` | ✅ |
| cacho.ink | `cacho_domingo` | ✅ |
| cacho.ink | `cacho_redencion` | ✅ |
| claudia.ink | `claudia_domingo` | ✅ |
| bruno.ink | `bruno_domingo` | ✅ |
| lucia.ink | `lucia_cierre_domingo` | ✅ |
| lucia.ink | `lucia_en_asamblea` | ✅ |

---

## 8. CAMBIOS REALIZADOS

### No se realizaron cambios al código.

Esta revisión fue de diagnóstico. Los issues encontrados son menores y no bloquean la jugabilidad.

---

## 9. RECOMENDACIONES FUTURAS

1. **Unificar evaluadores:** Usar las funciones de recursos.ink en domingo.ink o eliminarlas
2. **Revisar `final_represion`:** Considerar si debería ser probabilístico o requerir una acción específica
3. **Documentar rutas de finales:** Crear guía para testers con caminos claros a cada final

---

## 10. CÓMO ALCANZAR CADA FINAL (Guía de Rutas)

### Finales Negativos (Game Over)
- **final_apagado:** Maximizar inercia (evitar acciones, no conectar)
- **final_sin_llama:** Dejar que la olla falle, no ayudar, llama cae a 0

### Finales de Aislamiento
- **final_solo:** Conexion <= 3, llama <= 2 (no participar, no ayudar)
- **final_gris:** Inercia >= 8, conexion <= 4 (pasivo + aislado)

### Finales de Cambio Personal
- **final_pequeno_cambio:** Conexion 4-6, pequenas_victorias >= 5
- **final_vulnerabilidad:** Contar a alguien + inercia <= 6
- **final_despertar:** Llegar a inercia alta, luego recuperarse con ayuda

### Finales de Comunidad
- **final_red:** Conexion >= 7, llama >= 5, ayudar en olla
- **final_resistencia_silenciosa:** No ir a asamblea pero ayudar >= 3 veces
- **final_lucha_colectiva:** Asamblea + ayudas + llama alta

### Finales Radicales
- **final_huelga:** Asamblea + ayudas + diego_relacion >= 4 + llama >= 6
- **final_ocupacion:** Conexion >= 7 + llama >= 7 + ayudas >= 3

### Finales Especiales
- **final_juan_migrante:** Desarrollar relación con Juan, despedirse
- **final_tejido:** Vincular con Ixchel, escuchar su historia
- **final_la_llama:** Perfección (conexion 9+, llama 8+, todas las ideas, etc.)

---

*Documento generado por revisión técnica de mecánicas*
