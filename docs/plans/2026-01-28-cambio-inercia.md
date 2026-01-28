# Reporte de Implementación: De Salud Mental a Inercia

**Fecha:** 28 de enero de 2026
**Estado:** Completado

## 1. Resumen del Cambio

Se ha reemplazado integralmente el sistema de **"Salud Mental"** (0-5, donde bajo es malo) por el sistema de **"Inercia"** (0-10, donde alto es malo).

Este cambio responde a una crítica fundamental sobre el diseño original: la representación de la crisis como una patología individual ("estoy enfermo") en lugar de una condición estructural ("el sistema me impide actuar").

## 2. Fundamentación Teórica (Mark Fisher)

Basado en el concepto de **Realismo Capitalista** y la **Impotencia Reflexiva**:

> "Sabemos que las cosas están mal, pero sentimos que no podemos hacer nada."

La **Inercia** modela esta parálisis. No es que el personaje "pierda cordura", es que pierde **agencia**. El sistema lo desgasta hasta convertirlo en un autómata (zombi) que solo puede elegir opciones de conformidad.

## 3. Nueva Mecánica: INERCIA

- **Rango:** 0 a 10.
- **Valor Inicial:** 5 (Estado normal de desgaste).
- **Dirección:**
    - **Subir (+):** Es MALO. Aumenta la resistencia al cambio. (Ej: Despido, aislamiento, burocracia).
    - **Bajar (-):** Es BUENO. Recupera agencia. (Ej: Conexión genuina, acción colectiva).

### Estados
- **0-3 (Despierto):** Agencia total. Ventaja en chequeos mentales. Acceso a opciones radicales.
- **4-7 (Automático):** Estado estándar. Sobrevivencia.
- **8-9 (Parálisis):** Desventaja en chequeos. El mundo se vuelve gris.
- **10 (Apagado):** GAME OVER. El personaje se rinde completamente al sistema.

## 4. Cambios Realizados

### Código (Ink)
- Reemplazo global de `salud_mental` y `peso_estructural` por `inercia`.
- Reemplazo de `bajar_salud_mental(x)` por `aumentar_inercia(x)`.
- Reemplazo de `subir_salud_mental(x)` por `disminuir_inercia(x)`.
- Inversión de lógica en chequeos: `{inercia >= 8}` es ahora la condición de fallo/gris.

### Interfaz (Web)
- Nuevo ícono: Ancla (`anchor`).
- Nuevo color: Gris azulado (`#607d8b`).
- Feedback visual: "Parálisis" cuando la inercia es alta.

### Narrativa
- **Final Gris:** Ahora se dispara con Inercia Alta (≥8).
- **Final Apagado:** Se dispara con Inercia Máxima (10).
- **Asamblea (Sábado):** La comprensión política ("No es culpa mía") ahora es accesible si el jugador tiene **Baja Inercia** (está despierto), premiando la gestión de la agencia sobre el azar.

## 5. Estado Actual

El juego ahora es mecánicamente consistente con su tesis narrativa. La lucha no es por "no estar triste", es por **mantener la capacidad de actuar** frente a un sistema que induce pasividad.
