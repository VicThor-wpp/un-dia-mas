# Diseño: Sistema de Presentación de Texto Narrativo

**Fecha:** 2026-01-29
**Estado:** Aprobado
**Objetivo:** Mejorar el impacto narrativo mediante animaciones de texto y pausas dramáticas

---

## Resumen Ejecutivo

Tres capas de presentación que trabajan juntas:

1. **Fade-in por párrafo** (siempre activo) - Cada párrafo aparece con transición suave
2. **Pausas dramáticas** (híbrido) - Tags manuales + heurísticas automáticas
3. **Typewriter** (opcional, off by default) - Activable en settings

---

## Especificación Funcional

### 1. Fade-in por Párrafo

- **Timing:** 400-500ms de fade, 300ms de delay entre párrafos
- **Efecto:** Opacity 0→1 + translateY(8px→0)
- **Siempre activo** salvo `prefers-reduced-motion`

### 2. Pausas Dramáticas (Sistema Híbrido)

#### Tags Manuales

| Tag | Efecto |
|-----|--------|
| `# PAUSA` | Fuerza pausa, espera click para continuar |
| `# CONTINUO` | Override, desactiva heurística en ese bloque |

#### Heurísticas Automáticas

| Patrón | Ejemplo | Razón |
|--------|---------|-------|
| Línea ≤ 15 caracteres sola | `"No."` | Momento de impacto |
| Termina en "..." | `Piensa en la chacra...` | Suspense |
| Después de `===` | Cambio de knot | Nueva escena |

#### Indicador Visual

- Símbolo "▼" pulsante cuando espera input
- Animación: opacity 0.6→1→0.6 en ciclo de 1.5s
- Posición: debajo del último párrafo visible

### 3. Typewriter (Opcional)

- **Default:** OFF
- **Activación:** Checkbox en panel de Reading Preferences
- **Velocidad base:** ~30ms por caracter
- **Pausas variables:**
  - Coma (,): +100ms
  - Punto (.): +200ms
  - Puntos suspensivos (...): +400ms
  - Signos de exclamación/interrogación: +150ms

---

## Arquitectura Técnica

### Nuevo Módulo: `text-presenter.js`

```
Ink Output → ChoiceParser → TextPresenter → DOM
```

#### Componentes Internos

1. **ParagraphQueue** - Recibe texto, divide en párrafos, encola para presentación secuencial

2. **TimingController** - Maneja delays entre párrafos, detecta si debe pausar (heurística o tag)

3. **FadeRenderer** - Aplica animación CSS de fade-in a cada párrafo

4. **TypewriterRenderer** - Alternativa al FadeRenderer cuando está habilitado. Escribe letra por letra

5. **PauseIndicator** - Muestra/oculta el "▼" pulsante cuando espera input

### Integración

- Hook en `game.js` donde actualmente se hace `storyContainer.innerHTML`
- Lee tags via `ChoiceParser` (existente)
- Guarda preferencia typewriter en `ReadingPreferences` (existente)

---

## CSS Requerido

```css
/* Fade-in para párrafos */
.paragraph-hidden {
  opacity: 0;
  transform: translateY(8px);
}

.paragraph-visible {
  opacity: 1;
  transform: translateY(0);
  transition: opacity 450ms ease-out, transform 450ms ease-out;
}

/* Indicador de continuar */
.pause-indicator {
  opacity: 0.6;
  animation: pulse 1.5s ease-in-out infinite;
}

@keyframes pulse {
  0%, 100% { opacity: 0.6; }
  50% { opacity: 1; }
}

/* Accesibilidad */
@media (prefers-reduced-motion: reduce) {
  .paragraph-hidden,
  .paragraph-visible {
    transition: none;
    opacity: 1;
    transform: none;
  }
  .pause-indicator {
    animation: none;
    opacity: 1;
  }
}
```

---

## Manejo de Edge Cases

| Caso | Solución |
|------|----------|
| Click rápido múltiple | Debounce 100ms, o skip al final del bloque actual |
| Texto muy largo (>10 párrafos) | Mostrar máximo 5, pausar, continuar con resto |
| Typewriter activado mid-text | Aplica solo al próximo bloque |
| Navegación atrás (historial) | Texto ya visto aparece instantáneo |
| `prefers-reduced-motion` | Desactivar animaciones, mostrar todo directo |
| Mobile tap vs click | Usar `pointerdown` para unificar |

**Fallback:** Si TextPresenter falla, texto aparece instantáneo (comportamiento actual).

---

## Configuración de Usuario

Agregar a `ReadingPreferences`:

```
☐ Efecto máquina de escribir
```

Un checkbox simple. La preferencia se persiste en localStorage.

---

## Plan de Testing

### Pruebas Manuales

1. **Flujo básico** - Párrafos aparecen con fade secuencial
2. **Pausas automáticas** - Líneas cortas pausan (ej: `tiago_se_abre`)
3. **Tag manual** - `# PAUSA` funciona correctamente
4. **Typewriter** - Letra por letra con pausas en puntuación
5. **Click rápido** - No rompe ni skipea contenido
6. **Reduced motion** - Animaciones desactivadas
7. **Mobile** - Tap funciona igual que click

### Escenas de Testing Recomendadas

- `tiago_se_abre` - Líneas cortas dramáticas
- `cacho_momento_real` - Revelación importante
- `miercoles_despido` - Momento de alto impacto

---

## Archivos a Modificar/Crear

| Archivo | Acción |
|---------|--------|
| `modules/text-presenter.js` | CREAR - Módulo principal |
| `game.js` | MODIFICAR - Integrar TextPresenter |
| `style.css` | MODIFICAR - Agregar animaciones |
| `modules/reading-preferences.js` | MODIFICAR - Agregar checkbox typewriter |
| `index.html` | MODIFICAR - Incluir nuevo módulo |

---

## Decisiones de Diseño

1. **Vanilla JS/CSS** - Consistente con arquitectura existente, sin dependencias
2. **Typewriter off by default** - Feature secundario, no esencial
3. **Híbrido para pausas** - Balance entre control autoral y conveniencia
4. **Timing moderado** - 400-500ms es el sweet spot para este tono narrativo
5. **Un solo checkbox en settings** - Simplicidad sobre configurabilidad
