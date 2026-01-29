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

// --- Ecos del viernes ---
{olla_cerro_viernes:
    Ayer la olla cerró.
    Es sábado y todavía te pesa.
    40 personas que no comieron.
    ¿O sí comieron? ¿Dónde?
}
{not olla_cerro_viernes && ayude_en_olla:
    Ayer la olla funcionó.
    Con lo justo. Pero funcionó.
    Hoy hay asamblea.
}

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

{inercia <= 6: La cabeza sigue dando vueltas. Tres días sin laburo y ya parece una eternidad.}

// REMOVIDO: Juan no se integra a la olla, su arco es migración
// {juan_sabe_mi_situacion && ayude_en_olla:
//     -> juan_invitar_olla_sabado ->
// }

// Bruno recluta a Tiago si la olla falló
{olla_en_crisis || olla_cerro_viernes:
    -> bruno_recluta_tiago ->
}

// Decisión crucial de Tiago
{tiago_confianza >= 3 && not tiago_captado_por_bruno:
    -> tiago_decision_final ->
}

// Tiago se abre si hay confianza
{tiago_confianza >= 2 && not tiago_captado_por_bruno:
    -> tiago_se_abre ->
}

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
    "Hace mucho que no voy. Siempre es lo mismo."
    "Hoy no. Hoy vamos nosotros."
    Marcos te mira. Hay algo ahí. Una duda.
    "Vamos a ver", dice. Pero va.
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

* [Ir a la asamblea igual] # EFECTO:llama+
    -> sabado_asamblea
* [No ir] # EFECTO:conexion- # EFECTO:llama-
    -> sabado_noche_solo

=== sabado_tarde ===

-> check_game_over ->

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

// Cacho en la fila
{not olla_en_crisis:
    -> cacho_en_la_fila ->
}

// Cacho reacciona al cierre de la olla
{olla_cerro_viernes:
    -> cacho_sin_olla ->
}

// Lucía aparece en la olla
{lucia_consejo_sindical:
    -> lucia_en_olla ->
}

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

// Ixchel en la asamblea - su intervención desde la experiencia
{ixchel_relacion >= 2:
    Ixchel está al fondo.
    No habla. Pero escucha.

    En un momento, cuando alguien dice "esto se cae",
    ella dice, bajito:

    "En mi comunidad votaron 98% que no.
    Y la mina abrió igual.
    Pero no dejamos de juntarnos."

    Silencio.

    "Juntarse es lo primero. Lo demás viene después."

    ~ ixchel_relacion += 1
    ~ subir_llama(1)
}

// Bruno ofrece al protagonista
{inercia >= 7:
    -> bruno_oferta_protagonista ->
}

// Momento colectivo - boost de llama
{veces_que_ayude >= 2 && participe_asamblea:
    Algo pasa en la asamblea.
    No es grande. No es histórico.
    Pero es real.

    Alguien empieza a cantar.
    Una canción vieja. De cuando había fábricas.

    Elena la conoce. Sofía también.
    Uno a uno, se van sumando.

    No es esperanza ingenua.
    Es memoria. Es resistencia.

    ~ subir_llama(3)
    ~ activar_hay_cosas_juntos()
}

// Reconocimiento del barrio - boost de conexión
{veces_que_ayude >= 3 && conexion >= 5:
    Sofía te llama aparte.

    "Quiero decirte algo."
    "Cuando llegaste, pensé que eras otro más."
    "Me equivoqué."

    Te abraza.

    "Sos parte, ¿sabés? Ya sos parte."

    ~ subir_conexion(3)
    ~ sofia_relacion += 2
}

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

Hablás.

"Yo... hace tres días me quedé sin laburo. No sé bien qué puedo aportar. Pero tengo tiempo ahora. Y quiero ayudar."

// Chequeo comunitario: hablar frente a la asamblea, conectar con el grupo
# DADOS:CHEQUEO
~ temp resultado_sabado_hablar = chequeo_completo_comunitario(conexion, 4)
{ resultado_sabado_hablar == 2:
    -> sabado_hablar_critico
}
{ resultado_sabado_hablar == 1:
    -> sabado_hablar_exito
}
{ resultado_sabado_hablar == 0:
    -> sabado_hablar_fallo
}
-> sabado_hablar_crit_fallo

= sabado_hablar_critico
Te miran.

* [...]
-

Silencio. Y después algo inesperado: aplausos. Pocos, pero sinceros.

Sofía tiene los ojos húmedos.
Elena asiente con fuerza.

"Eso. Eso es lo que necesitamos. Gente que diga la verdad."

Tu voz encontró algo. Un nervio. Un lugar real.

~ subir_dignidad(2)
~ subir_conexion(1)
~ subir_llama(1)
-> sabado_asamblea_fin

= sabado_hablar_exito
Te miran.

* [...]
-

Sofía asiente.
Elena sonríe.

"Eso es lo que necesitamos. Gente."

~ subir_dignidad(1)
-> sabado_asamblea_fin

= sabado_hablar_fallo
Te miran.

* [...]
-

Algunos asienten. Otros miran para otro lado.
No es un discurso brillante. Pero es honesto.

Sofía dice: "Gracias."
Y sigue la reunión.

~ subir_dignidad(1)
-> sabado_asamblea_fin

= sabado_hablar_crit_fallo
Te miran.

* [...]
-

Se te corta la voz. Te trabás.

"Bueno... eso."

Te sentás. Rojo.
Nadie dice nada. Lo que es peor que si dijeran algo.

Sofía pasa a otro tema. Con suavidad.
Pero el silencio te quema.
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
    ~ modificador += 1  // Tenés credibilidad
}
{ participe_asamblea:
    ~ modificador += 1
}
{ sofia_relacion >= 4:
    ~ modificador += 1
}

~ temp resultado = chequeo(modificador, 5)

{
- resultado == 2 || (inercia <= 3 && ayude_en_olla):  // Crítico O Conciencia Despierta
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
// Éxito crítico: se abre el momento de análisis político

El resto de la asamblea fluye diferente.
Tu intervención cambió algo.

* [...]
-

Elena pide la palabra.

"Perdonen que me ponga memoriosa. Pero lo que dijo el compañero me hizo acordar."

* [Escuchar]
-

"En el 2002, cuando cerró el frigorífico, dijeron que era problema nuestro.
Que no éramos competitivos.
Que el mercado había decidido."

"Pero el mercado no decidió nada.
Los dueños decidieron.
Se llevaron la plata y nos dejaron afuera."

* [...]
-

"Lo que quiero decir es esto:
No sos vos el problema.
Nunca fuiste vos."

~ activar_no_es_individual()

# IDEA DESBLOQUEADA: "NO ES SOLO MI PROBLEMA"

La precariedad no es falla personal.
Es diseño.

* [...]
-

Diego suma:

"En Venezuela pasó igual.
Los patrones decían que ellos creaban trabajo.
Pero nosotros hacíamos todo el laburo.
Ellos solo firmaban."

"Un día paramos.
Y se dieron cuenta que sin nosotros
no hay empresa."

~ activar_antagonismo_clase()

# IDEA DESBLOQUEADA: "HAY INTERESES OPUESTOS"

No es que "todos estamos en el mismo barco".
Unos reman. Otros pasean.

* [...]
-

Sofía cierra:

"Bueno. Por eso estamos acá.
La olla no es caridad.
Es organización.
Es decir: nosotros podemos."

~ activar_autonomia_posible()

# IDEA DESBLOQUEADA: "PODEMOS ORGANIZARNOS SIN JEFES"

No necesitás permiso para cuidarte entre ustedes.

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

~ disminuir_inercia(1)

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

-> check_game_over ->

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

// Fragmento nocturno
-> seleccionar_fragmento_sabado ->

* [Dormir] -> fragmento_sabado

=== fragmento_sabado ===

# MIENTRAS DORMÍS

{vinculo == "sofia": -> fragmento_sofia_sabado}
{vinculo == "elena": -> fragmento_elena_sabado}
{vinculo == "diego": -> fragmento_diego_sabado}
{vinculo == "marcos": -> fragmento_marcos_sabado}
-> fragmento_sabado_default

=== fragmento_sofia_sabado ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Sofía está destruida.

    Hoy vio gente en la asamblea.
    Gente rota que intenta seguir.

    Vos también estabas ahí.
    Roto.

    "¿Para qué seguir?", piensa.

    La olla no salva a nadie.
    Solo retrasa lo inevitable.
    Un día más.
    Hasta que no hay más días.

    ~ aumentar_inercia(1)
    * [Continuar] -> transicion_sabado_domingo
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Sofía está sola en la olla.

    Hoy hubo asamblea.
    Vino poca gente.

    "El barrio se muere", piensa.

    Cada vez menos gente.
    Cada vez más solos.

    La olla va a cerrar.
    Es cuestión de tiempo.

    Y nadie va a hacer nada.

    ~ bajar_llama(1)
    * [Continuar] -> transicion_sabado_domingo
}

// FRAGMENTO NORMAL
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

* [Continuar] -> transicion_sabado_domingo

=== fragmento_elena_sabado ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Elena sueña con Raúl.

    Está en el frigorífico.
    El día que lo echaron.

    Vuelve a casa roto.
    Ya no es el mismo.

    "Nunca volvió a ser el mismo", piensa Elena.

    Despierta.
    Piensa en vos.

    Vos tampoco vas a volver a ser el mismo.
    Nadie vuelve.

    ~ aumentar_inercia(1)
    * [Continuar] -> transicion_sabado_domingo
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Elena está sola.

    Raúl murió.
    El barrio se dispersó.

    "Nos convertimos en islas", piensa.

    Cuando Raúl murió, tres vecinos vinieron.
    Antes hubiera sido el barrio entero.

    Ahora ni eso.
    Ahora solo puertas cerradas.

    ~ bajar_llama(1)
    * [Continuar] -> transicion_sabado_domingo
}

// FRAGMENTO NORMAL
# ELENA

Elena sueña con Raúl.

Están en el barrio.
Hace calor.
Él sonríe.

"¿Viste? Siempre salimos."

Se despierta.
Es un buen sueño.

* [Continuar] -> transicion_sabado_domingo

=== fragmento_diego_sabado ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Diego habló con su madre.

    "Estoy bien, má."
    Mentira.

    No está bien.

    Dejó Venezuela para esto.
    Para ver cómo te humillan.
    Para terminar roto.

    En otro país.
    En otro idioma.

    Pero la humillación es la misma.
    Siempre la misma.

    ~ aumentar_inercia(1)
    * [Continuar] -> transicion_sabado_domingo
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Diego está solo.

    Tres contactos en Uruguay.
    Su familia en Venezuela.

    "Crucé un continente para seguir solo", piensa.

    La asamblea.
    El barrio.
    Todo le queda lejos.

    Siempre le quedó lejos.
    Siempre va a quedar lejos.

    ~ bajar_llama(1)
    * [Continuar] -> transicion_sabado_domingo
}

// FRAGMENTO NORMAL
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

* [Continuar] -> transicion_sabado_domingo

=== fragmento_marcos_sabado ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Marcos piensa.

    Vos ahora entendés.
    Ya sos como él.

    No hay dignidad.
    Nunca la hubo.

    Solo hay funcionar.
    Aceptar.
    Agachar la cabeza.

    "Bienvenido", piensa.

    Ya no queda nada más.
    Nunca quedó.

    ~ aumentar_inercia(1)
    * [Continuar] -> transicion_sabado_domingo
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Marcos mira la asamblea desde lejos.

    Gente que se junta.
    Gente que habla de cambiar cosas.

    "No van a cambiar nada", piensa.

    La gente nunca cambió nada.
    Los de arriba ganan.
    Siempre ganan.

    Mejor solo.
    Mejor no intentar.
    Mejor apagarse.

    ~ bajar_llama(1)
    * [Continuar] -> transicion_sabado_domingo
}

// FRAGMENTO NORMAL
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

* [Continuar] -> transicion_sabado_domingo

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

* [Continuar] -> transicion_sabado_domingo

=== transicion_sabado_domingo ===
// Chequeo de colapso mental antes de continuar
{inercia >= 10:
    -> recovery_mental_sabado
}
- (post_recovery_sabado)

// Chequeo de destrucción del tejido social
{llama <= 0:
    -> final_sin_llama
}

-> domingo_amanecer

=== recovery_mental_sabado ===
La oscuridad viene de nuevo. Más fuerte.

* [...]
-

{conexion <= 1 && llama <= 1:
    No hay red. No hay llama. No hay mañana.

    -> final_apagado
}

{participe_asamblea:
    La asamblea. Las voces. Algo de eso queda.
- else:
    Una cara. Un gesto. Algo mínimo.
}

~ disminuir_inercia(3)

Mañana es domingo. Último día. Algo tiene que pasar.

-> transicion_sabado_domingo.post_recovery_sabado
