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
| **Energía** | Capacidad de hacer cosas hoy | 0-5 | 4 |
| **Conexión** | Tu lugar en el tejido del barrio | 0-10 | 5 |
| **Dignidad** | Lo que el sistema te saca de a poco | 0-10 | 5 |
| **La Llama** | Esperanza colectiva | 0-10 | 3 |
| **Salud Mental** | Bienestar psicológico (baja con estrés) | 0-5 | 5 |
| **Acumulación** | Complicidad con la lógica del capital (oculto) | 0-10 | 0 |

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
| **Juan** | Compañero de trabajo | Se pierde el contacto tras el despido |
| **Sofía** | Líder de la olla | Madre soltera, sostiene todo |
| **Elena** | Veterana del barrio | Memoria del 2002, sabiduría |
| **Diego** | Venezolano nuevo | Buscando pertenecer |
| **Marcos** | El que se alejó | Ex-militante quemado |

### Vínculo
Al inicio, se asigna aleatoriamente uno de los cuatro NPCs de la olla como tu "vínculo" - la persona con quien tenés historia previa.

## Finales

El juego tiene 6 finales posibles basados en tus decisiones:

1. **La Red** (conexión alta + la_llama alta + ayudaste): Tenés una comunidad
2. **Solo** (conexión baja + la_llama baja): Aislamiento
3. **Quizás** (conexión media): Posibilidad abierta
4. **Incierto** (default): Todo es confuso
5. **Gris** (salud mental baja): Agotamiento emocional
6. **El Trato** (acumulación alta): Tentación de Walter

## Estructura Técnica

```
ink/
├── main.ink                 # Entry point + creación personaje
├── variables.ink            # Variables globales centralizadas
├── mecanicas/
│   ├── dados.ink           # Sistema de tiradas
│   └── recursos.ink        # Gestión de recursos
├── ubicaciones/
│   ├── casa.ink            # Escenas en casa
│   ├── bondi.ink           # Transporte público
│   ├── laburo.ink          # Trabajo (hasta el despido)
│   ├── barrio.ink          # Caminatas y encuentros
│   └── olla.ink            # La olla popular
├── personajes/
│   ├── juan.ink            # Compañero de trabajo
│   ├── sofia.ink           # Líder de la olla
│   ├── elena.ink           # Veterana
│   ├── diego.ink           # Venezolano
│   └── marcos.ink          # El ausente
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
    └── finales.ink         # Los 6 finales
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
├── style.css            # Estilos del juego
├── game.js              # Motor principal del juego
├── modules/
│   ├── config-manager.js    # Gestión de configuración
│   ├── dice-display.js      # Visualización de tiradas
│   ├── portraits.js         # Sistema de retratos de NPCs
│   ├── relationships-panel.js # Panel de relaciones
│   ├── save-system.js       # Guardado/carga de partidas
│   └── stats-panel.js       # Panel de stats siempre visible
├── config/
│   ├── game.json            # Config general, días, dados
│   ├── stats.json           # Stats y thresholds
│   └── characters.json      # NPCs y relaciones
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

```bash
# Compilar Ink a JSON
inklecate -o web/un_dia_mas.json ink/main.ink

# Crear wrapper JS para el runtime
echo "var storyContent = $(cat web/un_dia_mas.json);" > web/un_dia_mas.js
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

Durante el juego, el protagonista puede "internalizar" ideas que afectan su perspectiva:

**Elegidas:**
- "Ahora tengo tiempo para esto"
- "Pedir ayuda no es debilidad"
- "Hay cosas que se hacen juntos"
- "La red o la nada"

**Involuntarias (por estrés/baja salud mental):**
- "¿Quién soy sin laburo?"
- "Esto es lo que hay"

## Estado del Proyecto

**Prototipo funcional v2** - Una semana completa jugable con:
- Runtime web custom con UI completa
- Sistema de dados visual con feedback claro
- Sistema de guardado/carga con múltiples slots
- 5 NPCs con arcos y retratos dinámicos
- 6 finales diferentes basados en decisiones
- Sistema de recursos balanceado con alertas visuales
- ~3000 líneas de narrativa modular
- Deploy automático en Netlify

## Licencia

[Por definir]

---

*"La red o la nada."* - Elena
