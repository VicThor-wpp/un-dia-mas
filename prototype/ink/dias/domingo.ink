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
~ recuperar_energia_diaria()

# DOMINGO

// AMBIENTE Y RADIO
-> ambiente_amanecer ->

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
Tenías certezas.

// VOCES
-> voces_reaccion ->

* [...]
-

Ahora eso se cayó. Unipersonal, te dijeron.
Sin derechos de empleado. Pero con tres meses de colchón.
Y un barrio que no conocías tanto como ahora.

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

* [...]
-

// --- Flashbacks de la semana ---
{fui_despedido:
    El miércoles.
    La oficina. El papel. "Tu puesto fue afectado."
    Cuatro días. Parece un mes.
}

{ayude_en_olla:
    La olla. El vapor. Las manos pelando papas.
    Gente que no conocías hace una semana.
    Gente que ahora sabe tu nombre.
}

{participe_asamblea:
    La asamblea del sábado.
    Hablaste. O escuchaste. O las dos cosas.
    Fue raro. Pero fue real.
}

{conte_a_alguien:
    Le contaste a alguien.
    Dijiste en voz alta lo que te pasó.
    No se arregló nada. Pero pesó menos.
}

{not conte_a_alguien:
    No le contaste a nadie.
    Todavía cargás eso solo.
    Pesa.
}

* [...]
-

// --- Sensaciones físicas según estado ---
{inercia >= 7:
    El cuerpo no responde bien.
    Las piernas pesan. La cabeza zumba.
    Una semana así y ya sentís que no podés más.
}
{inercia <= 3:
    Estás cansado pero entero.
    Una semana difícil. Pero estás acá.
}

{conexion >= 6:
    El teléfono suena a veces.
    Gente que pregunta cómo estás.
    No es que tenés todo resuelto.
    Pero no estás solo.
}
{conexion <= 3:
    El teléfono no suena.
    Nadie pregunta.
    El domingo es el peor día para estar solo.
}

* [...]
-

// --- Memorias de NPCs según relación ---
{sofia_relacion >= 3:
    Pensás en Sofía. En las ojeras. En cómo sostiene todo.
    Ojalá alguien la sostenga a ella.
}
{elena_relacion >= 3:
    Pensás en Elena. En el 2002. En que ella ya pasó por esto.
    Y sigue acá.
}
{diego_relacion >= 3:
    Pensás en Diego. En Venezuela. En el depósito.
    En que él también tiene miedo pero no para.
}
{marcos_relacion >= 3:
    Pensás en Marcos. En el silencio. En la plaza.
    En que a veces volver es más difícil que irse.
}

// --- Momento profundo con vínculo ---
{vinculo == "sofia":
    Sofía.
    La primera vez que la viste con las bolsas.
    Algo cambió ahí. No sabés qué.
    Pero cambió.
}
{vinculo == "elena":
    Elena.
    Sentada en el banco de la plaza.
    Como si supiera que ibas a venir.
    Como si siempre supiera.
}
{vinculo == "diego":
    Diego.
    Caminando rápido. Siempre rápido.
    Pero esa vez se paró. Te miró.
    Y vos sentiste que alguien te veía.
}
{vinculo == "marcos":
    Marcos.
    El teléfono que no contesta.
    La plaza. La caja. Los hijos en Europa.
    ¿Estará pensando en vos también?
}
{vinculo == "ixchel":
    Ixchel.
    Las manos tejiendo. El olor a pepián.
    Algo antiguo en sus ojos.
    Como si supiera cosas que se olvidaron.
}

# PAUSA

* [...]
-

// Reflexión sobre la búsqueda de empleo
{rechazos >= 1 || rechazos_enviados >= 5:
    -> busqueda_reflexion_domingo ->
}

// Chequeo de idea involuntaria si tuvo muchos rechazos
{rechazos >= 5 && idea_no_soy_suficiente == false && RANDOM(1,2) == 1:
    -> domingo_idea_no_soy_suficiente
}

// Chequeo de idea positiva si tiene buena conexión
{rechazos >= 3 && conexion >= 6 && idea_el_problema_no_soy_yo == false:
    -> busqueda_idea_el_problema_no_soy_yo ->
}

// Chequeo mental: la reflexión final del domingo
# DADOS:CHEQUEO
~ temp resultado_domingo_reflexion = chequeo_completo_mental(conexion, 4)
{ resultado_domingo_reflexion == 2:
    La cabeza se aquieta. Por primera vez en días.

    Algo se acomoda. No es una respuesta. Es una calma.
    Por primera vez en días, respirás hondo y el aire entra. Todo.
    El pecho se abre. Los hombros bajan.

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

    Ponés la pava. Te hacés un café.
    Te sentás al lado de la ventana.
    Afuera la calle está quieta. Domingo.

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

    ¿Cuánto queda del colchón? ¿Cuánto antes de no poder pagar el alquiler?
    Las cuentas no cierran. Las cuentas nunca cierran.

    {conexion >= 4: Al menos hay gente. Eso debería alcanzar. Pero hoy no alcanza.}
    {conexion < 4: Estás solo. Y el domingo es el peor día para estar solo.}

    La tarde va a ser larga.
}
{ resultado_domingo_reflexion == -1:
    La cabeza explota.

    Todo se mezcla. El laburo. La plata. La olla. Las caras.
    ¿Qué sentido tiene? ¿Para qué?

    Te mirás las manos. No parecen tuyas.
    El cuerpo está acá pero vos estás en otro lado.
    En ningún lado.

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

=== domingo_idea_no_soy_suficiente ===
// Idea involuntaria que aparece por acumulación de rechazos

El pensamiento viene solo.
No lo pediste.
No lo querés.
Pero está ahí.

* [...]
-

{rechazos} rechazos.
{rechazos_enviados} CVs al vacío.
{rechazos_ghosting} entrevistas que ni contestaron.

Quizás el problema sos vos.

# IDEA INVOLUNTARIA: "NO SOY SUFICIENTE"

* [Aceptar la idea (peligroso)]
    ~ idea_no_soy_suficiente = true
    ~ aumentar_inercia(2)
    
    El mercado habló.
    Vos escuchaste.
    No sos suficiente.
    
    El pensamiento se instala.
    Va a costar sacarlo.
    
    -> domingo_pensar_continua

* [Resistir el pensamiento]
    No.
    
    {conexion >= 4:
        Pensás en la gente del barrio.
        En Sofía. En Elena. En la olla.
        Ellos no te miran así.
    }
    
    No vas a dejar que el mercado te defina.
    
    ~ subir_dignidad(1)
    -> domingo_pensar_continua

=== domingo_pensar_continua ===
// Continúa el flujo normal después de la idea involuntaria

-> domingo_tarde

=== domingo_tarde ===

# DOMINGO - TARDE

La tarde.
El sol baja.

Mañana es lunes.
Pero no hay laburo al que ir.

// --- Mensajes de NPCs ---
{sofia_relacion >= 3 && ayude_en_olla:
    Suena el teléfono. Sofía: "Hoy hacemos olla de domingo. Quedan todos invitados."
}
{elena_relacion >= 3 && not ayude_en_olla:
    Elena te mandó un mensaje: "Pasá cuando quieras. El banco te espera."
}
{diego_relacion >= 3 && sofia_relacion < 3 && elena_relacion < 3:
    Diego te manda un audio: "Che, si querés mañana caemos temprano al depósito. Hay laburo."
}
{marcos_relacion >= 3 && sofia_relacion < 3 && elena_relacion < 3 && diego_relacion < 3:
    Un mensaje de Marcos. Sin texto. Solo un emoji del sol.
    Es raro. Pero es algo.
}

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

// DIARIO DE CONCIENCIA
-> diario_escribir ->

// Fragmento nocturno final
-> seleccionar_fragmento_domingo ->

-> domingo_resumen_ideas

=== domingo_resumen_ideas ===

Las ideas que internalizaste:
{idea_tengo_tiempo: - "Ahora tengo tiempo para esto."}
{idea_pedir_no_debilidad: - "Pedir ayuda no es debilidad."}
{idea_hay_cosas_juntos: - "Hay cosas que se hacen juntos."}
{idea_red_o_nada: - "La red o la nada."}
{idea_el_problema_no_soy_yo: - "El problema no soy yo."}
{idea_quien_soy: - "¿Quién soy sin laburo?" (involuntaria)}
{idea_esto_es_lo_que_hay: - "Esto es lo que hay." (involuntaria)}
{idea_no_soy_suficiente: - "No soy suficiente." (involuntaria, peligrosa)}

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

// ANTAGONISTA: Cacho - reflexión
-> cacho_domingo ->

// ANTAGONISTA: Bruno - resultado del conflicto
-> bruno_domingo ->

// ANTAGONISTA: Claudia - resultado de la auditoría
{lista_entregada:
    -> claudia_domingo_lista_entregada ->
- else:
    -> claudia_domingo_sin_lista ->
}

// ANTAGONISTA: Claudia - consecuencias a largo plazo de la lista
-> claudia_consecuencias_largas ->

// ANTAGONISTA: Redención de Cacho si aplica
-> cacho_redencion ->

// ANTAGONISTA: Redención extendida de Cacho
-> cacho_redencion_extendida ->

// ANTAGONISTA: Cacho - domingo redención
-> cacho_domingo_redencion ->

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

// FINAL REPRESIÓN - Intentaste luchar pero la organización no alcanzó
// NOTA: Requiere "buenos" estados (conexion alta, llama alta, inercia baja)
// porque la represión es consecuencia de INVOLUCRARSE activamente.
// La diferencia con huelga/ocupación es que acá faltó base organizativa
// (pocas veces ayudando o sin Diego de aliado = la acción fue más vulnerable).
{participe_asamblea && conexion >= 5 && llama >= 5 && inercia <= 4 && (veces_que_ayude < 2 || diego_relacion < 4):
    -> final_represion
}

// FINAL HUELGA - Huelga salvaje organizada desde abajo
{evaluar_huelga():
    -> final_huelga
}

// FINAL OCUPACIÓN - Ocupación de fábrica
{evaluar_ocupacion():
    -> final_ocupacion
}

// FINAL IXCHEL - Requiere vínculo con Ixchel
{evaluar_tejido():
    -> final_tejido
}

// FINAL OCULTO - Requiere perfección
{evaluar_la_llama():
    -> final_la_llama
}

// FINAL LUCHA COLECTIVA - Participación activa
{evaluar_lucha_colectiva():
    -> final_lucha_colectiva
}

// FINAL RED - Comunidad como red
{evaluar_red():
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
