// ============================================
// VIERNES - LA CRISIS DE LA OLLA
// Patron modular con tunnels
// ============================================

// Tunnels usados de otros modulos:
// - escenas/olla.ink: olla_llegada, olla_ambiente_crisis, olla_colecta_callejera,
//                     olla_pedir_vecinos, olla_resultado_colecta, olla_servir
// - escenas/barrio.ink: barrio_caminar_tarde
// - personajes/sofia.ink: sofia_reunion_crisis, sofia_pedir_ideas
// - personajes/elena.ink: elena_canastas, elena_pedir
// - personajes/diego.ink: diego_colecta

=== viernes_amanecer ===

~ dia_actual = 5
~ energia = 4

# VIERNES

Dos días sin laburo.
Se siente más largo.

El viernes antes era el mejor día.
Fin de semana, descanso, algo de plata.

Ahora es solo otro día.

{fui_a_olla_jueves: Sofía dijo que hoy necesitaban resolver algo. La olla está en crisis.}

* [Levantarte] -> viernes_manana

=== viernes_manana ===

El mate.
La mañana.

{olla_en_crisis:
    Pensás en la olla.
    En que dijeron que no tenían para hoy.
    En que hay gente que depende de eso.
}

¿Qué hacés hoy?

* [Ir a la olla temprano]
    -> viernes_olla_temprano
* [Buscar laburo primero] # COSTO:1 # STAT:dignidad
    -> viernes_buscar
* [Ver qué pasa]
    -> viernes_barrio

=== viernes_buscar ===

~ energia -= 1
~ bajar_dignidad(1)

Abrís la compu.
Más CVs.
Más portales.

Hay una oferta que parece real.
Mandás.

No esperás respuesta.
Pero hay que seguir intentando.

{energia > 1:
    Todavía es temprano. Podés ir a la olla.
    * [Ir a la olla]
        -> viernes_olla_temprano
    * [Quedarte buscando] # COSTO:1
        ~ energia -= 1
        Seguís buscando.
        Las horas pasan.
        A las 3 dejás.
        -> viernes_tarde
}

* [Ir a la tarde] -> viernes_tarde

=== viernes_barrio ===

Salís a caminar.
El barrio.

A esta hora la gente hace sus cosas.
Compras, trámites, vida.

Pasás por la olla.
Hay movimiento.

* [Entrar] -> viernes_olla_temprano
* [Seguir de largo] -> viernes_tarde

=== viernes_olla_temprano ===

~ energia -= 1

// Llegada a la olla
-> olla_llegada ->

// Ambiente de crisis
-> olla_ambiente_crisis ->

// Reunion de crisis con Sofia
-> sofia_reunion_crisis ->

Te ven.

{ayude_en_olla:
    // Sofia pide ideas
    -> sofia_pedir_ideas ->
    -> viernes_reunion
- else:
    Sofía te mira.
    "¿Venís a ayudar o a mirar?"
    * ["A ayudar."] # STAT:conexion
        ~ ayude_en_olla = true
        ~ subir_conexion(1)
        "Bien. Porque estamos en el horno."
        -> viernes_reunion
    * ["Solo pasaba."]
        "Bueno. Si te animás, acá estamos."
        -> viernes_tarde
}

=== viernes_reunion ===

# LA REUNION DE LA OLLA

Están: Sofía, Elena, dos o tres más que no conocés bien.

El problema es simple:
No hay plata para la comida de hoy.
Vienen 30 personas a comer.
No tienen qué darles.

"Las donaciones no llegaron."
"El municipio no contesta."
"Los comercios ya dijeron que no."

Silencio.

¿Qué se puede hacer?

* [Proponer una colecta rápida] -> viernes_colecta
* [Proponer pedir a vecinos] -> viernes_vecinos
* [Quedarte callado, escuchar] -> viernes_escuchar

=== viernes_escuchar ===

No decís nada.
Escuchás.

Los demás discuten.
Ideas van y vienen.

// Elena propone las canastas
-> elena_canastas ->

-> viernes_plan

=== viernes_colecta ===

"¿Y si hacemos una colecta? Rápida. Hoy."

Te miran.

"¿Cómo?"

"No sé. Golpear puertas. Pedir en la calle. Algo."

Sofía lo piensa.
"Es arriesgado. Pero no hay mucho más."

Elena:
"En el 2002 hacíamos eso. Funcionaba."

~ idea_hay_cosas_juntos = true

-> viernes_plan

=== viernes_vecinos ===

"¿Y los vecinos? ¿Los que no vienen a la olla pero conocen?"

"Ya les pedimos."
"Algunos dieron. No alcanza."

"¿Y si pedimos distinto? No plata. Comida directa. Lo que tengan."

Sofía lo piensa.
"Puede ser. Es más fácil dar una papa que cien pesos."

~ idea_hay_cosas_juntos = true

-> viernes_plan

=== viernes_plan ===

# EL PLAN

Deciden hacer las dos cosas:
- Pedir comida directa a vecinos
- Colecta rápida en la zona

Se dividen.

"¿Vos podés ayudar?", pregunta Sofía.

* [Sí, voy con la colecta] -> viernes_colecta_accion
* [Sí, voy a pedir a vecinos] -> viernes_vecinos_accion
* [No puedo, tengo que hacer otra cosa] -> viernes_no_ayudar

=== viernes_no_ayudar ===

~ bajar_conexion(1)

"No puedo. Tengo que... buscar laburo."

Sofía asiente.
No dice nada.
Pero algo se enfría.

"Bueno. Si podés más tarde..."

Te vas.
Sabés que podrías haber ayudado.
Elegiste no hacerlo.

-> viernes_tarde

=== viernes_colecta_accion ===

// Tunnel de colecta callejera
-> olla_colecta_callejera ->

// Diego en la colecta
-> diego_colecta ->

Al final de la tarde, entre todos:
Hay para comprar verduras.
No es mucho. Pero es algo.

-> viernes_olla_tarde

=== viernes_vecinos_accion ===

// Tunnel de pedir a vecinos
-> olla_pedir_vecinos ->

// Elena sabe pedir
-> elena_pedir ->

Volvés con bolsas.
No es mucho. Pero es algo.

-> viernes_olla_tarde

=== viernes_olla_tarde ===

# LA OLLA - TARDE

Vuelven todos.

// Resultado de la colecta
-> olla_resultado_colecta ->

La cocina empieza.
Todos ayudan.

{energia > 0:
    Te quedás ayudando.
    Pelás, cortás, revolvés.
    Sos parte de esto.
    ~ subir_conexion(1)
}

// Servir la comida
A las 7 la olla abre.
-> olla_servir ->

-> viernes_noche

=== viernes_tarde ===

~ energia -= 1

// Caminar por el barrio de tarde
-> barrio_caminar_tarde ->

{olla_en_crisis && not ayude_en_olla:
    Te preguntás cómo les habrá ido a los de la olla.
    Si resolvieron.
    Si cerraron.
}

El barrio sigue.
Vos seguís.
Pero algo falta.

* [Ir a casa] -> viernes_noche

=== viernes_noche ===

# VIERNES - NOCHE

~ energia = 0

{ayude_en_olla:
    Estás destruido.
    Pero hiciste algo.
    La olla funcionó hoy.
    Mañana hay que ver de vuelta.

    ~ subir_llama(1)
}

{not ayude_en_olla && olla_en_crisis:
    Te quedaste afuera.
    No sabés cómo les fue.
    Quizás deberías haber ido.
}

Mañana es sábado.
Hay una asamblea en el barrio.
Para hablar de la olla, de la situación.

{ayude_en_olla: Te invitaron. Podés ir.}
{not ayude_en_olla: Escuchaste que hay. Quizás podrías ir.}

* [Dormir] -> fragmento_viernes

=== fragmento_viernes ===

# MIENTRAS DORMÍS

{vinculo == "sofia": -> fragmento_sofia_viernes}
{vinculo == "elena": -> fragmento_elena_viernes}
{vinculo == "diego": -> fragmento_diego_viernes}
{vinculo == "marcos": -> fragmento_marcos_viernes}
-> fragmento_viernes_default

=== fragmento_sofia_viernes ===

# SOFÍA

Sofía está agotada.

{ayude_en_olla:
    Pero hoy funcionó.
    Entre todos, funcionó.
- else:
    Hoy apenas alcanzó.
    No sabe si mañana va a dar.
}

Mañana es la asamblea.
Hay que hablar de todo.
De cómo seguir.

* [Continuar] -> sabado_amanecer

=== fragmento_elena_viernes ===

# ELENA

Elena piensa en Raúl.

En el 2002, él tampoco dormía.
Pero salieron.
Juntos, salieron.

Mañana hay asamblea.
Ella va a ir.
Tiene cosas que decir.

* [Continuar] -> sabado_amanecer

=== fragmento_diego_viernes ===

# DIEGO

Diego cuenta la plata.

No alcanza.
Nunca alcanza.
Pero hoy comió.

{ayude_en_olla:
    Y ayudó en algo.
    Eso se siente diferente.
}

Mañana sigue.

* [Continuar] -> sabado_amanecer

=== fragmento_marcos_viernes ===

# MARCOS

Marcos vio la asamblea desde lejos.

No entró.
No quiso.
O no pudo.

La gente hace cosas.
Él solo mira.

Quizás mañana.
Siempre quizás mañana.

* [Continuar] -> sabado_amanecer

=== fragmento_viernes_default ===

El barrio duerme.
Los problemas siguen.

Mañana hay asamblea.
Para hablar de cómo seguir.

* [Continuar] -> sabado_amanecer
