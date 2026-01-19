// ============================================
// LUNES - ROUTING CON TUNNELS
// Solo controla el flujo, las escenas están en módulos
// ============================================

=== lunes_amanecer ===

~ dia_actual = 1
~ energia = 4

# LUNES

// Despertar en casa (tunnel)
-> casa_despertar ->

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
-> renzo_saludo_manana ->

// Trabajo de la mañana
-> laburo_trabajo_rutina ->

// Verificar si hay escena adicional con Juan
{hable_con_renzo_sobre_rumores:
    -> lunes_pre_almuerzo_decision
- else:
    -> lunes_almuerzo
}

=== lunes_pre_almuerzo_decision ===

¿Qué hacés con la mirada del jefe?

* [Seguir laburando]
    -> lunes_almuerzo
* [Preguntarle a Juan] # STAT:conexion # EFECTO:conexion+
    -> renzo_preguntar_sobre_jefe ->
    -> lunes_almuerzo
* {energia >= 2} [Hablar con el jefe] # COSTO:1 # DADOS:dignidad # EFECTO:dignidad?
    -> laburo_hablar_con_jefe ->
    -> lunes_almuerzo

=== lunes_almuerzo ===

# ALMUERZO

12:30.
Hora de comer.

* [Almorzar con Juan] # EFECTO:conexion+
    -> renzo_almuerzo ->
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

-> renzo_post_reunion ->

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

~ energia -= 1

Pasás por el kiosco.
Comprás algo. Un alfajor. Una coca.

El kiosquero te conoce de vista.

"¿Qué tal? Cara de cansado hoy."

"Día largo."

"Son todos largos."

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

Pasás por lo de Elena.
Está tomando café afuera, en un vaso térmico.

"Vení, sentate."

* [Contarle] # STAT:conexion # EFECTO:conexion+
    ~ subir_conexion(1)
    Le contás.
    "En el 2002 Raúl perdió el laburo. Pero salimos. Juntos."
    -> lunes_ir_casa
* ["Normal."] # EFECTO:conexion-
    No te cree. Pero no insiste.
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

~ energia -= 1

Pasás por la olla.
Sofía está adentro.

"¿Buscás algo?"

* ["Pasaba nomás."]
    "Si alguna vez querés dar una mano..."
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

* [Dormir] -> lunes_fragmentos

=== lunes_fragmentos ===

# MIENTRAS DORMÍS

-> renzo_fragmento_noche ->

// Fragmento del vínculo
{vinculo == "sofia": -> fragmento_sofia_lunes}
{vinculo == "elena": -> fragmento_elena_lunes}
{vinculo == "diego": -> fragmento_diego_lunes}
{vinculo == "marcos": -> fragmento_marcos_lunes}
-> martes_amanecer

=== fragmento_sofia_lunes ===

Sofía tampoco duerme bien.

Los números de la olla no cierran.
Hace tres meses que no cierran.

Mañana hay que seguir.

* [Continuar] -> martes_amanecer

=== fragmento_elena_lunes ===

Elena no puede dormir.

La radio dice cosas.
"Antes nos cuidábamos más", piensa.

Apaga la radio.

* [Continuar] -> martes_amanecer

=== fragmento_diego_lunes ===

Diego está despierto.

Piensa en su madre.
En Venezuela.
En todo lo que dejó.

* [Continuar] -> martes_amanecer

=== fragmento_marcos_lunes ===

Marcos está solo.
Como siempre.

No es felicidad.
Es funcionar.

* [Continuar] -> martes_amanecer
