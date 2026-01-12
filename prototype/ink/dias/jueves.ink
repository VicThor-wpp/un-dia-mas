// ============================================
// JUEVES - EL PRIMER DIA SIN LABURO
// Patron modular con tunnels
// ============================================

// Tunnels usados de otros modulos:
// - escenas/olla.ink: olla_llegada, olla_ayudar_cocina, olla_escuchar_crisis
// - escenas/barrio.ink: barrio_caminar_manana, barrio_caminar_sin_rumbo
// - personajes/sofia.ink: sofia_primer_encuentro, sofia_invitar_ayudar, sofia_agradecimiento
// - personajes/elena.ink: elena_historia_2002
// - personajes/diego.ink: diego_encuentro_barrio, diego_enterarse_despido, diego_caminar_juntos
// - personajes/marcos.ink: marcos_no_esta

=== jueves_amanecer ===

~ dia_actual = 4
~ energia = 3  // Dormiste mal

# JUEVES

Te despertás.
Por un segundo, pensás que tenés que ir a laburar.

Después te acordás.

Ya no tenés laburo.

El despertador no sonó porque lo apagaste.
¿Para qué madrugar?

~ tiene_laburo = false

* [Levantarte igual] # EFECTO:dignidad+
    -> jueves_manana
* [Quedarte en la cama] # COSTO:1 # EFECTO:dignidad-
    -> jueves_cama

=== jueves_cama ===

~ energia -= 1

Te quedás.
Mirás el techo.
Pensás.

¿Cuánto duran tres meses?
¿Cuánto tarda en aparecer otro laburo?
¿Qué pasa si no aparece?

La cabeza no para.

Eventualmente te levantás.
El cuerpo no aguanta más la cama.

-> jueves_manana_tarde

=== jueves_manana ===

Te levantás.
El mate.
La rutina, pero vacía.

Antes el mate era apurado, entre ducharte y salir.
Ahora tenés todo el tiempo del mundo.

Demasiado tiempo.

-> jueves_manana_tarde

=== jueves_manana_tarde ===

Son las 10 de la mañana.
Normalmente estarías laburando.

Ahora estás acá.
En tu casa.
Sin saber qué hacer.

{conte_a_alguien: Al menos alguien sabe. No estás completamente solo en esto.}
{not conte_a_alguien: Nadie sabe todavía. El peso es solo tuyo.}

¿Qué hacés hoy?

* [Buscar laburo online] # COSTO:1 # STAT:dignidad # EFECTO:dignidad-
    -> jueves_buscar_laburo
* [Ir al barrio] # EFECTO:conexion?
    -> jueves_barrio
* [Quedarte en casa] # COSTO:1 # STAT:conexion # EFECTO:conexion-
    -> jueves_quedarse

=== jueves_buscar_laburo ===

~ energia -= 1

Abrís las páginas de empleo.
Hay ofertas.
Pocas que sirvan.

"Se busca. Experiencia mínima 5 años."
"Se busca. Hasta 25 años."
"Se busca. Disponibilidad full time. Pago por productividad."

Mandás algunos CVs.
No esperás respuesta.
Pero hay que hacer algo.

~ bajar_dignidad(1)

{energia > 0: Todavía podés hacer algo más hoy.}

* {energia > 0} [Salir al barrio] -> jueves_barrio
* [Ya fue, quedarse] -> jueves_noche

=== jueves_quedarse ===

~ energia -= 1
~ bajar_conexion(1)

Te quedás.
La tele.
El celular.
Nada.

Las horas pasan.
No hacés nada.
No hablás con nadie.

Es fácil quedarse.
Demasiado fácil.

* [Ir a la noche] -> jueves_noche

=== jueves_barrio ===

// Contexto del barrio
Salís.
-> barrio_caminar_manana ->
// Continua con opciones del dia

* [Ir a la olla] # EFECTO:llama+ -> jueves_olla
* [Caminar nomás] -> jueves_caminar
* [Buscar a tu vínculo] # EFECTO:conexion+ -> jueves_buscar_vinculo

=== jueves_caminar ===

// Usar tunnel del barrio
-> barrio_caminar_sin_rumbo ->

// Contenido específico del día
El tipo que duerme en la plaza sigue ahí.
Lo viste mil veces.
Hoy lo mirás diferente.

No sos él.
Tenés tres meses.
Pero la distancia se siente más corta.

* [Volver a casa] -> jueves_noche
* [Ir a la olla] -> jueves_olla

=== jueves_olla ===

~ fui_a_olla_jueves = true

// Llegada a la olla
-> olla_llegada ->

Sofía está ahí.
Y otra gente que no conocés bien.

// Encuentro con Sofia
-> sofia_primer_encuentro ->

{conte_a_alguien && vinculo == "sofia":
    -> jueves_olla_ayudar
}

{not conte_a_alguien || vinculo != "sofia":
    * ["Me echaron ayer."]
        ~ conte_a_alguien = true
        ~ subir_conexion(1)
        Sofía asiente. No dice "qué bajón" ni "vas a conseguir algo".
        Solo asiente.
        "Bueno. ¿Querés dar una mano?"
        -> jueves_olla_pregunta
    * ["Tenía el día libre."]
        Sofía te mira.
        No te cree.
        Pero no insiste.
        -> sofia_invitar_ayudar ->
        -> jueves_olla_pregunta
}

=== jueves_olla_pregunta ===

¿Querés ayudar?

* [Sí] # EFECTO:conexion+ # EFECTO:llama+ -> jueves_olla_ayudar
* [Solo vine a ver] # EFECTO:conexion- -> jueves_olla_ver

=== jueves_olla_ver ===

"Solo vine a ver."

Sofía asiente.
"Bueno. Cuando quieras."

// Ambiente normal de trabajo
-> olla_ambiente_normal ->

* [Irte] -> jueves_noche

=== jueves_olla_ayudar ===

// Tunnel de ayudar en la cocina
-> olla_ayudar_cocina ->

// Escuchar sobre la crisis
-> olla_escuchar_crisis ->

"Si no conseguimos algo para el viernes, no sé qué hacemos", dice alguien.

// Sofia en silencio ante la crisis
Sofía no dice nada.
Solo sigue cocinando.

{idea_tengo_tiempo == false:
    # IDEA DISPONIBLE: "AHORA TENGO TIEMPO"

    Antes no podías.
    Laburabas, llegabas cansado, no había espacio.
    Ahora sí.

    * [Internalizar la idea]
        ~ idea_tengo_tiempo = true
        Ahora tenés tiempo.
        No es consuelo. Pero es algo que podés dar.
        -> jueves_olla_fin
    * [Dejar pasar]
        -> jueves_olla_fin
- else:
    -> jueves_olla_fin
}

=== jueves_olla_fin ===

Terminás de ayudar.
Son las 3 de la tarde.

// Agradecimiento de Sofia
-> sofia_agradecimiento ->

* [Ir a casa] -> jueves_noche

=== jueves_buscar_vinculo ===

{vinculo == "sofia": -> jueves_olla}
{vinculo == "elena": -> jueves_elena}
{vinculo == "diego": -> jueves_diego}
{vinculo == "marcos": -> jueves_marcos}

=== jueves_elena ===

// Encuentro en casa de Elena
-> elena_en_casa ->

// Historia del 2002
-> elena_historia_2002 ->

{idea_pedir_no_debilidad == false:
    # IDEA DISPONIBLE: "PEDIR AYUDA NO ES DEBILIDAD"

    Elena lo dice como si fuera obvio.
    Quizás lo es.

    * [Internalizar]
        ~ idea_pedir_no_debilidad = true
        Pedir ayuda no es debilidad.
        Es lo que se hace.
        -> jueves_elena_fin
    * [Dejar pasar]
        -> jueves_elena_fin
- else:
    -> jueves_elena_fin
}

=== jueves_elena_fin ===

Te quedás un rato.
// Elena habla del barrio
-> elena_hablar_barrio ->

* [Irte] -> jueves_noche

=== jueves_diego ===

// Encuentro casual con Diego
-> diego_encuentro_barrio ->

// Diego se entera del despido
-> diego_enterarse_despido ->

* [Caminar juntos un rato]
    // Tunnel de caminar juntos
    -> diego_caminar_juntos ->
    -> jueves_noche
* [Irte]
    -> jueves_noche

=== jueves_marcos ===

// Marcos no está disponible
-> marcos_no_esta ->

* [Irte] -> jueves_noche

=== jueves_noche ===

# JUEVES - NOCHE

~ energia = 0

Primer día completo sin laburo.

Te acostás temprano.
¿Para qué quedarse despierto?

La cabeza sigue dando vueltas.
Tres meses.
Noventa días.
La cuenta regresiva.

{ayude_en_olla: Pero hoy hiciste algo. Ayudaste en la olla. Eso es algo.}
{fui_a_olla_jueves && not ayude_en_olla: Fuiste a la olla. Viste algo. Quizás mañana.}
{not fui_a_olla_jueves: No saliste mucho. Mañana quizás.}

El viernes viene.
La olla necesita resolver algo.
Vos también.

* [Dormir] -> fragmento_jueves

=== fragmento_jueves ===

# MIENTRAS DORMÍS

{vinculo == "sofia": -> fragmento_sofia_jueves}
{vinculo == "elena": -> fragmento_elena_jueves}
{vinculo == "diego": -> fragmento_diego_jueves}
{vinculo == "marcos": -> fragmento_marcos_jueves}
-> fragmento_olla_jueves

=== fragmento_marcos_jueves ===

# MARCOS

Marcos tampoco duerme.

El departamento vacío.
La tele encendida sin sonido.
Los mensajes sin responder.

Pensó en ir a la asamblea.
No fue.
Es más fácil no ir.

Mañana es otro día igual.

* [Continuar] -> viernes_amanecer

=== fragmento_sofia_jueves ===

# SOFÍA

// Fragmento nocturno de Sofia
-> sofia_fragmento_noche ->

// Sofia pensando
-> sofia_fragmento_pensar ->

Mañana hay que buscar soluciones.

* [Continuar] -> viernes_amanecer

=== fragmento_elena_jueves ===

# ELENA

// Fragmento nocturno de Elena
-> elena_fragmento_noche ->

* [Continuar] -> viernes_amanecer

=== fragmento_diego_jueves ===

# DIEGO

// Fragmento nocturno de Diego
-> diego_fragmento_noche ->

* [Continuar] -> viernes_amanecer

=== fragmento_olla_jueves ===

// Olla cerrada de noche
-> olla_cerrar_noche ->

El barrio duerme.
Los problemas no.

* [Continuar] -> viernes_amanecer
