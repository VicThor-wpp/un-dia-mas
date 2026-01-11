# La Llama - Prototipo Narrativo

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

| Recurso | Descripción | Rango |
|---------|-------------|-------|
| **Energía** | Capacidad de hacer cosas hoy | 0-5 |
| **Conexión** | Tu lugar en el tejido del barrio | 0-10 |
| **Dignidad** | Lo que el sistema te saca de a poco | 0-10 |
| **La Llama** | Esperanza colectiva | 0-10 |
| **Trauma** | Se acumula, nunca baja | 0-10 |
| **Acumulación** | Complicidad con la lógica del capital (oculto) | 0-10 |

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
| **Renzo** | Compañero de trabajo | Se pierde el contacto tras el despido |
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
5. **Gris** (trauma alto): Agotamiento emocional
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
│   ├── renzo.ink           # Compañero de trabajo
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
- **Runtime sugerido**: [inkjs](https://github.com/y-lohse/inkjs) para web
- **Compilador**: inklecate

### Compilación

```bash
# Compilar a JSON para inkjs
inklecate -o la_llama.json ink/main.ink
```

### Integración Web (ejemplo básico)

```javascript
import { Story } from 'inkjs';

const story = new Story(storyContent);

function continueStory() {
    while (story.canContinue) {
        const text = story.Continue();
        // Mostrar texto
    }

    // Mostrar opciones
    story.currentChoices.forEach((choice, i) => {
        // Crear botón para choice.text
    });
}

function choose(index) {
    story.ChooseChoiceIndex(index);
    continueStory();
}
```

## Contexto Cultural

El juego está ambientado en Uruguay y usa vocabulario local:
- **Bondi**: Autobús/colectivo
- **Olla popular**: Comedor comunitario autogestionado
- **Laburo**: Trabajo
- **Pibe/a**: Chico/a
- **Mate**: Infusión tradicional

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

**Involuntarias (por trauma):**
- "¿Quién soy sin laburo?"
- "Esto es lo que hay"

## Estado del Proyecto

**Prototipo funcional** - Una semana completa jugable con:
- Sistema de dados integrado
- 5 NPCs con arcos propios
- 6 finales diferentes
- Sistema de recursos balanceado
- ~3000 líneas de narrativa modular

## Licencia

[Por definir]

---

*"La red o la nada."* - Elena
