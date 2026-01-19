# Plan de Implementación: UI con Atrament

**Fecha:** 2026-01-11
**Proyecto:** Un Día Más
**Objetivo:** Implementar UI de testing con Atrament Web UI

---

## Fases de Implementación

```
FASE 1          FASE 2          FASE 3          FASE 4
Base            Visual          Multimedia      Polish
funcional       pulido          (img+sound)     final
    │               │               │               │
    ▼               ▼               ▼               ▼
[Ink+Debug]  →  [Theme+CSS]  →  [Assets]    →  [Animaciones]
```

---

## FASE 1: Base Funcional

### Objetivo
Tener el juego corriendo en Atrament con debugger habilitado.

### Tareas

#### 1.1 Setup del proyecto Atrament
```bash
# Crear proyecto
npx atrament-wizard create un-dia-mas
cd un-dia-mas
npm install
npm run install-inklecate
```

#### 1.2 Configurar atrament.config.json
```json
{
  "name": "Un Día Más",
  "short_name": "UnDiaMas",
  "description": "Juego narrativo sobre precariedad laboral y solidaridad barrial",
  "theme": "dark",
  "font": "Lora",
  "game": {
    "path": "game",
    "source": "main.ink"
  }
}
```

#### 1.3 Migrar archivos Ink
- [ ] Copiar `prototype/ink/*` a `root/game/`
- [ ] Verificar compilación: `npm start`
- [ ] Resolver errores de compilación si los hay

#### 1.4 Habilitar debugger
Agregar a `main.ink`:
```ink
# title: Un Día Más
# author: [Tu nombre]
# debug
# font: Lora
# theme: dark
# autosave: true
# observe: dia_actual
# observe: energia
# observe: conexion
# observe: la_llama
# observe: dignidad
# observe: tiene_laburo
# observe: vinculo
```

#### 1.5 Verificar funcionamiento
- [ ] El juego carga correctamente
- [ ] El debugger muestra las variables
- [ ] Se puede navegar por la historia
- [ ] Autosave funciona

### Entregable
Juego jugable en `localhost:8900` con debugger funcional.

---

## FASE 2: Pulido Visual

### Objetivo
Aplicar el sistema de diseño y customizar la apariencia.

### Tareas

#### 2.1 Crear theme custom
Crear `resources/themes/barrio.json`:
```json
{
  "name": "barrio",
  "theme": {
    "bg-color": "#1a1a1f",
    "fg-color": "#d4a574",
    "shade-color": "rgba(0, 0, 0, 0.3)",
    "font-color": "#e8e6e3",
    "accent-bg-color": "#252530",
    "accent-fg-color": "#7eb8a2",
    "accent-inverse-color": "#1a1a1f",
    "border-radius": "0.5rem",
    "border-radius-inline": "0.25rem"
  }
}
```

#### 2.2 Agregar CSS custom
Crear/editar `resources/styles/custom.css`:
```css
/* Variables adicionales */
:root {
  --color-energy: #d4a574;
  --color-connection: #7eb8a2;
  --color-dignity: #a08bd4;
  --color-alert: #c75d5d;

  --color-sofia: #e89b7b;
  --color-elena: #98b89e;
  --color-diego: #d4a574;
  --color-marcos: #7ba3c7;
  --color-renzo: #8b7b7b;
}

/* Estilos de personajes para diálogos */
.speaker-sofia { color: var(--color-sofia); }
.speaker-elena { color: var(--color-elena); }
.speaker-diego { color: var(--color-diego); }
.speaker-marcos { color: var(--color-marcos); }
.speaker-renzo { color: var(--color-renzo); }

/* Barras de progreso custom */
.progress-energy .progress-fill { background: var(--color-energy); }
.progress-connection .progress-fill { background: var(--color-connection); }
.progress-dignity .progress-fill { background: var(--color-dignity); }

/* Choices con costo */
.choice-cost {
  color: var(--color-alert);
  font-size: 0.85em;
  margin-left: auto;
}
```

#### 2.3 Implementar toolbar con stats
Agregar a `main.ink`:
```ink
# toolbar: game_toolbar

=== function game_toolbar()
  📅 {dia_nombre(dia_actual)}
  [progress value={energia} max=5 class=progress-energy]⚡[/progress]
  [progress value={conexion} max=10 class=progress-connection]🤝[/progress]
  [button onclick=show_stats]👤[/button]

=== function dia_nombre(dia)
  {dia:
    - 1: LUNES
    - 2: MARTES
    - 3: MIÉRCOLES
    - 4: JUEVES
    - 5: VIERNES
    - 6: SÁBADO
    - 7: DOMINGO
  }

=== function show_stats()
  [title]Tu Situación[/title]
  💼 {tiene_laburo: Empleado | [highlight color=var(--color-alert)]Sin trabajo[/highlight]}

  [table border=false]<>
  [row]⚡ Energía[ ][progress value={energia} max=5][/progress][ ]{energia}/5[/row]<>
  [row]🤝 Conexión[ ][progress value={conexion} max=10][/progress][ ]{conexion}/10[/row]<>
  [row]✊ Dignidad[ ][progress value={dignidad} max=10][/progress][ ]{dignidad}/10[/row]<>
  [row]🔥 Esperanza[ ][progress value={la_llama} max=10][/progress][ ]{la_llama}/10[/row]<>
  [/table]

  💜 Vínculo: {vinculo}
```

#### 2.4 Agregar banners de cambio de día
En cada archivo de día (ej: `dias/miercoles.ink`):
```ink
=== miercoles_inicio ===
# CLEAR
[banner style=accent allcaps=true]Miércoles[/banner]
[info font=system]Día 3 de 7[/info]

// resto del contenido...
```

#### 2.5 Agregar info boxes para eventos
```ink
// Ejemplo: después del despido
[info side=highlight]💼 Estado: Sin trabajo. La indemnización cubre dos meses.[/info]

// Ejemplo: subir conexión
[info side=accent]🤝 Conexión +1[/info]
```

### Entregable
UI con theme custom, toolbar funcional, y elementos visuales integrados.

---

## FASE 3: Multimedia

### Objetivo
Agregar imágenes y sonido para mayor inmersión.

### Tareas

#### 3.1 Estructura de assets
```
root/game/
├── images/
│   ├── backgrounds/
│   │   ├── casa.jpg
│   │   ├── laburo.jpg
│   │   ├── barrio.jpg
│   │   └── olla.jpg
│   └── portraits/
│       ├── sofia.png
│       ├── elena.png
│       ├── diego.png
│       ├── marcos.png
│       └── renzo.png
└── sounds/
    ├── ambient/
    │   ├── casa_manana.mp3
    │   ├── fabrica.mp3
    │   ├── barrio.mp3
    │   └── olla.mp3
    └── sfx/
        ├── dado.mp3
        ├── exito.mp3
        └── fallo.mp3
```

#### 3.2 Implementar backgrounds por ubicación
```ink
=== casa_despertar ===
# BACKGROUND: images/backgrounds/casa.jpg
# PLAY_MUSIC: sounds/ambient/casa_manana.mp3

Te despertás con el ruido del bondi...
```

#### 3.3 Implementar portraits en diálogos
```ink
=== hablar_con_sofia ===
# BACKGROUND: images/backgrounds/barrio.jpg

[block width=15%][picture]images/portraits/sofia.png[/picture][/block][block width=85%]<>
[css class=speaker-sofia]**Sofía**[/css]<>
"¿Viste lo del viernes? Estamos armando una olla en lo de Elena."<>
[/block]
```

#### 3.4 Agregar efectos de sonido
```ink
// En el sistema de dados
=== function mostrar_resultado_dado(resultado)
  {resultado >= 1:
    # PLAY_SOUND: sounds/sfx/exito.mp3
    [info side=accent]✓ Éxito[/info]
  - else:
    # PLAY_SOUND: sounds/sfx/fallo.mp3
    [info side=highlight]✗ Fallo[/info]
  }
```

### Entregable
Juego con backgrounds, portraits, y sonido ambiente.

---

## FASE 4: Polish Final

### Objetivo
Animaciones, transiciones, y detalles finales.

### Tareas

#### 4.1 Animación de dados (CSS)
Agregar a `custom.css`:
```css
@keyframes dice-roll {
  0%, 100% { transform: rotate(0deg); }
  25% { transform: rotate(15deg); }
  75% { transform: rotate(-15deg); }
}

.dice-rolling {
  animation: dice-roll 0.3s ease-in-out 3;
}

.dice-result {
  animation: fadeIn 0.5s ease-out;
}

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(-10px); }
  to { opacity: 1; transform: translateY(0); }
}
```

#### 4.2 Transiciones entre días
```ink
// Usar click-to-continue con delay
=== fin_de_dia ===
# STOP_MUSIC
[banner]Fin del día[/banner]
El sol se pone sobre el barrio...
+ [>>>(animation=2 continue=4)] -> siguiente_dia
```

#### 4.3 Efectos visuales para eventos críticos
```ink
=== despido ===
# CLEAR
# STOP_MUSIC
# PAGE_BACKGROUND: images/backgrounds/laburo_oscuro.jpg
# PLAY_SOUND: sounds/sfx/tension.mp3

[banner style=accent allcaps=true]Te despidieron[/banner]

// Pausa dramática
+ [>>>3]
-
Juan te llama a la oficina...
```

#### 4.4 Pulir costos en choices
```ink
+ {energia >= 2} Pasar por el taller de Sofía [css class=choice-cost]⚡-1[/css]
    ~ energia = energia - 1
    -> taller_sofia
+ {energia < 2} Pasar por el taller de Sofía #DISABLED
    [css class=choice-cost]Sin energía[/css]
```

### Entregable
Juego pulido listo para testing externo.

---

## Checklist General

### Fase 1
- [ ] Proyecto Atrament creado
- [ ] Archivos Ink migrados
- [ ] Debugger funcionando
- [ ] Autosave funcionando

### Fase 2
- [ ] Theme "barrio" aplicado
- [ ] CSS custom con colores de personajes
- [ ] Toolbar con stats en tiempo real
- [ ] Banners de cambio de día
- [ ] Info boxes para eventos

### Fase 3
- [ ] Backgrounds por ubicación
- [ ] Portraits de personajes
- [ ] Música ambiente
- [ ] Efectos de sonido

### Fase 4
- [ ] Animación de dados
- [ ] Transiciones entre días
- [ ] Efectos para eventos críticos
- [ ] Build de producción

---

## Comandos Útiles

```bash
# Desarrollo
npm start                    # Servidor dev en localhost:8900

# Builds
npm run build-web           # PWA para servidor web
npm run build-singlefile    # HTML único
npm run build-standalone    # Ejecutables desktop

# Preview build
npm run preview             # Probar build en localhost:4173
```

---

## Notas

- Mantener el debugger habilitado (`# debug`) durante todo el desarrollo
- Probar en mobile periódicamente (Atrament es responsive)
- Hacer commits frecuentes en cada sub-tarea completada
- Documentar cualquier workaround o decisión técnica nueva
