# Escenas Post-Despido: Fantasmas del Laburo

**Fecha:** 2026-02-02  
**Archivo:** `prototype/ink/ubicaciones/laburo.ink`  
**Sección:** POST-DESPIDO: FANTASMAS DEL LABURO

## Resumen

Después del despido (miércoles), el protagonista no desaparece del mundo laboral. Estas escenas capturan los "fantasmas" del trabajo anterior — los encuentros incómodos, los recordatorios de lo que fue.

## Escenas Creadas

### 1. Pasar por el Edificio (`laburo_fantasma_edificio`)
**Trigger:** Viernes, caminando por el centro  
**Condición:** `fui_despedido == true`

- Caminás por la misma cuadra de siempre
- El edificio sigue ahí, pero ya no es tuyo
- Opciones:
  - **Seguir caminando** — el corazón se acelera igual
  - **Pararte un momento** — posible encuentro con Martínez
  - **Cruzar de vereda** — evitar es cuidarse

**Subescenas:**
- `laburo_fantasma_pasar_largo`
- `laburo_fantasma_pararte`
- `laburo_fantasma_martinez_ve` (si d6 >= 4)
- `laburo_fantasma_evitar`

### 2. Cruce con Ex-Compañero (`laburo_fantasma_cruce`)
**Trigger:** Jueves, en el barrio o bondi  
**Condición:** `fui_despedido == true`

- Encuentro casual con Fernández (ventas)
- La pregunta incómoda: "¿Cómo estás?"
- Opciones de respuesta:
  - **"Bien"** — mentira cómoda
  - **"Acá andamos"** — real, abre info sobre empresa
  - **"Como el orto"** — honesto, también abre info

**Información de la empresa:**
- Van a seguir despidiendo
- Gómez ya cayó
- Martínez en la lista
- Sensación: no sos el único, nunca lo fuiste

### 3. González en la Olla (Expandido) (`laburo_fantasma_gonzalez_olla`)
**Trigger:** Sábado en la olla, durante servicio  
**Condición:** `fui_despedido == true && vio_a_gonzalez == false`  
**Variable nueva:** `vio_a_gonzalez`

Expande la mención breve que ya existía en `olla_servir`.

- González de contabilidad aparece en la cola
- Momento de reconocimiento mutuo
- Opciones al servir:
  - **Normal** — lo justo, como a todos
  - **Darle más** — pedazo extra de carne

**La conversación:**
- "Nunca pensé que iba a terminar acá"
- Lo echaron dos semanas antes
- Tiene tres pibes, no les contó
- Sale de casa a las 8, camina todo el día, vuelve a las 6
- "Para que no sospechen"

**Tono:** Comunidad, no caridad. Reconocimiento entre pares.

### 4. Mensaje del Grupo de WhatsApp (`laburo_fantasma_grupo_whatsapp`)
**Trigger:** Sábado, momento de relax en casa  
**Condición:** `fui_despedido == true`

- El grupo "Equipo de Gestión" sigue activo
- Todavía estás ahí
- Opciones:
  - **Mirar** — ver la vida que sigue sin vos
  - **Ignorar** — protegerse

**Si mirás:**
- Conversaciones banales (archivos, cumpleaños)
- Tu último mensaje: un emoji de pulgar. Nadie contestó.
- ¿Salir del grupo?
  - **Salir** → nadie va a notar, +dignidad
  - **Quedarte mirando** → fantasma en el grupo, +inercia

## Integración en Días

| Día | Escena | Nota |
|-----|--------|------|
| Jueves | `laburo_fantasma_cruce` | Posible cruce con Fernández |
| Viernes | `laburo_fantasma_edificio` | Opcional, pasar por el edificio |
| Sábado | `laburo_fantasma_gonzalez_olla` | Durante servicio en olla |
| Sábado | `laburo_fantasma_grupo_whatsapp` | En casa, momento de relax |

## Variables

### Nuevas
- `vio_a_gonzalez` — para no repetir escena de González

### Usadas
- `fui_despedido` — condición para todas las escenas
- `energia` — no se usa directamente (escenas no cuestan energía)
- `inercia` — aumenta con encuentros difíciles
- `dignidad` — sube si salís del grupo

## Efectos Narrativos

1. **Sensación de no pertenecer** — El edificio sigue, vos no
2. **Solidaridad silenciosa** — González, el cruce incómodo
3. **La vida sigue sin vos** — El grupo de WhatsApp
4. **No sos el único** — Info de más despidos

## Notas de Diseño

- **Tono:** No melodramático. Real, seco, con toques de humor negro
- **González:** La escena más emotiva, pero sin sentimentalismo. La vergüenza de mentir a la familia, el ritual de salir "al trabajo"
- **El grupo:** Metáfora perfecta de exclusión. Seguís ahí pero ya no existís
- **Opciones de evitar:** Siempre válidas. A veces evitar es cuidarse

## Conexiones con Otros Archivos

- `olla.ink` ya tenía mención breve de González en `olla_servir` — esta escena expande ese momento
- La red de personajes del laburo (Martínez, Fernández, González) ahora tiene vida post-despido
