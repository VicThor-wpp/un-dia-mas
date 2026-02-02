# DESARROLLO DE ANTAGONISTAS

**Fecha:** 2026-02-02
**Archivo:** docs/changes/ANTAGONISTAS.md

---

## Resumen

Se expandieron los tres antagonistas principales para darles más presencia narrativa y mecánica a lo largo de la semana.

---

## BRUNO (El Fascista Territorial)

### Archivos modificados
- `prototype/ink/personajes/bruno.ink` (6KB → 16KB)

### Nuevas escenas

#### Aparición temprana (Martes/Miércoles)
- **`bruno_camioneta_martes`**: Primera aparición - solo la camioneta en la esquina. Elena reacciona si tenés relación con ella.
- **`bruno_mencion_miercoles`**: Se escucha hablar de él en la olla. Diego y Sofía cuentan sobre "El Apóstol" y la chacra.
- **`bruno_y_tiago_miercoles`**: Se ve a Bruno hablando con Tiago por la ventanilla de la camioneta.

#### Conflicto con Elena (NUEVO)
- **`elena_sobre_bruno`**: Elena cuenta su historia con Bruno (requiere elena_relacion >= 3).
- **`elena_historia_bruno`**: Backstory - conexión con la dictadura, "los que miran y anotan".
- **`elena_confronta_bruno`**: Elena y Bruno cara a cara en la olla. Elena no retrocede.

#### Expansiones
- **`bruno_presion_tiago`**: Escena más explícita de manipulación a Tiago ("Tu vieja está internada. No tenés a nadie.").
- **`bruno_oferta_seguridad`**: Oferta alternativa para inercia 5-7 (trabajo de "seguridad").
- **`bruno_y_claudia`**: Bruno y Claudia se cruzan - dos formas de control.
- **`fragmento_bruno_sermon`**: Bruno dando sermón en la chacra.

### Variables nuevas
- `sabe_de_bruno`: Protagonista conoce a Bruno
- `bruno_contacto_tiago`: Bruno contactó a Tiago antes
- `tiago_tentado_bruno`: Tiago está considerando la oferta
- `tiago_rechazo_bruno`: Tiago rechazó a Bruno
- `elena_conto_bruno`: Elena contó la historia

---

## CLAUDIA (La Violencia Administrativa)

### Archivos modificados
- `prototype/ink/personajes/claudia.ink` (5.4KB → 12.4KB)

### Nuevas escenas

#### Aviso temprano (Miércoles/Jueves)
- **`claudia_aviso_miercoles`**: Llega el aviso oficial de inspección. Sofía muestra el papel.
- **`claudia_tension_jueves`**: La tensión crece en la olla antes de la visita.
- **`claudia_primera_inspeccion`**: Primera ronda de inspección - Claudia saca fotos y anota "inconsistencias".

#### Momento de humanización (opcional)
- **`claudia_sola`**: Bifurca según hostilidad:
  - **`claudia_sola_maquina`**: Claudia es pura máquina burocrática.
  - **`claudia_sola_humana`**: Un atisbo de humanidad - recuerda a su abuela y el 2002.
- **`fragmento_claudia_casa`**: Claudia en su departamento vacío con el gato.

#### Consecuencias expandidas
- **`claudia_el_desperdicio`**: Claudia critica la cantidad de comida por porción.
- **`claudia_consecuencias_largas`**: Efectos a largo plazo de entregar/no entregar la lista:
  - Si entregaste: Tiago, la familia venezolana y el viejo sin cédula dejan de venir.
  - Si resististe: Viene gente nueva que antes tenía miedo.

### Variables nuevas
- `sabe_de_claudia`: Protagonista sabe de la auditoría
- `tension_olla`: Hay tensión en la olla por la auditoría

---

## CACHO (El Lumpen Iluso)

### Archivos modificados
- `prototype/ink/personajes/cacho.ink` (5KB → 15KB)

### Nuevas escenas

#### Alivio cómico expandido
- **`cacho_primer_cruce`**: Cruce temprano en la calle, "Cerrando unos negocios" viniendo de la olla.
- **`cacho_explicacion_cripto`**: Cacho explica bitcoin (mal).
- **`cacho_networking`**: Cacho hace "networking" con una señora en la fila.
- **`cacho_linkedin`**: Muestra su LinkedIn ("CEO en Emprendimientos Varios", 12 conexiones).
- **`cacho_uber`**: Cuenta que chocó el Uber sin seguro ("Mentalidad de empleado, tener seguro").
- **`cacho_planeros`**: Critica a los "planeros" mientras está en la fila.

#### Quiebre de fachada
- **`cacho_fachada_cae`**: Escena del cumpleaños de su madre. La fachada se quiebra.
- **`cacho_quiebre_profundo`**: "Todos mis negocios fueron mentira."
- **`cacho_quiebre_final`**: "Mi vieja laburó toda la vida. Yo no heredé eso."

#### Redención
- **`cacho_contactos`**: Cacho ofrece un contacto real (verdulería que puede donar).
- **`cacho_contactos_reales`**: El contacto funciona. Primera vez que Cacho sirve para algo.
- **`cacho_redencion_extendida`**: Cacho cortando verdura en la olla. "Capaz que esto es mejor negocio."
- **`cacho_domingo_redencion`**: Resultado de la redención de Cacho.

#### Fragmentos nocturnos nuevos
- **`fragmento_cacho_youtube`**: Cacho mirando videos de "mentalidad de tiburón" a las 2am.
- **`fragmento_cacho_espejo`**: "Hoy es el día" (se lo dice hace 20 años).

### Variables nuevas
- `cacho_encuentros`: Cantidad de veces que lo cruzaste
- `cacho_quiebre_completo`: Cacho tuvo el quiebre profundo
- `cacho_ayudo`: Cacho ayudó de verdad a la olla

---

## Integración sugerida con días

### Martes
- `-> bruno_camioneta_martes` (si pasa por la esquina)
- `-> cacho_primer_cruce` (encuentro casual)

### Miércoles
- `-> bruno_mencion_miercoles` (en la olla)
- `-> bruno_y_tiago_miercoles` (tarde)
- `-> claudia_aviso_miercoles` (llega el aviso)
- `-> cacho_explicacion_cripto` (encuentro casual)

### Jueves
- `-> claudia_tension_jueves` (en la olla)
- `-> bruno_presion_tiago` (si sabe_de_bruno)
- `-> cacho_linkedin` o `-> cacho_uber` (alivio cómico)
- `-> elena_sobre_bruno` (si elena_relacion >= 3)

### Viernes
- `-> claudia_primera_inspeccion` (mañana)
- `-> claudia_la_auditoria` (mediodía - escena central)
- `-> claudia_amenaza_final` (tarde)
- `-> cacho_fachada_cae` (noche, si cacho_encuentros >= 3)

### Sábado
- `-> elena_confronta_bruno` (si bruno_tension >= 2)
- `-> bruno_recluta_tiago` (si olla falló)
- `-> cacho_contactos` (si cacho_momento_real y olla_en_crisis)

### Domingo
- `-> bruno_domingo` (resultado)
- `-> claudia_domingo_lista_entregada` o `-> claudia_domingo_sin_lista` (consecuencias)
- `-> claudia_consecuencias_largas` (efectos de la lista)
- `-> cacho_domingo` o `-> cacho_domingo_redencion` (resultado)

---

## Notas de diseño

### Bruno
- **Presencia gradual**: Aparece primero como sombra (camioneta, rumores), luego en persona.
- **Conexión con Elena**: Añade profundidad histórica. Elena lo "conoce de antes" - vinculación implícita con la dictadura.
- **Dos frentes**: Ataca a Tiago (vulnerable) y al protagonista (si inercia alta).
- **Conexión con Claudia**: Escena opcional donde se los ve hablando - dos formas de control que convergen.

### Claudia
- **Aviso temprano**: Genera tensión antes de su aparición.
- **Humanización opcional**: Depende de la hostilidad. Si el jugador la confronta mucho, se vuelve más máquina. Si no, muestra un atisbo de duda.
- **Consecuencias reales**: La lista tiene efectos materiales (gente que deja de venir).

### Cacho
- **Alivio cómico dosificado**: Varias escenas cortas distribuidas en la semana.
- **El quiebre**: Necesita varios encuentros previos para desbloquearse.
- **Redención trucha pero útil**: No cambia de personalidad, pero encuentra una forma de aportar (contacto de la verdulería).
- **Progresión**: De "mindset de tiburón" a cortar papas en la olla.

---

## Métricas

| Personaje | Escenas antes | Escenas después | Aumento |
|-----------|--------------|-----------------|---------|
| Bruno     | 8            | 18              | +125%   |
| Claudia   | 7            | 15              | +114%   |
| Cacho     | 7            | 20              | +186%   |

---

*Documento generado para Un Día Más - 2026-02-02*
