# PLAN DE IMPLEMENTACIÓN: EXPANSIÓN DEL ELENCO Y SISTEMA NOCTURNO

> **Fecha:** 2026-01-28
> **Objetivo:** Implementar 5 nuevos personajes y profundizar el sistema de Ideas Nocturnas.

---

## 1. ARQUITECTURA TÉCNICA
Primero, necesitamos los cimientos.

### Archivos Nuevos
*   `prototype/ink/personajes/lucia.ink` (Ya existe esqueleto, hay que llenarlo)
*   `prototype/ink/personajes/tiago.ink`
*   `prototype/ink/personajes/cacho.ink`
*   `prototype/ink/personajes/bruno.ink`
*   `prototype/ink/personajes/claudia.ink`

### Variables Nuevas (variables.ink)
*   **Relaciones:** `lucia_relacion`, `tiago_confianza`, `cacho_deuda`, `bruno_tension`, `claudia_hostilidad`.
*   **Flags de Estado:**
    *   `lucia_consejo_sindical` (true/false)
    *   `tiago_captado_por_bruno` (true/false - *Bad Ending para Tiago*)
    *   `cacho_estafado` (true/false)
    *   `lista_entregada` (true/false - *Decisión Claudia*)
*   **Nuevas Ideas:**
    *   `idea_organizacion_real` (Lucía)
    *   `idea_orden_autoritario` (Bruno)
    *   `idea_salvacion_individual` (Cacho)
    *   `idea_numero_frio` (Claudia - Cinismo burocrático)

---

## 2. INTEGRACIÓN EN LA LÍNEA DE TIEMPO

### LUNES / MARTES (El Trabajo)
*   **LUCÍA:** Insertar escenas en `laburo.ink`.
    *   *Escena:* El mate en la oficina. Lucía advierte sobre la "limpieza".
    *   *Opción:* ¿Escucharla (sube Inercia a corto plazo por miedo, baja a largo plazo por info) o ignorarla?

### JUEVES (La Tentación)
*   **CACHO:** Insertar en `barrio.ink`.
    *   *Escena:* Te cruza cuando vas a buscar trabajo. Te ofrece un "negocio": vender celulares bloqueados o perfumes falsos.
    *   *Riesgo:* Ganás plata rápida (Dignidad baja, Inercia sube).

### VIERNES (El Asedio - Día Clave)
*   **CLAUDIA:** Insertar en `olla.ink` (Evento Principal).
    *   *Escena:* La Auditoría. Claudia bloquea la cocina.
    *   *Conflicto:* Tiago quiere repetir plato. Claudia lo niega.
    *   *Decisión:* Entregar la lista (traicionar a Ixchel/Diego) o echar a Claudia (perder insumos secos).

*   **EL APÓSTOL BRUNO:** Insertar en `barrio.ink` (Evento Secundario).
    *   *Escena:* La 4x4 estacionada. Bruno reclutando gente afuera de la olla cerrada/en crisis.
    *   *Interacción:* Si la olla falló con Claudia, Bruno te ofrece "ayuda" a cambio de lealtad.

### SÁBADO (La Disputa)
*   **TIAGO vs BRUNO:** Desenlace del arco de Tiago.
    *   Si ayudaste en la Olla: Tiago está cargando cajones (logística).
    *   Si la Olla falló: Tiago no está. Se fue a "El Renacer" con Bruno.

---

## 3. SISTEMA DE "REFLEXIONES NOCTURNAS" (Gabinete del Pensamiento)

Actualmente, los fragmentos son pasivos (solo lees). Vamos a convertirlos en una **mecánica activa de asimilación de Ideas**.

### Nueva Estructura del Nodo `noche`
Al final de cada día, antes de dormir, el cerebro del protagonista procesa lo vivido.

**Mecánica:**
1.  **El Eco:** Aparece una frase dicha por un NPC ese día.
2.  **La Asimilación:** El jugador elige cómo interpretar esa frase.
3.  **El Resultado:** Se desbloquea/fortalece una IDEA o cambia un STAT.

### Ejemplo Práctico (Viernes Noche)

Si te cruzaste con Claudia (La Burócrata):

```ink
=== viernes_noche_reflexion ===
Te acostás. Cerrás los ojos.
Todavía escuchás la voz de Claudia.
"Una cédula, un plato. Sin registro no hay comida."

Es cruel. Pero el sistema es así.

* [Pensar: "Tiene razón. Sin orden no se puede."]
    Asimilás la lógica del sistema.
    Es más fácil obedecer que pelear.
    ~ aumentar_inercia(1)
    ~ unlock_idea(idea_numero_frio)

* [Pensar: "Es violencia. El hambre no tiene cédula."]
    La rabia no te deja dormir.
    Pero te mantiene despierto.
    ~ disminuir_inercia(1)
    ~ subir_dignidad(1)
```

Si te cruzaste con Cacho (El Heredero):

```ink
=== jueves_noche_reflexion ===
Cacho dijo que el mes que viene "la pega".
Siempre dice eso.

* [Pensar: "Pobre iluso."]
    Sabés que no hay salida mágica.
    ~ subir_conexion(1) // Te aferrás a lo real

* [Pensar: "¿Y si tiene razón? ¿Y si soy yo el gil?"]
    La duda entra.
    Quizás vos te estás hundiendo por no ser "vivo".
    ~ aumentar_inercia(1)
    ~ unlock_idea(idea_salvacion_individual)
```

---

## 4. RUTAS DE IMPLEMENTACIÓN

### Fase 1: Los Aliados (Lucía y Tiago)
Son más fáciles de integrar porque suman a la Olla existente.
1.  Escribir `lucia.ink` y `tiago.ink`.
2.  Conectarlos en `main.ink`.
3.  Agregar a Lucía en `dias/lunes.ink` y `dias/martes.ink`.
4.  Agregar a Tiago en `ubicaciones/olla.ink`.

### Fase 2: Los Antagonistas (Bruno y Claudia)
Requieren lógica condicional compleja en el Viernes.
1.  Escribir `bruno.ink` y `claudia.ink`.
2.  Reescribir el evento de crisis en `dias/viernes.ink` para que Claudia sea el detonante.

### Fase 3: El Sistema Nocturno
1.  Crear `mecanicas/sistema_ideas.ink`.
2.  Modificar los cierres de día (`transicion_X_Y`) para llamar a este sistema antes de los fragmentos de NPCs.

---

## 5. NOTAS DE TONO

*   **Tiago:** No debe sonar a "pobre víctima". Debe tener calle, ser desconfiado, usar silencios.
*   **Bruno:** No debe ser una caricatura de villano. Debe sonar "razonable" y "ordenado" para alguien desesperado. Su maldad es que ofrece esclavitud disfrazada de salvación.
*   **Claudia:** No debe gritar. Su violencia es el silencio administrativo y la mirada de superioridad moral.
