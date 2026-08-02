# Sistema de Finales - Un Día Más

> Documentación técnica para diseñadores y testers.  
> Actualizado: 2026-02-02

## Resumen

El juego tiene **19 finales** organizados en 6 categorías según su tono y dificultad. Los finales se evalúan en orden de prioridad al final del domingo, y el primero que cumpla sus condiciones es el que se muestra.

### Distribución medida (2026-08-02)

Medida sobre 1.000 partidas con decisiones al azar, después del rebalanceo de
inercia. El jugador aleatorio es el piso, no el jugador real: sirve para ver si
el sistema deja lugar a algo más que un solo desenlace.

| Final | % aleatorio |
|-------|-------------|
| APAGADO | 53% |
| JUAN MIGRANTE | 14% |
| RESISTENCIA SILENCIOSA | 6% |
| QUIZÁS | 6% |
| LA RED | 5% |
| OCUPACIÓN | 5% |
| DESPERTAR | 5% |
| GRIS | 2% |
| resto (7 finales) | <1% cada uno |

Un jugador que decide a conciencia da vuelta el cuadro: simulando uno que elige
siempre la opción que menos inercia suma, APAGADO cae a **2%**. Antes del
rebalanceo ese mismo jugador moría el 64% de las veces, y el aleatorio el 93%.

Cuatro finales (SOLO, INCIERTO, TEJIDO, LA LLAMA y los radicales más exigentes)
siguen apareciendo poco o nada en juego aleatorio: son rutas que piden
intención sostenida, no un problema de balance en sí, pero conviene verificarlas
a mano antes de darlas por alcanzables.

---

## Variables Clave

| Variable | Rango | Descripción |
|----------|-------|-------------|
| `inercia` | 0-10 | Resistencia al cambio. 10 = parálisis total |
| `llama` | 0-10 | Esperanza colectiva del barrio |
| `conexion` | 0-10 | Tu lugar en el tejido social |
| `dignidad` | 0-10 | Lo que el sistema te saca de a poco |
| `veces_que_ayude` | 0+ | Contador de veces que ayudaste en la olla |
| `participe_asamblea` | bool | Fuiste a la asamblea del sábado |
| `conte_a_alguien` | bool | Compartiste tu vulnerabilidad |
| `ayude_en_olla` | bool | Ayudaste al menos una vez |

---

## Finales por Categoría

### 🔴 Game Over (2)

Finales de fracaso total. Se evalúan primero.

#### APAGADO 💀
- **Condición:** `inercia >= 10`
- **Probabilidad target:** ~5-10%
- **Notas:** Colapso mental individual. El "realismo capitalista" te apagó. Puede tener segunda oportunidad si el vínculo tiene relación ≥3.

#### SIN_LLAMA 🕯️
- **Condición:** `llama <= 0`
- **Probabilidad target:** ~5-10%
- **Notas:** Colapso colectivo. El tejido social se destruyó. Segunda oportunidad el domingo si ayudaste en olla y Sofia relación ≥3.

---

### 🟠 Negativos (2)

Finales tristes pero no catastróficos.

#### SOLO 👤
- **Condición:** `conexion <= 3 AND llama <= 2`
- **Probabilidad target:** ~10-15%
- **Notas:** Aislamiento completo. No conectaste con nadie. Todo gris.

#### GRIS 🌫️
- **Condición:** `inercia >= 8 AND conexion <= 4`
- **Probabilidad target:** ~10-15%
- **Notas:** Depresión y soledad. La salud mental se desgastó.

---

### 🟡 Neutrales (3)

Finales ambiguos. Ni victoria ni derrota.

#### INCIERTO ❓
- **Condición:** Fallback si `conexion < 5`
- **Probabilidad target:** ~15-20%
- **Notas:** No sabés qué viene. Estás vivo. ¿Eso es algo?

#### QUIZÁS 🤷
- **Condición:** Fallback si `conexion >= 5`
- **Probabilidad target:** ~15-20%
- **Notas:** Hay un "quizás" que antes no había. Posibilidad, no esperanza.

#### DESERCIÓN 🚪
- **Condición:** `NOT tiene_laburo AND conexion >= 5 AND inercia <= 4`
- **Probabilidad target:** ~5%
- **Notas:** Abandonaste el circuito laboral. Fuera del sistema, pero vivo.

---

### 🟢 Positivos (4)

Finales con esperanza moderada.

#### RED 🕸️
- **Condición:** `conexion >= 5 AND llama >= 4 AND ayude_en_olla`
- **Probabilidad target:** ~15-20%
- **Notas:** Comunidad como red de sostén. No hay solución mágica, pero no estás solo.

#### VULNERABILIDAD 💔
- **Condición:** `conte_a_alguien AND inercia <= 6`
- **Probabilidad target:** ~10%
- **Notas:** Dejaste de fingir. Mostraste vulnerabilidad genuina. Una grieta por donde entra luz.

#### PEQUEÑO_CAMBIO 🌱
- **Condición:** `conexion >= 4 AND conexion < 7 AND pequenas_victorias >= 5`
- **Probabilidad target:** ~15%
- **Notas:** Algo se movió adentro. No es grande, pero es cambio.

#### RESISTENCIA_SILENCIOSA 🤫
- **Condición:** `NOT participe_asamblea AND veces_que_ayude >= 3 AND conexion >= 4`
- **Probabilidad target:** ~5%
- **Notas:** Ayudaste sin ir a la asamblea. No todas las luchas son visibles.

---

### 🔵 Épicos (4)

Finales de victoria colectiva. Requieren esfuerzo sostenido.

#### LA_LLAMA 🔥
- **Condición:** `conexion >= 7 AND llama >= 6 AND contar_ideas_positivas() >= 3 AND participe_asamblea AND veces_que_ayude >= 2`
- **Probabilidad target:** ~3-5%
- **Notas:** Final oculto. Requiere buena conexión, llama viva, y haber internalizado al menos 3 ideas positivas. "Prendimos fuego."

#### LUCHA_COLECTIVA ✊
- **Condición:** `participe_asamblea AND veces_que_ayude >= 2 AND llama >= 5 AND conexion >= 6`
- **Probabilidad target:** ~5-8%
- **Notas:** Participación activa en la lucha. "La organización es esperanza."

#### HUELGA 🪧
- **Condición:** `participe_asamblea AND veces_que_ayude >= 2 AND llama >= 6 AND conexion >= 6 AND diego_relacion >= 4`
- **Probabilidad target:** ~3-5%
- **Notas:** Huelga salvaje organizada desde abajo. Requiere vínculo con Diego.

#### OCUPACIÓN 🏭
- **Condición:** `participe_asamblea AND conexion >= 6 AND llama >= 6 AND veces_que_ayude >= 2`
- **Probabilidad target:** ~5-8%
- **Notas:** Ocupación de fábrica. El poder no se pide, se construye. Fallback épico si no tienes a Diego para HUELGA.

---

### 🟣 Especiales (4)

Finales temáticos con condiciones únicas.

#### TEJIDO 🧶
- **Condición:** `vinculo == "ixchel" AND ixchel_relacion >= 3 AND ixchel_conto_historia AND ayude_en_olla`
- **Probabilidad target:** ~5%
- **Notas:** Final de Ixchel. El tejido que conecta. Sabiduría ancestral.

#### DESPERTAR 🌅
- **Condición:** `inercia_maxima_alcanzada >= 8 AND inercia <= 4 AND conexion >= 5`
- **Probabilidad target:** ~5%
- **Notas:** Te recuperaste de una espiral. Tocaste fondo y encontraste a otros.

#### JUAN_MIGRANTE ✈️
- **Condición:** `juan_relacion >= 4 AND juan_decidio_irse AND juan_se_despidio`
- **Probabilidad target:** ~5%
- **Notas:** Juan se fue. Algunos se van para que otros se queden.

#### REPRESIÓN 👮
- **Condición:** `participe_asamblea AND conexion >= 5 AND llama >= 5 AND inercia <= 4`
- **Probabilidad target:** ~3%
- **Notas:** Intentaste luchar y te reprimieron. La derrota también enseña.

---

## Diagrama de Prioridad de Evaluación

```
                    ┌─────────────────┐
                    │  evaluar_final  │
                    └────────┬────────┘
                             │
                             ▼
              ┌──────────────────────────────┐
              │     GAME OVER (prioridad 1)  │
              │  inercia >= 10? → APAGADO    │
              │  llama <= 0? → SIN_LLAMA     │
              └──────────────┬───────────────┘
                             │ no
                             ▼
              ┌──────────────────────────────┐
              │   ESPECIALES (prioridad 2)   │
              │  RESISTENCIA_SILENCIOSA      │
              │  DESPERTAR                   │
              │  JUAN_MIGRANTE               │
              │  REPRESIÓN                   │
              └──────────────┬───────────────┘
                             │ no match
                             ▼
              ┌──────────────────────────────┐
              │     ÉPICOS (prioridad 3)     │
              │  HUELGA                      │
              │  OCUPACIÓN                   │
              │  TEJIDO (Ixchel)             │
              │  LA_LLAMA (oculto)           │
              │  LUCHA_COLECTIVA             │
              └──────────────┬───────────────┘
                             │ no match
                             ▼
              ┌──────────────────────────────┐
              │    POSITIVOS (prioridad 4)   │
              │  RED                         │
              │  DESERCIÓN                   │
              │  VULNERABILIDAD              │
              └──────────────┬───────────────┘
                             │ no match
                             ▼
              ┌──────────────────────────────┐
              │   NEGATIVOS (prioridad 5)    │
              │  SOLO                        │
              │  GRIS                        │
              │  PEQUEÑO_CAMBIO              │
              └──────────────┬───────────────┘
                             │ no match
                             ▼
              ┌──────────────────────────────┐
              │   FALLBACK (prioridad 6)     │
              │  conexion >= 5? → QUIZÁS     │
              │  else → INCIERTO             │
              └──────────────────────────────┘
```

---

## Orden Exacto de Evaluación (domingo.ink)

```
 1. APAGADO          (inercia >= 10)
 2. SIN_LLAMA        (llama <= 0)
 3. RESISTENCIA_SILENCIOSA
 4. DESPERTAR
 5. JUAN_MIGRANTE
 6. REPRESIÓN
 7. HUELGA
 8. OCUPACIÓN
 9. TEJIDO
10. LA_LLAMA         (oculto)
11. LUCHA_COLECTIVA
12. RED
13. DESERCIÓN
14. VULNERABILIDAD
15. SOLO
16. GRIS
17. PEQUEÑO_CAMBIO
18. QUIZÁS           (fallback conexion >= 5)
19. INCIERTO         (fallback default)
```

---

## Notas de Diseño

### Mecánicas de Segunda Oportunidad

Antes del game over, el sistema ofrece intervenciones:

1. **Intervención del vínculo** (inercia = 10): Si tu vínculo tiene relación ≥3, te llama y reduce inercia en 3.
2. **Chispa de emergencia** (llama = 0, domingo): Si ayudaste en olla y Sofía relación ≥3, la llama sube a 2.

### Sinergia de Ideas

- `contar_ideas_positivas()`: Cuenta ideas positivas para LA_LLAMA (requiere ≥3)
  - `idea_tengo_tiempo`
  - `idea_pedir_no_debilidad`
  - `idea_hay_cosas_juntos`
  - `idea_red_o_nada`
  - `idea_red_sostiene`
  - `idea_ayni`
  - `idea_no_es_individual`
  - `idea_el_problema_no_soy_yo`

### Balance de Probabilidades Target

| Categoría | % Total |
|-----------|---------|
| Game Over | 10-20% |
| Negativos | 20-30% |
| Neutrales | 35-45% |
| Positivos | 35-50% |
| Épicos | 10-15% |
| Especiales | 15-20% |

*Nota: Los porcentajes se superponen porque dependen de las decisiones del jugador.*

### Recomendaciones para Testing

1. **Probar game overs:** Subir inercia con rechazos + no ayudar en olla
2. **Probar LA_LLAMA:** Requiere playthrough "perfecto" (todas las decisiones positivas)
3. **Probar DESPERTAR:** Dejar que inercia suba a 8+, luego recuperarse con conexión
4. **Probar REPRESIÓN:** Ir a asamblea con buenas stats pero dejar que el conflicto escale

---

## Historial de Cambios

- **2026-02-02 (rev2):** Sincronización doc/código:
  - LA_LLAMA: umbrales reducidos (conexion 7, llama 6, 3 ideas)
  - OCUPACIÓN: umbrales reducidos (conexion 6, llama 6, ayude 2)
  - RED: umbrales reducidos (conexion 5, llama 4)
  - TEJIDO: umbral reducido (ixchel 3)
  - Actualizada lista de ideas positivas
- **2026-02-02:** Documento inicial creado
