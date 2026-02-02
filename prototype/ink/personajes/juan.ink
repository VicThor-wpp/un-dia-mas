// ============================================
// PERSONAJE: JUAN
// Compañero de trabajo (Juan)
// ============================================

// --- ENCUENTRO EN EL LABURO ---

=== juan_saludo_manana ===

Juan está en el escritorio de al lado.
Compañero hace tres años.
El único con el que hablás de verdad acá.

{
- dia_actual == 1:
    -> juan_pregunta_piso4
- dia_actual == 2:
    Te mira.
    "¿Cómo dormiste?"
    "Mal."
    "Yo también."
}

->->

=== juan_pregunta_piso4 ===
"Che, ¿viste lo del piso 4?"

* ["¿Qué pasó?"] -> juan_rumor
* ["No, ¿qué?"] -> juan_rumor
* ["No quiero saber."] -> juan_ignorar

=== juan_rumor ===

Juan baja la voz.

"Echaron a tres. El viernes. Sin aviso."

"¿En serio?"

"Reestructuración, dijeron. Pero mirá..."

* [...]
-

Mira para los costados.

"Los de RRHH andan raros. Reuniones todo el tiempo. Algo pasa."

~ hable_con_juan_sobre_rumores = true

* ["¿Creés que nos toca?"] -> juan_preocupacion
* ["Siempre hay rumores."] -> juan_minimizar
* ["Hay que cuidarse."] -> juan_cuidarse

=== juan_ignorar ===

"Como quieras."

Juan vuelve a su pantalla.
Un poco ofendido.

~ juan_relacion -= 1

Mejor no saber.
O no.

->->

=== juan_preocupacion ===

"No sé. Espero que no. Pero..."

Se encoge de hombros.

"Yo tengo el alquiler, la cuota del auto... Si me echan, cago fuego."

Se frota la cara.

"Me hacen facturar cuarenta mil pesos, bo. Como unipersonal.
Descontale el BPS, el Fonasa... me quedan treinta y cinco en la mano.
Entre eso y lo que gana Laura apenas llegamos.
El alquiler ya nos come la mitad. Después la luz, internet, el préstamo de la moto..."

"Yo también."

// Chequeo social: navegar la conversación delicada en el trabajo
# DADOS:CHEQUEO
~ temp resultado_juan_social = chequeo_completo_social(juan_relacion, 3)
{ resultado_juan_social == 2:
    -> juan_preocupacion_critico
}
{ resultado_juan_social == 1:
    -> juan_preocupacion_exito
}
{ resultado_juan_social == 0:
    -> juan_preocupacion_fallo
}
-> juan_preocupacion_crit_fallo

= juan_preocupacion_critico
* [...]
-

Un momento de honestidad. Raro en la oficina.
Los dos saben que son descartables.

Juan baja la voz aún más.

"Che, ¿sabés qué me dijo Martínez antes de que lo rajaran? Que vio una lista. Con nombres. En el escritorio de RRHH."

"¿Una lista?"

"No sé si es verdad. Pero si es así... tenemos que cuidarnos."

El dato queda. No sabés si es real.
Pero la confianza de Juan sí lo es.

~ juan_relacion += 2
~ subir_conexion(1)

"Bueno. A laburar. Que nos vean laburando."
->->

= juan_preocupacion_exito
* [...]
-

Un momento de honestidad.
Los dos saben que son descartables.
Que la "independencia" de la unipersonal era solo una forma de que la empresa se ahorre nuestros derechos.
Todos lo somos.

~ juan_relacion += 1

"Bueno. A laburar. Que nos vean laburando."
->->

= juan_preocupacion_fallo
* [...]
-

Juan mira para los costados. Nervioso.

"Mejor no hablar de esto acá."

Vuelve a su pantalla.
La conversación se cortó. Pero el miedo quedó.

"Bueno. A laburar."
->->

= juan_preocupacion_crit_fallo
* [...]
-

Juan se pone pálido.

"Pará, pará. ¿Vos creés que nos van a echar a todos?"

"No, no dije eso..."

"No, ya sé. Pero..."

Se levanta. Nervioso. Se va al baño.
Le metiste más miedo del que ya tenía.

~ aumentar_inercia(1)
->->

=== juan_minimizar ===

"Siempre hay rumores, Juan. Todos los meses dicen que van a echar gente."

"Sí, pero esta vez..."

"Esta vez también. Tranqui."

Juan no parece convencido.
Vos tampoco.
Pero hay que seguir.

->->

=== juan_cuidarse ===

"Hay que cuidarse. No llegar tarde, no bardear, hacer lo que piden."

"¿Vos creés que eso alcanza?"

"No sé. Pero peor es no hacer nada."

Juan asiente.
Los dos saben que es mentira.
Cuando quieren echarte, te echan.
No importa lo que hagas.

->->

// --- ALMUERZO CON JUAN ---

=== juan_almuerzo ===

~ almorzamos_juntos = true
~ juan_relacion += 1

Bajan juntos.
El comedor de la empresa.

"¿Qué hay hoy?"

~ ultima_tirada = d6()
{ultima_tirada <= 3: "Guiso."|"Milanesa con puré."}

"Podría ser peor."

Se sientan.
Comen.

Juan habla de su novia, de las vacaciones que quieren hacer, del partido del domingo.
Cosas normales.
Cosas de gente normal.

* [...]
-

Por un rato, te olvidás de los rumores.

~ subir_conexion(1)

"Che, si pasa algo... digo, si alguno de los dos... nos avisamos, ¿no?"

"Obvio."

No saben qué más decir.
Pero el pacto está.

->->

// ============================================
// BUILD-UP DE MIGRACIÓN - LUNES/MARTES
// Juan menciona que Laura tiene prima en España
// ============================================

=== juan_almuerzo_lunes_espana ===
// Trigger: lunes, durante almuerzo, si juan_relacion >= 2

~ juan_menciono_espana = true

Están almorzando.
Juan pincha la milanesa sin ganas.

"Che, ¿sabés qué? La prima de Laura se fue a España."

"¿Ah sí?"

"Sí. Valencia. Trabaja en una clínica. Dice que está bárbaro."

* ["¿Y le va bien?"]
    "Parece que sí. Gana en euros, alquila con la mitad del sueldo. Tiene vacaciones de verdad."
    -> juan_almuerzo_espana_cont
* ["Todos dicen eso al principio."]
    Juan se ríe, pero sin ganas.
    "Sí, capaz. Pero la mina está hace tres años. Y no volvió."
    -> juan_almuerzo_espana_cont
* [Seguir comiendo]
    -> juan_almuerzo_espana_cont

=== juan_almuerzo_espana_cont ===

"Laura anoche estuvo hablando con ella. Por videollamada."

* [...]
-

"Me mostró fotos del departamento. Dos cuartos. Balcón. En el centro."

Pausa.

"Con lo que pagan de alquiler allá, acá no alquilás ni un monoambiente en el Cerro."

* ["¿Laura quiere ir?"]
    Juan deja el tenedor.
    "No sé. Capaz. A veces hace comentarios."
    "¿Y vos?"
    "Yo... no sé. Tendría que pensarlo."
    ~ juan_seed_migracion = true
    ->->
* ["España está lejos."]
    "Sí. Pero cada vez parece más cerca que llegar a fin de mes acá."
    ~ juan_seed_migracion = true
    ->->
* [No decir nada]
    El tema queda flotando.
    ~ juan_seed_migracion = true
    ->->

=== juan_charla_martes_espana ===
// Trigger: martes, si juan_menciono_espana

Juan está raro hoy.

"Che, ¿te puedo preguntar algo?"

"Dale."

"¿Vos alguna vez pensaste en irte?"

* ["¿Irme a dónde?"]
    "No sé. Afuera. España, Chile, donde sea."
    -> juan_pregunta_irte_cont
* ["A veces."]
    Juan asiente.
    "Yo también. Últimamente más."
    -> juan_pregunta_irte_cont
* ["No. Acá está mi vida."]
    Juan te mira.
    "¿Qué vida? ¿Esta?"
    No sabés si es pregunta o acusación.
    -> juan_pregunta_irte_cont

=== juan_pregunta_irte_cont ===

"Laura anoche me dijo algo."

* [...]
-

"Que la prima le puede conseguir algo. En la clínica. No es seguro, pero..."

Pausa larga.

"Yo tengo el pasaporte italiano. Por el abuelo. Entro sin visa."

* ["¿Lo estás pensando en serio?"]
    "No sé. Sí. No. A veces."
    ~ juan_considerando_irse = true
    ~ juan_relacion += 1
    ->->
* ["Es una decisión grande."]
    "Ya sé. Por eso no sé."
    ~ juan_considerando_irse = true
    ->->
* ["Pensalo bien."]
    "Sí. Eso hago. Pensar. Todo el tiempo."
    ~ juan_considerando_irse = true
    ->->

// ============================================
// BUILD-UP DE MIGRACIÓN - MIÉRCOLES
// Post-despido: Juan pregunta "¿vos te irías?"
// ============================================

=== juan_post_despido_miercoles ===
// Trigger: miércoles, después del despido del protagonista, si juan_sabe_de_mi_despido

Juan te llama.

"Che. ¿Estás?"

"Más o menos."

"¿Podemos vernos? Quiero hablar de algo."

* ["Dale. ¿Dónde?"]
    -> juan_encuentro_miercoles
* ["Estoy complicado."]
    "Media hora. Es importante."
    -> juan_encuentro_miercoles

=== juan_encuentro_miercoles ===

~ energia -= 1

El bar de la esquina. El de siempre.
Juan ya está. Dos cervezas en la mesa.

Se te queda mirando.

"La puta madre. No lo puedo creer."

* ["Yo tampoco."]
    -> juan_miercoles_charla
* ["Es lo que es."]
    -> juan_miercoles_charla
* [...]
    -> juan_miercoles_charla

=== juan_miercoles_charla ===

"Tres años. Tres años laburando ahí. ¿Y así te avisan?"

"Sí. Reestructuración."

"Reestructuración mis huevos."

* [...]
-

Silencio. Juan toma un trago.

"¿Sabés qué? Esto me confirma algo."

"¿Qué?"

* [...]
-

"Que acá no hay nada. Que te pueden cagar en cualquier momento y no podés hacer nada."

Pausa.

"Laura habló de vuelta con la prima. Le dijo que hay posibilidades."

* ["¿En serio?"]
    -> juan_miercoles_espana
* ["¿De qué?"]
    -> juan_miercoles_espana
* [Quedarte callado]
    -> juan_miercoles_espana

=== juan_miercoles_espana ===

"Sí. En la clínica buscan gente. A Laura le podrían hacer los papeles."

Juan te mira.

"Y yo estuve pensando..."

* [...]
-

Larga pausa.

"Si vos, que hacías todo bien, que nunca faltabas, que laburabas el doble... si a vos te echaron así..."

"¿Qué me queda a mí?"

* [...]
-

Te mira fijo.

"¿Vos te irías?"

* ["No sé."]
    "Yo tampoco sabía. Ahora sé menos."
    ~ juan_pregunto_si_me_iria = true
    -> juan_miercoles_cierre
* ["No. Acá está todo lo que tengo."]
    Juan asiente. Lento.
    "Eso es lo que me decía mi viejo. 'Acá naciste, acá te quedás'. Y mirá cómo terminó."
    ~ juan_pregunto_si_me_iria = true
    -> juan_miercoles_cierre
* ["Si pudiera, capaz que sí."]
    "¿Ves? Vos también. Todos lo pensamos."
    ~ juan_pregunto_si_me_iria = true
    -> juan_miercoles_cierre

=== juan_miercoles_cierre ===

Terminan las cervezas en silencio.

"Bueno. Voy a casa. Laura está esperando."

* [...]
-

Se para. Te mira.

"Che. Lo que decidas... te banco. ¿Sabés?"

"Vos también."

Se va.

Te quedás pensando.
¿Qué decidirías vos si pudieras?

~ juan_relacion += 1
~ subir_conexion(1)

->->

// ============================================
// BUILD-UP DE MIGRACIÓN - JUEVES
// Mensaje de Juan: "Laura consiguió algo"
// ============================================

=== juan_mensaje_jueves ===
// Trigger: jueves, si juan_considerando_irse

Te llega un mensaje de Juan.

"Che. Laura consiguió algo."

* [Responder "¿Qué?"]
    -> juan_mensaje_jueves_cont
* [Responder "¿En España?"]
    -> juan_mensaje_jueves_cont
* [No responder]
    El mensaje queda ahí. Vibrando.
    ~ juan_avanzo_migracion = true
    ->->

=== juan_mensaje_jueves_cont ===

Juan escribe. Los tres puntitos.

"Sí. En la clínica de la prima. Le hacen los papeles."

Pausa.

"Todavía no es seguro. Pero es algo."

* ["¿Y vos?"]
    -> juan_jueves_respuesta
* ["Felicitaciones."]
    -> juan_jueves_respuesta
* ["¿Cuándo sería?"]
    -> juan_jueves_respuesta

=== juan_jueves_respuesta ===

"No sé. Estamos viendo. Pero si sale..."

* [...]
-

"Creo que me voy con ella."

Pausa larga.

"No sé cómo decirlo. Pero te quería contar a vos primero."

* ["Gracias por contarme."]
    "Vos sos de los pocos que entiende."
    ~ juan_avanzo_migracion = true
    ~ juan_relacion += 1
    ->->
* ["Es una noticia grande."]
    "Sí. Todavía no caigo."
    ~ juan_avanzo_migracion = true
    ->->
* ["¿Estás seguro?"]
    "No. Pero ¿cuándo estuve seguro de algo?"
    ~ juan_avanzo_migracion = true
    ->->

// ============================================
// BUILD-UP DE MIGRACIÓN - VIERNES
// Llamada: están viendo pasajes
// ============================================

=== juan_llamado_viernes_pasajes ===
// Trigger: viernes, si juan_avanzo_migracion

El teléfono suena. Juan.

"Che. ¿Podés hablar?"

* ["Sí, dale."]
    -> juan_viernes_pasajes
* ["Estoy ocupado."]
    "Dos minutos. Es importante."
    -> juan_viernes_pasajes

=== juan_viernes_pasajes ===

La voz de Juan suena rara. Temblorosa.

"Estuvimos mirando pasajes."

* [...]
-

"Hay uno para el sábado que viene. Barato. Bueno, barato para lo que sale."

Silencio.

"Laura quiere sacarlo. Dice que si no, nos vamos a arrepentir."

* ["¿Y vos qué querés?"]
    -> juan_viernes_duda
* ["¿Tan rápido?"]
    -> juan_viernes_duda
* [Quedarte callado]
    -> juan_viernes_duda

=== juan_viernes_duda ===

"No sé, bo. No sé qué quiero."

Escuchás que respira hondo.

"Una parte de mí quiere salir corriendo. Otra parte quiere quedarse. Y no sé cuál tiene razón."

* [...]
-

"¿Podemos vernos mañana? Antes de decidir. Necesito... no sé. Hablar con alguien que no sea Laura."

* ["Sí. ¿Dónde?"]
    "En la plaza de Jacinto Vera. A las cinco."
    ~ juan_encuentro_despedida = true
    ->->
* ["Dale. Te mando mensaje."]
    "Gracias. De verdad."
    ~ juan_encuentro_despedida = true
    ->->

// ============================================
// DESPEDIDA EMOCIONAL - SÁBADO
// Encuentro en persona, momento de honestidad
// ============================================

=== juan_despedida_sabado ===
// Trigger: sábado, si juan_encuentro_despedida

~ energia -= 1

La plaza de Jacinto Vera.
Un sábado a las cinco de la tarde.
Gurises jugando. Viejos en los bancos.

Juan está sentado solo. Mirando nada.

Te ve llegar. Se para.

"Gracias por venir."

* ["¿Cómo estás?"]
    -> juan_despedida_inicio
* [Sentarte a su lado]
    -> juan_despedida_inicio
* [...]
    -> juan_despedida_inicio

=== juan_despedida_inicio ===

Se sientan en un banco. Lejos de la gente.

Juan está callado. Mirando la plaza.

"¿Sabés qué? Crecí a tres cuadras de acá."

* [...]
-

"Esa panadería de la esquina. Iba con mi viejo los domingos. Bizcochos y café con leche."

Pausa.

"Y ahora voy a dejar todo esto."

* ["¿Ya decidieron?"]
    Juan asiente.
    "Sacamos los pasajes anoche. Sábado que viene."
    -> juan_despedida_confesion
* ["Todavía podés quedarte."]
    Juan te mira.
    "¿Para qué? ¿Para esperar que me echen a mí también?"
    -> juan_despedida_confesion
* [Quedarte callado]
    -> juan_despedida_confesion

=== juan_despedida_confesion ===

Juan se frota la cara. Respira hondo.

"Te voy a decir algo que no le dije a nadie."

* [...]
-

"Tengo miedo de quedarme."

Pausa.

"Y tengo miedo de irme."

* [...]
-

"Tengo miedo de todo, boludo. Toda mi vida tuve miedo."

Se le quiebra un poco la voz.

"Miedo de perder el laburo. Miedo de no poder pagar el alquiler. Miedo de decepcionar a Laura. Miedo de terminar como mi viejo."

* ["Tu viejo no terminó tan mal."]
    "¿No? Sesenta y cinco años, solo en un monoambiente, mirando la tele."
    -> juan_despedida_diego
* ["El miedo es normal."]
    "Sí. Pero el mío me paraliza. O me hace huir. No sé cuál es peor."
    -> juan_despedida_diego
* [Escuchar]
    -> juan_despedida_diego

=== juan_despedida_diego ===

Juan mira a unos gurises que juegan a la pelota.

"¿Sabés qué me hace pensar en Diego?"

* [...]
-

"Él vino huyendo. De la crisis, de los milicos, de todo. No tuvo opción."

Pausa.

"Ixchel igual. La mina vio cosas que yo ni imagino. Y vino acá. Sin nada."

* [...]
-

"Y yo... yo me voy buscando. Con pasaporte europeo. Con laburo esperando. Con todo armado."

Se ríe. Amargo.

"Ellos vinieron porque no les quedaba otra. Yo me voy porque puedo."

* ["Eso no está mal."]
    "No sé. A veces siento que los traiciono."
    -> juan_despedida_ironia
* ["Cada uno hace lo que puede."]
    "Sí. Pero algunos pueden más que otros. Y yo soy de los que puede."
    -> juan_despedida_ironia
* ["Es distinto."]
    "Ya sé. Pero igual me pesa."
    -> juan_despedida_ironia

=== juan_despedida_ironia ===

"¿Sabés qué es lo irónico?"

* [...]
-

"Yo toda la vida repitiendo 'vienen a sacarnos el laburo'. Y resulta que el que se va soy yo."

Pausa larga.

"Diego se quedó. Ixchel se quedó. Y yo, el uruguayo de toda la vida, soy el que escapa."

* ["No estás escapando."]
    "¿No? ¿Entonces qué hago?"
    -> juan_despedida_honestidad
* ["Capaz que ellos querían irse también."]
    "Capaz. Pero no podían. Yo puedo. Y elijo irme."
    -> juan_despedida_honestidad
* [Quedarte callado]
    -> juan_despedida_honestidad

=== juan_despedida_honestidad ===

Juan te mira. Los ojos húmedos.

"Che. Gracias por bancármela todos estos años."

* [...]
-

"Y perdón por las boludeces que dije. Lo de 'acá falta autoridad', lo de 'los que vienen de afuera'..."

Se frota los ojos.

"Soy un hipócrita, ¿sabés? Repetía esas cosas y ahora soy yo el que se va a otro país a buscar trabajo."

* ["Todos decimos boludeces."]
    "Sí. Pero algunas lastiman. Y yo lastimé."
    ~ juan_relacion += 1
    -> juan_despedida_abrazo
* ["Lo importante es que te diste cuenta."]
    "Sí. Tarde. Pero sí."
    ~ juan_relacion += 1
    -> juan_despedida_abrazo
* ["Ya está, Juan."]
    Juan asiente.
    "Ya está."
    -> juan_despedida_abrazo

=== juan_despedida_abrazo ===

Se para.

"Bueno. Era eso."

* [Abrazarlo]
    -> juan_abrazo_largo
* [Darle la mano]
    -> juan_mano_despedida
* [Quedarte sentado]
    -> juan_despedida_distante

=== juan_abrazo_largo ===

Lo abrazás.
Un abrazo largo. De esos que no se daban antes.
De esos que dicen todo lo que las palabras no pueden.

Juan te aprieta fuerte.

"Cuidate, boludo."

"Vos también."

* [...]
-

Se separan. Juan tiene los ojos rojos.

"Si alguna vez querés venir... tenés donde quedarte."

"Gracias."

"Y si alguna vez vuelvo... tomamos unas birras."

"Dale."

~ juan_despedida_emotiva = true
~ juan_relacion += 2
~ subir_conexion(2)

-> juan_despedida_final_sabado

=== juan_mano_despedida ===

Le das la mano.
Firme. Seria.

Juan la toma. Te mira.

"Suerte, Juan."

"Vos también."

* [...]
-

Por un segundo parece que quiere decir algo más.
Pero no dice nada.

~ juan_relacion += 1
~ subir_conexion(1)

-> juan_despedida_final_sabado

=== juan_despedida_distante ===

Te quedás sentado.
Juan te mira.

"Bueno. Chau."

"Chau."

* [...]
-

Se va.
No mirás para dónde.

-> juan_despedida_final_sabado

=== juan_despedida_final_sabado ===

~ juan_migra = true
~ juan_decidio_irse = true
~ juan_se_despidio = true

Lo mirás caminar por la plaza.
Pasa al lado de los gurises que juegan a la pelota.
Dobla en la esquina.
Desaparece.

* [...]
-

Te quedás un rato más.

Pensás en Diego, que vino huyendo y se quedó.
En Ixchel, que cruzó el continente y eligió este lugar.
En Juan, que nació acá y se va.

* [...]
-

La plaza sigue igual.
Los viejos en los bancos.
Los gurises jugando.

Otro uruguayo que se va.
Como tantos.

->->

// ============================================
// FRAGMENTO NOCTURNO DE JUAN - LA DECISIÓN
// Juan y Laura haciendo cuentas, mirando fotos
// ============================================

=== fragmento_juan_noche_migracion ===
// Juan la noche antes de decidir irse

Juan no puede dormir.

Laura ya duerme. Él mira el techo.

Se levanta despacio. Va a la cocina. Enciende la luz.

* [...]
-

Abre la notebook. Planilla de Excel.

"Pasajes: 2400 euros."
"Primer mes alquiler: 800 euros."
"Depósito: 800 euros."
"Comida hasta primer sueldo: 500 euros."

Hace la suma.
La hace de vuelta.
El mismo número.

* [...]
-

Lo tienen. Justo. Pero lo tienen.

Años de ahorrar para vacaciones que nunca llegaron.
Ahora sirven para otra cosa.

* [...]
-

Cierra la planilla. Abre fotos.

La plaza del barrio.
El bar de la esquina.
La cancha donde jugaba de gurí.
Sus viejos en el último cumpleaños.

* [...]
-

Traga saliva.

"¿Qué hacés?"

Laura. En la puerta. Medio dormida.

"Nada. Mirando cosas."

* [...]
-

Laura se acerca. Ve las fotos.

"¿Estás bien?"

"Sí. No. No sé."

* [...]
-

Laura se sienta a su lado.

"Todavía podemos no ir."

Juan la mira.

"No. Vamos. Es solo que..."

* [...]
-

"Es solo que me cuesta."

Laura le agarra la mano.

"A mí también."

Se quedan así. En silencio. Mirando fotos del barrio.

* [...]
-

Después cierran todo.
Van a la cama.
Juan sigue sin dormir.

Pero al menos no está solo.

->->

=== fragmento_juan_ultima_noche ===
// La última noche de Juan en Uruguay

Juan hace las valijas.

Dos valijas. Toda una vida en dos valijas.

Laura ya terminó la suya. Duerme.
Él no puede.

* [...]
-

Mira el departamento.

El sillón que compraron juntos.
La mesa donde cenaban.
La ventana que da al patio del vecino.

Se van a quedar. Todo se va a quedar.

* [...]
-

Saca el celular. Abre el chat con su viejo.

El último mensaje es de hace tres días:
"Andá tranquilo, hijo. Nosotros estamos bien."

Mentira. Pero una mentira de amor.

* [...]
-

Piensa en escribir algo.
No sabe qué.
Guarda el celular.

* [...]
-

Se sienta en el sillón. Por última vez.

Piensa en todo lo que deja.
En todo lo que busca.
En que capaz que no encuentra nada.
En que capaz que no vuelve nunca.

* [...]
-

Se duerme ahí.
En el sillón.
Con las valijas al lado.

Mañana empieza otra cosa.

->->

// ============================================
// REFLEXIÓN DEL PROTAGONISTA
// ¿Qué significa que Juan se vaya?
// ============================================

=== reflexion_juan_se_va ===
// Trigger: después de la despedida de Juan

Juan se va.

* [...]
-

Pensás en eso mientras volvés a casa.

Tres años trabajando juntos.
Almuerzos. Cervezas. Quejas del laburo.
Un amigo. O algo parecido a un amigo.

* [...]
-

Y ahora se va.

Como tantos.
Como los primos que se fueron a España.
Como los compañeros del liceo que están en México, Chile, Brasil.
Como medio Uruguay.

* ["¿Y yo?"]
    -> reflexion_protagonista_irse
* [Seguir caminando]
    -> reflexion_protagonista_quedarse

=== reflexion_protagonista_irse ===

¿Y yo?

¿Me iría?

* [...]
-

No tenés pasaporte europeo.
No tenés contactos afuera.
No tenés ahorros para un pasaje.

Pero aunque tuvieras...

* [...]
-

Pensás en la olla. En Elena. En Diego. En Ixchel.
En el vecino que te presta las herramientas.
En la señora que te guarda el pan.

En todo lo que te ata a este lugar.

* [...]
-

¿Atar? ¿O sostener?

-> reflexion_quedarse_resistir

=== reflexion_protagonista_quedarse ===

Seguís caminando.

Pasás por la panadería del barrio.
Por la plaza donde juegan los gurises.
Por la casa de Elena.

* [...]
-

Todo esto.

Todo esto que Juan deja.
Todo esto que Diego vino a buscar.
Todo esto que Ixchel encontró sin esperar.

* [...]
-

Todo esto que vos tenés.

-> reflexion_quedarse_resistir

=== reflexion_quedarse_resistir ===

Llegás a la esquina de tu casa.

* [...]
-

Juan se va buscando algo mejor.
Diego vino huyendo de algo peor.
Ixchel cruzó un continente para llegar acá.

Y vos estás acá. Siempre estuviste acá.

* [...]
-

¿Qué significa quedarse?

* ["Quedarse es resistir."]
    -> reflexion_resistir
* ["Quedarse es lo que me tocó."]
    -> reflexion_resignacion
* ["Quedarse es una elección."]
    -> reflexion_eleccion

=== reflexion_resistir ===

Quedarse es resistir.

No porque sea heroico.
No porque sea fácil.
Sino porque alguien tiene que estar.

* [...]
-

Alguien tiene que seguir abriendo la olla.
Alguien tiene que seguir cuidando el barrio.
Alguien tiene que seguir acá cuando todos se van.

* [...]
-

Capaz que sos vos.
Capaz que no.
Pero por ahora, estás.

~ subir_llama(1)
~ subir_dignidad(1)

->->

=== reflexion_resignacion ===

Quedarse es lo que me tocó.

No elegiste nacer acá.
No elegiste ser pobre.
No elegiste que te echaran.

* [...]
-

Pero acá estás.

Y algo hay que hacer con eso.

~ aumentar_inercia(1)

->->

=== reflexion_eleccion ===

Quedarse es una elección.

Podrías irte. Juntar plata. Buscar un pasaporte. Inventar algo.
Pero elegís quedarte.

* [...]
-

No porque sea mejor.
No porque sea más fácil.
Sino porque acá está lo tuyo.

* [...]
-

La gente. El barrio. La olla.

Las raíces que no se llevan en una valija.

~ subir_conexion(1)
~ subir_dignidad(1)

->->

// ============================================
// MENSAJE DE JUAN DESDE ESPAÑA
// Después de que se va
// ============================================

=== juan_mensaje_desde_espana ===
// Trigger: una semana después de que Juan se fue

Te llega un mensaje de Juan.

Número español.

"Che. Llegamos bien."

* [Responder]
    -> juan_espana_chat
* [Ver mensaje]
    -> juan_espana_leer

=== juan_espana_chat ===

"¿Cómo está todo?"

"Bien. Acá hace frío pero bueno. Diferente."

* [...]
-

"Laura ya arrancó en la clínica. Yo ando viendo cosas. Hay laburo."

Pausa.

"¿Y vos? ¿Cómo va todo por allá?"

* ["Bien. Sigo en la olla."]
    "Me alegro. Mandale saludos a todos."
    -> juan_espana_cierre
* ["Más o menos. Pero ahí andamos."]
    "Aguantá. Ya va a salir algo."
    -> juan_espana_cierre
* ["Acá todo igual."]
    "Sí. Eso pensé. Ojalá cambie."
    -> juan_espana_cierre

=== juan_espana_leer ===

"Foto: Valencia de noche. Luces. Gente en la calle."

* [...]
-

"Segunda foto: Juan y Laura sonriendo. Cansados pero sonriendo."

Parecen bien.
Parecen lejos.

-> juan_espana_cierre

=== juan_espana_cierre ===

"Bueno. Cuidate, boludo."

"Vos también."

* [...]
-

Guardás el teléfono.

Juan en España. Quién lo hubiera dicho.

Otro que se fue.
Pero este no desapareció.
Mandó mensaje.

Capaz que eso es lo que queda.
Los que se van pero no se olvidan.

~ juan_mando_mensaje_espana = true

->->

// --- DESPUÉS DE LA REUNIÓN ---

=== juan_post_reunion ===

Juan se acerca.

"Esta semana va a ser jodida."

"Sí."

No hay más que decir.

* [Preguntarle si quiere ir al bar] -> juan_invitar_bar
* [Irte] ->->

=== juan_invitar_bar ===

"Che, Juan. ¿Vamos a tomar algo?"

~ ultima_tirada = d6()

{ultima_tirada >= 3:
    "Dale. Una cerveza no viene mal."
    -> juan_bar
- else:
    "No puedo, tengo cosas. Otro día."
    "Dale. Otro día."
    Se va.
    ->->
}

=== juan_bar ===

~ fue_al_bar_con_juan = true

Van al bar de la esquina.
Dos cervezas.

~ energia -= 1
~ juan_relacion += 1
~ subir_conexion(1)

"¿Vos qué harías si te echan?", pregunta Juan.

* ["No sé. Buscar otra cosa."]
"A veces siento que estoy corriendo en una cinta, uruguayo. Mis viejos se rompieron el lomo para sacarme del barrio, para que yo fuera 'alguien'. Y acá estoy, facturando como si fuera un empresario mientras rezo que no me corten la luz. Si nos echan, volvemos al mismo barro del que ellos quisieron sacarnos."

Se quedan en silencio.
La cerveza está fría, pero el miedo calienta el aire.
    -> juan_bar_fin
* ["Tengo algo de ahorros. Aguantaría unos meses."]
    "Yo no. Si me echan, cago fuego."
    "Algo aparece, Juan."
    "Ojalá."
    -> juan_bar_fin
* ["Hay otros laburos. Hay otras cosas."]
    Juan te mira.
    "¿Cómo qué?"
    "No sé. Pero el mundo no se acaba."
    No suena convincente. Pero es algo.
    -> juan_bar_fin

=== juan_bar_fin ===

Terminan las cervezas.
Se despiden.

"Nos vemos mañana."
"Nos vemos."

~ activar_tengo_tiempo()

->->

// --- PREGUNTAR A JUAN ---

=== juan_preguntar_sobre_jefe ===

"Che, Juan. ¿Viste cómo me miró el jefe?"

"Sí. Raro."

"¿Qué onda?"

"No sé. Pero a Martínez lo miró así el jueves antes de que lo citaran."

Eso no ayuda.

~ aumentar_inercia(1)

->->

// --- DESPUÉS DEL DESPIDO ---

=== juan_enterarse_despido ===
// Cuando Juan se entera de que te echaron

~ juan_sabe_de_mi_despido = true

{juan_relacion >= 3:
    Juan te busca.
    "Che, me enteré. La puta madre."
    "Sí."
    "¿Estás bien?"
    "No sé."

    Te da un abrazo torpe.
    No sabe qué más hacer.
    Nadie sabe.

    "Si necesitás algo..."
    "Gracias."

    ~ subir_conexion(1)
- else:
    Juan te manda un mensaje.
    "Me enteré. Qué bajón."
    No respondés.
}

->->

=== juan_despues_despido ===
// Intentar contactar a Juan después de perder el laburo

{dia_actual <= 5:
    Llamás a Juan.

    ~ ultima_tirada = d6()

    {ultima_tirada >= 4:
        Contesta.
        "Hola. ¿Cómo andás?"
        "Ahí. ¿Y vos? ¿Cómo está todo?"
        "Igual. Raro sin vos acá."

        {juan_relacion >= 4:
            "Che, tendríamos que juntarnos. Un día de estos."
            "Dale. Avisame."
        }

        Cortás.
        El laburo sigue sin vos.
        La vida sigue sin vos.
        ->->
    - else:
        No contesta.
        Debe estar laburando.
        Obvio.
        ->->
    }
}

{dia_actual > 5:
    Pensás en llamar a Juan.
    Pero... ¿para qué?
    Ya no comparten nada.
    Solo compartían el laburo.

    ~ juan_estado = "distante"
    ->->
}

// --- FRAGMENTO NOCTURNO DE JUAN ---

=== juan_fragmento_noche ===

Juan no puede dormir.

Su novia ya duerme.

Él mira el techo.

{dia_actual == 1:
    Piensa en el laburo.
    En los despidos.
    En vos.

    Si lo echan a él, el alquiler se complica.
    La cuota del auto.
    Los planes con la novia.

    Todo armado sobre algo que puede desaparecer mañana.
}

{dia_actual == 2:
    Mañana la reunión.
    ¿A quién le tocará?
    ¿A vos? ¿A él?

    No puede dejar de pensar.
}

{dia_actual >= 3 && fui_despedido:
    Piensa en vos.
    En que te echaron.
    En que podría ser él mañana.

    {juan_relacion >= 4:
        Tendría que llamarte.
        Pero no sabe qué decir.
    }
}

"¿Estás bien?", pregunta ella sin abrir los ojos.

"Sí. Dormí."

Miente.
Todos mienten.

->->

// --- EL PASADO ENTERRADO DE JUAN ---

=== juan_recuerdo_marchas ===

~ juan_recuerdo_padre = true

Están hablando de la situación laboral.
Juan está más callado que de costumbre.

De pronto dice:

"Mi viejo me llevaba a las marchas."

"¿Qué marchas?"

* [...]
-

"Del PIT-CNT. Cuando era chico. Cinco, seis años. Me ponía arriba de los hombros para que viera."

"No sabía."

"No lo cuento nunca."

* [...]
-

Pausa larga.

"No sé por qué me acordé recién. Hace años que no pienso en eso."

"¿Y por qué dejaste de ir?"

* [...]
-

"No sé. Crecí. Empecé a laburar. El viejo se jubiló, se volvió amargo. Ya no hablamos de política."

"¿Y vos?"

"Yo... no sé. Supongo que me dio miedo terminar como él. Toda la vida peleando y al final solo, en un monoambiente, viendo las noticias para putearse."

* [...]
-

Silencio.

"A veces sueño con esas marchas. Con el ruido. Con mi viejo joven. Y me despierto confundido."

~ subir_conexion(1)
~ juan_relacion += 1

->->

=== juan_sobre_laura ===
// Escenas con Laura (la esposa)

~ juan_hablo_de_laura = true

"¿Cómo está Laura?"

Juan suspira.

"Bien. Ella siempre está bien. Es más tranquila que yo."

* [...]
-

"A veces me dice: 'Dejá de ver tantas noticias que te hacés mala sangre'. Tiene razón. Pero no puedo parar."

"¿Por qué?"

"Porque si no miro, siento que algo me va a agarrar desprevenido. Que me van a cagar y no me voy a dar cuenta."

* [...]
-

"Ella quiere tener hijos. Yo le digo que 'todavía no estamos listos económicamente'. Pero la verdad es que tengo miedo."

"¿De qué?"

"De traer un guri a este quilombo. De no poder darle nada. De terminar como mi viejo: prometiendo cosas que no podés cumplir."

* [...]
-

Pausa.

"Si me echan del laburo, ¿qué le digo? '¿Perdón, amor, se me terminó el curro y ahora somos pobres'?"

"No sos pobre, Juan."

"Todavía no."

~ subir_conexion(1)
~ juan_relacion += 1

->->

=== juan_fascinado_diego ===
// Juan fascinado por las historias de Diego

Están en la olla. Diego cuenta una historia.
Juan lo escucha con la boca abierta.

"Hermano, eso es de película. Las cooperativas, el camión quemado, la huida..."

Diego se encoge de hombros.

"Es mi vida, no más."

* [...]
-

Después, cuando Diego se va, Juan te dice:

"Ese tipo vivió más en veintiocho años que yo en treinta y dos."

"¿Te parece?"

* [...]
-

"A mí nunca me pasó nada. Nunca tuve que huir de nada. Nunca arriesgué nada."

"Eso no es malo."

"No sé. A veces siento que mi vida es... gris. Chica. Sin épica."

* [...]
-

Pausa.

"Y después viene uno como Diego, que perdió todo y sigue laburando, sigue ayudando. Y yo acá quejándome del alquiler."

No sabés qué decirle.
Pero algo se movió adentro suyo.

~ subir_conexion(1)

->->

=== juan_procesando ===
// El procesamiento lento de Juan
// Esta escena ocurre DESPUÉS de una conversación anterior

~ juan_proceso_algo = true

Una semana después de la charla.
Juan te manda un mensaje.

"Che, ¿podemos vernos un rato?"

* [Aceptar]

    Se encuentran.
    Juan trae café.
    
    "Estuve pensando en lo que dijo Diego el otro día."
    
    "¿Qué cosa?"
    
    * [...]
    -
    
    "Eso de que el problema no es el inmigrante, es el empresario que nos explota a los dos."
    
    "¿Y qué pensás?"
    
    * [...]
    -
    
    Juan toma café. Piensa.
    
    "Creo que tiene razón. O sea... yo siempre repetía lo que escuchaba en las noticias. 'Vienen a sacarnos el laburo'. Pero Diego labura el doble que yo y le pagan la mitad."
    
    * [...]
    -
    
    "Y el que nos paga poco a los dos es el mismo. No es Diego. Es el patrón."
    
    Pausa larga.
    
    "No sé. Capaz que soy un boludo y recién estoy entendiendo cosas que todo el mundo sabe."
    
    "No sos boludo. Estás pensando. Eso ya es algo."
    
    ~ subir_conexion(2)
    ~ juan_relacion += 1
    ->->

* [No poder]
    "No puedo ahora, Juan. Después."
    "Dale."
    
    No sabés qué quería decirte.
    Pero algo le quedó dando vueltas.
    ->->

=== juan_sobre_miedo ===
// Juan confronta su propio miedo

~ juan_hablo_de_miedo = true

"¿Sabés qué me pasa?"

"¿Qué?"

"Que tengo miedo de todo. De perder el laburo, de que me roben, de que las cosas se vayan al carajo. Y el miedo me hace decir cosas que después me arrepiento."

* [...]
-

"Como lo del 'acá falta autoridad'. O lo de 'los que vienen de afuera'. Cosas que repito sin pensar."

"¿Y por qué las decís?"

"Porque si le echo la culpa a alguien, me siento menos en banda. Como si supiera qué está pasando."

// Chequeo mental: ayudar a Juan a procesar su miedo
# DADOS:CHEQUEO
~ temp resultado_juan_miedo = chequeo_completo_mental(juan_relacion, 4)
{ resultado_juan_miedo == 2:
    -> juan_miedo_critico
}
{ resultado_juan_miedo == 1:
    -> juan_miedo_exito
}
{ resultado_juan_miedo == 0:
    -> juan_miedo_fallo
}
-> juan_miedo_crit_fallo

= juan_miedo_critico
* [...]
-

Silencio.

"Pero la verdad es que no sé nada. Solo tengo miedo y repito lo que dicen en la tele."

"Eso ya es darse cuenta de algo."

Juan te mira. Y por primera vez, dice algo que no esperabas:

"¿Sabés qué? Creo que mi viejo decía las mismas cosas. En las marchas, el enemigo era claro. Ahora todo es confuso. Y en la confusión, repetimos lo primero que escuchamos."

"Pero estás dejando de repetir."

"Sí. Capaz que sí."

~ subir_conexion(2)
~ juan_relacion += 2
->->

= juan_miedo_exito
* [...]
-

Silencio.

"Pero la verdad es que no sé nada. Solo tengo miedo y repito lo que dicen en la tele."

"Eso ya es darse cuenta de algo."

"Sí. Pero darse cuenta no alcanza. Hay que hacer algo. Y no sé qué."

~ subir_conexion(1)
~ juan_relacion += 1
->->

= juan_miedo_fallo
* [...]
-

Juan se queda callado.

"La verdad es que no sé nada."

No sabés qué decirle. El miedo es contagioso.
Y vos también tenés el tuyo.

"Somos dos boludos con miedo."

Se ríe. Vos también.
No resuelve nada. Pero alivia.

~ juan_relacion += 1
->->

= juan_miedo_crit_fallo
* [...]
-

Juan se pone más nervioso.

"¿Ves? Ni vos sabés qué decir. Nadie sabe."

El miedo se multiplica. Hablaron del tema y quedaron peor.
A veces abrir la caja de Pandora no ayuda.

"Mejor dejemos de hablar de esto."

~ aumentar_inercia(1)
->->

// --- ENCUENTRO DEL VIERNES (ORIGINAL) ---
// Hook: si tenés buena relación con Juan, te llama el viernes

=== juan_llamado_viernes ===
// Llamar solo si juan_relacion >= 4

El teléfono vibra.
Juan.

"Che, ¿estás? ¿Podemos vernos un rato?"

* ["Sí, dale. ¿Dónde?"]
    "En el bar de la otra vez. Media hora."
    -> juan_encuentro_viernes
* ["No puedo ahora."]
    "Dale, entiendo. Otro día."
    Cortás.
    Algo en su voz te quedó.
    ->->

=== juan_encuentro_viernes ===

~ energia -= 1

El bar de la esquina.
Mismo lugar que el lunes.
Parece hace mil años.

Juan ya está.
Pide dos cervezas antes de que te sientes.

Está raro.
Nervioso.
O algo.

"¿Todo bien?", preguntás.

{llama >= 5 || conexion >= 5:
    -> juan_noticia_buena
- else:
    -> juan_noticia_mala
}

=== juan_noticia_buena ===

Juan respira.

"Sí. Mirá, te quería contar algo."

Toma un trago.

* [...]
-

"Mi cuñado tiene un taller. Arregla electrodomésticos, esas cosas."

"¿Y?"

"Necesita alguien. No es fijo, son changas. Pero paga."

* [...]
-

Te mira.

"Pensé en vos. Si te interesa, le digo."

* ["Sí, pasale mi número."]
    ~ subir_conexion(1)
    ~ subir_dignidad(1)
    ~ juan_ofrecio_changa = true
    "Dale, le digo. Capaz te llama la semana que viene."

    No es un laburo.
    Es una posibilidad.
    Pero viniendo de Juan, significa algo.

    "Gracias, Juan."
    "Para eso estamos."
    -> juan_encuentro_fin

* ["Dejame pensarlo."]
    "Dale, sin presión. Avisame."

    No sabés si querés eso.
    Pero que Juan haya pensado en vos...

    ~ subir_conexion(1)
    -> juan_encuentro_fin

* ["No, gracias. Voy a buscar otra cosa."]
    "Como quieras."

    Juan parece un poco dolido.
    Pero entiende.

    -> juan_encuentro_fin

=== juan_noticia_mala ===

~ juan_tambien_despedido = true
~ juan_estado = "despedido"

Juan no te mira.
Toma un trago largo.

"A mí también me echaron."

Silencio.

* [...]
-

"¿Cuándo?"

"Ayer. Mismo discurso. Reestructuración."

Unipersonal también.
Sin nada.
Como vos.

* [...]
-

"La puta madre, Juan."

"Sí."

Se queda mirando la cerveza.

"Tres años. Facturando como si fuera mi propio jefe, mientras ellos ponían las reglas y se llevaban la tajada. Me vendieron la del emprendedor y me compraron como insumo."

* ["No sos pelotudo. Nos cagaron a todos."]
    ~ subir_conexion(2)
    ~ aumentar_inercia(1)

    "Es el sistema, Juan. Así funciona."

    "Ya sé. Pero igual duele."

    Toman en silencio.
    Dos tipos sin laburo.
    Pero juntos en esto.

    -> juan_encuentro_fin

* ["¿Y ahora qué vas a hacer?"]
    ~ subir_conexion(1)
    ~ aumentar_inercia(1)

    "No sé. Buscar. Lo que sea."

    "Si escucho algo, te aviso."

    "Gracias."

    Es raro.
    Antes él era el que tenía todo armado.
    Ahora están igual.

    -> juan_encuentro_fin

* [Quedarte callado]
    ~ aumentar_inercia(1)

    No sabés qué decir.
    ¿Qué se dice?

    Toman en silencio.

    -> juan_encuentro_fin

=== juan_encuentro_fin ===

Terminan las cervezas.
No piden otra.

"Bueno. Nos vemos."

"Nos vemos, Juan."

Se dan un abrazo torpe.
De esos que no se daban antes.

{juan_relacion >= 4:
    ~ juan_relacion += 1
}

Volvés a casa.
Con algo más.
O algo menos.
Depende cómo lo mires.

->->

// --- JUAN EN JUEVES-DOMINGO ---

=== juan_encuentro_jueves ===
// Juan te encuentra despues del despido
# PORTRAIT:juan,worried,left

Te suena el celular. Es Juan.

"Che, ¿estás bien? Me enteré de lo del laburo."

* ["Sí, ahí ando."]
    "No me vendas humo. ¿Necesitás algo?"
    ~ juan_relacion += 1
    ~ juan_sabe_mi_situacion = true
    ->->
* ["¿Cómo te enteraste?"]
    "El laburo es chico, se sabe todo."
    ~ juan_sabe_mi_situacion = true
    ->->
* [No contestar]
    Dejás sonar. No es el momento.
    ->->

=== juan_charla_viernes ===
// Juan en viernes
# PORTRAIT:juan,friendly,left

{juan_sabe_mi_situacion:
    Juan te manda un mensaje:
    "Tengo un contacto que busca gente. No es gran cosa pero es algo. ¿Querés que le pase tu número?"

    * ["Dale, pasale."]
        "Listo. Te aviso si me dice algo."
        ~ juan_ofrecio_contacto = true
        ~ juan_relacion += 1
        ->->
    * ["Dejá, ya veo."]
        "Bueno, pero si cambiás de idea avisame."
        ->->
- else:
    Juan te manda un mensaje genérico del grupo del laburo.
    No sabés si decirle lo que pasó.
    ->->
}

=== juan_invitar_olla_sabado ===
// Invitar a Juan a la olla
# PORTRAIT:juan,neutral,left

{ayude_en_olla && juan_sabe_mi_situacion:
    "Che Juan, hay una olla popular en el barrio. ¿Querés venir?"

    * ["Hay buena gente."]
        Juan duda.
        "¿Olla popular? No sé..."
        "Vení una vez. Si no te copa, no venís más."
        "Bueno. Dale."
        ~ juan_fue_a_olla = true
        ~ juan_relacion += 1
        ->->
    * [No insistir]
        "Ta, dejá. Era una idea."
        ->->
- else:
    No tiene sentido invitarlo todavía.
    ->->
}

=== fragmento_juan_noche ===
// Fragmento nocturno de Juan

Juan llega a su casa.
Un dos ambientes en la periferia. Más lejos, más barato.

Abre la heladera. Hay poco.
Piensa en el laburo. En que capaz que es el próximo.
En que los rumores siempre se cumplen.

{juan_sabe_mi_situacion:
    Piensa en vos.
    "Ojalá esté bien", murmura.
}

Se acuesta con la tele prendida.
El noticiero habla de desempleo.
Cambia de canal.

->->

// --- FRAGMENTOS NOCTURNOS DE JUAN ---

=== fragmento_juan_cena ===
Juan calienta una lata de atún.

Pan. Atún. Tele.
La rutina de los que viven solos.

{juan_sabe_mi_situacion:
    Piensa en vos.
    En que no contestaste el mensaje.
    O sí contestaste pero cortito.

    "Ojalá esté bien."
}

Lava el plato. Uno solo.
Se acuesta.

->->

=== juan_mensaje_sabado ===
// Juan manda mensaje de apoyo desde España (o antes de irse)
// Trigger: sábado, si juan_decidio_irse

{ juan_decidio_irse:
    Te llega un mensaje de Juan.

    "Che, me enteré de lo de la asamblea. Ojalá salga bien."
    "Desde acá los banco. Fuerza."

    ~ juan_mando_apoyo = true
    ~ subir_llama(1)

    No está. Pero sigue presente.
    Las distancias no borran los vínculos.
}

->->

=== fragmento_juan_curriculum ===
Juan actualiza su currículum.

Por las dudas.
Siempre por las dudas.

Después de lo que te pasó a vos...
Mejor tener todo listo.

"Experiencia laboral: 8 años en el mismo puesto."
"Habilidades: Excel, Word, aguantar."

Cierra la compu. Mañana hay que ir.
Mientras haya donde ir.

->->

// === JUAN SE VA - MIGRACIÓN A ESPAÑA (VERSIÓN ORIGINAL) ===
// Mantener para compatibilidad si no se activa el build-up

=== juan_despedida_migracion ===
// Juan cuenta que se va a España con Laura
// Trigger: viernes, si juan_relacion >= 3 Y NO se activó el build-up

{juan_encuentro_despedida:
    // Si ya está el build-up activo, ir a la versión nueva
    -> juan_despedida_sabado
}

El teléfono vibra. Juan.

"Che, ¿podés? Necesito contarte algo."

* ["Sí, dale."]
    "¿Dónde estás? Voy para allá."
    -> juan_despedida_cafe
* ["Estoy complicado ahora."]
    "Es importante. Media hora."
    -> juan_despedida_cafe

=== juan_despedida_cafe ===

~ energia -= 1

El mismo bar de siempre.
Pero Juan está distinto. Nervioso. O aliviado. No sabés.

Pide dos cervezas. No espera a que lleguen.

"Nos vamos."

* ["¿Cómo?"]
    -> juan_explica_migracion
* ["¿A dónde?"]
    -> juan_explica_migracion
* [...]
    -> juan_explica_migracion

=== juan_explica_migracion ===

"Laura tiene familia en Valencia. Una tía. Consiguió laburo en una clínica, le hacen los papeles."

# PAUSA

"Y yo... bueno. Con el pasaporte italiano del abuelo puedo entrar. Buscar algo allá."

* ["¿Y el laburo acá?"]
    Juan se ríe. Amargo.
    "¿Qué laburo? Estamos todos colgando de un hilo. Mejor cortar antes de que me corten."
    -> juan_migracion_razones
* ["¿Cuándo se van?"]
    "En dos semanas. Ya sacamos los pasajes."
    -> juan_migracion_razones
* [Quedarte callado]
    Las cervezas llegan. Juan toma un trago largo.
    -> juan_migracion_razones

=== juan_migracion_razones ===

"Mirá, yo sé lo que estás pensando. Que me escapo. Que es de cagón."

# PAUSA

"Capaz que sí. Pero Laura tiene la oportunidad, y yo... no tengo nada que me ate acá."

Silencio.

"Mis viejos se van a quedar solos. Eso me mata. Pero ellos mismos me dicen que me vaya. 'Andá, que acá no hay futuro'."

* ["¿Y vos qué pensás?"]
    -> juan_duda_interna
* ["Tus viejos tienen razón."]
    Juan asiente. Pero no parece convencido.
    -> juan_duda_interna
* ["Yo no me iría."]
    -> juan_contraste_quedarse

=== juan_duda_interna ===

Juan mira la cerveza.

"No sé. A veces pienso que me voy porque puedo. Porque tengo el pasaporte, porque Laura tiene el contacto."

# PAUSA

"Y pienso en Diego. En lo que tuvo que dejar. En que él no eligió irse."

* [...]
-

"Yo elijo. Y no sé si eso me hace libre o cobarde."

-> juan_despedida_final

=== juan_contraste_quedarse ===

"¿Por qué no te irías?"

* ["Porque acá está mi gente."]
    Juan te mira.
    "¿Qué gente? A vos te echaron igual que a mí van a echar. ¿Qué te queda?"
    "No sé. Pero algo."
    -> juan_reflexion_quedarse
* ["Porque irme es rendirse."]
    "¿Y quedarte qué es? ¿Ganar?"
    No tenés respuesta.
    -> juan_reflexion_quedarse
* ["No tengo a dónde ir."]
    Juan asiente.
    "Eso también. Yo puedo porque Laura puede. Si no, estaría igual que vos."
    -> juan_reflexion_quedarse

=== juan_reflexion_quedarse ===

# PAUSA

"Sabés qué pienso a veces? Que los que se quedan son más valientes. O más boludos. No sé."

Silencio.

"Mi viejo se quedó toda la vida. Fue a las marchas, peleó, y al final... monoambiente y soledad."

* [...]
-

"Yo no quiero eso. Pero tampoco quiero ser el que se fue y nunca volvió."

-> juan_despedida_final

=== juan_despedida_final ===

Terminan las cervezas.

Juan deja plata en la mesa. Más de lo que corresponde.

"Bueno. Era eso."

Se para. Incómodo.

* [Abrazarlo]
    Lo abrazás.
    Un abrazo largo. De esos que no se daban antes.
    "Cuidate, boludo."
    "Vos también."
    ~ juan_relacion += 1
    ~ subir_conexion(1)
    -> juan_despedida_cierre
* [Darle la mano]
    Le das la mano.
    "Suerte, Juan."
    "Gracias. Vos también."
    -> juan_despedida_cierre
* [No decir nada]
    No sabés qué decir.
    Juan tampoco.
    "Bueno. Chau."
    "Chau."
    -> juan_despedida_cierre

=== juan_despedida_cierre ===

~ juan_migra = true
~ juan_decidio_irse = true
~ juan_se_despidio = true

Se va.

Lo mirás caminar hasta la esquina. Dobla. Desaparece.

# PAUSA

Otro que se va.
Diego vino huyendo. Juan se va buscando.
Vos te quedás.

No sabés si es valentía o inercia.
Pero te quedás.

->->

// --- ESCENA CLAVE: CONTRADICCIÓN DE JUAN ---
// Juan retrocede después de que Lucía propone el paro


=== juan_contradiccion ===
// Juan retrocede después de hablar de organizarse

~ juan_mostro_contradiccion = true

Es viernes. Juan te llama aparte.

"Che. Sobre lo que hablamos el otro día..."

"¿Lo de juntarnos a hablar con otros?"

"Sí. Mirá..."

* [...]
-

Juan mira para los costados.

"La verdad, no sé si me conviene."

* [...]
-

"Si se enteran de que andamos juntando gente... sabés cómo son.
Te marcan. Y cuando hay despidos, sos el primero de la lista."

Te mira. Vergüenza.

"Tengo el alquiler. Laura. Los planes..."

* ["Te entiendo."]
    "No te juzgo, Juan. Cada uno tiene su situación."
    
    Juan suspira. Aliviado.
    
    "Gracias. Me siento un cagón, ¿sabés? Hablar de la injusticia y después..."
    -> juan_contradiccion_cierre
    
* ["Pero vos dijiste..."]
    "Sí, ya sé lo que dije. En el bar es fácil."
    
    Juan se frota la cara.
    
    "Después llegás a casa y pensás en Laura preguntando cómo pagamos el alquiler."
    -> juan_contradiccion_cierre
    
* [Quedarte callado]
    No decís nada.
    
    Juan tampoco.
    
    El silencio dice lo que las palabras no.
    -> juan_contradiccion_cierre

=== juan_contradiccion_cierre ===

"Si sale algo más tranqui... algo sin tanto riesgo..."

"Dale. Te aviso."

* [...]
-

Juan vuelve a su escritorio.

No es cobarde. Es que tiene mucho que perder.
Las revoluciones las hacen los que pueden darse el lujo de perder.
O los que ya perdieron todo.

Juan está en el medio.
Como la mayoría.

->->
