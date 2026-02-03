# PROPUESTA DE EXPANSIÓN: MECÁNICAS DE AMBIENTE, PENSAMIENTO Y UX

Este documento detalla la expansión de los pilares 2 (Gabinete de Pensamiento), 3 (Uruguay Gris) y 5 (Pulido Técnico/UX).

---

## 1. EL GABINETE DEL PENSAMIENTO (DIÁLOGO INTERNO)

### Filosofía
Las ideas no solo afectan números, sino que **comentan** la realidad. Cada idea tendrá un "Trigger" que puede dispararse aleatoriamente o en momentos clave para ofrecer una perspectiva ideológica del protagonista.

### Nuevas Variables de Control
```ink
VAR voces_activas = true           // Permite silenciar el diálogo interno si el jugador lo prefiere
VAR probabilidad_voz = 30          // % de chance de que una idea hable en un nodo de texto
VAR ultima_voz = ""                // Evita que la misma idea hable dos veces seguidas
```

### Mapa de "Voces" por Idea
- **idea_quien_soy (Involuntaria):** "Tu silla en la oficina ya la ocupa otro. Sos un fantasma caminando por 18 de Julio."
- **idea_el_problema_no_soy_yo (Política):** "Esa mirada de lástima del jefe... no es por vos, es por su propio miedo a estar en tu lugar."
- **idea_red_o_nada (Heredada):** "Elena tiene razón. Si no nos sostenemos entre nosotros, el cemento nos come."

---

## 2. URUGUAY GRIS (AMBIENTE DINÁMICO)

### Filosofía
El clima y el entorno mediático deben reforzar la sensación de "horror lento" y realismo material.

### Nuevas Variables de Ambiente
```ink
VAR clima_actual = "gris"          // gris, lluvia, viento, sol_frio
VAR humedad_nivel = 0               // 0-10. Si > 7, afecta energía.
VAR noticia_del_dia = ""           // Almacena el titular que escuchaste en la radio
VAR escucho_radio = false          // Tracking para diálogos posteriores ("¿Viste lo que dijeron?")
```

### Sistema de Clima (Mecánico)
- **Humedad (El mal de Montevideo):** Si `humedad_nivel > 8`, el costo de energía de las acciones de "Caminar" o "Olla" aumenta en +1.
- **Viento Sur:** Aumenta la `inercia` ligeramente al amanecer (ganas de quedarse en la cama).

---

## 3. PULIDO TÉCNICO Y UX (GLOSA Y DIARIO)

### Filosofía
Reducir la fricción cognitiva del jugador y aumentar la inmersión mediante herramientas de información contextual.

### Nuevas Variables de Sistema (Metadatos)
```ink
VAR glosa_activada = true          // Muestra/oculta explicaciones de términos uruguayos
VAR total_victorias_morales = 0    // Tracking para el resumen del Diario
VAR total_traiciones = 0           // Tracking para el resumen del Diario
VAR lista_decisiones_clave = ""    // String acumulativo para el resumen final
```

### El Diario de Conciencia (Mecánica de Noche)
Cada noche, el protagonista escribe una línea en su diario. 
- *Si ayudaste en la olla:* "Hoy las manos me huelen a cebolla. Es un olor mejor que el del aire acondicionado."
- *Si ignoraste a alguien:* "Vi a Sofía y doblé la esquina. El silencio pesa más que la charla."

---

## 4. RESUMEN DE VARIABLES A AGREGAR (`variables.ink`)

| Variable | Tipo | Función |
|----------|------|---------|
| `voces_activas` | bool | Toggle de diálogo interno |
| `clima_actual` | string | Estado del tiempo |
| `humedad_nivel` | int | Penalizador de energía |
| `noticia_del_dia` | string | Contexto mediático |
| `escucho_radio` | bool | Flag de información |
| `total_victorias_morales` | int | Contador UX |
| `total_traiciones` | int | Contador UX |
| `diario_entradas` | int | Cantidad de reflexiones escritas |

---

### PRÓXIMOS PASOS
1. Implementar `mecanicas/ambiente.ink` con la lógica de Radio y Clima.
2. Crear `mecanicas/voces.ink` con el sistema de diálogo interno.
3. Actualizar `amanecer` y `noche` en todos los días para incluir estos sistemas.
4. Integrar el sistema de "Glosa" en los textos (ej. `[MIDES|Ministerio de Desarrollo Social]`).

¿Qué te parece este mapa de variables? Si estás de acuerdo, procedo a la implementación técnica.
