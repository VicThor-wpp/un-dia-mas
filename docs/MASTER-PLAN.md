# UN DÍA MÁS - Source of Truth (Consolidado)

> **Fecha Última Actualización:** 2026-01-29
> **Estado:** Implementación Completada (Fase 1 y Fase 2)
> **Versión:** Prototype v1.1

---

## 1. DEFINICIÓN DEL SISTEMA

### Filosofía Central: Realismo Capitalista y Agencia
El juego evita patologizar el malestar. No usa "Salud Mental" (individual), sino **INERCIA** (estructural).
La lucha del jugador no es por "ser feliz", sino por mantener la **agencia** (capacidad de actuar) frente a un sistema diseñado para inducir pasividad ("Impotencia Reflexiva" de Mark Fisher).

### Variables Canónicas (Implementadas)

| Variable | Valor Inicial | Rango | Lógica | Significado |
|----------|---------------|-------|--------|-------------|
| `energia` | 4 | 0-6 | Gasto diario | Capacidad de acción. Si 0 → Agotado. |
| `conexion` | 3 | 0-10 | Sube = Mejor | Integración en el tejido social. Si ≤3 → Aislado. |
| `llama` | 5 | 0-10 | Sube = Mejor | Esperanza colectiva. Si 0 → Game Over (Colapso Social). |
| `dignidad` | 5 | 0-10 | Sube = Mejor | Autoestima política. Si baja, acelera Inercia. |
| `inercia` | 5 | 0-10 | **Sube = PEOR** | Resistencia al cambio. Si 10 → Game Over (Apagado). |

### Mecánica de Inercia
- **0-3 (Despierto):** Agencia total. Opciones radicales disponibles.
- **4-7 (Automático):** Estado normal de desgaste.
- **8-9 (Parálisis):** Opciones bloqueadas. Riesgo de Final Gris.
- **10 (Apagado):** El personaje se convierte en autómata. Fin del juego.

---

## 2. NARRATIVA CANÓNICA

### Premisa Laboral: La Unipersonal Forzada
El protagonista no es un empleado formal despedido con indemnización. Es un **falso autónomo** ("unipersonal") al que le rescinden el contrato.
- **Consecuencia:** Cero indemnización, cero seguro de paro.
- **Urgencia:** Inmediata desde el miércoles a las 11:00 AM.

### Personajes y Arcos (Completados)

| NPC | Rol | Arco Implementado |
|-----|-----|-------------------|
| **Sofía** | Sostén de la Olla | Crisis de recursos el viernes. Depende de tu ayuda para no colapsar. |
| **Elena** | Memoria (2002) | Enseña que "pedir ayuda no es debilidad". Conecta pasado y presente. |
| **Diego** | El Migrante | Cooperativismo (CECOSESOLA). Tensión solidaridad vs. supervivencia. |
| **Marcos** | El Quemado | Aislado hasta el sábado. Espejo del protagonista (también despedido). |
| **Ixchel** | Resistencia Ancestral | Cosmovisión maya. "Tejer" comunidad. Final alternativo `final_tejido`. |
| **Juan** | El Migrante | Decide irse a España con Laura (`juan_migra`). Contraste temático con Diego/Ixchel que vinieron. |

## Fase 2: Antagonistas y Secundarios (COMPLETADA)

### Personajes Integrados

| Personaje | Rol | Días Activo | Arco Completo |
|-----------|-----|-------------|---------------|
| Lucía | Sindicalista pragmática | L, M, V, S, D | Organización vs institucionalización |
| Tiago | Pibe vulnerable (INAU) | J, V, S, D | Captación por Bruno vs comunidad |
| Cacho | Emprendedor iluso | J, V, S, D | Delirio vs momento de realidad |
| Bruno | Fascista territorial | J, V, S, D | Amenaza a la olla y captación de vulnerables |
| Claudia | Auditora estatal | V, S, D | Violencia administrativa vs resistencia |

### Escenas por Personaje

**Lucía:**
- lucia_escena_mate (Lunes)
- lucia_almuerzo_oficina (Martes)
- lucia_post_despido (Jueves)
- lucia_explica_unipersonal (Viernes) - **NUEVO**: Explica por qué el sindicato no puede ayudar a unipersonales
- lucia_en_olla (Viernes)
- lucia_en_asamblea (Sábado)
- lucia_cierre_domingo (Domingo)

**Tiago:**
- tiago_primer_encuentro (Jueves)
- tiago_conflicto_comida (Viernes)
- tiago_se_abre (Sábado)
- tiago_decision_final (Sábado)
- tiago_en_asamblea (Sábado)
- tiago_domingo (Domingo)

**Cacho:**
- cacho_oferta_negocio (Jueves)
- cacho_casa (Jueves)
- cacho_en_la_fila (Viernes)
- cacho_sin_olla (Sábado)
- cacho_redencion (Domingo)
- cacho_domingo (Domingo)

**Bruno:**
- bruno_primer_encuentro (Jueves)
- bruno_la_visita (Jueves)
- bruno_confronta_sofia (Viernes)
- bruno_recluta_tiago (Sábado)
- bruno_oferta_protagonista (Sábado)
- bruno_amenaza_olla (Sábado)
- bruno_domingo (Domingo)

**Claudia:**
- claudia_llegada (Viernes)
- claudia_la_auditoria (Viernes)
- claudia_amenaza_final (Viernes)
- claudia_el_tupper (Viernes)
- claudia_segundo_round (Sábado)
- claudia_domingo (Domingo)

### Escenas de Profundidad Emocional (2026-01-29)

**Nuevas escenas que agregan vulnerabilidad y momentos de impacto:**

| Escena | Archivo | Trigger | Descripción |
|--------|---------|---------|-------------|
| `sofia_momento_quiebre` | sofia.ink | sofia_relacion >= 3, ayude_en_olla | Sofía admite que no puede más. Revela el peso de la Chola. |
| `protagonista_pide_ayuda` | elena.ink | elena_relacion >= 2, inercia >= 4 | El protagonista se quiebra y pide ayuda a Elena. |
| `asamblea_momento_colectivo` | olla.ink | participe_asamblea | Votación dramatizada con canto de murga emergente. |
| `juan_despedida_migracion` | juan.ink | juan_relacion >= 2 | Juan se despide: migra a España con Laura. |

**Sistema de pacing:** 75 tags `# PAUSA` distribuidos en escenas clave para ritmo dramático.

### Finales Fase 2 (Balanceados)

| Final | Requisitos |
|-------|------------|
| final_huelga | llama >= 6, conexion >= 6, veces_que_ayude >= 2, participe_asamblea, diego_relacion >= 4 |
| final_ocupacion | llama >= 6, conexion >= 6, veces_que_ayude >= 2, participe_asamblea |
| final_represion | llama >= 5, conexion >= 5, participe_asamblea, diego_relacion < 4 |
| final_desercion | conexion >= 5, inercia <= 4, NOT tiene_laburo |

---

## 3. ESTRUCTURA DE JUEGO (7 DÍAS)

- **Lunes:** Normalidad amenazada. Rumores.
- **Martes:** Tensión creciente. El jefe evita miradas.
- **Miércoles (11:00 AM):** **EL DESPIDO**. Punto de quiebre. Decisión: ¿Aislamiento o Barrio?
- **Jueves:** Primer día sin estructura. **Decisión Crítica:** ¿Ayudar en la Olla? (Puerta a final LA RED).
- **Viernes:** Crisis de la Olla. Faltan recursos. Decisión moral: ¿Pedir en la calle?
- **Sábado:** La Asamblea. Clímax político. Única chance de recuperar a Marcos.
- **Domingo:** Resolución. Evaluación de finales según stats acumulados.

---

## 4. SISTEMA DE FINALES (19 Implementados)

El juego evalúa condiciones en orden de prioridad en `domingo.ink`:

1.  **APAGADO** (`inercia >= 10`): Colapso de agencia. Game Over temprano posible.
2.  **SIN LLAMA** (`llama <= 0`): Colapso del tejido social. Game Over temprano posible.
3.  **TEJIDO** (Ruta Ixchel): Requiere relación profunda con Ixchel y valores comunitarios.
4.  **LA LLAMA** (Oculto/Perfecto): Requiere `conexion` y `llama` altas + Ideas desbloqueadas.
5.  **LUCHA COLECTIVA**: Participación activa en asamblea y ayuda constante.
6.  **LA RED** (Victoria Estándar): `conexion >= 5` + Ayuda en olla.
7.  **VULNERABILIDAD HONESTA**: Abrirse emocionalmente pese al dolor.
8.  **SOLO** (Derrota Aislamiento): `conexion` y `llama` bajas.
9.  **GRIS** (Derrota Depresión): `inercia` alta, conexión media-baja.
10. **RESISTENCIA SILENCIOSA**: Ayuda constante sin exposición política.
11. **DESPERTAR**: Recuperación tras tocar fondo.
12. **JUAN MIGRANTE**: Arco de despedida de Juan.
13. **Y otros finales intermedios (Incierto, Quizás, Pequeño Cambio).**

---

## 5. ESTADO TÉCNICO

### Infraestructura
- **Motor:** Ink + Web Runtime (Vanilla JS).
- **Tests:** Suite de tests narrativos (`npm run test:endings`) para verificar alcanzabilidad de finales.
- **Auditoría:** Script de detección de variables huérfanas (`npm run audit`).
- **Build:** `npm run build` compila Ink a JSON y genera el wrapper JS.

### Mejoras Recientes (Enero 2026)
- **Sistema de Ecos:** Las decisiones del día anterior se reflejan en el texto del amanecer siguiente.
- **Feedback Visual:** El CSS reacciona a estados altos/bajos de `conexion` y `llama` (no solo salud).
- **Selección de Vínculo:** Reemplazada lista plana por "Escenas Trigger" emocionales al inicio.
- **Save System:** Corregido bug de bloqueo permanente en early returns.

---

## 6. MAPA DE ARCHIVOS (Dónde está qué)

```
docs/
├── MASTER-PLAN.md              (Este archivo)
├── design/                     (Mecánicas, Narrativa, Flowcharts)
├── reference/                  (Análisis, Quick Refs)
├── archive/                    (Documentación antigua/obsoleta)
└── plans/                      (Planes de implementación específicos)

prototype/ink/
├── main.ink                    (Entry point)
├── variables.ink               (TODAS las variables declaradas aquí)
├── mecanicas/
│   ├── recursos.ink            (Lógica de Inercia, Llama, Conexión)
│   └── dados.ink               (Sistema de azar)
├── dias/                       (Flujo temporal Lunes-Domingo)
├── personajes/                 (Contenido específico de NPCs)
└── finales/                    (Texto de los 16 finales)
```

---

*Este documento es la referencia actual del proyecto. Cualquier cambio mayor debe reflejarse aquí.*