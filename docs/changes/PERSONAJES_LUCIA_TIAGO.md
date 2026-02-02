# Desarrollo de Personajes: Lucía y Tiago

> **Fecha:** 2026-02-02
> **Archivos modificados:**
> - `prototype/ink/personajes/lucia.ink`
> - `prototype/ink/personajes/tiago.ink`

---

## Resumen de Cambios

Se expandieron ambos personajes para darles más profundidad narrativa, historia personal y arcos de desarrollo.

---

## LUCÍA - Cambios

### Escenas Pre-Despido (Nuevas/Expandidas)
- **`lucia_escena_mate`**: Mantenida y mejorada (advertencia inicial)
- **`lucia_almuerzo_oficina`**: Mantenida (tensión pre-despido)
- **`lucia_no_firmes_sin_leer`** [NUEVA]: Te da una lista de derechos antes de irte. "No firmes nada que diga 'renuncia'. Nunca."

### Historia Personal [NUEVO]
- **`lucia_historia_carrera`**: Cuenta por qué dejó Relaciones Laborales
  - La madre se enfermó de lupus
  - Tuvo que elegir entre trabajar y estudiar
  - "Lo peor no fue dejar. Fue darme cuenta de que todo lo que estudié no sirve para nada si no tenés poder."

### Conflicto "Machirulaje" [NUEVO]
- **`lucia_machirulaje_reunion`**: Cuenta una reunión donde González la ignoró y Martínez repitió sus ideas
- **`lucia_machirulaje_en_vivo`**: Escena donde ves el machirulaje en acción (Ramiro le "roba" la idea)
  - Opción de intervenir para defenderla (+2 relación)

### Escenas Post-Despido (Nuevas/Expandidas)
- **`lucia_consejo_despido`**: Mantenida (consejo por teléfono)
- **`lucia_post_despido`**: Mantenida (te convoca al sindicato)
- **`lucia_ayuda_reclamo`** [NUEVA]: Te acompaña al MTSS aunque no sirva de mucho
  - "Honestamente? Capaz que no. Pero hay que hacerlo igual."

### Fragmentos Nocturnos [NUEVOS/EXPANDIDOS]
- **`fragmento_lucia_numeros`**: Expandido - Calcula cuánto se ahorró la empresa
  - "Un millón doscientos por cabeza. Ocho despedidos. Nueve millones seiscientos en carne humana."
- **`fragmento_lucia_insomnio`** [NUEVO]: A las 3am escribe una propuesta que nadie va a leer
  - Piensa en González, en su madre, en la olla

### Sistema de Variables
- `lucia_relacion`: 0-5 (aumenta con interacciones)
- `lucia_consejo_sindical`: boolean
- `lucia_historia_conocida`: boolean (contó por qué dejó la carrera)
- `lucia_sigue_luchando`: boolean (sigue activa post-domingo)

---

## TIAGO - Cambios

### Sistema de Confianza [NUEVO]
Progresión clara en 6 niveles (variable `tiago_confianza`):
- **0** = Desconfianza total (recién llegado)
- **1** = Te tolera (ayudaste una vez)
- **2** = Te observa (no le fallaste)
- **3** = Te prueba (te cuenta algo personal)
- **4** = Te acepta (defendiste algo suyo)
- **5** = Confianza real (lealtad)

### Primer Encuentro (Expandido)
- **`tiago_primer_encuentro`**: Mejorado con más opciones de respuesta
- **`tiago_prueba_inicial`** [NUEVO]: Te pone a prueba con trabajo físico
  - "¿Podés o es mucho?"
  - Si lo hacés sin quejarte: +1 confianza

### Competencia de Logística [NUEVO]
- **`tiago_logistica_problema`**: Hay 100kg de harina y no hay dónde guardarla
- **`tiago_resuelve_logistica`**: Tiago propone armar tarima con palets
- **`tiago_consigue_materiales`**: Van juntos a buscar materiales
  - "Cuando vivís en la calle, aprendés dónde hay cosas."
  - +2 confianza si le preguntás

### Historia INAU [NUEVO]
- **`tiago_historia_inau`**: Cuenta qué es lo peor del sistema
  - "Te acostumbrás a que nadie se quede. Y cuando salís... no sabés cómo es que alguien se quede."
- **`tiago_recuerdo_hogar`**: Fragmento del hogar de Colón
  - Cuchetas de metal, olor a lavandina
  - "Se portó bien y lo movieron igual. Tres hogares en cuatro años."

### Relación con Bruno [NUEVO]
- **`bruno_presiona_tiago`**: Ves a Bruno con Tiago en la camioneta
  - Opción de intervenir y "rescatarlo"
- **`bruno_oferta_chacra`**: Bruno le ofrece la chacra directamente
- **`tiago_duda_chacra`**: Tiago duda entre irse o quedarse
  - "En el INAU me prometieron muchas cosas. Nunca cumplieron."

### Fragmentos Nocturnos [NUEVOS]
- **`fragmento_tiago_techo`**: Expandido (mirando el barrio desde arriba)
- **`fragmento_tiago_hambre`** [NUEVO]: No comió porque llegó tarde
  - "El hambre es vieja conocida."
  - "Mañana va a llegar temprano. Va a ganarse el plato."

### Finales (Expandidos)
- **`tiago_final_red`** [NUEVO]: En final "La Red", Tiago es parte del equipo
  - "Mañana capaz que vienen más. Hay que conseguir más papas."
  - Primera vez que sonríe
- **`tiago_final_solo`** [NUEVO]: En final "Solo", aparece en el noticiero
  - "Joven de 16 años detenido en operativo antidrogas."
  - "El sistema cumplió su profecía."

### Sistema de Variables
- `tiago_confianza`: 0-5 (con etapas claras)
- `tiago_estado`: "presente" | "ido" | "capturado"
- `tiago_historia_inau`: boolean
- `tiago_se_queda`: boolean
- `tiago_captado_por_bruno`: boolean

---

## Integración Narrativa

### Lucía
- Funciona como **puente entre el mundo formal (sindicato) y el informal (olla)**
- Su historia personal explica su pragmatismo: sabe que la teoría no alcanza
- El machirulaje la empuja hacia espacios donde la escuchen (la olla, el barrio)
- Los fragmentos nocturnos muestran que su lucha es constante, no solo de día

### Tiago
- La progresión de confianza permite **desarrollo gradual** (no pasa de desconfiado a amigo en una escena)
- La competencia de logística establece su **valor concreto** para la comunidad
- La historia del INAU explica su desconfianza sin victimizarlo
- La presión de Bruno crea **tensión dramática** con consecuencias reales

### Conexiones entre personajes
- Lucía puede aparecer en la olla (escena `lucia_en_olla`)
- Ambos comparten el espacio de la asamblea (si ocurre)
- Los dos representan respuestas diferentes a la Inercia:
  - Lucía: organización pragmática
  - Tiago: agencia micro (decidir día a día)

---

## Pendientes / Ideas futuras

1. **Escena cruzada Lucía-Tiago**: Podrían interactuar directamente (ella lo defiende, o él le consigue algo)
2. **Lucía en el ministerio**: Escena más desarrollada del proceso burocrático
3. **Tiago enseña algo**: Escena donde Tiago enseña alguna habilidad práctica al protagonista
4. **Historia de la madre de Tiago**: Fragmento o visita (muy difícil emocionalmente)

---

*Documento generado: 2026-02-02*
