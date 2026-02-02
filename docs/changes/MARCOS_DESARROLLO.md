# MARCOS_DESARROLLO.md
## Cambios realizados al personaje Marcos "El Cuadro Quemado"

**Fecha:** 2026-02-02  
**Archivo modificado:** `prototype/ink/personajes/marcos.ink`

---

## Resumen

Se expandió significativamente el arco de Marcos para solucionar el problema de su reconexión abrupta. Anteriormente saltaba de "no contesta" a "aparece en asamblea" sin transición. Ahora tiene una progresión gradual de 8 fases con múltiples escenas intermedias.

---

## Sistema de Estados

Se implementó un sistema de estados para trackear la progresión de Marcos:

```
marcos_estado: "ausente" → "evitando" → "respondiendo" → "mirando" → "reconectando"
```

Cada estado tiene escenas asociadas y el jugador debe progresar gradualmente.

---

## Nuevas Escenas Agregadas

### 1. Escenas Intermedias

| Escena | Descripción | Estado requerido |
|--------|-------------|------------------|
| `marcos_encuentro_evita` | Lo ves en el almacén, paga apurado y se va | evitando |
| `marcos_supermercado` | Encuentro accidental comparando precios | evitando |
| `marcos_mensaje_no_responde` | Manda mensaje, tilde azul, nada | ausente/evitando |
| `marcos_mensaje_responde_tarde` | Responde después de días con "Es lo que hay" | evitando → respondiendo |
| `marcos_mensaje_noche` | Mensaje a las 2AM "¿Estás despierto?" | evitando → respondiendo |
| `marcos_cafe_bar` | Se encuentran en un bar, Marcos habla de su parálisis | respondiendo |
| `marcos_menciona_hijos_casual` | Mención al pasar sobre foto de Martín | cualquiera |

### 2. Escenas Diego-Marcos

| Escena | Descripción |
|--------|-------------|
| `marcos_diego_encuentro` | Diego y Marcos coinciden en la olla |
| `marcos_diego_charla` | "Las papas se comen. Las teorías no." |
| `marcos_diego_pregunta_practica` | "¿Cuántos kilos de fideos necesitamos?" - descoloca a Marcos |

**Momento clave:** Diego le pasa un cuchillo y pregunta "¿Sabés pelar?" - primera vez que Marcos hace algo concreto.

### 3. Escenas Elena-Marcos

| Escena | Descripción |
|--------|-------------|
| `marcos_elena_conflicto` | "¿Vas a ayudar o vas a mirar?" - teoría vs praxis |
| `marcos_elena_cont` | "En el 2002 no teníamos tiempo de analizar" |
| `marcos_elena_respeto` | Marcos le trae mate, momento de respeto mutuo |

**Frase clave de Elena:** "Dejá de leer y pelá una papa"

### 4. Crítica a "La Orga"

| Escena | Descripción |
|--------|-------------|
| `marcos_critica_orga` | "Tenían razón pero la cagaron" |
| `marcos_critica_cont` | "Extraño la mística. El creer que se podía." |

**Matiz importante:** No es solo amargura. Hay nostalgia. Extraña lo que prometía, no lo que fue.

### 5. Fragmentos Nocturnos (Nuevos)

| Escena | Descripción |
|--------|-------------|
| `fragmento_marcos_noticias` | En su cueva scrolleando noticias, indignándose sin hacer nada |
| `fragmento_marcos_fotos_hijos` | Mirando fotos de Lucía y Martín, la época en que todo tenía sentido |
| `fragmento_marcos_mensaje_no_envia` | Escribe mensaje a Martín, lo borra, "Mañana capaz" |
| `fragmento_marcos_insomnio` | No duerme, tele sin sonido, café a las 4AM |
| `fragmento_marcos_balcon` | Fuma en el balcón pensando en la olla |
| `fragmento_marcos_musica` | Rock nacional de los 80, nostalgia |
| `fragmento_marcos_libros` | Mirando El Capital que ahora usa para nivelar la mesa |

### 6. Progresión de Asamblea

Antes: ausente → viene a asamblea (salto abrupto)

Ahora:
1. `marcos_asamblea_lejos` - Mira desde la vereda de enfrente
2. `marcos_asamblea_puerta` - En la puerta, un pie adentro, uno afuera
3. `marcos_en_asamblea` - Adentro, en el fondo, mirando
4. `marcos_ayuda_cocina` - Pelando papas con Elena

### 7. Reconexión Gradual

| Escena | Descripción |
|--------|-------------|
| `marcos_trae_arroz` | Aparece con 10 kilos de arroz del mayorista |
| `marcos_domingo_olla` | Adentro, con las manos en los bolsillos |
| `marcos_ayuda_cocina` | Pelando papas, Elena lo corrige, "Sí, compañera" |

---

## Variables Nuevas

```ink
marcos_estado              // "ausente", "evitando", "respondiendo", "mirando", "reconectando"
marcos_mensajes_enviados   // Contador de mensajes sin respuesta
marcos_encuentros_evitados // Veces que Marcos evitó hablar
marcos_acepto_cafe         // Si aceptó tomar café
marcos_va_a_ayudar         // Si ofreció ayuda concreta
marcos_ofrecio_ayuda       // Si ofreció conseguir algo (fideos/arroz)
```

---

## Temas Desarrollados

### 1. Parálisis por Análisis
> "El problema de entender demasiado es que ves todas las consecuencias. Y entonces no hacés nada."

### 2. Teoría vs Praxis
- Elena: pura praxis sin teoría
- Marcos: pura teoría sin praxis
- Diego: praxis con teoría emergente (cooperativismo real)

### 3. El Fracaso como Padre
> "Cuando era joven la política era todo. No aprendí a ser padre fuera de eso."

### 4. La Nostalgia del Militante Quemado
> "No extraño la orga. Extraño lo que la orga prometía. Lo que nunca fue."

### 5. El Mensaje que Nunca se Envía
Fragmento nocturno clave: escribe mensajes a sus hijos, los borra. "Mañana capaz que mañana."

---

## Integración con el Sistema de Juego

- Los estados de Marcos afectan qué escenas están disponibles
- La relación (`marcos_relacion`) modifica los chequeos sociales
- Las escenas nocturnas cambian según el estado (esperanza vs vacío)
- El fragmento `marcos_fragmento_noche` tiene variantes según progresión

---

## Notas de Diseño

1. **Marcos no se "cura"** - solo reconecta parcialmente
2. **El cambio viene de lo concreto** - papas, arroz, no discursos
3. **Diego es el catalizador** - su pregunta práctica rompe la parálisis
4. **Elena es la prueba** - si puede trabajar con ella, puede con cualquiera
5. **Los hijos son la herida abierta** - nunca se resuelve del todo

---

## Próximos Pasos Sugeridos

1. Conectar escenas de mensajes con el sistema de días (miércoles/jueves)
2. Agregar trigger para escena Diego-Marcos en momento de asamblea
3. Crear escena donde Marcos finalmente escribe a sus hijos (¿final del arco?)
4. Integrar fragmentos nocturnos con sistema de perspectivas
