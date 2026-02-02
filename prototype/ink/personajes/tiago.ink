// TIAGO - El Pibe de Logística
// ============================================
// Edad: 16 | Rol: Adolescente del barrio, logística de la olla
// Arquetipo: El Futuro en Riesgo / El Institucionalizado
// 
// Sistema de confianza (tiago_confianza):
// 0 = Desconfianza total (recién llegado)
// 1 = Te tolera (ayudaste una vez)
// 2 = Te observa (no le fallaste)
// 3 = Te prueba (te cuenta algo personal)
// 4 = Te acepta (defendiste algo suyo)
// 5 = Confianza real (lealtad)
//
// Variables de estado:
// - tiago_confianza: nivel de confianza (0-5)
// - tiago_estado: "presente", "ido", "capturado"
// - tiago_historia_inau: contó algo del INAU
// - tiago_se_queda: decidió quedarse
// - tiago_captado_por_bruno: se fue con Bruno

// ============================================
// PRIMER ENCUENTRO - DESCONFIANZA
// ============================================

=== tiago_primer_encuentro ===
// Escena Jueves/Viernes en la Olla - Primera vez que lo ves

Un pibe flaco, con gorra, está moviendo cajones de verdura.
No parece tener más de 16 años.
Los brazos son pura fibra y nervio.

Te ve mirando.
"¿Qué mirás? ¿Ayudás o estorbás?"

* [Ofrecer ayuda.]
    "Vengo a dar una mano."
    
    Te mira de arriba abajo.
    Evaluando.
    
    Te tira una bolsa de papas. Pesada.
    "Ponela ahí. Que no toque el piso, que chupa humedad."
    
    Sabe lo que hace.
    
    ~ tiago_confianza = 1
    ->->

* [Preguntar quién es.]
    "¿Y vos quién sos?"
    
    "Soy el que mueve las cosas para que coman."
    
    Sigue laburando. No le interesa charlar.
    
    ~ tiago_confianza = 0
    ->->

* [Quedarte mirando.]
    Seguís mirando.
    
    "Bo, ¿sos de la tele o qué? Dejá de mirar y hacé algo."
    
    Te da la espalda.
    
    ~ tiago_confianza = 0
    ->->

=== tiago_prueba_inicial ===
// Escena: Tiago te pone a prueba (si tiago_confianza == 1)

{tiago_confianza != 1:
    ->->
}

Tiago te llama.

"Ey. Vos."

Señala unas cajas pesadas.

"Hay que llevar eso al fondo. Pero el pasillo está lleno de mierda.
Hay que mover todo primero."

Te mira fijo.

"¿Podés o es mucho?"

* [Hacerlo sin quejarte.]
    Agarrás la primera caja.
    Pesada.
    
    Tiago te mira trabajar.
    Veinte minutos.
    Sudor.
    Dolor de espalda.
    
    Cuando terminás, asiente.
    
    "Bien."
    
    No dice más.
    Pero es suficiente.
    
    ~ tiago_confianza = 2
    ->->

* [Preguntar por qué vos.]
    "¿Y por qué no lo hacés vos?"
    
    Tiago se ríe.
    
    "Porque yo ya hice el triple antes de que llegaras.
    Pero si no podés, decilo."
    
    * * [Hacerlo.]
        Agarrás la caja.
        -> tiago_trabajo_duro
    
    * * [Decir que no podés.]
        "Ahora no puedo."
        
        Tiago asiente.
        "Está bien. Pero no vuelvas a ofrecerte si no vas a cumplir."
        
        ~ tiago_confianza = 0
        ->->

=== tiago_trabajo_duro ===
Terminás el trabajo.
Tiago observa.

"No te quejaste."

Pausa.

"Casi todos se quejan."

~ tiago_confianza = 2
->->

// ============================================
// COMPETENCIA DE LOGÍSTICA
// ============================================

=== tiago_logistica_problema ===
// Escena: Hay un problema logístico que nadie puede resolver

Sofía está preocupada.

"Llegaron las donaciones de la iglesia. Pero son cien kilos de harina y no tenemos dónde ponerla. El depósito está lleno y si la dejamos afuera se moja."

La gente discute.
"Hay que hacer lugar."
"¿Dónde?"
"Tiramos algo."
"¿Tiramos comida?"

Tiago escucha desde la esquina.

* [Preguntar si tiene alguna idea.]
    "Tiago, ¿se te ocurre algo?"
    
    Todos te miran.
    Tiago también.
    
    Sorprendido de que alguien le pregunte.
    
    -> tiago_resuelve_logistica

* [Esperar a ver qué pasa.]
    -> tiago_resuelve_solo

=== tiago_resuelve_logistica ===

Tiago se acerca.
Mira el depósito. Mira el patio. Mira las bolsas.

"Hay que armar una tarima."

"¿Con qué?"

"Los palets del fondo. Los que tiran en el supermercado.
Si los apilás y los tapás con un nylon, la harina queda seca."

Sofía lo mira.

"¿Y el nylon?"

"El de las obras. Siempre sobra. Yo sé dónde hay."

* [Apoyar la idea.]
    "Suena bien. ¿Necesitás ayuda?"
    
    Tiago asiente.
    "Vení."
    
    -> tiago_consigue_materiales

* [Dejar que lo haga solo.]
    Tiago se va.
    Vuelve en una hora con todo.
    
    La harina queda guardada.
    Seca.
    
    ~ tiago_confianza += 1
    ->->

=== tiago_resuelve_solo ===

Tiago se para.
Sin que nadie le pregunte.

"Hay que armar una tarima con palets.
Yo sé dónde conseguir."

Se va.
Vuelve en una hora con los materiales.

La harina queda guardada.
Seca.

Sofía le agradece.
Tiago se encoge de hombros.

"Es lo que hay que hacer."

->->

=== tiago_consigue_materiales ===

Caminan juntos.
Tiago conoce cada pasillo del barrio.
Cada atajo. Cada baldío.

"Acá."

Atrás de una obra abandonada.
Palets. Nylon. Sogas.

"¿Cómo sabías que estaba esto?"

Tiago se encoge de hombros.

"Cuando vivís en la calle, aprendés dónde hay cosas."

No dice más.
Pero dijiste mucho.

Vuelven con todo.
La harina queda guardada.

Sofía le agradece.
Tiago asiente.

Te mira.

"Gracias por preguntar."

Es lo más parecido a un cumplido que vas a escuchar.

~ tiago_confianza += 2
->->

// ============================================
// CONFLICTO CON CLAUDIA (COMIDA PARA LA ABUELA)
// ============================================

=== tiago_conflicto_comida ===
// Escena Viernes: El conflicto con Claudia por la porción

Tiago se acerca a la olla con un tupper sucio.
"Es para la vieja. No puede venir."

Claudia (la auditora) se interpone.
"No se puede retirar comida. Es para consumo en el local."

Tiago te mira a vos. Los ojos inyectados de bronca.
"¿Le vas a decir algo a la cheta esta o qué?"

* [Defender a Tiago.]
    Te plantás frente a Claudia.
    "La abuela de Tiago existe. Vive a dos cuadras. No puede caminar. Lleváselo, pibe."
    
    Tiago no espera. Agarra el tupper y desaparece.
    Claudia anota algo en su carpeta.
    
    ~ tiago_confianza += 2
    ~ claudia_hostilidad += 1
    ~ disminuir_inercia(1)
    ->->

* [Intentar negociar.]
    "Claudia, ¿no se puede hacer una excepción? La señora no puede venir."
    
    Claudia duda.
    
    "Tendría que anotarlo. Y ver si hay suficiente."
    
    Tiago bufa.
    "Dejá. Me las arreglo."
    
    Se va sin el tupper.
    
    ~ tiago_confianza += 1
    ->->

* [No intervenir.]
    Te quedás callado.

    Tiago tira el tupper al piso.
    "Métanse el guiso en el orto."

    Se va pateando una silla.

    ~ tiago_estado = "ido"
    ~ aumentar_inercia(1)
    ->->

// ============================================
// HISTORIA INAU - APERTURA
// ============================================

=== tiago_se_abre ===
// Escena Viernes/Sábado: Si tiago_confianza >= 3
// Primera apertura sobre su pasado

{tiago_confianza < 3:
    ->->
}

Tiago se sienta a tu lado.
No dice nada.

Después de un rato:

"Mi vieja está internada.
En el Vilardebó."

# PAUSA

No te mira.

"No voy a visitarla.
No puedo."

# PAUSA

* [Escuchar en silencio.]
    No decís nada.

    A veces el silencio es el único respeto.

    Tiago asiente.
    "Gracias por no decir nada."

    ~ tiago_confianza += 1
    ->->

* [Decir algo de apoyo.]
    "Está bien no poder."

    Tiago te mira.
    Por primera vez, sin desafío.

    "¿Vos creés?"

    "Sí."

    ~ tiago_confianza += 1
    ->->

=== tiago_historia_inau ===
// Escena: Tiago cuenta algo del INAU (si tiago_confianza >= 4)

{tiago_confianza < 4:
    ->->
}

Están solos.
Tiago fuma.
No debería, pero nadie le dice nada.

"¿Sabés qué es lo peor del INAU?"

No esperás la pregunta.

* [Preguntar.]
    "¿Qué?"

    -> tiago_cuenta_inau

* [Esperar.]
    Esperás.
    -> tiago_cuenta_inau

=== tiago_cuenta_inau ===

"Que te acostumbrás."

# PAUSA

"Te acostumbrás a que te muevan de un lugar a otro.
A que te digan que 'es por tu bien'.
A que la gente que te cuida cambie cada seis meses."

Tira el pucho.

"Te acostumbrás a que nadie se quede."

# PAUSA

"Y cuando salís... no sabés cómo es que alguien se quede.
Esperás que se vayan.
Siempre."

* ["Yo no me voy a ir."]
    "Todos dicen eso."
    
    "Yo no soy todos."
    
    Tiago te mira.
    Larga.
    
    "Vamos a ver."
    
    Pero hay algo en su voz.
    Algo como esperanza.
    
    ~ tiago_confianza += 1
    ~ tiago_historia_inau = true
    ->->

* [Quedarte en silencio.]
    No decís nada.
    Porque cualquier cosa que digas va a sonar falsa.
    
    Tiago asiente.
    
    "Gracias por no prometer nada."
    
    ~ tiago_historia_inau = true
    ->->

=== tiago_recuerdo_hogar ===
// Fragmento: Recuerdo del hogar del INAU

Tiago se acuerda.

El hogar de Colón.
Las cuchetas de metal.
El olor a lavandina.

Los educadores que cambiaban cada pocos meses.
Algunos buenos. La mayoría cansados.

"Portate bien y te va a ir bien."

Mentira.
Se portó bien y lo movieron igual.
Tres hogares en cuatro años.

Aprendió que "portarse bien" no sirve.
Aprendió que las promesas no se cumplen.
Aprendió a no confiar.

Ahora está en la olla.
Donde Sofía le dice "volvé mañana" y lo cumple.
Donde hay comida y no hay formularios.

Es lo más parecido a un hogar que tuvo.

->->

// ============================================
// RELACIÓN CON BRUNO - PRESIÓN
// ============================================

=== bruno_presiona_tiago ===
// Escena: Bruno intercepta a Tiago

Estás llegando a la olla.
Ves la camioneta de Bruno estacionada en la esquina.

Tiago está adentro.
Hablando.

Bruno le pone una mano en el hombro.
Tiago se pone tenso.

* [Acercarte.]
    Caminás hacia la camioneta.

    Bruno te ve.
    Sonríe.

    "¡Eh! El vecino nuevo. ¿Todo bien?"

    -> bruno_tiago_intercepcion

* [Observar de lejos.]
    Te quedás mirando.

    Tiago te ve.
    Sus ojos dicen algo.
    No sabés qué.

    Bruno arranca.
    Tiago adentro.

    Vuelve una hora después.
    No dice nada.

    ~ aumentar_inercia(1)
    ->->

=== bruno_tiago_intercepcion ===

"Tiago me estaba contando que anda sin un mango.
Le ofrecí un laburito. Nada pesado."

Tiago mira el piso.

* [Intervenir.]
    "Tiago, Sofía te andaba buscando. Necesita ayuda con las cajas."

    Mentira.
    Pero Tiago entiende.

    "Ah, sí. Ya iba."

    Se baja de la camioneta.

    Bruno te mira.
    La sonrisa no llega a los ojos.

    "Otro día será, entonces."

    Arranca.

    Tiago camina a tu lado.
    No dice nada.
    Pero no hace falta.

    ~ tiago_confianza += 2
    ~ disminuir_inercia(1)
    ->->

* [No intervenir.]
    "Todo bien, Bruno."

    Te vas.

    No sabés qué pasó después.
    Tiago no te cuenta.

    ~ aumentar_inercia(1)
    ->->

=== bruno_oferta_chacra ===
// Escena: Bruno le ofrece la chacra a Tiago directamente

{tiago_confianza >= 3:
    Tiago te busca.

    "Bruno me ofreció llevarme a la chacra.
    Dice que hay laburo. Comida. Un lugar para dormir."

    Te mira.

    "No sé qué hacer."

    * [Preguntar qué piensa.]
        "¿Vos qué querés hacer?"
        
        Tiago se rasca la cabeza.
        
        "No sé. Acá no hay plata. Pero... no sé."
        
        -> tiago_duda_chacra

    * [Advertirle sobre Bruno.]
        "Bruno no hace nada gratis, Tiago."
        
        "Ya sé. Pero..."
        
        -> tiago_duda_chacra
- else:
    ->->
}

=== tiago_duda_chacra ===

"En el INAU me prometieron muchas cosas.
Nunca cumplieron."

# PAUSA

"Pero acá... ¿qué tengo acá?"

* [Decir que tiene la olla.]
    "Tenés la olla. A Sofía. A nosotros."
    
    Tiago te mira.
    
    "¿Y eso alcanza?"
    
    -> tiago_decision_final

* [Decir que él decide.]
    "Es tu vida, Tiago."
    
    -> tiago_decision_final

// ============================================
// DECISIÓN FINAL
// ============================================

=== tiago_decision_final ===
// La encrucijada: quedarse o irse con Bruno

Tiago piensa.
Largo rato.

* [Decirle que se quede.]
    "Quedate, Tiago.
    Acá también hay lugar.
    No es una chacra, pero es real."

    Tiago piensa.

    "¿Y si no alcanza?"

    "Vamos a hacer que alcance.
    Pero juntos."

    Tiago asiente.

    ~ tiago_se_queda = true
    ~ tiago_estado = "presente"
    ~ subir_llama(2)
    ~ subir_conexion(1)
    ->->

* [Dejarlo decidir.]
    "No sé, Tiago.
    Es tu vida.
    Yo no te puedo decir qué hacer."

    Tiago baja la cabeza.

    "Nadie me dijo eso nunca."

    Se queda pensando.

    {llama >= 6:
        "Me quedo. Por ahora."
        ~ tiago_se_queda = true
        ~ tiago_estado = "presente"
    - else:
        "Voy a ir. A ver qué onda."
        ~ tiago_captado_por_bruno = true
        ~ tiago_estado = "capturado"
        ~ bajar_llama(2)
    }
    ->->

// ============================================
// FRAGMENTOS NOCTURNOS
// ============================================

=== fragmento_tiago_techo ===
// Tiago en un techo, mirando el barrio

Tiago está en el techo de la olla.
Se subió por la canaleta.

Desde arriba, el barrio parece distinto.
Más ordenado.
Menos caótico.

Piensa en la chacra de Bruno.
Piensa en la olla.
Piensa en la calle.

Tres opciones.
Ninguna buena.

Pero algunas son menos malas.

Se queda mirando las estrellas.
Las mismas de siempre.
Las únicas que no cambian.

->->

=== fragmento_tiago_hambre ===
// Tiago y el hambre

Tiago no comió hoy.

No porque no hubiera comida.
Sino porque llegó tarde.
Y no quiso pedir.

El hambre es vieja conocida.
Sabe cómo se siente el estómago vacío.
Cómo duele.
Cómo después deja de doler y empieza el mareo.

En el INAU comía.
No siempre rico, pero comía.
Afuera es distinto.

En la olla también come.
Pero tiene que ganárselo.
Eso lo hace diferente.

Mañana va a llegar temprano.
Va a mover cajas.
Va a ganarse el plato.

->->

// ============================================
// ESCENAS DOMINGO - RESULTADO
// ============================================

=== tiago_domingo ===
// Resultado de la decisión de Tiago

{tiago_se_queda:
    Tiago está en la olla.
    Barriendo. Ordenando.

    No habla mucho.
    Pero está.

    "¿Todo bien?", preguntás.

    "Más o menos."

    Pausa.

    "Pero estoy acá. Es algo."

    ~ subir_conexion(1)
    ->->
}

{tiago_captado_por_bruno:
    Pasás por la esquina.
    La camioneta de Bruno está ahí.

    Adentro, Tiago.
    Mira para otro lado cuando te ve.

    Ya no es del barrio.
    Ya no es de nadie.

    ~ bajar_llama(1)
    ->->
}

->->

=== tiago_en_asamblea ===
// Escena Sábado: Tiago en la asamblea (si se quedó)

{tiago_se_queda && participe_asamblea:
    Tiago está en el fondo.
    No habla. Escucha.

    Cuando alguien propone algo sobre los pibes del barrio,
    levanta la mano.

    "Yo puedo ayudar con eso."

    Primera vez que lo ves participar.
    Primera vez que se ofrece.

    ~ tiago_confianza += 1
    ~ subir_llama(1)
    ->->
- else:
    ->->
}

=== tiago_final_red ===
// Final LA RED: Tiago es parte del equipo
// Llamar desde final_red si tiago_se_queda

{tiago_se_queda:
    Tiago está en la puerta de la olla.
    Con una lista.

    "Hoy vienen treinta familias.
    Hay comida para cuarenta.
    Sobra."

    Sonríe.
    Primera vez que lo ves sonreír.

    "Mañana capaz que vienen más.
    Hay que conseguir más papas."

    Ya no es el pibe que movía cajas.
    Es parte del equipo.
}

->->

=== tiago_final_solo ===
// Final SOLO/GRIS: Tiago es una estadística
// Llamar desde finales negativos si tiago_captado_por_bruno

{tiago_captado_por_bruno:
    En el noticiero:

    "Joven de 16 años detenido en operativo antidrogas.
    Tenía antecedentes en INAU.
    Fue trasladado al SIRPA."

    Pasan la foto.
    Es Tiago.

    Otra estadística.
    Otro número.

    El sistema cumplió su profecía.
}

->->
