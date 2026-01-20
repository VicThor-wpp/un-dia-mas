// ============================================
// SABADO - LA ASAMBLEA
// Patron modular con tunnels
// ============================================

// Tunnels usados de otros modulos:
// - escenas/olla.ink: olla_preparar_asamblea, olla_asamblea_inicio,
//                     olla_asamblea_discusion, olla_asamblea_fin, olla_cerrar_noche
// - escenas/barrio.ink: barrio_sabado, barrio_plaza
// - personajes/sofia.ink: sofia_fragmento_asamblea
// - personajes/elena.ink: elena_consejo
// - personajes/marcos.ink: marcos_contesta, marcos_encuentro_plaza,
//                          marcos_revelar_despido, marcos_hablar_precariedad,
//                          marcos_invitar_asamblea, marcos_en_asamblea, marcos_se_fue,
//                          marcos_idea_esto_es_lo_que_hay

=== sabado_amanecer ===

~ dia_actual = 6
~ energia = 4  // Fin de semana, dormiste un poco más

# SABADO

Sábado.
Antes era descanso.
Ahora todos los días son iguales.

* [...]
-

{ayude_en_olla: Hoy es la asamblea. A las 5 en la olla.}

* [Levantarte] -> sabado_manana

=== sabado_manana ===

La mañana de sábado.
El barrio más tranquilo.

{salud_mental <= 4: La cabeza sigue dando vueltas. Tres días sin laburo y ya parece una eternidad.}

¿Qué hacés con la mañana?

* [Llamar a alguien] # EFECTO:conexion?
    -> sabado_llamar
* [Salir a caminar] # COSTO:1
    -> sabado_caminar
* [Quedarte en casa] # COSTO:1 # STAT:conexion # EFECTO:conexion-
    -> sabado_casa

=== sabado_llamar ===

¿A quién llamás?

* {vinculo == "marcos"} [A Marcos (otra vez)]
    -> sabado_marcos
* [A tu vieja / tu viejo] # COSTO:1
    -> sabado_familia
* [A nadie, mejor no] -> sabado_casa

=== sabado_marcos ===

// Marcos contesta (raro)
-> marcos_contesta ->

"Dale. En la plaza. En una hora."

* [Ir] -> sabado_marcos_plaza

=== sabado_marcos_plaza ===

// Encuentro en la plaza con Marcos
-> marcos_encuentro_plaza ->

"Me echaron."

// Marcos revela que tambien lo echaron
-> marcos_revelar_despido ->

"¿Cómo la llevás?"

// Marcos sobre funcionar
-> marcos_funcionar ->

// Hablar de la precariedad
-> marcos_hablar_precariedad ->

// Idea involuntaria al ver a Marcos
-> marcos_idea_esto_es_lo_que_hay ->

// Invitar a Marcos a la asamblea
-> marcos_invitar_asamblea ->

* ["Vamos juntos."] # EFECTO:conexion+
    "Hace mucho que no voy al barrio."
    "Por eso. Vamos."
    Marcos asiente.
    ~ marcos_estado = "mirando"
    -> sabado_tarde
* ["No importa, era por decir."] # EFECTO:conexion-
    "Mejor no. No estoy para eso."
    "Bueno."
    -> sabado_tarde

=== sabado_familia ===

~ energia -= 1

Llamás a tu familia.

"Hola, má."

Hablás.
De todo y de nada.

* [...]
-

No le contás lo del laburo.
O sí, depende.

* [Contarle]
    ~ conte_a_alguien = true
    "Má, me echaron."
    Silencio.
    "¿Estás bien? ¿Necesitás plata?"
    "No sé. Era unipersonal. No hay indemnización. No hay nada."
    "¿Cómo que no hay nada?"
    "Así me contrataron. Facturaba. Como si fuera mi propia empresa."
    Ella no entiende. Pero te escucha.
    -> sabado_tarde
* [No contarle]
    Hablás de otras cosas.
    El clima. Los vecinos. Boludeces.
    No querés preocuparla.
    O no querés tener que explicar.
    -> sabado_tarde

=== sabado_caminar ===

~ energia -= 1

Salís a caminar.

// Ambiente de sabado
-> barrio_sabado ->

* [Volver a casa] -> sabado_casa
* [Pasar por la olla] -> sabado_olla_temprano

=== sabado_olla_temprano ===

Pasás por la olla.

// Preparando asamblea
-> olla_preparar_asamblea ->

Sofía te ve.

"¿Venís a la asamblea?"

* ["Sí, vengo más tarde."]
    "Bien. A las 5."
    -> sabado_tarde
* ["No sé si puedo."]
    Sofía asiente.
    "Bueno. Si podés, acá estamos."
    -> sabado_tarde

=== sabado_casa ===

~ energia -= 1
~ bajar_conexion(1)

Te quedás en casa.
Tele.
Celular.
Nada.

Las horas pasan.

* [Ir a la asamblea igual] # EFECTO:llama+ -> sabado_asamblea
* [No ir] # EFECTO:conexion- # EFECTO:llama- -> sabado_noche_solo

=== sabado_tarde ===

La tarde.

A las 5 es la asamblea.

{energia >= 1:
    Podés ir.
    * [Ir a la asamblea] -> sabado_asamblea
    * [No ir] -> sabado_noche_solo
- else:
    Estás muy cansado.
    No das más.
    * [Intentar ir igual]
        ~ energia = 0
        Te arrastrás hasta la olla.
        -> sabado_asamblea
    * [Quedarte] -> sabado_noche_solo
}

=== sabado_noche_solo ===

~ bajar_conexion(2)
~ bajar_llama(1)

No vas.

Te quedás en casa.
Pensás en que deberías haber ido.
Pero no fuiste.

* [...]
-

La asamblea pasa sin vos.
No sabés qué decidieron.
No sabés qué viene.

Estás afuera.

* [Dormir] -> fragmento_sabado

=== sabado_asamblea_post_cierre ===
// Consecuencias del cierre de la olla el viernes

El aire está raro.
Ayer la olla cerró.
Primera vez en meses.

* [...]
-

Sofía está callada.
Elena tiene cara de preocupación.

"Bueno... tenemos que hablar de lo de ayer."

* [...]
-

Sofía suspira.

"Ayer cerramos. Lo saben.
La pregunta es: ¿qué hacemos para que no pase de nuevo?"

{vos_propusiste_cerrar:
    Te miran.
    Vos propusiste cerrar.
    Ahora te toca proponer qué sigue.

    * [Proponer sistema de reserva de emergencia]
        "Necesitamos un fondo. Aunque sea chico. Para días así."
        Sofía asiente. "Tiene sentido."
        La discusión sigue.
        -> sabado_asamblea_continua

    * [Proponer red de donantes fijos]
        "Necesitamos gente que se comprometa a dar todos los meses."
        Elena: "En el 2002 así empezamos."
        La idea prende.
        -> sabado_asamblea_continua

    * [Quedarte callado]
        No decís nada.
        Sofía te mira. Esperaba más.
        ~ bajar_dignidad(1)
        -> sabado_asamblea_continua
- else:
    La discusión sigue sin que nadie te mire especialmente.
    -> sabado_asamblea_continua
}

=== sabado_asamblea_continua ===
// Continúa después de resolver el tema del cierre

La conversación se amplía.
No es solo lo de ayer.
Es todo.

* [Seguir] -> sabado_asamblea_discusion_normal

=== sabado_asamblea ===

// Ecos: los NPCs recuerdan tus acciones pasadas
-> sabado_ver_sofia ->
-> sabado_ver_diego ->

// Inicio de la asamblea
-> olla_asamblea_inicio ->

// Si la olla cerró ayer, eso domina la conversación
{olla_cerro_viernes:
    -> sabado_asamblea_post_cierre
}

-> sabado_asamblea_discusion_normal

=== sabado_asamblea_discusion_normal ===
// Discusión normal de la asamblea (sin cierre previo)

// Discusion de la asamblea
-> olla_asamblea_discusion ->

// Elena da consejo
-> elena_consejo ->

// Marcos en la asamblea (si vino)
-> marcos_en_asamblea ->

¿Qué hacés?

* [Hablar] # STAT:dignidad # EFECTO:dignidad+
    -> sabado_hablar
* [Escuchar]
    -> sabado_escuchar_asamblea
* [Proponer algo] # STAT:dignidad # STAT:llama # EFECTO:dignidad+ # EFECTO:llama+
    -> sabado_asamblea_proponer

=== sabado_escuchar_asamblea ===

Escuchás.

Las ideas van y vienen.
- Hacer más colectas.
- Buscar comercios que donen.
- Pedir al municipio de vuelta.
- Organizar una feria.

No hay solución mágica.
Solo ideas.
Solo gente tratando.

-> sabado_asamblea_fin

=== sabado_hablar ===

~ subir_dignidad(1)

Hablás.

"Yo... hace tres días me quedé sin laburo. No sé bien qué puedo aportar. Pero tengo tiempo ahora. Y quiero ayudar."

Te miran.

* [...]
-

Sofía asiente.
Elena sonríe.

"Eso es lo que necesitamos. Gente."

-> sabado_asamblea_fin

// DEPRECATED: Replaced by sabado_asamblea_proponer (dice-based version)
// This knot is no longer called and kept only for reference
/*
=== sabado_proponer ===

~ subir_dignidad(1)
~ subir_llama(1)

"¿Y si hacemos algo más grande? Una jornada. Invitamos a todo el barrio. Mostramos lo que hace la olla. Pedimos ayuda abiertamente."

Silencio.

"Es mucho laburo."
"Pero puede funcionar."
"Hay que organizarlo."

Sofía:
"¿Vos te animás a ayudar con eso?"

* ["Sí."] # STAT:conexion # EFECTO:conexion+
    ~ subir_conexion(1)
    "Sí. Ahora tengo tiempo."
    Risas nerviosas.
    Pero es real.
    Ahora tenés tiempo.
    -> sabado_asamblea_fin
* ["No sé si puedo."] # EFECTO:conexion-
    "Bueno. La idea queda."
    -> sabado_asamblea_fin
*/

=== sabado_asamblea_proponer ===
Te levantás.
Todos te miran.

~ temp modificador = 0
{ veces_que_ayude >= 2:
    ~ modificador = 1  // Tenés credibilidad
}
{ participe_asamblea:
    ~ modificador = modificador + 1
}
{ sofia_relacion >= 4:
    ~ modificador = modificador + 1
}

~ temp resultado = chequeo(modificador, 5)

{
- resultado == 2:  // Crítico
    Las palabras salen.
    No sabés de dónde.
    Pero salen.

    Hablás de la semana.
    De lo que perdiste.
    De lo que encontraste.

    Cuando terminás, hay silencio.
    Después, aplausos.

    Sofía tiene lágrimas.

    ~ subir_llama(2)
    ~ subir_conexion(2)
    ~ subir_dignidad(1)

    -> asamblea_exito_total

- resultado == 1:  // Éxito
    Proponés algo.
    Un sistema de turnos.
    Una red de ayuda.
    Algo.

    La gente asiente.
    No es revolución.
    Pero es algo.

    ~ subir_llama(1)
    ~ subir_conexion(1)

    -> asamblea_exito

- resultado == 0:  // Fallo
    Empezás a hablar.
    Te trabás.

    Sofía interviene, suave.
    "Gracias. ¿Alguien más?"

    Te sentás.
    No estuvo mal.
    Pero tampoco estuvo bien.

    -> asamblea_continua

- else:  // Fumble
    Te levantás.
    Abrís la boca.

    Nada sale.

    Te sentás de nuevo.
    Nadie dice nada.

    ~ bajar_dignidad(1)

    -> asamblea_continua
}

=== asamblea_exito_total ===
// Stub: Consecuencias de éxito crítico en propuesta

El resto de la asamblea fluye diferente.
Tu intervención cambió algo.

-> sabado_asamblea_fin

=== asamblea_exito ===
// Stub: Consecuencias de éxito en propuesta

La asamblea continúa.
Tu idea se suma a las demás.

-> sabado_asamblea_fin

=== asamblea_continua ===
// Stub: La asamblea sigue sin mayor impacto de tu intervención

La asamblea sigue.
Otras voces hablan.

-> sabado_asamblea_fin

=== sabado_asamblea_fin ===

// Cierre de la asamblea
-> olla_asamblea_fin ->

{idea_hay_cosas_juntos == false:
    # IDEA DISPONIBLE: "HAY COSAS QUE SE HACEN JUNTOS"

    La asamblea te mostró algo.
    No es que alguien tiene la respuesta.
    Es que entre todos se busca.

    * [Internalizar]
        ~ idea_hay_cosas_juntos = true
        Hay cosas que se hacen juntos.
        O no se hacen.
        -> sabado_noche
    * [Dejar pasar]
        -> sabado_noche
- else:
    -> sabado_noche
}

=== sabado_noche ===

# SABADO - NOCHE

~ energia = 0
~ subir_llama(1)

Volvés a casa.
Cansado pero distinto.

Cuatro días sin laburo.
Tres meses de colchón.
La cuenta regresiva sigue.

* [...]
-

Pero hoy estuviste en una asamblea.
Hoy fuiste parte de algo.

No resuelve nada.
Pero cambia algo.

// Marcos se fue de la asamblea
-> marcos_se_fue ->

* [Dormir] -> fragmento_sabado

=== fragmento_sabado ===

# MIENTRAS DORMÍS

{vinculo == "sofia": -> fragmento_sofia_sabado}
{vinculo == "elena": -> fragmento_elena_sabado}
{vinculo == "diego": -> fragmento_diego_sabado}
{vinculo == "marcos": -> fragmento_marcos_sabado}
-> fragmento_sabado_default

=== fragmento_sofia_sabado ===

# SOFÍA

Sofía finalmente duerme.

{participe_asamblea:
    La asamblea salió bien.
    Hay un plan.
    No es mucho, pero es algo.
- else:
    La asamblea pasó.
    Ella siguió sola.
}

Mañana es domingo.
Un día para respirar.
Después sigue la lucha.

* [Continuar] -> domingo_amanecer

=== fragmento_elena_sabado ===

# ELENA

Elena sueña con Raúl.

Están en el barrio.
Hace calor.
Él sonríe.

"¿Viste? Siempre salimos."

Se despierta.
Es un buen sueño.

* [Continuar] -> domingo_amanecer

=== fragmento_diego_sabado ===

# DIEGO

Diego habló con su madre.

"Estoy bien, má."
Mentira piadosa.
O quizás no.

{participe_asamblea:
    Hoy fue a una asamblea.
    No entendió todo.
    Pero sintió algo.
}

Mañana sigue.

* [Continuar] -> domingo_amanecer

=== fragmento_marcos_sabado ===

# MARCOS

{marcos_estado == "mirando":
    Marcos fue a la asamblea.
    Se sentó atrás.
    No habló.
    Pero estuvo.

    Es más de lo que hizo en meses.
- else:
    Marcos no fue.
    Como siempre.

    La vida pasa.
    Él mira.
}

Mañana es domingo.

* [Continuar] -> domingo_amanecer

// --- ECOS: NPCs RECUERDAN TUS ACCIONES ---

=== sabado_ver_sofia ===
// Tunnel: Sofia recuerda si ayudaste en la olla

Sofía te ve llegar.

{ayude_en_olla && veces_que_ayude >= 2:
    "Che, gracias por el viernes. No sé cómo hubiéramos hecho sin vos."

    Alguien notó.
    Alguien se acuerda.

    ~ sofia_relacion += 1
}
{ayude_en_olla && veces_que_ayude == 1:
    "Qué bueno que viniste."

    Un reconocimiento simple.
    Pero real.
}
{not ayude_en_olla:
    "Hola."

    Nada más.
    No hay mucho que decir.
}

->->

=== sabado_ver_diego ===
// Tunnel: Diego recuerda si hablaste con el

Diego está en la asamblea.

{hable_con_diego_profundo:
    Te ve y se acerca.

    "Che, lo que hablamos el otro día... me quedó dando vueltas.
    Creo que tenías razón."

    ~ diego_relacion += 1
}
{conte_a_alguien && vinculo == "diego":
    Diego asiente cuando te ve.

    Hay algo compartido ahí.
    Un secreto. Tu despido.
    Él sabe. Y vos sabés que él sabe.
}

->->

// --- FRAGMENTOS DE NOCHE ---

=== fragmento_sabado_default ===

El barrio duerme.
La asamblea pasó.
Mañana es domingo.

La semana que viene empieza todo de vuelta.
Pero quizás no igual.

* [Continuar] -> domingo_amanecer
