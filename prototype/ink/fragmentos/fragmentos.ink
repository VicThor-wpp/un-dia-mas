// ============================================
// FRAGMENTOS - Sistema de perspectivas alternas
// ============================================

// Los fragmentos son ventanas a la vida de otros personajes.
// Ocurren durante la noche, cuando el protagonista duerme.
// El jugador no controla estas escenas, solo las observa.

// MEJORA v2: Sistema dinámico con variedad por personaje,
// sensible a decisiones del jugador y día de la semana.

// ============================================
// VARIABLES DE ESTADO (importadas de main)
// ============================================

// Asumimos que estas variables existen en el archivo principal:
// VAR vinculo = ""
// VAR dia_actual = 1  // 1=lunes, 2=martes... 7=domingo
// VAR ayude_en_olla = false
// VAR participe_asamblea = false
// VAR bruno_presiono_tiago = false
// VAR juan_sabe_despido = false
// VAR marcos_abrio_corazon = false
// VAR sofia_confio = false
// VAR elena_hablo_pasado = false

// ============================================
// SISTEMA PRINCIPAL DE SELECCIÓN
// ============================================

=== fragmento_nocturno ===
// Punto de entrada principal para fragmentos nocturnos
// Llama según el vínculo principal del jugador

{vinculo == "sofia": -> fragmento_sofia}
{vinculo == "elena": -> fragmento_elena}
{vinculo == "diego": -> fragmento_diego}
{vinculo == "marcos": -> fragmento_marcos}
{vinculo == "juan": -> fragmento_juan}
{vinculo == "ixchel": -> fragmento_ixchel}

// Sin vínculo definido: fragmento de la ciudad
-> fragmento_ciudad ->
->->

// ============================================
// FRAGMENTOS DE SOFÍA
// ============================================

=== fragmento_sofia ===
{dia_actual:
- 1: -> sofia_lunes
- 2: -> sofia_martes
- 3: -> sofia_miercoles
- 4: -> sofia_jueves
- 5: -> sofia_viernes
- 6: -> sofia_sabado
- 7: -> sofia_domingo
}
-> sofia_generico ->
->->

=== sofia_lunes ===
// Sofía después del primer día - incertidumbre

Sofía revisa los mensajes del grupo de WhatsApp.
Treinta y cuatro nuevos.

"¿Alguien sabe cómo está el nuevo?"
"Parece que le pegó fuerte."
"Hay que darle espacio, ya va a conectar."

Sofía apaga el teléfono.
Mira por la ventana del monoambiente que comparte con su prima.

Ella también fue nueva alguna vez.
Recuerda el miedo.
La vergüenza de necesitar ayuda.

Suspira.

Mañana le va a hablar.
Sin presionar.
Solo... estar.

->->

=== sofia_martes ===
// Sofía pensando en la olla

Sofía cuenta las papas.
Treinta y siete.
No alcanzan.

"Mañana van a venir más", dice en voz baja.

El rumor de los despidos en la fábrica ya corrió.
Cinco familias nuevas.
Tres pibes más.

Sofia anota en un cuaderno gastado:
"Conseguir más verdura. Hablar con la feria."

Su estómago gruñe.
Ella comió poco hoy.
Siempre come poco.

Los pibes comen primero.
Siempre.

->->

=== sofia_miercoles ===
// Sofía y los pibes

Los pibes ya duermen en el fondo del local.
Sofía les acomoda las frazadas.

Kevin, el más chico, tiene fiebre.
Le pone la mano en la frente.
Caliente.

"Mañana lo llevo al policlínico", susurra.

Faltan remedios.
Faltan frazadas.
Falta de todo.

Pero sobra algo:
gente que aparece cuando hace falta.

Sofía sonríe apenas.
Todavía cree en eso.

->->

=== sofia_jueves ===
// Sofía después de hablar (o no) con el protagonista
{sofia_confio:
    Sofía piensa en lo que le contó hoy.
    Hacía tiempo que no hablaba de eso.
    Del barrio. De la madre. De las noches sin comer.
    
    Algo se abrió.
    No sabe si es bueno o malo.
    
    Pero sintió que la escucharon.
    Sin lástima.
    Solo... escucha.
    
    "Quizás se puede confiar", piensa.
    Quizás.
- else:
    Sofía mira el teléfono.
    Quería hablar hoy.
    No pudo.
    
    Hay cosas que pesan demasiado.
    Cosas que no se cuentan a cualquiera.
    
    "Otro día será", se dice.
    Siempre otro día.
}
->->

=== sofia_viernes ===
// Sofía preparando la olla del fin de semana
{ayude_en_olla:
    Sofía lava las ollas.
    Hoy vino ayuda.
    
    No es solo los brazos.
    Es saber que alguien entiende.
    Que no estás sola.
    
    "Quizás esto funciona", piensa.
    "Quizás esto tiene sentido."
- else:
    Sofía lava las ollas sola.
    La espalda le duele.
    Las manos le arden.
    
    Nadie vino hoy.
    Bueno, casi nadie viene nunca.
    
    Pero mañana hay que cocinar igual.
    Los pibes no entienden de cansancio.
    Solo entienden de hambre.
}
->->

=== sofia_sabado ===
// Sofía en la asamblea (o no)
{participe_asamblea:
    Sofía sale de la asamblea con energía.
    Hubo debate. Hubo desacuerdos.
    Pero también hubo decisiones.
    
    Esto es lo que la sostiene.
    No la esperanza individual.
    La certeza colectiva.
    
    "Entre todos, podemos."
    Lo cree. Todavía lo cree.
- else:
    Sofía vuelve de la asamblea cansada.
    Poca gente. Mucho silencio.
    
    A veces se pregunta si tiene sentido.
    Si alguien realmente escucha.
    Si algo cambia.
    
    Pero mañana hay que seguir.
    Porque los pibes siguen.
    Y ella no los va a soltar.
}
->->

=== sofia_domingo ===
// Sofía domingo - reflexión de fin de semana

Es domingo.
Sofía se permite un mate sin apuro.

Piensa en la semana.
En las caras nuevas.
En las que ya no están.

Algunos volvieron al interior.
Otros cruzaron a Argentina.
Uno... prefiere no pensar en ese.

Pero hay pibes que ahora sonríen.
Hay familias que encontraron techo.
Hay gente que sabe que no está sola.

Eso tiene que alcanzar.
Por ahora, tiene que alcanzar.

->->

=== sofia_generico ===
// Fallback para Sofía

Sofía revisa la lista de la semana.
Siempre hay algo que falta.
Siempre hay alguien que necesita.

Pero también siempre hay alguien que da.
Eso la sostiene.

->->

// ============================================
// FRAGMENTOS DE ELENA
// ============================================

=== fragmento_elena ===
{dia_actual:
- 1: -> elena_lunes
- 2: -> elena_martes
- 3: -> elena_miercoles
- 4: -> elena_jueves
- 5: -> elena_viernes
- 6: -> elena_sabado
- 7: -> elena_domingo
}
-> elena_generico ->
->->

=== elena_lunes ===
// Elena primer día - observando desde lejos

Elena barre el patio del conventillo.
Los vecinos ya duermen.

Escuchó que llegó alguien nuevo.
Despedido, dicen.
Como tantos.

Ella vio a muchos así.
La mayoría no aguanta.
Se van. Se rompen. Se pierden.

Algunos pocos encuentran algo.
Una red. Una razón. Un lugar.

Veremos cuál es este.
Elena sabe esperar.
Aprendió hace tiempo.

->->

=== elena_martes ===
// Elena y sus recuerdos

Elena mira la foto vieja.
Su marido. Sus hijos. Otro país.

Hace veinte años que está acá.
Hace quince que no los ve.

No por falta de ganas.
Por falta de papeles.
Por falta de plata.
Por falta de todo lo que falta.

Guarda la foto.
Mañana hay que seguir.

->->

=== elena_miercoles ===
// Elena cocinando

Elena cocina para mañana.
Arroz con cosas.
"Cosas" es lo que haya.

Hoy hay zanahoria y un poco de carne.
Mañana capaz que no hay nada.

Cocina de más.
Siempre cocina de más.
Por si alguien necesita.

Es lo que hacía su mamá.
Lo que hacía su abuela.
Mujeres que siempre cocinaban de más.

->->

=== elena_jueves ===
// Elena hablando del pasado (o no)
{elena_hablo_pasado:
    Elena se acuesta pensando en lo que contó.
    El viaje en barco. El miedo. La llegada.
    
    Hace años que no hablaba de eso.
    Duele menos de lo que pensaba.
    O duele igual, pero compartido.
    
    "Hay que soltar algunas cosas", piensa.
    "Para poder cargar otras."
- else:
    Elena se acuesta en silencio.
    Hay cosas que no se cuentan.
    Cosas que pesan pero sostienen.
    
    Su historia es suya.
    No tiene que darla a nadie.
    
    Pero a veces...
    A veces le gustaría que alguien preguntara.
}
->->

=== elena_viernes ===
// Elena viernes - visita al cementerio (mental)

Elena prende una vela.
Por los que ya no están.
Por los que están lejos.
Por los que nunca llegaron.

No es religiosa.
Pero las velas ayudan.
Son pequeñas luces en la oscuridad.

"Mientras haya luz, hay esperanza."
Eso decía su mamá.
Elena todavía quiere creerlo.

->->

=== elena_sabado ===
// Elena sábado - tejiendo comunidad

Elena lleva comida a la vecina del 4.
La que tiene al marido enfermo.
La que no puede salir.

No le pide nada a cambio.
No espera agradecimiento.

Es lo que se hace.
Lo que siempre se hizo.
Cuidar al de al lado.

Porque mañana podés ser vos.
Y vas a necesitar que alguien te cuide.

->->

=== elena_domingo ===
// Elena domingo - el banco

Elena se sienta en el banco de la plaza.
Su banco. El de siempre.

Mira pasar a la gente.
Familias. Parejas. Pibes jugando.

Ella también tuvo eso.
En otro tiempo. En otro lugar.

No tiene nostalgia.
Tiene memoria.
Es diferente.

La memoria no paraliza.
La memoria enseña.

->->

=== elena_generico ===
// Fallback para Elena

Elena escucha la radio.
Las mismas noticias de siempre.
Crisis. Despidos. Ajuste.

Apaga la radio.
Las noticias no cambian nada.
Las manos sí.

->->

// ============================================
// FRAGMENTOS DE DIEGO
// ============================================

=== fragmento_diego ===
{dia_actual:
- 1: -> diego_lunes
- 2: -> diego_martes
- 3: -> diego_miercoles
- 4: -> diego_jueves
- 5: -> diego_viernes
- 6: -> diego_sabado
- 7: -> diego_domingo
}
-> diego_generico ->
->->

=== diego_lunes ===
// Diego primer día - llegando tarde

Diego entra al rancho tratando de no hacer ruido.
Son las tres de la mañana.
La vieja duerme.

O finge dormir.

"¿Comiste?", dice ella sin abrir los ojos.
"Sí, ma."
Mentira. Pero no hay para dos.

Se acuesta vestido.
Mañana hay que buscar changa.
Mañana hay que seguir.

->->

=== diego_martes ===
// Diego en la esquina

Diego y los pibes en la esquina.
No hay laburo. No hay plata. No hay nada que hacer.

Pasa un patrullero.
Los mira. 
Ellos miran al piso.

"Estos nos tienen marcados", dice el Tato.
"Siempre nos van a tener marcados", dice Diego.

No es queja.
Es realidad.
La conocen desde que nacieron.

->->

=== diego_miercoles ===
// Diego pensando en el futuro

Diego mira videos en el celular.
Un rapero famoso contando su historia.
Salió del barrio. La hizo.

"Podría ser yo", piensa Diego.
Pero no lo piensa en serio.

Sabe que las chances son mínimas.
Sabe que el sistema no perdona.
Sabe que estar en el lugar equivocado...

Apaga el celular.
Mejor no pensar tanto.

->->

=== diego_jueves ===
// Diego y la música

Diego escribe letras en un cuaderno.
Rap. Lo suyo.

"Nací en el barro pero no me hundo
voy caminando por este mundo
que me mira de costado
pero yo sigo parado..."

No es bueno todavía.
Pero es suyo.
Es lo único que es suyo.

->->

=== diego_viernes ===
// Diego - la llamada

Diego recibe una llamada.
Es su hermano. Desde el penal.

"¿Cómo estás, gurí?"
"Bien. ¿Y vos?"
"Acá. Ya sabés."

Hablan cinco minutos.
De nada. De todo.
Del barrio. De la vieja. Del tiempo.

Cuando corta, Diego se queda mirando la pared.
Su hermano tomó un camino.
Él tiene que encontrar otro.

Tiene que.

->->

=== diego_sabado ===
// Diego en el baile

Diego en el baile del barrio.
Cumbia. Amigos. Por un rato se olvida.

Pero ve a la policía en la entrada.
Controlando. Marcando.

El baile no es igual cuando te miran así.
Cuando cualquier movimiento es sospechoso.
Cuando tu alegría es un problema.

Igual baila.
La alegría es resistencia.

->->

=== diego_domingo ===
// Diego domingo - mate con la vieja

Diego toma mate con la vieja.
Domingo a la tarde.
Lo único sagrado.

"¿Encontraste algo?", pregunta ella.
"Hay una changuita el martes."
"Algo es algo."

Ella lo mira.
Él sabe lo que piensa.
Que no termine como el hermano.

"Voy a estar bien, ma."
No sabe si es verdad.
Pero lo dice igual.

->->

=== diego_generico ===
// Fallback para Diego

Diego camina por el barrio.
Su barrio. El único que conoce.
El que lo hizo y lo puede destruir.

->->

// ============================================
// FRAGMENTOS DE MARCOS
// ============================================

=== fragmento_marcos ===
{dia_actual:
- 1: -> marcos_lunes
- 2: -> marcos_martes
- 3: -> marcos_miercoles
- 4: -> marcos_jueves
- 5: -> marcos_viernes
- 6: -> marcos_sabado
- 7: -> marcos_domingo
}
-> marcos_generico ->
->->

=== marcos_lunes ===
// Marcos primer día - el arquitecto caído

Marcos mira los planos viejos.
Proyectos que nunca se construyeron.
Sueños que se quedaron en papel.

Antes diseñaba edificios.
Ahora diseña maneras de llegar a fin de mes.

El título está en un cajón.
Junto con las fotos del estudio.
Junto con la vida de antes.

Toma un trago.
Solo uno.
Bueno, dos.

->->

=== marcos_martes ===
// Marcos y el insomnio

Son las cuatro de la mañana.
Marcos no puede dormir.

Piensa en las deudas.
En el divorcio.
En los hijos que no ve.
En todo lo que se rompió.

Se levanta.
Pone música bajito.
Jazz. Lo único que lo calma.

Afuera está oscuro.
Adentro también.

->->

=== marcos_miercoles ===
// Marcos ayudando en la comunidad

Marcos arregló la canilla del conventillo.
No cobró nada.
Es lo que sabe hacer.

"Gracias, Marcos", dijo Elena.
"De nada. Para eso estamos."

Por un momento se sintió útil.
Por un momento recordó quién era.
Alguien que construye.
No alguien que se derrumba.

->->

=== marcos_jueves ===
// Marcos y la vulnerabilidad
{marcos_abrio_corazon:
    Marcos piensa en lo que contó hoy.
    El estudio. La quiebra. El alcohol.
    
    Hacía años que no hablaba de eso.
    Se siente expuesto.
    Pero también... liviano.
    
    "Quizás no tengo que cargar todo solo."
    Pensamiento nuevo.
    Incómodo.
    Pero nuevo.
- else:
    Marcos toma otro whisky.
    Solo. Como siempre.
    
    Hay cosas que no se cuentan.
    Vergüenzas que pesan.
    Fracasos que definen.
    
    Es más fácil así.
    Solo.
    O eso se dice.
}
->->

=== marcos_viernes ===
// Marcos viernes - el balcón

Marcos en el balcón.
Fuma mirando la ciudad.

Desde acá se ven las luces de Pocitos.
Los edificios que otros diseñaron.
La vida que él no tiene.

Pero también se ve el barrio.
La gente que resiste.
Los que no se rinden.

"Todavía puedo ser útil", piensa.
"Todavía puedo construir algo."

Aunque sea distinto.
Aunque sea más chico.
Aunque sea solo esto.

->->

=== marcos_sabado ===
// Marcos sábado - llamada de los hijos

Suena el teléfono.
Es la hija.

"Hola pa. ¿Cómo estás?"
"Bien, m'hija. ¿Ustedes?"
"Bien. Mamá dice que..."

Escucha.
No discute.
Ya no tiene fuerzas para discutir.

Cuando corta, mira la foto de ellos.
Chiquitos. Sonriendo.
Antes de todo.

"Por ustedes", susurra.
"Tengo que salir de esta por ustedes."

->->

=== marcos_domingo ===
// Marcos domingo - la música

Marcos pone vinilos.
Zitarrosa. El Sabalero. Mateo.

La música de antes.
Cuando todo era posible.
Cuando el país era otro.
Cuando él era otro.

Canta bajito.
Nadie lo escucha.
Pero él se escucha.

Y por un rato, no está solo.

->->

=== marcos_generico ===
// Fallback para Marcos

Marcos dibuja en una servilleta.
Un edificio imposible.
Un sueño arquitectónico.

Capaz que algún día.
Capaz.

->->

// ============================================
// FRAGMENTOS DE JUAN
// ============================================

=== fragmento_juan ===
{dia_actual:
- 1: -> juan_lunes
- 2: -> juan_martes
- 3: -> juan_miercoles
- 4: -> juan_jueves
- 5: -> juan_viernes
- 6: -> juan_sabado
- 7: -> juan_domingo
}
-> juan_generico ->
->->

=== juan_lunes ===
// Juan lunes - después de tu despido

Juan vuelve del laburo.
El escritorio de al lado estaba vacío.

Nadie dijo nada.
Como si no hubiera pasado.
Como si desaparecer fuera normal.

Juan pensó en llamar.
No lo hizo.
¿Qué iba a decir?

"Lo lamento" suena a poco.
"Yo sigo" suena a traición.

Pone la tele.
Cualquier cosa para no pensar.

->->

=== juan_martes ===
// Juan martes - miedo al despido

Juan revisa los números.
Productividad. Ventas. Métricas.

Si rajaron al otro... él puede ser el próximo.
La lista siempre tiene un próximo.

Trabaja hasta tarde.
No porque le paguen más.
Porque tiene miedo.

El miedo es gratis.
Y funciona mejor que el salario.

->->

=== juan_miercoles ===
// Juan miércoles - la cena familiar

Juan cena con la familia.
La madre pregunta por el laburo.
El padre cuenta del suyo (que ya no existe).
El hermano mira el celular.

Nadie habla de lo importante.
De los despidos. De la crisis. Del miedo.

Hablan del clima.
Del fútbol.
De cualquier cosa.

Es más fácil así.
Hasta que no lo es.

->->

=== juan_jueves ===
// Juan jueves - sabiendo (o no) la verdad
{juan_sabe_despido:
    Juan sabe la verdad ahora.
    No fue performance.
    Fue política.
    Fue ajuste.
    Fue número.
    
    Se siente culpable por seguir.
    Por no decir nada.
    Por ser cómplice del silencio.
    
    Pero ¿qué puede hacer?
    ¿Renunciar? ¿Protestar?
    
    Tiene cuentas que pagar.
    Como todos.
- else:
    Juan no sabe por qué lo rajaron.
    Quizás fue performance.
    Quizás fue recorte.
    Quizás fue nada.
    
    Prefiere no preguntar.
    Las respuestas pueden doler.
    
    Sigue laburando.
    Cabeza baja.
    Como siempre.
}
->->

=== juan_viernes ===
// Juan viernes - planes de escape

Juan googlea "trabajar en el exterior".
España. Portugal. Alemania.

La mitad de sus compañeros de facultad se fueron.
Los que se quedaron no pueden irse.
O no quieren.
O tienen miedo.

Él tiene un poco de todo.

Cierra la computadora.
Mañana sigue igual.
Por ahora.

->->

=== juan_sabado ===
// Juan sábado - reencuentro con amigos

Juan con los amigos de siempre.
Cerveza. Picada. Fútbol en la tele.

Todos hablan del laburo.
De lo mal que está todo.
De irse o quedarse.

"Yo me estoy por ir", dice el Gordo.
"Yo tengo una oferta en Chile", dice Martín.
"Yo no me puedo ir", dice Juan.

No explica por qué.
No quiere hablar de la vieja.
De las deudas. De las razones.

->->

=== juan_domingo ===
// Juan domingo - la decisión

Juan almuerza con los viejos.
El padre está peor.
La madre disimula.

Él es el único que labura.
El único sostén.

A veces piensa en irse.
A veces piensa en gritar.
A veces piensa en rendirse.

Pero no puede.
No ahora.
No todavía.

"¿Más ensalada, m'hijo?"
"Dale, ma."

Sigue.
Es lo que hace.

->->

=== juan_generico ===
// Fallback para Juan

Juan mira el celular.
Notificaciones del laburo.
Un domingo.

Suspira.
Contesta.
Es lo que hay.

->->

// ============================================
// FRAGMENTOS DE IXCHEL
// ============================================

=== fragmento_ixchel ===
{dia_actual:
- 1: -> ixchel_lunes
- 2: -> ixchel_martes
- 3: -> ixchel_miercoles
- 4: -> ixchel_jueves
- 5: -> ixchel_viernes
- 6: -> ixchel_sabado
- 7: -> ixchel_domingo
}
-> ixchel_generico ->
->->

=== ixchel_lunes ===
// Ixchel lunes - el trabajo

Ixchel termina de limpiar la cocina del restaurante.
Sus manos están rojas por el agua caliente y el detergente.

"Dale, bolita, apurate que cerramos", grita el encargado.

No es boliviana. Es guatemalteca. Maya-K'iche'.
Se lo dijo tres veces. Él sigue diciendo "bolita".
Para él, todos los indígenas son lo mismo.

Ixchel no contesta.
Su dignidad es un silencio antiguo.

->->

=== ixchel_martes ===
// Ixchel martes - la llamada

Ixchel llama a Guatemala.
La abuela contesta.
La voz viene de lejos, con ruido.

"¿Estás comiendo bien?"
"Sí, abuelita."
"¿Te tratan bien?"
"... Sí."

La pausa dice todo.
Pero la abuela no pregunta más.
Sabe que algunas verdades no cruzan fronteras.

"Ri Dios kataq'anej."
Que Dios te acompañe.

Ixchel corta.
Se permite llorar un minuto.
Solo uno.

->->

=== ixchel_miercoles ===
// Ixchel miércoles - el tejido

En un cuarto pequeño, Ixchel teje.

Los colores son de allá. Los movimientos son de acá.
Un puente entre mundos que nadie ve.

Cada punto es memoria.
La abuela enseñando.
Las montañas de Quetzaltenango.
El olor a tortilla.
El sonido del quetzal.

"Ri qa tzij, ri qa k'aslemal."
Nuestras palabras, nuestra vida.

Mientras teja, existe.
Mientras exista, resiste.

->->

=== ixchel_jueves ===
// Ixchel jueves - encontrando comunidad

Ixchel descubre la olla popular.
La invitaron. No sabía si ir.

Fue.

Hay otros como ella.
Otros que llegaron de lejos.
Otros que buscan un lugar.

Sofía le ofrece un plato.
"¿De dónde sos?"
"Guatemala. De Quetzaltenango."
"Bienvenida."

Así de simple.
Sin preguntas de papeles.
Sin miradas de sospecha.

Bienvenida.
Hacía tiempo que no escuchaba eso.

->->

=== ixchel_viernes ===
// Ixchel viernes - la noche difícil

Ixchel camina sola por la calle.
Es tarde. El restaurante cerró.

Un tipo le grita algo.
Algo sobre bolivianas.
Algo sucio.

Ella apura el paso.
El corazón le late fuerte.

Llega al cuarto.
Cierra con llave.
Se sienta en la cama.

"Mañana será otro día", dice en K'iche'.
Es lo que decía la abuela.
Es lo que se dice ella.

Tiene que ser verdad.
Tiene que.

->->

=== ixchel_sabado ===
// Ixchel sábado - día libre

Ixchel tiene el día libre.
Va a la feria de Tristán Narvaja.

Ve artesanías de todos lados.
Bolivia. Perú. Ecuador. Paraguay.
Pero ninguna de Guatemala.

Compra una naranja.
Se sienta a comerla en la plaza.

Extraña.
Extraña todo.
El sol de allá. El mercado de allá. La gente de allá.

Pero también ve algo.
Familias compartiendo.
Pibes jugando.
Gente resistiendo.

Quizás acá también se puede.
Quizás.

->->

=== ixchel_domingo ===
// Ixchel domingo - el altar

Ixchel arma un pequeño altar.
Una vela. Flores. La foto de la abuela.
Copal que trajo escondido en la maleta.

Reza en K'iche'.
No a un dios con nombre.
A todo. A la tierra. A los ancestros. A la vida.

"Maltiox."
Gracias.

Está lejos de todo.
Pero los ancestros viajan con ella.
Están en sus manos cuando teje.
Están en su lengua cuando reza.
Están en su sangre cuando resiste.

Nunca está sola.
Nunca.

->->

=== ixchel_generico ===
// Fallback para Ixchel

Ixchel mira la luna.
Es la misma luna que ve su abuela.
Eso la conecta.
Eso la sostiene.

->->

// ============================================
// FRAGMENTOS DE TIAGO
// ============================================

=== fragmento_tiago ===
// Tiago solo aparece si Bruno lo presionó
{not bruno_presiono_tiago:
    -> fragmento_ciudad ->
}

{dia_actual:
- 5: -> tiago_viernes
- 6: -> tiago_sabado
- 7: -> tiago_domingo
}
-> tiago_generico ->
->->

=== tiago_viernes ===
// Tiago después de la presión de Bruno

Tiago camina por la rambla.
Necesita pensar.

Bruno le pidió algo.
Algo que no quiere hacer.
Algo que lo convierte en lo que odia.

"No tenés opción", dijo Bruno.
"Todos tenemos opción", piensa Tiago.
Pero ¿es verdad?

Mira el mar.
El mar no tiene respuestas.
Solo olas.
Van y vienen.
Como las deudas.
Como los problemas.

->->

=== tiago_sabado ===
// Tiago tomando decisiones

Tiago no durmió.
Estuvo pensando toda la noche.

Si hace lo que Bruno quiere, traiciona a la comunidad.
Si no lo hace, Bruno le corta el laburo.
Y sin laburo... no hay nada.

Piensa en la familia.
En la hermana enferma.
En los remedios que hay que comprar.

A veces no hay opciones buenas.
Solo malas y peores.

->->

=== tiago_domingo ===
// Tiago - la decisión

Tiago toma una decisión.
No va a hacer lo que Bruno quiere.

No sabe cómo va a pagar los remedios.
No sabe cómo va a explicar.
No sabe nada.

Pero sabe quién es.
O quién quiere ser.

"Hay cosas que no se hacen."
La voz de la madre. La que ya no está.

Hay cosas que no se hacen.
Aunque cueste todo.

->->

=== tiago_generico ===
// Fallback para Tiago

Tiago mira el celular.
Mensajes de Bruno.
Los ignora.

Por ahora.

->->

// ============================================
// FRAGMENTOS DE LA CIUDAD
// ============================================

=== fragmento_ciudad ===
{dia_actual:
- 1: -> ciudad_lunes
- 2: -> ciudad_martes
- 3: -> ciudad_miercoles
- 4: -> ciudad_jueves
- 5: -> ciudad_viernes
- 6: -> ciudad_sabado
- 7: -> ciudad_domingo
}
-> fragmento_ciudad_noche ->
->->

=== ciudad_lunes ===
// Ciudad lunes - empezando semana

La ciudad despierta.
Mismo tránsito. Mismos ómnibus llenos. Mismo cansancio.

En los semáforos, los limpiavidrios.
En las esquinas, los que venden lo que pueden.
En los refugios, los que no tienen dónde ir.

La ciudad no ve.
La ciudad pasa de largo.
La ciudad tiene apuro.

Siempre apuro.
Nunca tiempo.

->->

=== ciudad_martes ===
// Ciudad martes - el centro

18 de Julio a las seis de la tarde.
Todos volviendo del laburo.
Caras cansadas. Mochilas pesadas.

En las vidrieras, cosas que nadie puede comprar.
En los bancos, colas que no terminan.
En las plazas, los que no tienen adónde volver.

La ciudad rica y la ciudad pobre.
La misma calle.
Mundos distintos.

->->

=== ciudad_miercoles ===
// Ciudad miércoles - lluvia

Llueve en Montevideo.
Las calles se vacían.

Los que tienen techo corren a buscar refugio.
Los que no tienen techo... se mojan.

La lluvia no discrimina.
Pero los techos sí.

->->

=== ciudad_jueves ===
// Ciudad jueves - el barrio

En el barrio, las cosas funcionan distinto.
No hay delivery gourmet.
Hay vecinos que se prestan una taza de azúcar.

No hay gimnasios con pileta.
Hay canchitas de baby fútbol con los arcos rotos.

No hay seguridad privada.
Hay ojos que miran, vecinos que cuidan.

Es distinto.
No peor.
Distinto.

->->

=== ciudad_viernes ===
// Ciudad viernes noche

Viernes de noche.
Los que tienen guita van a Pocitos.
Los que no tienen van a la plaza del barrio.

Misma ciudad.
Dos fiestas diferentes.

En una hay champagne.
En la otra hay tetrabrik.

Pero en las dos hay risa.
Eso no lo pueden privatizar.
Todavía.

->->

=== ciudad_sabado ===
// Ciudad sábado - la feria

Sábado de feria.
Tristán Narvaja llena de gente.

Libros viejos. Discos usados. Cachivaches.
Cosas que alguien tiró.
Cosas que alguien necesita.

La economía de lo usado.
La economía de los que no llegan.
La economía real.

->->

=== ciudad_domingo ===
// Ciudad domingo - el silencio

Domingo a la tarde.
Montevideo se aquieta.

Los negocios cerrados.
Las calles vacías.
Un silencio raro.

En ese silencio, los que trabajan igual.
Las empleadas domésticas.
Los deliverys.
Los que cuidan enfermos.

El descanso es un privilegio.
No todos lo tienen.

->->

=== fragmento_ciudad_noche ===
// Fragmento genérico de la ciudad de noche

La ciudad duerme.
O finge dormir.

Los que no tienen techo buscan donde quedarse.
Los que tienen techo tratan de no verlos.

Las luces de la rambla.
Los edificios de Pocitos.
Los cantegriles al fondo.

Todo convive.
Todo ignora.

La misma ciudad.
Mundos distintos.

->->

// ============================================
// SISTEMA DE SELECCION ESPECÍFICO POR DÍA
// (para uso en archivos de día específico)
// ============================================

=== seleccionar_fragmento_viernes ===
// Elige un fragmento para la noche del viernes
{ayude_en_olla:
    -> sofia_viernes ->
- else:
    {vinculo == "marcos":
        -> marcos_viernes ->
    - else:
        {vinculo == "diego":
            -> diego_viernes ->
        - else:
            -> ciudad_viernes ->
        }
    }
}
->->

=== seleccionar_fragmento_sabado ===
// Elige un fragmento para la noche del sabado
{participe_asamblea:
    -> sofia_sabado ->
- else:
    {vinculo == "elena":
        -> elena_sabado ->
    - else:
        {vinculo == "diego":
            -> diego_sabado ->
        - else:
            {vinculo == "marcos":
                -> marcos_sabado ->
            - else:
                -> ciudad_sabado ->
            }
        }
    }
}
->->

=== seleccionar_fragmento_domingo ===
// Fragmento final - basado en vinculo
{vinculo == "sofia":
    -> sofia_domingo ->
}
{vinculo == "elena":
    -> elena_domingo ->
}
{vinculo == "diego":
    -> diego_domingo ->
}
{vinculo == "marcos":
    -> marcos_domingo ->
}
{vinculo == "juan":
    -> juan_domingo ->
}
{vinculo == "ixchel":
    -> ixchel_domingo ->
}
// Fallback
-> ciudad_domingo ->
->->

// ============================================
// NOTAS DE DISEÑO v2
// ============================================

// Los fragmentos sirven para:
// 1. Mostrar que otros personajes tienen sus propias vidas
// 2. Dar información que el protagonista no tiene
// 3. Crear empatía con la comunidad
// 4. Mostrar las consecuencias sistémicas
// 5. Hacer sentir que el mundo sigue sin el jugador
// 6. Mostrar vulnerabilidad y humanidad de los NPCs

// Reglas de los fragmentos:
// - El jugador NO puede actuar durante un fragmento
// - Los fragmentos son cortos (50-150 palabras)
// - Cada fragmento muestra UN momento, UNA perspectiva
// - Los fragmentos varían según el día de la semana
// - Los fragmentos cambian según las decisiones del jugador
// - Los fragmentos deben generar conexión emocional

// Sistema implementado:
// - 7 fragmentos por personaje principal (uno por día)
// - Fragmentos condicionales según variables de estado
// - Fragmentos de la ciudad como fallback variados
// - Fragmento de Tiago solo si Bruno lo presionó
