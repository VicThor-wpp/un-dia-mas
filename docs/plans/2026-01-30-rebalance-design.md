# Un Día Más - Rediseño Integral

**Fecha**: 2026-01-30
**Enfoque**: Híbrido (redes de seguridad + ajustes moderados)
**Objetivo**: Mejorar balance, profundizar mecánicas, corregir narrativa sin trivializar el juego

---

## 1. Sistema de Notificaciones (UI)

### Problema
- Desktop: `position: fixed; top: 80px` queda fuera de vista al scrollear
- Mobile: `bottom: 20px` sin límites, se salen del viewport con múltiples notificaciones
- Sin atributos ARIA

### Solución

**CSS (`css/notifications.css`):**
```css
.notifications {
    position: fixed;
    bottom: 20px;
    right: 20px;
    max-height: 60vh;
    overflow-y: auto;
    display: flex;
    flex-direction: column-reverse;
    gap: 8px;
    z-index: 1000;
}

@media (max-width: 768px) {
    .notifications {
        bottom: calc(20px + env(safe-area-inset-bottom));
        left: 10px;
        right: 10px;
    }
}
```

**JavaScript (`modules/notification-system.js`):**
```javascript
// Agregar atributos ARIA
container.setAttribute('role', 'log');
container.setAttribute('aria-live', 'polite');
container.setAttribute('aria-label', 'Notificaciones del juego');

// Límite de 3 notificaciones visibles
const MAX_NOTIFICATIONS = 3;
if (container.children.length >= MAX_NOTIFICATIONS) {
    container.removeChild(container.firstChild);
}
```

---

## 2. Sistema de Ideas (Mecánicas)

### Problema
- 10 ideas existen pero solo `final_la_llama` las requiere
- Ideas involuntarias nunca se activan automáticamente
- Sinergias no hacen nada mecánicamente

### Solución

**Ideas con efectos mecánicos (`mecanicas/ideas.ink`):**

| Idea | Tipo | Efecto Mecánico |
|------|------|-----------------|
| `idea_pedir_no_debilidad` | Positiva | +1 a chequeos sociales al pedir ayuda |
| `idea_hay_cosas_juntos` | Positiva | Ayudar en olla recupera +1 energía extra |
| `idea_red_o_nada` | Positiva | -1 inercia al final del día si conexión >= 5 |
| `idea_tengo_tiempo` | Positiva | +1 energía al inicio de cada día |
| `idea_no_es_individual` | Positiva | Llama no puede bajar más de 1 por día |
| `idea_ayni` | Positiva (Ixchel) | Ayudar a otros recupera 1 energía |
| `idea_quien_soy` | Involuntaria | +1 inercia en noches solitarias |
| `idea_esto_es_lo_que_hay` | Involuntaria | -1 a chequeos mentales |

**Activación automática de ideas involuntarias:**
```ink
=== function evaluar_ideas_involuntarias ===
{ inercia >= 6 && not idea_quien_soy:
    ~ idea_quien_soy = true
    ~ NotificationSystem.show("Una idea se instala: ¿Quién soy sin laburo?", "negative")
}

{ conexion <= 2 && dignidad <= 3 && not idea_esto_es_lo_que_hay:
    ~ idea_esto_es_lo_que_hay = true
    ~ NotificationSystem.show("Una idea se instala: Esto es lo que hay...", "negative")
}
```

**Sinergias con efectos reales:**
```ink
=== function evaluar_sinergias ===
// Sinergia Colectiva (3 ideas sociales)
{ idea_pedir_no_debilidad && idea_hay_cosas_juntos && idea_red_o_nada:
    ~ sinergia_colectiva = true
    // Ventaja automática en chequeos comunitarios
}

// Sinergia de Agencia
{ idea_tengo_tiempo && idea_no_es_individual:
    ~ sinergia_agencia = true
    // Inercia game-over sube de 10 a 12
}
```

**Contrarresto:**
- `idea_pedir_no_debilidad` anula efecto negativo de `idea_quien_soy`
- `idea_no_es_individual` anula efecto negativo de `idea_esto_es_lo_que_hay`

---

## 3. Rebalanceo de Recursos

### 3.1 Energía

| Aspecto | Actual | Propuesto |
|---------|--------|-----------|
| Inicio de partida | 4/5 | 5/5 |
| Recuperación diaria | Fija (4) | Variable: 4 base + bonus |
| Quedarse en cama | Cuesta 1 energía | Gratis, pero +1 inercia |

```ink
=== function recuperar_energia_diaria ===
~ energia = 4
{ conexion >= 5: ~ energia += 1 }
{ idea_tengo_tiempo: ~ energia += 1 }
{ inercia >= 7: ~ energia -= 1 }
~ energia = MIN(energia, 5)
```

### 3.2 Inercia

| Aspecto | Actual | Propuesto |
|---------|--------|-----------|
| Game over | >= 10 | >= 10 (o >= 12 con sinergia_agencia) |
| Recuperación | Casi ninguna | Acciones específicas la bajan |

**Acciones que bajan inercia:**
```ink
=== function reducir_inercia(cantidad) ===
~ inercia = MAX(0, inercia - cantidad)

// Triggers:
// - Conversación honesta con vínculo: -1
// - Ayudar en olla (primera vez del día): -1
// - Desbloquear idea positiva: -1
// - Noche con fragmento positivo: -1
// - idea_red_o_nada + conexion >= 5: -1 automático/día
```

**Freno de emergencia (domingo):**
```ink
{ inercia >= 10 && vinculo_relacion >= 3:
    -> intervencion_vinculo ->
    // Reduce inercia a 7, continúa
}
```

### 3.3 La Llama

| Aspecto | Actual | Propuesto |
|---------|--------|-----------|
| Game over | <= 0 | <= 0, con piso temporal |
| Piso | Ninguno | No baja de 2 hasta sábado |

```ink
=== function bajar_llama(cantidad) ===
~ temp nueva = llama - cantidad
{ dia_actual < 6 && nueva < 2:
    ~ llama = 2
- else:
    ~ llama = MAX(0, nueva)
}
```

**Más formas de subirla:**
- Participar en conversación grupal: +1
- Marcos viene a asamblea: +2
- Defender a alguien: +1
- Éxito crítico en chequeo comunitario: +1

### 3.4 Dignidad

**Darle peso mecánico:**
```ink
=== function evaluar_dignidad_nocturna ===
{ dignidad <= 2 && not idea_pedir_no_debilidad:
    ~ aumentar_inercia(1)
}
{ dignidad >= 8:
    ~ reducir_inercia(1)
}

// Afecta versión de fragmentos nocturnos
{ dignidad >= 7: -> fragmento_version_esperanzada }
{ dignidad <= 3: -> fragmento_version_oscura }
```

---

## 4. Accesibilidad de Finales

### Ajuste de Umbrales

| Final | Requisitos Actuales | Requisitos Propuestos |
|-------|---------------------|----------------------|
| `final_la_llama` | conexión>=9, llama>=8, 4 ideas | conexión>=7, llama>=6, 3 ideas |
| `final_ocupacion` | conexión>=7, llama>=7, ayudas>=3 | conexión>=6, llama>=6, ayudas>=2 |
| `final_huelga` | 5 condiciones + diego>=4 | 4 condiciones + diego>=3 |
| `final_lucha_colectiva` | conexión>=7, llama>=7 | conexión>=6, llama>=5 |
| `final_red` | conexión>=7, llama>=5 | conexión>=5, llama>=4 |
| `final_tejido` | 4 condiciones Ixchel | 3 condiciones + ixchel>=3 |

### Finales Nuevos

**`final_resistencia_silenciosa`:**
```ink
{ not participe_asamblea && veces_que_ayude >= 3 && conexion >= 4:
    -> final_resistencia_silenciosa
    // "No todas las luchas son visibles"
}
```

**`final_despertar`:**
```ink
{ inercia_maxima_alcanzada >= 8 && inercia <= 4 && conexion >= 5:
    -> final_despertar
    // "Tocaste fondo y encontraste a otros ahí"
}
```

**`final_juan_migrante`:**
```ink
{ juan_relacion >= 4 && juan_decidio_irse && juan_se_despidio:
    -> final_juan_migrante
    // "Algunos se van para que otros puedan quedarse"
}
```

### Game-Overs con Segunda Oportunidad

**`final_apagado`:**
```ink
{ inercia >= 10 && vinculo_relacion >= 3:
    -> intervencion_vinculo_apagado ->
    // Reduce a 7, continúa
}
```

**`final_sin_llama`:**
```ink
{ llama <= 0 && dia_actual == 7 && ayude_en_olla && sofia_relacion >= 3:
    ~ llama = 2
    -> chispa_emergencia ->
}
```

### Distribución Esperada

| Dificultad | % Antes | % Después |
|------------|---------|-----------|
| Fácil (solo, gris, incierto) | 50-60% | 30-40% |
| Moderado | 25-30% | 35-40% |
| Difícil | 15-20% | 20-25% |
| Muy difícil | 5-10% | 10-15% |
| Épico | <2% | 5-8% |
| Game over | 5-15% | 2-5% |

---

## 5. NPCs Incompletos

### 5.1 Ixchel - Arco "Ayni"

**Nueva idea:** `idea_ayni` — "La reciprocidad es supervivencia"
**Efecto:** Ayudar a otros recupera 1 energía

| Día | Escena |
|-----|--------|
| Miércoles | Ofrece mate silencioso en olla |
| Jueves | Cuenta fragmento de migración |
| Viernes | Enseña concepto de Ayni |
| Sábado | Propone red de trueque en asamblea |
| Domingo | Ofrece lugar en su red |

### 5.2 Juan - Arco "El que se va"

**Variables (limpiar DEPRECADA):**
```ink
VAR juan_relacion = 2
VAR juan_decidio_irse = false
VAR juan_se_despidio = false
VAR juan_mando_apoyo = false  // +1 llama en sábado
```

| Día | Escena |
|-----|--------|
| Lunes | Almuerzo (existente) |
| Martes | "Estoy viendo opciones" |
| Miércoles | Ausente |
| Jueves | Mensaje: oferta en España |
| Viernes | Llamada de despedida opcional |
| Sábado | No viene, manda mensaje apoyo |

### 5.3 Marcos - Simplificación

**Eliminar `marcos_estado`.** Solo:
```ink
VAR marcos_relacion = 2
VAR marcos_revelo_despido = false
VAR marcos_vino_asamblea = false
```

| Día | Escena |
|-----|--------|
| Miércoles | Escritorio vacío |
| Jueves | Lo ves de lejos en olla, se va |
| Viernes | Encuentro en plaza, revela despido |
| Sábado | Llamada para invitar a asamblea |

---

## 6. Pacing y Estructura Narrativa

### Principios

1. **Una escena nocturna por noche** — la del vínculo o la más relevante
2. **Máximo un NPC nuevo por día** — el resto son profundizaciones
3. **Máximo 2 decisiones importantes por día**
4. **~400 líneas máximo por día** (excepto sábado: 500)

### Reestructuración por Día

| Día | Foco Principal | Líneas |
|-----|----------------|--------|
| Lunes | Normalidad amenazada | ~300 |
| Martes | Tensión + reunión de reestructuración | ~350 |
| Miércoles | Despido + UNA reacción principal | ~450 |
| Jueves | Primer día sin laburo + descubrir olla | ~400 |
| Viernes | Claudia audita + consecuencias | ~350 |
| Sábado | **Asamblea (clímax expandido)** | ~500 |
| Domingo | Reflexión + evaluación final | ~300 |

### Correcciones Específicas

**Lunes → Martes (conectar):**
```ink
=== martes_laburo_manana ===
El mail de anoche sigue en tu cabeza.
"Reunión de reestructuración. Obligatoria."
La reunión es a las 11. Faltan tres horas.
```

**Miércoles (reducir):**
- Fragmentos nocturnos: -30% texto
- Solo UN fragmento (el del vínculo)
- Limitar llamadas opcionales a 2

**Viernes (simplificar):**
- Claudia + olla: mantener
- Crisis Tiago: mover a sábado mañana
- Búsqueda laburo: segundo plano

**Sábado (expandir asamblea):**
```ink
=== sabado_asamblea ===
// 200+ líneas propias
// Decisiones dentro:
//   - ¿Hablás o callás?
//   - ¿Apoyás propuesta de Sofia?
//   - ¿Mencionás a los ausentes?
```

**`conte_a_alguien` (arreglar discontinuidad):**
```ink
{ conte_a_alguien && vinculo != persona_a_quien_conte:
    ~ vinculo_sabe_indirecto = true
}

// jueves_manana
{ vinculo_sabe_indirecto:
    Mensaje de {vinculo}: "Me contó Elena. ¿Por qué no me llamaste?"
}
```

---

## 7. Resumen de Archivos a Modificar

### Ink (prototype/ink/)
- `variables.ink` — limpiar deprecadas, agregar nuevas
- `mecanicas/ideas.ink` — efectos mecánicos
- `mecanicas/recursos.ink` — recuperación, pisos, reducciones
- `mecanicas/dados.ink` — sinergias afectan ventaja/desventaja
- `dias/martes.ink` — conectar con lunes
- `dias/miercoles.ink` — reducir, un fragmento
- `dias/viernes.ink` — simplificar
- `dias/sabado.ink` — expandir asamblea
- `dias/domingo.ink` — nuevos finales, umbrales
- `personajes/ixchel.ink` — arco completo
- `personajes/juan.ink` — arco migración
- `personajes/marcos.ink` — simplificar
- `finales/finales.ink` — nuevos finales, umbrales

### Web (prototype/web/)
- `css/notifications.css` — posicionamiento
- `css/responsive.css` — mobile safe-area
- `modules/notification-system.js` — ARIA, límite 3

---

## 8. Orden de Implementación Sugerido

1. **UI: Notificaciones** — fix rápido, impacto inmediato
2. **Recursos: Redes de seguridad** — inercia/llama recuperables
3. **Ideas: Efectos mecánicos** — profundidad sin complejidad
4. **Finales: Umbrales y nuevos** — accesibilidad
5. **NPCs: Ixchel, Juan, Marcos** — completar arcos
6. **Pacing: Redistribución** — martes, miércoles, sábado
7. **Testing: Verificar balance** — playthrough completo

---

*Documento generado durante sesión de brainstorming 2026-01-30*
