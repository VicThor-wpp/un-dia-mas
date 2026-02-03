// ============================================
// LUNES - ROUTING CON TUNNELS
// Solo controla el flujo, las escenas están en módulos
// ============================================

=== lunes_amanecer ===

~ dia_actual = 1
~ energia = 5

# LUNES

// AMBIENTE Y RADIO
-> ambiente_amanecer ->

// Despertar en casa (tunnel)
-> casa_despertar ->

// VOCES
-> voces_reaccion ->

// Después de despertar, continúa con la salida
-> lunes_salir

=== lunes_salir ===
// Salir de casa

-> casa_salir ->

// La parada del bondi
-> lunes_parada_bondi

=== lunes_parada_bondi ===

-> bondi_esperar_parada ->

// Después del bondi, verificar si llegó tarde
{ultima_tirada == 1:
    -> lunes_llegada_tarde
- else:
    -> lunes_llegada
}

=== lunes_llegada ===

-> laburo_llegada ->

-> lunes_manana

=== lunes_llegada_tarde ===

-> laburo_llegada_tarde ->

-> lunes_manana

=== lunes_manana ===

-> laburo_manana ->

// Encuentro con Juan
-> juan_saludo_manana ->

// Encuentro con Lucía (compañera sindicalista)
{RANDOM(1,2) == 1:
    -> lucia_escena_mate ->
}

// Trabajo de la mañana
-> laburo_trabajo_rutina ->

// Verificar si hay escena adicional con Juan
{hable_con_juan_sobre_rumores:
    -> lunes_pre_almuerzo_decision
- else:
    -> lunes_almuerzo
}

=== lunes_pre_almuerzo_decision ===

¿Qué hacés con la mirada del jefe?

* [Seguir laburando]
    -> lunes_almuerzo
* [Preguntarle a Juan] # STAT:conexion # EFECTO:conexion+
    -> juan_preguntar_sobre_jefe ->
    -> lunes_almuerzo
* {energia >= 2} [Hablar con el jefe] # COSTO:1 # DADOS:dignidad # EFECTO:dignidad?
    -> laburo_hablar_con_jefe ->
    -> lunes_almuerzo

=== lunes_almuerzo ===

# ALMUERZO

12:30.
Hora de comer.

{hable_con_juan_sobre_rumores:
    Juan te mira.
    "¿Hablaste con el jefe?"
    No contestás.
}

* [Almorzar con Juan] # EFECTO:conexion+
    -> juan_almuerzo ->
    -> lunes_tarde
* [Almorzar solo] # EFECTO:conexion-
    -> laburo_almuerzo_solo ->
    -> lunes_tarde
* [Saltear el almuerzo] # EFECTO:dignidad-
    -> laburo_almuerzo_saltear ->
    -> lunes_tarde

=== lunes_tarde ===

-> laburo_tarde ->

// La reunión de reestructuración
A las 4, el jefe llama a una reunión.
"Todos al salón grande."

* [Ir con los demás] -> lunes_reunion

=== lunes_reunion ===

-> laburo_reunion_general ->

-> juan_post_reunion ->

// Si fueron al bar, ya se despidieron ahí - ir directo al bondi
{fue_al_bar_con_juan:
    -> lunes_bondi_vuelta
}

A las 5, te vas.

-> laburo_salida ->

-> lunes_bondi_vuelta

=== lunes_bondi_vuelta ===

-> bondi_vuelta ->

El bondi llega al barrio.

* [Ir directo a casa] # EFECTO:conexion-
    -> lunes_ir_casa
* {energia >= 2} [Pasar por algún lado] # COSTO:1 # EFECTO:conexion?
    -> lunes_pasar

=== lunes_pasar ===

¿A dónde?

* [Por la olla] # COSTO:1 # EFECTO:llama+
    -> lunes_olla
* [Por lo de tu vínculo] # COSTO:1 # EFECTO:conexion+
    -> lunes_visita_vinculo
* [Por el kiosco] # COSTO:1
    -> lunes_kiosco

=== lunes_kiosco ===

# LOC:calle

~ energia -= 1

Pasás por el kiosco.
Comprás algo. Un alfajor. Una coca.

El kiosquero te conoce de vista.

* [...]
-

"¿Qué tal? Cara de cansado hoy."

"Día largo."

// Chequeo social: charla con el kiosquero
~ temp kiosco_charla = chequeo_social(0, 3)
{ kiosco_charla == 2:
    "¿Sabés qué? Tomá." Te da otro alfajor.
    "No te cobro ese. Cara de que lo necesitás."
    Le agradecés. A veces la gente te sorprende.
    ~ subir_conexion(1)
}
{ kiosco_charla == 1:
    "Son todos largos." Se queda un rato. "Pero se bancan."
    Asentiás. Se bancan.
}
{ kiosco_charla == 0:
    "Son todos largos."
    Silencio. Nada más.
}
{ kiosco_charla == -1:
    "Son todos largos. Y cada vez peor."
    Te mira y se da vuelta. Conversación terminada.
    Te vas sintiéndote peor que antes.
    ~ aumentar_inercia(1)
}

-> lunes_ir_casa

=== lunes_visita_vinculo ===

~ energia -= 1

{vinculo == "sofia": -> lunes_visita_sofia}
{vinculo == "elena": -> lunes_visita_elena}
{vinculo == "diego": -> lunes_visita_diego}
{vinculo == "marcos": -> lunes_visita_marcos}

=== lunes_visita_sofia ===

Pasás por lo de Sofía.
Está en la puerta, los pibes adentro.

"¿Todo bien?"

* [Contarle del laburo] # STAT:conexion # EFECTO:conexion+
    ~ subir_conexion(1)
    Le contás. Los rumores. La reunión.
    "En la olla estamos peor", dice. "Pero entiendo."
    -> lunes_ir_casa
* ["Sí, todo bien."] # EFECTO:conexion-
    "Si necesitás algo..."
    -> lunes_ir_casa

=== lunes_visita_elena ===
    -> elena_conversacion ->
    -> lunes_ir_casa

=== lunes_visita_diego ===

Encontrás a Diego en la esquina.

"¿Qué onda?"
"Acá. Saliendo del depósito."

Hablan un rato.
Diego también tiene miedo.

~ subir_conexion(1)

-> lunes_ir_casa

=== lunes_visita_marcos ===

Llamás a Marcos.
No contesta.

"Visto."
No responde.

-> lunes_ir_casa

=== lunes_olla ===

# LOC:olla

~ energia -= 1

Pasás por la olla.
Sofía está adentro.

"¿Buscás algo?"

* ["Pasaba nomás."]
    "Si alguna vez querés sumarte a construir..."
    -> lunes_ir_casa
* ["¿Puedo ayudar?"] # COSTO:1 # STAT:conexion # EFECTO:conexion+ # EFECTO:llama+
    ~ subir_conexion(1)
    ~ subir_llama(1)
    ~ energia -= 1
    Te ponen a ordenar cosas.
    No es mucho. Pero es algo.
    -> lunes_ir_casa

=== lunes_ir_casa ===

-> casa_llegada_noche ->

-> lunes_dormir

=== lunes_dormir ===

// DIARIO DE CONCIENCIA
-> diario_escribir ->

// Reflexión nocturna (Fase 3)
-> reflexion_nocturna ->

* [Dormir] -> lunes_fragmentos

=== lunes_fragmentos ===

# LOC:casa
# MIENTRAS DORMÍS

-> juan_fragmento_noche ->

// Fragmento del vínculo
{vinculo == "sofia": -> fragmento_sofia_lunes}
{vinculo == "elena": -> fragmento_elena_lunes}
{vinculo == "diego": -> fragmento_diego_lunes}
{vinculo == "marcos": -> fragmento_marcos_lunes}
-> lunes_cliffhanger

=== fragmento_sofia_lunes ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Sofía está agotada.

    Piensa en vos.
    En cómo te arrastraste hoy.
    En cómo aceptaste todo.

    "Así termina la gente", piensa.
    "Aceptando cualquier cosa."

    ~ aumentar_inercia(1)
    * [Continuar] -> lunes_cliffhanger
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Sofía cierra la olla temprano.

    Nadie vino.
    Otra vez nadie vino.

    "¿Para qué?", se pregunta.

    Mañana quizás tampoco abra.

    ~ bajar_llama(1)
    * [Continuar] -> lunes_cliffhanger
}

// FRAGMENTO NORMAL
Sofía tampoco duerme bien.

Los números de la olla no cierran.
Hace tres meses que no cierran.

Mañana hay que seguir.

* [Continuar] -> lunes_cliffhanger

=== fragmento_elena_lunes ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Elena te vio hoy.

    Te vio aceptar.
    Te vio agachar la cabeza.
    Te vio convertirte en lo que no eras.

    "El 2002 también quebró gente así", piensa.
    "Los que se dejaron quebrar."

    ~ aumentar_inercia(1)
    * [Continuar] -> lunes_cliffhanger
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Elena prende la radio.

    Hablan de la crisis.
    De los despidos.
    De la gente sola.

    Apaga la radio.
    Ella también está sola.

    "Ya nadie se cuida", piensa.

    ~ bajar_llama(1)
    * [Continuar] -> lunes_cliffhanger
}

// FRAGMENTO NORMAL
Elena no puede dormir.

La radio dice cosas.
"Antes nos cuidábamos más", piensa.

Apaga la radio.

* [Continuar] -> lunes_cliffhanger

=== fragmento_diego_lunes ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Diego piensa en vos.

    En cómo te vio hoy.
    Roto. Doblado.

    "Yo también voy a terminar así", piensa.
    "Todos terminamos así."

    Llama a su madre.
    Cuelga antes de que atienda.

    ~ aumentar_inercia(1)
    * [Continuar] -> lunes_cliffhanger
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Diego está solo en su pieza.

    Nadie lo llamó hoy.
    Nadie lo llamó ayer.
    Nadie lo va a llamar mañana.

    Piensa en Venezuela.
    Allá estaba solo.
    Acá está solo.

    No hay diferencia.

    ~ bajar_llama(1)
    * [Continuar] -> lunes_cliffhanger
}

// FRAGMENTO NORMAL
Diego está despierto.

Piensa en su madre.
En Venezuela.
En todo lo que dejó.

* [Continuar] -> lunes_cliffhanger

=== fragmento_marcos_lunes ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Marcos te reconoce.

    Ahora sos como él.
    Quebrado. Funcional. Vacío.

    "Bienvenido", piensa.
    Pero no siente nada.

    Ya no queda nada que sentir.

    ~ aumentar_inercia(1)
    * [Continuar] -> lunes_cliffhanger
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Marcos está solo.

    Dejó de esperar que cambie.
    Dejó de esperar que alguien llame.
    Dejó de esperar.

    La gente no se junta.
    La gente no se organiza.
    La gente no hace nada.

    Nunca lo hizo. Nunca lo hará.

    ~ bajar_llama(1)
    * [Continuar] -> lunes_cliffhanger
}

// FRAGMENTO NORMAL
Marcos está solo.
Como siempre.

No es felicidad.
Es funcionar.

* [Continuar] -> lunes_cliffhanger

=== lunes_cliffhanger ===

El celular vibra.

Un mensaje de grupo del laburo.

"Mañana reunión de área. Obligatoria."

No dice más.

* [Dormir inquieto] -> transicion_lunes_martes

=== transicion_lunes_martes ===
// Procesamiento nocturno de ideas y recursos
~ evaluar_ideas_involuntarias()
~ evaluar_dignidad_nocturna()
~ efecto_red_o_nada()
~ efecto_noche_solitaria()

// Chequeo de colapso mental antes de continuar
{inercia >= 10:
    -> final_apagado
}

// Chequeo de destrucción del tejido social
{llama <= 0:
    -> final_sin_llama
}

-> martes_amanecer
