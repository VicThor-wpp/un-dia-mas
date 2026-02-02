# Mejora de Fragmentos Nocturnos

**Fecha:** 2026-02-02  
**Archivo:** `prototype/ink/fragmentos/fragmentos.ink`

## Problema Identificado

El análisis inicial marcó los fragmentos nocturnos como **repetitivos**. El archivo original tenía:

- Solo 4 fragmentos definidos (2 de Ixchel, 1 de Juan, 1 genérico de ciudad)
- 12+ fragmentos **referenciados pero no implementados**
- Sistema de selección básico sin variedad por día
- Poca conexión emocional con los NPCs

## Solución Implementada

### 1. Sistema Dinámico por Día

Cada personaje ahora tiene **7 fragmentos únicos** (uno por día de la semana):

```ink
=== fragmento_sofia ===
{dia_actual:
- 1: -> sofia_lunes
- 2: -> sofia_martes
// etc.
}
```

### 2. Fragmentos por Personaje

| Personaje | Fragmentos | Temática |
|-----------|------------|----------|
| **Sofía** | 7 | Olla popular, pibes, comunidad, cansancio, esperanza |
| **Elena** | 7 | Migración, memoria, solidaridad vecinal, nostalgia |
| **Diego** | 7 | Barrio, discriminación policial, rap, familia, futuro |
| **Marcos** | 7 | Arquitecto caído, alcohol, divorcio, redención |
| **Juan** | 7 | Miedo al despido, migración, familia, culpa |
| **Ixchel** | 7 | Racismo laboral, tejido, K'iche', espiritualidad maya |
| **Tiago** | 3 | Solo si Bruno lo presionó - dilema moral |
| **Ciudad** | 7 | Contrastes urbanos, desigualdad, resistencia |

**Total: 52 fragmentos únicos** (antes había 4)

### 3. Fragmentos Condicionales

Fragmentos que cambian según decisiones del jugador:

- `sofia_jueves`: Cambia si `sofia_confio == true`
- `sofia_viernes`: Cambia si `ayude_en_olla == true`
- `sofia_sabado`: Cambia si `participe_asamblea == true`
- `elena_jueves`: Cambia si `elena_hablo_pasado == true`
- `marcos_jueves`: Cambia si `marcos_abrio_corazon == true`
- `juan_jueves`: Cambia si `juan_sabe_despido == true`
- `fragmento_tiago`: Solo aparece si `bruno_presiono_tiago == true`

### 4. Conexión Emocional

Cada fragmento muestra:

- **Vulnerabilidad**: Los NPCs tienen miedos, dudas, dolores
- **Humanidad**: Momentos íntimos que el protagonista no ve
- **Contexto**: El mundo sigue sin el jugador
- **Resistencia**: Pequeños actos de dignidad y solidaridad

#### Ejemplos de Tono Logrado

**Sofía (cansancio solidario):**
> "Su estómago gruñe. Ella comió poco hoy. Siempre come poco. Los pibes comen primero. Siempre."

**Ixchel (dignidad ancestral):**
> "No es boliviana. Es guatemalteca. Maya-K'iche'. Se lo dijo tres veces. Él sigue diciendo 'bolita'. Ixchel no contesta. Su dignidad es un silencio antiguo."

**Marcos (vulnerabilidad masculina):**
> "Piensa en las deudas. En el divorcio. En los hijos que no ve. En todo lo que se rompió. Se levanta. Pone música bajito. Jazz. Lo único que lo calma."

**Diego (realidad de barrio):**
> "Pasa un patrullero. Los mira. Ellos miran al piso. 'Estos nos tienen marcados', dice el Tato. 'Siempre nos van a tener marcados', dice Diego."

### 5. Estructura del Sistema

```
fragmento_nocturno (entrada principal)
├── Por vínculo → fragmento_[personaje]
│   └── Por día → [personaje]_[día]
│       └── Por decisiones → Variantes condicionales
└── Sin vínculo → fragmento_ciudad
    └── Por día → ciudad_[día]
```

## Variables Requeridas

El archivo asume estas variables definidas en el archivo principal:

```ink
VAR vinculo = ""
VAR dia_actual = 1  // 1=lunes, 7=domingo
VAR ayude_en_olla = false
VAR participe_asamblea = false
VAR bruno_presiono_tiago = false
VAR juan_sabe_despido = false
VAR marcos_abrio_corazon = false
VAR sofia_confio = false
VAR elena_hablo_pasado = false
```

## Uso

### Desde cualquier día:
```ink
// Mostrar fragmento nocturno basado en vínculo y día
-> fragmento_nocturno ->
```

### Para días específicos:
```ink
// Viernes
-> seleccionar_fragmento_viernes ->

// Sábado  
-> seleccionar_fragmento_sabado ->

// Domingo
-> seleccionar_fragmento_domingo ->
```

## Notas de Diseño

1. **Fragmentos cortos**: 50-150 palabras máximo
2. **Sin acción del jugador**: Solo observa
3. **Un momento, una perspectiva**: No sobrecargados
4. **Lenguaje auténtico**: 
   - K'iche' para Ixchel
   - Lunfardo para Diego
   - Uruguayismos para todos
5. **Sin moralejas explícitas**: Mostrar, no decir

## Mejoras Futuras Posibles

- [ ] Fragmentos que cambian según relación con el personaje (no solo vínculo principal)
- [ ] Fragmentos cruzados (ver a dos personajes interactuando)
- [ ] Fragmentos que revelan información narrativa clave
- [ ] Posibilidad de "espiar" fragmentos de otros vínculos (con costo)
