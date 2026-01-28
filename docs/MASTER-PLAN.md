# UN DÍA MÁS - Source of Truth (Consolidado)

> **Fecha Última Actualización:** 2026-01-28
> **Estado:** Implementación Completada (Fase 1)
> **Versión:** Prototype v1.0

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
| **Juan** | El Testigo | Compañero que se queda. Representa la culpa del sobreviviente. |

---

## 3. ESTRUCTURA DE JUEGO (7 DÍAS)

- **Lunes:** Normalidad amenazada. Rumores.
- **Martes:** Tensión creciente. El jefe evita miradas.
- **Miércoles (11:00 AM):** **EL DESPIDO**. Punto de quiebre. Decisión: ¿Aislamiento o Barrio?
- **Jueves:** Primer día sin estructura. **Decisión Crítica:** ¿Ayudar en la Olla? (Bloquea final LA RED).
- **Viernes:** Crisis de la Olla. Faltan recursos. Decisión moral: ¿Pedir en la calle?
- **Sábado:** La Asamblea. Clímax político. Única chance de recuperar a Marcos.
- **Domingo:** Resolución. Evaluación de finales según stats acumulados.

---

## 4. SISTEMA DE FINALES (Implementados)

El juego evalúa condiciones en orden de prioridad en `domingo.ink`:

1.  **APAGADO** (`inercia >= 10`): Colapso de agencia. Game Over temprano posible.
2.  **SIN LLAMA** (`llama <= 0`): Colapso del tejido social. Game Over temprano posible.
3.  **TEJIDO** (Ruta Ixchel): Requiere relación profunda con Ixchel y valores comunitarios.
4.  **LA LLAMA** (Oculto/Perfecto): Requiere `conexion` y `llama` muy altas + todas las Ideas desbloqueadas.
5.  **LUCHA COLECTIVA**: Participación activa en asamblea y ayuda constante.
6.  **LA RED** (Victoria Estándar): `conexion >= 7` + Ayuda en olla.
7.  **VULNERABILIDAD HONESTA**: Abrirse emocionalmente pese al dolor.
8.  **SOLO** (Derrota Aislamiento): `conexion` y `llama` bajas.
9.  **GRIS** (Derrota Depresión): `inercia` alta, conexión media-baja.
10. **PEQUEÑO CAMBIO / QUIZÁS / INCIERTO**: Finales intermedios.

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
└── finales/                    (Texto de los 12 finales)
```

---

*Este documento es la referencia actual del proyecto. Cualquier cambio mayor debe reflejarse aquí.*