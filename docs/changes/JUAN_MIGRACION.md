# CAMBIOS: Arco de Migración de Juan

**Fecha:** 2026-02-02  
**Archivo:** `prototype/ink/personajes/juan.ink`  
**Autor:** Subagente udm-juan

## Problema Original

El arco de migración de Juan era **abrupto**:
- El protagonista se enteraba de golpe que Juan se iba a España
- No había progresión emocional durante la semana
- La despedida era funcional pero no emotiva
- Faltaba explorar el significado de que un uruguayo se vaya mientras los migrantes se quedaron

## Cambios Implementados

### 1. Build-up de Migración (Lunes a Viernes)

#### Lunes: `juan_almuerzo_lunes_espana`
- Juan menciona casualmente que la prima de Laura se fue a España
- "La mina está hace tres años. Y no volvió."
- Describe el departamento en Valencia (dos cuartos, balcón, la mitad del sueldo en alquiler)
- Planta la semilla de la idea

#### Martes: `juan_charla_martes_espana`
- Juan pregunta: "¿Vos alguna vez pensaste en irte?"
- Revela que tiene pasaporte italiano por el abuelo
- "Laura anoche me dijo algo... la prima le puede conseguir algo"
- Variable: `juan_considerando_irse = true`

#### Miércoles: `juan_post_despido_miercoles`
- Después del despido del protagonista
- "Si vos, que hacías todo bien... si a vos te echaron así... ¿qué me queda a mí?"
- Pregunta clave: "¿Vos te irías?"
- La conversación es íntima, honesta

#### Jueves: `juan_mensaje_jueves`
- Mensaje de Juan: "Che. Laura consiguió algo."
- "En la clínica de la prima. Le hacen los papeles."
- "Creo que me voy con ella."
- "Te quería contar a vos primero."

#### Viernes: `juan_llamado_viernes_pasajes`
- Llamada con voz temblorosa
- "Estuvimos mirando pasajes. Hay uno para el sábado que viene."
- "Una parte de mí quiere salir corriendo. Otra parte quiere quedarse."
- Pide encontrarse el sábado para hablar

### 2. Despedida Emocional (Sábado)

#### Escena: `juan_despedida_sabado`
**Ubicación:** Plaza de Jacinto Vera (barrio donde creció Juan)

**Estructura:**
1. **Contexto personal:** "Crecí a tres cuadras de acá. Esa panadería de la esquina. Iba con mi viejo los domingos."
2. **Confesión central:** "Tengo miedo de quedarme. Y tengo miedo de irme. Tengo miedo de todo."
3. **Conexión Diego/Ixchel:** "Ellos vinieron huyendo. Yo me voy buscando. Con pasaporte europeo. Con laburo esperando."
4. **Auto-reconocimiento:** "Yo toda la vida repitiendo 'vienen a sacarnos el laburo'. Y resulta que el que se va soy yo."
5. **Disculpa:** "Perdón por las boludeces que dije. Soy un hipócrita."
6. **Despedida física:** Abrazo largo, mano, o distancia (según elección del jugador)

**Variables según elección:**
- Abrazo: `juan_despedida_emotiva = true`, +2 relación, +2 conexión
- Mano: +1 relación, +1 conexión
- Distancia: sin bonificadores

### 3. Fragmentos Nocturnos de Juan

#### `fragmento_juan_noche_migracion`
- Juan y Laura haciendo cuentas en Excel
- Pasajes, alquiler, depósito, comida
- "Años de ahorrar para vacaciones que nunca llegaron"
- Mira fotos del barrio, la cancha, sus viejos
- Laura lo encuentra: "Todavía podemos no ir" / "No. Vamos. Es solo que me cuesta."

#### `fragmento_juan_ultima_noche`
- Dos valijas. Toda una vida en dos valijas.
- Mira el departamento por última vez
- Mensaje del padre: "Andá tranquilo, hijo. Nosotros estamos bien." (mentira de amor)
- Se duerme en el sillón con las valijas al lado

### 4. Reflexión del Protagonista

#### Escenas: `reflexion_juan_se_va`, `reflexion_protagonista_irse/quedarse`, `reflexion_quedarse_resistir`

**Estructura:**
1. Camino a casa pensando en Juan
2. Recuerda a todos los que se fueron (primos, compañeros del liceo)
3. Se pregunta: "¿Y yo? ¿Me iría?"
4. Reflexiona sobre lo que lo ata/sostiene al lugar

**Tres finales según elección:**
- **"Quedarse es resistir":** Alguien tiene que seguir abriendo la olla, cuidando el barrio. Bonus: +1 llama, +1 dignidad
- **"Quedarse es lo que me tocó":** Resignación realista. Bonus: +1 inercia
- **"Quedarse es una elección":** Las raíces que no se llevan en una valija. Bonus: +1 conexión, +1 dignidad

### 5. Mensaje desde España

#### Escena: `juan_mensaje_desde_espana`
- Una semana después: mensaje con número español
- "Che. Llegamos bien."
- Fotos de Valencia, de Juan y Laura sonriendo
- "Cuidate, boludo."
- Variable: `juan_mando_mensaje_espana = true`
- Reflexión: "Los que se van pero no se olvidan"

## Variables Nuevas

```ink
// Build-up
juan_menciono_espana (bool)
juan_seed_migracion (bool)
juan_considerando_irse (bool)
juan_pregunto_si_me_iria (bool)
juan_avanzo_migracion (bool)
juan_encuentro_despedida (bool)

// Despedida
juan_despedida_emotiva (bool)

// Post-migración
juan_mando_mensaje_espana (bool)
```

## Significado Temático

La migración de Juan ahora subraya:

1. **Inversión irónica:** Diego e Ixchel vinieron huyendo y se quedaron; Juan nació acá y se va buscando
2. **Privilegio:** Juan puede irse porque tiene pasaporte europeo y contactos; otros no tienen esa opción
3. **Hipocresía procesada:** Juan reconoce que repetía discursos anti-inmigrantes y ahora él es el migrante
4. **El miedo como motor:** Juan siempre tuvo miedo; el miedo lo hacía decir boludeces, y ahora el miedo lo hace irse
5. **Quedarse como resistencia:** La reflexión del protagonista conecta con el tema central de la obra

## Compatibilidad

- Si no se activa el build-up (variables no seteadas), la escena original `juan_despedida_migracion` sigue funcionando
- Las escenas nuevas son modulares y pueden activarse según el día y las decisiones del jugador
- Las escenas nocturnas pueden usarse independientemente como interludes

## Triggers Sugeridos

| Día | Escena | Condición |
|-----|--------|-----------|
| Lunes | `juan_almuerzo_lunes_espana` | `juan_relacion >= 2`, durante almuerzo |
| Martes | `juan_charla_martes_espana` | `juan_menciono_espana` |
| Miércoles | `juan_post_despido_miercoles` | `fui_despedido && juan_sabe_de_mi_despido` |
| Jueves | `juan_mensaje_jueves` | `juan_considerando_irse` |
| Viernes | `juan_llamado_viernes_pasajes` | `juan_avanzo_migracion` |
| Sábado | `juan_despedida_sabado` | `juan_encuentro_despedida` |
| Noche Jueves/Viernes | `fragmento_juan_noche_migracion` | `juan_avanzo_migracion` |
| Noche pre-viaje | `fragmento_juan_ultima_noche` | `juan_se_despidio` |
| Post-despedida | `reflexion_juan_se_va` | `juan_se_despidio` |
| +7 días | `juan_mensaje_desde_espana` | `juan_migra` |
