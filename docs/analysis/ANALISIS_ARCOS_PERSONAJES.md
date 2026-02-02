# ANÁLISIS EXHAUSTIVO: ARCOS DE PERSONAJES
## "Un Día Más" - Reporte de Narrativa

**Fecha:** 2 de febrero de 2026
**Versión analizada:** Prototype v1.x

---

## ÍNDICE
1. [Resumen Ejecutivo](#resumen-ejecutivo)
2. [Análisis por Personaje](#análisis-por-personaje)
3. [Mapa de Relaciones](#mapa-de-relaciones)
4. [Sistema de Vínculos](#sistema-de-vínculos)
5. [Fragmentos Nocturnos](#fragmentos-nocturnos)
6. [Coherencia Diseño vs Implementación](#coherencia-diseño-vs-implementación)
7. [NPCs que Necesitan Desarrollo](#npcs-que-necesitan-desarrollo)
8. [Propuestas de Mejora](#propuestas-de-mejora)

---

## RESUMEN EJECUTIVO

El juego cuenta con **11 NPCs principales** más el protagonista. Los personajes están organizados en tres círculos:

- **Círculo de la Olla:** Elena, Sofía, Diego, Ixchel, Tiago
- **Círculo Laboral/Transición:** Juan, Lucía, Marcos
- **Antagonistas/Tensión:** Claudia, Bruno, Cacho

### Fortalezas Detectadas:
- ✅ Elena tiene el arco más completo y coherente
- ✅ Diego está muy bien implementado con su historia de CECOSESOLA
- ✅ Ixchel aporta profundidad cultural única
- ✅ El sistema de relaciones/vínculos funciona mecánicamente

### Áreas de Mejora:
- ⚠️ Lucía está sub-implementada vs su diseño
- ⚠️ Cacho carece de arco real de redención
- ⚠️ Claudia es unidimensional (solo antagonista)
- ⚠️ Tiago necesita más escenas de desarrollo intermedio
- ⚠️ Bruno aparece poco para su peso narrativo

---

## ANÁLISIS POR PERSONAJE

### 1. ELENA "La Memoria" 🟢 COMPLETO

#### Arco Narrativo
| Fase | Contenido | Estado |
|------|-----------|--------|
| **Inicio** | Veterana sentada en el banco, observadora silenciosa | ✅ Implementado |
| **Desarrollo** | Cuenta historias del 2002, trueque, banco, desalojo García | ✅ Implementado |
| **Clímax** | Preocupación por la olla, pide ayuda al protagonista | ✅ Implementado |
| **Resolución** | Conexión profunda con protagonista, herencia de sabiduría | ✅ Implementado |

#### Escenas Clave Implementadas:
- `elena_conversacion` - Hub principal
- `elena_trueque_2002` - Historia del trueque
- `elena_en_banco_2002` - Escena del banco
- `elena_desalojo_garcia` - Resistencia al desalojo
- `elena_sobre_la_chola` - Relación con la madre de Sofía
- `elena_anarquismo` - Filosofía política
- `elena_preocupada_olla_knot` - Crisis de la olla
- `protagonista_pide_ayuda` - Quiebre del protagonista

#### Fragmentos Nocturnos: 4 implementados
- `elena_fragmento_noche` (principal)
- `fragmento_elena_banco`
- `fragmento_elena_recuerdo`
- `fragmento_elena_cartas`

#### Coherencia Diseño/Implementación: **95%**
- ✅ Anarquismo visceral presente
- ✅ Relación con la Chola documentada
- ✅ Historia del 2002 completa
- ⚠️ Falta escena de la inundación del 59 (mencionada en diseño)

---

### 2. DIEGO "El Sembrador Roto" 🟢 COMPLETO

#### Arco Narrativo
| Fase | Contenido | Estado |
|------|-----------|--------|
| **Inicio** | Camina rápido, trabaja en depósito, no habla mucho | ✅ Implementado |
| **Desarrollo** | Cuenta de CECOSESOLA, cooperativas, camión quemado | ✅ Implementado |
| **Clímax** | Pierde el trabajo, crisis personal | ✅ Implementado |
| **Resolución** | Encuentra rol organizador en la olla | ✅ Implementado |

#### Escenas Clave Implementadas:
- `diego_historia_cecosesola` - Historia completa de la cooperativa
- `diego_sobre_camion` - El camión quemado
- `diego_libreta_semillas` - Objeto simbólico poderoso
- `diego_pierde_laburo` - Crisis personal
- `diego_conversacion_profunda` - Apertura emocional
- `diego_y_marcos` - Tensión ideológica interesante

#### Fragmentos Nocturnos: 4 implementados
- `diego_fragmento_noche` (principal - muy completo)
- `fragmento_diego_llamada`
- `fragmento_diego_permiso`
- `fragmento_diego_mate`

#### Coherencia Diseño/Implementación: **98%**
- ✅ Historia de CECOSESOLA perfectamente integrada
- ✅ Premio Right Livelihood mencionado
- ✅ Franela de cooperativa como objeto
- ✅ Libreta de semillas implementada
- ✅ Contraste con Marcos funciona

---

### 3. SOFÍA "La Elección Consciente" 🟢 COMPLETO

#### Arco Narrativo
| Fase | Contenido | Estado |
|------|-----------|--------|
| **Inicio** | Coordinadora agotada, ojeras permanentes | ✅ Implementado |
| **Desarrollo** | Historia de la Chola, beca rechazada, vida doble | ✅ Implementado |
| **Clímax** | Momento de quiebre emocional | ✅ Implementado |
| **Resolución** | Acepta ayuda, la máscara se rompe | ✅ Implementado |

#### Escenas Clave Implementadas:
- `sofia_sobre_madre` - Muerte de la Chola
- `sofia_oferta_alemania` - Beca rechazada
- `sofia_martin_papas` - Compañero de laboratorio
- `sofia_catolicismo` - Fe práctica
- `sofia_delantal_madre` - Objeto heredado
- `sofia_momento_quiebre` - Escena crucial de vulnerabilidad
- `sofia_pide_ayuda` - Crisis de la olla

#### Fragmentos Nocturnos: 3 implementados
- `sofia_fragmento_noche` (principal)
- `fragmento_sofia_cocina`
- `fragmento_sofia_pibes`
- `fragmento_sofia_asamblea`

#### Coherencia Diseño/Implementación: **92%**
- ✅ Tensión academia/olla presente
- ✅ Hijos mencionados (Nico y Lupe)
- ✅ Delantal de la madre como símbolo
- ⚠️ Padre de los hijos (Matías) no aparece
- ⚠️ Compañero Martín mencionado pero sin escena propia

---

### 4. MARCOS "El Cuadro Quemado" 🟡 CASI COMPLETO

#### Arco Narrativo
| Fase | Contenido | Estado |
|------|-----------|--------|
| **Inicio** | Aislado, evita el barrio, cruza rápido | ✅ Implementado |
| **Desarrollo** | Revela pasado militante, desencanto | ✅ Implementado |
| **Clímax** | Revela que también fue despedido | ✅ Implementado |
| **Resolución** | Vuelve a la asamblea, reconexión | ✅ Implementado |

#### Escenas Clave Implementadas:
- `marcos_encuentro_plaza` - Encuentro central
- `marcos_sobre_hijos` - Hijos en Europa
- `marcos_sobre_zabalza` - Referencia política
- `marcos_noche_votos_2009` - Quiebre ideológico
- `marcos_sobre_voto_blanco` - Vergüenza del voto
- `marcos_revelar_despido` - Momento de vulnerabilidad
- `marcos_domingo_olla` - Reconexión

#### Fragmentos Nocturnos: 3 implementados
- `marcos_fragmento_noche` (principal)
- `fragmento_marcos_insomnio`
- `fragmento_marcos_balcon`
- `fragmento_marcos_musica`

#### Coherencia Diseño/Implementación: **88%**
- ✅ Lenguaje de "cuadro" presente
- ✅ Burnout político bien representado
- ✅ Tensión con Diego implementada
- ⚠️ Ex-esposa Claudia (diferente a la auditora) no aparece
- ⚠️ Asamblea del Paraninfo no mencionada

---

### 5. IXCHEL "La Raíz Desplazada" 🟢 COMPLETO

#### Arco Narrativo
| Fase | Contenido | Estado |
|------|-----------|--------|
| **Inicio** | Trabaja en silencio, formal, invisible | ✅ Implementado |
| **Desarrollo** | Historia de Tomás, Mina Marlin, cosmovisión maya | ✅ Implementado |
| **Clímax** | Crítica a izquierda académica, concepto de ayni | ✅ Implementado |
| **Resolución** | Momento de alegría colectiva (baile) | ✅ Implementado |

#### Escenas Clave Implementadas:
- `ixchel_historia_tomas` - Hermano desaparecido
- `ixchel_sobre_mina_marlin` - Conflicto minero
- `ixchel_llegada_uruguay` - Historia migratoria
- `ixchel_sobre_huipil` - Identidad oculta
- `ixchel_cosmovision` - Relación con el maíz
- `ixchel_critica_academica` - Escena política crucial
- `ixchel_sobre_ayni` - Economía del cuidado
- `ixchel_momento_alegria` - Baile colectivo

#### Fragmentos Nocturnos: 4 implementados
- `ixchel_fragmento_noche` (principal)
- `fragmento_ixchel_cocina`
- `fragmento_ixchel_altar`
- `ixchel_fragmento_noche_tejido`

#### Coherencia Diseño/Implementación: **97%**
- ✅ Cosmovisión maya completamente integrada
- ✅ Historia de Goldcorp/Mina Marlin documentada
- ✅ Sincretismo religioso presente
- ✅ Huipil como símbolo poderoso
- ✅ Interacciones con Elena, Diego implementadas

---

### 6. JUAN "El Asustado" 🟡 CASI COMPLETO

#### Arco Narrativo
| Fase | Contenido | Estado |
|------|-----------|--------|
| **Inicio** | Compañero de trabajo, miedoso, repite discursos | ✅ Implementado |
| **Desarrollo** | Fascinación con historias migrantes, procesamiento lento | ✅ Implementado |
| **Clímax** | Contradicción (quiere organizarse pero tiene miedo) | ✅ Implementado |
| **Resolución** | Migración a España con Laura | ✅ Implementado |

#### Escenas Clave Implementadas:
- `juan_preocupacion` - Miedo laboral
- `juan_bar` - Conversación profunda
- `juan_recuerdo_marchas` - Pasado enterrado
- `juan_sobre_laura` - Relación con esposa
- `juan_fascinado_diego` - Contraste con migrantes
- `juan_procesando` - Cambio gradual
- `juan_contradiccion` - Escena clave de cobardía
- `juan_despedida_migracion` - Arco final

#### Fragmentos Nocturnos: 4 implementados
- `juan_fragmento_noche` (principal)
- `fragmento_juan_cena`
- `fragmento_juan_curriculum`
- `fragmento_juan_noche`

#### Coherencia Diseño/Implementación: **90%**
- ✅ Miedo crónico bien representado
- ✅ Procesamiento lento implementado
- ✅ Migración a España como resolución
- ⚠️ Changa técnica (drones, seguridad) poco desarrollada
- ⚠️ Robo de la moto no aparece

---

### 7. LUCÍA "La Sindicalista Pragmática" 🔴 SUBDESARROLLADA

#### Arco Narrativo
| Fase | Contenido | Estado |
|------|-----------|--------|
| **Inicio** | Delegada sindical, advierte al protagonista | ✅ Implementado |
| **Desarrollo** | Explica situación de unipersonal, límites del sindicato | ✅ Implementado |
| **Clímax** | Aparece en la olla | ⚠️ Básico |
| **Resolución** | Participa en asamblea | ⚠️ Básico |

#### Escenas Clave Implementadas:
- `lucia_escena_mate` - Advertencia inicial
- `lucia_consejo_despido` - Consejos post-despido
- `lucia_almuerzo_oficina` - Tensión laboral
- `lucia_explica_unipersonal` - Escena crucial sobre límites
- `lucia_en_olla` - Aparición en olla
- `lucia_en_asamblea` - Conexión con barrio

#### Fragmentos Nocturnos: 1 implementado
- `fragmento_lucia_numeros` (único)

#### Coherencia Diseño/Implementación: **65%**
- ✅ Pragmatismo sindical presente
- ✅ Explicación de unipersonal bien hecha
- ❌ Conflicto con "machirulaje" del PIT-CNT NO implementado
- ❌ Historia personal casi inexistente
- ❌ Su feminismo sindical no aparece
- ❌ Falta profundidad emocional

---

### 8. TIAGO "El Futuro en Riesgo" 🟡 PARCIALMENTE COMPLETO

#### Arco Narrativo
| Fase | Contenido | Estado |
|------|-----------|--------|
| **Inicio** | Pibe de logística, defensivo | ✅ Implementado |
| **Desarrollo** | Historia de INAU, madre en Vilardebó | ✅ Implementado |
| **Clímax** | Conflicto tupper con Claudia | ✅ Implementado |
| **Resolución** | Decisión: ¿olla o chacra de Bruno? | ✅ Implementado |

#### Escenas Clave Implementadas:
- `tiago_primer_encuentro` - Actitud defensiva
- `tiago_conflicto_comida` - Escena con Claudia
- `tiago_se_abre` - Revela sobre madre
- `tiago_decision_final` - Encrucijada crucial
- `tiago_en_asamblea` - Si se queda

#### Fragmentos Nocturnos: 1 implementado
- `fragmento_tiago_techo` (único)

#### Coherencia Diseño/Implementación: **80%**
- ✅ Tensión con Bruno implementada
- ✅ Decisión bifurcada funciona
- ⚠️ Historia INAU mencionada pero no desarrollada
- ⚠️ Falta desarrollo intermedio entre confianza baja y apertura
- ⚠️ Solo 1 fragmento nocturno

---

### 9. CLAUDIA "La Violencia Administrativa" 🟡 FUNCIONAL PERO PLANA

#### Arco Narrativo
| Fase | Contenido | Estado |
|------|-----------|--------|
| **Inicio** | Auditora llega a la olla | ✅ Implementado |
| **Desarrollo** | Exige lista, amenaza con cerrar | ✅ Implementado |
| **Clímax** | Ultimátum del viernes | ✅ Implementado |
| **Resolución** | Resultado según decisión del jugador | ✅ Implementado |

#### Escenas Implementadas:
- `claudia_llegada` - Primera aparición
- `claudia_la_auditoria` - Conflicto central
- `claudia_amenaza_final` - Ultimátum
- `claudia_el_tupper` - Conflicto con Tiago
- `claudia_segundo_round` - Presión adicional
- `claudia_domingo` - Resolución

#### Fragmentos Nocturnos: 1 implementado
- `fragmento_claudia_oficina` (único)

#### Coherencia Diseño/Implementación: **85%**
- ✅ Función antagonista cumplida
- ✅ "Lo que no está en planilla no existe" presente
- ⚠️ Sin humanización - es puramente funcional
- ⚠️ Su propia presión de arriba apenas mencionada

---

### 10. BRUNO "El Apóstol" 🟡 INSUFICIENTE

#### Arco Narrativo
| Fase | Contenido | Estado |
|------|-----------|--------|
| **Inicio** | Aparece con camioneta, marca territorio | ✅ Implementado |
| **Desarrollo** | Intenta reclutar a Tiago, confronta a Sofía | ✅ Implementado |
| **Clímax** | Ofrece "salida" al protagonista | ⚠️ Solo si inercia alta |
| **Resolución** | Gana o pierde a Tiago | ✅ Implementado |

#### Escenas Implementadas:
- `bruno_primer_encuentro` - Oferta inicial
- `bruno_la_visita` - Marca territorio
- `bruno_confronta_sofia` - Conflicto ideológico
- `bruno_recluta_tiago` - Tensión central
- `bruno_oferta_protagonista` - Tentación
- `bruno_amenaza_olla` - Escalada

#### Fragmentos Nocturnos: 1 implementado
- `fragmento_bruno_chacra` (único)

#### Coherencia Diseño/Implementación: **75%**
- ✅ Discurso neo-pentecostal presente
- ✅ Modelo Beraca implícito
- ⚠️ Aparece poco para su peso narrativo
- ⚠️ Conexiones con diputados mencionadas pero no mostradas
- ❌ Falta su historia de origen (ex-policía)

---

### 11. CACHO "El Lumpen Iluso" 🔴 SUBDESARROLLADO

#### Arco Narrativo
| Fase | Contenido | Estado |
|------|-----------|--------|
| **Inicio** | Ofrece negocios turbios | ✅ Implementado |
| **Desarrollo** | Casa ruinosa, "stock" de chatarra | ✅ Implementado |
| **Clímax** | Momento de realidad (si se confronta) | ⚠️ Opcional |
| **Resolución** | Posible redención | ⚠️ Muy condicional |

#### Escenas Implementadas:
- `cacho_oferta_negocio` - Perfumes falsos
- `cacho_en_la_fila` - Vergüenza en la olla
- `cacho_casa` - Decodificadores viejos
- `cacho_sin_olla` - Si cierra
- `cacho_redencion` - Posible ayuda
- `cacho_domingo` - Reflexión

#### Fragmentos Nocturnos: 1 implementado
- `fragmento_cacho_casa` (único)

#### Coherencia Diseño/Implementación: **70%**
- ✅ "Mindset" capitalista representado
- ✅ Contradicción planero/anti-planero
- ⚠️ Arco de redención demasiado condicional
- ❌ Sin desarrollo intermedio
- ❌ Alivio cómico sin peso dramático real

---

## MAPA DE RELACIONES

```
                    ┌─────────────────────────────────────┐
                    │           PROTAGONISTA              │
                    │   (Vínculo aleatorio con 1 de 4)   │
                    └──────────────┬──────────────────────┘
                                   │
         ┌─────────────────────────┼─────────────────────────┐
         │                         │                         │
         ▼                         ▼                         ▼
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   CÍRCULO OLLA  │    │ CÍRCULO LABORAL │    │  ANTAGONISTAS   │
├─────────────────┤    ├─────────────────┤    ├─────────────────┤
│ ELENA ◄──────► SOFÍA │    │ JUAN ◄────► LUCÍA │    │     CLAUDIA     │
│   │ (tía-sobrina)    │    │  (compañeros)     │    │   (vs Olla)     │
│   │                  │    │       │           │    │        │        │
│   ▼                  │    │       ▼           │    │        ▼        │
│ DIEGO ◄──────► IXCHEL│    │    MARCOS         │    │     BRUNO       │
│   │ (migrantes)      │    │  (aislado)        │    │   (vs Olla)     │
│   │                  │    │       │           │    │        │        │
│   ▼                  │    │       │           │    │        ▼        │
│ TIAGO                │    │       └───────────┼────┼───► TIAGO       │
│ (en riesgo)          │    │                   │    │   (disputa)     │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                                   │
                                   ▼
                    ┌─────────────────────────────────────┐
                    │              CACHO                  │
                    │     (periférico, cómico-trágico)   │
                    └─────────────────────────────────────┘
```

### Relaciones Clave Implementadas:

| Relación | Tipo | Estado | Escenas |
|----------|------|--------|---------|
| Elena ↔ Sofía | Tía/sobrina simbólica | ✅ | Múltiples referencias |
| Elena ↔ La Chola | Amigas 40 años | ✅ | `elena_sobre_la_chola` |
| Diego ↔ Marcos | Tensión ideológica | ✅ | `diego_y_marcos` |
| Diego ↔ Ixchel | Migrantes solidarios | ✅ | `ixchel_y_diego` |
| Elena ↔ Ixchel | Guerreras de distintas guerras | ✅ | `ixchel_y_elena` |
| Juan ↔ Diego | Fascinación/incomprensión | ✅ | `juan_fascinado_diego` |
| Ixchel ↔ Juan | Paciencia ante ignorancia | ✅ | `ixchel_y_juan` |
| Bruno ↔ Tiago | Depredador/presa | ✅ | `bruno_recluta_tiago` |
| Bruno ↔ Sofía | Conflicto ideológico | ✅ | `bruno_confronta_sofia` |
| Claudia ↔ Tiago | Burocracia vs necesidad | ✅ | `tiago_conflicto_comida` |

### Relaciones Faltantes o Débiles:

| Relación | Diseño | Implementación |
|----------|--------|----------------|
| Marcos ↔ Sofía | "La admira en secreto" | ⚠️ No hay escena directa |
| Lucía ↔ Sofía | Amigas sindicato/olla | ⚠️ Solo mención |
| Juan ↔ Ixchel | "Preguntas de documental" | ✅ Pero breve |
| Elena ↔ Diego | Respeto mutuo | ⚠️ Implícito, no explícito |

---

## SISTEMA DE VÍNCULOS

### Mecánica de Relación Individual

Cada personaje tiene una variable `[personaje]_relacion` que aumenta con:
- Escuchar activamente
- Ayudar en tareas
- Pasar chequeos sociales
- Elegir opciones empáticas

### Variables de Estado por Personaje:

| Personaje | Variable Relación | Estados Especiales |
|-----------|-------------------|-------------------|
| Elena | `elena_relacion` | `elena_preocupada_olla`, `elena_me_aconsejo` |
| Diego | `diego_relacion` | `diego_perdio_laburo`, `diego_estado` |
| Sofía | `sofia_relacion` | `sofia_estado` ("agotada", "quebrando") |
| Marcos | `marcos_relacion` | `marcos_estado` ("mirando", "reconectando") |
| Ixchel | `ixchel_relacion` | `ixchel_estado` |
| Juan | `juan_relacion` | `juan_migra`, `juan_estado` |
| Tiago | `tiago_confianza` | `tiago_se_queda`, `tiago_captado_por_bruno` |
| Claudia | `claudia_hostilidad` | `lista_entregada` |
| Bruno | `bruno_tension` | - |

### Sistema de Vínculos Global

Variable `vinculo` determina entrada a la olla:
- `"sofia"` - Conoces a Sofía de antes
- `"elena"` - Conoces a Elena de antes
- `"diego"` - Conoces a Diego de antes
- `"marcos"` - Conoces a Marcos de antes

**Impacto en Fragmentos:** El vínculo determina qué fragmento nocturno se muestra el domingo (`seleccionar_fragmento_domingo`).

### Variables Globales de Conexión:

| Variable | Función |
|----------|---------|
| `conexion` | Nivel general de integración comunitaria |
| `llama` | Esperanza/motivación colectiva |
| `dignidad` | Autoestima y resistencia |
| `inercia` | Parálisis/desesperanza |

### Funciones de Modificación:
- `subir_conexion(n)` / `bajar_conexion(n)`
- `subir_llama(n)` / `bajar_llama(n)`
- `subir_dignidad(n)`
- `aumentar_inercia(n)` / `disminuir_inercia(n)`

---

## FRAGMENTOS NOCTURNOS

### Distribución por Personaje:

| Personaje | Fragmentos | Profundidad |
|-----------|------------|-------------|
| Elena | 4 | ⭐⭐⭐⭐⭐ |
| Diego | 4 | ⭐⭐⭐⭐⭐ |
| Sofía | 4 | ⭐⭐⭐⭐ |
| Marcos | 4 | ⭐⭐⭐⭐ |
| Ixchel | 4 | ⭐⭐⭐⭐⭐ |
| Juan | 4 | ⭐⭐⭐⭐ |
| Lucía | 1 | ⭐ |
| Tiago | 1 | ⭐⭐ |
| Claudia | 1 | ⭐⭐ |
| Bruno | 1 | ⭐⭐ |
| Cacho | 1 | ⭐⭐ |

### Análisis de Fragmentos:

**Mejor implementados:**
1. **Elena** - Muestra el insomnio de los viejos, la radio, los fantasmas
2. **Diego** - Franela de CECOSESOLA, llamada a Venezuela, libreta de semillas
3. **Ixchel** - Altar, copal, tejido, sincretismo religioso

**Más débiles:**
1. **Lucía** - Solo hace números. Sin vida personal.
2. **Tiago** - Solo mira estrellas. Sin contexto INAU.
3. **Cacho** - Solo cuenta monedas. Predecible.

### Sistema de Selección:

```ink
=== seleccionar_fragmento_viernes ===
{ayude_en_olla:
    -> fragmento_sofia_cocina ->
- else:
    {vinculo == "marcos":
        -> fragmento_marcos_insomnio ->
    - else:
        -> fragmento_ciudad_noche ->
    }
}
```

**Problema:** El sistema de selección es muy básico. No considera las variables de relación individual.

---

## COHERENCIA DISEÑO VS IMPLEMENTACIÓN

### Ranking de Coherencia:

| Personaje | Coherencia | Notas |
|-----------|------------|-------|
| Diego | 98% | Casi perfecto |
| Ixchel | 97% | Excelente integración cultural |
| Elena | 95% | Falta inundación del 59 |
| Sofía | 92% | Padre de hijos ausente |
| Juan | 90% | Changas técnicas sub-desarrolladas |
| Marcos | 88% | Ex-esposa y Paraninfo faltan |
| Claudia | 85% | Funcional pero plana |
| Tiago | 80% | INAU poco desarrollado |
| Bruno | 75% | Aparece poco, origen no contado |
| Cacho | 70% | Arco de redención débil |
| Lucía | 65% | Muy subdesarrollada |

### Elementos del Diseño NO Implementados:

| Personaje | Elemento Faltante |
|-----------|-------------------|
| Elena | Inundación del 59 |
| Sofía | Matías (padre de hijos), Martín como personaje |
| Marcos | Ex-esposa Claudia (distinta de auditora), Asamblea Paraninfo |
| Juan | Historia del robo de moto, changa en mansión |
| Lucía | Conflicto machirulaje PIT-CNT, historia personal completa |
| Tiago | Desarrollo historia INAU, abuela/tía que lo cría |
| Bruno | Historia de origen (ex-policía), fotos con diputados |
| Cacho | Desarrollo intermedio del arco |

---

## NPCS QUE NECESITAN DESARROLLO

### PRIORIDAD ALTA 🔴

#### 1. LUCÍA
**Problema:** Es un personaje con enorme potencial (feminismo sindical, pragmatismo vs idealismo, puente entre mundos) pero está reducida a dar información.

**Necesita:**
- Historia personal (¿por qué dejó la carrera? ¿qué la radicalizó?)
- Conflicto con machirulaje sindical como escena
- Fragmentos nocturnos adicionales
- Escena de quiebre emocional
- Interacción más profunda con Sofía

#### 2. TIAGO
**Problema:** El arco existe pero el desarrollo intermedio es insuficiente. Pasa de "desconfiado" a "se abre" muy rápido.

**Necesita:**
- 2-3 escenas intermedias de construcción de confianza
- Desarrollo de historia INAU (flashback o conversación)
- Más fragmentos nocturnos
- Escena con la abuela/tía que lo cría
- Momento de logística donde demuestra competencia

### PRIORIDAD MEDIA 🟡

#### 3. BRUNO
**Problema:** Es el antagonista principal pero aparece poco. Su amenaza es más narrativa que presente.

**Necesita:**
- Escena de origen (cómo se hizo "apóstol")
- Escena en la chacra (mostrar el "modelo")
- Interacción con más personajes (no solo Tiago y Sofía)
- Conexiones políticas como escena (no solo mención)

#### 4. CACHO
**Problema:** Es alivio cómico pero sin arco real. La redención es demasiado condicional.

**Necesita:**
- Momento de humanización más accesible
- Historia de cómo llegó a esto (¿qué pasó con la herencia?)
- Interacción significativa con otro personaje
- Arco de "contribución torpe pero real"

#### 5. CLAUDIA
**Problema:** Es puramente funcional. No tiene dimensión humana.

**Necesita:**
- Fragmento nocturno más desarrollado (la presión que recibe)
- Un momento de duda o humanidad
- Opcional: historia personal breve

### PRIORIDAD BAJA 🟢

#### 6. MARCOS
**Necesita:**
- Escena con ex-esposa (o mención más desarrollada)
- Referencia al Paraninfo

#### 7. JUAN
**Necesita:**
- Escena del robo de la moto como flashback
- Más desarrollo de changas técnicas

---

## PROPUESTAS DE MEJORA

### POR PERSONAJE:

#### LUCÍA - Expansión Completa

```ink
// Nueva escena: Historia personal de Lucía
=== lucia_historia_personal ===
Lucía te cuenta de cuando dejó la facultad.

"Estaba en tercer año de Relaciones Laborales. 
Trabajaba en un call center para pagar los cursos."

* [...]
-

"Un día el supervisor me llamó 'histérica' en una reunión 
porque pedí que respetaran los descansos."

"¿Qué hiciste?"

"Organicé a las compañeras. Hicimos un paro de brazos caídos.
Me rajaron a la semana."

* [...]
-

"Pero antes de irme, conseguimos los descansos.
Ahí entendí que los derechos no se piden, se arrancan."

~ subir_conexion(1)
~ lucia_relacion += 1
->->
```

```ink
// Nueva escena: Conflicto con machirulaje
=== lucia_machirulaje ===
Lucía está furiosa.

"¿Sabés qué me dijeron hoy en la reunión del gremio?"

"¿Qué?"

"Que 'las compañeras' podíamos encargarnos del acto del 8 de marzo.
Como si el feminismo fuera cosa nuestra y el salario fuera cosa de todos."

* ["¿Y qué les dijiste?"]
    "Les dije que el salario también es feminista.
    Que las que más ganan menos somos nosotras.
    Se quedaron callados."
    -> lucia_machirulaje_cont
* [Escuchar]
    -> lucia_machirulaje_cont

=== lucia_machirulaje_cont ===
"El problema no es el patrón solo.
Es que en el sindicato también mandan los mismos de siempre.
Tipos que hablan de igualdad y después se sirven primero."

Pausa.

"Por eso vengo acá. En la olla no hay jefes.
O si los hay, son minas que laburan el triple."

~ subir_dignidad(1)
->->
```

#### TIAGO - Desarrollo Intermedio

```ink
// Nueva escena: Tiago muestra competencia
=== tiago_logistica_crisis ===
La garrafa se terminó. A mitad del almuerzo.

Sofía entra en pánico.
"¿Y ahora qué hacemos? Hay treinta platos sin servir."

Tiago aparece.
"Yo me encargo."

* [...]
-

Desaparece quince minutos.
Vuelve con una garrafa llena.

"El de la ferretería me la fió.
Le dije que mañana le llevo los cajones que necesita."

Sofía lo mira.
"¿Negociaste un trueque?"

"Negocié supervivencia."

~ tiago_confianza += 2
~ subir_llama(1)
->->
```

```ink
// Nueva escena: Historia INAU
=== tiago_historia_inau ===
Es de noche. Están solos.

Tiago habla sin mirarte.

"¿Sabés qué es lo peor del INAU?"

"¿Qué?"

"Que te hacen sentir que sos el problema.
Como si hubieras elegido nacer donde naciste."

* [...]
-

"Había un educador, Javier. El único que me trataba como persona.
Un día me dijo: 'Tiago, vos no sos tu expediente'."

Pausa larga.

"Me escapé tres veces. Las tres me volvieron a agarrar.
La cuarta me 'egresaron'. Que es la forma elegante de decir
que ya no soy problema de ellos."

~ tiago_confianza += 1
~ subir_conexion(1)
->->
```

#### BRUNO - Presencia Aumentada

```ink
// Nueva escena: Origen de Bruno
=== bruno_origen ===
Estás solo. Bruno te encuentra.

"¿Sabés cómo empecé?"

No preguntaste. Pero él quiere contar.

"Fui policía quince años. Brigada antidrogas.
Vi de todo. Hice de todo."

* [...]
-

"Un día entré a un aguantadero a buscar un pibe.
Lo encontré muerto. Quince años.
Y algo se rompió adentro mío."

"¿Y qué hiciste?"

"Encontré a Dios. O Dios me encontró a mí."

* [...]
-

"Ahora hago lo que la policía no puede:
Salvo a los pibes antes de que se pierdan."

Su voz cambia. Más suave. Más peligrosa.

"¿Vos querés salvarlos o querés hacerte el bueno?"

~ bruno_tension += 1
->->
```

```ink
// Nueva escena: La chacra de Bruno
=== bruno_visita_chacra ===
Aceptás ir a ver "El Renacer".

La camioneta te lleva media hora fuera de Montevideo.
Portón de metal. Alambre de púa discreto.

Adentro: barracones, huerta, un galpón con bloques de cemento.

Pibes trabajando. En silencio. Sin mirar.

"Producción", dice Bruno. "Dignidad. Orden."

* [Observar a los pibes]
    Uno te mira un segundo. Hay algo en sus ojos.
    ¿Miedo? ¿Alivio? ¿Vacío?
    Bruno lo nota. El pibe baja la vista.
    ~ subir_dignidad(-1)
    -> bruno_chacra_cont
* [Preguntar por las condiciones]
    "¿Cuántas horas trabajan?"
    "Las que hagan falta para su rehabilitación."
    No es una respuesta.
    -> bruno_chacra_cont

=== bruno_chacra_cont ===
"Acá nadie te pregunta de dónde venís.
Solo te preguntamos si querés cambiar."

Te mira fijo.

"¿Vos querés cambiar?"

->->
```

#### CACHO - Humanización

```ink
// Nueva escena: La madre de Cacho
=== cacho_foto_madre ===
Estás en la casa de Cacho.
Entre la chatarra, ves una foto limpia.

Una mujer mayor, sonriendo.

"¿Quién es?"

Cacho se pone serio por primera vez.

"Mi vieja. Murió hace cinco años."

* [...]
-

"Ella sí que laburaba. Costurera.
Me crió sola. Con estas manos."

Mira las suyas. No son manos de trabajo.

"Yo le prometí que iba a ser alguien.
Mirá cómo cumplí."

* ["Todavía podés."]
    "¿Vos creés?"
    
    Por un segundo, no hay personaje.
    Solo un tipo asustado en una casa que se cae.
    
    ~ cacho_momento_real = true
    ->->
* [No decir nada]
    El silencio lo dice todo.
    ->->
```

### MEJORAS AL SISTEMA DE FRAGMENTOS

```ink
// Nuevo sistema de selección basado en relaciones
=== seleccionar_fragmento_dinamico(dia) ===
// Prioriza personajes con alta relación que no han tenido fragmento reciente

{dia == "viernes":
    {sofia_relacion >= 4 && not fragmento_sofia_mostrado:
        ~ fragmento_sofia_mostrado = true
        -> fragmento_sofia_cocina ->
    }
    {diego_relacion >= 4 && not fragmento_diego_mostrado:
        ~ fragmento_diego_mostrado = true
        -> fragmento_diego_llamada ->
    }
    // fallback
    -> fragmento_ciudad_noche ->
}
// etc para otros días
->->
```

### NUEVOS FRAGMENTOS NECESARIOS

```ink
// Fragmento adicional para Lucía
=== fragmento_lucia_sola ===
Lucía llega a su apartamento.
Compartido con una compañera que casi nunca está.

Se saca los zapatos. Le duelen los pies.
Ocho horas de pie. Más la reunión del gremio.

Abre la heladera. Medio tomate. Queso viejo.

"Para esto estudié", murmura.

Pero después piensa en las compañeras del call center.
En que ahora tienen descansos.
En que ella lo logró.

Se hace un té con el agua que sobró.
Mañana hay que seguir peleando.

->->
```

```ink
// Fragmento adicional para Tiago
=== fragmento_tiago_mensaje ===
Tiago mira el celular.
Un mensaje de un número desconocido.

"Tu vieja preguntó por vos."

El Vilardebó. Alguien le avisó.

No contesta.
¿Qué le va a decir?

Borra el mensaje.
Pero no puede borrar la culpa.

{tiago_se_queda:
    Piensa en la olla.
    Al menos ahí sirve para algo.
}

Se duerme con el celular apretado en la mano.
Por si suena.
No va a sonar.

->->
```

---

## CONCLUSIONES

### Fortalezas del Sistema Actual:
1. **Personajes principales muy sólidos** (Elena, Diego, Sofía, Ixchel)
2. **Sistema de relaciones mecánicamente funcional**
3. **Coherencia temática** entre diseño e implementación
4. **Fragmentos nocturnos potentes** para personajes principales
5. **Tensiones ideológicas bien articuladas** (Diego vs Marcos, Elena vs burocracia)

### Debilidades a Corregir:
1. **Desequilibrio de desarrollo** entre personajes principales y secundarios
2. **Lucía es la mayor pérdida** - personaje con enorme potencial desperdiciado
3. **Antagonistas planos** - Claudia y Bruno necesitan dimensión humana
4. **Desarrollo intermedio insuficiente** para Tiago y Cacho
5. **Sistema de fragmentos demasiado simple**

### Recomendaciones Prioritarias:

| Prioridad | Acción | Impacto |
|-----------|--------|---------|
| 1 | Expandir Lucía completamente | Alto |
| 2 | Agregar 2-3 escenas intermedias a Tiago | Alto |
| 3 | Aumentar presencia de Bruno | Medio-Alto |
| 4 | Humanizar a Claudia | Medio |
| 5 | Desarrollar arco de Cacho | Medio |
| 6 | Mejorar sistema de selección de fragmentos | Bajo-Medio |

### Estimación de Trabajo:
- **Lucía completa:** ~2000 palabras de contenido nuevo
- **Tiago desarrollo:** ~1500 palabras
- **Bruno expansión:** ~1500 palabras
- **Claudia humanización:** ~800 palabras
- **Cacho arco:** ~1000 palabras
- **Fragmentos adicionales:** ~500 palabras cada uno

**Total estimado:** ~8000-10000 palabras de contenido nuevo para equilibrar los arcos.

---

*Reporte generado para mejorar la narrativa de "Un Día Más"*
*Fecha: 2 de febrero de 2026*
