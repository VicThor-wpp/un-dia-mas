# Un Día Más - Análisis Exhaustivo y Sugerencias

> Análisis profundo del proyecto con recomendaciones para optimizar narrativa, mecánicas, lógica y enganche

**Fecha**: 2026-01-19
**Versión analizada**: Prototype v0.8

---

## 📊 Resumen Ejecutivo

**Un Día Más** es un proyecto narrativo sólido con:
- ✅ Temática potente y relevante (precariedad laboral)
- ✅ Estructura técnica limpia y modular
- ✅ Sistema de variables bien diseñado
- ✅ 5 finales con gatillos claros
- ✅ Documentación excepcional

**Áreas de oportunidad identificadas**:
- 🔸 Complejidad narrativa puede aumentarse
- 🔸 Mecánicas de dados subutilizadas
- 🔸 Algunos días carecen de tensión suficiente
- 🔸 Falta feedback inmediato al jugador sobre consecuencias
- 🔸 Sistema de ideas puede tener más peso mecánico

---

## 🎯 Fortalezas Actuales (Lo que ya funciona muy bien)

### 1. Arquitectura Modular Excelente
```
✅ Pattern de tunnels bien implementado
✅ Variables centralizadas en variables.ink
✅ Separación limpia: días / ubicaciones / personajes
✅ Sistema de helper functions (recursos.ink, dados.ink)
```

### 2. Decisiones Críticas Bien Diseñadas
- **Miércoles post-despido**: Turning point claro y emotivo
- **Jueves ayudar en olla**: Gate para final LA RED es brillante
- **Sábado llamar Marcos**: Ventana única funciona narrativamente

### 3. Sistema de NPCs Rico
- Cada NPC tiene arco, estado y relación
- Fragmentos nocturnos dan perspectiva externa
- Vínculo aleatorio aumenta rejugabilidad

### 4. Documentación de Clase Mundial
- NARRATIVE-MAP.md es exhaustivo
- FLOWCHARTS.md visualiza rutas perfectamente
- Fácil de mantener y extender

---

## 📖 NARRATIVA - Oportunidades de Mejora

### 1. **Días Lunes y Martes: Falta Tensión Creciente**

**Problema**: Los días 1-2 son demasiado "normales". El jugador no siente urgencia.

**Solución**: Amplificar señales de peligro

```ink
// LUNES - Añadir escena adicional
=== lunes_reunion_sorpresa ===
A las 3 PM, el jefe convoca reunión de último momento.

"Necesitamos hablar de números."

Tu estómago se tensa.
No es nada personal, dice.
Todavía.

* [Preguntar qué pasa] -> lunes_pregunta_directa
* [Quedarte callado] -> lunes_silencio_tension
```

**Implementación**:
- Añadir escena `lunes_reunion_numeros` en `dias/lunes.ink`
- Introducir variable `nivel_tension_laburo` (0-10)
- Usar como foreshadowing del despido

**Impacto**: El despido del miércoles golpea más fuerte si hubo build-up real.

---

### 2. **Jueves: La "Primera Vez Sin Trabajo" Necesita Más Peso**

**Problema**: El jueves es el primer día sin laburo, pero no se siente suficientemente desorientador.

**Solución**: Expandir la experiencia de "tiempo vacío"

```ink
=== jueves_despertar_sin_alarma ===
Te despertás.
No sonó alarma.

Mirás el reloj.
10:30 AM.

Hace 10 años que no dormís hasta las 10:30.

El silencio de la casa es raro.
El barrio tiene ruidos que nunca escuchaste.
Hay gente en la calle que nunca viste.

Porque siempre estabas laburando.

* [Levantarte igual como si tuvieras laburo]
    -> jueves_rutina_fantasma
* [Quedarte en cama un rato más]
    -> jueves_hundirse
```

**Nuevo concepto**: "Rutina Fantasma"
- Opción de seguir la rutina como si tuvieras trabajo
- Efecto: +dignidad, -1 salud_mental (negación)
- Texto: "Te vestís. Tomás café. Como si. Pero no hay a dónde ir."

---

### 3. **Viernes: La Crisis de la Olla Puede Ser Más Dramática**

**Problema**: La crisis se resuelve demasiado rápido. Falta stakes emocionales.

**Solución**: Expandir la crisis con dilema moral más fuerte

```ink
=== viernes_crisis_maxima ===
Sofía está sentada en el piso de la cocina.
No cocinando. Sentada.

"No hay nada. Llamé a todos los proveedores.
Pedí a todos los vecinos.
No alcanza."

Elena está callada. Diego mira el piso.

Hay 40 personas que van a venir a las 7.
Y no hay comida.

* [Proponer juntar plata entre todos los presentes]
    -> viernes_crisis_junta_interna
* [Proponer pedir préstamo a comercio barrio]
    -> viernes_crisis_deuda  // NUEVO
* [Proponer hacer colecta callejera]
    -> viernes_crisis_colecta
* [Proponer cancelar por hoy]
    -> viernes_crisis_cancelar  // NUEVO - opción dura
```

**Nueva opción: Cancelar la olla por un día**
- Costo emocional: -2 llama, -2 conexion, pero +1 dignidad (realismo)
- Texto: "No podemos dar lo que no tenemos. Mejor cerrar hoy que servir porquerías."
- Consecuencia: Sofía colapsa emocionalmente
- **Añade peso moral**: ¿Cerrar es rendirse o es responsable?

---

### 4. **Domingo: Falta Clímax Antes del Final**

**Problema**: El domingo es demasiado contemplativo. No hay momento culminante.

**Solución**: Añadir escena de cierre con todos los NPCs

```ink
=== domingo_encuentro_grupo ===
{participe_asamblea && ayude_en_olla:
    Pasás por la olla.
    No hay reunión hoy, pero hay gente.

    Sofía. Elena. Diego.
    {marcos_vino_a_asamblea: Incluso Marcos, parado lejos pero ahí.}

    Te ven. Te hacen señas.

    * [Acercarte]
        -> domingo_cierre_red
    * [Saludar de lejos y seguir]
        -> domingo_cierre_distante
}
```

**Nuevo concepto**: "Foto Final"
- Momento visual que captura estado de tu red
- Texto cambia según NPCs presentes y relaciones
- Sirve como preview emocional del final

---

### 5. **Ideas: Expandir Impacto Narrativo**

**Problema**: Las ideas solo cambian texto de finales. Pueden hacer más.

**Solución**: Ideas desbloquean opciones de diálogo únicas

```ink
=== sabado_asamblea_hablar ===
Sofía te mira. "¿Querés decir algo?"

* [Hablar sobre tu situación]
    -> asamblea_compartir_despido

* {idea_hay_cosas_juntos} [Hablar sobre lo aprendido esta semana]
    // NUEVO - Solo disponible si tenés la idea
    -> asamblea_speech_colectivo

* {idea_red_o_nada} [Contar la historia de Elena del 2002]
    // NUEVO - Pasás la antorcha
    -> asamblea_historia_elena
```

**Implementación**:
- Ideas como keys para opciones narrativas
- Opciones con ideas dan +1 llama extra
- Crea momento "payoff" para decisiones anteriores

---

## ⚙️ MECÁNICAS - Optimización y Amplificación

### 1. **Sistema de Dados: Gravemente Subutilizado**

**Problema**: Tienes `chequeo(modificador, dificultad)` pero casi no se usa. Solo 7 rolls en todo el juego.

**Oportunidad**: Integrar dados en decisiones sociales clave

```ink
=== jueves_olla_pelar_papas ===
Estás pelando papas con Elena.
Ella pela rápido, con práctica de años.

~ temp modificador = 0
{elena_relacion >= 3: ~ modificador = 1}  // Si la relación es buena

~ temp resultado = chequeo(modificador, 4)

{
- resultado == 2:  // Crítico
    Elena te mira.
    "Pelás como mi Raúl. Él también era metódico."
    Se le humedecen los ojos.
    ~ elena_relacion += 2
    -> elena_historia_raul

- resultado == 1:  // Éxito
    Elena asiente mientras trabajás.
    Hay algo cómodo en el silencio compartido.
    ~ elena_relacion += 1
    -> olla_seguir_cocinando

- resultado == -1:  // Fumble
    Te cortás el dedo.
    "Despacio, pibe."
    Elena te cura con alcohol.
    Es un momento íntimo.
    ~ elena_relacion += 1
    -> olla_curacion

- else:  // Fallo normal
    Pelás en silencio.
    -> olla_seguir_cocinando
}
```

**Implementación**: Añadir chequeos en:
- Conversaciones profundas (éxito = unlock historia)
- Colecta viernes (ya existe, expandir outcomes)
- Asamblea sábado (hablar en público)
- Llamadas telefónicas (¿contestan? ¿cómo?)

**Diseño**: Los dados NO determinan éxito/fallo binario. Determinan **qué tipo de historia desbloqueas**.

---

### 2. **Energía: Añadir Recuperación Estratégica**

**Problema**: Energía solo baja. No hay forma de recuperarla excepto dormir.

**Solución**: Momentos de recuperación contextual

```ink
=== function recuperar_energia(cantidad) ===
~ energia += cantidad
{energia > 5: ~ energia = 5}

// Ejemplo de uso
=== jueves_olla_servir_comida ===
Sirven comida a 50 personas.
Es agotador.
Pero hay algo.

Un pibe te mira y dice "gracias".
No lo conocés. No importa.

{ayude_en_olla:
    Sentís algo.
    No es felicidad.
    Es... propósito, quizás.

    ~ recuperar_energia(1)  // RECUPERACIÓN CONTEXTUAL
}
```

**Implementación**: Recuperar energía cuando:
- Ayudás en olla y recibís agradecimiento (+1)
- Conversación profunda con vínculo (+1)
- Asamblea donde propones y aceptan (+1)

**Balance**: Energía sigue siendo limitada, pero recompensar acción social incentiva gameplay conectado.

---

### 3. **Conexión y Llama: Hacerlas Más Visibles**

**Problema**: El jugador no sabe su conexion/llama hasta el final. No hay feedback.

**Solución**: Thresholds con notificaciones narrativas

```ink
=== function subir_conexion(cantidad) ===
~ temp conexion_antes = conexion
~ conexion += cantidad
{conexion > 10: ~ conexion = 10}

// NUEVO: Feedback narrativo en thresholds
{
- conexion >= 7 && conexion_antes < 7:
    # CONEXIÓN ALTA
    Algo cambió.
    Ya no te sentís tan solo.
    El barrio te conoce.
    Vos conocés al barrio.

- conexion >= 5 && conexion_antes < 5:
    # CONEXIÓN MEDIA
    Hay gente.
    No muchos. Pero hay.

- conexion <= 2 && conexion_antes > 2:
    # CONEXIÓN BAJA
    El aislamiento se siente físico.
    Pasás por la calle y nadie te mira.
    O quizás vos no mirás.
}
```

**Implementación**:
- Tags `# CONEXIÓN ALTA/MEDIA/BAJA` que el UI puede capturar
- Mostrar iconos/colores en UI según threshold
- Stats panel ya implementado - usar esto

---

### 4. **Salud Mental: Expandir Sistema**

**Problema**: Salud mental solo baja. Es un countdown a GRIS. Poco interesante.

**Solución**: Sistema de "Días Buenos / Días Malos"

```ink
// NUEVO en variables.ink
VAR dias_buenos_seguidos = 0
VAR dias_malos_seguidos = 0

// Al final de cada día
=== evaluar_dia ===
{
- conexion_dia >= 2 && energia_gastada >= 2:  // Día activo y social
    ~ dias_buenos_seguidos += 1
    ~ dias_malos_seguidos = 0
    {dias_buenos_seguidos >= 2:
        ~ salud_mental += 1  // Recuperación lenta
        Te sentís un poco mejor.
        No es mucho. Pero es algo.
    }

- conexion_dia <= 0 && energia_gastada <= 1:  // Día aislado
    ~ dias_malos_seguidos += 1
    ~ dias_buenos_seguidos = 0
    {dias_malos_seguidos >= 2:
        ~ salud_mental -= 1  // Declive acelerado
        El peso aumenta.
        Cada día es más difícil.
    }
}
```

**Implementación**:
- Tracking diario de actividad social vs. aislamiento
- Salud mental puede recuperarse MUY lentamente
- Añade esperanza: el jugador no está condenado

---

## 🧠 LÓGICA - Correcciones y Optimizaciones

### 1. **Bug Potencial: ayude_en_olla Como Booleano**

**Problema**: `ayude_en_olla` es bool, pero `veces_que_ayude` es int. Inconsistencia.

```ink
// ACTUAL
VAR ayude_en_olla = false  // Bool
VAR veces_que_ayude = 0    // Int
```

**Solución**: Unificar en contador

```ink
// PROPUESTO
// Eliminar: VAR ayude_en_olla = false

// Usar solo:
VAR veces_que_ayude = 0

// En finales.ink
=== evaluar_final ===
{conexion >= 7 && llama >= 5 && veces_que_ayude >= 2:
    -> final_red
}
```

**Justificación**:
- Más flexible (permite gradientes)
- Evita redundancia
- Permite finales más matizados

---

### 2. **Optimizar Variables de NPC**

**Problema**: Cada NPC tiene 5-8 variables específicas. Difícil escalar.

**Solución**: Sistema de flags agrupados

```ink
// ACTUAL (para cada NPC)
VAR sofia_estado = "activa"
VAR sofia_relacion = 2
VAR sofia_me_pidio_ayuda = false
VAR sofia_sabe_mi_situacion = false
VAR sofia_hijos_enfermos = false
// ... 8 variables

// PROPUESTO
VAR sofia_relacion = 2
VAR sofia_estado = "activa"
VAR sofia_flags = 0  // Bitfield
/*
Bit 0: me_pidio_ayuda
Bit 1: sabe_mi_situacion
Bit 2: hable_profundo
Bit 3: hijos_enfermos
... etc
*/

=== function sofia_tiene_flag(bit) ===
~ return (sofia_flags & (POW(2, bit))) > 0

=== function sofia_set_flag(bit) ===
~ sofia_flags = sofia_flags | POW(2, bit)
```

**Pros**: Escalable, menos variables globales
**Contras**: Menos legible para no-programadores

**Recomendación**: Mantener actual para prototipo. Considerar si escalas a 10+ NPCs.

---

### 3. **Missing: Sistema de "Puntos Sin Retorno"**

**Problema**: Puedes tomar decisiones que bloquean finales sin saberlo.

**Solución**: Advertencias sutiles narrativas

```ink
=== jueves_olla_decision ===
Sofía te mira.
"¿Podés quedarte? Necesitamos gente."

{
- not conte_a_alguien:
    # ADVERTENCIA SUTIL
    Podrías irte.
    Nadie sabe que estás acá.
    Nadie sabe nada.
    ¿Vas a seguir así toda la semana?
}

* [Ayudar] -> jueves_ayudar
* [Irte] -> jueves_irse
```

**Implementación**:
- No decir explícitamente "esto bloquea final X"
- Pero dar pista narrativa de que es decisión importante
- Tags `# DECISIÓN CRÍTICA` en código para testing

---

## 🎮 ENGANCHE - Amplificar Inmersión

### 1. **Falta: Sistema de "Ecos" - Tus Decisiones Resuenan**

**Problema**: Decisiones se sienten aisladas. No ves consecuencias encadenadas.

**Solución**: NPCs mencionan tus acciones pasadas

```ink
=== sabado_encuentro_diego ===
Diego te ve en la calle.

{ayude_en_olla && viernes_colecta:
    "Che, lo del viernes estuvo re bien.
    Sofía me dijo que fuiste vos el que propuso la colecta.
    Te re banco."

    Alguien notó.
    Alguien se acuerda.

    ~ diego_relacion += 1
}
{not ayude_en_olla:
    "¿Cómo andás?"

    Charla normal.
    No hay mucho que decir.
}
```

**Implementación**:
- Cada NPC referencia 1-2 decisiones pasadas
- Crea sensación de mundo que reacciona
- Valida que las elecciones importan

---

### 2. **Añadir: Micro-Decisiones de Personalidad**

**Problema**: Todas las decisiones son grandes y evidentes. Falta textura.

**Solución**: Decisiones pequeñas que definen voz

```ink
=== lunes_cafe_cocina ===
Tomás café en la cocina.

* [Tomar mate amargo]
    ~ personalidad_mate = "amargo"
* [Tomar mate dulce]
    ~ personalidad_mate = "dulce"
* [Café solo, sin azúcar]
    ~ personalidad_mate = "cafe_amargo"

// Luego, en escena olla:
=== jueves_olla_mate_ronda ===
Elena ceba.
Te pasa el mate.

{personalidad_mate == "amargo":
    "Sin azúcar, ¿no?"
    Asintás.
    "Yo también."
}
```

**Impacto**: Sensación de personaje único. No todos juegan al mismo protagonista.

**Implementación**: 5-10 micro-decisiones sobre:
- Bebidas (mate/café)
- Comida (cocinar vs. comprar)
- Música (radio vs. silencio)
- Rutinas (bañarse a la mañana vs. noche)

---

### 3. **Sistema de Momentos "Observables"**

**Problema**: Todo es interacción. Falta contemplación pasiva.

**Solución**: Escenas donde solo mirás

```ink
=== viernes_olla_antes_servir ===
Faltan 10 minutos para las 7.

Mirás alrededor:
- Sofía termina de cocinar
- Elena acomoda las sillas
- Diego trae bolsas de pan
- La gente empieza a llegar

No estás haciendo nada en este momento.
Solo estás viendo.

Hace una semana tenías laburo.
Hoy estás acá.

* [Seguir mirando] -> viernes_reflexion_momento
* [Ponerte a ayudar] -> viernes_servir_comida
```

**Impacto**: Momentos de respiro. Permitir al jugador procesar.

---

### 4. **Falta: Mini-Cliffhangers Entre Días**

**Problema**: Los días terminan y empiezan sin tensión narrativa.

**Solución**: Hooks al final de cada día

```ink
=== jueves_noche_fin ===
Te acostás.

El celular vibra.

Es un mensaje.

De Sofia.

"Mañana necesito hablar con vos.
Es importante."

* [Dormir preocupado] -> fragmento_jueves
```

**Implementación**: Cada día termina con:
- Mensaje misterioso
- Ruido extraño
- Recuerdo perturbador
- Noticia que afecta barrio

Crea continuidad narrativa y anticipación.

---

## 🚀 NUEVAS CARACTERÍSTICAS SUGERIDAS

### 1. **Sistema de "Flashbacks Elegidos"**

**Concepto**: Durante momentos de stress, aparecen flashbacks a tu `perdida` elegida en intro.

```ink
=== miercoles_despido_flashback ===
{perdida == "familiar":
    Salís de la oficina.
    Por un segundo, ves a tu vieja en la calle.
    No es ella. No puede ser.
    Pero por un segundo...

    Recordás cuando te dijo:
    "Mientras tengas laburo, estás bien."

    Ya no tenés laburo.
}

{perdida == "relacion":
    Salís.
    Pensás en llamar a alguien.
    Por un segundo, pensás en llamar a elle.

    Tu dedo va al contacto.
    Todavía está ahí.
    No lo borraste.

    No llamás.
}
```

**Impacto**: Las elecciones de intro tienen peso real en narrativa.

---

### 2. **"Ruta Oculta": Reconectar con Marcos**

**Concepto**: Si seguís intentando contactar a Marcos toda la semana, desbloqueas ruta especial.

```ink
// Tracking
VAR intentos_marcos = 0

// Lunes, Martes, Miércoles, Jueves, Viernes
// Cada vez: ~ intentos_marcos += 1

// Sábado
{intentos_marcos >= 4:
    Marcos contesta.
    Pero no dice "Dale, plaza."
    Dice: "Para. Vengo yo."

    -> marcos_viene_a_tu_casa  // NUEVO - Escena íntima
}
```

**Diseño**: Recompensar persistencia del jugador.

---

### 3. **Sistema de "Pequeñas Victorias"**

**Concepto**: Tracking de logros no-épicos

```ink
VAR pequenas_victorias = 0

// Cuando:
// - Cocinás en vez de no comer
// - Te bañás en día difícil
// - Salís de casa aunque no querés
// - Llamás a alguien

~ pequenas_victorias += 1

// En finales:
{pequenas_victorias >= 10:
    No salvaste el mundo.
    Pero te levantaste.
    Te lavaste.
    Saliste.

    Eso, a veces, es todo.
}
```

**Impacto**: Validar esfuerzos invisibles. Resonancia con quienes vivieron depresión/crisis.

---

### 4. **Nuevo Final Oculto: "LA LLAMA"**

**Concepto**: Final ultra-secreto si maximizás todo.

```ink
=== evaluar_final ===
// NUEVO - Antes que final_red
{
    conexion == 10
    && llama >= 8
    && veces_que_ayude >= 4
    && participe_asamblea
    && marcos_vino_a_asamblea
    && sofia_relacion >= 5
    && elena_relacion >= 5
    && todas_las_ideas:
    -> final_la_llama  // NUEVO
}
```

```ink
=== final_la_llama ===
# FINAL: LA LLAMA

El lunes llega.

No tenés laburo.
Pero tenés algo que pocos tienen.

La olla no solo sobrevivió.
Creció.

La asamblea no fue solo un evento.
Fue el principio.

Sofía te mira diferente.
Elena te dice "Raúl estaría orgulloso."
Diego ya no se siente tan solo.
Marcos volvió. De a poco. Pero volvió.

Y hay una llama.

No es esperanza ingenua.
Es conocimiento.
Que juntos, hay algo.

El sistema no cambió.
Pero ustedes sí.

Y la llama no se apaga.

# FIN - "Prendimos fuego"

-> END
```

**Requisitos**: Jugador perfecto. Solo 5-10% lo verán.
**Impacto**: Sensación de "true ending". Incentivo para rejugar.

---

## 🎨 PULIDO Y DETALLES

### 1. **Añadir Variedad de Fragmentos Nocturnos**

**Actual**: 1 fragmento por noche según vínculo.

**Propuesta**: 2-3 fragmentos alternos según decisiones del día.

```ink
=== fragmento_lunes ===
{
- almorzamos_juntos && fue_a_olla:
    -> fragmento_sofia_numeros  // Sofía cuenta donaciones
- almorzamos_juntos && not fue_a_olla:
    -> fragmento_juan_preocupado  // Juan piensa en reestructuración
- not almorzamos_juntos:
    -> fragmento_diego_madre  // Diego llama a Venezuela
}
```

---

### 2. **Weathering: Condiciones Climáticas Como Metáfora**

```ink
VAR clima_dia = "normal"

// Miércoles
~ clima_dia = "gris"

# MIÉRCOLES
El cielo está gris.
No llueve. Pero podría.
Todo el día se siente pesado.

// Sábado (si conexion alta)
~ clima_dia = "despejando"

# SÁBADO
El cielo está despejando.
No es sol pleno. Pero hay algo.
```

**Impacto**: Refuerzo emocional sin ser obvio.

---

### 3. **Música Diegética: Referencias Culturales Uruguayas**

```ink
=== jueves_olla_radio ===
La radio está prendida en la cocina.

Suena Jaime Roos.
"Brindis por Pierrot."

Elena la sube.

{vinculo == "elena":
    "Esta canción me recuerda al 2002."
    No te explica por qué.
    No hace falta.
}
```

**Implementación**: 5-6 referencias musicales/culturales uruguayas específicas.

---

## 🔧 IMPLEMENTACIÓN: Por Dónde Empezar

### Prioridad 1 (Impacto Alto, Esfuerzo Bajo)
1. ✅ Thresholds narrativos para conexion/llama (1-2 hrs)
2. ✅ Expandir crisis viernes con opción "cancelar" (2 hrs)
3. ✅ Sistema de "ecos" - NPCs mencionan acciones (3 hrs)
4. ✅ Cliffhangers entre días (2 hrs)

### Prioridad 2 (Impacto Alto, Esfuerzo Medio)
1. ✅ Más uso de sistema dados en conversaciones (4-5 hrs)
2. ✅ Ideas desbloquean opciones de diálogo (4 hrs)
3. ✅ Ampliar jueves "rutina fantasma" (3 hrs)
4. ✅ Domingo encuentro grupal (4 hrs)

### Prioridad 3 (Pulido y Extensión)
1. ✅ Final oculto LA LLAMA (5 hrs)
2. ✅ Sistema pequeñas victorias (4 hrs)
3. ✅ Flashbacks según perdida (5 hrs)
4. ✅ Ruta oculta Marcos (6 hrs)

---

## 📈 MÉTRICAS DE ÉXITO

**Cómo medir si las mejoras funcionan**:

1. **Rejugabilidad**: ¿Jugadores quieren ver otros finales?
   - Actual: 3-4 rutas principales
   - Target: 5-6 rutas significativamente diferentes

2. **Conexión Emocional**: ¿Jugadores reportan sentir peso de decisiones?
   - Añadir: Choices con tags `# HEAVY` para análisis

3. **Balance de Finales**: ¿Distribución de finales es sana?
   - Target: 30% LA RED, 20% QUIZÁS, 20% SOLO, 15% GRIS, 15% INCIERTO
   - Si >50% consiguen LA RED: demasiado fácil
   - Si <20% consiguen LA RED: demasiado difícil

4. **Tiempo de Juego**:
   - Actual: 1.5-2 hrs
   - Target con mejoras: 2-3 hrs (sin sentirse alargado)

---

## 💡 IDEAS RADICALES (Opcional - Cambios Grandes)

### 1. **Día 8: "Lunes Siguiente"**

**Concepto**: Añadir un día más DESPUÉS del final.

```ink
=== lunes_siguiente ===
# LUNES - UNA SEMANA DESPUÉS

El lunes llega.
Otra vez.

{final_actual == "red":
    Vas a la olla.
    -> lunes_red_continuidad
}
{final_actual == "solo":
    Te quedás en casa.
    -> lunes_solo_continuidad
}
```

**Impacto**: Muestra que la vida continúa. Los finales no son endpoints absolutos.

---

### 2. **Modo "Nueva Semana Plus"**

**Concepto**: Segunda playtbrough con eventos diferentes.

- Juan también despedido
- Olla cierra permanentemente
- Marcos responde antes
- Nuevas crisis surgen

**Impacto**: Rejugabilidad extrema. Mundo se siente vivo.

---

### 3. **Capítulo 2: "Tres Meses Después"**

**Concepto**: Sequel directo basado en savegame de final.

```ink
=== tres_meses_inicio ===
# TRES MESES DESPUÉS

{final_anterior == "red":
    La olla sigue.
    El barrio sigue.
    Vos seguís.
    Pero los tres meses se acabaron.
    -> capitulo2_red
}
```

**Alcance**: Proyecto ambicioso. Solo si querés expandir a juego más largo.

---

## 🎓 CONCLUSIÓN

**Un Día Más es un proyecto sólido con fundamentos excelentes.**

### Fortalezas a mantener:
- ✅ Arquitectura modular
- ✅ Decisiones críticas bien diseñadas
- ✅ Sistema de NPCs rico
- ✅ Temática relevante y emotiva

### Áreas de crecimiento:
- 🔸 Ampliar uso de sistema de dados
- 🔸 Mayor feedback inmediato al jugador
- 🔸 Tensión narrativa más sostenida
- 🔸 Consecuencias más visibles y encadenadas

### Recomendación Final:

**Fase 1**: Implementar mejoras de Prioridad 1 (10 hrs, impacto inmediato)
**Fase 2**: Testing con jugadores beta → ajustar balance
**Fase 3**: Implementar Prioridad 2 según feedback (15 hrs)
**Fase 4**: Pulido final y consideración de Prioridad 3 (15 hrs)

**Total para versión 1.0 mejorada**: ~40 horas de desarrollo adicional.

---

**Este juego tiene potencial de resonar profundamente con audiencia que vivió precariedad.**

La clave está en:
1. Hacer que cada decisión se sienta importante
2. Que las consecuencias sean visibles y naturales
3. Que el jugador sienta que su historia es única
4. Que el peso emocional sea real pero no abrumador

Tenés todos los building blocks. Ahora es pulir y amplificar.

---

**¿Preguntas? ¿Qué dirección te interesa explorar primero?**
