# Un Día Más - Prototipo Narrativo

Un juego narrativo sobre pertenecer cuando todo se reorganiza.

## Sinopsis

Sos un trabajador de treinta y algo en un barrio de Montevideo. El miércoles te despiden. Los tres meses de indemnización son tu único colchón. Esta semana vas a descubrir si tenés una red que te sostenga o si estás solo.

## Temas

- La precariedad laboral y sus efectos en la identidad
- Las redes de solidaridad barrial (la olla popular)
- La tensión entre individualismo y comunidad
- El duelo por futuros que no fueron

## Estructura del Juego

### Arco Temporal
- **Lunes-Martes**: Vida normal, rumores en el trabajo
- **Miércoles**: El despido (punto de quiebre)
- **Jueves-Viernes**: Primer contacto con la olla, crisis comunitaria
- **Sábado**: La asamblea (clímax colectivo)
- **Domingo**: Reflexión y cierre

### Sistema de Recursos

| Recurso | Descripción | Rango | Inicio |
|---------|-------------|-------|--------|
| **Energía** | Capacidad de hacer cosas hoy | 0-6 | 5 |
| **Conexión** | Tu lugar en el tejido del barrio | 0-10 | 3 |
| **Dignidad** | Lo que el sistema te saca de a poco | 0-10 | 5 |
| **La Llama** | Esperanza colectiva | 0-10 | 5 |
| **Inercia** | Resistencia al cambio. 10 = parálisis total | 0-10 | 5 |

La **inercia** es la mecánica central: sube cuando te encerrás y baja cuando
hacés algo con otros. Si llega a 10 el juego termina en el final APAGADO.

Los valores canónicos viven en [`ink/variables.ink`](ink/variables.ink).

### Sistema de Dados

- **d6 básico**: Tirada simple
- **Chequeo**: d6 + modificador vs dificultad
  - 6 natural = éxito crítico
  - 1 natural = fallo crítico
- **Ventaja/Desventaja**: Tira 2d6, usa mejor/peor

## Personajes

### Protagonista
Definido por tres elecciones iniciales:
- **Pérdida**: familiar, relación, futuro, vacío
- **Atadura**: responsabilidad, barrio, inercia, algo
- **Posición política**: ajeno, quemado, esperanzado, ambiguo

### NPCs Principales

| Personaje | Rol | Arco |
|-----------|-----|------|
| **Juan** | Compañero de trabajo | Termina migrando |
| **Sofía** | Líder de la olla | Madre soltera, sostiene todo |
| **Elena** | Veterana del barrio | Memoria del 2002 y de la dictadura |
| **Diego** | Venezolano nuevo | Buscando pertenecer |
| **Marcos** | El que se alejó | Ex-militante quemado |
| **Ixchel** | Migrante maya-k'iche' | Resistencia territorial y desplazamiento |
| **Lucía** | La sindicalista | El paro y la organización |
| **Tiago** | El pibe | Disputado entre la olla y Bruno |
| **Cacho** | El heredero | Salvación individual, cripto |
| **Bruno** | El "Apóstol" | Control autoritario desde afuera |
| **Claudia** | La inspectora | Control burocrático desde adentro |

Cada NPC tiene un perfil detallado en
[`docs/design/characters/`](../docs/design/characters/).

### Vínculo
Al inicio elegís una cara del barrio y eso fija tu "vínculo": la persona con
la que ya tenés historia. Las opciones son **Sofía, Elena, Diego, Marcos e
Ixchel**. El vínculo cambia escenas propias en varios días y puede intervenir
como segunda oportunidad si la inercia llega al tope.

## Finales

El juego tiene **19 finales**, agrupados en 6 categorías (game over, negativos,
neutros, positivos, radicales y especiales). Se evalúan por prioridad al cerrar
el domingo y gana el primero que cumpla sus condiciones.

Las condiciones exactas de cada uno están documentadas en
[`docs/design/finales.md`](../docs/design/finales.md); el texto vive en
[`ink/finales/finales.ink`](ink/finales/finales.ink).

## Estructura Técnica

```
ink/
├── main.ink                 # Entry point + creación personaje
├── variables.ink            # Variables globales centralizadas
├── mecanicas/
│   ├── dados.ink           # Sistema de tiradas
│   ├── recursos.ink        # Gestión de recursos y game over
│   ├── ideas.ink           # Contenido de las ideas internalizables
│   ├── sistema_ideas.ink   # Lógica de desbloqueo de ideas
│   ├── ambiente.ink        # Clima, radio y atmósfera diaria
│   ├── voces.ink           # Voces internas
│   └── ux.ink              # Helpers de presentación
├── ubicaciones/
│   ├── casa.ink            # Escenas en casa
│   ├── bondi.ink           # Transporte público
│   ├── laburo.ink          # Trabajo (hasta el despido)
│   ├── barrio.ink          # Caminatas y encuentros
│   ├── busqueda.ink        # Búsqueda de laburo
│   └── olla.ink            # La olla popular
├── personajes/
│   ├── juan.ink            # Compañero de trabajo
│   ├── sofia.ink           # Líder de la olla
│   ├── elena.ink           # Veterana
│   ├── diego.ink           # Venezolano
│   ├── marcos.ink          # El ausente
│   ├── ixchel.ink          # Migrante maya-k'iche'
│   ├── lucia.ink           # La sindicalista
│   ├── tiago.ink           # El pibe
│   ├── cacho.ink           # El heredero
│   ├── bruno.ink           # El "Apóstol"
│   └── claudia.ink         # La inspectora
├── dias/
│   ├── lunes.ink           # Día 1
│   ├── martes.ink          # Día 2
│   ├── miercoles.ink       # Día 3 (despido)
│   ├── jueves.ink          # Día 4
│   ├── viernes.ink         # Día 5
│   ├── sabado.ink          # Día 6 (asamblea)
│   └── domingo.ink         # Día 7
├── fragmentos/
│   └── fragmentos.ink      # Perspectivas nocturnas
└── finales/
    └── finales.ink         # Los 19 finales
```

### Patrón de Tunnels

Los módulos usan el patrón de tunnels de Ink para reutilización:

```ink
// En dias/lunes.ink (llamador)
-> casa_despertar ->
-> lunes_siguiente_escena

// En ubicaciones/casa.ink (módulo)
=== casa_despertar ===
// contenido de la escena
->->  // retorna al llamador
```

## Tecnología

- **Lenguaje**: [Ink](https://www.inklestudios.com/ink/) (Inkle Studios)
- **Runtime Web**: Custom con [inkjs](https://github.com/y-lohse/inkjs)
- **Compilador**: inklecate
- **Icons**: [Lucide](https://lucide.dev/)
- **Deploy**: Netlify

### Runtime Web

El proyecto incluye un runtime web modular en `web/`:

```
web/
├── index.html           # Entry point
├── manual.html          # Manual del juego
├── ink.js               # Runtime oficial de Ink (inkjs)
├── game.js              # Motor principal del juego
├── css/                 # CSS modular (index.html linkea cada archivo)
│   ├── variables.css        # Colores, tipografías, colores de stats
│   ├── base.css             # Reset y utilidades
│   ├── header.css           # Barra fija y stats
│   ├── story.css            # Texto narrativo y animaciones
│   ├── dice.css             # Tiradas de dados
│   ├── choices.css          # Botones de decisión
│   ├── notifications.css    # Toasts
│   ├── modals.css           # Modales (stats, guardado, manual, prefs)
│   ├── ui-elements.css      # Relaciones, tags, retratos, thresholds
│   ├── start-screen.css     # Pantalla de inicio
│   ├── ending-screen.css    # Final y libro de finales
│   └── responsive.css       # Mobile y accesibilidad
├── modules/
│   ├── config-manager.js       # Gestión de configuración
│   ├── notification-system.js  # Notificaciones visuales
│   ├── decision-log.js         # Historial de decisiones
│   ├── stats-panel.js          # Panel de stats siempre visible
│   ├── relationships-panel.js  # Panel de relaciones
│   ├── portrait-system.js      # Retratos de NPCs
│   ├── save-system.js          # Guardado/carga de partidas
│   ├── choice-parser.js        # Parseo de tags en decisiones
│   ├── text-presenter.js       # Presentación progresiva del texto
│   ├── start-screen.js         # Pantalla de inicio
│   ├── ending-screen.js        # Pantalla de final
│   ├── achievements.js         # Logros
│   ├── audio-system.js         # Audio
│   ├── accessibility-manager.js# Accesibilidad
│   ├── reading-preferences.js  # Preferencias de lectura
│   └── security-validator.js   # Validación de datos guardados
├── config/
│   ├── game.json            # Config general, días, dados
│   ├── ui.json              # Config de interfaz
│   ├── stats.json           # Stats y thresholds
│   ├── characters.json      # NPCs y relaciones
│   ├── endings-config.json  # Metadatos de finales
│   ├── achievements-config.json
│   ├── audio-config.json
│   └── security-config.json
└── assets/
    └── portraits/           # Retratos de personajes
```

#### Características del Runtime

- **Stats siempre visibles**: Header fijo con energía, salud mental, conexión, etc.
- **Sistema de dados visual**: Muestra tiradas con resultado y descripción
- **Guardado/carga**: LocalStorage con múltiples slots
- **Alertas de threshold**: Aviso visual cuando stats llegan a niveles críticos
- **Retratos dinámicos**: Cambio de expresión según estado del NPC
- **Config-driven**: Comportamiento configurable vía JSON

### Compilación

Todo pasa por los scripts de npm, desde `prototype/`:

```bash
npm run build          # Compila ink/main.ink -> web/un_dia_mas.json + .js
npm run dev            # Igual que build, en modo watch
npm run lint           # Chequeos estáticos sobre los .ink
npm test               # Suite completa (estructura + partidas reales)
npm run test:narrative # Solo las partidas: 200 al azar, falla ante cualquier error
npm run test:endings   # Verifica que los 19 finales existan y cierren
npm run audit          # Auditoría de variables declaradas vs usadas
npm run clean          # Borra el JSON/JS compilado
```

`npm run build` usa el `inklecate` nativo que viene en [`bin/`](../bin/) y
**falla con exit code 1 si el Ink no compila**. No deja el JSON viejo en su
lugar: lo borra antes de compilar, así un build roto nunca se publica como si
fuera bueno.

`web/un_dia_mas.json` y `web/un_dia_mas.js` **se versionan**: Netlify publica
`prototype/web/` como sitio estático sin build step, así que el archivo que
está en git es el juego que se juega. Después de tocar cualquier `.ink`:
compilar, correr los tests y commitear la salida junto al fuente.

Para reproducir una partida que falló:

```bash
TRACE_SEED=42 npm run test:narrative     # imprime la transcripción de esa semilla
TRACE_SEED=42 TRACE_LINES=60 npm run test:narrative
FUZZ_RUNS=2000 npm run test:narrative    # fuzz más largo
```

### Desarrollo Local

Abrir `web/index.html` en un navegador o usar un servidor local:

```bash
cd web && python -m http.server 8000
# o
npx serve web
```

## Contexto Cultural

El juego está ambientado en Uruguay y usa vocabulario local:
- **Bondi**: Autobús/colectivo
- **Olla popular**: Comedor comunitario autogestionado
- **Laburo**: Trabajo
- **Pibe/a**: Chico/a
- **Café de especialidad en prensa francesa**: Ritual cotidiano y sostén energético

La referencia al "2002" alude a la crisis económica uruguaya de ese año, momento de proliferación de ollas populares y redes de solidaridad.

## Influencias

- **Disco Elysium**: Sistema de habilidades como voces internas
- **Kentucky Route Zero**: Narrativa sobre precariedad y comunidad
- **Celeste**: Mecánicas que reflejan estados emocionales
- **Papers, Please**: Dilemas morales sistémicos

## Ideas Internalizadas

Durante el juego, el protagonista puede "internalizar" ideas que afectan su
perspectiva. Hay 21 en total, declaradas en
[`ink/variables.ink`](ink/variables.ink) y escritas en
[`ink/mecanicas/ideas.ink`](ink/mecanicas/ideas.ink).

**Positivas:**
- "Ahora tengo tiempo para esto"
- "Pedir ayuda no es debilidad"
- "Hay cosas que se hacen juntos"
- "La red o la nada" (de Elena)
- "La red sostiene"
- "La reciprocidad es supervivencia" (ayni)
- "El problema no soy yo"

**Políticas:**
- "No es solo mi problema" (la precariedad es estructural)
- "Hay intereses opuestos" (patrones vs trabajadores)
- "Podemos organizarnos sin jefes"
- "A veces hay que romper para construir"
- "El resultado importa más que el discurso" (Lucía)

**De los antagonistas:**
- "Alguien tiene que poner orden" (Bruno)
- "Si sos vivo te salvás" (Cacho)
- "Somos números en un Excel" (Claudia)

**Involuntarias (por inercia alta):**
- "¿Quién soy sin laburo?"
- "Esto es lo que hay"
- "No soy suficiente"

**De Ixchel:**
- "La comida es memoria" (del pepián)
- "Hay otra forma" (del Ut'z Kaslemal)

## Estado del Proyecto

**Prototipo funcional v2** - Una semana completa jugable con:
- Runtime web custom con UI completa
- Sistema de dados visual con feedback claro
- Sistema de guardado/carga con múltiples slots
- 11 NPCs con arcos, perfiles documentados y retratos dinámicos
- 19 finales diferentes basados en decisiones
- Sistema de recursos con la inercia como mecánica central
- ~33.000 líneas de narrativa modular en 35 archivos Ink
- Deploy automático en Netlify

## Licencia

[Por definir]

---

*"La red o la nada."* - Elena
