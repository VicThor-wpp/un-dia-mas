# PLAN DE ACTUALIZACIÓN Y POTENCIACIÓN DE NARRATIVAS

**Fecha de creación:** 2026-01-20
**Estado:** ✅ COMPLETADO
**Objetivo:** Actualizar las narrativas .ink basándose en los perfiles de personajes actualizados para mayor profundidad política y mejor balance.

---

## RESUMEN EJECUTIVO

Este documento rastrea la implementación de mejoras narrativas basadas en el análisis comparativo entre los perfiles de personajes documentados y las narrativas .ink actuales. El objetivo es cerrar las brechas identificadas, profundizar la dimensión política y mejorar el balance del juego.

---

## FASE 1: CORRECCIONES CRÍTICAS

### 1.1 Corregir inconsistencia de Sofía (hijos)
- **Archivo:** `ink/personajes/sofia.ink`
- **Problema:** El texto dice "tres hijos" pero el perfil especifica DOS hijos (Nico 12, Lupe 8)
- **Acción:** Cambiar referencias de "tres hijos" a "dos hijos"
- **Estado:** ✅ COMPLETADO (2026-01-20) - Corregido a "Dos hijos: Nico y Lupe" y ajustado fragmento nocturno

### 1.2 Expandir narrativa de Ixchel
- **Archivo:** `ink/personajes/ixchel.ink`
- **Problema:** Solo ~120 líneas, muy subdesarrollada respecto al perfil rico
- **Acciones:**
  - [x] Agregar escena `ixchel_historia_tomas` (hermano desaparecido)
  - [x] Agregar escena `ixchel_mina_marlin` (lucha contra extractivismo)
  - [x] Agregar escena `ixchel_llegada_uruguay` (choque cultural)
  - [x] Expandir fragmento nocturno con cosmovisión maya
  - [x] Agregar escena del huipil como identidad
  - [x] Agregar cosmovisión maya y sincretismo religioso
  - [x] Agregar interacciones con Elena, Diego y Juan
- **Estado:** ✅ COMPLETADO (2026-01-20) - Expandido de ~120 a ~500 líneas

### 1.3 Agregar historia de CECOSESOLA a Diego
- **Archivo:** `ink/personajes/diego.ink`
- **Problema:** La historia cooperativista apenas se menciona
- **Acciones:**
  - [x] Crear escena `diego_historia_cecosesola`
  - [x] Crear escena `diego_sobre_camion` (camión quemado)
  - [x] Agregar la libreta de semillas como objeto narrativo
  - [x] Mejorar fragmento nocturno con Premio Nobel Alternativo y franela
  - [x] Agregar tensión con Marcos (`diego_y_marcos`)
- **Estado:** ✅ COMPLETADO (2026-01-20) - Agregado ~230 líneas nuevas

---

## FASE 2: PROFUNDIZACIÓN POLÍTICA

### 2.1 Mejorar escenas de Elena
- **Archivo:** `ink/personajes/elena.ink`
- **Acciones:**
  - [x] Agregar escena `elena_sobre_la_chola` (amistad de 40 años)
  - [x] Agregar escena `elena_desalojo_garcia` (resistencia años 90)
  - [x] Agregar escena `elena_trueque_2002` (detalle del trueque)
  - [x] Agregar escena `elena_en_banco_2002` (escena del banco)
  - [x] Agregar escena `elena_anarquismo` (anarquismo visceral)
  - [x] Agregar tunnel `elena_frase_trinchera`
- **Estado:** ✅ COMPLETADO (2026-01-20) - Agregado ~270 líneas nuevas

### 2.2 Agregar hijos emigrados a Marcos
- **Archivo:** `ink/personajes/marcos.ink`
- **Acciones:**
  - [x] Crear escena `marcos_sobre_hijos` (Lucía y Martín en Europa)
  - [x] Agregar escena `marcos_sobre_zabalza` (referencia a Zabalza)
  - [x] Crear escena `marcos_noche_votos_2009`
  - [x] Agregar escena `marcos_sobre_voto_blanco`
  - [x] La tensión Diego-Marcos ya se agregó en diego.ink (`diego_y_marcos`)
- **Estado:** ✅ COMPLETADO (2026-01-20) - Agregado ~185 líneas nuevas

### 2.3 Desarrollar pasado sindical de Juan
- **Archivo:** `ink/personajes/juan.ink`
- **Acciones:**
  - [x] Crear escena `juan_recuerdo_marchas` (padre en PIT-CNT)
  - [x] Agregar escena `juan_sobre_laura` (esposa)
  - [x] Agregar escena `juan_fascinado_diego` (fascinación por historias migrantes)
  - [x] Agregar escena `juan_procesando` (procesamiento lento de ideas)
  - [x] Agregar escena `juan_sobre_miedo` (confronta su propio miedo)
- **Estado:** ✅ COMPLETADO (2026-01-20) - Agregado ~235 líneas nuevas

### 2.4 Agregar elementos faltantes a Sofía
- **Archivo:** `ink/personajes/sofia.ink`
- **Acciones:**
  - [x] Crear escena `sofia_sobre_madre` (muerte de la Chola)
  - [x] Crear escena `sofia_oferta_alemania` (beca rechazada)
  - [x] Agregar escena `sofia_martin_papas` (compañero Martín pelando papas)
  - [x] Agregar escena `sofia_catolicismo` (catolicismo práctico)
  - [x] Agregar escena `sofia_delantal_madre` (delantal de la Chola)
- **Estado:** ✅ COMPLETADO (2026-01-20) - Agregado ~215 líneas nuevas

---

## FASE 3: MEJORAS EN LA OLLA

### 3.1 Historia fundacional de la olla
- **Archivo:** `ink/ubicaciones/olla.ink`
- **Acciones:**
  - [x] Agregar escena `olla_historia_fundacion` (la Chola y la fundación)
  - [x] Agregar escena `olla_virgen_guadalupe` (imagen de la Virgen)
  - [x] Agregar escena `olla_grupo_whatsapp` (coordinación)
- **Estado:** ✅ COMPLETADO (2026-01-20)

### 3.2 Economía colectiva
- **Archivo:** `ink/ubicaciones/olla.ink`
- **Acciones:**
  - [x] Agregar escena `olla_sobre_donaciones` (cómo funcionan las donaciones)
  - [x] Agregar escena `olla_don_ruben` (almacén)
  - [x] Agregar escena `olla_verduleria_paraguayos` (verdulería)
  - [x] Agregar escena `olla_plan_abc` (Plan ABC de la Intendencia)
  - [x] Agregar escena `olla_caja_elena` (la caja de aportes)
- **Estado:** ✅ COMPLETADO (2026-01-20) - Agregado ~290 líneas nuevas

---

## SEGUIMIENTO DE IMPLEMENTACIÓN

| # | Tarea | Archivo | Estado | Notas |
|---|-------|---------|--------|-------|
| 1.1 | Corregir hijos Sofía | sofia.ink | ✅ | 2 hijos (Nico y Lupe) |
| 1.2a | Historia Tomás | ixchel.ink | ✅ | Hermano desaparecido |
| 1.2b | Mina Marlin | ixchel.ink | ✅ | Lucha anti-extractivismo |
| 1.2c | Llegada Uruguay | ixchel.ink | ✅ | SERPAJ/ACNUR |
| 1.2d | Fragmento nocturno | ixchel.ink | ✅ | Vela, copal, Tomás |
| 1.2e | Escena huipil | ixchel.ink | ✅ | Identidad invisible |
| 1.3a | CECOSESOLA | diego.ink | ✅ | Historia cooperativista |
| 1.3b | Libreta semillas | diego.ink | ✅ | Semillas venezolanas |
| 1.3c | Fragmento nocturno | diego.ink | ✅ | Premio Nobel Alternativo |
| 1.3d | Tensión con Marcos | diego.ink | ✅ | "¿Quién controla la orga?" |
| 2.1a | Elena + Chola | elena.ink | ✅ | 40 años de amistad |
| 2.1b | Desalojo García | elena.ink | ✅ | Resistencia años 90 |
| 2.1c | Trueque 2002 | elena.ink | ✅ | Ropa por leche |
| 2.1d | Anarquismo explícito | elena.ink | ✅ | "El de arriba caga al de abajo" |
| 2.2a | Hijos Marcos | marcos.ink | ✅ | Lucía y Martín en Europa |
| 2.2b | Ref. Zabalza | marcos.ink | ✅ | "Dice en voz alta lo que pienso" |
| 2.2c | Noche votos 2009 | marcos.ink | ✅ | Botín de cargos |
| 2.2d | Voto en blanco | marcos.ink | ✅ | Nueva escena agregada |
| 2.3a | Marchas padre Juan | juan.ink | ✅ | PIT-CNT en los hombros |
| 2.3b | Escenas Laura | juan.ink | ✅ | Esposa y miedo |
| 2.3c | Fascinación migrantes | juan.ink | ✅ | Diego "de película" |
| 2.3d | Procesamiento lento | juan.ink | ✅ | "El patrón nos explota a los dos" |
| 2.4a | Sofia + madre | sofia.ink | ✅ | Muerte de la Chola |
| 2.4b | Oferta Alemania | sofia.ink | ✅ | Beca rechazada |
| 2.4c | Martín pelando papas | sofia.ink | ✅ | "Más difícil que cromatografía" |
| 2.4d | Catolicismo | sofia.ink | ✅ | Virgen de Guadalupe |
| 3.1a | Historia Chola | olla.ink | ✅ | Fundación en los 90 |
| 3.1b | Virgen Guadalupe | olla.ink | ✅ | "Patrona de los pobres" |
| 3.1c | Grupo WhatsApp | olla.ink | ✅ | "Elena no tiene WhatsApp" |
| 3.2a | Donaciones | olla.ink | ✅ | Economía detallada |
| 3.2b | Don Rubén | olla.ink | ✅ | "Él también estuvo en la cola" |
| 3.2c | Verdulería paraguayos | olla.ink | ✅ | "Son de acá también" |
| 3.2d | Plan ABC | olla.ink | ✅ | "Arroz sin aceite" |

---

## NOTAS DE IMPLEMENTACIÓN

### Líneas agregadas por archivo:
- **ixchel.ink:** ~500 líneas (reemplazo total, era ~120)
- **diego.ink:** ~230 líneas nuevas
- **elena.ink:** ~270 líneas nuevas
- **marcos.ink:** ~185 líneas nuevas
- **juan.ink:** ~235 líneas nuevas
- **sofia.ink:** ~215 líneas nuevas + corrección de hijos
- **olla.ink:** ~290 líneas nuevas

### Total estimado: ~1,400+ líneas de nuevo contenido narrativo

### Variables nuevas agregadas:
- `diego_conto_cecosesola`, `diego_conto_camion`
- `ixchel_me_conto_de_tomas`, `ixchel_hablo_de_mina`, `ixchel_conto_llegada`, `ixchel_hablo_de_huipil`
- `elena_hablo_de_chola`, `elena_conto_desalojo`, `elena_conto_trueque`, `elena_conto_banco`, `elena_hablo_politica`
- `marcos_hablo_de_hijos`, `marcos_hablo_de_zabalza`, `marcos_conto_2009`, `marcos_conto_voto`
- `juan_recuerdo_padre`, `juan_hablo_de_laura`, `juan_proceso_algo`, `juan_hablo_de_miedo`
- `sofia_hablo_de_madre`, `sofia_hablo_de_alemania`, `sofia_hablo_de_martin`
- `escuche_historia_olla`

---

## HISTORIAL DE CAMBIOS

| Fecha | Cambio | Responsable |
|-------|--------|-------------|
| 2026-01-20 15:12 | Creación del plan | Claude |
| 2026-01-20 15:15 | FASE 1 completada | Claude |
| 2026-01-20 15:25 | FASE 2 completada | Claude |
| 2026-01-20 15:35 | FASE 3 completada | Claude |
| 2026-01-20 15:40 | **PLAN COMPLETADO** | Claude |

