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

// --- Ecos del jueves ---
{fui_a_olla_jueves:
    Te acordás de ayer en la olla.
    Las manos con olor a cebolla.
    Las caras.
    Hoy hay que volver.
}
{ayude_a_diego:
    Diego te mandó un mensaje anoche: "Gracias por la mano, che."
}

Dos días sin laburo.
Se siente más largo.

El viernes antes era el mejor día.
Fin de semana, descanso, algo de plata.

* [...]
-

Ahora es solo otro día.

{fui_a_olla_jueves: Sofía dijo que hoy necesitaban resolver algo. La olla está en crisis.}

* [Levantarte] -> viernes_manana

=== viernes_manana ===

El café.
La mañana.

El sostén energético más honesto: algo caliente y amargo que te hace funcionar.

{olla_en_crisis:
    Pensás en la olla.
    En que dijeron que no tenían para hoy.
    En que hay gente que depende de eso.
}

¿Qué hacés hoy?

* [Ir a la olla temprano] # EFECTO:llama+
    -> viernes_olla_temprano
* [Buscar laburo primero] # COSTO:1 # STAT:dignidad # EFECTO:dignidad-
    -> viernes_buscar
* {lucia_relacion >= 1} [Llamar a Lucía]
    -> lucia_post_despido ->
    * * [Ir a la olla después]
        -> viernes_olla_temprano
    * * [Buscar laburo]
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

// Claudia llega a auditar
-> claudia_llegada ->

// Eco: Elena recuerda si le contaste tu historia
-> viernes_olla_elena_eco ->

// Ambiente de crisis
-> olla_ambiente_crisis ->

// EL CONFLICTO: CLAUDIA (Fase 2)
-> claudia_la_auditoria ->

// Conflicto Tiago vs Claudia por el tupper
{tiago_confianza >= 1:
    -> tiago_conflicto_comida ->
}

{lista_entregada:
    // TRAICIÓN: Hay comida pero a un costo terrible
    Sofía cocina en silencio.
    Nadie habla.
    La comida está asegurada.
    Pero se siente robada.
    -> viernes_olla_tarde
- else:
    // DIGNIDAD: No hay lista, no hay comida del estado
    // Ahora hay que salir a buscar
    "Bueno", dice Sofía. "No tenemos los insumos secos."
    "Pero tenemos dignidad."
    "Ahora hay que conseguir comida."
    -> viernes_reunion
}

=== viernes_reunion ===

# LA REUNION DE LA OLLA

Están: Sofía, Elena, dos o tres más que no conocés bien.

El problema es simple:
Claudia cortó los insumos.
Vienen 30 personas a comer.
No tienen qué darles.

* [...]
-

"Las donaciones no llegaron."
"El municipio no contesta."
"Los comercios ya dijeron que no."

Silencio.

¿Qué se puede hacer?

* [Proponer una colecta rápida] # EFECTO:dignidad+ # EFECTO:llama+
    -> viernes_colecta
* [Proponer pedir a vecinos] # EFECTO:dignidad+ # EFECTO:llama+
    -> viernes_vecinos
* [Proponer cancelar por hoy] # EFECTO:llama- # EFECTO:dignidad+
    -> viernes_cancelar_olla
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

=== viernes_cancelar_olla ===

"Capaz que... capaz que hoy no."

Silencio.

Sofía te mira.

"¿Cancelar?"

"No podemos dar lo que no tenemos. Mejor cerrar hoy que... que improvisar mal."

~ bajar_llama(2)
~ subir_dignidad(1)
~ vos_propusiste_cerrar = true

Elena suspira.
"Tiene razón. Una vez cerramos en el 2002. Fue un día. Volvimos al otro."

Sofía se sienta.
Tiene la cara de alguien que no durmió.

* [...]
-

"Okay. Cerramos."

~ olla_cerro_viernes = true

Diego no dice nada.
Nadie dice nada.

El silencio pesa.

* [Quedarte con ellos] -> viernes_quedarse_cerrado
* [Irte] -> viernes_irte_cerrado

=== viernes_quedarse_cerrado ===

Te quedás.
No hay mucho que hacer.
Pero te quedás.

Sofía hace café.
Elena mira por la ventana.
Diego ordena sillas vacías.

* [...]
-

Es raro estar acá cuando no hay comida.
Cuando no hay gente.

Pero estás.

~ subir_conexion(1)

* [Pasar la tarde] -> viernes_noche

=== viernes_irte_cerrado ===

Te vas.
No hay nada que hacer acá.

Caminás por el barrio.
Pasás por la plaza.
El tipo del banco sigue ahí.

Hoy no hay olla.
Mañana capaz que sí.
Capaz que no.

* [Ir a casa] -> viernes_noche

=== viernes_plan ===

# EL PLAN

Deciden hacer las dos cosas:
- Pedir comida directa a vecinos
- Colecta rápida en la zona

* [...]
-

Se dividen.

"¿Vos podés ayudar?", pregunta Sofía.

* [Sí, voy con la colecta] # EFECTO:conexion+ # EFECTO:llama+
    -> viernes_colecta_accion
* [Sí, voy a pedir a vecinos] # EFECTO:conexion+ # EFECTO:llama+
    -> viernes_vecinos_accion
* [No puedo, tengo que hacer otra cosa] # EFECTO:conexion-
    -> viernes_no_ayudar

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

Diego se mueve diferente.
No pide con lástima. Pide con encanto.
Habla con las viejas. Les sonríe.

"Es un arte", te dice.
"Si das lástima, te dan sobras.
Si das alegría, te dan lo que tienen."

// Chequeo comunitario: la colecta depende de la fuerza del tejido social
# DADOS:CHEQUEO
~ temp resultado_viernes_colecta = chequeo_completo_comunitario(1, 4)
{ resultado_viernes_colecta == 2:
    Aprendés algo nuevo.
    El rebusque no es solo pedir. Es conectar.

    La gente responde. Más de lo esperado.
    Un almacenero da dos bolsas llenas. "Para los gurises", dice.
    Una vecina trae una olla de arroz ya hecho.

    Al final de la tarde, entre todos:
    Hay de sobra. Por primera vez en semanas.

    ~ subir_llama(1)
    ~ subir_conexion(1)
}
{ resultado_viernes_colecta == 1:
    Aprendés algo nuevo.
    El rebusque no es solo pedir. Es conectar.

    Al final de la tarde, entre todos:
    Hay para comprar verduras.
    No es mucho. Pero es algo.
}
{ resultado_viernes_colecta == 0:
    Aprendés, pero cuesta.
    La gente mira para otro lado. O da monedas.

    Al final de la tarde, entre todos:
    Apenas alcanza. Justo.
    Diego no dice nada. Pero se le nota en la cara.
}
{ resultado_viernes_colecta == -1:
    La gente no da. O da con desprecio.
    "Siempre pidiendo", dice uno.
    Diego aprieta los dientes. Vos también.

    Al final de la tarde:
    Casi nada. No alcanza.
    Van a tener que improvisar.

    ~ bajar_llama(1)
}

-> viernes_olla_tarde

=== viernes_vecinos_accion ===

// Tunnel de pedir a vecinos
-> olla_pedir_vecinos ->

// Elena sabe pedir
-> elena_pedir ->

// Chequeo social: convencer a los vecinos de donar
# DADOS:CHEQUEO
~ temp resultado_viernes_vecinos = chequeo_completo_social(elena_relacion, 4)
{ resultado_viernes_vecinos == 2:
    Los vecinos responden. Con ganas.
    Volvés con bolsas llenas. Papas, cebollas, fideos, hasta un pollo.
    Elena sonríe. "¿Viste? La gente es buena. Solo hay que saber pedir."
    ~ subir_conexion(1)
    ~ subir_llama(1)
}
{ resultado_viernes_vecinos == 1:
    Volvés con bolsas.
    No es mucho. Pero es algo.
}
{ resultado_viernes_vecinos == 0:
    Volvés con poco. Unas papas. Un paquete de arroz.
    "Está jodido para todos", dice Elena.
    No culpa a nadie. Pero la preocupación se le nota.
}
{ resultado_viernes_vecinos == -1:
    Casi nadie abre la puerta. Los que abren dicen que no.
    "No tenemos", dice una vecina. Y cierra.
    Volvés con las manos casi vacías.
    Elena no dice nada. Pero camina más lento.
    ~ bajar_llama(1)
}

-> viernes_olla_tarde

=== viernes_olla_tarde ===

# LA OLLA - TARDE

Vuelven todos.

// Resultado de la colecta
-> olla_resultado_colecta ->

La cocina empieza.
Todos ayudan.

// Conflicto Tiago vs Claudia
{tiago_confianza >= 1:
    -> tiago_conflicto_comida ->
}

// Ixchel durante la crisis - sigue cocinando con lo que hay
{ixchel_relacion >= 1:
    Ixchel está en la cocina.
    No dice nada. Pero sigue cocinando.
    Con lo que hay. Con lo que queda.

    "Siempre se puede con menos", murmura.
    "En mi pueblo, con menos se hacía más."

    ~ ixchel_relacion += 1
}

{energia > 0:
    Te quedás ayudando.
    Pelás, cortás, revolvés.
    Sos parte de esto.
    ~ subir_conexion(1)
}

* {energia >= 2} [Ofrecerte para la colecta] # COSTO:2 # EFECTO:conexion++ # EFECTO:llama+
    ~ energia -= 2
    Salís a pedir en los negocios.
    No es fácil. Pero conseguís algo.
    ~ veces_que_ayude += 1
    ~ subir_conexion(2)
    ~ subir_llama(1)

// Lucía aparece si la relación es buena
{lucia_relacion >= 2:
    -> lucia_en_olla ->
}

// Servir la comida
A las 7 la olla abre.

// Cacho está en la fila
-> cacho_en_la_fila ->

-> olla_servir ->

{veces_que_ayude == 1:
    ~ disminuir_inercia(1)
}

-> viernes_noche

=== viernes_tarde ===

~ energia -= 1

-> check_game_over ->

// Caminar por el barrio de tarde
-> barrio_caminar_tarde ->

// Mensaje de Juan
{juan_sabe_mi_situacion:
    -> juan_charla_viernes ->
}

{olla_en_crisis && not ayude_en_olla:
    Te preguntás cómo les habrá ido a los de la olla.
    Si resolvieron.
    Si cerraron.
}

// Bruno aparece a confrontar a Sofía
{bruno_tension >= 1 || fui_a_olla_jueves:
    -> bruno_confronta_sofia ->
}

El barrio sigue.
Vos seguís.
Pero algo falta.

* [Ir a casa] -> viernes_noche

=== viernes_noche ===

# VIERNES - NOCHE

-> check_game_over ->

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

// Hook de Juan: si tenés buena relación, te llama
{juan_relacion >= 4 && energia >= 1:
    -> juan_llamado_viernes ->
    
    Te quedás pensando en Juan.
    Siempre pareció el más seguro.
    Pero hoy su voz temblaba un poco.
    
    "Tengo miedo de ser el próximo", dijo.
    
    El miedo no respeta antigüedad.
}

~ energia = 0

Mañana es sábado.
Hay una asamblea en el barrio.
Para hablar de la olla, de la situación.

{ayude_en_olla: Te invitaron. Podés ir.}
{not ayude_en_olla: Escuchaste que hay. Quizás podrías ir.}

// Reflexión nocturna (Fase 3)
-> reflexion_nocturna ->

// Fragmento nocturno
-> seleccionar_fragmento_viernes ->

* [Dormir] -> fragmento_viernes

=== fragmento_viernes ===

# MIENTRAS DORMÍS

{vinculo == "sofia": -> fragmento_sofia_viernes}
{vinculo == "elena": -> fragmento_elena_viernes}
{vinculo == "diego": -> fragmento_diego_viernes}
{vinculo == "marcos": -> fragmento_marcos_viernes}
-> fragmento_viernes_default

=== fragmento_sofia_viernes ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Sofía está destruida.

    Hoy vio gente rota pidiendo comida.
    Vos entre ellos.

    "Todos terminan así", piensa.

    La olla no salva a nadie.
    Solo alarga la caída.
    Un plato de comida.
    Y mañana otra vez.

    Hasta que no hay mañana.

    { chance(50):
        ~ aumentar_inercia(1)
    }
    * [Continuar] -> transicion_viernes_sabado
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Sofía mira la olla vacía.

    Hoy vino menos gente.
    Mañana va a venir menos.

    "Se termina", piensa.

    El barrio se dispersa.
    Cada uno solo.
    La olla va a cerrar.

    No hay tejido que sostenga esto.
    Ya no hay nada.

    { chance(60):
        ~ bajar_llama(1)
    }
    * [Continuar] -> transicion_viernes_sabado
}

// FRAGMENTO NORMAL
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

* [Continuar] -> transicion_viernes_sabado

=== fragmento_elena_viernes ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Elena piensa en Raúl.

    En cómo el 2002 lo rompió.
    Nunca se recuperó del todo.

    Piensa en vos.
    "Ya está roto", piensa.

    El mismo proceso.
    Primero la humillación.
    Después la nada.

    Raúl murió un poco roto.
    Vos también vas a morir roto.
    Todos mueren rotos.

    { chance(50):
        ~ aumentar_inercia(1)
    }
    * [Continuar] -> transicion_viernes_sabado
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Elena está sola.

    Raúl murió.
    Los hijos lejos.
    Los vecinos ya ni saludan.

    "Nos convertimos en extraños", piensa.

    El barrio murió.
    La red se cortó.
    Ahora es cada uno solo.

    Hasta el final.
    Siempre solo.

    { chance(60):
        ~ bajar_llama(1)
    }
    * [Continuar] -> transicion_viernes_sabado
}

// FRAGMENTO NORMAL
# ELENA

Elena piensa en Raúl.

En el 2002, él tampoco dormía.
Pero salieron.
Juntos, salieron.

Mañana hay asamblea.
Ella va a ir.
Tiene cosas que decir.

* [Continuar] -> transicion_viernes_sabado

=== fragmento_diego_viernes ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Diego cuenta la plata.

    No alcanza.

    Piensa en su madre.
    En cómo le miente.
    "Estoy bien, má."

    No está bien.

    Dejó Venezuela para esto.
    Para ver cómo te destruyen en otro país.
    En otro idioma.

    Pero la destrucción es igual.
    Siempre igual.

    { chance(50):
        ~ aumentar_inercia(1)
    }
    * [Continuar] -> transicion_viernes_sabado
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Diego está solo en su pieza.

    Tres contactos en el celular.
    Su familia en Venezuela.

    "Crucé el continente para estar solo", piensa.

    La olla.
    El barrio.
    Todo le queda lejos.

    En Venezuela estaba solo.
    Acá está solo.

    No hay diferencia.

    { chance(60):
        ~ bajar_llama(1)
    }
    * [Continuar] -> transicion_viernes_sabado
}

// FRAGMENTO NORMAL
# DIEGO

Diego cuenta la plata.

No alcanza.
Nunca alcanza.
Pero hoy trabajó fuerte.

{ayude_en_olla:
    Y vos estuviste ahí.
    Cargando cajones a la par.
}

"La gente piensa que venimos a pedir", piensa.
"No venimos a pedir."
"Venimos a ser parte de algo."

Eso alimenta más que el guiso.
Casi.

Mañana sigue.

* [Continuar] -> transicion_viernes_sabado

=== fragmento_marcos_viernes ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Marcos piensa en vos.

    Ahora entendés.
    Ahora sabés lo que es.

    No hay dignidad.
    Nunca la hubo.
    Solo hay funcionar.

    Aceptar.
    Agachar la cabeza.
    Sobrevivir.

    "Bienvenido", piensa.

    Ya sos como él.
    Ya no queda nada más.

    { chance(50):
        ~ aumentar_inercia(1)
    }
    * [Continuar] -> transicion_viernes_sabado
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Marcos mira desde lejos.

    La gente se junta.
    Hablan de cambiar cosas.

    "No van a cambiar nada", piensa.

    Nunca cambió nada.
    La gente no tiene poder.
    Nunca lo tuvo.

    Mejor solo.
    Mejor apagado.
    Mejor no intentar.

    { chance(60):
        ~ bajar_llama(1)
    }
    * [Continuar] -> transicion_viernes_sabado
}

// FRAGMENTO NORMAL
# MARCOS

Marcos vio la asamblea desde lejos.

No entró.
No quiso.
O no pudo.

La gente hace cosas.
Él solo mira.

Quizás mañana.
Siempre quizás mañana.

* [Continuar] -> transicion_viernes_sabado

=== fragmento_viernes_default ===

El barrio duerme.
Los problemas siguen.

Mañana hay asamblea.
Para hablar de cómo seguir.

* [Continuar] -> transicion_viernes_sabado

=== transicion_viernes_sabado ===
// Chequeo de colapso mental antes de continuar
{inercia >= 10:
    -> recovery_mental_viernes
}
- (post_recovery_viernes)

// Chequeo de destrucción del tejido social
{llama <= 0:
    -> final_sin_llama
}

-> sabado_amanecer

=== recovery_mental_viernes ===
Todo se pone oscuro. Otra vez. Peor.

* [...]
-

{conexion <= 1 && llama <= 1:
    No queda nada.
    Ni gente. Ni fuego. Ni razón.

    -> final_apagado
}

Pero algo queda. Alguien dijo tu nombre hoy. Alguien te vio.

~ inercia = 9

No estás bien. Pero todavía estás.

-> transicion_viernes_sabado.post_recovery_viernes
