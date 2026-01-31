// ============================================
// DOMINGO - EL FIN DE LA SEMANA
// Patron modular con tunnels
// Conecta con finales/finales.ink
// ============================================

// Tunnels usados de otros modulos:
// - ubicaciones/barrio.ink: barrio_domingo, barrio_grupo_olla
// - personajes/sofia.ink: sofia_llamar, sofia_conversacion_telefono
// - personajes/elena.ink: elena_llamar, elena_conversacion_telefono
// - personajes/diego.ink: diego_llamar, diego_conversacion_telefono
// - personajes/marcos.ink: marcos_llamar, marcos_conversacion_telefono, marcos_domingo_olla

=== domingo_amanecer ===

~ dia_actual = 7
~ energia = 5  // Domingo, descansaste

# DOMINGO

// --- Ecos del sábado ---
{participe_asamblea:
    La asamblea de ayer fue... algo.
    {marcos_vino_a_asamblea: Marcos estaba. No dijiste nada. Pero estaba.}
    Hoy es domingo.
    Último día de la semana.
}
{not participe_asamblea:
    Domingo.
    Ayer no fuiste a nada.
    Hoy tampoco hay nada.
    O capaz que sí, pero no te enteraste.
}

Una semana.

Hace una semana eras otra persona.
Tenías laburo.
Tenías rutina.
Tenías algo.

* [...]
-

Ahora no tenés nada. Unipersonal.
Sin derechos. Sin colchón. Sin respuestas.

* [Levantarte] -> domingo_manana

=== domingo_manana ===

Domingo.
El día más lento.

{participe_asamblea: Ayer fue la asamblea. Hoy es día de procesar.}
{not participe_asamblea: No fuiste a la asamblea. No sabés qué pasó.}

La mañana está ahí.
Esperando.

¿Qué hacés?

* [Quedarte en casa, pensar] # EFECTO:conexion-
    -> domingo_pensar
* [Salir al barrio] # COSTO:1 # EFECTO:conexion?
    -> domingo_barrio
* [Llamar a tu vínculo] # EFECTO:conexion+
    -> domingo_llamar

=== domingo_pensar ===

Te quedás.
Pensás.

La semana que pasó.
Lo que viene.

// Chequeo mental: la reflexión final del domingo
# DADOS:CHEQUEO
~ temp resultado_domingo_reflexion = chequeo_completo_mental(conexion, 4)
{ resultado_domingo_reflexion == 2:
    La cabeza se aquieta. Por primera vez en días.

    Algo se acomoda. No es una respuesta. Es una calma.

    Una semana atrás eras otro. Tenías laburo y nada más.
    Ahora no tenés laburo. Pero tenés algo que antes no tenías.

    {conexion >= 6: Gente. Caras. Nombres. Una red que no sabías que existía.}
    {conexion < 6: Algo. Todavía no sabés qué. Pero algo.}

    ~ subir_dignidad(1)
    ~ disminuir_inercia(1)
}
{ resultado_domingo_reflexion == 1:
    {inercia <= 6:
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
}
{ resultado_domingo_reflexion == 0:
    La cabeza da vueltas.
    No llegás a ningún lado.

    {conexion >= 4: Al menos hay gente. Eso debería alcanzar. Pero hoy no alcanza.}
    {conexion < 4: Estás solo. Y el domingo es el peor día para estar solo.}

    La tarde va a ser larga.
}
{ resultado_domingo_reflexion == -1:
    La cabeza explota.

    Todo se mezcla. El laburo. La plata. La olla. Las caras.
    ¿Qué sentido tiene? ¿Para qué?

    El domingo es un espejo. Y no te gusta lo que ves.

    ~ aumentar_inercia(1)
}

* [Ir a la tarde] -> domingo_tarde

=== domingo_barrio ===

~ energia -= 1

Salís.

// Ambiente de domingo
-> barrio_domingo ->

// Marcos en la olla - domingo
{marcos_vino_a_asamblea && marcos_relacion >= 4:
    -> marcos_domingo_olla ->
}

-> domingo_encuentro_grupo

=== domingo_encuentro_grupo ===

Pasás por la olla.
No hay reunión hoy. Pero hay gente.

* [...]
-

{participe_asamblea && ayude_en_olla:
    Sofía está afuera.
    Elena toma mate en la vereda.
    Diego ordena cosas.
    {marcos_vino_a_asamblea: Marcos está parado lejos, pero ahí.}
    Te ven.

    * [Acercarte]
        -> domingo_cierre_red
    * [Saludar de lejos y seguir]
        -> domingo_cierre_distante
}
{participe_asamblea && not ayude_en_olla:
    Hay gente.
    Te miran.
    Saludan, pero...
    Hay algo raro.
    No sos parte. No del todo.

    * [Acercarte igual] -> domingo_cierre_intento
    * [Seguir de largo] -> domingo_cierre_distante
}
{not participe_asamblea:
    La olla está cerrada.
    No hay nadie.
    O quizás hay, pero no te ven.
    O no te buscan.

    * [Seguir] -> domingo_tarde
}

=== domingo_cierre_red ===

Te acercás.

Sofía te pasa un mate.
Elena te hace lugar en el banco.
Diego asiente.

* [...]
-

{marcos_vino_a_asamblea:
    Marcos te mira desde lejos.
    Levanta la mano.
    Es un gesto mínimo.
    Pero es algo.
}

* [...]
-

Nadie dice nada importante.
Pero están.
Y vos estás.

Esto es algo.

~ subir_conexion(1)

* [Quedarte un rato] -> domingo_tarde

=== domingo_cierre_distante ===

Saludás de lejos.
Seguís caminando.

Hay distancia.
Elegiste que la haya.
O la distancia te eligió.

* [Seguir] -> domingo_tarde

=== domingo_cierre_intento ===

Te acercás.

Sofía te mira.
Elena asiente.
Diego dice algo.

Pero no estás. No del todo.
Faltó algo. Ayudar, quizás.
O solo estar más.

No te rechazan.
Pero tampoco te llaman.

* [Quedarte un poco] -> domingo_tarde

=== domingo_llamar ===

{vinculo == "sofia": -> domingo_llamar_sofia}
{vinculo == "elena": -> domingo_llamar_elena}
{vinculo == "diego": -> domingo_llamar_diego}
{vinculo == "marcos": -> domingo_llamar_marcos}

// Fallback (should never reach)
-> domingo_tarde

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

* [...]
-

La semana que viene:
- Hay que buscar laburo.
- Hay que ver qué pasa con la olla.
- Hay que seguir viviendo.

{conexion >= 6: Al menos no estás solo.}
{conexion < 4: Estás bastante solo. Quizás la semana que viene...}

{llama >= 5: Hay algo de esperanza. Pequeña, pero ahí.}
{llama < 3: Todo se ve gris. Pero mañana es otro día.}

* [Ir a la noche] -> domingo_noche

=== domingo_noche ===

# DOMINGO - NOCHE

El final de la semana.

Te sentás.
Pensás en todo.

* [...]
-

Una semana.
{fui_despedido: Te echaron.}
{ayude_en_olla: Ayudaste en la olla.}
{participe_asamblea: Fuiste a una asamblea.}
{conte_a_alguien: Le contaste a alguien.}

* [...]
-

{not conte_a_alguien && not ayude_en_olla: Estuviste bastante solo esta semana.}

{juan_sabe_mi_situacion: Juan sabe lo que pasó. Te bancó a su manera.}

// Fragmento nocturno final
-> seleccionar_fragmento_domingo ->

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

* [Ver el final] -> sintesis_ideas

=== sintesis_ideas ===

~ idea_momento_sintesis = true
~ check_sinergias()

{ideas_activas >= 1:
    Un momento de silencio.
    Las ideas de la semana se acomodan.
}

{sinergia_colectiva >= 2:
    Algo se armó esta semana. No fue solo vos.
    Pedir ayuda, hacer juntos, sostener la red.
    Esas tres cosas se cruzan. Se sostienen.
}

{sinergia_individual >= 2:
    Algo cambió adentro. Todavía no sabés qué.
    Pero el tiempo y las preguntas dejaron marca.
}

{ideas_activas >= 4:
    Fue una semana entera. No una semana cualquiera.
    Algo se movió. En vos. En el barrio. En los dos.
}

{ideas_activas == 0:
    La semana pasó.
    No sabés si algo cambió.
}

* [...] -> cierres_fase_2

// ============================================
// CIERRES DE PERSONAJES FASE 2
// ============================================

=== cierres_fase_2 ===

// Lucía - cierre sindical
-> lucia_cierre_domingo ->

// Tiago - resultado de su decisión
-> tiago_domingo ->

// Cacho - reflexión
-> cacho_domingo ->

// Bruno - resultado del conflicto
-> bruno_domingo ->

// Claudia - resultado de la auditoría
-> claudia_domingo ->

// Redención de Cacho si aplica
-> cacho_redencion ->

// Tiago en asamblea si aplica
-> tiago_en_asamblea ->

// Lucía en asamblea si aplica
-> lucia_en_asamblea ->

-> evaluar_final

=== evaluar_final ===

// Evaluamos variables para determinar el final
// Los finales estan definidos en finales/finales.ink

// FINAL MÁS DURO - Colapso mental individual (peso alto = malo)
{inercia >= 10:
    -> final_apagado
}

// FINAL DESTRUCCIÓN TEJIDO SOCIAL - Colapso colectivo
{llama <= 0:
    -> final_sin_llama
}

// FINAL RESISTENCIA SILENCIOSA - Ayudaste sin participar en asamblea
{evaluar_resistencia_silenciosa():
    -> final_resistencia_silenciosa
}

// FINAL DESPERTAR - Te recuperaste de una espiral
{evaluar_despertar():
    -> final_despertar
}

// FINAL JUAN MIGRANTE - Juan se fue y te despediste
{evaluar_juan_migrante():
    -> final_juan_migrante
}

// FINAL REPRESIÓN - Intentaste luchar y te reprimieron
// Requiere intento de acción radical con mala suerte
{participe_asamblea && conexion >= 5 && llama >= 5 && inercia <= 4:
    -> final_represion
}

// FINAL HUELGA - Huelga salvaje organizada desde abajo
{participe_asamblea && veces_que_ayude >= 2 && llama >= 6 && conexion >= 6 && diego_relacion >= 4:
    -> final_huelga
}

// FINAL OCUPACIÓN - Ocupación de fábrica
{participe_asamblea && conexion >= 7 && llama >= 7 && veces_que_ayude >= 3:
    -> final_ocupacion
}

// FINAL IXCHEL - Requiere vínculo con Ixchel
{vinculo == "ixchel" && ixchel_relacion >= 4 && ixchel_conto_historia && ayude_en_olla:
    -> final_tejido
}

// FINAL OCULTO - Requiere perfección
{conexion >= 9 && llama >= 8 && veces_que_ayude >= 3 && participe_asamblea && marcos_vino_a_asamblea && sofia_relacion >= 4 && elena_relacion >= 4 && tiene_todas_ideas():
    -> final_la_llama
}

// FINAL LUCHA COLECTIVA - Participación activa
{evaluar_lucha_colectiva():
    -> final_lucha_colectiva
}

// FINAL RED - Comunidad como red
{conexion >= 7 && llama >= 5 && ayude_en_olla:
    -> final_red
}

// FINAL DESERCIÓN - Abandonar el circuito laboral
// Requiere desconexión del sistema pero conexión con la comunidad
{not tiene_laburo && conexion >= 5 && inercia <= 4:
    -> final_desercion
}

// FINAL VULNERABILIDAD - Apertura emocional genuina
{evaluar_vulnerabilidad():
    -> final_vulnerabilidad_honesta
}

// FINAL SOLO - Aislamiento completo
{conexion <= 3 && llama <= 2:
    -> final_solo
}

// FINAL GRIS - Depresión y soledad (peso alto = malo)
{inercia >= 8 && conexion <= 4:
    -> final_gris
}

// FINAL PEQUEÑO CAMBIO - Algo movió adentro
{evaluar_pequeno_cambio():
    -> final_pequeno_cambio
}

// Default: segun nivel de conexion
{conexion >= 5:
    -> final_quizas
- else:
    -> final_incierto
}
