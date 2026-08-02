// ============================================
// UBICACIÓN: EL LABURO
// Escenas en el trabajo
// ============================================

// --- LLEGADA ---

=== laburo_llegada ===

# LOC:oficina
# EL LABURO

Llegás.
8:05.
Justo.

El edificio de siempre.
La puerta de siempre.
El ascensor de siempre.

+ [...]
-

"Buen día."
"Buen día."
"Buen día."

Todos dicen buen día.
Nadie pregunta si lo es.

Afuera el bondi pasó lleno. Adentro el café cuesta ochenta pesos.
La empresa factura en dólares. Vos facturás en pesos.
La diferencia es el negocio de alguien.

->->

=== laburo_llegada_tarde ===

# LOC:oficina
# EL LABURO

Llegás.
8:25.
Tarde.

El jefe te ve entrar.
No dice nada.
Anota algo.

Mierda.

~ aumentar_inercia(1)

->->

// --- MAÑANA DE TRABAJO ---

=== laburo_manana ===

# LA MAÑANA

El escritorio.
La computadora.
Los mails.

Lo de siempre.

// Chequeo mental: concentración en el laburo
~ temp concentracion = chequeo_mental(0, 3)
{ concentracion == 2:
    Hoy estás afilado. Todo sale rápido y bien.
    El jefe pasa y asiente. Bien.
    ~ pequenas_victorias += 1
}
{ concentracion == 1:
    Estás enfocado. El trabajo sale. Las horas pasan sin dolor.
}
{ concentracion == 0:
    Te cuesta concentrarte. Releés el mismo mail tres veces.
    El cansancio pesa.
}
{ concentracion == -1:
    Cometés un error estúpido. Un mail al cliente equivocado.
    El jefe se da cuenta. "Prestá atención."
    ~ aumentar_inercia(1)
}

{d6() >= 5:
    Por la ventana se ve el puerto. Las grúas. Los contenedores que van y vienen.
    La riqueza del país pasando de largo.
}

->->

=== laburo_trabajo_rutina ===

Las horas pasan.

Mails.
Planillas.

+ [...]
-

Reuniones que podrían ser mails.
Mails que podrían ser nada.

{d6() <= 3:
    -> laburo_evento_tension
- else:
    // Evento Lucía (Fase 2)
    {lucia_relacion == 0 && d6() >= 4:
        -> lucia_escena_mate ->
    - else:
        {d6() <= 2:
            El jefe pasa por tu escritorio.
            Te mira.
            No dice nada.
            Sigue.

            ¿Qué mierda fue eso?
            ~ aumentar_inercia(1)
        }
    }
}

->->

=== laburo_evento_tension ===

~ temp evento = d6()

{ evento:
- 1:
    Vas al baño.
    Escuchás a alguien llorando en el cubículo del fondo.
    Tratás de no hacer ruido.
    Te lavás las manos rápido y salís.
    El sonido del llanto te sigue hasta el escritorio.
    ~ aumentar_inercia(1)

- 2:
    La impresora se traba.
    Vas a destrabarla y ves un papel que quedó a medias.
    "LISTA DE REVISIÓN DE PUESTOS - CONFIDENCIAL"
    Alguien te lo arranca de la mano antes de que leas nombres.
    "Dámelo." Es la secretaria de Personal.
    ~ aumentar_inercia(1)

- 3:
    Reunión de equipo.
    Falta una silla.
    "¿Y Gómez?"
    "Gómez... ya no está con nosotros."
    Nadie pregunta más.
    El aire acondicionado está demasiado frío.

- 4:
    Tu computadora se reinicia sola.
    Por un segundo, la pantalla negra te devuelve tu reflejo.
    Cara de miedo.
    "¿Será hoy?", pensás.
    No, hoy no. Reinicia.
    Pero el miedo queda.

- 5:
    Café en la cocina.
    Dos gerentes hablan bajito.
    Cuando entrás, se callan.
    Te sonríen. Una sonrisa de plástico.
    "Todo bien, ¿no?"
    "Sí, sí."
    Salís con el café ardiendo en la mano.

- 6:
    Un mail general.
    "Celebramos los resultados del trimestre."
    Gráficos en subida. Números verdes.
    Abajo, en letra chica: "Continuaremos optimizando recursos."
    Optimizar.
    Vos sos un recurso.
}

->->

// --- ALMUERZO ---

=== laburo_almuerzo ===

# ALMUERZO

12:30.
Hora de comer.

{ not dieta_elegida:
    Mirás el tupper.

    * [Comés de todo.]
        ~ es_vegano = false
        ~ dieta_elegida = true
        -> laburo_almuerzo_post_dieta
    * [Sos vegano.]
        ~ es_vegano = true
        ~ dieta_elegida = true
        -> laburo_almuerzo_post_dieta
}

= laburo_almuerzo_post_dieta

* [Almorzar acompañado] # DADOS # STAT:conexion # EFECTO:conexion+
    -> laburo_almuerzo_acompanado
* [Almorzar solo] # EFECTO:conexion-
    -> laburo_almuerzo_solo
* [Saltear el almuerzo] # EFECTO:dignidad-
    -> laburo_almuerzo_saltear

=== laburo_almuerzo_acompanado ===

Bajás al comedor.
Sacás el tupper de la mochila.

Lo que trajiste de casa.
Lo que pudiste armar anoche.

~ ultima_tirada = d6()
{es_vegano:
    {ultima_tirada <= 2: Arroz blanco con un chorro de aceite. Qué tristeza.}
    {ultima_tirada == 3 || ultima_tirada == 4: Fideos con salsa de tomate de lata. Sobreviviendo.}
    {ultima_tirada >= 5: Ensalada de lentejas que armaste con lo que quedaba. Un festín en este desierto.}
- else:
    {ultima_tirada <= 2: Arroz con huevo. Otra vez.}
    {ultima_tirada == 3 || ultima_tirada == 4: Fideos con tuco de ayer.}
    {ultima_tirada >= 5: Milanesa fría. Lujo.}
}

Te sentás con alguien.

// Chequeo social: conversación en el almuerzo
~ temp charla_almuerzo = chequeo_social(0, 3)
{ charla_almuerzo == 2:
    Enganchás una charla copada. Se ríen. Por un rato, olvidás todo.
    ~ subir_conexion(1)
}
{ charla_almuerzo == 1:
    Hablás de cosas. Por un rato, te olvidás de los problemas.
}
{ charla_almuerzo == 0:
    Hablás de cosas. Pero los problemas siguen ahí.
}
{ charla_almuerzo == -1:
    Metés la pata con un comentario. Silencio incómodo.
    Te levantás antes de tiempo.
    ~ bajar_conexion(1)
}

~ subir_conexion(1)

->->

=== laburo_almuerzo_solo ===

Comés solo.
En un rincón del comedor.
El tupper sobre la mesa.

A veces está bien.
El silencio.
No tener que hablar.

+ [...]
-

Mirás a los demás.
Cada uno con su vianda.
Algunos solos, otros en grupo.

¿Cuántos estiran la comida como vos?

->->

=== laburo_almuerzo_saltear ===

~ energia -= 1

No comés.
Seguís laburando.

El estómago protesta pero la cabeza dice que hay que demostrar compromiso.
Que te vean.
Que sepan que sos valioso.

+ [...]
-

...

A las 3 te morís de hambre.
Comprás algo en la máquina.

No sirvió de nada.

->->

// --- TARDE ---

=== laburo_tarde ===

# LA TARDE

La tarde es larga.
El cuerpo pide siesta.
La computadora pide atención.

Más mails.
Más tareas.
Más de lo mismo.

{d6() == 1:
    Un error. Algo que hiciste mal.
    El jefe te llama.
    "Esto está mal."
    "Sí, perdón. Lo corrijo."
    ~ bajar_dignidad(1)
}

->->

// --- REUNIONES ---

=== laburo_reunion_general ===
// Reunión de reestructuración

El salón grande.
Toda la oficina.
30, 40 personas.

El jefe y alguien de Personal al frente.

+ [...]
-

"Buenas tardes. Queríamos informarles..."

El aire se tensa.

"...que la empresa está atravesando un proceso de reestructuración."

Ahí está.

+ [...]
-

"No podemos dar detalles todavía, pero habrá cambios en las próximas semanas. Les pedimos paciencia y compromiso."

Eso es todo.
No dicen quién.
No dicen cuándo.
Solo que algo viene.

* [Mirar a un compañero] -> laburo_reunion_mirar_companero
* [Mirar al piso] -> laburo_reunion_mirar_piso
* [Mirar al jefe] -> laburo_reunion_mirar_jefe

=== laburo_reunion_mirar_companero ===

Mirás a tu compañero.
Él te mira.

Sin palabras, entienden.
Esto es real.

Hay miedo en sus ojos.
Probablemente en los tuyos también.

-> laburo_reunion_fin

=== laburo_reunion_mirar_piso ===

Mirás el piso.
No querés ver a nadie.
No querés que te vean.

El miedo se huele.
30 personas pensando lo mismo.
¿Seré yo?

-> laburo_reunion_fin

=== laburo_reunion_mirar_jefe ===

Mirás al jefe.
Está serio.
No mira a nadie en particular.

¿Él decide quién se va?
¿Él ya sabe?

No te mira.
No sabés si eso es bueno o malo.

-> laburo_reunion_fin

=== laburo_reunion_fin ===

La reunión termina.
Todos vuelven a sus puestos.
Nadie habla.

~ aumentar_inercia(1)

->->

// --- CITACIÓN A RRHH ---

=== laburo_citacion_rrhh ===

Un mail.
Asunto: "Reunión".
De: Personal.

"Mañana a las 11, en Personal. Por favor, confirmá asistencia."

Se te cae el estómago.

+ [...]
-

Te levantás.
Caminás al baño.
Las piernas te llevan solas porque la cabeza ya no está acá.

El pasillo es el mismo de siempre.
Pero hoy es más largo.
Cada paso suena más fuerte.

+ [...]
-

En el baño, te mojás la cara.
Las manos frías.
El agua fría.
Todo frío.

Te mirás en el espejo.
La cara de alguien que ya sabe.

Volvés al escritorio.
Abrís el mail otra vez.
"Reunión de rutina", dice abajo en chiquito.

Reunión de rutina.
Nadie se la cree.
Vos menos que nadie.

* [Responder preguntando para qué]
    Escribís: "Hola, ¿podrían indicarme el motivo de la reunión?"
    Responden en tres minutos.
    "Es una reunión de rutina."
    Rutina.
    Claro.
    -> laburo_citacion_vuelta
* [Confirmar asistencia]
    Escribís: "Confirmo. Gracias."
    No preguntás.
    A veces es mejor no saber.
    Aunque ya sabés.
    -> laburo_citacion_vuelta

=== laburo_citacion_vuelta ===

Cerrás el mail.

{vinculo == "juan": Juan te mira desde su escritorio. "¿Qué pasó?" No le contestás.}
{juan_relacion >= 2: Juan: "Eh, ¿estás bien?" Mentís: "Sí, todo bien."}

+ [...]
-

La tarde se hace eterna.

Cada mail nuevo te congela un segundo.
Cada vez que alguien camina cerca, apretás los dientes.

El reloj no avanza.
O avanza demasiado.
Las dos cosas a la vez.

+ [...]
-

-> laburo_citacion_fin

=== laburo_citacion_fin ===

~ aumentar_inercia(1)

A las cinco salís.
Mañana a las once.
Mañana se define todo.

O quizás ya está definido y mañana es solo el trámite.

->->

// --- EL DESPIDO ---

=== laburo_despido ===

# LA REUNIÓN

La oficina de Personal.
La luz fluorescente zumba. Un zumbido fino, constante, como un mosquito que no podés matar.

Dos personas que no conocés bien.
Una mujer de traje gris. Un tipo con carpeta.
Un vaso de agua que nadie te ofreció.
Un papel sobre la mesa. Ya está firmado. Del lado de ellos.

+ [...]
-

La mujer lee. No te mira. Lee de un papel.

"La empresa está atravesando un proceso de reestructuración y optimización de recursos."

Optimización de recursos. Vos sos el recurso.
Lo que significa: tu laburo generaba plata. Pero no la suficiente.
No para vos. Para ellos. Siempre para ellos.

+ [...]
-

"Tu puesto fue afectado por este proceso."

Así que era eso.
Lo sabías. Desde ayer. Desde el mail. Desde antes, quizás.
Pero saberlo no te prepara.

"Lamentamos informarte que dejamos de necesitar tus servicios. Agradecemos tu colaboración durante este período."

Escuchás las palabras pero no las sentís.
Como si le hablaran a otro.
Como si estuvieras mirando la escena desde arriba, flotando cerca del fluorescente que zumba.

{juan_relacion >= 2: Pensás en Juan. ¿Lo sabe? ¿A él también?}

* [Escuchar] # FALSA
    No hay liquidación. No hay indemnización.
    Sos unipersonal. Facturás. "Independiente."
    Así te contrataron hace tres años.
    Así te echan hoy.
    -> laburo_despido_firmar

* [Aceptar] -> laburo_despido_firmar
* [Preguntar por qué] # EFECTO:dignidad?
    -> laburo_despido_preguntar

=== laburo_despido_preguntar ===

"¿Por qué yo?"

Te sale la voz más chica de lo que querías.

Se miran entre ellos. La mujer busca algo en el papel. El tipo cierra la carpeta.

"No es personal. Es una decisión estratégica de reestructuración."

Estratégica.

// Confrontar sube dignidad (aunque no cambie el resultado)
~ subir_dignidad(1)

"Pero trabajo acá hace tres años."

+ [...]
-

Tres años.
Tres años facturando a esta empresa.
Tres navidades con el aguinaldo que nunca fue porque sos "independiente".
Tres años llegando temprano, quedándote tarde, comiendo del tupper en ese comedor de mierda.

La mujer te mira por primera vez.

"Trabajás con nosotros. Facturás. Es diferente."

+ [...]
-

Claro. Siempre fue diferente cuando les convenía.
Cuando había que quedarse hasta las diez, eras del equipo.
Cuando hay que pagar indemnización, sos externo.

Querés gritar.
Pero no gritás.
Porque sos profesional.
Porque te enseñaron a ser profesional mientras te robaban.

Nunca es personal.
Es el capitalismo funcionando como fue diseñado.
Tu laburo vale más de lo que te pagan. Siempre valió más.
La diferencia se la quedó la empresa. Tres años de diferencia.
Y ahora te dan una caja de cartón.

* [Irte] -> laburo_despido_firmar

=== laburo_despido_firmar ===

No hay nada que firmar.
Sos unipersonal. Simplemente dejás de facturar.

"Podés retirar tus pertenencias personales."

Te dan una caja. Cartón marrón. Genérica.
La misma caja que le habrán dado a Gómez. Y al que vino antes.

+ [...]
-

Vas al escritorio.
El escritorio que fue tuyo mil mañanas.

Abrís el cajón.
Una taza. La que dice "Mejor Empleado" que te regalaron en una fiesta de fin de año.
Una foto de... ya ni importa.
Un cable USB que no es tuyo. Lo dejás.
Un paquete de galletitas abierto. Lo dejás también.

+ [...]
-

La caja pesa nada.
Tres años caben en una caja que pesa nada.

{juan_relacion >= 1: Juan está en su escritorio. Levanta la vista. Ve la caja. No dice nada. Los ojos dicen todo.}
{vinculo == "juan": Juan se para. "Esperá." No sabés qué más dice porque ya estás caminando al ascensor.}

+ [...]
-

El ascensor baja.
No mirás para atrás.

Las puertas se abren. La planta baja. La recepción.
La recepcionista te mira. Ya sabe. Todos saben.

"Chau."
"Chau."

La puerta.
La calle.

El sol.
Hace buen día.
No debería hacer buen día.
No tiene derecho a hacer buen día.

~ fui_despedido = true
~ tiene_laburo = false
~ aumentar_inercia(1)

->->

// --- SALIDA DEL LABURO ---

=== laburo_salida ===

# LOC:calle
# LA SALIDA

5 de la tarde.
El laburo terminó.
Por hoy.

Caminás a la parada.
El cuerpo cansado.
La cabeza {d6() >= 4: cansada también|peor}.

->->

=== laburo_salida_despedido ===

# LOC:calle
# LA CALLE

Salís con tu caja.

La calle está igual que siempre.
El sol es el mismo sol.
La gente camina como si nada.

* [Seguir caminando] # FALSA
    Pero vos estás parado acá con una caja.
    A las 11:30 de la mañana de un miércoles.
    Sin laburo.

+ [...]
-

Tenés tres meses de colchón.
No te estás muriendo.
Pero algo murió.

¿Quién sos ahora que no tenés laburo?

+ [...]
-

~ idea_quien_soy = true

# IDEA: "¿QUIÉN SOY SIN LABURO?"

No la elegiste. Llegó sola.
Como un zumbido en la cabeza que no para.

->->

// --- INTERACCIÓN CON EL JEFE ---

=== laburo_hablar_con_jefe ===

~ energia -= 1

Te levantás.
Vas a la oficina del jefe.

"¿Puedo?"

"Sí, pasá. ¿Qué necesitás?"

"Nada, quería saber si... si estaba todo bien con mi trabajo."

Te mira.

~ ultima_tirada = d6()

{ultima_tirada >= 4:
    "Sí, todo bien. ¿Por?"

    "No, por nada. Rumores nomás."

    "No hagas caso a los rumores. Concentrate en tu trabajo."

    Salís.
    No fue tan malo.
    Pero tampoco te dijo nada.
    ->->
- else:
    "Mirá, ahora no es el momento para hablar de eso. Después vemos."

    ¿Después vemos qué?

    "Bueno. Gracias."

    Salís.
    Peor que antes.
    ~ aumentar_inercia(1)
    ->->
}

// ============================================
// POST-DESPIDO: FANTASMAS DEL LABURO
// Escenas después del miércoles
// ============================================

// --- PASAR POR EL EDIFICIO ---

=== laburo_fantasma_edificio ===
// Trigger: viernes, caminando por el centro
// Requiere: fui_despedido == true

# EL EDIFICIO

Caminás por el centro.
Sin querer, tus pies te llevan por la misma cuadra de siempre.

+ [...]
-

Ahí está.

El edificio.
La puerta de siempre.
El cartel de la empresa.

Pero ya no es tuyo.

* [Seguir caminando]
    -> laburo_fantasma_pasar_largo
* [Pararte un momento]
    -> laburo_fantasma_pararte
* [Cruzar de vereda]
    -> laburo_fantasma_evitar

=== laburo_fantasma_pasar_largo ===

Seguís caminando.
Como si nada.

Pero el corazón se acelera igual.

+ [...]
-

Por el rabillo del ojo ves gente entrando.
La misma puerta.
El mismo ascensor.

Solo que vos ya no.

->->

=== laburo_fantasma_pararte ===

Te parás.

Mirás el edificio desde afuera.
Nunca lo habías visto así.

+ [...]
-

¿Cuántas veces entraste por esa puerta?
¿Mil? ¿Más?

Ahora es solo un edificio.
Una puerta que ya no se abre para vos.

+ [...]
-

{d6() >= 4:
    Sale alguien conocido. Martínez, de sistemas.
    Te ve.
    -> laburo_fantasma_martinez_ve
- else:
    No sale nadie que conozcas.
    Mejor así.
    ->->
}

=== laburo_fantasma_martinez_ve ===

Martínez te ve.

Por un segundo, los dos se quedan.

* [Saludar]
    Levantás la mano.
    "Hola."
    "Hola, bo." 
    Él sigue caminando. Rápido.
    Como si el despido fuera contagioso.
    ~ aumentar_inercia(1)
    ->->
* [Hacerte el boludo]
    Mirás para otro lado.
    Él hace lo mismo.
    Silencio de ex-compañeros.
    ->->

=== laburo_fantasma_evitar ===

Cruzás de vereda.

No querés ver.
No querés que te vean.

+ [...]
-

No está mal.
A veces evitar es cuidarse.

Seguís caminando por la otra vereda.
El edificio queda atrás.

->->

// --- CRUCE CON EX-COMPAÑERO ---

=== laburo_fantasma_cruce ===
// Trigger: jueves, en el barrio o en el bondi
// Requiere: fui_despedido == true

# EL CRUCE

{d6() >= 4:
    En la parada del bondi.
- else:
    Caminando por el barrio.
}

Una cara conocida.

+ [...]
-

Es Fernández. Del área de ventas.
Se sienta cerca tuyo en las reuniones.
Se sentaba.

* [Saludar]
    -> laburo_fantasma_saludar
* [Hacerte el distraído]
    -> laburo_fantasma_distraido

=== laburo_fantasma_saludar ===

"Fernández."

Te mira. Tarda un segundo en reconocerte.

    "Ah, hola. ¿Cómo... cómo estás, bo?"
La pregunta incómoda.
Ambos saben la respuesta.

* ["Bien."]
    -> laburo_fantasma_charla_bien
* ["Acá andamos."]
    -> laburo_fantasma_charla_real
* ["Como el orto."]
    -> laburo_fantasma_charla_honesta

=== laburo_fantasma_charla_bien ===

"Bien."

Mentira.

"Qué bueno."

Mentira también.

+ [...]
-

Silencio incómodo.

"Bueno, me tengo que ir..."

"Sí, yo también."

Se van por lados opuestos.

->->

=== laburo_fantasma_charla_real ===

"Acá andamos."

Fernández asiente.

"Me enteré. Lo siento, bo."

+ [...]
-

"Gracias."

Silencio.

"En la empresa... están todos nerviosos. Dicen que van a seguir recortando."

* ["¿En serio?"]
    -> laburo_fantasma_info_empresa
* ["No me importa ya."]
    "Sí, bueno. Ya fue."
    Fernández asiente.
    "Cuidate."
    "Vos también."
    ->->

=== laburo_fantasma_charla_honesta ===

"Como el orto."

Fernández no sabe qué decir.

"Eh... lo lamento, che."

+ [...]
-

"No es tu culpa."

"No, pero igual."

+ [...]
-

Se queda callado un momento.

"Mirá... no le cuentes a nadie que te dije esto, pero..."

-> laburo_fantasma_info_empresa

=== laburo_fantasma_info_empresa ===

Fernández mira para los lados.

"Van a seguir despidiendo. Escuché que el mes que viene caen más."

+ [...]
-

"Gómez ya cayó. Martínez dicen que está en la lista."

No sabés cómo sentirte.
¿Alivio de no ser el único?
¿Tristeza por los que vienen?

* ["Qué cagada."]
    "Sí. Una cagada total."
    -> laburo_fantasma_despedida_info
* ["Era de esperarse."]
    "Sí, pero igual duele."
    -> laburo_fantasma_despedida_info

=== laburo_fantasma_despedida_info ===

"Bueno, me tengo que ir."

"Dale. Cuidate."

+ [...]
-

Se va.

Te quedás pensando.
No sos el único.
Nunca lo fuiste.

~ aumentar_inercia(1)

->->

=== laburo_fantasma_distraido ===

Mirás el celular.
Te hacés el que no lo viste.

+ [...]
-

Él también mira para otro lado.

Silencio de ex-compañeros.
Más cómodo que la conversación.

->->

// --- GONZÁLEZ EN LA OLLA (EXPANDIDO) ---

=== laburo_fantasma_gonzalez_olla ===
// Trigger: sábado en la olla, servicio expandido
// Requiere: fui_despedido == true && vio_a_gonzalez == false

~ vio_a_gonzalez = true

# LA COLA

Estás sirviendo.
Cucharón, plato, cucharón, plato.

+ [...]
-

Y entonces lo ves.

González.
De contabilidad.
En la cola.

+ [...]
-

Te ve.
Los dos se quedan.

Un segundo que dura una hora.

* [Servirle normalmente]
    -> gonzalez_servir_normal
* [Darle un poco más]
    -> gonzalez_servir_mas

=== gonzalez_servir_normal ===

Le servís.
Lo justo.
Como a todos.

"Gracias."

Apenas un murmullo.
No te mira.

+ [...]
-

Se va a sentar.
Solo.
En un rincón.

->->

=== gonzalez_servir_mas ===

Le servís un poco más.
Un pedazo extra de carne.
Quizás un poco de papa de más.

+ [...]
-

González mira el plato.
Después te mira.

"Gracias."

Sabe que sabés.
Sabés que sabe.

* [Asentir]
    Asentís.
    Sigue la fila.
    -> gonzalez_despues
* ["¿Cómo andás?"]
    -> gonzalez_charla

=== gonzalez_charla ===

"¿Cómo andás?"

González se ríe. Sin gracia.

"Acá. Como vos."

+ [...]
-

"¿Cuándo te...?"

"Hace dos semanas. Antes que vos."

+ [...]
-

"No lo había contado. Por la vergüenza."

Mirás alrededor. La cola sigue.

"Después hablamos."

"Dale."

-> gonzalez_despues

=== gonzalez_despues ===
// Después del servicio

Terminás de servir.
González sigue ahí.
Sentado solo.

* [Acercarte]
    -> gonzalez_charla_larga
* [Dejarlo]
    Lo dejás.
    A veces la gente necesita estar sola.
    ->->

=== gonzalez_charla_larga ===

Te sentás enfrente.

"¿Hace mucho que venís acá?"

"Primera vez."

+ [...]
-

González mira el plato vacío.

"Nunca pensé que iba a terminar acá."

* ["Yo tampoco."]
    "Yo tampoco."
    Silencio.
    "Pero acá estamos."
    -> gonzalez_cierre
* ["No está tan mal."]
    "No está tan mal. La comida es buena. La gente también."
    González asiente, no muy convencido.
    -> gonzalez_cierre

=== gonzalez_cierre ===

"Tengo tres pibes", dice González.
"No les conté que me echaron. Les digo que estoy de licencia."

+ [...]
-

"Todos los días salgo de casa a las ocho. Camino. Voy a la plaza. Vuelvo a las seis."

"Para que no sospechen."

"Para que no sospechen."

+ [...]
-

No sabés qué decir.

González se levanta.

"Gracias por el plato. Y por... por no decir nada."

"¿Qué voy a decir?"

+ [...]
-

Se va.

Otro fantasma del laburo.
Otro que camina por ahí sin que nadie sepa.

~ subir_conexion(1)

->->

// --- MENSAJE DEL GRUPO DE TRABAJO ---

=== laburo_fantasma_grupo_whatsapp ===
// Trigger: sábado, momento de relax en casa
// Requiere: fui_despedido == true

# EL CELULAR

Estás en tu pieza.
El celular vibra.

Es el grupo del laburo.
"Equipo de Gestión".
Todavía estás ahí.

* [Mirar]
    -> laburo_grupo_mirar
* [Ignorar]
    -> laburo_grupo_ignorar

=== laburo_grupo_mirar ===

Abrís el chat.

{d6() >= 4:
    Martínez: "Alguien sabe dónde quedó el archivo del proyecto Alfa?"
    López: "En la carpeta compartida"
    Martínez: "No lo encuentro"
    López: "Pedile a sistemas"
- else:
    Fernández: "Feliz cumpleaños Rosita!!"
    Varios: "🎂🎂🎂"
    Rosa: "Gracias a todos!!"
}

+ [...]
-

La vida sigue.
Sin vos.

El grupo charla como si nada.
Como si nunca hubieras estado.

* [Seguir leyendo]
    -> laburo_grupo_leer_mas
* [Cerrar]
    -> laburo_grupo_cerrar

=== laburo_grupo_leer_mas ===

Scrolleás para arriba.
Mensajes de los últimos días.

"Reunión a las 3"
"Confirmado"
"Voy llegando"

+ [...]
-

Tu último mensaje fue hace una semana.
Un emoji de pulgar arriba.
Nadie contestó.

* [Salir del grupo]
    -> laburo_grupo_salir
* [Quedarte mirando]
    -> laburo_grupo_quedarse
* [Cerrar]
    -> laburo_grupo_cerrar

=== laburo_grupo_salir ===

¿Salir del grupo?

* [Sí]
    -> laburo_grupo_confirmar_salida
* [No, mejor no]
    -> laburo_grupo_quedarse

=== laburo_grupo_confirmar_salida ===

Tocás "Salir del grupo".

"¿Estás seguro?"

* [Sí]
    Saliste.
    
    Nadie va a notar.
    O quizás sí.
    Da igual.
    
    ~ subir_dignidad(1)
    ->->
* [No]
    -> laburo_grupo_quedarse

=== laburo_grupo_quedarse ===

Te quedás.
Mirando.
Sin escribir.

+ [...]
-

Un fantasma en el grupo.
Leyendo conversaciones que ya no te incluyen.
Reuniones a las que no vas.
Cumpleaños que ya no festejás.

* [Cerrar] -> laburo_grupo_cerrar

=== laburo_grupo_cerrar ===

Cerrás el chat.

+ [...]
-

El grupo sigue ahí.
La notificación en silencio.
Un recordatorio de lo que ya no sos.

~ aumentar_inercia(1)

->->

=== laburo_grupo_ignorar ===

No abrís.

+ [...]
-

Dejás que la notificación se acumule.
Otro mensaje que no leés.
Otra vida que sigue sin vos.

A veces ignorar es protegerse.

->->
