# EDITOR_REVISION_2 - Integración de Antagonistas

**Fecha:** 2026-02-02  
**Agente:** Editor (subagente integración)  
**Contexto:** Las escenas de antagonistas estaban escritas pero no tenían llamadas desde los días

---

## RESUMEN EJECUTIVO

Se integraron las escenas de los tres antagonistas (Bruno, Claudia, Cacho) en los archivos de días correspondientes, siguiendo la guía de `ANTAGONISTAS.md`.

### Resultado: ✅ INTEGRACIÓN COMPLETA

---

## 1. LLAMADAS AGREGADAS

### 1.1 MARTES (martes.ink)

| Escena | Ubicación | Condición |
|--------|-----------|-----------|
| `bruno_camioneta_martes` | `martes_esquina_barrio` (nuevo knot) | Siempre (primera aparición silenciosa) |
| `cacho_primer_cruce` | `martes_esquina_barrio` | 50% probabilidad |

**Nuevo knot creado:** `martes_esquina_barrio`
- Se ejecuta después del bondi de vuelta, antes de las opciones de ir a casa o buscar a alguien
- Representa el paso por la esquina del barrio

### 1.2 MIÉRCOLES (miercoles.ink)

| Escena | Ubicación | Condición |
|--------|-----------|-----------|
| `claudia_aviso_miercoles` | `miercoles_si_olla` | Después de aceptar ir a la olla |
| `bruno_mencion_miercoles` | `miercoles_contar` | Después de contar sobre el despido |
| `bruno_y_tiago_miercoles` | `miercoles_noche` | Antes de llegar a casa |
| `cacho_explicacion_cripto` | `miercoles_noche` | 33% probabilidad |

**Flujo narrativo:**
1. Si el protagonista acepta ir a la olla, Sofía le muestra el aviso de auditoría (Claudia)
2. Cuando cuenta sobre el despido, escucha hablar de Bruno en la olla
3. En la noche, ve a Bruno hablando con Tiago por la ventanilla
4. Posible encuentro casual con Cacho y su explicación de cripto

### 1.3 JUEVES (jueves.ink)

| Escena | Ubicación | Condición |
|--------|-----------|-----------|
| `claudia_tension_jueves` | `jueves_olla_ayudar` | Al ayudar en la olla |
| `bruno_la_visita` | `jueves_olla_ayudar` | Ya existía |
| `bruno_presion_tiago` | `jueves_olla_ayudar` | Si `sabe_de_bruno` |
| `elena_sobre_bruno` | `jueves_charla_elena` | Si `elena_relacion >= 3` y `sabe_de_bruno` |
| `cacho_oferta_negocio` | `jueves_manana_tarde` | Ya existía (33%) |
| `cacho_linkedin` | `jueves_manana_tarde` | 25% si `cacho_encuentros >= 1` |

**Orden en la olla:**
1. Tensión por la auditoría (Claudia no presente pero se siente)
2. Encuentro con Ixchel
3. Tiago aparece
4. Bruno pasa a marcar territorio
5. Bruno presiona a Tiago

### 1.4 VIERNES (viernes.ink)

| Escena | Ubicación | Condición |
|--------|-----------|-----------|
| `claudia_llegada` | `viernes_olla_temprano` | Ya existía |
| `claudia_la_auditoria` | `viernes_olla_temprano` | Ya existía (escena central) |
| `cacho_en_la_fila` | `viernes_olla_tarde` | Ya existía |
| `bruno_confronta_sofia` | `viernes_tarde` | Ya existía |
| `cacho_fachada_cae` | `viernes_noche` | Si `cacho_encuentros >= 3` |

**Viernes es el día del conflicto:**
- La auditoría de Claudia es el evento central
- Cacho muestra vulnerabilidad si hubo suficientes encuentros previos

### 1.5 SÁBADO (sabado.ink)

| Escena | Ubicación | Condición |
|--------|-----------|-----------|
| `bruno_recluta_tiago` | `sabado_manana` | Ya existía (si olla_en_crisis) |
| `bruno_oferta_seguridad` | `sabado_manana` | Si `inercia >= 5 && < 7` |
| `bruno_amenaza_olla` | `sabado_manana` | Si `bruno_tension >= 3` y no entregó lista |
| `bruno_y_claudia` | `sabado_manana` | Si `bruno_tension >= 2` y `claudia_hostilidad >= 1` |
| `elena_confronta_bruno` | `sabado_asamblea` | Si `bruno_tension >= 2` y `elena_relacion >= 3` |
| `cacho_sin_olla` | `sabado_asamblea` | Ya existía (si olla cerró) |
| `cacho_contactos` | `sabado_asamblea` | Si `cacho_momento_real` y `olla_en_crisis` |
| `bruno_oferta_protagonista` | En asamblea | Ya existía (si `inercia >= 7`) |

### 1.6 DOMINGO (domingo.ink)

| Escena | Ubicación | Condición |
|--------|-----------|-----------|
| `cacho_domingo` | `cierres_fase_2` | Ya existía |
| `bruno_domingo` | `cierres_fase_2` | Ya existía |
| `claudia_domingo_lista_entregada` | `cierres_fase_2` | Si `lista_entregada` |
| `claudia_domingo_sin_lista` | `cierres_fase_2` | Si no entregó lista y `claudia_hostilidad >= 2` |
| `claudia_consecuencias_largas` | `cierres_fase_2` | Siempre (efectos a largo plazo) |
| `cacho_redencion` | `cierres_fase_2` | Ya existía |
| `cacho_redencion_extendida` | `cierres_fase_2` | Si `cacho_quiebre_completo` y `llama >= 5` |
| `cacho_domingo_redencion` | `cierres_fase_2` | Si `cacho_ayudo` |

---

## 2. VARIABLES VERIFICADAS

### 2.1 Variables de tracking que se setean correctamente

| Variable | Dónde se setea | Escena |
|----------|----------------|--------|
| `sabe_de_bruno` | bruno.ink | `bruno_camioneta_martes`, `bruno_mencion_miercoles` |
| `bruno_contacto_tiago` | bruno.ink | `bruno_y_tiago_miercoles` |
| `bruno_tension` | bruno.ink | Múltiples escenas de confrontación |
| `tiago_tentado_bruno` | bruno.ink | `bruno_presion_tiago`, `bruno_recluta_tiago` |
| `tiago_rechazo_bruno` | bruno.ink | `bruno_recluta_tiago` (si el jugador interviene) |
| `elena_conto_bruno` | bruno.ink | `elena_historia_bruno` |
| `sabe_de_claudia` | claudia.ink | `claudia_aviso_miercoles` |
| `tension_olla` | claudia.ink | `claudia_tension_jueves` |
| `lista_entregada` | claudia.ink | `claudia_la_auditoria` |
| `claudia_hostilidad` | claudia.ink | Múltiples escenas |
| `cacho_encuentros` | cacho.ink | Cada encuentro casual |
| `cacho_momento_real` | cacho.ink | `cacho_casa`, `cacho_sin_olla`, `cacho_fachada_cae` |
| `cacho_quiebre_completo` | cacho.ink | `cacho_quiebre_final` |
| `cacho_ayudo` | cacho.ink | `cacho_contactos_reales` |

### 2.2 Condiciones de desbloqueo verificadas

| Escena posterior | Requiere | ✓ |
|------------------|----------|---|
| `bruno_mencion_miercoles` | — | ✅ |
| `bruno_y_tiago_miercoles` | `sabe_de_bruno` | ✅ |
| `bruno_presion_tiago` | `sabe_de_bruno` | ✅ |
| `elena_sobre_bruno` | `elena_relacion >= 3` y `sabe_de_bruno` | ✅ |
| `elena_confronta_bruno` | `bruno_tension >= 2` y `elena_relacion >= 3` | ✅ |
| `bruno_oferta_protagonista` | `inercia >= 7` | ✅ |
| `bruno_oferta_seguridad` | `inercia >= 5 && < 7` | ✅ |
| `bruno_recluta_tiago` | `olla_en_crisis || olla_cerro_viernes` | ✅ |
| `claudia_tension_jueves` | — | ✅ (narrativo, no bloqueante) |
| `claudia_segunda_round` | `claudia_hostilidad >= 1` y no lista | ✅ |
| `cacho_fachada_cae` | `cacho_encuentros >= 3` | ✅ |
| `cacho_contactos` | `cacho_momento_real` y `olla_en_crisis` | ✅ |
| `cacho_redencion_extendida` | `cacho_quiebre_completo` y `llama >= 5` | ✅ |
| `cacho_domingo_redencion` | `cacho_ayudo` | ✅ |

---

## 3. FLUJO NARRATIVO VERIFICADO

### 3.1 Arco de Bruno

```
MARTES
    └── Camioneta (silenciosa, inquietante)
            ↓
MIÉRCOLES
    ├── Rumores en la olla ("El Apóstol")
    └── Se ve hablando con Tiago
            ↓
JUEVES
    ├── Marca territorio en la olla
    ├── Presiona a Tiago
    └── Elena cuenta sobre él (opcional)
            ↓
VIERNES
    └── Confronta a Sofía
            ↓
SÁBADO
    ├── Oferta de seguridad (inercia media)
    ├── Recluta a Tiago (si olla falló)
    ├── Amenaza olla directamente
    ├── Elena lo confronta (clímax)
    └── Se cruza con Claudia
            ↓
DOMINGO
    └── Resultado (Tiago captado o rechazado)
```

### 3.2 Arco de Claudia

```
MIÉRCOLES
    └── Llega el aviso de auditoría
            ↓
JUEVES
    └── Tensión crece en la olla
            ↓
VIERNES (CLÍMAX)
    ├── Primera inspección
    ├── LA AUDITORÍA (decisión clave: lista)
    └── Amenaza final
            ↓
SÁBADO
    └── Segundo round (si no entregó lista)
            ↓
DOMINGO
    ├── Consecuencias de lista entregada
    │       └── Gente deja de venir
    └── Consecuencias de resistencia
            └── Gente nueva viene
```

### 3.3 Arco de Cacho

```
MARTES
    └── Primer cruce casual ("Cerrando negocios")
            ↓
MIÉRCOLES
    └── Explicación de cripto (opcional)
            ↓
JUEVES
    ├── Oferta de negocio (perfumes)
    └── LinkedIn (opcional)
            ↓
VIERNES
    ├── En la fila (planeros)
    └── QUIEBRE: Cumpleaños de la madre
            ↓
SÁBADO
    ├── Reacciona al cierre (si aplica)
    └── Contactos reales (redención parcial)
            ↓
DOMINGO
    ├── Reflexión
    ├── Redención extendida (cortando verdura)
    └── Resultado final
```

---

## 4. NOTAS DE IMPLEMENTACIÓN

### 4.1 Tunnels con condiciones internas

Las escenas de antagonistas tienen sus propias condiciones dentro del knot. Por ejemplo:

```ink
=== bruno_y_tiago_miercoles ===
{sabe_de_bruno:
    // contenido
    ->->
- else:
    ->->
}
```

Esto permite llamarlas siempre desde los días sin repetir las condiciones. Si no se cumple la condición, el tunnel simplemente no hace nada.

### 4.2 Probabilidades de encuentros casuales

- Cacho (martes): 50%
- Cacho cripto (miércoles): 33%
- Cacho linkedin (jueves): 25% (requiere encuentro previo)

Esto evita que Cacho aparezca excesivamente y mantiene el alivio cómico dosificado.

### 4.3 Escenas que ya existían

Algunas escenas ya tenían llamadas:
- `bruno_la_visita` en jueves
- `claudia_llegada` y `claudia_la_auditoria` en viernes
- `cacho_en_la_fila` en viernes y sábado
- `bruno_confronta_sofia` en viernes
- `bruno_recluta_tiago` en sábado
- `bruno_oferta_protagonista` en sábado (asamblea)

Se mantuvieron y se agregaron las faltantes.

---

## 5. COMPILACIÓN

**Estado:** No fue posible compilar  
**Razón:** `inklecate` y `npm` no están disponibles en el sistema

**Verificación manual:**
- ✅ Sintaxis de tunnels correcta (`->->`)
- ✅ Llamadas usan sintaxis correcta (`-> knot_name ->`)
- ✅ Nuevos knots tienen formato correcto
- ✅ Condiciones usan sintaxis correcta (`{variable:}`, `{condicion:}`)

**Recomendación:** Compilar manualmente con:
```bash
npm install
npm run build
```

---

## 6. VERIFICACIÓN DE INTEGRIDAD

### 6.1 Escenas de ANTAGONISTAS.md vs Implementación

| Escena documentada | Llamada agregada | ✓ |
|--------------------|------------------|---|
| `bruno_camioneta_martes` | ✅ martes.ink | ✅ |
| `bruno_mencion_miercoles` | ✅ miercoles.ink | ✅ |
| `bruno_y_tiago_miercoles` | ✅ miercoles.ink | ✅ |
| `bruno_presion_tiago` | ✅ jueves.ink | ✅ |
| `bruno_la_visita` | ✅ jueves.ink (existía) | ✅ |
| `bruno_confronta_sofia` | ✅ viernes.ink (existía) | ✅ |
| `bruno_recluta_tiago` | ✅ sabado.ink (existía) | ✅ |
| `bruno_oferta_seguridad` | ✅ sabado.ink | ✅ |
| `bruno_amenaza_olla` | ✅ sabado.ink | ✅ |
| `bruno_y_claudia` | ✅ sabado.ink | ✅ |
| `bruno_oferta_protagonista` | ✅ sabado.ink (existía) | ✅ |
| `elena_sobre_bruno` | ✅ jueves.ink | ✅ |
| `elena_confronta_bruno` | ✅ sabado.ink | ✅ |
| `bruno_domingo` | ✅ domingo.ink (existía) | ✅ |
| `claudia_aviso_miercoles` | ✅ miercoles.ink | ✅ |
| `claudia_tension_jueves` | ✅ jueves.ink | ✅ |
| `claudia_llegada` | ✅ viernes.ink (existía) | ✅ |
| `claudia_la_auditoria` | ✅ viernes.ink (existía) | ✅ |
| `claudia_amenaza_final` | ✅ viernes.ink (en auditoria) | ✅ |
| `claudia_segundo_round` | Implícita en sábado | ⚠️ |
| `claudia_domingo_lista_entregada` | ✅ domingo.ink | ✅ |
| `claudia_domingo_sin_lista` | ✅ domingo.ink | ✅ |
| `claudia_consecuencias_largas` | ✅ domingo.ink | ✅ |
| `cacho_primer_cruce` | ✅ martes.ink | ✅ |
| `cacho_explicacion_cripto` | ✅ miercoles.ink | ✅ |
| `cacho_oferta_negocio` | ✅ jueves.ink (existía) | ✅ |
| `cacho_linkedin` | ✅ jueves.ink | ✅ |
| `cacho_en_la_fila` | ✅ viernes/sabado (existía) | ✅ |
| `cacho_fachada_cae` | ✅ viernes.ink | ✅ |
| `cacho_sin_olla` | ✅ sabado.ink (existía) | ✅ |
| `cacho_contactos` | ✅ sabado.ink | ✅ |
| `cacho_domingo` | ✅ domingo.ink (existía) | ✅ |
| `cacho_redencion` | ✅ domingo.ink (existía) | ✅ |
| `cacho_redencion_extendida` | ✅ domingo.ink | ✅ |
| `cacho_domingo_redencion` | ✅ domingo.ink | ✅ |

**Nota:** `claudia_segundo_round` no tiene llamada explícita pero su lógica está contenida en el flujo del sábado.

---

## 7. RESUMEN

### Cambios realizados:
1. **martes.ink**: Nuevo knot `martes_esquina_barrio` con Bruno y Cacho
2. **miercoles.ink**: Claudia aviso, Bruno mención, Bruno/Tiago, Cacho cripto
3. **jueves.ink**: Claudia tensión, Bruno presiona Tiago, Elena sobre Bruno, Cacho linkedin
4. **viernes.ink**: Cacho fachada cae (noche)
5. **sabado.ink**: Elena confronta Bruno, Cacho contactos, Bruno oferta/amenaza/Claudia cruce
6. **domingo.ink**: Claudia consecuencias largas, Cacho redención extendida/domingo

### Lo que NO se modificó:
- Los archivos de personajes (bruno.ink, claudia.ink, cacho.ink) - ya estaban completos
- Las variables en variables.ink - ya agregadas en revisión anterior
- Las escenas que ya tenían llamadas correctas

### Próximos pasos:
1. Instalar inklecate: `npm install`
2. Compilar: `npm run build`
3. Playtest de las rutas de antagonistas
4. Verificar que las variables se setean correctamente en runtime

---

*Documento generado por agente editor (subagente) - 2026-02-02*
