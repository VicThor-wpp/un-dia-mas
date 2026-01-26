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

* [...]
-

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
El café.
La rutina, pero vacía.

Moler.
Agua caliente.
Prensa francesa.

* [...]
-

El único mecanismo de supervivencia que hoy parece confiable.

Antes el café era apurado, entre ducharte y salir.
Ahora tenés todo el tiempo del mundo.

* [...]
-

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

* [...]
-

"Se busca. Experiencia mínima 5 años."
"Se busca. Hasta 25 años."
"Se busca. Disponibilidad full time. Pago por productividad."

* [...]
-

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

* [...]
-

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
        // Chequeo social: abrirte ante desconocidos en la olla
        # DADOS:CHEQUEO
        ~ temp resultado_jueves_abrirte = chequeo_completo_social(0, 4)
        { resultado_jueves_abrirte == 2:
            Sofía asiente. Algo en tu voz fue real. Crudo.
            "Gracias por contarlo. No es fácil."
            Te pone una mano en el hombro. Firme.
            "Acá nadie juzga. ¿Querés dar una mano?"
            ~ subir_conexion(2)
        }
        { resultado_jueves_abrirte == 1:
            Sofía asiente. No dice "qué bajón" ni "vas a conseguir algo".
            Solo asiente.
            "Bueno. ¿Querés dar una mano?"
            ~ subir_conexion(1)
        }
        { resultado_jueves_abrirte == 0:
            Sofía te mira. Asiente.
            "Está jodido. Lo sé."
            No hay mucho más. Pero no te rechaza.
        }
        { resultado_jueves_abrirte == -1:
            Las palabras salen mal. Entrecortadas.
            Sofía te mira sin entender del todo.
            "¿Perdón?"
            "Nada. Nada."
            La vergüenza te traga. No podés ni decirlo en voz alta.
            ~ bajar_salud_mental(1)
        }
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

// NUEVO: Avistamiento de Marcos
{not vino_marcos:
    De reojo, ves a alguien en la esquina.
    Campera oscura. Cabeza gacha.
    
    Es Marcos.
    
    Está mirando la olla desde lejos.
    Como si quisiera entrar pero una pared invisible lo frenara.
    
    * [Salir a buscarlo]
        Salís rápido.
        Pero Marcos te ve venir.
        Gira y se va. Casi corriendo.

        La vergüenza es más rápida que vos.
        -> jueves_olla_ver_post
    * [Dejarlo mirar]
        Lo dejás estar.
        A veces, mirar es el primer paso.

        Se queda un minuto más. Y se va.
        -> jueves_olla_ver_post
}

= jueves_olla_ver_post

* [Irte] -> jueves_noche

=== jueves_olla_ayudar ===

// Tunnel de ayudar en la cocina
-> olla_ayudar_cocina ->

// Encuentro con Ixchel en la cocina de la olla
{ixchel_relacion == 0:
    En la cocina hay alguien que no conocés.

    Una mujer baja, morena, pelo largo recogido.
    Pica verduras con una precisión que parece innata.

    -> ixchel_primer_encuentro_olla ->
}
{ixchel_relacion >= 1:
    Ixchel está en la cocina.
    Te saluda con un gesto breve.

    -> ixchel_en_olla ->
}

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

// Ir a buscar a Elena lleva a la olla donde está ayudando
Buscás a Elena.
No está en la plaza. No está en su casa.

Probás en la olla.

# LA OLLA

Ahí está.
Sentada en un banquito.
Pelando papas.

"Ah, m'hijo. Vos acá."

* [Sentarte a pelar con ella]
    -> jueves_charla_elena
* [Solo saludar y mirar]
    "Solo pasaba a saludar."
    "Bueno. Cuando quieras, agarrá un cuchillo."
    -> jueves_noche

=== jueves_charla_elena ===

~ ayude_en_olla = true

Te sentás a su lado.
Agarrás un cuchillo.
Un balde de papas entre los dos.

Estás en la cocina de la olla.
Elena pela papas a tu lado.

* [...]
-

// Preparar el chequeo de dados
~ temp modificador = 0

{elena_relacion >= 3:
    ~ modificador = 1
}

{escuche_sobre_2002:
    ~ modificador = modificador + 1
}

~ temp resultado = chequeo(modificador, 4)

{
- resultado == 2:  // Crítico
    # PORTRAIT:elena,remembering,right

    Pelás en silencio un rato.

    Elena para de pelar.
    Te mira.

    "Vos me hacés acordar a Raúl."

    Pausa larga.

    "Él también se sentaba así. Pelando. Sin decir nada.
    Pero estando."

    Se le humedecen los ojos.
    No dice más.
    No hace falta.

    ~ elena_relacion += 2
    ~ subir_conexion(1)

    {idea_pedir_no_debilidad == false:
        # IDEA DISPONIBLE: "PEDIR AYUDA NO ES DEBILIDAD"

        Hay algo en el silencio compartido.
        En estar sin tener que explicar.
        En ayudar sin que te lo pidan.

        * [Internalizar la idea]
            ~ idea_pedir_no_debilidad = true

            # IDEA: "PEDIR AYUDA NO ES DEBILIDAD"

            Pedir ayuda no es debilidad.
            Estar para alguien no es caridad.
            Es lo que se hace.
            -> jueves_elena_fin
        * [Dejar pasar]
            -> jueves_elena_fin
    - else:
        -> jueves_elena_fin
    }

- resultado == 1:  // Éxito
    # PORTRAIT:elena,wise,right

    Elena te mira las manos.
    "No aprietes tanto, m'hijo. La papa siente que tenés miedo."
    
    Se ríe, pero con cariño.
    
    "Estás acá ayudando, sí. Pero te veo los ojos.
    Tenés miedo de terminar necesitando el plato vos también."
    
    Te quedás helado. Elena ve todo.
    
    "En el 2002 nos pasaba lo mismo.
    Nos daba vergüenza caer. Como si fuera culpa nuestra."
    
    Te muestra cómo pela ella.
    Rápido. Eficiente. Memoria muscular de la crisis.
    
    "Pero escuchame bien:
    Esto no es un pozo donde caés.
    Es una trinchera donde nos juntamos."
    
    "El de arriba te quiere con vergüenza y solo.
    Acá te queremos con orgullo y juntos."

    -> elena_historia_2002 ->

    Hay algo cómodo en el silencio compartido.
    Las manos ocupadas. La mente quieta.

    ~ elena_relacion += 1
    ~ subir_conexion(1)

    -> jueves_elena_fin

- resultado == -1:  // Fumble
    # PORTRAIT:elena,worried,right

    Pelás apurado.
    Sin concentrarte.

    Te cortás el dedo con el cuchillo.

    "¡Pará, pará!"

    Elena deja todo.
    Te cura con alcohol.
    Duele.

    "Despacio, pibe. Esto no es carrera."

    Te venda el dedo con un trapo limpio.

    Es un momento íntimo.
    Raro. Pero íntimo.

    Como si fueras su hijo.
    Como si ella fuera tu abuela.

    ~ elena_relacion += 1

    -> jueves_elena_fin

- else:  // Fallo normal
    # PORTRAIT:elena,neutral,right

    Pelás en silencio.
    Elena también.

    El trabajo fluye.
    Sin palabras.

    No está mal.
    A veces el silencio es suficiente.

    Las papas se acumulan.
    El tiempo pasa.

    // En el fallo normal, Elena habla del barrio
    -> elena_hablar_barrio ->

    -> jueves_elena_fin
}

=== jueves_elena_fin ===

Terminás de ayudar.
Las manos mojadas. El olor a papa.

Elena asiente.
"Gracias por la mano, m'hijo."

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

* [...]
-

La cabeza sigue dando vueltas.
Tres meses.
Noventa días.
La cuenta regresiva.

// Chequeo mental: enfrentar la primera noche sin laburo
# DADOS:CHEQUEO
~ temp resultado_jueves_noche = chequeo_completo_mental(0, 4)
{ resultado_jueves_noche == 2:
    Pero algo te frena el espiral.
    Un pensamiento claro entre la niebla:
    "Hoy pasó el primer día. Y seguís acá."
    No es mucho. Pero es suficiente para cerrar los ojos.
    ~ subir_dignidad(1)
}
{ resultado_jueves_noche == 1:
    {ayude_en_olla: Pero hoy hiciste algo. Ayudaste en la olla. Eso es algo.}
    {fui_a_olla_jueves && not ayude_en_olla: Fuiste a la olla. Viste algo. Quizás mañana.}
    {not fui_a_olla_jueves: No saliste mucho. Mañana quizás.}
}
{ resultado_jueves_noche == 0:
    {ayude_en_olla: Ayudaste en la olla. Pero no alcanza para silenciar la cabeza.}
    {not ayude_en_olla: El día pasó. No hiciste mucho. La culpa no deja dormir.}
    Las tres de la mañana. Seguís despierto. Mirando el techo.
}
{ resultado_jueves_noche == -1:
    La cabeza no para. No para. No para.
    ¿Qué hice mal? ¿Podría haber hecho algo distinto?
    ¿Voy a terminar en la calle?
    El pensamiento se repite en loop. Hasta las cinco de la mañana.
    ~ bajar_salud_mental(1)
}

// Juan te llama
{vinculo == "sofia" || vinculo == "elena" || vinculo == "diego":
    -> juan_encuentro_jueves ->
}

El viernes viene.
La olla necesita resolver algo.
Vos también.

* [Dormir] -> fragmento_jueves

=== fragmento_jueves ===

# MIENTRAS DORMÍS

{vinculo == "sofia": -> fragmento_sofia_jueves ->}
{vinculo == "elena": -> fragmento_elena_jueves ->}
{vinculo == "diego": -> fragmento_diego_jueves ->}
{vinculo == "marcos": -> fragmento_marcos_jueves ->}

-> fragmento_comun_jueves

=== fragmento_marcos_jueves ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Marcos piensa en vos.

    Ya sos como él.
    Roto. Funcional. Vacío.

    "Ahora entendés", piensa.

    No hay salida.
    Solo hay aceptar.
    Aceptar que esto es todo.
    Que nunca fue más.

    Mañana va a ser igual.
    Siempre igual.

    ~ bajar_salud_mental(1)
    ->->
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Marcos mira el celular.

    Veinte mensajes sin leer.
    La asamblea del barrio.
    Invitaciones.
    Gente que intenta.

    "Para qué", piensa.

    La gente no cambia nada.
    Nunca cambió nada.
    Nunca va a cambiar nada.

    Mejor solo.
    Mejor apagado.

    ~ bajar_llama(1)
    ->->
}

// FRAGMENTO NORMAL
# MARCOS

Marcos tampoco duerme.

El departamento vacío.
La tele encendida sin sonido.
Los mensajes sin responder.

Pensó en ir a la asamblea.
No fue.
Es más fácil no ir.

Mañana es otro día igual.

->->

=== fragmento_sofia_jueves ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Sofía mira la olla vacía.

    Piensa en toda la gente que pasó por acá.
    Gente que llegó rota.
    Gente que se fue más rota.

    Vos sos uno más.

    "No sé si puedo seguir viendo esto", piensa.

    Cada día llega alguien más destruido.
    Cada día la olla alcanza para menos.

    Todo cae.
    Todo se rompe.

    ~ bajar_salud_mental(1)
    ->->
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Sofía está sola en la cocina.

    Hoy vino poca gente.
    Mañana va a venir menos.

    "La olla se muere", piensa.

    Cuando empezó, el barrio se juntaba.
    Ahora cada uno se salva solo.

    O no se salva.

    La llama se apaga.
    Y ella no sabe cómo volver a prenderla.

    ~ bajar_llama(1)
    ->->
}

// FRAGMENTO NORMAL
# SOFÍA

// Fragmento nocturno de Ixchel
-> ixchel_fragmento_noche ->

// Sofia pensando
-> sofia_fragmento_pensar ->

Mañana hay que buscar soluciones.

->->

=== fragmento_elena_jueves ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Elena piensa en toda la gente que vio romperse.

    En el 2002 fueron muchos.
    Gente que no volvió a ser la misma.

    Raúl también se rompió.
    Siguió funcionando.
    Pero algo murió en él.

    Vos también te estás rompiendo.
    Ella lo ve.

    "Ojalá alcance el tejido para sostenerlo", piensa.
    Pero no está segura.

    ~ bajar_salud_mental(1)
    ->->
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Elena prende la radio.

    Hablan de la crisis.
    De cómo la gente ya no se ayuda.

    "Tienen razón", piensa.

    El barrio ya no es barrio.
    Son casas una al lado de la otra.
    Nada más.

    Cuando Raúl murió, tres vecinos vinieron.
    Antes hubiera sido el barrio entero.

    Ya no hay barrio.
    Ya no hay nada.

    ~ bajar_llama(1)
    ->->
}

// FRAGMENTO NORMAL
# ELENA

// Fragmento nocturno de Elena
-> elena_fragmento_noche ->

->->

=== fragmento_diego_jueves ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Diego piensa en Venezuela.

    Dejó todo para venir acá.
    Para esto.
    Para ver cómo te humillan en otro idioma.

    Su madre pregunta cómo está.
    "Bien, má."
    Mentira.

    Piensa en vos.
    En cómo te vio hoy.
    Destruido.

    "Yo voy a terminar igual", piensa.
    "Todos terminamos igual."

    ~ bajar_salud_mental(1)
    * [Continuar] -> jueves_cliffhanger
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Diego cuenta.

    Tres personas le hablan en Uruguay.
    Tres.

    Su familia está en Venezuela.
    Sus amigos quedaron allá.

    Acá no tiene a nadie.

    "Crucé un continente para estar solo", piensa.

    En Venezuela estaba solo.
    Acá está solo.

    No hay diferencia.

    ~ bajar_llama(1)
    ->->
}

// FRAGMENTO NORMAL
# DIEGO

// Fragmento nocturno de Diego
-> diego_fragmento_noche ->

->->

=== fragmento_comun_jueves ===

// Olla cerrada de noche
-> olla_cerrar_noche ->

// Fragmento de Ixchel (si no fue visto en Sofia)
{fui_a_olla_jueves && vinculo != "sofia":
    -> ixchel_fragmento_noche ->
}

El barrio duerme.
Los problemas no.

* [Continuar] -> jueves_cliffhanger

// Fragmento de Ixchel (ex Yulimar)
{fui_a_olla_jueves:
    -> ixchel_fragmento_noche ->
}

* [Continuar] -> jueves_cliffhanger

=== jueves_cliffhanger ===

{conte_a_alguien && vinculo != "marcos":
    El celular vibra.

    {vinculo == "sofia":
        Sofía: "Mañana necesito hablar. Es sobre la olla. Urgente."
    }
    {vinculo == "elena":
        Elena: "Mañana te llamo temprano. Hay algo."
    }
    {vinculo == "diego":
        Diego: "Che, mañana te busco. Tengo una idea."
    }
}

* [Dormir] -> transicion_jueves_viernes

=== transicion_jueves_viernes ===
// Chequeo de colapso mental antes de continuar
{salud_mental <= 0:
    -> recovery_mental_jueves
}
- (post_recovery_jueves)

// Chequeo de destrucción del tejido social
{llama <= 0:
    -> final_sin_llama
}

-> viernes_amanecer

=== recovery_mental_jueves ===
Todo se pone oscuro. La cabeza no funciona.

* [...]
-

Pero algo te sostiene. Un recuerdo. Una cara. Algo.

~ salud_mental = 1

No estás bien. Pero seguís.

-> transicion_jueves_viernes.post_recovery_jueves
