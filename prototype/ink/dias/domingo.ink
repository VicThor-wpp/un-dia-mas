// ============================================
// DOMINGO - EL FIN DE LA SEMANA
// Patron modular con tunnels
// Conecta con finales/finales.ink
// ============================================

// Tunnels usados de otros modulos:
// - escenas/barrio.ink: barrio_domingo, barrio_grupo_olla
// - personajes/sofia.ink: sofia_llamar, sofia_conversacion_telefono
// - personajes/elena.ink: elena_llamar, elena_conversacion_telefono
// - personajes/diego.ink: diego_llamar, diego_conversacion_telefono
// - personajes/marcos.ink: marcos_llamar, marcos_conversacion_telefono

=== domingo_amanecer ===

~ dia_actual = 7
~ energia = 5  // Domingo, descansaste

# DOMINGO

Una semana.

Hace una semana eras otra persona.
Tenías laburo.
Tenías rutina.
Tenías algo.

Ahora tenés tres meses de indemnización.
Y un montón de preguntas.

* [Levantarte] -> domingo_manana

=== domingo_manana ===

Domingo.
El día más lento.

{participe_asamblea: Ayer fue la asamblea. Hoy es día de procesar.}
{not participe_asamblea: No fuiste a la asamblea. No sabés qué pasó.}

La mañana está ahí.
Esperando.

¿Qué hacés?

* [Quedarte en casa, pensar]
    -> domingo_pensar
* [Salir al barrio] # COSTO:1
    -> domingo_barrio
* [Llamar a tu vínculo]
    -> domingo_llamar

=== domingo_pensar ===

Te quedás.
Pensás.

La semana que pasó.
Lo que viene.

{trauma >= 2:
    La cabeza no para.
    ¿Quién sos ahora?
    ¿Qué hacés?
    ¿Qué viene?
}

{conexion >= 6:
    Pero no estás solo.
    Esta semana conociste gente.
    O reconectaste con gente.
    Eso es algo.
}

{conexion < 4:
    Estás bastante solo.
    Esta semana no conectaste mucho.
    La soledad pesa.
}

* [Ir a la tarde] -> domingo_tarde

=== domingo_barrio ===

~ energia -= 1

Salís.

// Ambiente de domingo
-> barrio_domingo ->

Pasás por la olla.
Cerrada. Domingos no abre.

Pero hay gente afuera igual.
Hablando.
Sofía. Elena. Otros.

* [Acercarte] -> domingo_grupo
* [Seguir de largo] -> domingo_tarde

=== domingo_grupo ===

// Grupo de la olla en el barrio
-> barrio_grupo_olla ->

-> domingo_tarde

=== domingo_llamar ===

{vinculo == "sofia": -> domingo_llamar_sofia}
{vinculo == "elena": -> domingo_llamar_elena}
{vinculo == "diego": -> domingo_llamar_diego}
{vinculo == "marcos": -> domingo_llamar_marcos}

=== domingo_llamar_sofia ===

// Llamar a Sofia
-> sofia_llamar ->

// Conversacion telefonica
-> sofia_conversacion_telefono ->

-> domingo_tarde

=== domingo_llamar_elena ===

// Llamar a Elena
-> elena_llamar ->

// Conversacion telefonica
-> elena_conversacion_telefono ->

-> domingo_tarde

=== domingo_llamar_diego ===

// Llamar a Diego
-> diego_llamar ->

// Conversacion telefonica
-> diego_conversacion_telefono ->

-> domingo_tarde

=== domingo_llamar_marcos ===

// Llamar a Marcos
-> marcos_llamar ->

// Conversacion telefonica
-> marcos_conversacion_telefono ->

-> domingo_tarde

=== domingo_tarde ===

# DOMINGO - TARDE

La tarde.
El sol baja.

Mañana es lunes.
Pero no hay laburo al que ir.

La semana que viene:
- Hay que buscar laburo.
- Hay que ver qué pasa con la olla.
- Hay que seguir viviendo.

{conexion >= 6: Al menos no estás solo.}
{conexion < 4: Estás bastante solo. Quizás la semana que viene...}

{la_llama >= 5: Hay algo de esperanza. Pequeña, pero ahí.}
{la_llama < 3: Todo se ve gris. Pero mañana es otro día.}

* [Ir a la noche] -> domingo_noche

=== domingo_noche ===

# DOMINGO - NOCHE

El final de la semana.

Te sentás.
Pensás en todo.

Una semana.
{fui_despedido: Te echaron.}
{ayude_en_olla: Ayudaste en la olla.}
{participe_asamblea: Fuiste a una asamblea.}
{conte_a_alguien: Le contaste a alguien.}

{not conte_a_alguien && not ayude_en_olla: Estuviste bastante solo esta semana.}

-> domingo_resumen_ideas

=== domingo_resumen_ideas ===

Las ideas que internalizaste:
{idea_tengo_tiempo: - "Ahora tengo tiempo para esto."}
{idea_pedir_no_debilidad: - "Pedir ayuda no es debilidad."}
{idea_hay_cosas_juntos: - "Hay cosas que se hacen juntos."}
{idea_red_o_nada: - "La red o la nada."}
{idea_quien_soy: - "¿Quién soy sin laburo?" (involuntaria)}
{idea_esto_es_lo_que_hay: - "Esto es lo que hay." (involuntaria)}

La semana termina.
El juego también.
Por ahora.

* [Ver el final] -> evaluar_final

=== evaluar_final ===

// Evaluamos variables para determinar el final
// Los finales estan definidos en finales/finales.ink

{conexion >= 7 && la_llama >= 5 && ayude_en_olla:
    -> final_red
}

{conexion <= 3 && la_llama <= 2:
    -> final_solo
}

{acumulacion >= 5:
    -> final_walter
}

{trauma >= 4 && conexion <= 4:
    -> final_gris
}

// Default: segun nivel de conexion
{conexion >= 5:
    -> final_quizas
- else:
    -> final_incierto
}
