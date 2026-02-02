# DESARROLLO DE IXCHEL - Registro de Cambios

**Fecha:** 2026-02-02
**Versión:** 2.0
**Archivo:** `prototype/ink/personajes/ixchel.ink`

---

## RESUMEN

Se expandió significativamente el personaje de Ixchel para equiparar su peso narrativo con los otros vínculos principales (Sofía, Elena, Diego). El archivo pasó de ~18KB a ~51KB.

---

## CONTENIDO AGREGADO

### 1. Escenas de Cocina - Enseñando Recetas

#### `ixchel_ensena_pepian`
- Escena completa donde Ixchel enseña a hacer pepián guatemalteco
- Incluye técnicas (asar tomate directo en hornalla, tostar pepitoria)
- Recuerdos de la abuela mientras cocina
- Chequeo físico para aprender la receta
- Reflexión sobre la comida como memoria
- Nueva idea desbloqueada: "LA COMIDA ES MEMORIA"

#### `ixchel_ensena_tortillas`
- Escena donde enseña a hacer tortillas de maíz
- Explicación del maíz como ser sagrado
- Referencia al Popol Vuh ("los dioses nos hicieron de masa")
- Momento de conexión intercultural

### 2. Historia de Tomás - Contada en Partes

#### `ixchel_tomas_infancia`
- Recuerdos de infancia con Tomás
- El cerro al amanecer
- Anécdota de los mangos robados
- Tomás siempre protegiendo a su hermana

#### `ixchel_tomas_lider`
- Cómo Tomás se convirtió en líder
- Progresión: catequista → organizador → vocero del Consejo
- Las consultas comunitarias
- Su filosofía: "El poder de ellos es el dinero. El nuestro es estar juntos."

#### `ixchel_tomas_ultimo_dia`
- El día que Tomás desapareció
- Detalles específicos (camisa celeste, la despedida)
- El hallazgo del cuerpo
- Las amenazas que siguieron
- Escena emocionalmente intensa con lágrimas

### 3. Conversación Profunda sobre la Virgen de Guadalupe

#### `ixchel_virgen_guadalupe_profundo`
- Hub con tres ramas:
  - `ixchel_guadalupe_porque` - Por qué Guadalupe específicamente (morena, se apareció a un indio)
  - `ixchel_guadalupe_historia` - La estampita que le dio su mamá, habla con ella todas las noches
  - `ixchel_guadalupe_escucha` - Reflexión sobre si los santos escuchan

### 4. Cosmovisión Maya - Buen Vivir

#### `ixchel_utz_kaslemal`
- Explicación del Ut'z Kaslemal (buen vivir maya)
- Contraste con el "progreso" occidental
- "Tomá lo que necesitás, no lo que podés"
- Conexión con la olla popular
- Nueva idea desbloqueada: "HAY OTRA FORMA"

### 5. Escena de Ixchel Hablando K'iche' Sola

#### `ixchel_hablando_kiche`
- Protagonista encuentra a Ixchel rezando/cantando en k'iche'
- Opciones: escuchar desde afuera o interrumpir
- Explicación del dolor de perder la lengua
- **Nueva mecánica:** Ixchel enseña una palabra en k'iche' ("saqarik" = amanecer/nuevo comienzo)
- Variable `aprendio_palabra_kiche` para usar en el cierre

### 6. Fragmentos Nocturnos Expandidos

#### `ixchel_fragmento_noche_rio` (NUEVO)
- Ixchel va al arroyo Pantanoso de noche
- Comparación con el río de Guatemala
- "El agua tiene memoria"
- Habla con Tomás junto al agua

#### `ixchel_fragmento_noche_rezo` (EXPANDIDO)
- Versión más detallada del rezo nocturno
- Mezcla español y k'iche'
- Habla con la foto de Tomás sobre el día
- Mención de la gente nueva de la olla

#### `fragmento_ixchel_llamada_mama` (NUEVO)
- Llamada telefónica a Guatemala
- 15 minutos (lo máximo que puede pagar)
- La madre dice "igual" = sigue difícil

### 7. Conexiones con Otros Personajes

#### `ixchel_y_elena_profundo` (NUEVO)
- Conversación profunda sobre pérdidas
- Elena comparte su propia historia
- "Las arrugas son los ríos del alma"
- "No te voy a decir que pasa. Porque no pasa. Pero se aprende a cargar."

#### `ixchel_y_diego_profundo` (NUEVO)
- Intercambio de historias de pérdida
- "A mi hermano lo mataron" / "A mi cooperativa la destruyeron"
- Reflexión sobre los uruguayos que no entienden

#### `ixchel_y_diego_reconocimiento` (NUEVO)
- Momento de reconocimiento mutuo como migrantes
- "Nadie te pregunta cómo estás de verdad"
- "Somos los que escuchamos"

#### `ixchel_y_juan_xenofobo` (NUEVO)
- Juan dice "Ixchel es distinta, no como otros..."
- Ixchel responde con paciencia pero firmeza
- "Cuando uno huye de su tierra, no es porque quiere"

#### `ixchel_y_juan_despues` (NUEVO)
- Juan se disculpa
- "El perdón no se pide. Se gana."
- Ixchel le da una oportunidad: "Ahora ayude"

### 8. Participación en Asamblea

#### `ixchel_en_asamblea` (NUEVO)
- Ixchel interviene para pedir orden
- "En mi comunidad, primero se escucha a los ancianos"
- Elena la apoya: "La guatemalteca tiene razón"

#### `ixchel_intervencion_asamblea` (NUEVO)
- Ixchel advierte sobre la "ayuda" del gobierno
- Paralelo con las mineras en Guatemala
- "¿Qué van a pedir a cambio?"

### 9. Cierre Dominical

#### `ixchel_cierre_domingo` (NUEVO)
- Escena de reflexión en domingo
- Cumpleaños de la abuela muerta
- Cita de la abuela: "Nunca te olvides de dónde venís. Pero tampoco de adónde vas."
- Integración de la palabra k'iche' aprendida
- Cierre poético: "Mientras haya maíz, hay esperanza"

---

## VARIABLES NUEVAS

```ink
~ ixchel_enseno_receta = true
~ ixchel_enseno_tortillas = true
~ ixchel_conto_tomas_infancia = true
~ ixchel_conto_tomas_lider = true
~ ixchel_conto_tomas_ultimo = true
~ ixchel_hablo_guadalupe_profundo = true
~ ixchel_hablo_buen_vivir = true
~ vio_ixchel_hablando_kiche = true
~ aprendio_palabra_kiche = true
~ ixchel_fragmento_rio = true
~ ixchel_hablo_con_elena = true
~ ixchel_hablo_elena_profundo = true
~ ixchel_hablo_con_diego = true
~ ixchel_diego_hablaron_profundo = true
~ ixchel_aguanto_xenofobia_juan = true
~ juan_se_disculpo_ixchel = true
~ ixchel_participo_asamblea = true
~ ixchel_cierre_domingo = true
```

---

## IDEAS DESBLOQUEADAS (NUEVAS)

- `"LA COMIDA ES MEMORIA"` - Escena del pepián
- `"HAY OTRA FORMA"` - Escena del Ut'z Kaslemal

---

## COMPARACIÓN DE PESO VS OTROS VÍNCULOS

| Elemento | Sofía | Elena | Diego | Ixchel (antes) | Ixchel (ahora) |
|----------|-------|-------|-------|----------------|----------------|
| Encuentro casual | ✓ | ✓ | ✓ | ✓ | ✓ |
| Escenas en olla | ✓ | ✓ | ✓ | ✓ | ✓ |
| Historia profunda partes | 3 | 4 | 3 | 2 | **5** |
| Fragmentos nocturnos | 3 | 3 | 3 | 2 | **4** |
| Escena enseñando algo | ✓ | ✓ | ✓ | ✗ | **✓** |
| Participación asamblea | ✓ | ✓ | ✓ | ✗ | **✓** |
| Cierre domingo | ✓ | ✓ | ✓ | ✗ | **✓** |
| Interacción con otros | 3 | 3 | 3 | 3 | **6** |
| Momento de quiebre | ✓ | ✓ | ✓ | ✗ | **✓*** |

*El "quiebre" de Ixchel es más sutil - contando la historia de Tomás completa

---

## TEMAS PROFUNDIZADOS

1. **Sincretismo religioso** - Virgen de Guadalupe como figura de resistencia indígena
2. **Pérdida de la lengua** - El dolor de no tener con quién hablar k'iche'
3. **Cosmovisión maya** - Ut'z Kaslemal, ayni, relación con la naturaleza
4. **Migración forzada** - Paralelos con Diego, diferencias con uruguayos
5. **Xenofobia cotidiana** - Manejo de microagresiones con dignidad
6. **Transmisión de saberes** - Cocina como acto político y de memoria

---

## NOTAS DE DISEÑO

- Se mantuvo el estilo de Ixchel: formal ("usted"), pausada, sabia sin ser sentenciosa
- Se evitó el "dolor como espectáculo" - las escenas emotivas tienen propósito narrativo
- Se agregó agencia política (intervención en asamblea, crítica a academia)
- Se creó arco de relación con Juan (xenófobo → disculpa → aprendizaje)
- Se integró la palabra k'iche' aprendida en el cierre dominical

---

## PRÓXIMOS PASOS SUGERIDOS

1. Integrar escenas en los días correspondientes (jueves-domingo)
2. Agregar triggers para fragmentos nocturnos según condiciones
3. Revisar balance con otros personajes
4. Testear flujo de revelación gradual de historia de Tomás
