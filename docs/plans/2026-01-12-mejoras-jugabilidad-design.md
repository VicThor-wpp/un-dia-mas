# Diseño: 10 Features para Mejorar Un Día Más

**Fecha:** 2026-01-12
**Estado:** Aprobado para implementación

## Contexto

El jugador reporta:
- Sensación de "jugar a ciegas" sin saber consecuencias
- Texto acumulado sin respiro
- Botón continuar poco visible/animado
- Falta de feedback visual

## Las 10 Features

### 1. Indicadores de Consecuencias Vagos

**Problema:** El jugador elige a ciegas sin saber qué stats se verán afectados.

**Solución:** Agregar badges de consecuencias vagos en las opciones.

**Formato:**
```
🤝↑    - Probablemente sube conexión
✊↓?   - Podría bajar dignidad (incertidumbre)
🔥↑↓   - La llama está en juego
```

**Implementación en Ink:**
```ink
* [Ayudar a Sofia] # COSTO:1 # EFECTO:conexion+
* [Ignorarla] # EFECTO:conexion- # EFECTO:dignidad?
```

---

### 2. Expansión del Sistema de Dados

**Problema:** Los dados son escasos. El azar debe reforzar la precariedad.

**Solución:** Agregar tiradas en:
- Encuentros casuales (barrio, bondi)
- Conversaciones profundas
- Acciones prácticas

**Frecuencia objetivo:** 2-3 tiradas por día de juego.

**IMPORTANTE:** Actualmente `chequeo()` está definido pero nunca se usa. Hay que implementarlo en las opciones con `# DADOS`.

---

### 3. Técnicas de Ritmo Combinadas

**A. Interacciones falsas para monólogos:**
```ink
=== sofia_historia ===
"No soy fuerte. Estoy cansada."

* [Asentir en silencio] # FALSA
-
"Pero no tengo opción."
```

**B. Animación gradual para descripciones:**
```css
.story-text {
    animation: fadeIn 0.4s ease-in;
}
```

**C. Separadores visuales:**
```ink
# SEPARADOR:tiempo   // ── ◷ ──
# SEPARADOR:lugar    // ── ◈ ──
```

**D. Pausas frecuentes en crisis:**
```ink
# RITMO:tenso   // MAX_PARAGRAPHS = 2
```

---

### 4. Botón Continuar Animado + Favicon

**Botón actual:** `...` estático, sin animación.

**Solución:**
```css
.continue-button::before {
    content: '...';
    animation: pulse-dots 1.5s ease-in-out infinite;
}

@keyframes pulse-dots {
    0%, 100% { opacity: 0.4; letter-spacing: 8px; }
    50% { opacity: 1; letter-spacing: 12px; }
}
```

**Variantes contextuales:**
| Contexto | Símbolo | Tag |
|----------|---------|-----|
| Normal | `...` | default |
| Espera | `⏳` | `# CONTINUAR:espera` |
| Tensión | `›››` | `# CONTINUAR:tension` |

**Favicon:**
```html
<link rel="icon" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 32 32'><text y='24' font-size='24'>🔥</text></svg>">
```

---

### 5. Micro-decisiones Frecuentes

**Objetivo:** Máximo 20 líneas sin input del jugador.

```ink
=== bondi_viaje ===
El bondi arranca. Hay asiento adelante y atrás.

* [Sentarte adelante]
    Ves la ciudad por el parabrisas.
* [Sentarte atrás]
    Mirás a la gente subir y bajar.
-
El viaje dura quince minutos.
```

---

### 6. Encuentros Aleatorios Pasivos

El mundo se siente vivo cuando pasan cosas sin decisión:

```ink
=== caminata_barrio ===
~ temp encuentro = d6()
{encuentro:
    - 1: Un perro te sigue media cuadra.
    - 2: Escuchás cumbia desde una ventana.
    - 3: Un pibe pasa en bici, te saluda.
    - 4: Olor a torta frita.
    - 5: Una vecina riega las plantas.
    - 6: Todo tranquilo.
}
```

---

### 7. Sistema de Tags Unificado

```ink
// Consecuencias (nuevo)
# EFECTO:conexion+
# EFECTO:dignidad-
# EFECTO:llama?

// Costos (existente)
# COSTO:1

// Dados (existente)
# DADOS
# DADOS:conexion

// Ritmo (nuevo)
# RITMO:tenso
# RITMO:calmo

// Continuar (nuevo)
# CONTINUAR:espera
# CONTINUAR:tension

// Separadores (nuevo)
# SEPARADOR:tiempo
# SEPARADOR:lugar

// Interacción falsa (nuevo)
# FALSA
```

---

### 8. Preview en Hover (Tooltips)

```css
.choice-button:hover .choice-tooltip {
    opacity: 1;
}
```

```ink
* [Confrontar al jefe] # TOOLTIP:Arriesgado pero honesto
```

---

### 9. Historial de Cambios

Log visual accesible con botón `[?]`:
```
┌─ Últimos cambios ─┐
│ 🤝 +1 (Sofia)     │
│ ⚡ -1 (Ayudar)    │
│ 🎲 4 - Éxito      │
└───────────────────┘
```

---

### 10. Validación de Contenido Completo

**Regla:** Toda opción debe tener contenido. Ninguna decisión incompleta.

---

## Issues Detectados en Código Actual

| Issue | Archivo | Descripción |
|-------|---------|-------------|
| `chequeo()` no se usa | `dados.ink` | Función definida pero nunca llamada |
| `ultimo_resultado` siempre 0 | `game.js:91` | Muestra "Fallo" para todo |
| Botón sin animación | `style.css:222` | Solo estilos estáticos |
| No hay favicon | `index.html` | Falta link rel="icon" |
| Variable `la_llama` vs `llama` | varios | Inconsistencia de nombre |

---

## Prioridad de Implementación

1. **Crítico:** Arreglar sistema de dados (que funcione `chequeo()`)
2. **Crítico:** Favicon y nombre correcto (Un Día Más, `llama`)
3. **Alto:** Botón continuar animado
4. **Alto:** Indicadores de consecuencias
5. **Medio:** Animaciones de texto
6. **Medio:** Micro-decisiones e interacciones falsas
7. **Bajo:** Tooltips y historial
