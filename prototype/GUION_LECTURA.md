# UN DÍA MÁS - GUIÓN DE LECTURA
Generated: 1/28/2026, 1:44:40 AM
Simplified for reading. No logic, no system files.







## CASA_DESPERTAR


El despertador.
{dia_actual == 1: Las 6:30.}
{dia_actual >= 4 && not tiene_laburo: No hay despertador. Te despertás igual.}

{tiene_laburo:
El cuerpo no quiere pero se levanta igual.
Otra semana.
}
{not tiene_laburo:
No hay razón para madrugar.
Pero el cuerpo ya tiene el ritmo.
}

- **OPCIÓN:** Levantarte de una
- **OPCIÓN:** Cinco minutos más
- **OPCIÓN:** {tiene_laburo} [Apagar el despertador y quedarte] # COSTO:1 # EFECTO:dignidad-
- **OPCIÓN:** {not tiene_laburo} [Quedarte en la cama] # COSTO:1 # EFECTO:conexion-


## CASA_LEVANTARSE_RAPIDO


Te levantás de una.
La disciplina del cuerpo que ya no pregunta.

{tiene_laburo: Años de lo mismo. El cuerpo sabe.}
{not tiene_laburo: El cuerpo todavía no sabe que ya no hace falta.}




## CASA_CINCO_MAS


Cinco minutos más.
El techo.
La luz que entra.

{perdida == "familiar": Por un segundo pensás en tu vieja. O en tu viejo. En las mañanas de antes.}
{perdida == "relacion": La cama está vacía del otro lado. Ya te acostumbraste. Casi.}
{perdida == "futuro": Pensás en todo lo que ibas a ser. Y en esto que sos.}
{perdida == "vacio": Hay algo que falta. Nunca sabés qué.}

Los cinco minutos se estiran.
Son diez.


{tiene_laburo:
Mierda. Vas a llegar tarde.
- **OPCIÓN:** Levantarte apurado
}
{not tiene_laburo:
No importa.
No hay a dónde llegar.
- **OPCIÓN:** Levantarte
}


## CASA_QUEDARSE


Apagás el despertador.
Te quedás.

El techo.
El silencio.
La pregunta de siempre: ¿para qué?

...

No. Hay que ir.
Hay cuentas que pagar.
Hay un sistema que te necesita funcionando.


Te levantás. Tarde.

- **OPCIÓN:** Apurarte


## CASA_QUEDARSE_SIN_LABURO


Te quedás en la cama.
No hay apuro.


El techo.
El silencio.
Los pensamientos.

{salud_mental <= 4:
¿Quién sos ahora?
¿Qué hacés?
¿Para qué te levantás?
}

Eventualmente, el cuerpo pide moverse.

- **OPCIÓN:** Levantarte


## CASA_BANARSE


{dias_sin_ducha == 1: Ayer no te duchaste.}
{dias_sin_ducha == 2: Hace dos días que no te duchás.}
{dias_sin_ducha >= 3: Hace {dias_sin_ducha} días que no te duchás. Se nota.}

- **OPCIÓN:** Ducharte
- **OPCIÓN:** Lavarte la cara nomás


## CASA_DUCHA


Te duchás.
El agua caliente.
Unos minutos de paz.

{tiene_laburo: El cuerpo despierta.}
{not tiene_laburo: No hay apuro. Podés tomarte tu tiempo.}

Te secás.
Te vestís.




## CASA_LAVARSE


Un lavado de cara.
El agua fría te despeja un poco.

{tiene_laburo: No hay tiempo para más.}
{not tiene_laburo: No tenés ganas de nada elaborado.}




## CASA_DESAYUNO


- **OPCIÓN:** Hacer café
- **OPCIÓN:** Salir de una


## CASA_MATE




El café de especialidad en la prensa francesa.
El ritual que te despierta y te sostiene.

- **OPCIÓN:** ...
-

Agua caliente. Molienda. Cuatro minutos.
Un vaso térmico para llevarte el resto.
{tiene_laburo: Cinco minutos de paz antes de salir.}
{not tiene_laburo: Todo el tiempo del mundo. Demasiado tiempo.}

{atadura == "responsabilidad":
Pensás en quién depende de vos.
{tiene_laburo: Otra razón para ir.}
{not tiene_laburo: Otra razón para encontrar algo.}
}

{posicion == "quemado":
Antes el café era para pensar en cosas.
Ahora es para no pensar.
}

- **OPCIÓN:** ...
-

No es gusto.
Es sostén energético.
Una forma de sobrevivir a la mañana.

{ despertar == 2:
El café te despierta de verdad. Sentís que hoy podés con lo que venga.
}
{ despertar == 1:
Algo en el café te despierta. Hoy se puede.
}
{ despertar == 0:
El café no basta. La cabeza sigue nublada.
}
{ despertar == -1:
Te quemás con el café. El vaso se cae, te salpica la mano.
El día arranca mal.
}

El café se termina.



## CASA_MATE_APURADO


No hay tiempo para café.
Un vaso de agua y listo.

El día empieza mal.
Pero empieza.



## CASA_SIN_CAFE


Sin café.
Un vaso de agua y a la calle.

{tiene_laburo: El café se toma en el bondi. O no se toma.}
{not tiene_laburo: Total, ¿para qué apurarse?}




## CASA_SALIR




El barrio temprano.
Gente yendo a {tiene_laburo: laburar|sus cosas}, pibes a la escuela.
El kiosco de la esquina abriendo.

{vinculo == "sofia":
Sofía está sacando a los pibes.
"¡Buen día!"
Le devolvés el saludo.
}

{vinculo == "elena":
Elena está en la vereda.
Barriendo, como siempre.
Te mira, asiente.
}

{vinculo == "diego":
Diego viene caminando por la otra vereda.
{tiene_laburo: También va al bondi.}
Se cruzan la mirada.
"¿Qué onda?"
"Ahí vamos."
}

{vinculo == "marcos":
Marcos no está.
Nunca está a esta hora.
}




## CASA_LLEGADA_NOCHE




Llegás a casa.

{energia <= 1: Estás destruido. No das para nada.}
{energia == 2: Estás cansado. Pero se puede.}
{energia >= 3: Todavía tenés algo de energía.}

- **OPCIÓN:** {energia >= 2} [Cocinar algo decente] # COSTO:1 # EFECTO:dignidad+
- **OPCIÓN:** Comer cualquier cosa
- **OPCIÓN:** {energia >= 2} [Llamar a alguien] # COSTO:1 # STAT:conexion # EFECTO:conexion+
- **OPCIÓN:** Tele y a dormir


## CASA_COCINAR



Cocinás algo.
Nada elaborado.
Pero comida de verdad.

Mientras cocinás, pensás.
{tiene_laburo: En el laburo. En lo que viene.}
{not tiene_laburo: En lo que no tenés. En lo que tenés que buscar.}

Comés.
No está mal.




## CASA_COMER_RAPIDO


Cualquier cosa.
Lo que haya.
Pan con algo.
Sobras.

Comés parado, mirando el celular.
Las noticias.
Las redes.
Nada bueno.



## CASA_LLAMAR_NOCHE



Llamás a alguien.

{vinculo == "sofia":
{ultima_tirada >= 4:
Sofía contesta. Hablan un rato.
De los pibes, de la olla, de la vida.
- else:
Sofía no contesta. Está acostando a los pibes.
}
}
{vinculo == "elena":
Elena contesta. Siempre contesta.
Hablan un rato. Te hace bien.
}
{vinculo == "diego":
Diego contesta.
Hablan boludeces. Está bien.
}
{vinculo == "marcos":
Marcos no contesta.
Como siempre.
}



## CASA_TELE


Prendés la tele.
Canales.
Noticias.

- **OPCIÓN:** ...
-

"La situación económica..."
"Despidos en el sector..."
"El gobierno anunció..."

{d6() <= 3:
Apagás la tele.
Mejor no.
- else:
Dejás la tele prendida.
Ruido de fondo.
Compañía falsa.
}



## CASA_NOCHE_FINAL


La noche avanza.

Te acostás.

{tiene_laburo:
Mañana hay que ir.
Siempre hay que ir.
}
{not tiene_laburo:
Mañana no hay que ir a ningún lado.
Eso debería ser un alivio.
No lo es.
}

Cerrás los ojos.
El sueño tarda en venir.

Pero viene.




## CASA_DIA_LIBRE


La mañana.
{dia_actual == 6 || dia_actual == 7: Fin de semana.}
{not tiene_laburo && dia_actual < 6: Un día más sin laburo.}

No hay apuro.
Pero tampoco hay nada.

- **OPCIÓN:** Quedarte en casa
- **OPCIÓN:** Salir


## CASA_QUEDARSE_DIA



Te quedás.
Tele.
Celular.
Nada.

Las horas pasan.
No hacés nada.
No hablás con nadie.

Es fácil quedarse.
Demasiado fácil.

{salud_mental <= 4:
Los pensamientos vienen solos.
¿Para qué?
¿Quién sos?
¿Qué estás haciendo?
}





## BONDI_ESPERAR_PARADA


La parada del bondi.
Hay gente esperando.
Cada uno en su mundo.

- **OPCIÓN:** Esperar tranquilo
- **OPCIÓN:** Mirar el celular
- **OPCIÓN:** {energia >= 3} [Hablar con alguien] # COSTO:1 # DADOS:conexion # EFECTO:conexion+


## BONDI_ESPERAR_TRANQUILO


Esperás.
El bondi tarda.
Siempre tarda.

La gente mira el celular o el vacío.


{ultima_tirada == 6:
El bondi llega rápido. Día de suerte.
}
{ultima_tirada == 1:
El bondi tarda una eternidad.
}

El bondi llega.
Normal.



## BONDI_ESPERAR_CELULAR


Mirás el celular.
Noticias.


{ultima_tirada <= 2:
"Empresa X despide a 200 trabajadores."
"La inflación de este mes..."

Cerrás las noticias.
Mejor no saber.
}
{ultima_tirada >= 5:
Un meme. Un video de un gato.
Por un segundo, sonreís.
}

El bondi llega.



## BONDI_ESPERAR_HABLAR



Hay una señora que siempre está a esta hora.
Nunca hablaste con ella.

"Buen día."

- **OPCIÓN:** ...
-

"Buen día." Te mira sorprendida. "¿Todo bien?"

"Sí, sí. Esperando el bondi nomás."

"Como todos."

- **OPCIÓN:** ...
-


{ultima_tirada >= 4:
"Yo trabajo acá cerca hace 20 años. Antes el bondi venía cada 10 minutos. Ahora..."
Se encoge de hombros.
"Todo empeora de a poco. Uno se acostumbra."
No es una conversación feliz.
Pero es una conversación.
}

El bondi llega.



## BONDI_CORRER_PARA_AGARRAR


El bondi está por irse.
Corrés.

{ carrera == 2:
Lo agarrás de taquito. El chofer te ve llegar corriendo y espera.
"Dale, subí." Ni transpirado estás.
}
{ carrera == 1:
Lo agarrás justo.
El chofer te mira con cara de "siempre lo mismo".
Pero te deja subir.
}
{ carrera == 0:
Se va.
El bondi se va en tu cara.

Mierda.

- **OPCIÓN:** Esperar el próximo
- **OPCIÓN:** Caminar
}
{ carrera == -1:
Corrés y te torcés el tobillo en la vereda rota.
El bondi se va.

Mierda. Mierda.


- **OPCIÓN:** Esperar el próximo renqueando
- **OPCIÓN:** Caminar como puedas
}


## BONDI_ESPERAR_OTRO


Esperás el próximo.
20 minutos.


Llegás tarde.



## BONDI_CAMINAR_ALTERNATIVA


Decidís caminar.
40 minutos, más o menos.


Es un día {d6() >= 4: lindo|gris} al menos.
Caminás.

Llegás tarde.
Pero llegás.



## BONDI_SUBIR




El bondi lleno.
Cuerpos apretados.
Olor a cuerpos, a sudor de madrugada, a cansancio acumulado.

- **OPCIÓN:** ...
-

Conseguís un lugar donde agarrarte.

- **OPCIÓN:** Mirar por la ventana
- **OPCIÓN:** Cerrar los ojos
- **OPCIÓN:** Escuchar conversaciones


## BONDI_SUBIR_TARDE




Subís al bondi.
Ya es tarde.
El estrés se suma al cansancio.

El bondi va más vacío a esta hora, al menos.
Te sentás.



## BONDI_VENTANA


La ciudad pasa.
Los edificios.
La gente en las veredas.

- **OPCIÓN:** ...
-

Los carteles de "Se alquila", "Se vende", "Cerrado".

{dia_actual == 1: Cada vez más carteles de esos.}
{dia_actual >= 4 && not tiene_laburo: Los carteles se sienten diferentes ahora. Más cercanos.}



## BONDI_OJOS_CERRADOS


Cerrás los ojos.
El ruido del bondi.
El movimiento.

- **OPCIÓN:** ...
-

Por un segundo, casi te dormís.

...

- **OPCIÓN:** ...
-

{d6() >= 4:
Tu parada. Justo a tiempo.
- else:
Alguien te empuja.
Casi te pasás.
}



## BONDI_ESCUCHAR


Dos personas atrás hablan:


{ultima_tirada <= 2:
"...y le dijeron que no renovaban. Así nomás. Diez años en la empresa."
"Está jodida la cosa."
"Está jodidísima."
{tiene_laburo: Las palabras quedan. Podrías ser vos.}
{not tiene_laburo: Ya sos vos.}
}
{ultima_tirada == 3 || ultima_tirada == 4:
"...el nene tiene fiebre y no puedo faltar..."
"Es una mierda."
"Es lo que hay."
Problemas de todos.
}
{ultima_tirada >= 5:
"...y entonces le dije que no, que así no..."
Se ríen.
Una conversación normal.
Eso también existe.
}



## BONDI_LLEGADA_DESTINO


Tu parada.
Bajás.



## BONDI_LLEGADA_DESTINO_TARDE


Tu parada.
Bajás.
Tarde.




## BONDI_VUELTA


El bondi de vuelta.
Menos lleno que a la mañana.

Te sentás.

- **OPCIÓN:** ...
-

Mirás por la ventana.
La ciudad de tarde.

{tiene_laburo:
Otro día.
Mañana lo mismo.
}
{not tiene_laburo:
La ciudad sigue.
Vos no sabés bien hacia dónde vas.
}

- **OPCIÓN:** Pensar en el día
- **OPCIÓN:** Desconectar
- **OPCIÓN:** Mirar a la gente


## BONDI_VUELTA_PENSAR


Pensás en el día.

{dia_actual == 1 && hable_con_juan_sobre_rumores:
En lo que dijo Juan.
En los despidos.
En la reunión.
}

- **OPCIÓN:** ...
-

{not tiene_laburo:
En que no tenés laburo.
En que no hay colchón. Nada.
Unipersonal. Sin derechos.
}

El bondi llega al barrio.



## BONDI_VUELTA_DESCONECTAR


Desconectás.
Música en los auriculares.
O nada.

- **OPCIÓN:** ...
-

Solo el ruido del bondi.

Por un rato, no pensás.

El bondi llega al barrio.



## BONDI_VUELTA_GENTE


Mirás a la gente.

Un viejo con bolsas.
Una mina con uniforme de trabajo.
Un pibe con la mochila del colegio.

- **OPCIÓN:** ...
-

Todos volviendo a algún lado.
Todos con sus cosas.

El bondi llega al barrio.



## BONDI_LLEGADA_BARRIO


Tu parada.
El barrio.

Bajás.





## LABURO_LLEGADA




Llegás.
8:05.
Justo.

El edificio de siempre.
La puerta de siempre.
El ascensor de siempre.

- **OPCIÓN:** ...
-

"Buen día."
"Buen día."
"Buen día."

Todos dicen buen día.
Nadie pregunta si lo es.



## LABURO_LLEGADA_TARDE




Llegás.
8:25.
Tarde.

El jefe te ve entrar.
No dice nada.
Anota algo.

Mierda.





## LABURO_MANANA




El escritorio.
La computadora.
Los mails.

Lo de siempre.

{ concentracion == 2:
Hoy estás afilado. Todo sale rápido y bien.
El jefe pasa y asiente. Bien.
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
}



## LABURO_TRABAJO_RUTINA


Las horas pasan.

Mails.
Planillas.

- **OPCIÓN:** ...
-

Reuniones que podrían ser mails.
Mails que podrían ser nada.

{d6() <= 3:
- else:
{d6() <= 2:
El jefe pasa por tu escritorio.
Te mira.
No dice nada.
Sigue.

¿Qué mierda fue eso?
}
}



## LABURO_EVENTO_TENSION



{ evento:
- 1:
Vas al baño.
Escuchás a alguien llorando en el cubículo del fondo.
Tratás de no hacer ruido.
Te lavás las manos rápido y salís.
El sonido del llanto te sigue hasta el escritorio.

- 2:
La impresora se traba.
Vas a destrabarla y ves un papel que quedó a medias.
"LISTA DE REVISIÓN DE PUESTOS - CONFIDENCIAL"
Alguien te lo arranca de la mano antes de que leas nombres.
"Dámelo." Es la secretaria de RRHH.

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




## LABURO_ALMUERZO




12:30.
Hora de comer.

- **OPCIÓN:** Almorzar acompañado
- **OPCIÓN:** Almorzar solo
- **OPCIÓN:** Saltear el almuerzo


## LABURO_ALMUERZO_ACOMPANADO


Bajás al comedor.
Sacás el tupper de la mochila.

Lo que trajiste de casa.
Lo que pudiste armar anoche.

{ultima_tirada <= 2: Arroz con huevo. Otra vez.}
{ultima_tirada == 3 || ultima_tirada == 4: Fideos con tuco de ayer.}
{ultima_tirada >= 5: Milanesa fría. Lujo.}

Te sentás con alguien.

{ charla_almuerzo == 2:
Enganchás una charla copada. Se ríen. Por un rato, olvidás todo.
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
}




## LABURO_ALMUERZO_SOLO


Comés solo.
En un rincón del comedor.
El tupper sobre la mesa.

A veces está bien.
El silencio.
No tener que hablar.

- **OPCIÓN:** ...
-

Mirás a los demás.
Cada uno con su vianda.
Algunos solos, otros en grupo.

¿Cuántos estiran la comida como vos?



## LABURO_ALMUERZO_SALTEAR



No comés.
Seguís laburando.

El estómago protesta pero la cabeza dice que hay que demostrar compromiso.
Que te vean.
Que sepan que sos valioso.

- **OPCIÓN:** ...
-

...

A las 3 te morís de hambre.
Comprás algo en la máquina.

No sirvió de nada.




## LABURO_TARDE




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
}




## LABURO_REUNION_GENERAL


El salón grande.
Toda la oficina.
30, 40 personas.

El jefe y alguien de RRHH al frente.

- **OPCIÓN:** ...
-

"Buenas tardes. Queríamos informarles..."

El aire se tensa.

"...que la empresa está atravesando un proceso de reestructuración."

Ahí está.

- **OPCIÓN:** ...
-

"No podemos dar detalles todavía, pero habrá cambios en las próximas semanas. Les pedimos paciencia y compromiso."

Eso es todo.
No dicen quién.
No dicen cuándo.
Solo que algo viene.

- **OPCIÓN:** Mirar a un compañero
- **OPCIÓN:** Mirar al piso
- **OPCIÓN:** Mirar al jefe


## LABURO_REUNION_MIRAR_COMPANERO


Mirás a tu compañero.
Él te mira.

Sin palabras, entienden.
Esto es real.

Hay miedo en sus ojos.
Probablemente en los tuyos también.



## LABURO_REUNION_MIRAR_PISO


Mirás el piso.
No querés ver a nadie.
No querés que te vean.

El miedo se huele.
30 personas pensando lo mismo.
¿Seré yo?



## LABURO_REUNION_MIRAR_JEFE


Mirás al jefe.
Está serio.
No mira a nadie en particular.

¿Él decide quién se va?
¿Él ya sabe?

No te mira.
No sabés si eso es bueno o malo.



## LABURO_REUNION_FIN


La reunión termina.
Todos vuelven a sus puestos.
Nadie habla.





## LABURO_CITACION_RRHH


Te llaman.

"Mañana a las 11, en RRHH."

No dicen para qué.

- **OPCIÓN:** Preguntar para qué
"¿Para qué?"
"Es una reunión de rutina."
No suena a rutina.
- **OPCIÓN:** Asentir
Asentís.
No preguntás.
A veces es mejor no saber.


## LABURO_CITACION_FIN



Aunque ya sabés.
O creés saber.




## LABURO_DESPIDO




La oficina de RRHH.
Dos personas que no conocés bien.
Un papel sobre la mesa.

"La empresa está reestructurando."

Ah.

- **OPCIÓN:** ...
-

"Tu puesto fue afectado."

Así que era eso.

"Dejamos de necesitar tus servicios. Gracias por tu colaboración."

- **OPCIÓN:** Escuchar
No hay liquidación. No hay indemnización.
Sos unipersonal. Facturás. "Independiente."
Así te contrataron hace tres años.
Así te echan hoy.

- **OPCIÓN:** Aceptar
- **OPCIÓN:** Preguntar por qué


## LABURO_DESPIDO_PREGUNTAR


"¿Por qué yo?"

Se miran entre ellos.

"No es personal. Es reestructuración."

"Pero trabajo acá hace tres años."

- **OPCIÓN:** ...
-

"Trabajás con nosotros. Facturás. Es diferente."

Claro. Siempre fue diferente cuando les convenía.
Nunca es personal.
Es el sistema funcionando como fue diseñado.

- **OPCIÓN:** Irte


## LABURO_DESPIDO_FIRMAR


No hay nada que firmar.
Sos unipersonal. Simplemente dejás de facturar.

Te dan una caja para tus cosas.
No tenés muchas cosas.

- **OPCIÓN:** ...
-

El escritorio se vacía rápido.





## LABURO_SALIDA




5 de la tarde.
El laburo terminó.
Por hoy.

Caminás a la parada.
El cuerpo cansado.
La cabeza {d6() >= 4: cansada también|peor}.



## LABURO_SALIDA_DESPEDIDO




Salís con tu caja.

La calle está igual que siempre.
El sol es el mismo sol.
La gente camina como si nada.

- **OPCIÓN:** Seguir caminando
Pero vos estás parado acá con una caja.
A las 11:30 de la mañana de un miércoles.
Sin laburo.

- **OPCIÓN:** ...
-

Tenés tres meses de colchón.
No te estás muriendo.
Pero algo murió.

¿Quién sos ahora que no tenés laburo?

- **OPCIÓN:** ...
-




No la elegiste. Llegó sola.
Como un zumbido en la cabeza que no para.




## LABURO_HABLAR_CON_JEFE



Te levantás.
Vas a la oficina del jefe.

"¿Puedo?"

"Sí, pasá. ¿Qué necesitás?"

"Nada, quería saber si... si estaba todo bien con mi trabajo."

Te mira.


{ultima_tirada >= 4:
"Sí, todo bien. ¿Por?"

"No, por nada. Rumores nomás."

"No hagas caso a los rumores. Concentrate en tu trabajo."

Salís.
No fue tan malo.
Pero tampoco te dijo nada.
- else:
"Mirá, ahora no es el momento para hablar de eso. Después vemos."

¿Después vemos qué?

"Bueno. Gracias."

Salís.
Peor que antes.
}




## BARRIO_CAMINAR




Caminás por el barrio.

Las veredas rotas de siempre.
Los autos estacionados.
Los perros callejeros.

{tiene_laburo:
Todo igual que siempre.
- else:
Todo igual. Pero vos no.
La calle se siente más ancha cuando no tenés adónde ir.
}

{ encuentro_barrio == 2:
Un vecino que no conocías te para. "¿Sos nuevo por acá?" "No, de toda la vida." Se ríen.
"Soy el Carlos. Del 14." Te da la mano. Un tipo más que te conoce.
}
{ encuentro_barrio == 1:
Cruzás saludos con un par de vecinos. El barrio te conoce.
}
{ encuentro_barrio == 0:
Nadie te saluda. O capaz no miraste.
}
{ encuentro_barrio == -1:
Un tipo te mira mal desde la esquina. No sabés por qué.
Apurás el paso. El barrio a veces no es fácil.
}


{ultima_tirada == 1:
}
{ultima_tirada == 2:
}
{ultima_tirada == 6:
}

El barrio sigue.
Vos seguís.



## BARRIO_ENCUENTRO_VECINO_MOLESTO


Un vecino te para.

"Che, ¿vos no viste quién me raya el auto?"

"No, ni idea."

"Siempre lo mismo en este barrio de mierda."

Se va enojado.



## BARRIO_ENCUENTRO_PERRO


Un perro callejero te sigue un rato.
Flaco.
Con cara de hambre.

{d6() >= 4:
Le tirás algo que tenés en el bolsillo.
Un pedazo de galletita.
El perro come y se va.
- else:
No tenés nada para darle.
El perro se aburre y se va.
}



## BARRIO_ENCUENTRO_POSITIVO


Una vecina te saluda.
"¡Buen día!"

"Buen día."

{d6() >= 4:
"¿Todo bien?"
"Sí, ahí andamos."
"Bueno. Cuidate."

Una conversación breve.
Pero humana.
- else:
Sigue caminando.
Pero te saludó.
Eso está bien.
}




## BARRIO_PLAZA




La plaza del barrio.

Un par de bancos, algunos árboles, los juegos oxidados.

- **OPCIÓN:** ...
-

Pibes jugando a la pelota.
Viejos sentados.
Madres con cochecitos.


{veces_en_plaza == 1:
No venías hace rato.
}

{not tiene_laburo:
Antes solo venías los fines de semana.
Ahora tenés todo el tiempo del mundo.
}

- **OPCIÓN:** Sentarte en un banco
- **OPCIÓN:** Caminar por la plaza
- **OPCIÓN:** Mirar a los pibes jugar
- **OPCIÓN:** Irte


## BARRIO_PLAZA_BANCO


Te sentás en un banco.

El sol.
El ruido de los pibes.
El viento.

- **OPCIÓN:** ...
-

Por un rato, no pensás en nada.

{d6() >= 5:
Alguien se sienta al lado tuyo.
Un viejo.

"Linda tarde."

"Sí."

Se quedan en silencio.
No hace falta más.

}



## BARRIO_PLAZA_CAMINAR


Caminás por la plaza.

Dando vueltas.
Sin rumbo.

{not tiene_laburo:
Esto hacés ahora.
Caminar.
Sin saber a dónde.
}

{d6() <= 2:
Una pelota te pega en el pie.
Un pibe viene corriendo.
"¡Perdón, señor!"
Se la devolvés.
"Tranquilo."
}



## BARRIO_PLAZA_PIBES


Mirás a los pibes jugar.

Picado en la tierra.
Gritos.
Peleas por goles.

{d6() >= 4:
Uno hace un golazo.
Los otros putean.
"¡Era offside!"
"¡Offside las pelotas!"

Te reís.
No te reías hace rato.
}

{not tiene_laburo:
Cuando eras pibe, todo era más simple.
O eso te parece ahora.
}




## BARRIO_KIOSCO




El kiosco de la esquina.

Esas viejas, caramelos, cigarrillos.

- **OPCIÓN:** ...
-

Revistas que nadie compra.
Un cartel de Coca-Cola de hace 20 años.

{not conozco_al_kiosquero:
El kiosquero es un tipo de unos 60.
Bigote.
Cara de pocos amigos.
- else:
El kiosquero está ahí, como siempre.
}

"¿Qué va a ser?"

- **OPCIÓN:** Comprar algo
- **OPCIÓN:** Solo saludar
"Nada, pasaba nomás. Buen día."
Te mira raro pero no dice nada.


## BARRIO_KIOSCO_COMPRAR



{ultima_tirada <= 2:
"Un agua."
"50."
Pagás. Te da el agua.
}
{ultima_tirada == 3 || ultima_tirada == 4:
"Un atado."
Te da el atado. Pagás.
{d6() >= 4:
"Cada vez más caros, eh."
"Todo sube."
"Todo sube."
}
}
{ultima_tirada >= 5:
"Dame un alfajor de esos."
Te da el alfajor.
"40."
Pagás.
}

{d6() == 6:
El kiosquero te mira.
"¿Todo bien? Te veo medio caído."

- **OPCIÓN:** "Sí, todo bien."
"Sí, todo bien."
"Bueno."
- **OPCIÓN:** "Ahí andamos."
"Ahí andamos. Perdí el laburo."
"Uh. Está jodido."
"Está jodido."
"Bueno. Suerte."
- else:
}



## BARRIO_TIPO_DEL_BANCO




El tipo que duerme en el banco.

Siempre está ahí.
Con sus bolsas, sus cartones, su mundo.

- **OPCIÓN:** ...
-

{not hable_con_el_del_banco:
Nunca le hablaste.
Nadie le habla.
Pasa la gente y no lo mira.
}

- **OPCIÓN:** ...
-

{not tiene_laburo:
Ahora lo mirás distinto.
¿Cuántos pasos hay entre vos y él?
Unipersonal. Sin indemnización. Sin seguro.
Muy pocos pasos.
}

- **OPCIÓN:** Acercarte
- **OPCIÓN:** Dejarlo tranquilo
Lo dejás tranquilo.
Él no pidió que lo molesten.


## BARRIO_BANCO_ACERCARSE


Te acercás.

Está despierto.
Te mira.

- **OPCIÓN:** ...
-

Ojos cansados.
Barba de días.
Ropa sucia pero no tanto.

{not hable_con_el_del_banco:
"¿Qué querés?"

No suena agresivo.
Solo cansado.

- **OPCIÓN:** Preguntarle si necesita algo
"¿Necesitás algo?"

Te mira.

"¿Y vos qué me vas a dar?"

No sabés qué decir.

"Un café, si querés."

"Bueno."



- **OPCIÓN:** Sentarte cerca
Te sentás en el otro extremo del banco.

Se quedan en silencio.

"Me llamo Roberto."

"Yo soy {vinculo == "sofia": Martín|Diego}."

"Bueno."


Silencio.
No hace falta más.


- **OPCIÓN:** Irte
"Nada. Perdón."
"Está bien."

- else:
"Ah, vos otra vez."

{nombre_del_banco != "": "¿Cómo andás, {nombre_del_banco}?"}

"Acá. Siempre acá."

- **OPCIÓN:** Ofrecerle un café
- **OPCIÓN:** Sentarte un rato
- **OPCIÓN:** Irte
"Bueno. Nos vemos."
"Chau."
}


## BARRIO_BANCO_CAFE


Le traés un café del kiosco.

"Gracias."

Toma.

- **OPCIÓN:** ...
-

{d6() >= 4:
"Yo laburaba, ¿sabés? En una fábrica. Hace años."
No preguntaste.
Pero te cuenta.
"Después cerró. Y bueno. Una cosa lleva a la otra."
Toma el café.
"Pero no estoy mal. Tengo mis cosas. Conozco gente. Vivo."
}



## BARRIO_BANCO_CHARLA


Te sentás.

{nombre_del_banco}: "¿Vos qué hacés?"

{tiene_laburo:
"Laburo. En una oficina."
"Ah. Bien."
- else:
"Nada. Perdí el laburo hace poco."

Te mira.

"Uh. ¿Y cómo la llevás?"

"Ahí."

"Sí. Ahí se lleva."
}

Silencio.

{d6() >= 4:
"¿Sabés qué es lo peor? No es el frío. No es el hambre. Es que la gente no te mira."

"Te miran como si no existieras."

Pensás en todas las veces que no miraste.

}




## BARRIO_ENCUENTRO_ALEATORIO



{ultima_tirada == 1:
}
{ultima_tirada == 2:
}
{ultima_tirada == 3:
}
{ultima_tirada == 4:
}
{ultima_tirada == 5:
}
{ultima_tirada == 6:
}



## BARRIO_ENCUENTRO_SOFIA


{vinculo == "sofia":
Sofía viene por la vereda con los pibes.

"¡Ey! ¿Qué hacés por acá?"

"Nada. Caminando."

"¿Todo bien?"

- **OPCIÓN:** "Sí, todo bien."
"Sí, todo bien."
"Bueno. Cualquier cosa..."
"Sí, ya sé."
- **OPCIÓN:** "Más o menos."
"Más o menos."
"Uh. ¿Querés hablar?"
"Después. Ahora no."
"Bueno. Sabés dónde estoy."
- else:
Una vecina pasa.
Te saluda.
"Buen día."
"Buen día."
}


## BARRIO_ENCUENTRO_MUSICA


De una casa sale música.
Cumbia.
A todo lo que da.

{d6() >= 4:
Por un segundo, el barrio se siente vivo.
No todo es gris.
- else:
Es temprano para tanta música.
Pero bueno. Cada uno.
}



## BARRIO_ENCUENTRO_DISCUSION


En una esquina, dos tipos discuten.

"¡Te dije que no!"
"¡Y yo te digo que sí!"

No sabés de qué hablan.
Pasás de largo.

{d6() == 1:
Uno te mira.
"¡¿Qué mirás?!"
"Nada."
Seguís caminando.
}



## BARRIO_ENCUENTRO_NENES


Pibes jugando en la vereda.
Con lo que hay.
Una pelota medio desinflada.
Chapitas.
Palitos.

{d6() >= 5:
Uno te saluda.
"¡Hola, señor!"
"Hola."
Te hace sonreír.
}



## BARRIO_ENCUENTRO_VIEJA


Una vieja camina despacio.
Con bolsas del super.
Le cuesta.

- **OPCIÓN:** Ayudarla
"¿La ayudo?"
"Ay, sí. Gracias, m'hijo."

Le llevás las bolsas hasta la esquina.

"Dios te bendiga."

- **OPCIÓN:** Seguir
Seguís caminando.
Ella sigue caminando.
Cada uno con lo suyo.


## BARRIO_ENCUENTRO_SILENCIO


Por un momento, todo está en silencio.

No hay gente.
No hay autos.
No hay nada.

- **OPCIÓN:** ...
-

Solo vos y el barrio.

{not tiene_laburo:
¿Esto es la vida ahora?
¿Caminar por el barrio sin rumbo?
}

- **OPCIÓN:** ...
-

El momento pasa.
Un auto pasa.
Todo sigue.




## BARRIO_NOCHE




El barrio de noche.

Pocas luces.
Perros ladrando.

- **OPCIÓN:** ...
-

La televisión prendida en las casas.

- **OPCIÓN:** ...
-

{d6() <= 2:
Hay un grupo de pibes en la esquina.
Fumando.
Hablando.
Te miran cuando pasás.
Seguís caminando.
}

{d6() == 6:
Las estrellas se ven.
A veces se olvida que están ahí.
El barrio no es tan malo de noche.
}




## BARRIO_DOMINGO




Domingo.
El barrio más tranquilo que nunca.

- **OPCIÓN:** ...
-

Los negocios cerrados.
Poca gente en la calle.

- **OPCIÓN:** ...
-

Alguien pasea un perro.
Un viejo toma café en un vaso térmico en la vereda.

{d6() >= 5:
El olor a asado viene de algún lado.
Domingos en familia.
Vos no tenés eso hoy.
}




## BARRIO_GRUPO_OLLA


El grupo de la olla.
Sofía, Elena, otros.

Hablando en la vereda.
Tomando café.

- **OPCIÓN:** ...
-

"¿Todo bien?", te preguntan.

Te quedás un rato.
Escuchando.
Siendo parte.





## BARRIO_CAMINAR_SIN_RUMBO


Caminás sin rumbo.

No hay a donde ir.
No hay a donde volver.

- **OPCIÓN:** ...
-

El barrio te conoce.
Pero hoy te siente distinto.

- **OPCIÓN:** ...
-

{not tiene_laburo:
Sin laburo, las calles son diferentes.
Antes eran camino al trabajo.
Ahora son solo calles.
}

- **OPCIÓN:** ...
-

Las horas pasan.
Caminando.
Pensando.




## BARRIO_SABADO




Sábado.
El barrio más relajado.

- **OPCIÓN:** ...
-

La gente hace compras.
Los pibes juegan en la calle.
Algún asado se prepara.

{d6() >= 4:
Pasás por la ferretería.
Cerrada.
"Se vende" dice el cartel.
Otro negocio que cierra.
}




## BARRIO_CAMINAR_TARDE


La tarde en el barrio.

El sol bajando.
Las sombras largas.

- **OPCIÓN:** ...
-

Gente volviendo de trabajar.
Gente saliendo a caminar.

{d6() >= 5:
Un vecino te saluda.
"¿Qué tal?"
"Ahí andamos."
El intercambio de siempre.
}




## BARRIO_CAMINAR_MANANA


La mañana en el barrio.

El sol recién saliendo.
El rocío en los autos.

- **OPCIÓN:** ...
-

Gente yendo a trabajar.
Pibes yendo a la escuela.

{not tiene_laburo:
Antes eras uno de ellos.
Los que van al laburo.
Ahora mirás pasar.
}

{d6() >= 5:
Un vecino te saluda.
"¡Buen día!"
"Buen día."
El saludo de siempre.
}





## OLLA_LLEGADA




La olla popular del barrio.
Un galponcito con chapas, mesas largas, ollas enormes.
El olor a comida que se siente desde la esquina.

Sofía está en el medio de todo.
Coordinando, hablando, moviendo ollas.
No para.

{olla_en_crisis:
Hay poca gente cocinando.
Las ollas están casi vacías.
Se nota la tensión.
- else:
Hay movimiento. Gente cocinando, gente sirviendo.
Funciona.
}

- **OPCIÓN:** Acercarte a ayudar
- **OPCIÓN:** Quedarte mirando
- **OPCIÓN:** {olla_en_crisis} [Preguntar qué pasa] # EFECTO:conexion?
- **OPCIÓN:** Irte


## OLLA_IRSE


Te vas.
Todavía no estás listo para esto.



## OLLA_OBSERVAR


Te quedás mirando desde afuera.

La gente. Viejos, familias, pibes.
No es una fila de espera pasiva. Se habla. Se comparte.
Vecinos. Gente que conocés de vista.

{not tiene_laburo:
Ahí está la red.
La que te empieza a faltar a vos.
}

Una señora te mira.
"¿Vas a comer o a mirar?"

- **OPCIÓN:** Ofrecer ayuda
- **OPCIÓN:** Irte
"No, nada. Perdón."
Te vas.


## OLLA_OFRECER_AYUDA


"Disculpá, ¿necesitan una mano?"

Sofía te mira de arriba abajo.

{veces_que_ayude == 0:
"¿Sabés pelar papas?"
"Sí."
"Entonces vení."
- else:
"Ah, volviste. Bien. Metete en {d6() >= 4: las papas|el reparto}."
}



## OLLA_AYUDAR_MENU




¿Qué hacés?

- **OPCIÓN:** Pelar papas
- **OPCIÓN:** Servir
- **OPCIÓN:** Limpiar
- **OPCIÓN:** {energia <= 1} [Decir que te vas]


## OLLA_PELAR_PAPAS



Te sentás en un banquito con un balde de papas.
Pelás.

Hay una señora al lado tuyo. Es Elena, la veterana del barrio. No la habías visto en esta tarea antes, o quizás sí y no te dabas cuenta.

- **OPCIÓN:** ...
-

{ pelada == 2:
Te sale natural. La cáscara sale en una tira larga, casi perfecta.
Elena te mira de reojo. No sonríe, pero asiente.
"Mi viejo pelaba así", dice. "En el 2002. Cuando tuvimos que cerrar el taller."
Es la primera vez que menciona el taller. El cuchillo sigue moviéndose.
Historias que se cuentan mirando para abajo.
}
{ pelada == 1:
Pelás. El movimiento repetitivo calma algo en tu cabeza.
Elena habla del precio del aceite. De que no alcanza.
"Es cíclico", dice. "Cada diez años nos rompen las piernas. Y aprendemos a caminar de nuevo."
Te pasa otra papa sin mirarte.
"Aprendemos."
}
{ pelada == 0:
Se te caen un par de papas. Tenés las manos torpes, desacostumbradas al trabajo manual.
Elena las levanta sin decir nada. Las lava. Te las devuelve.
"Despacio", dice. "Nadie nos corre."
Pero el hambre sí corre.
}
{ pelada == -1:
El cuchillo se resbala. Te cortás el dedo. La sangre gotea sobre una papa lavada.
"¡Trapo!"
Elena te venda rápido. Tiene práctica.
"La sangre se lava. El hambre no", murmura alguien.
Sentís la vergüenza arder más que el corte.
}

Las papas se acaban. Tus manos huelen a tierra y almidón.

- **OPCIÓN:** Seguir ayudando
- **OPCIÓN:** Irte


## OLLA_SERVIR



Te ponés atrás de la mesa.
Cucharón en mano.

La gente avanza.
Platos, platos, platos.

- **OPCIÓN:** ...
-

{ servicio == 2:
El ritmo es perfecto. Cucharón, plato, sonrisa. Cucharón, plato, sonrisa.
Ves una cara conocida. González. De contabilidad.
Te ve. Baja la vista.
Le servís un poco más de carne.
Él asiente, rápido, y se va sin mirar atrás.
La dignidad es un cristal frágil. Hoy vos lo cuidaste.
}
{ servicio == 1:
Servís. Las manos se estiran. Manos curtidas, manos de oficina, manos de pibes.
Una nena te da un dibujo a cambio del plato. Un sol negro.
"Gracias", dice.
Te guardás el dibujo en el bolsillo. Quema.
}
{ servicio == 0:
Calculaste mal. Le diste mucho a los primeros, ahora tenés que escatimar.
Un viejo te mira el cucharón medio vacío.
"¿Eso es todo?"
"Hay que estirar, abuelo."
Te odiás por decir eso. Te odiás mucho.
}
{ servicio == -1:
Se te vuelca el cucharón sobre la mesa.
"¡Eh, cuidado!"
Es comida caliente. Es comida que falta.
Sofía viene con un trapo. No te reta. Su silencio es peor.
"Tomate un respiro", te dice.
Te apartás, con las manos temblando.
}

{not tiene_laburo:
Del otro lado del mesón, las caras cambian.
Pero los ojos son los mismos.
Miedo.
El mismo miedo que tenés vos cuando te despertás a las 4 de la mañana.
}

La fila se termina.

- **OPCIÓN:** Seguir ayudando
- **OPCIÓN:** Irte


## OLLA_LIMPIAR



Limpiás.
Mesas, ollas, pisos.

El trabajo físico te vacía la cabeza.
Por un rato no pensás en nada.
Solo en la mugre y en sacarla.

- **OPCIÓN:** ...
-

{d6() >= 5:
Sofía está haciendo cuentas en una libreta.
Muerde la lapicera.
"No cierran", murmura. "Nunca cierran."
Te ve limpiando. Cierra la libreta de golpe.
"Dejá eso. Vení."
Te da un mate. Está frío.
"Gracias por venir. La mayoría viene una vez, se saca la foto moral y no vuelve."
Te mira fijo.
"No desaparezcas."
}

Terminás de limpiar. El piso brilla, o eso te parece.

- **OPCIÓN:** Seguir ayudando
- **OPCIÓN:** Irte


## OLLA_DESPEDIRSE


"Me voy yendo."

{veces_que_ayude >= 2:
Sofía asiente.
"Gracias por la mano. La olla es de todos."

- else:
"Bueno. Gracias."
}

Salís de la olla.
El olor a comida te sigue un rato.




## OLLA_PREGUNTAR_CRISIS


"¿Qué pasó? ¿Por qué tan vacío?"

Sofía suspira.

"No hay donaciones. El municipio se borró. El super cerró."

- **OPCIÓN:** ...
-

Mira las ollas casi vacías.

"Hoy damos, pero mañana... no sé."

- **OPCIÓN:** Ofrecer plata
- **OPCIÓN:** Ofrecer ayuda
- **OPCIÓN:** No decir nada
No sabés qué decir.
Ella tampoco espera que digas nada.


## OLLA_OFRECER_PLATA


{not tiene_laburo:
No tenés nada. Sin indemnización.
Lo poco que tenés es lo que juntaste.
Pero...
}

"¿Puedo aportar algo? Plata, digo."

Sofía te mira.

"Todo suma, pibe. Todo suma."

- **OPCIÓN:** Dar algo chico
Le das lo que tenés en el bolsillo.
No es mucho.
"Gracias."
- **OPCIÓN:** Dar algo más
Le das un billete más grande.
"Gracias. En serio."
- **OPCIÓN:** Pensarlo mejor
"Después te traigo algo."
"Bueno."
No suena convencida.


## OLLA_OFRECER_AYUDA_CRISIS


"¿Qué puedo hacer?"

"Conseguir donaciones. Hablar con gente. Mover contactos."

{not tiene_laburo:
Tenés tiempo, al menos.
}

"Hay una asamblea el viernes. Si querés venir..."

- **OPCIÓN:** Decir que vas a ir
"Voy."
"Bien."
- **OPCIÓN:** Decir que vas a ver
"Voy a ver si puedo."
"Bueno."


## OLLA_CRISIS_SIN_COMIDA




Llegás a la olla.
Está cerrada.

Un cartel en la puerta:
"HOY NO HAY COMIDA. MAÑANA INTENTAMOS."

- **OPCIÓN:** ...
-


Hay gente parada afuera.
Mirando el cartel.
Sin saber qué hacer.

- **OPCIÓN:** ...
-

Una señora con un nene.
Un viejo con bastón.
Dos pibes que no tienen más de 15.

{not tiene_laburo:
Vos tenés tres meses de colchón.
Ellos no tienen nada.
}

- **OPCIÓN:** Quedarte un rato
- **OPCIÓN:** Irte
Te vas.
No hay nada que hacer.
O sí, pero no sabés qué.


## OLLA_CRISIS_QUEDARSE


Te quedás.
No sabés para qué.

Sofía sale del galpón.
Tiene los ojos rojos.

- **OPCIÓN:** ...
-

"Mañana capaz que conseguimos algo. Hoy no hay."

La gente se va de a poco.
Vos te quedás.

- **OPCIÓN:** ...
-

"¿Querés ayudar de verdad?"

"Sí."

"Entonces vení el viernes a la asamblea."




## OLLA_ASAMBLEA




Viernes de noche.
El galpón de la olla lleno de gente.

No solo los que ayudan.
Vecinos.
Gente del barrio que nunca viste.

- **OPCIÓN:** ...
-

Sofía está al frente.

"Bueno, gracias por venir. Esto es de todos. Hablamos todos."


- **OPCIÓN:** Escuchar
- **OPCIÓN:** Hablar


## OLLA_ASAMBLEA_ESCUCHAR


Escuchás.

Una señora: "Mi marido perdió el laburo. Somos cuatro. No llegamos."

Un tipo: "El kiosco de la esquina cerró. ¿Quién nos va a donar ahora?"

Otra señora: "La municipalidad no responde. Llamé veinte veces."

- **OPCIÓN:** ...
-

Un pibe joven: "Hay que hacer algo. No podemos quedarnos esperando."

Sofía: "Por eso estamos acá. Para decidir qué hacemos."

{not tiene_laburo:
Pensás en tu propia situación.
Tres meses.
No es nada comparado con esto.
O es lo mismo, pero en cámara lenta.
}



## OLLA_ASAMBLEA_HABLAR



Levantás la mano.

"Yo... hace poco perdí el laburo. No estoy en la misma que ustedes, todavía. Pero quiero ayudar."

- **OPCIÓN:** ...
-

La gente te mira.

Sofía asiente.

"Todo el mundo aporta lo que puede. Eso está bien."




## OLLA_ASAMBLEA_PROPUESTAS


Se discuten propuestas.

"Hay que hacer una colecta."
"Hay que ir a la municipalidad."
"Hay que hablar con los comercios que quedan."
"Hay que organizarse mejor."

- **OPCIÓN:** ...
-

{d6() >= 4:
Al final, algo se decide.
Un plan. Tareas.
Vos te anotás para algo.

- else:
Al final, no se decide mucho.
Pero algo se mueve.
Al menos la gente habló.
}

La asamblea termina.
La gente se va de a poco.

Sofía te ve.

"Gracias por venir."




## OLLA_COMER




{veces_que_ayude >= 2:
Sofía te ve.
"¿Hoy comés?"

- **OPCIÓN:** Sí
"Sí."
"Sentate."
- **OPCIÓN:** No, solo vine a ayudar
"No, vine a ayudar nomás."
"Bueno. Vení."
- else:
Hacés la cola.
Como todos.
}


## OLLA_COMER_COLA


La cola.
Adelante tuyo, una señora con tres pibes.
Atrás, un viejo solo.

Nadie habla.

- **OPCIÓN:** ...
-

{not tiene_laburo:
¿Es esto tu futuro?
Quizás.
Pero si es esto, al menos no estás solo.
}

- **OPCIÓN:** ...
-

Te toca.
Te dan un plato.
Guiso.



## OLLA_COMER_PLATO


Guiso.
Papas, carne (poca), verduras.
Comida de verdad.

Te sentás en una mesa larga.
Comés.

- **OPCIÓN:** ...
-

{d6() >= 4:
Alguien al lado tuyo te habla.
"¿Primera vez?"
"Sí."
"Está bien la comida."
"Sí."
No dicen más.
Pero es algo.
}

Terminás de comer.




## OLLA_AMBIENTE_NORMAL


La olla funcionando.

Ollas en el fuego.
Gente preparando.
El olor a comida.

Lo de siempre.
Pero hay tensión.
Se nota en las caras.




## OLLA_AYUDAR_COCINA


Te ponés a ayudar.

Pelás papas.
Cortás verduras.
Revolvés la olla.

- **OPCIÓN:** ...
-

No es difícil.
Pero es necesario.





## OLLA_ESCUCHAR_CRISIS


"No hay para mañana."

Sofía lo dice bajito.
Pero todos escuchan.

- **OPCIÓN:** ...
-

"Las donaciones no llegan."
"El municipio no contesta."
"Los comercios ya no dan."


- **OPCIÓN:** ...
-

Silencio.
¿Qué se hace?




## OLLA_AMBIENTE_CRISIS


La olla está distinta hoy.

Menos movimiento.
Más caras largas.

Se siente la tensión.
Algo no está bien.

{olla_en_crisis:
Ya sabés lo que es.
No hay recursos.
}




## OLLA_COLECTA_CALLEJERA




Salís a la calle.
A pedir.

Es difícil.
Pararte en una esquina.
Explicar.
Pedir.

- **OPCIÓN:** ...
-


Pero lo hacés.
No bajás la cabeza. Mirás a los ojos.
Esto es trabajo digno. Es sostener.

- **OPCIÓN:** ...
-

Algunos dan.
La mayoría no.
Pero algunos sí.





## OLLA_PEDIR_VECINOS




Vas por las casas.
Golpeando puertas.
Pidiendo comida.

"Lo que tengan. Una papa. Un tomate."


{d6() >= 3:
Algunos dan.
Una bolsa acá, otra allá.
Se junta algo.
}

{d6() < 3:
Pocas puertas se abren.
La gente también está mal.
}




## OLLA_RESULTADO_COLECTA


Vuelven todos.
Se cuenta lo que hay.

{d6() >= 4:
"Algo juntamos."
No es mucho.
Pero es algo.
}

{d6() < 4:
"No alcanza."
Pero hay que cocinar igual.
Con lo que hay.
}




## OLLA_PREPARAR_ASAMBLEA


La olla se prepara para la asamblea.

Sillas en círculo.
Termo de café.
Papeles con números.

Hoy se habla de todo.
De cómo seguir.
De si se puede seguir.




## OLLA_ASAMBLEA_INICIO





La gente se sienta.
Sofía abre.

"Bueno. Estamos todos los que estamos."
"Gracias por venir."

- **OPCIÓN:** ...
-

Elena sirve café.
Alguien trae bizcochos.

"Hay que hablar de cómo seguimos."




## OLLA_ASAMBLEA_DISCUSION


La discusión empieza.

Ideas van y vienen:
- "Hacer más colectas."
- "Buscar comercios nuevos."
- "Ir al municipio de vuelta."
- "Organizar una feria."

- **OPCIÓN:** ...
-

Nadie tiene la respuesta.
Pero todos buscan.




## OLLA_ASAMBLEA_FIN


La asamblea termina.

No hay solución mágica.
Pero hay un plan.
Más o menos.

- **OPCIÓN:** ...
-

La gente se va yendo.
Algunos se quedan a limpiar.

"Gracias por venir", dice Sofía.





## OLLA_CERRAR_NOCHE


La olla cierra.

Las ollas vacías.
Las mesas limpias.
Las luces se apagan.

- **OPCIÓN:** ...
-

Sofía es la última en irse.
Siempre.

Mañana hay que volver a empezar.




## VIERNES_OLLA_ELENA_ECO


{elena_conto_historia:
Elena te ve llegar.
"Viniste."
No es sorpresa.
Es algo más.
Como si hubiera esperado que vinieras.
Como si la historia del 2002 hubiera funcionado.
}




## OLLA_HISTORIA_FUNDACION



Elena está sentada en un rincón.
Sofía revuelve la olla.
Hay un momento de calma.

"¿Cómo empezó todo esto?", preguntás.

Elena y Sofía se miran.

"La Chola", dicen las dos al mismo tiempo.

- **OPCIÓN:** ...
-

Elena habla primero.

"La mamá de Sofía. Empezó en los 90, dando merienda a los gurises en su casa."

Sofía asiente.

"Quince porciones. Con lo que había. Nada más."

- **OPCIÓN:** ...
-

"En el 2002 explotó. De quince a ochenta porciones. La Chola y Elena cocinaban turnándose."

Elena se ríe.

"Terminábamos a las cuatro de la mañana. Y a las siete ya estábamos pelando de nuevo."

- **OPCIÓN:** ...
-

"Después de la crisis, bajó un poco. Veinte, treinta porciones. La Chola se puso vieja. Sofía estaba en España."

"Y después vino la pandemia", dice Sofía.

"Y de treinta pasamos a cien. Y acá estamos."

- **OPCIÓN:** ...
-

Mirás el galponcito. Las paredes de bloque, el techo de chapa.

"Todo esto lo construyeron ustedes."

"Entre todos", corrige Elena. "Nunca nadie solo."




## OLLA_VIRGEN_GUADALUPE


Notás una imagen en la pared.
La Virgen de Guadalupe. Colores vivos. Flores dibujadas alrededor.

"La puso la Chola", dice Sofía sin que preguntes.

- **OPCIÓN:** ...
-

"La trajo de un viaje a México. Decía que era la patrona de los pobres."

"¿Vos creés en eso?"

- **OPCIÓN:** ...
-

Sofía se encoge de hombros.

"Creo en lo que funciona. Y esa imagen lleva ahí veinte años. La gente la mira cuando entra. Algunos rezan. Otros no. Pero todos la ven."

- **OPCIÓN:** ...
-

Mirás la imagen.
Morena, con rayos dorados.
Parece vigilar todo.

{ixchel_me_conto_de_tomas:
Pensás en Ixchel.
Ella también tiene una estampita de la Virgen.
La misma Virgen en dos continentes.
La misma lucha.
}



## OLLA_GRUPO_WHATSAPP


El celular de Sofía no para de sonar.

"El grupo", explica. "Ahí coordinamos todo."

"¿Cuántos son?"

"Ocho. Los que siempre estamos."

- **OPCIÓN:** ...
-

"Diego avisa cuando consigue donaciones. Yo anoto quién trae qué. Las vecinas confirman si pueden venir."

"¿Y Elena?"

- **OPCIÓN:** ...
-

Sofía se ríe.

"Elena no tiene WhatsApp. Dice que es 'para pendejos'. Yo le cuento todo."

"¿Y funciona?"

"Más o menos. A veces los mensajes se pierden. A veces la gente no lee. Pero es mejor que nada."




## OLLA_SOBRE_DONACIONES


"¿De dónde sale todo esto?", preguntás mirando las ollas, los cajones de verdura.

Sofía cuenta con los dedos.

"El Plan ABC de la Intendencia. Insumos básicos: arroz, fideos, aceite. Pero llega irregular."

- **OPCIÓN:** ...
-

"Don Rubén, del almacén de la esquina. Nos da lo que está por vencer. Y a veces algo más."

"La verdulería de los paraguayos. Dejan cajones los viernes."

- **OPCIÓN:** ...
-

"Vecinos que aportan. Desde cien pesos hasta dos mil. Todo va a una caja que administra Elena."

"¿Y vos?"

- **OPCIÓN:** ...
-

Sofía duda.

"Yo pongo entre diez y quince mil por mes. Más cuando hay emergencias."

"Eso es mucho."

"Sí. Pero no alcanza para mantenerlo sola. Esto es colectivo o no es."




## OLLA_DON_RUBEN


Llega un hombre mayor cargando bolsas.

"Don Rubén", lo saluda Sofía. "Gracias."

"De nada, m'hija. Esto iba a la basura pero todavía está bueno."

- **OPCIÓN:** ...
-

Don Rubén se va.

"Siempre nos ayuda", dice Sofía. "Desde el 2002."

"¿Por qué?"

- **OPCIÓN:** ...
-

"Dice que él también estuvo en la cola cuando era chico. En otra olla, en otro barrio. Ahora le toca dar."

"Qué grande."

"Es el barrio. Así funciona. Los que pueden dan, los que necesitan reciben. Y a veces es lo mismo."



## OLLA_VERDULERIA_PARAGUAYOS


Es viernes.
Llegan cajones de verdura.

"De la verdulería de los paraguayos", explica Diego. "Siempre los viernes."

- **OPCIÓN:** ...
-

"¿Por qué ayudan?"

"Porque son de acá también. Aunque algunos no los vean así."

- **OPCIÓN:** ...
-

Diego baja la voz.

"A veces los molestan. Les dicen cosas. Pero siguen viniendo, siguen donando."

"Qué hijos de puta los que los molestan."

"Sí. Pero ellos son más fuertes que eso."




## OLLA_PLAN_ABC


Sofía revisa unas cajas.

"El Plan ABC llegó", anuncia.

"¿Qué es?"

- **OPCIÓN:** ...
-

"El plan de la Intendencia de Montevideo. Nos dan insumos: arroz, fideos, aceite. A veces lentejas."

"¿Y alcanza?"

- **OPCIÓN:** ...
-

Sofía se ríe sin gracia.

"Alcanza para un día y medio. Y llega una vez por mes. Cuando llega."

"¿Cómo que cuando llega?"

- **OPCIÓN:** ...
-

"A veces se demoran. A veces falta algo. Una vez nos mandaron arroz para tres meses pero nada de aceite. ¿Qué hacés con arroz sin aceite?"

Suspira.

"Pero es algo. Más de lo que teníamos antes de 2020."



## OLLA_CAJA_ELENA


Elena saca una caja de lata de debajo de la mesa.

"La caja", dice.

"¿Qué tiene?"

- **OPCIÓN:** ...
-

"Los aportes de los vecinos. Los que pueden, ponen algo. Cien pesos, quinientos, lo que tengan."

Abre la caja. Billetes doblados, monedas, un papelito con anotaciones.

- **OPCIÓN:** ...
-

"Todo se anota. Yo llevo la cuenta acá, Sofía tiene un backup en el celular."

"¿Y cuánto hay?"

Elena cuenta.

"Mil trescientos. Alcanza para una garrafa y algo de verdura."

- **OPCIÓN:** ...
-

Cierra la caja.

"No es mucho. Pero es nuestro. Nadie nos lo regaló."








## JUAN_SALUDO_MANANA


Juan está en el escritorio de al lado.
Compañero hace tres años.
El único con el que hablás de verdad acá.

{
- dia_actual == 1:
- dia_actual == 2:
Te mira.
"¿Cómo dormiste?"
"Mal."
"Yo también."
}



## JUAN_PREGUNTA_PISO4

"Che, ¿viste lo del piso 4?"

- **OPCIÓN:** "¿Qué pasó?"
- **OPCIÓN:** "No, ¿qué?"
- **OPCIÓN:** "No quiero saber."


## JUAN_RUMOR


Juan baja la voz.

"Echaron a tres. El viernes. Sin aviso."

"¿En serio?"

"Reestructuración, dijeron. Pero mirá..."

- **OPCIÓN:** ...
-

Mira para los costados.

"Los de RRHH andan raros. Reuniones todo el tiempo. Algo pasa."


- **OPCIÓN:** "¿Creés que nos toca?"
- **OPCIÓN:** "Siempre hay rumores."
- **OPCIÓN:** "Hay que cuidarse."


## JUAN_IGNORAR


"Como quieras."

Juan vuelve a su pantalla.
Un poco ofendido.


Mejor no saber.
O no.



## JUAN_PREOCUPACION


"No sé. Espero que no. Pero..."

Se encoge de hombros.

"Yo tengo el alquiler, la cuota del auto... Si me echan, cago fuego."

"Yo también."


{ resultado_juan_social == 2:
}
{ resultado_juan_social == 1:
}
{ resultado_juan_social == 0:
}


### juan_preocupacion_critico

- **OPCIÓN:** ...
-

Un momento de honestidad. Raro en la oficina.
Los dos saben que son descartables.

Juan baja la voz aún más.

"Che, ¿sabés qué me dijo Martínez antes de que lo rajaran? Que vio una lista. Con nombres. En el escritorio de RRHH."

"¿Una lista?"

"No sé si es verdad. Pero si es así... tenemos que cuidarnos."

El dato queda. No sabés si es real.
Pero la confianza de Juan sí lo es.


"Bueno. A laburar. Que nos vean laburando."


### juan_preocupacion_exito

- **OPCIÓN:** ...
-

Un momento de honestidad.
Los dos saben que son descartables.
Que la "independencia" de la unipersonal era solo una forma de que la empresa se ahorre nuestros derechos.
Todos lo somos.


"Bueno. A laburar. Que nos vean laburando."


### juan_preocupacion_fallo

- **OPCIÓN:** ...
-

Juan mira para los costados. Nervioso.

"Mejor no hablar de esto acá."

Vuelve a su pantalla.
La conversación se cortó. Pero el miedo quedó.

"Bueno. A laburar."


### juan_preocupacion_crit_fallo

- **OPCIÓN:** ...
-

Juan se pone pálido.

"Pará, pará. ¿Vos creés que nos van a echar a todos?"

"No, no dije eso..."

"No, ya sé. Pero..."

Se levanta. Nervioso. Se va al baño.
Le metiste más miedo del que ya tenía.



## JUAN_MINIMIZAR


"Siempre hay rumores, Juan. Todos los meses dicen que van a echar gente."

"Sí, pero esta vez..."

"Esta vez también. Tranqui."

Juan no parece convencido.
Vos tampoco.
Pero hay que seguir.



## JUAN_CUIDARSE


"Hay que cuidarse. No llegar tarde, no bardear, hacer lo que piden."

"¿Vos creés que eso alcanza?"

"No sé. Pero peor es no hacer nada."

Juan asiente.
Los dos saben que es mentira.
Cuando quieren echarte, te echan.
No importa lo que hagas.




## JUAN_ALMUERZO



Bajan juntos.
El comedor de la empresa.

"¿Qué hay hoy?"

{ultima_tirada <= 3: "Guiso."|"Milanesa con puré."}

"Podría ser peor."

Se sientan.
Comen.

Juan habla de su novia, de las vacaciones que quieren hacer, del partido del domingo.
Cosas normales.
Cosas de gente normal.

- **OPCIÓN:** ...
-

Por un rato, te olvidás de los rumores.


"Che, si pasa algo... digo, si alguno de los dos... nos avisamos, ¿no?"

"Obvio."

No saben qué más decir.
Pero el pacto está.




## JUAN_POST_REUNION


Juan se acerca.

"Esta semana va a ser jodida."

"Sí."

No hay más que decir.

- **OPCIÓN:** Preguntarle si quiere ir al bar
- **OPCIÓN:** Irte


## JUAN_INVITAR_BAR


"Che, Juan. ¿Vamos a tomar algo?"


{ultima_tirada >= 3:
"Dale. Una cerveza no viene mal."
- else:
"No puedo, tengo cosas. Otro día."
"Dale. Otro día."
Se va.
}


## JUAN_BAR



Van al bar de la esquina.
Dos cervezas.


"¿Vos qué harías si te echan?", pregunta Juan.

- **OPCIÓN:** "No sé. Buscar otra cosa."
"A veces siento que estoy corriendo en una cinta, uruguayo. Mis viejos se rompieron el lomo para sacarme del barrio, para que yo fuera 'alguien'. Y acá estoy, facturando como si fuera un empresario mientras rezo que no me corten la luz. Si nos echan, volvemos al mismo barro del que ellos quisieron sacarnos."

Se quedan en silencio.
La cerveza está fría, pero el miedo calienta el aire.
- **OPCIÓN:** "Tengo algo de ahorros. Aguantaría unos meses."
"Yo no. Si me echan, cago fuego."
"Algo aparece, Juan."
"Ojalá."
- **OPCIÓN:** "Hay otros laburos. Hay otras cosas."
Juan te mira.
"¿Cómo qué?"
"No sé. Pero el mundo no se acaba."
No suena convincente. Pero es algo.


## JUAN_BAR_FIN


Terminan las cervezas.
Se despiden.

"Nos vemos mañana."
"Nos vemos."





## JUAN_PREGUNTAR_SOBRE_JEFE


"Che, Juan. ¿Viste cómo me miró el jefe?"

"Sí. Raro."

"¿Qué onda?"

"No sé. Pero a Martínez lo miró así el jueves antes de que lo citaran."

Eso no ayuda.





## JUAN_ENTERARSE_DESPIDO



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

- else:
Juan te manda un mensaje.
"Me enteré. Qué bajón."
No respondés.
}



## JUAN_DESPUES_DESPIDO


{dia_actual <= 5:
Llamás a Juan.


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
- else:
No contesta.
Debe estar laburando.
Obvio.
}
}

{dia_actual > 5:
Pensás en llamar a Juan.
Pero... ¿para qué?
Ya no comparten nada.
Solo compartían el laburo.

}



## JUAN_FRAGMENTO_NOCHE


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




## JUAN_RECUERDO_MARCHAS



Están hablando de la situación laboral.
Juan está más callado que de costumbre.

De pronto dice:

"Mi viejo me llevaba a las marchas."

"¿Qué marchas?"

- **OPCIÓN:** ...
-

"Del PIT-CNT. Cuando era chico. Cinco, seis años. Me ponía arriba de los hombros para que viera."

"No sabía."

"No lo cuento nunca."

- **OPCIÓN:** ...
-

Pausa larga.

"No sé por qué me acordé recién. Hace años que no pienso en eso."

"¿Y por qué dejaste de ir?"

- **OPCIÓN:** ...
-

"No sé. Crecí. Empecé a laburar. El viejo se jubiló, se volvió amargo. Ya no hablamos de política."

"¿Y vos?"

"Yo... no sé. Supongo que me dio miedo terminar como él. Toda la vida peleando y al final solo, en un monoambiente, viendo las noticias para putearse."

- **OPCIÓN:** ...
-

Silencio.

"A veces sueño con esas marchas. Con el ruido. Con mi viejo joven. Y me despierto confundido."




## JUAN_SOBRE_LAURA



"¿Cómo está Laura?"

Juan suspira.

"Bien. Ella siempre está bien. Es más tranquila que yo."

- **OPCIÓN:** ...
-

"A veces me dice: 'Dejá de ver tantas noticias que te hacés mala sangre'. Tiene razón. Pero no puedo parar."

"¿Por qué?"

"Porque si no miro, siento que algo me va a agarrar desprevenido. Que me van a cagar y no me voy a dar cuenta."

- **OPCIÓN:** ...
-

"Ella quiere tener hijos. Yo le digo que 'todavía no estamos listos económicamente'. Pero la verdad es que tengo miedo."

"¿De qué?"

"De traer un guri a este quilombo. De no poder darle nada. De terminar como mi viejo: prometiendo cosas que no podés cumplir."

- **OPCIÓN:** ...
-

Pausa.

"Si me echan del laburo, ¿qué le digo? '¿Perdón, amor, se me terminó el curro y ahora somos pobres'?"

"No sos pobre, Juan."

"Todavía no."




## JUAN_FASCINADO_DIEGO


Están en la olla. Diego cuenta una historia.
Juan lo escucha con la boca abierta.

"Hermano, eso es de película. Las cooperativas, el camión quemado, la huida..."

Diego se encoge de hombros.

"Es mi vida, no más."

- **OPCIÓN:** ...
-

Después, cuando Diego se va, Juan te dice:

"Ese tipo vivió más en veintiocho años que yo en treinta y dos."

"¿Te parece?"

- **OPCIÓN:** ...
-

"A mí nunca me pasó nada. Nunca tuve que huir de nada. Nunca arriesgué nada."

"Eso no es malo."

"No sé. A veces siento que mi vida es... gris. Chica. Sin épica."

- **OPCIÓN:** ...
-

Pausa.

"Y después viene uno como Diego, que perdió todo y sigue laburando, sigue ayudando. Y yo acá quejándome del alquiler."

No sabés qué decirle.
Pero algo se movió adentro suyo.




## JUAN_PROCESANDO



Una semana después de la charla.
Juan te manda un mensaje.

"Che, ¿podemos vernos un rato?"

- **OPCIÓN:** Aceptar

Se encuentran.
Juan trae café.

"Estuve pensando en lo que dijo Diego el otro día."

"¿Qué cosa?"

- **OPCIÓN:** ...
-

"Eso de que el problema no es el inmigrante, es el empresario que nos explota a los dos."

"¿Y qué pensás?"

- **OPCIÓN:** ...
-

Juan toma café. Piensa.

"Creo que tiene razón. O sea... yo siempre repetía lo que escuchaba en las noticias. 'Vienen a sacarnos el laburo'. Pero Diego labura el doble que yo y le pagan la mitad."

- **OPCIÓN:** ...
-

"Y el que nos paga poco a los dos es el mismo. No es Diego. Es el patrón."

Pausa larga.

"No sé. Capaz que soy un boludo y recién estoy entendiendo cosas que todo el mundo sabe."

"No sos boludo. Estás pensando. Eso ya es algo."


- **OPCIÓN:** No poder
"No puedo ahora, Juan. Después."
"Dale."

No sabés qué quería decirte.
Pero algo le quedó dando vueltas.


## JUAN_SOBRE_MIEDO



"¿Sabés qué me pasa?"

"¿Qué?"

"Que tengo miedo de todo. De perder el laburo, de que me roben, de que las cosas se vayan al carajo. Y el miedo me hace decir cosas que después me arrepiento."

- **OPCIÓN:** ...
-

"Como lo del 'acá falta autoridad'. O lo de 'los que vienen de afuera'. Cosas que repito sin pensar."

"¿Y por qué las decís?"

"Porque si le echo la culpa a alguien, me siento menos en banda. Como si supiera qué está pasando."


{ resultado_juan_miedo == 2:
}
{ resultado_juan_miedo == 1:
}
{ resultado_juan_miedo == 0:
}


### juan_miedo_critico

- **OPCIÓN:** ...
-

Silencio.

"Pero la verdad es que no sé nada. Solo tengo miedo y repito lo que dicen en la tele."

"Eso ya es darse cuenta de algo."

Juan te mira. Y por primera vez, dice algo que no esperabas:

"¿Sabés qué? Creo que mi viejo decía las mismas cosas. En las marchas, el enemigo era claro. Ahora todo es confuso. Y en la confusión, repetimos lo primero que escuchamos."

"Pero estás dejando de repetir."

"Sí. Capaz que sí."



### juan_miedo_exito

- **OPCIÓN:** ...
-

Silencio.

"Pero la verdad es que no sé nada. Solo tengo miedo y repito lo que dicen en la tele."

"Eso ya es darse cuenta de algo."

"Sí. Pero darse cuenta no alcanza. Hay que hacer algo. Y no sé qué."



### juan_miedo_fallo

- **OPCIÓN:** ...
-

Juan se queda callado.

"La verdad es que no sé nada."

No sabés qué decirle. El miedo es contagioso.
Y vos también tenés el tuyo.

"Somos dos boludos con miedo."

Se ríe. Vos también.
No resuelve nada. Pero alivia.



### juan_miedo_crit_fallo

- **OPCIÓN:** ...
-

Juan se pone más nervioso.

"¿Ves? Ni vos sabés qué decir. Nadie sabe."

El miedo se multiplica. Hablaron del tema y quedaron peor.
A veces abrir la caja de Pandora no ayuda.

"Mejor dejemos de hablar de esto."




## JUAN_LLAMADO_VIERNES


El teléfono vibra.
Juan.

"Che, ¿estás? ¿Podemos vernos un rato?"

- **OPCIÓN:** "Sí, dale. ¿Dónde?"
"En el bar de la otra vez. Media hora."
- **OPCIÓN:** "No puedo ahora."
"Dale, entiendo. Otro día."
Cortás.
Algo en su voz te quedó.


## JUAN_ENCUENTRO_VIERNES



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
- else:
}


## JUAN_NOTICIA_BUENA


Juan respira.

"Sí. Mirá, te quería contar algo."

Toma un trago.

- **OPCIÓN:** ...
-

"Mi cuñado tiene un taller. Arregla electrodomésticos, esas cosas."

"¿Y?"

"Necesita alguien. No es fijo, son changas. Pero paga."

- **OPCIÓN:** ...
-

Te mira.

"Pensé en vos. Si te interesa, le digo."

- **OPCIÓN:** "Sí, pasale mi número."
"Dale, le digo. Capaz te llama la semana que viene."

No es un laburo.
Es una posibilidad.
Pero viniendo de Juan, significa algo.

"Gracias, Juan."
"Para eso estamos."

- **OPCIÓN:** "Dejame pensarlo."
"Dale, sin presión. Avisame."

No sabés si querés eso.
Pero que Juan haya pensado en vos...


- **OPCIÓN:** "No, gracias. Voy a buscar otra cosa."
"Como quieras."

Juan parece un poco dolido.
Pero entiende.



## JUAN_NOTICIA_MALA



Juan no te mira.
Toma un trago largo.

"A mí también me echaron."

Silencio.

- **OPCIÓN:** ...
-

"¿Cuándo?"

"Ayer. Mismo discurso. Reestructuración."

Unipersonal también.
Sin nada.
Como vos.

- **OPCIÓN:** ...
-

"La puta madre, Juan."

"Sí."

Se queda mirando la cerveza.

"Tres años. Facturando como si fuera mi propio jefe, mientras ellos ponían las reglas y se llevaban la tajada. Me vendieron la del emprendedor y me compraron como insumo."

- **OPCIÓN:** "No sos pelotudo. Nos cagaron a todos."

"Es el sistema, Juan. Así funciona."

"Ya sé. Pero igual duele."

Toman en silencio.
Dos tipos sin laburo.
Pero juntos en esto.


- **OPCIÓN:** "¿Y ahora qué vas a hacer?"

"No sé. Buscar. Lo que sea."

"Si escucho algo, te aviso."

"Gracias."

Es raro.
Antes él era el que tenía todo armado.
Ahora están igual.


- **OPCIÓN:** Quedarte callado

No sabés qué decir.
¿Qué se dice?

Toman en silencio.



## JUAN_ENCUENTRO_FIN


Terminan las cervezas.
No piden otra.

"Bueno. Nos vemos."

"Nos vemos, Juan."

Se dan un abrazo torpe.
De esos que no se daban antes.

{juan_relacion >= 4:
}

Volvés a casa.
Con algo más.
O algo menos.
Depende cómo lo mires.




## JUAN_ENCUENTRO_JUEVES



Te suena el celular. Es Juan.

"Che, ¿estás bien? Me enteré de lo del laburo."

- **OPCIÓN:** "Sí, ahí ando."
"No me vendas humo. ¿Necesitás algo?"
- **OPCIÓN:** "¿Cómo te enteraste?"
"El laburo es chico, se sabe todo."
- **OPCIÓN:** No contestar
Dejás sonar. No es el momento.


## JUAN_CHARLA_VIERNES



{juan_sabe_mi_situacion:
Juan te manda un mensaje:
"Tengo un contacto que busca gente. No es gran cosa pero es algo. ¿Querés que le pase tu número?"

- **OPCIÓN:** "Dale, pasale."
"Listo. Te aviso si me dice algo."
- **OPCIÓN:** "Dejá, ya veo."
"Bueno, pero si cambiás de idea avisame."
- else:
Juan te manda un mensaje genérico del grupo del laburo.
No sabés si decirle lo que pasó.
}


## JUAN_INVITAR_OLLA_SABADO



{ayude_en_olla && juan_sabe_mi_situacion:
"Che Juan, hay una olla popular en el barrio. ¿Querés venir?"

- **OPCIÓN:** "Hay buena gente."
Juan duda.
"¿Olla popular? No sé..."
"Vení una vez. Si no te copa, no venís más."
"Bueno. Dale."
- **OPCIÓN:** No insistir
"Ta, dejá. Era una idea."
- else:
No tiene sentido invitarlo todavía.
}


## FRAGMENTO_JUAN_NOCHE


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




## FRAGMENTO_JUAN_CENA

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



## FRAGMENTO_JUAN_CURRICULUM

Juan actualiza su currículum.

Por las dudas.
Siempre por las dudas.

Después de lo que te pasó a vos...
Mejor tener todo listo.

"Experiencia laboral: 8 años en el mismo puesto."
"Habilidades: Excel, Word, aguantar."

Cierra la compu. Mañana hay que ir.
Mientras haya donde ir.





## SOFIA_ENCUENTRO_CASUAL


Sofía sale del almacén con dos bolsas pesadas.
Madre soltera. Dos hijos: Nico y Lupe.
Organiza la olla popular desde hace dos años.

Tiene ojeras. Siempre tiene ojeras.

- **OPCIÓN:** Saludar
- **OPCIÓN:** Ofrecerte a ayudar con las bolsas
- **OPCIÓN:** Seguir de largo


## SOFIA_SALUDO


"Hola, Sofía."

Te mira. Una sonrisa cansada.

"Hola. ¿Cómo andás?"

{sofia_sabe_mi_situacion:
No esperás la pregunta de siempre.
Ella sabe. No pregunta.
"Ahí vamos."
"Ahí vamos todos."
- else:
"Bien. ¿Y vos?"
"En la lucha."
}

Sigue caminando. No tiene tiempo.
Nadie tiene tiempo.



## SOFIA_AYUDAR_BOLSAS


"Dejame ayudarte."

Agarrás una bolsa. Pesa.
Papas, fideos, aceite.

"Gracias. Las piernas ya no me dan."


Caminan juntos hacia el salón comunal.

"¿Para cuántos cocinan hoy?"

"Sesenta y pico. Cada semana son más."

Sesenta personas que dependen de esto.
De ella.

"¿Y la plata alcanza?"

Se ríe. Sin gracia.

"Nunca alcanza. Pero se estira."



## SOFIA_IGNORAR


Seguís de largo.
Ella ni se da cuenta.
Tiene demasiado en la cabeza.




## SOFIA_EN_OLLA


El salón comunal huele a guiso.
Sofía revuelve una olla enorme.

Hay voluntarios. Pocos.
Elena pela papas. Nadie más.

"¿Necesitás ayuda?"

Sofía te mira. Evalúa.

- **OPCIÓN:** "Puedo pelar, cortar, lo que sea."
- **OPCIÓN:** "Solo pasaba a saludar."


## SOFIA_ACEPTAR_AYUDA



"Agarrá un cuchillo. Las zanahorias."

Trabajás en silencio.
El ruido de los cuchillos, el burbujeo de la olla.
Un ritmo.


{ resultado_sofia_olla_fisico == 2:
Las manos se mueven solas. Encontrás el ritmo de la cocina.
Sofía te mira de reojo. Impresionada.
"Tenés mano para esto."
}
{ resultado_sofia_olla_fisico == 1:
Cortás, pelás, revolvés. El cuerpo responde.
No es elegante, pero es trabajo honesto.
}
{ resultado_sofia_olla_fisico == 0:
Te cansás rápido. Las manos no rinden.
Sofía no dice nada. Pero te pasa las tareas más livianas.
"Andá separando los platos."
}
{ resultado_sofia_olla_fisico == -1:
Se te resbala el cuchillo. Casi te cortás.
"¡Cuidado!" Sofía te frena la mano.
"Despacio. La olla no tiene apuro."
Te tiemblan las manos. El cuerpo no da más.
}

- **OPCIÓN:** ...
-

Sofía habla mientras revuelve.

"Mi vieja ya revolvía esta misma olla en el 2002. Ella me enseñó que cuando el Estado se retira, el barrio tiene que avanzar. Vi los 'Centros Sociales' que prometieron volverse cáscaras vacías, llenas de carteles pero sin comida. Nosotros no tenemos carteles, pero tenemos fuego."

"¿Es agotador, no?"

"Agotador es esperar que alguien te salve. Cocinar es resistencia."


- **OPCIÓN:** ...
-

Llegan los primeros. Viejos, niños, familias enteras.
Caras conocidas del barrio.

Sofía sirve. Una sonrisa para cada uno.
Aunque esté muerta de cansancio.



## SOFIA_SOLO_SALUDAR


"Ah. Bueno."

No hay reproche en su voz.
Solo cansancio.

"Cualquier cosa, acá estamos."

Volvés a la calle.
La olla sigue hirviendo.




## SOFIA_CONVERSACION_PROFUNDA



Es de noche. La olla terminó.
Sofía limpia. Sola.

"¿Te ayudo?"

"Ya casi termino."

- **OPCIÓN:** ...
-

Pero aceptás un trapo igual.
Secan los platos juntos.

"¿Por qué hacés esto, Sofía?"

Se detiene. Piensa.

"Porque alguien tiene que hacerlo."

"Podrías no hacerlo. Cuidar a tus hijos y ya."

"Mis hijos comen de acá también."

Silencio.

"Cuando llegué al barrio, no tenía nada. Un bolso y los gurises.
Pero acá no me dieron limosna. Me dieron un lugar."

- **OPCIÓN:** ...
-

"¿Y ahora vos salvás a otros?"

"No sé si salvo a nadie. Pero intento que nadie tenga que
pasar lo que pasé yo."


- **OPCIÓN:** "Sos muy fuerte."
- **OPCIÓN:** "¿No te cansás?"
- **OPCIÓN:** "¿Qué pasó cuando llegaste?"


## SOFIA_RESPUESTA_FUERTE


"No soy fuerte. Estoy cansada todo el tiempo.
Pero no tengo opción."

- **OPCIÓN:** ...
-

Sigue secando.

"Los gurises dependen de mí. El barrio depende de esto.
Si yo paro, ¿quién sigue?"

No tiene respuesta. Nadie la tiene.



## SOFIA_RESPUESTA_CANSANCIO


"Todos los días."

Te mira. Ojos rojos.

"A veces quiero irme. Dejarlo todo.
Pero ¿adónde? ¿Con qué?"

"No tenés que hacerlo sola."

"No estoy sola. Pero a veces se siente así."




## SOFIA_HISTORIA


"El padre de los gurises se fue. De un día para otro.
Me dejó con la ropa que teníamos puesta y deudas."

Aprieta el trapo.

- **OPCIÓN:** ...
-

"Llegué al barrio porque una prima me prestó una pieza.
No conocía a nadie. No tenía trabajo."

"¿Y la olla?"

- **OPCIÓN:** ...
-

"Elena me vio en la plaza. Yo estaba sentada, calculando cuánto me duraba la leche.
Se acercó y me dijo: 'Si tenés manos, servís'. Me trajo acá. Me dio un cuchillo."

Pausa.

"Ese día comimos. Pero lo importante fue que ese día cociné.
Dejé de esperar y empecé a hacer."





## SOFIA_SOBRE_MADRE



Es de noche. La olla está vacía.
Sofía mira la imagen de la Virgen de Guadalupe en la pared.

"La puso mi vieja. La Chola."

- **OPCIÓN:** ...
-

"Ella empezó todo esto. En los 90. Dando merienda a los gurises en su casa. De a poco fue creciendo."

"¿Y vos?"

"Yo me fui. Conseguí beca, estudié afuera. Era la 'chica brillante' del barrio. La que 'salió'."

- **OPCIÓN:** ...
-

Pausa. Sofía mira la imagen de la Virgen.

"Cuando mi vieja se enfermó, vine a 'ayudar seis meses'. Nunca volví a España."

"¿Por qué?"

- **OPCIÓN:** ...
-

"Porque ella me tomó la mano en el hospital y me dijo: 'La olla no se apaga'. Y después me dijo otra cosa."

"¿Qué?"

"'No seas boluda, Sofía. La olla sos vos ahora. Pero no sola. Nunca sola'."

- **OPCIÓN:** ...
-

Se le humedecen los ojos. No llora. Ya no llora por esto.

"Se murió tres semanas después. Y yo me quedé."




## SOFIA_OFERTA_ALEMANIA



"¿Sabés qué me llegó hace unos meses?"

"¿Qué?"

"Un mail de mi ex director de tesis. Una beca postdoctoral en Heidelberg. Alemania. Condiciones excelentes."

- **OPCIÓN:** ...
-

"¿En serio? ¿Y qué hiciste?"

"Le respondí que no en una semana."

"¿Por qué?"

- **OPCIÓN:** ...
-

Sofía se ríe. Pero no es una risa alegre.

"Porque si me iba ahora, mi vieja me tiraba el mate desde el cielo."

- **OPCIÓN:** ...
-

Pausa.

"A veces, en los congresos, veo a compañeros que siguieron la carrera 'en serio'. Publicando papers, viajando a conferencias. Y siento un poco de envidia."

"Es normal."

"Sí. Pero después me acuerdo de la risa de los gurises cuando hay postre en la olla. Y se me pasa."

- **OPCIÓN:** ...
-

Hace una pausa más larga.

"Casi siempre se me pasa."




## SOFIA_MARTIN_PAPAS



"¿Te conté de Martín?"

"¿Quién es Martín?"

"Un compañero del laboratorio. Especialista en química de alimentos."

- **OPCIÓN:** ...
-

"Un invierno vino a la olla. 'A ver de qué se trata', dijo."

"¿Y?"

"Terminó pelando papas tres horas. Torpemente. Se manchó el jean entero."

- **OPCIÓN:** ...
-

Sofía se ríe. Esta vez de verdad.

"En un momento dijo: 'Esto es más difícil que una cromatografía'. Y yo me reí por primera vez en semanas."

- **OPCIÓN:** ...
-

"Ahora viene una vez por mes, cuando puede. No es mucho, pero ayuda."

"¿Y en la universidad no te miran raro por la olla?"

- **OPCIÓN:** ...
-

"Al principio sí. '¿Olla popular? ¿Como en 2002?'. Pero con el tiempo varios entendieron."

Pausa.

"No es doble vida. Es vida integrada. Mis papers y mis papas."




## SOFIA_CATOLICISMO


Notás la estampita de la Virgen de Guadalupe en el delantal de Sofía.

"¿Sos católica?"

"Sí. Como la Chola. No soy de ir a misa todos los domingos, pero rezo a veces."

- **OPCIÓN:** ...
-

"Por eso les puse esos nombres a mis hijos. Nicolás y Guadalupe. Por ella."

Señala la imagen en la pared.

"Mi vieja la trajo de México cuando era joven. Decía que la Virgen de Guadalupe entiende a los pobres porque se apareció morena, hablándole a un indio."

- **OPCIÓN:** ...
-

"No es una fe de discurso. Es una base silenciosa. Cuando no sé qué hacer, rezo. Y después sigo haciendo."

"¿Y funciona?"

"No sé si funciona. Pero me calma."




## SOFIA_DELANTAL_MADRE


Notás que Sofía siempre usa el mismo delantal.
Viejo, manchado, remendado.

"Ese delantal..."

"Era de mi vieja."

- **OPCIÓN:** ...
-

"No lo lavo. Bueno, lo lavo un poco. Pero no le saco las manchas viejas."

"¿Por qué?"

"Porque son sus manchas. Sus horas de cocina. Su trabajo."

- **OPCIÓN:** ...
-

Se lo toca.

"A veces, cuando estoy muy quemada, me lo aprieto contra el pecho. Como si ella pudiera abrazarme."

No dice más.
No hace falta.





## SOFIA_PIDE_AYUDA



Sofía te busca. Cosa rara.

"Che. Necesito pedirte algo."

"¿Qué pasa?"

- **OPCIÓN:** ...
-

"La olla. No nos da. Tenemos deudas con el almacén.
Si no pagamos, no nos fían más."

"¿Cuánto es?"

"Tres mil pesos. Para ayer."

- **OPCIÓN:** ...
-

Tres mil pesos.
No los tenés. O sí, pero son para el alquiler.

- **OPCIÓN:** Ofrecer ayudar a conseguir donaciones
- **OPCIÓN:** Dar lo que tenés
- **OPCIÓN:** Decir que no podés


## SOFIA_AYUDA_DONACIONES


"Plata no tengo. Pero puedo ayudar a conseguir."

"¿Cómo?"

"No sé. Golpear puertas. Hablar con comercios.
Algo se me ocurre."

Sofía te mira. Evaluando.


{ resultado_sofia_persuadir == 2:
Sofía te mira distinto. Algo en tu voz la convenció.
"Sabés qué, sí. Necesito alguien que me ayude a hablar con los comercios de la zona. Tengo una lista."
Te pasa un papel arrugado. Nombres, direcciones.
"Juntos capaz que los convencemos."
}
{ resultado_sofia_persuadir == 1:
"Dale. Cualquier cosa sirve."
}
{ resultado_sofia_persuadir == 0:
"Mirá... no es por desconfiar. Pero ya vinieron otros con eso y después no aparecieron."
"Yo voy a aparecer."
"Bueno. Veremos."
No te cierra la puerta. Pero tampoco la abre del todo.
}
{ resultado_sofia_persuadir == -1:
"Mirá, te agradezco. Pero la verdad... no te conozco tanto."
El rechazo duele. Pero Sofía no puede darse el lujo de confiar en cualquiera.
Tiene sesenta bocas que dependen de ella.
}



## SOFIA_DAR_PLATA


Le das lo que tenés.
No son tres mil. Pero es algo.

"No puedo aceptar esto."

"Aceptalo. Después veo cómo hago."

- **OPCIÓN:** ...
-


Sofía no dice gracias.
Te abraza.
Fuerte.



## SOFIA_NO_PUEDO


"No puedo, Sofía. Lo siento."

"Está bien. Entiendo."

No hay reproche. Solo resignación.
Ella sabe lo que es no poder.





## SOFIA_PRIMER_ENCUENTRO


Sofía te ve.

{conte_a_alguien && vinculo == "sofia":
"Viniste."
No es pregunta. Es confirmación.
- else:
"¿Qué hacés acá a esta hora?"
}



## SOFIA_INVITAR_AYUDAR


"Si querés ayudar, sobran cosas para hacer."

No es obligación.
Es invitación.



## SOFIA_AGRADECIMIENTO


"Gracias", dice Sofía.
"Mañana si podés..."

Deja la frase ahí.
No es obligación. Es invitación.



## SOFIA_REUNION_CRISIS


Sofía está hablando con otros.
La discusión es intensa pero en voz baja.

"No tenemos para hoy."
"Algo hay que hacer."
"¿Pedimos prestado?"
"¿A quién?"



## SOFIA_PEDIR_IDEAS


Sofía te hace una seña para que te acerques.
"Justo vos. Necesitamos ideas."




## SOFIA_LLAMAR


Llamás a Sofía.

"Hola."

"Hola. ¿Cómo estás?"

"Cansada. Pero bien. ¿Vos?"

"Igual. Cansado pero... no sé. Distinto."



## SOFIA_CONVERSACION_TELEFONO


Hablan un rato.
De la olla.
De la semana.
De vos.

"Gracias por ayudar esta semana. De verdad."

"Gracias por dejarme ayudar."




## SOFIA_FRAGMENTO_PENSAR


Piensa en pedir prestado.
Piensa en golpear puertas.
Piensa en cerrar.

No puede cerrar.
Hay gente que depende de esto.

{ayude_en_olla:
Piensa en vos.
En que viniste a ayudar.
En que quizás no está sola.
}



## SOFIA_FRAGMENTO_ASAMBLEA


Sofía cierra la olla.

La asamblea fue bien.
Mejor de lo esperado.

Hay gente nueva.
Gente que quiere ayudar.
Vos.

No es solución.
Pero es algo.




## SOFIA_FRAGMENTO_NOCHE


Sofía mira a sus hijos dormir.
Nico y Lupe, dos cuerpos en un colchón y medio.

Lupe tiene tos.
Otra vez.
No hay plata para el médico.

{sofia_hijos_enfermos:
Mañana va a tener que elegir.
Remedios o comida.
Siempre eligiendo.
}

Piensa en la olla.
En las sesenta bocas.
En el almacén que no les quiere fiar.

¿Cuánto más puede seguir?

Se acuesta. El colchón es duro.

Cierra los ojos.

{sofia_estado == "agotada":
No puede dormir.
Las cuentas dan vueltas en su cabeza.
Los números nunca cierran.
}

{ayude_en_olla:
Piensa en vos.
Al menos hoy hubo una mano más.
Al menos hoy no estuvo tan sola.
}

A las seis suena el despertador.
Otra vez.
Siempre otra vez.




## FRAGMENTO_SOFIA_COCINA

Sofía lava los platos de la olla.
Sola. Los pibes duermen.

El agua corre. Las manos le duelen.
Pero la cocina queda limpia.

{sofia_relacion >= 3:
Piensa en vos.
"Ojalá venga mañana", murmura.
}

Mañana hay que cocinar de vuelta.
Siempre hay que cocinar de vuelta.



## FRAGMENTO_SOFIA_PIBES

Los pibes de Sofía duermen.
Ella los mira desde la puerta.

El grande tiene un examen mañana.
El chico tose.

{olla_en_crisis:
Si la olla cierra, no sabe qué van a comer.
No lo dice. No hace falta.
Los pibes no necesitan saber que el mundo se tambalea.
}

Les acomoda las frazadas.
Se acuesta sin cenar.



## FRAGMENTO_SOFIA_ASAMBLEA

{participe_asamblea:
Sofía repasa la lista de la asamblea.
Quién dijo qué. Quién se comprometió.
Quién no vino.

{sofia_relacion >= 4:
Tu nombre está en la lista de los que vinieron.
Sonríe.
}

Mañana hay que hacer lo que se dijo.
No el lunes. Mañana.
- else:
Sofía mira la lista vacía de voluntarios.
Suspira.

"¿Para qué hago asambleas si nadie viene?"
}





## ELENA_CONVERSACION




Elena está sentada en el banco de la plaza.
Siempre el mismo banco. Siempre la misma hora.

{elena_relacion == 0:
Setenta y pico. Llegó al barrio antes que todos.
Vio todo. Recuerda todo.
Mira pasar a la gente como quien lee un libro viejo.
}

- **OPCIÓN:** Sentarte a su lado
- **OPCIÓN:** Saludar de lejos
- **OPCIÓN:** Pasar de largo


## ELENA_MENU_TEMAS


Te sentás a su lado.
{elena_relacion > 2:
"¿Cómo andás, m'hijo?"
Su voz es ronca pero amable.
- else:
No dice nada. No hace falta.
}

- (opts)
- **OPCIÓN:** Charlar del día a día
- **OPCIÓN:** Preguntar sobre el barrio
- **OPCIÓN:** {elena_relacion >= 3} [Hablar de cosas serias] -> elena_menu_profundo
- **OPCIÓN:** {elena_relacion >= 4} [Preguntar por la olla] -> elena_sobre_olla
- **OPCIÓN:** Me tengo que ir
"Andá, andá. Que no se te haga tarde."


## ELENA_CHARLA_COTIDIANA

"Ahí andamos todos."

Mira hacia la calle.
"¿Sabés cuántas veces escuché eso? 'Ahí ando'.
En el 2002 todo el mundo andaba 'ahí'."


## ELENA_MENU_HISTORIA

- **OPCIÓN:** Sobre el 2002
- **OPCIÓN:** Sobre el trueque
- **OPCIÓN:** Sobre el banco
- **OPCIÓN:** Sobre los García
- **OPCIÓN:** Volver


## ELENA_MENU_PROFUNDO

- **OPCIÓN:** Sobre la Chola
- **OPCIÓN:** Sobre política
- **OPCIÓN:** Volver


## ELENA_SOBRE_OLLA

- **OPCIÓN:** La historia de la fundación
- **OPCIÓN:** Volver


## ELENA_SENTARSE


Te sentás a su lado.
No dice nada. No hace falta.

El sol de la tarde. Los gurises jugando.
Un momento de paz en el quilombo.

"¿Cómo andás, m'hijo?"

Su voz es ronca. Años de café fuerte y cigarros.

- **OPCIÓN:** "Ahí ando, Elena."
- **OPCIÓN:** "Mal. Todo mal."
- **OPCIÓN:** "¿Y vos, Elena?"


## ELENA_AHI_ANDO


"Ahí andamos todos."


Mira hacia la calle.

"¿Sabés cuántas veces escuché eso? 'Ahí ando'.
En el 2002 todo el mundo andaba 'ahí'.
Pero seguíamos."

- **OPCIÓN:** ...
-


Silencio.
El silencio de Elena nunca es incómodo.



## ELENA_TODO_MAL



"Mal es relativo, m'hijo."

Te mira. Ojos que vieron demasiado.

"¿Tenés techo? ¿Comiste hoy?"

"Sí."

"Entonces no está todo mal. Está jodido, pero no todo mal."

Tiene razón. O no.
Pero su certeza ayuda.




## ELENA_ELLA_COMO


"Vieja. Cada día más vieja."

Se ríe.

"Pero acá sigo. Como el banco este. Como el barrio."

Pausa.

"Mientras pueda caminar hasta acá, voy a venir.
El día que no venga, preocupate."



## ELENA_SALUDO_LEJOS


Levantás la mano.
Ella asiente.

Un saludo de barrio.
Sin palabras. Sin necesidad.



## ELENA_IGNORAR


Pasás de largo.
Ella ni se inmuta.

Ha visto gente pasar toda su vida.
Una persona más no cambia nada.




## ELENA_EN_OLLA


Elena pela papas.
Las manos arrugadas, pero firmes.
Años de práctica.

"Vení, sentate. Agarrá un cuchillo."

No es una pregunta.


Pelás papas en silencio.
Ella habla cuando quiere. Nunca antes.

"¿Sabés quién empezó esta olla?"

- **OPCIÓN:** "¿Usted?"
- **OPCIÓN:** "No."
- **OPCIÓN:** Seguir pelando en silencio


## ELENA_HISTORIA_OLLA



"Yo y otras tres. En el 2002."

Sigue pelando. No mira.

- **OPCIÓN:** ...
-

"No teníamos nada. Pero teníamos bronca y teníamos manos.
Cocinábamos en la calle para que nos vieran. Para que supieran que no nos íbamos a morir en silencio."

"¿Cuántos venían?"

- **OPCIÓN:** ...
-

"Al principio, veinte. Después cien. Después doscientos."

Pausa.

"Cuando el país se cae, la gente se junta.
Es lo único que tenemos."




## ELENA_SILENCIO


El silencio se estira.
No incómodo. Compartido.

Las papas se acumulan.
El trabajo sigue.




## ELENA_CONVERSACION_PROFUNDA



La casa de Elena es chica.
Fotos en las paredes. Gente que ya no está.

"Sentate. Voy a hacer café en la prensa francesa."

- **OPCIÓN:** ...
-

No aceptás un no.
Los viejos del barrio no aceptan un no.

El café llega. Negro. Fuerte.

"¿Qué te pasa, m'hijo? Te veo raro."

- **OPCIÓN:** Contarle tu situación
- **OPCIÓN:** "Nada. Solo quería visitarla."
- **OPCIÓN:** Preguntarle sobre el 2002


## ELENA_ESCUCHA


Le contás. Todo.
El laburo. La plata. El miedo.

Ella escucha. No interrumpe.
Cuando terminás, toma café. Piensa.


{ resultado_elena_abrir == 2:
}
{ resultado_elena_abrir == 1:
}
{ resultado_elena_abrir == 0:
}


### elena_escucha_critico

- **OPCIÓN:** ...
-

Elena deja la taza. Te mira con ojos que vieron demasiado.

"¿Sabés qué aprendí en setenta años?"

"¿Qué?"

"Que nadie se salva solo. Lo aprendí a los golpes.
Cuando el barco se hunde, o armamos una balsa entre todos o nos ahogamos por separado."

- **OPCIÓN:** ...
-

Hace una pausa larga. Algo se abre en ella.

"Raúl pasó lo mismo que vos. Exactamente. Lo echaron del frigorífico un martes. Llegó a casa blanco. No habló en tres días."

"¿Qué hicieron?"

"Lo que vamos a hacer con vos. Sostenerlo. Un día a la vez."


"Y vení a la olla. Siempre hay un plato."


### elena_escucha_exito

- **OPCIÓN:** ...
-

"¿Sabés qué aprendí en setenta años?"

"¿Qué?"

"Que nadie se salva solo. Lo aprendí a los golpes.
Cuando el barco se hunde, o armamos una balsa entre todos o nos ahogamos por separado."

- **OPCIÓN:** ...
-

"¿Y qué hago?"

"Lo que puedas. Un día a la vez.
No pensés en mañana. Pensá en hoy."


"Y vení a la olla. Siempre hay un plato."


### elena_escucha_fallo

- **OPCIÓN:** ...
-

Elena asiente. Despacio.

"Es jodido. Lo sé."

No dice mucho más. Toma café.
El silencio se estira.

"Vení a la olla si querés. Siempre hay un plato."

No se abrió del todo. Pero la puerta quedó entreabierta.



### elena_escucha_crit_fallo

- **OPCIÓN:** ...
-

Elena se queda callada. Demasiado callada.

"M'hijo... todos tenemos problemas."

Algo se cerró. Quizás no era el momento.
Quizás hablar de tus problemas le trajo fantasmas de los suyos.

Toman café en un silencio incómodo.

"Disculpá. Estoy cansada hoy."


## ELENA_NO_CUENTA


"Mentira. Pero está bien. Cuando quieras hablar, acá estoy."

Toman café.
No hace falta hablar.
A veces la compañía alcanza.




## ELENA_SOBRE_2002



"El 2002. La crisis."

Suspira. Los ojos se van lejos.

- **OPCIÓN:** ...
-

"Fue peor que esto. Mucho peor.
La gente no tenía para comer. Literal.
Los bancos cerrados. Todo cerrado."

"¿Cómo sobrevivieron?"

"Organizándonos. No esperando.
Entendiendo que la vergüenza es de ellos, no nuestra."

- **OPCIÓN:** ...
-

Toma café.

"Las ollas no eran caridad. Eran trincheras.
El trueque, las asambleas... eran formas de decir 'acá estamos y no nos vamos'."

"¿Y después?"

"Después volvió todo. El país se acomodó para los que siempre están bien. Los políticos se votaron sus propios aumentos y nos dijeron que la 'crisis había pasado'. Pero la crisis no pasa para el que perdió la casa o el que se le rompió la familia. Nosotros nos quedamos acá, sosteniendo los pedazos que ellos tiraron por la ventana."





## ELENA_SOBRE_LA_CHOLA



"¿La Chola? ¿La mamá de Sofía?"

Elena sonríe. Es la primera vez que la ves sonreír así.

"La Chola era mi hermana. No de sangre. De vida."

- **OPCIÓN:** ...
-

"Nos conocimos en la fábrica textil del Cerro. Año 75. Yo tenía veinticinco, ella veintitrés. Turnos de diez horas cosiendo zapatos."

"¿Y?"

"Y nada. Trabajábamos, tomábamos mate, puteábamos al capataz. Pero cuando vino la dictadura, nos juntamos de verdad."

- **OPCIÓN:** ...
-

"Éramos compañeras de fábrica, de huelga, de mate y de velorio."

- **OPCIÓN:** "¿De velorio?"
"Enterramos a mucha gente juntas. Compañeros que se llevaron. Algunos que aparecieron. Otros que no."

Silencio largo.

"Pero seguíamos. Siempre seguíamos."

- **OPCIÓN:** "¿Cuarenta años juntas?"
"Más. Nos vimos envejecer. Nos vimos enterrar maridos. Nos vimos criar hijos. Y cuando ella se enfermó..."


## ELENA_CHOLA_CONT


- **OPCIÓN:** ...
-

"Cuando la Chola se enfermó, estuve con ella hasta el final. En el hospital, tomándole la mano."

"¿Qué le dijiste?"

"Que iba a cuidar la olla. Y que iba a cuidar a Sofía."

- **OPCIÓN:** ...
-

Pausa larga.

"A veces le hablo todavía. A la foto que tengo en el aparador. Le cuento cómo está la olla. Le puteo cuando las cosas no salen."

Se ríe bajito.

"Ella me escucha. Estoy segura."




## ELENA_DESALOJO_GARCIA



"¿Vos conociste a los García? Los que vivían en la esquina."

"No."

"Ya no están. Pero casi los sacan antes de tiempo."

- **OPCIÓN:** ...
-

"Fue en el 98, creo. O 97. La mujer se había quedado sin laburo, el marido estaba enfermo. Debían tres meses de alquiler."

"¿Los iban a desalojar?"

"Vino la policía con el acta. A sacarlos a la calle. Con los gurises."

- **OPCIÓN:** ...
-

Elena se toma el mate.

"Yo me enteré por la vecina de enfrente. Salí corriendo. Llamé a la Chola, a otras cuantas."

"¿Y qué hicieron?"

- **OPCIÓN:** ...
-

"Nos paramos en la puerta. Yo adelante, con el mate en la mano y la mirada de alguien que no tiene nada que perder."

"¿Y la policía?"

"El oficial me dijo: 'Señora, apártese o la llevamos'. Yo le dije: 'Llevame entonces. Pero vas a tener que llevar a todas'."

- **OPCIÓN:** ...
-

Sonríe. Una sonrisa feroz.

"Detrás mío había veinte mujeres del barrio. Y un par de tipos también, pero las que paraban la olla éramos nosotras."

"¿Funcionó?"

"El milico llamó por radio. No sé qué le dijeron. Pero se fueron. Los García se quedaron tres meses más, hasta que consiguieron otro lugar."

- **OPCIÓN:** ...
-

Pausa.

"La propiedad privada se termina donde empieza el frío de un guri. Eso no lo escribió ningún filósofo. Eso lo aprendí ese día."




## ELENA_TRUEQUE_2002



"¿Sabés lo que es el trueque?"

"Más o menos. Cambiar cosas, ¿no?"

"Cambiar lo que tenés por lo que necesitás. Sin plata. Porque la plata no servía para nada."

- **OPCIÓN:** ...
-

"En el 2002, once intendencias aceptaron trueque. Hasta pagaban impuestos con carne. ¿Te imaginás? Yendo a la intendencia con un pedazo de carne para pagar la patente."

"No me lo imagino."

- **OPCIÓN:** ...
-

"Nosotras organizamos trueque acá en el barrio. En el gimnasio de la parroquia."

"¿Cómo funcionaba?"

"Cada uno llevaba lo que tenía. Ropa vieja, herramientas, comida casera, verduras del fondo. Y cambiaba por lo que necesitaba."

- **OPCIÓN:** ...
-

Elena mira hacia la pared. La foto de su marido.

"Yo cambié la ropa de mi marido muerto por leche en polvo para los nietos de una vecina."

- **OPCIÓN:** ...
-

"Recuerdo el olor de ese gimnasio. Humedad, desesperación... y solidaridad. Todo mezclado."

"¿Funcionó?"

"Funcionó hasta que la cosa se acomodó. Después todos fingimos que no había pasado. Pero yo me acuerdo. Yo siempre me acuerdo."




## ELENA_EN_BANCO_2002



"Un día fui al Banco República a sacar mis ahorros. Cuarenta mil pesos. Todo lo que tenía."

"¿Y?"

"Me dijeron que no había efectivo. 'Vuelva mañana'. Volví al otro día. Lo mismo. 'Vuelva la semana que viene'."

- **OPCIÓN:** ...
-

"Un viernes volví con la Chola y otras diez vecinas. No llevábamos martillos, pero sí la mirada de quien no tiene nada que perder."

"¿Y qué hicieron?"

- **OPCIÓN:** ...
-

"Nos plantamos en el hall. No gritamos. No rompimos nada. Solo nos sentamos y nos quedamos mirando."

"¿Y?"

"El gerente llamó a un teléfono. Media hora después apareció el efectivo."

- **OPCIÓN:** ...
-

Sonríe con satisfacción.

"A veces pararse es suficiente. Pero hay que saber pararse. Y hay que saber con quién."




## ELENA_ANARQUISMO



"Elena, ¿vos sos de algún partido?"

Se ríe con ganas.

"¿Partido? M'hijo, yo estuve en todos y en ninguno."

- **OPCIÓN:** ...
-

"En los 70 estuve cerca del sindicato. Después de lo de la fábrica, me junté con los de la barriada. Después de la dictadura, voté al Frente algunas veces."

"Pero..."

"Pero aprendí que el de arriba siempre caga al de abajo. No importa el color de la bandera."

- **OPCIÓN:** ...
-

Te mira fijo.

"Yo no soy anarquista de libro, m'hijo. Nunca leí a Bakunin. Pero sé una cosa: cada vez que alguien se pone por encima de otros, termina pisándolos."

"¿Entonces?"

- **OPCIÓN:** ...
-

"Entonces la única defensa real es el compañero de al lado. No el partido. No el sindicato. No el Estado. El compañero."

- **OPCIÓN:** ...
-

Hace una pausa.

"Los hombres hablan y miden quién la tiene más larga. Nosotras paramos la olla para que los gurises no se mueran. Esa es mi política."




## ELENA_FRASE_TRINCHERA


Elena dice, mirando la olla:

"Esto no es caridad, m'hijo. Esto es trinchera."

Lo dice como quien dice una verdad eterna.




## ELENA_PREOCUPADA_OLLA_KNOT




Elena te busca. Cosa rara.
Ella nunca busca a nadie.

"Che. Necesito hablar."

"¿Qué pasa?"

- **OPCIÓN:** ...
-

"La olla. Sofía está quemada.
Si ella cae, cae todo."

Te mira. Seria.

"Hay que ayudarla. Pero ella no pide."

"¿Qué puedo hacer?"

"Estar. Aparecer. Hacer lo que puedas.
A veces eso alcanza."

- **OPCIÓN:** "Voy a ayudar."
- **OPCIÓN:** "No sé si puedo."


## ELENA_ACEPTO_AYUDAR


"Bien."

No dice gracias. No hace falta.


{ resultado_elena_olla_futuro == 2:
"Sofía es terca. Como yo.
Pero necesita gente."

Elena te mira fijo. Algo cambia en su cara.

"¿Sabés qué, m'hijo? Vos me hacés acordar a cuando empezamos en el 2002. La misma cara de asustado. Pero estás acá. Y eso es lo que importa."

"Vamos a sacar esto adelante. Como sacamos todo."

}
{ resultado_elena_olla_futuro == 1:
"Sofía es terca. Como yo.
Pero necesita gente."

}
{ resultado_elena_olla_futuro == 0:
"Sofía es terca. Como yo.
Pero necesita gente."

Se te hace un nudo en el estómago.
La gravedad de la situación te cae encima.
¿Puede cerrar la olla? ¿Qué pasa con las sesenta personas?

}
{ resultado_elena_olla_futuro == -1:
"Sofía es terca. Como yo."

Elena te mira. Ve algo en tus ojos.
Miedo. Parálisis.

"No te congeles, m'hijo. Congelarse es lo peor."

Pero ya estás congelado.
La responsabilidad te aplasta.

}



## ELENA_NO_PUEDO_AYUDAR


"Nadie puede mucho. Pero todos pueden algo."

No hay reproche. Solo verdad.

"Pensalo."

Se va.
Las palabras quedan.




## ELENA_MEMORIA_BARRIO


"¿Ves esa casa? Ahí vivía Don Ramón.
Carpintero. Hizo la mitad de los muebles del barrio."

"¿Qué le pasó?"

- **OPCIÓN:** ...
-

"Se murió en el 2003. El corazón.
La crisis lo mató. Como a muchos."

Señala otra casa.

- **OPCIÓN:** ...
-

"Ahí vivían los Fernández. Cinco hijos.
Se fueron a España en el 2002. Nunca volvieron."

El barrio es un cementerio de historias.
Elena es la única que las recuerda.

"¿Por qué me cuenta esto?"

"Porque alguien tiene que saber.
Cuando yo me vaya, ¿quién va a recordar?"





## ELENA_EN_CASA



Elena está en su casa.
Te hace pasar.

"¿Cómo estás?"

"No sé."

Ella asiente.
Pone la pava.



## ELENA_HISTORIA_2002


"En el 2002, Raúl estuvo tres meses sin laburo. La olla nos salvó ese invierno."

No sabías eso.

"No te vas a morir. Pero va a ser duro. Y vas a necesitar gente."



## ELENA_HABLAR_BARRIO


Elena habla del barrio, de antes.
De cómo la gente se ayudaba.

"Ahora cuesta más. Pero sigue pasando."



## ELENA_CONSEJO


Elena habla:

"En el 2002 estuvimos peor. Y acá seguimos. La pregunta no es si vamos a seguir. Es cómo."



## ELENA_CANASTAS


Elena habla:
"En el 2002 hacíamos canastas. Cada uno ponía lo que podía. Nadie daba mucho pero entre todos..."

Sofía asiente.
"Podemos probar."




## ELENA_PEDIR

Elena sabe cómo gestionar recursos.
No es mendigar.
Es sostener la red.
Es distinto.

"En el 2002 hacíamos esto todo el tiempo. Te acostumbrás."



## ELENA_LLAMAR


Llamás a Elena.

"Hola, m'hijo."

Siempre te dice así.
Como si fueras de la familia.

"¿Cómo estás, Elena?"

"Acá. Como siempre. ¿Y vos? ¿Cómo llevás la semana?"

"Raro. Todo raro."

"Es normal. Dale tiempo."



## ELENA_CONVERSACION_TELEFONO


Hablan de cosas.
Ella te cuenta del barrio.
De antes.
De ahora.

"Vos vas a estar bien. Sos de los que se bancan."

No sabés si es verdad.
Pero ayuda escucharlo.





## ELENA_FRAGMENTO_NOCHE


Elena no duerme mucho.
Los viejos no duermen.

Se sienta en la cocina.
Café recalentado. Radio bajita. Las voces de siempre.

{escuche_sobre_2002:
Piensa en el 2002.
En los que no sobrevivieron.
En los que se fueron.
En los que quedaron.
}

Mira las fotos de la pared.
Su marido. Muerto hace quince años.
Sus hijos. Uno en Buenos Aires. Otro en España.
No vienen nunca.

{elena_preocupada_olla:
Piensa en Sofía.
En la olla.
En que la historia se repite.

Ella ya no tiene fuerzas para cargar todo.
Pero puede sostener un poco.
}

La radio habla de economía.
Números que no entiende.
Palabras que ya escuchó antes.

"Otra vez", murmura.
"Siempre otra vez."

{elena_relacion >= 4:
Piensa en vos.
En que hay gente nueva que entiende.
En que tal vez el barrio sobreviva.
}

A las cuatro se acuesta.
El sueño de los viejos.
Liviano. Interrumpido.
Lleno de fantasmas.




## FRAGMENTO_ELENA_BANCO

Elena está en su casa.
La tele prendida. El mate frío.

Mira la foto de Raúl en la repisa.
"Vos me entenderías", le dice.

En el 2002 estaban todos en la calle.
Ahora cada uno en su casa.
Con su pantalla. Con su soledad.

Se acuesta.
El banco de la plaza la espera mañana.



## FRAGMENTO_ELENA_RECUERDO

Elena no puede dormir.

Piensa en la olla de 2002.
En cómo empezó con tres ollas y un fogón.
En cómo terminaron siendo cincuenta.

{elena_relacion >= 3:
Piensa en vos.
"Tiene algo", se dice. "Algo de los de antes."
}

Se da vuelta en la cama.
El insomnio de los setenta es diferente.
No es ansiedad. Es inventario.



## FRAGMENTO_ELENA_CARTAS

Elena relee una carta vieja.
De su hermana en Buenos Aires.

"Venite, Elena. Acá hay trabajo."
La carta es de 2003.

Nunca se fue.
El barrio la necesitaba.
O ella necesitaba al barrio.
Da igual.

Guarda la carta. Apaga la luz.





## DIEGO_ENCUENTRO_CASUAL


Diego camina rápido.
Siempre camina rápido.

Venezolano. Llegó hace ocho meses.
Trabaja en el depósito de la zona industrial.
Turnos de doce horas. Pago en negro.

Tiene la mirada de los que no pueden parar.

- **OPCIÓN:** Saludar
- **OPCIÓN:** Preguntarle cómo le va
- **OPCIÓN:** Seguir caminando


## DIEGO_SALUDO


"Hey, Diego."

Se frena. Sorprendido.
No mucha gente le habla.

"Hola, ¿cómo estás?"

El acento. Suave pero presente.

"Bien. ¿Y vos? ¿El laburo?"

"Ahí. Cansado, pero bien."

Siempre dice que está bien.
Aunque no esté.



## DIEGO_COMO_VA


"Diego. ¿Cómo te va?"

Se detiene. Piensa.

"Bien... bueno, más o menos."

Mira para los lados. Como si alguien pudiera escuchar.

"El trabajo está raro. Nos quieren tratar como piezas de repuesto. Pero ya vi venir esto antes."

"¿Te preocupa?"

"Preocuparse es perder el tiempo. Hay que moverse. La red sostiene, hermano, pero uno tiene que ser parte del nudo."




## DIEGO_IGNORAR


Diego sigue caminando.
No nota que pasaste.
O finge no notar.

Cada uno con sus problemas.




## DIEGO_ENCUENTRO_BARRIO



Encontrás a Diego.
Está saliendo del depósito.

"¿Qué hacés acá? ¿No laburabas?"



## DIEGO_CAMINAR_JUNTOS



Caminan.
Hablan de boludeces.
Por un rato, casi te olvidás.




## DIEGO_EN_OLLA


Diego está descargando cajones.
Camisa arremangada. Transpirado.
Se mueve rápido, como siempre.


"No sabía que venías acá."

"Vengo a dar una mano. Los domingos no trabajo y...
bueno, hay que hacer algo."

- **OPCIÓN:** "Qué grande, Diego."
- **OPCIÓN:** "¿Te tratan bien?"
- **OPCIÓN:** Asentir y seguir


## DIEGO_TRANQUILIZAR


"Qué grande, Diego. Hace falta gente."

Sonríe. Se seca la frente.

"En Venezuela yo organizaba los operativos de comida en Petare. Sé cómo es la logística cuando no hay nada. Acá les faltaba alguien que supiera estirar los recursos."

"Siempre falta gente."

"Falta organización. Brazos sobran, lo que falta es saber hacia dónde empujarlos."

Te hace una seña. Hay cajones para descargar.


{ resultado_diego_fisico == 2:
Agarrás un cajón de papas. Pesado. Lo cargás sin parar.
Diego te mira con respeto.
"Sos fuerte, hermano. Si todos empujaran así..."
Trabajan juntos. A la par. Sin hablar.
El trabajo dice lo que las palabras no.
}
{ resultado_diego_fisico == 1:
Ayudás a cargar. Cuesta, pero se puede.
Diego asiente. Trabajan juntos.
}
{ resultado_diego_fisico == 0:
Intentás cargar un cajón. Es más pesado de lo que parece.
Diego agarra el otro lado sin decir nada.
"Entre los dos es más fácil."
No es debilidad. Es equipo.
}
{ resultado_diego_fisico == -1:
Agarrás un cajón. Se te resbala.
Las papas se desparraman por el piso.
"Tranquilo, tranquilo." Diego se agacha a juntar.
Te agachás con él. Rojo de vergüenza.
"A todos nos pasa. Las papas son traicioneras."
Sonríe. No te juzga.
}

Sofía le pasa una botella de agua.
Él sigue cargando cosas.
No para.



## DIEGO_PREGUNTA_SITUACION


"¿Está muy jodido?"

Baja la voz.

"El mes pasado no pude mandar plata a mi familia.
Primer mes en ocho que no mando."


- **OPCIÓN:** ...
-

Su mamá. Su hermana. Allá.
Esperando.

"Lo siento, Diego."

"Está bien. Voy a poder. Siempre se puede.
Tengo unos panas que venden comida. Capaz me sumo."

Ya está pensando en la siguiente jugada.
No se queda quieto. No puede.




## DIEGO_NO_PRESIONAR


Asentís. Seguís.
Diego sigue laburando.
Carga dos bolsa de papa como si fueran plumas.
La fuerza de la costumbre.



## DIEGO_COLECTA


Vas con Diego y otra persona.
Recorren la zona.

"Para la olla del barrio. Lo que pueda."

Diego sabe hacer esto.
No tiene vergüenza.
O la esconde bien.




## DIEGO_CONVERSACION_PROFUNDA



Es de noche. Diego fuma en la esquina.
Único momento de descanso.

"¿Puedo?"

Te hace lugar.

"¿Fumás?"

"No. Solo... quería hablar."

Silencio.

"¿De qué?"

- **OPCIÓN:** "De vos. ¿Cómo llegaste acá?"
- **OPCIÓN:** "De la situación. ¿Cómo la ves?"
- **OPCIÓN:** "De nada. Solo compañía."


## DIEGO_HISTORIA


Diego mira el cigarrillo.


{ resultado_diego_confianza == 2:

Diego te mira. Algo se abre.

"En Caracas, antes de venirme, yo creía. De verdad creía. Estuve en una cooperativa agrícola en el llano. Metíamos las manos en la tierra pensando que por fin era nuestra, que el socialismo de abajo iba a funcionar."

"¿Y qué pasó?"

"Pasó que la revolución tiene muchos estómagos y pocas manos. La corrupción se comió las semillas, y el autoritarismo se comió a los que preguntábamos dónde estaba el fertilizante."

Pausa larga. Diego mira sus manos.

"Vine acá para dejar de pelear, pero el hambre es el mismo monstruo con distinto acento."

Se queda callado un momento. Después agrega algo que nunca le contó a nadie:

"Mi viejo todavía está allá. Enfermo. No puedo ir a verlo porque si cruzo la frontera no me dejan volver. Y si no vuelvo, quién les manda plata."

La voz se le quiebra. Un instante. Después se recompone.

}
{ resultado_diego_confianza == 1:

"En Caracas, antes de venirme, yo creía. De verdad creía. Estuve en una cooperativa agrícola en el llano. Metíamos las manos en la tierra pensando que por fin era nuestra, que el socialismo de abajo iba a funcionar."

"¿Y qué pasó?"

"Pasó que la revolución tiene muchos estómagos y pocas manos. La corrupción se comió las semillas, y el autoritarismo se comió a los que preguntábamos dónde estaba el fertilizante. Destruyeron lo que construimos, y de paso borraron el trabajo de los que estaban antes de ellos, que tampoco eran santos, pero al menos dejaban algo en pie."

Pausa larga. Diego mira sus manos, curtidas por dos tierras distintas.

"Vine acá para dejar de pelear, pero el hambre es el mismo monstruo con distinto acento. A veces... a veces ya ni me da la cabeza para imaginar que la cosa se acomode. Es como si el futuro fuera un idioma que dejé de hablar."

Comunidad.
En el medio de la nada, se tienen entre ellos.

}
{ resultado_diego_confianza == 0:
Diego fuma. Piensa.

"Vine de Venezuela. Ya sabés eso."

Pausa.

"Algún día te cuento bien. Hoy no me da."

No insistís. Hay cosas que necesitan su tiempo.

}
{ resultado_diego_confianza == -1:
Diego se cierra. Tirás del cigarrillo.

"No me gusta hablar de eso."

"Perdón. No quería..."

"Está bien. Pero... no hoy."

El silencio se vuelve incómodo.
Quizás preguntaste demasiado pronto.
}



## DIEGO_OPINION


"La situación está jodida. Para todos."

Fuma.

- **OPCIÓN:** ...
-

"Pero ustedes no saben lo que es jodido de verdad.
Cuando la luz se va diez horas. Cuando no hay agua.
Cuando un kilo de arroz cuesta un sueldo."

"¿Y esto?"

"Esto es difícil. Pero no es Venezuela.
Y acá... acá se siente distinto.
La gente todavía se mira.
En Caracas, al final, cada uno miraba su propio plato."

Hace una pausa.

"Por eso vengo a la olla.
No por el plato. Yo sé hacerme el mío.
Sino porque acá el hambre se combate con asamblea, no con silencio.
Eso lo aprendí allá: el que come solo, muere solo."

- **OPCIÓN:** ...
-

Pausa.

"Aunque a veces... a veces me pregunto si vine
para terminar igual. Pobre en otro lado."




## DIEGO_COMPANIA


"Está bien."

Fuman en silencio.
O él fuma. Vos mirás la calle.

No hace falta hablar.
A veces solo estar alcanza.





## DIEGO_HISTORIA_CECOSESOLA



Es domingo. Diego tiene el día libre.
Están sentados en la plaza del barrio.

"¿Sabés qué hacía yo en Venezuela, antes de todo?"

"No. ¿Qué?"

"Organizaba ferias. Ferias de verdad."

- **OPCIÓN:** ...
-

"Mi familia estaba en CECOSESOLA. Central Cooperativa de Servicios Sociales de Lara. Suena a burocracia, pero era todo lo contrario."

"¿Qué era?"

"La red cooperativa más vieja del país. Fundada en el 67, antes de Chávez, antes de todo. Mi abuelo fue de los primeros. Mi padre también. Yo nací en eso."

- **OPCIÓN:** ...
-

Diego mira al cielo. Sonríe por primera vez en mucho tiempo.

"Las ferias de consumo familiar. Imaginate: los productores llevaban la cosecha directo a la feria. Tomates, pimentones, yuca, plátano. Sin intermediarios. Los precios eran treinta por ciento menos que en el mercado."

"¿Treinta por ciento?"

"Porque no había patrón. No había jefe. Todos ganábamos lo mismo: el que cargaba, el que vendía, el que contaba la plata. Rotábamos los cargos. Nadie se quedaba arriba."

- **OPCIÓN:** "Eso suena a cuento."
"Suena, sí. Pero funcionó sesenta años. Todavía funciona, aunque destruyeron la mitad."

- **OPCIÓN:** "¿Y cómo funcionaba?"
"Con asambleas. Todo se decidía entre todos. Si había problema, hablábamos. Si alguien se mandaba un moco, lo corregíamos. No había despidos, había conversaciones."


## DIEGO_CECOSESOLA_CONT


- **OPCIÓN:** ...
-

"También teníamos un centro de salud. Propio. Con quirófanos. Lo construimos nosotros. No esperamos que el gobierno nos lo diera."

"La puta madre."

- **OPCIÓN:** ...
-

Diego se pone serio.

"¿Sabés cuál es la diferencia entre la cooperativa de verdad y la que quería imponer el Estado?"

"¿Cuál?"

"El Estado quería que dependiéramos de él. Créditos estatales, contratos oficiales, consejos comunales alineados al partido. Nosotros dijimos que no. CECOSESOLA nunca aceptó plata del gobierno. Preferíamos ser pobres y libres."

- **OPCIÓN:** ...
-

"Y eso nos hizo enemigos."




## DIEGO_SOBRE_CAMION



Diego baja la voz.

"¿Sabés por qué me fui?"

"Por la situación, ¿no? El hambre, la inflación..."

"No. Bueno, también. Pero hubo algo más."

- **OPCIÓN:** ...
-

"Cuando el gobierno empezó a presionar a CECOSESOLA, nos negamos a alinearnos. No queríamos distribuir las cajas CLAP."

"¿Qué eran las CLAP?"

"Paquetes de comida que controlaba el partido. Si estabas con ellos, comías. Si no, te jodías. Era control político, no ayuda."

- **OPCIÓN:** ...
-

"Un funcionario le dijo a mi viejo: 'O entran al sistema o los vamos a asfixiar'. Empezaron a negarnos permisos. A demorarnos los insumos."

"Hijos de puta."

- **OPCIÓN:** ...
-

Diego mira sus manos.

"Una noche quemaron un camión de la cooperativa. Lleno de verduras para la feria del sábado. Nadie investigó. El mensaje era claro."

- **OPCIÓN:** ...
-

Silencio largo.

"Mi vieja me dijo: 'Vos tenés que irte antes de que te toque a vos'. Me dieron los ahorros de toda la vida. Que no eran nada, por la inflación. Pero era todo lo que tenían."

- **OPCIÓN:** "Lo siento."
"No hay nada que sentir. Es la historia de miles. Millones. Nos robaron el futuro antes de que existiera."

- **OPCIÓN:** Quedarte callado
No hay palabras.
Diego tampoco las espera.


## DIEGO_LIBRETA_SEMILLAS


Notás que Diego tiene una libretita gastada.
Anota todo ahí: gastos, horarios, nombres.

"¿Qué tenés en esa libreta?"

Diego sonríe.

"Cosas de feria. Costumbre vieja."

- **OPCIÓN:** "¿Puedo ver?"

Diego duda. Después te la muestra.

En las últimas páginas hay una lista distinta.
No son números. Son nombres de plantas.

"Pimentón larence. Tomate perita. Ají dulce. Cilantro cimarrón."

"¿Qué es esto?"

- **OPCIÓN:** ...
-

"Semillas de mi tierra. Las que aprendí a sembrar con mi abuelo."

Pasa el dedo por la lista.

"Ninguna crece igual acá. El clima es distinto. La tierra es distinta."

- **OPCIÓN:** ...
-

"A veces la leo como quien lee una carta de un muerto."

Guarda la libreta.

"Pero la guardo. Por si algún día..."

No termina la frase.
No hace falta.


- **OPCIÓN:** "No, perdón. Es personal."
"Está bien. Capaz otro día."


## DIEGO_Y_MARCOS


Marcos está hablando de "la orga". De cuando él militaba.
De la estructura, de las células, de la disciplina.

Diego lo escucha con cara rara.

"¿Y quién controlaba a la orga?"

Marcos se frena.

"¿Cómo?"

"¿Quién decidía quién subía y quién bajaba? ¿Quién manejaba la plata? ¿Había asambleas o había jefes?"

- **OPCIÓN:** ...
-

Marcos no sabe qué decir.

"Había... había dirección. Cuadros. Gente formada..."

"O sea, jefes."

- **OPCIÓN:** ...
-

Diego no lo dice con bronca. Lo dice con tristeza.

"Yo vi el cooperativismo de verdad ser aplastado por el cooperativismo del Estado. El problema no era la idea. Era que alguien arriba se creía con derecho a decidir por todos."

- **OPCIÓN:** ...
-

Marcos se queda callado.

Diego sigue:

"Sin la asamblea, sos solo otro tipo con libros y buenas intenciones. Y eso no alcanza."

Silencio incómodo.

Pero Marcos no se va.
Algo le quedó sonando.




## DIEGO_ENTERARSE_DESPIDO


{conte_a_alguien:
"Ya te conté. Me echaron."
"Mierda, sí. ¿Cómo andás?"
- else:
"Me echaron ayer."
"La puta madre."
}

Diego te mira.
Él sabe lo que es no tener nada seguro.

"Si necesitás algo..."

"Gracias."

No hay mucho que decir.
Pero estar con alguien ayuda.




## DIEGO_PIERDE_LABURO



Diego está en la plaza.
Medio día. Debería estar trabajando.

"Diego. ¿Qué hacés acá?"

"Me echaron."

Corto. Seco.

- **OPCIÓN:** ...
-

"¿Cuándo?"

"Ayer. Sin aviso. 'Ya no te necesitamos'."

Mira el piso.

- **OPCIÓN:** ...
-

"Ocho meses. Nunca falté. Nunca llegué tarde.
Y me echaron como si nada."

- **OPCIÓN:** "Lo siento mucho."
- **OPCIÓN:** "¿Tenés algo ahorrado?"
- **OPCIÓN:** "¿Qué vas a hacer?"


## DIEGO_CONSOLAR


"Lo siento, Diego."

"Sí. Yo también."

No hay más que decir.




## DIEGO_PREGUNTAR_AHORROS


"¿Tenés algo ahorrado?"

Sonríe. Sin gracia.

"¿Con lo que pagaban? Apenas daba para el cuarto y mandar algo."

"{diego_familia_en_venezuela:
"Mi vieja va a tener que esperar.
Pero ella entiende. Es una guerrera.
Ya pasó por peores."
}



## DIEGO_QUE_HACER


"No sé. Buscar otra cosa. Hay un depósito en Sayago.
Capaz que necesitan gente."

"¿Y si no?"

"No sé. Algo aparece. Siempre aparece algo."

Es lo que se dice.
Aunque no siempre sea verdad.




## DIEGO_AYUDA



{diego_perdio_laburo:
"Diego. Mirá, no es mucho, pero..."

Le das lo que podés.
Poco. Pero algo.

"No, hermano. Vos también estás jodido."

"Tomalo. Después me pagás."

No va a pagar. Los dos lo saben.
Pero la ficción ayuda.


"Gracias. En serio."

- else:
"Si necesitás algo, avisame."

Diego asiente.

"Gracias. Lo mismo digo.
Si vos te quedás en banda, el grupo se mueve.
No te vamos a dejar caer."


}



## DIEGO_LLAMAR


Llamás a Diego.

"¿Qué onda?"

"Nada. Domingo. ¿Vos?"

"Acá, en la pieza. Mirando el techo."



## DIEGO_CONVERSACION_TELEFONO


Hablan.
De nada.
De todo.

Diego también está solo.
Pero ahora están solos juntos, aunque sea por teléfono.

"La semana que viene hay que buscar laburo en serio."

"Sí. Hay que."

"Mañana salimos juntos. Recorremos."

"Dale."





## DIEGO_FRAGMENTO_NOCHE


Diego mira el techo del cuarto.
Paredes finas. Se escucha todo.

Un cuarto compartido con otro venezolano.
Seis metros cuadrados.
Casa. Por ahora.

Debajo de la almohada tiene una franela vieja.
El logo de CECOSESOLA: una mano sosteniendo espigas.
Ya no la usa, pero la guarda.

{diego_perdio_laburo:
Mañana tiene que buscar trabajo.
Tiene que encontrar algo.
No hay opción.

Piensa en su mamá.
En la llamada que tiene que hacer.
En las palabras que no encuentra.

"Este mes no puedo mandar."
¿Cómo se dice eso?
- else:
El despertador suena a las cuatro.
Turno de seis a seis.
Doce horas.
Después repetir.
}

{diego_familia_en_venezuela:
Piensa en Caracas.
En las calles que caminaba.
En la casa de su mamá.

A veces sueña que vuelve.
Que todo se arregló.
Que puede volver.

Después despierta.
}

{diego_conto_cecosesola:
Piensa en la cooperativa.
En 2022, CECOSESOLA ganó el Right Livelihood Award.
El "Nobel Alternativo", le dicen.

Lo vio por internet, desde este mismo cuarto.

Lloró de orgullo.
La cooperativa sobrevivió. Sigue funcionando.
Pero su familia tuvo que irse.

Lloró también de rabia.
}

{diego_viene_a_olla:
Al menos mañana hay olla.
Al menos va a estar ocupado.
Cansarse hace bien. Ayuda a no pensar.

Además, en la olla se siente útil.
Organizando logística, estirando recursos.
Sus manos recuerdan cómo se hace.
}

{ayude_a_diego:
Piensa en vos.
En que estás empezando a entender que la "clase media" era un cuento que te contabas para no sentirte parte de nosotros.

Se ríe bajito en la oscuridad.
"Uruguayo loco", piensa.
"Bienvenido a la resistencia. Acá no se factura, acá se sostiene."
}

Saca la libretita del bolsillo del pantalón.
La lista de semillas en la última página.
Pimentón larence. Tomate perita. Ají dulce.

"Algún día", murmura.

Afuera, la ciudad duerme.
Él no.

Los inmigrantes no duermen.
Calculan.
Planean.
Sobreviven.

Guarda la libreta.
Aprieta la franela bajo la almohada.
Cierra los ojos.




## FRAGMENTO_DIEGO_LLAMADA

Diego llama a su mamá en Caracas.

La señal va y viene.
"¿Comiste, mijo?"
"Sí, mamá."
Mentira. Hoy no comió.

Le manda la mitad de lo que gana.
Se queda con la otra mitad.
A veces alcanza. A veces no.

"Te quiero, mijo."
"Yo también, mamá."

Corta. Se queda mirando el techo.



## FRAGMENTO_DIEGO_PERMISO

Diego revisa los papeles de residencia.
Todo en orden. Más o menos.

{diego_relacion >= 3:
Piensa en el barrio.
En que alguien le habló hoy sin pedirle los papeles primero.
Eso vale.
}

El trámite es el jueves.
Si sale bien, puede trabajar en blanco.
Si sale mal...

No piensa en eso. Mañana.



## FRAGMENTO_DIEGO_MATE

Diego intenta cebar mate.

Le sale lavado. Otra vez.

{diego_relacion >= 2:
"Mañana le pido al vecino que me enseñe."
}

En Venezuela el café es otra cosa.
Acá todo es mate.
Mate dulce, mate amargo, mate con yuyos.
Un idioma nuevo que todavía no domina.

Se toma el mate lavado igual.
Algo caliente es algo caliente.






## MARCOS_ENCUENTRO_CASUAL


Marcos cruza la calle.
Rápido. Cabeza gacha.
Como si no quisiera que lo vean.

Lo conocés de antes.
Del barrio. De la época de las asambleas.
Ahora no viene nunca.

- **OPCIÓN:** Llamarlo
- **OPCIÓN:** Dejarlo pasar


## MARCOS_LLAMAR_CALLE


"¡Marcos!"

Se frena. Mira.
Por un segundo, parece que va a seguir de largo.
Pero se queda.

"Ah. Hola."

Incómodo. Distante.

"Hace rato que no te veo por acá."

"Sí. Ando en otra cosa."

Mentira. No anda en nada.
Pero no vas a decirlo.

- **OPCIÓN:** "¿Cómo estás?"
- **OPCIÓN:** "Te extrañamos en la olla."
- **OPCIÓN:** "Bueno, nos vemos."


## MARCOS_COMO_ESTAS


"¿Cómo estás?"

Pausa larga.

"Estoy."

No dice más.
No hace falta.




## MARCOS_OLLA_MENCION


"Te extrañamos en la olla. Sofía pregunta por vos."

Se tensa.

"Dile que estoy bien. Que... después paso."

No va a pasar.
Los dos lo saben.



## MARCOS_DESPEDIDA_CORTA


"Bueno, nos vemos."

"Sí. Nos vemos."

Se va.
Rápido. Como antes.



## MARCOS_IGNORAR


Lo dejás pasar.
No te ve. O finge.

Marcos ya no es parte del barrio.
O no quiere serlo.




## MARCOS_NO_ESTA



Tocás timbre.
Nada.

Llamás.
No contesta.

Quizás no está.
Quizás no quiere atender.

Con Marcos nunca sabés.



## MARCOS_CONTESTA


Llamás a Marcos.
Esta vez contesta.

"Hola."

"Marcos, soy yo. ¿Podemos vernos?"

Silencio.

"¿Para qué?"

"No sé. Para hablar."

Más silencio.

- **OPCIÓN:** "Estoy preocupado por vos."
- **OPCIÓN:** "Necesito hablar con alguien."
- **OPCIÓN:** "Nada, olvidate."


## MARCOS_ACEPTA_VERSE


Suspira.

"Dale. En la plaza. En una hora."

Corta.

Algo es algo.



## MARCOS_RECHAZA


"No. Ahora no puedo. Después te llamo."

No va a llamar.

"Dale."

Cortás.




## MARCOS_ENCUENTRO_PLAZA



Marcos está sentado en un banco.
Más flaco que antes.
Más cansado.
Barba de días.

"Viniste."

"Te dije que venía."

- **OPCIÓN:** ...
-

Se sientan.
Silencio largo.

"¿Qué onda?", pregunta al fin.

- **OPCIÓN:** "¿Cómo estás de verdad?"
- **OPCIÓN:** "¿Por qué te alejaste?"
- **OPCIÓN:** "Nada. Solo quería verte."


## MARCOS_VERDAD


"¿Cómo estás de verdad, Marcos?"

Te mira. Ojos cansados.

"Mal. ¿Querés que te mienta?"

"No."

"Mal. No duermo. No salgo. No hago nada."

- **OPCIÓN:** ...
-

Pausa.

"Estoy podrido de todo."




## MARCOS_PORQUE


"¿Por qué te alejaste? Del barrio, de la olla, de todo."

Silencio largo.

"Porque me quemé los ojos de ver cómo nos usaban. Diez años en la mesa chica de la militancia. Asambleas de trasnoche, marchas con la garganta rota, colectas para compañeros que después te vendían por un puesto en el ministerio."

Mira el piso.

"Cansado de ver cómo la estructura se morphaba el espíritu. Peleamos contra el sistema de afuera y nos terminó ganando el sistema de adentro. Al final, los de mi clase siguen igual, y los que hablaban en su nombre tienen auto nuevo. Me cansé de pelear para nada, uruguayo."




## MARCOS_SOLO_VER


"Nada. Solo quería verte."

Asiente.

"Gracias."

No dice más.
Pero se queda.

A veces estar alcanza.





## MARCOS_CONVERSACION_PROFUNDA



Es de tarde. El sol baja.
Marcos sigue en el banco.

"¿Por qué seguís viniendo a hablar conmigo?"

Buena pregunta.

- **OPCIÓN:** "Porque me importás."
- **OPCIÓN:** "Porque yo también estoy solo."
- **OPCIÓN:** "No sé."


## MARCOS_IMPORTA


"Porque me importás, Marcos."

Te mira. Sorprendido.

"¿Por qué? No hice nada por vos."

"No tiene que ser transaccional."


{ resultado_marcos_reconectar == 2:
Silencio largo. Marcos mira el piso.

Cuando levanta la vista, tiene los ojos húmedos.

"Hace mucho que nadie me dice eso."

Pausa.

"¿Sabés qué es lo peor de alejarte? Que después no sabés cómo volver. Y cada día es más difícil."

Se le quiebra la voz un segundo.

"Gracias por insistir. De verdad."

}
{ resultado_marcos_reconectar == 1:
Silencio.

"Hace mucho que nadie me dice eso."

}
{ resultado_marcos_reconectar == 0:
Marcos se queda callado.
Asiente apenas.

No te rechaza. Pero tampoco se abre.
La pared sigue ahí. Un poco más baja, quizás.

}
{ resultado_marcos_reconectar == -1:
Marcos se pone de pie.

"No hagás eso."

"¿Qué cosa?"

"Venirme con eso de que te importo. No me conocés. No sabés nada."

Se va caminando rápido.
La defensa de los que tienen miedo de que les importe algo.

}



## MARCOS_SOLO


"Porque yo también estoy solo. Y vos entendés."

Asiente.

"Sí. Entiendo."

Los dos solos.
Juntos en la soledad.




## MARCOS_NO_SE


"No sé. Capaz porque sí."

"Eso no es una respuesta."

"Es la única que tengo."

Se ríe. Por primera vez.
Una risa corta, rota.
Pero risa.





## MARCOS_SOBRE_HIJOS



"¿Y tus hijos, Marcos? ¿Cómo están?"

Silencio largo.

"Lejos."

- **OPCIÓN:** ...
-

"Lucía está en Barcelona. Se fue en 2019. Trabaja en comunicación, algo de redes sociales. Volvió una vez, hace dos años."

"¿Y el otro?"

"Martín está en Madrid. Se fue detrás de la hermana en 2021. Estudia algo de tecnología. No entiendo bien qué hace."

- **OPCIÓN:** ...
-

Pausa.

"Hablamos por WhatsApp. Cada tanto. Pero las conversaciones son... superficiales. '¿Cómo estás?' 'Bien'. '¿Y vos?' 'Bien'. Nada de verdad."

- **OPCIÓN:** "¿Los extrañás?"
"No sé si extraño. No sé si tengo derecho a extrañar."

- **OPCIÓN:** "Debe ser duro."
"Es lo que es. Ellos están mejor allá. Acá no hay nada para ellos."


## MARCOS_HIJOS_CONT


- **OPCIÓN:** ...
-

"¿Sabés qué pienso a veces?"

"¿Qué?"

"Les dejamos un país del que se tienen que ir. Toda mi vida militando para construir algo mejor, y mis hijos se tienen que en Europa a lavar platos o programar boludeces."

- **OPCIÓN:** ...
-

Su voz se quiebra un poco.

"Cuando era joven, la política era todo. No aprendí a ser padre fuera de eso. Y ahora están lejos y no sé cómo hablarles."

- **OPCIÓN:** ...
-

"A veces los veo en videollamada. Sonriendo. Felices. Lejos."

Pausa.

"Y no sé si siento alivio o fracaso."




## MARCOS_SOBRE_ZABALZA



"¿Conocés a Zabalza?"

"¿Jorge Zabalza? El tupamaro..."

"El que cuestiona la historia oficial. El que dice lo que nadie quiere decir."

- **OPCIÓN:** ...
-

"Leí una entrevista suya. De las que da cada tanto. Y sentí que alguien decía en voz alta lo que yo pensaba en silencio."

"¿Qué pensás?"

- **OPCIÓN:** ...
-

"Que la revolución se la comió la burocracia. Que los que empezaron peleando contra el sistema terminaron siendo el sistema. Que los que dormían en pensiones ahora viven en barrios privados."

- **OPCIÓN:** ...
-

"Zabalza sigue hablando. Sigue poniendo el dedo en la llaga. Yo me callé."

"¿Por qué?"

"Porque cuando lo decís en voz alta, te quedás solo. Y yo ya estaba bastante solo."




## MARCOS_NOCHE_VOTOS_2009



"¿Te acordás del 2009?"

"¿Qué pasó en el 2009?"

"Las internas del Frente. Cuando eligieron a Mujica."

- **OPCIÓN:** ...
-

"Estuve en el festejo. En la sede. Era euforia. La gente saltando, gritando. El triunfo."

"¿Y?"

- **OPCIÓN:** ...
-

"Y mientras la militancia de base festejaba, vi a los dirigentes en un rincón. Repartiéndose cargos. Hablando de quién iba a qué ministerio, quién se quedaba con qué secretaría."

"Como si fuera botín de guerra."

"Exacto. Botín."

- **OPCIÓN:** ...
-

Marcos mira sus manos.

"Vi compañeros que dormían en pensiones brindando porque ahora iban a vivir en casas con alarma. Vi la transformación en tiempo real."

"¿Y qué hiciste?"

"Nada. Me quedé mirando. Y al otro día seguí militando. Tardé años en animarme a irme."

- **OPCIÓN:** ...
-

"Ese fue el principio del fin. Solo que no lo supe hasta mucho después."




## MARCOS_SOBRE_VOTO_BLANCO



"¿Sabés qué hice la última elección?"

"¿Qué?"

"Voté en blanco."

- **OPCIÓN:** ...
-

"Después de treinta años votando a la izquierda. Después de todo lo que militía. Fui al cuarto oscuro y no pude poner la cruz."

"¿Por qué?"

"Porque no podía votar a los que me traicionaron. Pero tampoco podía votar a la derecha. Entonces nada."

- **OPCIÓN:** ...
-

"Me sentí sucio una semana entera. Como si hubiera traicionado a los compañeros muertos. A los que se jugaron la vida."

"¿Y ahora?"

"Ahora... ahora no sé. Capaz que votar en blanco fue lo más honesto que hice en años. O capaz que fue cobardía. No sé."





## MARCOS_REVELAR_DESPIDO



Están hablando. De nada.
De pronto, Marcos dice:

"Me echaron."

"¿Cuándo?"

"Hace seis meses. No se lo conté a nadie."

- **OPCIÓN:** ...
-

Ah.
Por eso estaba tan ausente.
Por eso se aisló.

"¿Por qué no dijiste nada?"

- **OPCIÓN:** ...
-

"Vergüenza. Orgullo. No sé.
Después de todo lo que hablaba sobre dignidad del trabajador...
y me echaron como a cualquiera."


- **OPCIÓN:** "A mí también me echaron."
- **OPCIÓN:** "No tenés que avergonzarte."
- **OPCIÓN:** Solo escuchar


## MARCOS_COMPARTIR


"A mí también me echaron."

Te mira. Sorprendido.

"¿En serio?"

"Hace poco. También me da vergüenza."


{ resultado_marcos_emocional == 2:
"Bienvenido al club."

Una sonrisa amarga. Pero compartida.

Y entonces Marcos dice algo inesperado:

"¿Sabés qué? Capaz que esto es lo que necesitaba. Que alguien que entiende me diga que no estoy loco."

Se queda un momento.

"Diez años de militancia y me echaron como a un trapo. La dignidad del trabajador, decía. Y miranos."

Pero hay algo diferente en su voz. No amargura. Algo más tibio.

}
{ resultado_marcos_emocional == 1:
"Bienvenido al club."

Una sonrisa amarga.
Pero compartida.

}
{ resultado_marcos_emocional == 0:
"Bienvenido al club."

El tono es seco. Distante.
Pero no se va.

}
{ resultado_marcos_emocional == -1:
"Bienvenido al club."

Pero algo se apaga en su cara.

"Qué mierda, ¿no? Todos iguales. Todos descartables."

El intento de conectar se convierte en confirmación de lo peor.
Para los dos.

}



## MARCOS_SIN_VERGUENZA


"No tenés que avergonzarte, Marcos. Le pasa a todo el mundo."

"Sí. Pero duele igual."

"Lo sé."

Silencio.

"Gracias por escuchar."




## MARCOS_ESCUCHAR


No decís nada.
Solo escuchás.

Marcos habla.
De la rabia, de la impotencia, del vacío.

A veces eso es lo que hace falta.
Que alguien escuche.





## MARCOS_INVITAR_ASAMBLEA


"Hay una asamblea hoy. En la olla. ¿Querés venir?"

Marcos lo piensa.
Largo.

"No sé. Hace mucho que no..."

- **OPCIÓN:** "Solo vení a mirar. Sin compromiso."
- **OPCIÓN:** "Entiendo. Otra vez será."


## MARCOS_ACEPTA_ASAMBLEA


"Solo a mirar. No tenés que hacer nada."

Pausa.

"Dale. Pero me voy cuando quiera."

"Obvio."




## MARCOS_RECHAZA_ASAMBLEA


"No. Todavía no estoy listo."

"Está bien. Cuando quieras."

"Gracias."



## MARCOS_EN_ASAMBLEA


{marcos_vino_a_asamblea:
Marcos está en el fondo.
Mirando.
No habla.
Pero está.

Sofía lo ve. Lo saluda de lejos.
Elena asiente.
Todos saben que es un paso.
}



## MARCOS_SE_FUE


{marcos_vino_a_asamblea:
Marcos se fue antes de que terminara.
Pero estuvo.
Quizás eso es algo.
}




## MARCOS_LLAMAR


Llamás a Marcos.

Para variar, contesta.

"Hola."

"Hola. Quería ver cómo estabas."

Silencio.

"Estoy. Es lo que hay."



## MARCOS_CONVERSACION_TELEFONO


{marcos_vino_a_asamblea:
"Ayer fuiste a la asamblea."
"Sí. No sé por qué. Pero fui."
"Estuvo bien que fueras."
"No sé. Quizás."
}

Hablan un rato.
Marcos sigue distante.
Pero un poco menos.




## MARCOS_HABLAR_PRECARIEDAD


Hablan un rato.
De la precariedad.
De cómo todo se cae.
De cómo seguir.

Marcos no tiene respuestas.
Pero al menos no estás solo.



## MARCOS_FUNCIONAR


"¿Cómo la llevás?"

"No la llevo. Funciono. Es distinto."

Funcionar.
Hacer lo mínimo.
Sobrevivir sin vivir.

Conocés la sensación.




## MARCOS_IDEA_ESTO_ES_LO_QUE_HAY



No la elegiste.
Llegó sola.
Mirando a Marcos.
Viendo el futuro posible.





## MARCOS_FRAGMENTO_NOCHE


Marcos mira la tele.
Sin sonido.
Las imágenes pasan.

Su departamento es chico. Desordenado.
Platos sucios. Ropa en el piso.
La entropía de la depresión.

{marcos_secreto:
Piensa en el laburo que perdió.
En los compañeros que ya no llaman.
En la vida que se fue deshaciendo.
}

{marcos_era_militante:
Piensa en las asambleas de antes.
En cuando creía que se podía cambiar algo.
En la energía que tenía.

¿Adónde fue todo eso?
¿Adónde fue él?
}

{marcos_vino_a_asamblea:
Piensa en hoy.
En la olla. En la gente.
En que se sintió raro volver.

Pero también se sintió...
¿Algo?

Quizás hay algo todavía.
}

{marcos_relacion >= 3:
Piensa en vos.
En que alguien insiste.
En que alguien no se rindió con él.

No sabe por qué.
Pero agradece.
}

A las tres de la mañana apaga la tele.
Se acuesta sin desvestirse.

Mañana es otro día.
Igual que hoy.
Igual que ayer.

Pero quizás no.
Quizás algo cambie.

{marcos_estado == "mirando":
Por primera vez en meses,
se duerme con algo parecido a la esperanza.
- else:
Se duerme con el vacío de siempre.
El vacío que ya es familiar.
}




## FRAGMENTO_MARCOS_INSOMNIO

Marcos no duerme.

El techo. Las paredes. El silencio.

Antes iba a las asambleas. Antes creía.
Antes había fuego.

{marcos_relacion >= 2:
Hoy alguien le habló.
No de política. De nada.
Solo hablar.

Eso jode. Porque es más difícil
ser cínico cuando alguien te mira a los ojos.
}

Se da vuelta. Otra vez.
El insomnio de los desencantados es el peor.



## FRAGMENTO_MARCOS_BALCON

Marcos sale al balcón.

Fuma.
La ciudad abajo.
Las luces de las casas.

{marcos_vino_a_asamblea:
Fue a la asamblea. No sabe por qué.
Capaz que por vos. Capaz que por curiosidad.

No fue tan malo.
Pero no lo va a admitir.
}

Tira el pucho.
Mañana es otro día.
Igual que todos.



## FRAGMENTO_MARCOS_MUSICA

Marcos pone música.
Rock nacional. De los '80.

Charly cantando sobre demoler.
Los Redondos sobre la bestia.

Sube el volumen.
La vecina golpea la pared.
Baja el volumen.

Música. Cigarros. Insomnio.
Las tres constantes de su vida.




## MARCOS_DOMINGO_OLLA


Marcos está en la olla.

No en la puerta. No mirando de lejos.
Adentro.

Tiene las manos en los bolsillos.
La postura de alguien que no sabe dónde ponerse.

{marcos_secreto:
Te ve.

"No me mires así."

"..."

"Vine. No sé por qué. No me hagas explicar."
}
{not marcos_secreto:
Te ve. Asiente.

Algo cambió desde ayer.
No sabés qué. Pero algo.
}

- **OPCIÓN:** No decir nada. Estar.
No decís nada.
Él tampoco.

Se quedan así.
Dos tipos en una olla popular un domingo.

No es heroico.
No es revolucionario.

Pero está ahí.



- **OPCIÓN:** Pasarle un mate.
Le pasás un mate.

Lo mira. Lo agarra.

"Hace rato que no tomaba mate con alguien."

Pausa.

"Gracias."

No es solo por el mate.






## IXCHEL_ENCUENTRO_CASUAL


Ves a una mujer barriendo la vereda frente a la mercería.
Es Ixchel. Siempre lleva un huipil colorido bajo el delantal de trabajo.
Se mueve con una parsimonia que contrasta con el ritmo frenético del barrio.

- **OPCIÓN:** Saludar
- **OPCIÓN:** Ofrecerte a ayudarla
- **OPCIÓN:** Seguir de largo


## IXCHEL_SALUDO


"Buen día, Ixchel."

Ella levanta la vista. Sus ojos son profundos, como si vieran más allá de la calle rota.

"Buen día para quien sabe caminarlo", dice con una leve sonrisa.

{not tiene_laburo:
"Lo veo cargando mucho peso en los hombros, joven. No todo lo que pesa es mochila."
- else:
"Que la prisa no le quite el camino."
}



## IXCHEL_AYUDAR


"¿Te doy una mano con eso?"

Ixchel te entrega la escoba sin dudar.
"La limpieza es un acto sagrado. Gracias."


Barrés juntos un rato. El sonido de la paja contra el cemento es hipnótico.

"¿Hace mucho que te viniste de Guatemala?"

"Guatemala vive en mi ombligo, joven. Mi familia cuidaba los cerros, defendiendo la tierra de los que venían con máquinas y papeles a decirnos que el agua tenía dueño."

- **OPCIÓN:** ...
-

"Me vine hace cinco años, cuando los líderes empezaron a no volver a casa."

Hace una pausa. Sus manos siguen barriendo, pero sus ojos miran algo lejano.

"Mi tierra no sabe de fronteras, solo de heridas que aún supuran."



## IXCHEL_IGNORAR


Pasás rápido.
Ixchel sigue barriendo.
Para ella, el tiempo no es algo que se gasta, es algo que se habita.




## IXCHEL_EN_OLLA


Ixchel está en un rincón, separando legumbres con una velocidad asombrosa.
Parece que sus manos tienen ojos propios.

"La diversidad es lo que hace al guiso", dice sin mirarte.

- **OPCIÓN:** "¿Cómo hacés tan rápido?"
"Aprendí de mis abuelas. Ellas decían que el alimento se prepara primero con la intención y después con las manos."
Te invita a sentarte a su lado. A separar lentejas.
- **OPCIÓN:** "Parece un laburo pesado."
"El trabajo duro es el que se hace solo, joven. Dios nos dio manos para compartir la carga. Entre muchos, es celebración."
Te hace un lugar. Te pone un balde de legumbres adelante.


## IXCHEL_COCINAR_JUNTOS



{ resultado_ixchel_cocinar == 2:
Tus manos encuentran el ritmo. Rápido. Preciso.
Ixchel te mira sorprendida.

"Tiene buenas manos, joven. Mi abuela diría que el maíz lo eligió."

Trabajan juntos en silencio. Un silencio sagrado.
El guiso toma forma.

}
{ resultado_ixchel_cocinar == 1:
Separás lentejas. No tan rápido como ella, pero sin parar.
Ixchel asiente. Conforme.

El trabajo compartido habla por los dos.

}
{ resultado_ixchel_cocinar == 0:
Confundís lentejas con piedritas. Dos veces.
Ixchel las saca sin decir nada.

"Despacio. La lenteja no tiene apuro."

Aprendés. Lento, pero aprendés.

}
{ resultado_ixchel_cocinar == -1:
Se te cae el balde. Las lentejas ruedan por el piso.

"Ay, perdón..."

Ixchel se ríe. Sin maldad. Con ternura.

"Mi hermano Tomás hacía lo mismo. Manos de elefante, decía mi abuela."

Juntan las lentejas del piso. Las lavan de vuelta.
El desastre se convirtió en recuerdo compartido.

}



## IXCHEL_PRIMER_ENCUENTRO_OLLA


Sofía te presenta a una mujer de rasgos indígenas.
Piel morena, cabello negro trenzado.
Bajo el delantal de cocina asoma un bordado colorado.

"Ella es Ixchel. Viene de Guatemala. Cocina mejor que todas nosotras juntas."

Ixchel sonríe con modestia.

"Mucho gusto, joven. Bienvenido a la olla."

Te dice "usted" aunque no parece mucho mayor que vos.
Es una formalidad antigua, respetuosa.




## IXCHEL_HISTORIA_TOMAS



Es de noche. La olla ya cerró.
Ixchel lava los platos en silencio.
Vos secás.

El silencio es cómodo hasta que ella lo rompe.

"Tenía un hermano. Tomás."

- **OPCIÓN:** ...
-

"Era catequista, pero no solo de fe. Organizaba a la comunidad. Era vocero del Consejo de Pueblos K'iche'."

"¿Consejo?"

"Los que defendíamos la tierra de las mineras. Goldcorp, una empresa canadiense, vino a sacarnos el oro. Pero el oro estaba debajo de nuestras casas, de nuestros ríos."

- **OPCIÓN:** ...
-

Sus manos siguen lavando, pero más lento.

"Tomás organizaba las consultas. Le preguntábamos al pueblo: ¿quieren la mina? Noventa y ocho por ciento dijo que no. Pero el gobierno ya había dado el permiso. Sin preguntarnos."

"¿Y qué pasó?"

- **OPCIÓN:** ...
-

Silencio largo.

"Un día salió a una reunión y no volvió. Lo encontraron tres días después. La policía dijo 'ajuste de cuentas'. Nadie investigó."

Sigue lavando.

- **OPCIÓN:** "Lo siento mucho."
- **OPCIÓN:** Quedarte en silencio


## IXCHEL_TOMAS_RESPUESTA


"Lo siento, Ixchel."

"Dios lo tiene en su gloria. Y yo lo tengo acá."

Se toca el pecho.

"Cada vez que barró, cada vez que cocino, hago lo que él hacía: cuidar a la comunidad. Eso no lo pueden matar."




## IXCHEL_TOMAS_SILENCIO


No decís nada.
A veces las palabras sobran.

Ixchel sigue lavando.
Vos seguís secando.

El silencio dice lo que la boca no puede.




## IXCHEL_SOBRE_MINA_MARLIN



"¿Sabés lo que es una mina a cielo abierto?"

No esperás la pregunta.

"Más o menos."

"Es cuando le arrancan la piel a la montaña. Usan cianuro para sacar el oro. El cianuro envenena el agua."

- **OPCIÓN:** ...
-

"Mi comunidad, San Miguel Ixtahuacán, está sobre oro. Por eso vinieron. La empresa se llamaba Goldcorp. Canadiense."

"¿Canadá?"

"Sí. Los de lejos vienen a sacar lo de acá. Siempre fue así."

- **OPCIÓN:** ...
-

"El agua empezó a enfermar a la gente. Las explosiones agrietaban las casas. Pero el gobierno decía que era progreso."

Sus ojos se endurecen por un momento.

"Nosotros hicimos consultas. Miles de personas votaron que no querían la mina. Pero los papeles del gobierno valen más que la voz del pueblo."

- **OPCIÓN:** "¿Y qué hicieron?"
"Resistir. Marchar. Bloquear. Y algunos... algunos pagaron con la vida."

Piensa en Tomás. No lo dice, pero vos sabés.


- **OPCIÓN:** "Eso es horrible."
"Es la realidad, joven. Acá y allá, los de arriba toman y los de abajo aguantan. Pero el agua tiene memoria. La tierra tiene memoria. Nosotros también."



## IXCHEL_LLEGADA_URUGUAY



"¿Cómo llegaste acá? ¿A Uruguay, digo?"

Ixchel sonríe, pero sin alegría.

"No lo elegí yo. Lo eligió un formulario."

- **OPCIÓN:** ...
-

"Después de lo de Tomás, empecé a recibir amenazas. Notas debajo de la puerta. Llamadas donde nadie hablaba."

"La puta madre."

- **OPCIÓN:** ...
-

"Una organización, SERPAJ, me contactó. Dijeron que podían sacarme del país por ACNUR. Refugiada."

"Y viniste acá."

"'Uruguay' era un nombre en un papel. No sabía ni dónde quedaba. Solo sabía que era lejos."

- **OPCIÓN:** ...
-

Hace una pausa.

"El primer invierno casi me muero. Ocho grados me parecían el fin del mundo. Una vecina de la pensión me prestó una campera. Nunca se la pude devolver. Se mudó."

Se mira las manos.

"Pero acá estoy. Un día más lejos de la montaña. Un día más cerca de... no sé de qué. Pero sigo."




## IXCHEL_SOBRE_HUIPIL



Notás el bordado que asoma bajo su uniforme de limpieza.

"Eso que llevás... ¿qué es?"

Ixchel sonríe.

"Es mi huipil. La ropa de mi pueblo. Este diseño es de San Miguel Ixtahuacán. Las líneas rojas son el maíz. Las verdes, la montaña."

- **OPCIÓN:** ...
-

"Lo uso debajo del uniforme de trabajo. Nadie lo ve."

"¿Por qué lo usás si nadie lo ve?"

- **OPCIÓN:** ...
-

"Porque yo sé que está ahí."

Se toca el pecho, donde el bordado queda oculto.

"Cuando limpio oficinas, soy invisible. Pero debajo del delantal soy Ixchel Batz Ixcoy, maya-k'iche', hija de la montaña."

- **OPCIÓN:** ...
-

"Ellos ven una empleada. Yo sé quién soy."

Es una armadura invisible.
Te das cuenta de que nunca pensaste en eso.




## IXCHEL_SOBRE_XENOFOBIA


Un vecino pasó y dijo algo ofensivo sobre "los que vienen de afuera".
Ixchel no bajó la cabeza. Ni siquiera dejó de separar las lentejas.

"¿No te jode?", preguntás.

"Él tiene el corazón nublado. Que el Señor lo perdone, porque no sabe que la tierra no le pertenece por un papel. La tierra es de Dios, nosotros solo la caminamos."

Te mira fijo.

"Ustedes los uruguayos a veces tienen miedo de ser nosotros. Pero en el hambre, todos tenemos la misma cara."

- **OPCIÓN:** ...
-

"Además..."

Sonríe levemente.

"Yo estuve frente a soldados con fusiles. Un señor que dice tonterías en la calle no me quita el sueño."




## IXCHEL_COSMOVISION


Ixchel está pelando papas. Murmura algo en un idioma que no entendés.

"¿Qué decías?"

"Le hablaba a la papa."

- **OPCIÓN:** "¿A la papa?"
"El maíz, la papa, el frijol... son seres, joven. No solo comida. Les pedimos permiso antes de comerlos."

- **OPCIÓN:** Sonreír
Ixchel nota tu sonrisa.

"Le parece raro."

"Un poco."

"Es porque ustedes olvidaron. Nosotros todavía recordamos."


## IXCHEL_COSMOVISION_CONT


"Mi abuela decía: 'El maíz no crece para nosotros. Crece con nosotros. Somos parientes'."

- **OPCIÓN:** ...
-

"Por eso cuando cocino, no estoy solo trabajando. Estoy... ¿cómo se dice? Honrando."

- **OPCIÓN:** ...
-

"Acá, en la olla, hacemos lo mismo. Convertimos comida en comunidad. Eso es sagrado."




## IXCHEL_SINCRETISMO


Ixchel tiene una estampita de la Virgen de Guadalupe en su delantal.

"¿Sos católica?"

"Sí. Y también soy maya."

- **OPCIÓN:** "¿No es contradictorio?"

"El Señor es grande. Tiene muchos nombres. Los españoles trajeron a María, pero ella se apareció morena, en el cerro del Tepeyac, hablando náhuatl."

- **OPCIÓN:** ...
-

"Guadalupe no es solo de ellos. Es de nosotros también. Es la madre tierra con otro vestido."


- **OPCIÓN:** "Entiendo."

"No hace falta elegir. Mi abuela rezaba el Padre Nuestro y después le hablaba a la montaña. Dios es grande, joven. Cabe todo."




## IXCHEL_EN_COCINA


Ixchel corta verduras con una precisión de cirujano.
No parece esforzarse. Es natural, como respirar.

"La prisa es de los que olvidaron a dónde van", dice sin levantar la vista.



## IXCHEL_SIRVIENDO


Ixchel sirve los platos con cuidado.
Un poco más para los que tienen cara de hambre.
Una sonrisa para cada uno.

"Buen provecho. Que Dios bendiga."



## IXCHEL_PELANDO


Ixchel pela papas.
Sus manos se mueven solas, como si supieran lo que hacen sin que ella les diga.

Te hace lugar en el banco.

"Siéntese. Hay papas para todos."



## IXCHEL_LLAMAR


Llamás a Ixchel.
Tarda en contestar.

"¿Aló?"

"Hola, Ixchel. ¿Cómo estás?"

"Bien, gracias a Dios. ¿Y usted, joven?"

Siempre tan formal.
Siempre tan respetuosa.



## IXCHEL_CONVERSACION_TELEFONO


Hablan un rato.
Ella cuenta de su trabajo, de la pensión, de las llamadas a Guatemala que salen carísimas.

"Pero mientras haya maíz, hay esperanza."

Su frase favorita.
Te queda sonando.





## IXCHEL_FRAGMENTO_NOCHE


Ixchel prende una vela pequeña en su cuarto.
El olor a copal llena el aire, tapando el olor a humedad de la pensión.

Frente a la vela hay una estampita de la Virgen de Guadalupe.
Al lado, una foto vieja de un hombre joven con camisa blanca.
Tomás.

- **OPCIÓN:** ...
-

Reza en voz baja.
Primero en español. Después en k'iche'.
Las palabras se mezclan, como se mezclaron siempre.

{ixchel_me_conto_de_tomas:
"Hermano, otro día más lejos. Pero no te olvido."
"Cada plato que sirvo es para vos también."
}

- **OPCIÓN:** ...
-

{ixchel_estado == "ayudando":
Piensa en el joven.
En cómo agarró la escoba.
En que todavía hay manos que no tienen miedo de tocar la tierra.

"Tal vez hay esperanza, Tomás."
}

- **OPCIÓN:** ...
-

Mira la foto de las montañas en la pared.
Los volcanes de su tierra. El lago Atitlán al fondo.

"Un día más lejos de la montaña", murmura.
"Pero un día más cerca de Su voluntad y de la comunidad."

- **OPCIÓN:** ...
-

Se envuelve en su rebozo.
Apaga la vela.

{ixchel_hablo_de_huipil:
Debajo de la ropa de dormir, sigue llevando el huipil.
Nadie lo ve.
Pero ella sabe que está ahí.
}

Mañana hay que barrer de nuevo.
Mañana hay que sostener de nuevo.
Mañana hay que seguir siendo Ixchel.




## IXCHEL_Y_ELENA


Elena le pasa el mate a Ixchel.

"Tomá, m'hija."

Ixchel acepta con las dos manos, ceremonial.

"Gracias, doña Elena."

Elena la mira.

"Vos sabés lo que es que te quieran romper. Se te ve en los ojos."

"Usted también, doña."

- **OPCIÓN:** ...
-

Se miran.
Dos guerreras de distintas guerras.
Pero la misma guerra.

"Los de arriba siempre quieren pisarnos", dice Elena.
"Pero acá seguimos. Como las piedras."

Ixchel asiente.

"Como las piedras."




## IXCHEL_Y_DIEGO


Diego e Ixchel descargan cajones juntos.
No hablan mucho. No hace falta.

Los dos saben lo que es huir.
Los dos saben lo que es empezar de cero.
Los dos saben lo que dejaron atrás.

"¿Extrañás Venezuela?", pregunta Ixchel.

"Todos los días."

"Yo también extraño Guatemala. Todos los días."

- **OPCIÓN:** ...
-

Silencio.

"Pero acá estamos", dice Diego.

"Acá estamos", confirma Ixchel.

Es suficiente.




## IXCHEL_Y_JUAN


Juan le pregunta a Ixchel sobre Guatemala.
Como si fuera un documental.

"¿Y los mayas todavía existen? Creía que..."

Ixchel lo mira.
No con enojo. Con paciencia.

"Existimos, sí. Millones. Y seguimos hablando nuestra lengua, tejiendo nuestra ropa, sembrando nuestro maíz."

- **OPCIÓN:** ...
-

Juan se pone un poco incómodo.

"Ah. No sabía. Perdón si..."

"No hay nada que perdonar, joven. Solo aprender."

Le sonríe.
Juan no sabe qué decir.
Pero algo se mueve adentro suyo.



## IXCHEL_FRASE_MAIZ


Ixchel dice, pausada:

"Mientras haya maíz, hay esperanza."

Simple.
Profundo.
Te queda sonando.




## IXCHEL_ENCUENTRO_OLLA



{ixchel_estado == "desconocida":
Hay una mujer que no conocés.
Morena, pelo largo y negro. Trabaja en silencio.
Pela papas más rápido que nadie.

- **OPCIÓN:** Acercarte
"Hola. ¿Primera vez?"
Te mira. Ojos oscuros, profundos.
"No. Vengo hace un mes."
- **OPCIÓN:** Seguir de largo
- else:
Ixchel está en la cocina. Como siempre.

- **OPCIÓN:** Saludarla
"Hola, Ixchel."
Sonríe apenas. "Hola."
- **OPCIÓN:** Trabajar cerca
Te ponés a pelar al lado de ella.
No hace falta hablar.
}


## IXCHEL_CONVERSACION_PROFUNDA



{ixchel_relacion >= 3:
Ixchel te mira diferente hoy.
"¿Puedo contarte algo?"

- **OPCIÓN:** "Claro."

{ resultado_ixchel_comunicar == 2:
"Allá, en Quetzaltenango, mi abuela tejía.
Huipiles con pájaros y montañas.
Cada color tenía un significado."

Pausa.

"Acá limpio grasa. Pero sigo tejiendo.
No con hilos. Con esto."

Señala la olla. La gente.

"La comunidad es un tejido. ¿Entendés?"

Algo te cruza. No solo entendés. Lo sentís.

"Sí. Y cada uno de nosotros es un hilo."

Ixchel sonríe. Amplia. Real.

"Exacto. Ya entendés, joven."

}
{ resultado_ixchel_comunicar == 1:
"Allá, en Quetzaltenango, mi abuela tejía.
Huipiles con pájaros y montañas.
Cada color tenía un significado."

Pausa.

"Acá limpio grasa. Pero sigo tejiendo.
No con hilos. Con esto."

Señala la olla. La gente.

"La comunidad es un tejido. ¿Entendés?"

}
{ resultado_ixchel_comunicar == 0:
"Allá, en Quetzaltenango, mi abuela tejía.
Huipiles con pájaros y montañas."

Pausa.

"Acá es diferente. Pero sigo intentando."

No entendés del todo. Pero escuchás.
A veces eso alcanza.

}
{ resultado_ixchel_comunicar == -1:
"Allá, en Quetzaltenango..."

Se detiene. Te mira.

"No importa. Son cosas mías."

Algo en tu cara la frenó. Quizás incomprensión.
Quizás distancia.
El mundo de Ixchel queda lejos. Demasiado lejos hoy.
}
- **OPCIÓN:** "Ahora no puedo."
Asiente. Sin ofenderse.
"Otro día."
- else:
Ixchel está ocupada. No es momento.
}


## IXCHEL_FRAGMENTO_NOCHE_TEJIDO


Ixchel cierra la puerta de su pieza.
Un cuarto compartido con dos mujeres más.

Se sienta en la cama.
Saca un hilo de colores de debajo de la almohada.

Teje.

Un patrón que su abuela le enseñó.
Pájaros que nunca vio en Montevideo.
Montañas que están a miles de kilómetros.

{ixchel_relacion >= 2:
Hoy alguien le habló en la olla.
No como "la boliviana".
Como Ixchel.
Eso vale más que el sueldo de un mes.
}

Teje hasta que se le cierran los ojos.
El hilo se cae al piso.

En sueños, está en Quetzaltenango.




## FRAGMENTO_IXCHEL_COCINA

Ixchel se lava las manos.
Rojas del agua caliente del restaurante.

El encargado gritó de vuelta.
"Boliviana" de vuelta.

No es boliviana. No importa.
Para ellos todos son lo mismo.

Se mira las manos.
Manos de su abuela. De su madre.
Manos que saben tejer y cocinar y sobrevivir.

Se duerme con las manos doloridas.
Mañana será otro día.



## FRAGMENTO_IXCHEL_ALTAR

Ixchel tiene un altar pequeño.
Debajo de la cama, donde las otras no ven.

Una vela. Una foto de su abuela.
Un hilo de colores.

Reza en K'iche'.
Palabras que no entiende nadie en este país.
Palabras que la sostienen.

{ixchel_relacion >= 2:
Hoy alguien la llamó por su nombre.
No "boliviana". No "india".
Ixchel.
Agrega eso a la oración.
}

La vela se apaga. Se duerme.






## LUNES_AMANECER








## LUNES_SALIR





## LUNES_PARADA_BONDI



{ultima_tirada == 1:
- else:
}


## LUNES_LLEGADA





## LUNES_LLEGADA_TARDE





## LUNES_MANANA





{hable_con_juan_sobre_rumores:
- else:
}


## LUNES_PRE_ALMUERZO_DECISION


¿Qué hacés con la mirada del jefe?

- **OPCIÓN:** Seguir laburando
- **OPCIÓN:** Preguntarle a Juan
- **OPCIÓN:** {energia >= 2} [Hablar con el jefe] # COSTO:1 # DADOS:dignidad # EFECTO:dignidad?


## LUNES_ALMUERZO




12:30.
Hora de comer.

- **OPCIÓN:** Almorzar con Juan
- **OPCIÓN:** Almorzar solo
- **OPCIÓN:** Saltear el almuerzo


## LUNES_TARDE



A las 4, el jefe llama a una reunión.
"Todos al salón grande."

- **OPCIÓN:** Ir con los demás


## LUNES_REUNION




{fue_al_bar_con_juan:
}

A las 5, te vas.




## LUNES_BONDI_VUELTA



El bondi llega al barrio.

- **OPCIÓN:** Ir directo a casa
- **OPCIÓN:** {energia >= 2} [Pasar por algún lado] # COSTO:1 # EFECTO:conexion?


## LUNES_PASAR


¿A dónde?

- **OPCIÓN:** Por la olla
- **OPCIÓN:** Por lo de tu vínculo
- **OPCIÓN:** Por el kiosco


## LUNES_KIOSCO



Pasás por el kiosco.
Comprás algo. Un alfajor. Una coca.

El kiosquero te conoce de vista.

- **OPCIÓN:** ...
-

"¿Qué tal? Cara de cansado hoy."

"Día largo."

{ kiosco_charla == 2:
"¿Sabés qué? Tomá." Te da otro alfajor.
"No te cobro ese. Cara de que lo necesitás."
Le agradecés. A veces la gente te sorprende.
}
{ kiosco_charla == 1:
"Son todos largos." Se queda un rato. "Pero se bancan."
Asentiás. Se bancan.
}
{ kiosco_charla == 0:
"Son todos largos."
Silencio. Nada más.
}
{ kiosco_charla == -1:
"Son todos largos. Y cada vez peor."
Te mira y se da vuelta. Conversación terminada.
Te vas sintiéndote peor que antes.
}



## LUNES_VISITA_VINCULO



{vinculo == "sofia": -> lunes_visita_sofia}
{vinculo == "elena": -> lunes_visita_elena}
{vinculo == "diego": -> lunes_visita_diego}
{vinculo == "marcos": -> lunes_visita_marcos}


## LUNES_VISITA_SOFIA


Pasás por lo de Sofía.
Está en la puerta, los pibes adentro.

"¿Todo bien?"

- **OPCIÓN:** Contarle del laburo
Le contás. Los rumores. La reunión.
"En la olla estamos peor", dice. "Pero entiendo."
- **OPCIÓN:** "Sí, todo bien."
"Si necesitás algo..."


## LUNES_VISITA_ELENA



## LUNES_VISITA_DIEGO


Encontrás a Diego en la esquina.

"¿Qué onda?"
"Acá. Saliendo del depósito."

Hablan un rato.
Diego también tiene miedo.




## LUNES_VISITA_MARCOS


Llamás a Marcos.
No contesta.

"Visto."
No responde.



## LUNES_OLLA



Pasás por la olla.
Sofía está adentro.

"¿Buscás algo?"

- **OPCIÓN:** "Pasaba nomás."
"Si alguna vez querés sumarte a construir..."
- **OPCIÓN:** "¿Puedo ayudar?"
Te ponen a ordenar cosas.
No es mucho. Pero es algo.


## LUNES_IR_CASA





## LUNES_DORMIR


- **OPCIÓN:** Dormir


## LUNES_FRAGMENTOS





{vinculo == "sofia": -> fragmento_sofia_lunes}
{vinculo == "elena": -> fragmento_elena_lunes}
{vinculo == "diego": -> fragmento_diego_lunes}
{vinculo == "marcos": -> fragmento_marcos_lunes}


## FRAGMENTO_SOFIA_LUNES


{dignidad <= 2:
Sofía está agotada.

Piensa en vos.
En cómo te arrastraste hoy.
En cómo aceptaste todo.

"Así termina la gente", piensa.
"Aceptando cualquier cosa."

- **OPCIÓN:** Continuar
}

{conexion <= 1:
Sofía cierra la olla temprano.

Nadie vino.
Otra vez nadie vino.

"¿Para qué?", se pregunta.

Mañana quizás tampoco abra.

- **OPCIÓN:** Continuar
}

Sofía tampoco duerme bien.

Los números de la olla no cierran.
Hace tres meses que no cierran.

Mañana hay que seguir.

- **OPCIÓN:** Continuar


## FRAGMENTO_ELENA_LUNES


{dignidad <= 2:
Elena te vio hoy.

Te vio aceptar.
Te vio agachar la cabeza.
Te vio convertirte en lo que no eras.

"El 2002 también quebró gente así", piensa.
"Los que se dejaron quebrar."

- **OPCIÓN:** Continuar
}

{conexion <= 1:
Elena prende la radio.

Hablan de la crisis.
De los despidos.
De la gente sola.

Apaga la radio.
Ella también está sola.

"Ya nadie se cuida", piensa.

- **OPCIÓN:** Continuar
}

Elena no puede dormir.

La radio dice cosas.
"Antes nos cuidábamos más", piensa.

Apaga la radio.

- **OPCIÓN:** Continuar


## FRAGMENTO_DIEGO_LUNES


{dignidad <= 2:
Diego piensa en vos.

En cómo te vio hoy.
Roto. Doblado.

"Yo también voy a terminar así", piensa.
"Todos terminamos así."

Llama a su madre.
Cuelga antes de que atienda.

- **OPCIÓN:** Continuar
}

{conexion <= 1:
Diego está solo en su pieza.

Nadie lo llamó hoy.
Nadie lo llamó ayer.
Nadie lo va a llamar mañana.

Piensa en Venezuela.
Allá estaba solo.
Acá está solo.

No hay diferencia.

- **OPCIÓN:** Continuar
}

Diego está despierto.

Piensa en su madre.
En Venezuela.
En todo lo que dejó.

- **OPCIÓN:** Continuar


## FRAGMENTO_MARCOS_LUNES


{dignidad <= 2:
Marcos te reconoce.

Ahora sos como él.
Quebrado. Funcional. Vacío.

"Bienvenido", piensa.
Pero no siente nada.

Ya no queda nada que sentir.

- **OPCIÓN:** Continuar
}

{conexion <= 1:
Marcos está solo.

Dejó de esperar que cambie.
Dejó de esperar que alguien llame.
Dejó de esperar.

La gente no se junta.
La gente no se organiza.
La gente no hace nada.

Nunca lo hizo. Nunca lo hará.

- **OPCIÓN:** Continuar
}

Marcos está solo.
Como siempre.

No es felicidad.
Es funcionar.

- **OPCIÓN:** Continuar


## LUNES_CLIFFHANGER


El celular vibra.

Un mensaje de grupo del laburo.

"Mañana reunión de área. Obligatoria."

No dice más.

- **OPCIÓN:** Dormir inquieto


## TRANSICION_LUNES_MARTES

{salud_mental <= 0:
}

{llama <= 0:
}




## MARTES_AMANECER





{almorzamos_juntos:
Juan te saluda de lejos al llegar.
Ayer almorzaron juntos.
Hoy hay algo distinto en el saludo. Más cercano.
}
{conozco_al_kiosquero:
Pasás por el kiosco. El tipo te saluda.
"¿Lo de siempre?"
Parece que ya tenés rutina.
}




## MARTES_BONDI_TENSION



Pero algo se siente diferente hoy.

En el micro, la gente habla de despidos.
En otras empresas, en otros lados.
"La cosa está jodida", dice alguien.

Vos escuchás.
No pensás que te toque a vos.

- **OPCIÓN:** Ir al laburo


## MARTES_LABURO



El laburo hoy está raro.

El jefe no te mira.
Los de RRHH entran y salen.
Hay reuniones que no te incluyen.

{ aguante == 2:
Respirás hondo. Te concentrás en lo tuyo. Si pasa algo, pasa. Pero hoy estás entero.
}
{ aguante == 1:
Intentás no pensar en eso. Te concentrás en la pantalla. Más o menos funciona.
}
{ aguante == 0:
No podés dejar de mirar la puerta de RRHH. Cada vez que se abre, el estómago se cierra.
}
{ aguante == -1:
Las manos te tiemblan. No podés concentrarte en nada. El miedo te paraliza.
}






## MARTES_CITACION


A la tarde, te llaman.




## MARTES_TARDE




El resto del día es largo.
Las horas no pasan.

Pensás en mañana.
En lo que puede ser.
En lo que probablemente sea.




## MARTES_BONDI_VUELTA



A las 5 te vas.

- **OPCIÓN:** Ir a casa
- **OPCIÓN:** {energia >= 2} [Buscar a alguien] # COSTO:1 # STAT:conexion # EFECTO:conexion+


## MARTES_BUSCAR



Necesitás hablar con alguien.
O solo estar con alguien.

{ busqueda == 2:
Salís y te los cruzás enseguida. Como si el barrio supiera que necesitás a alguien.
}
{ busqueda == 1:
Caminás un rato. Los encontrás.
}
{ busqueda == 0:
Tardás en encontrar a alguien. El barrio se siente vacío hoy.
}
{ busqueda == -1:
Caminás y caminás. No hay nadie. Estás por volverte cuando los ves a lo lejos.
La soledad pega más fuerte cuando la buscás romper y no podés.
}

{vinculo == "sofia": -> martes_buscar_sofia}
{vinculo == "elena": -> martes_buscar_elena}
{vinculo == "diego": -> martes_buscar_diego}
{vinculo == "marcos": -> martes_buscar_marcos}


## MARTES_BUSCAR_SOFIA


Pasás por la olla.
Sofía está cerrando.

"Hoy saliste temprano."

"Mañana tengo una reunión."

Ella te mira.
Entiende.

"Si necesitás algo..."

"Gracias."

No decís más.
No hay más que decir.




## MARTES_BUSCAR_ELENA


Pasás por lo de Elena.
Está en la vereda.

"¿Todo bien?"

"Mañana tengo una reunión en el laburo."

Elena te mira.
Ha visto esto antes.

"Vení, tomá algo."

Te sentás.
Ella no dice nada esperanzador.
No dice que todo va a estar bien.
"Acá estamos", dice. "Resistiendo."
Solo está.




## MARTES_BUSCAR_DIEGO


Encontrás a Diego saliendo del depósito.

"¿Qué onda?"

"Nada. Mañana tengo una reunión."

Diego entiende.
Él vive con eso todos los días.
La precariedad.

"Si pasa algo, avisame."

"Dale."




## MARTES_BUSCAR_MARCOS


Llamás a Marcos.
No contesta.

Mandás mensaje.
"Visto" pero no responde.

Así es Marcos ahora.
Presente pero ausente.



## MARTES_CASA



Llegás a casa.
La noche es larga.

No dormís bien.

- **OPCIÓN:** ...
-

En lo que viene.

Pensás en lo que viene. Si te echan, no hay nada.
La "unipersonal" fue el invento perfecto: les diste tres años de tu vida y ellos no te deben ni el saludo.
Sin indemnización. Sin despido. Sin red.
Solo una factura que ya no vas a emitir.
- **OPCIÓN:** Intentar dormir


## FRAGMENTO_MARTES





{vinculo == "sofia": -> fragmento_sofia_martes}
{vinculo == "elena": -> fragmento_elena_martes}
{vinculo == "diego": -> fragmento_diego_martes}
{vinculo == "marcos": -> fragmento_marcos_martes}


## FRAGMENTO_MARTES_DEFAULT


La noche pasa despacio.
El barrio duerme.
Vos no.

- **OPCIÓN:** ...
-

Pensás en el laburo.
En lo que significa.
En lo que sos sin él.

- **OPCIÓN:** ...
-

¿Quién sos sin eso?
Mañana vas a saber.

- **OPCIÓN:** Continuar


## FRAGMENTO_SOFIA_MARTES


{dignidad <= 2:
Sofía piensa en vos.

En cómo te vio hoy.
Roto antes de tiempo.

"Así empiezan a caer", piensa.
"Primero la dignidad. Después todo."

Conoció a tantos que terminaron así.
Ahora vos también.

- **OPCIÓN:** Continuar
}

{conexion <= 1:
Sofía está sola en la olla.

Nadie ayudó hoy.
Nadie preguntó.

"El barrio se muere", piensa.

Antes la gente se juntaba.
Ahora cada uno en su casa.
Cada uno solo.

- **OPCIÓN:** Continuar
}



Sofía tampoco duerme bien.

La olla necesita cosas.
Siempre necesita cosas.
Y cada vez hay menos.

- **OPCIÓN:** ...
-

Piensa en mañana.
En la comida que hay que conseguir.
En la gente que viene.

- **OPCIÓN:** ...
-

El barrio la necesita.
Eso la mantiene despierta.

- **OPCIÓN:** Continuar


## FRAGMENTO_ELENA_MARTES


{dignidad <= 2:
Elena prende la radio.

Hablan de despidos masivos.
De gente que se rompe.

Piensa en vos.
En lo que vio en tu cara.

"El 2002 quebró a muchos así", piensa.
"Los que aceptaron todo hasta que no quedó nada."

Raúl también estuvo cerca.
Muy cerca.

- **OPCIÓN:** Continuar
}

{conexion <= 1:
Elena mira por la ventana.

El barrio oscuro.
Todas las ventanas cerradas.

"Ya nadie se conoce", piensa.
"Ya nadie toca el timbre del vecino."

Cuando Raúl murió, tres vecinos vinieron.
Tres.

Antes hubiera sido el barrio entero.

- **OPCIÓN:** Continuar
}



Elena está con la radio.

Las noticias hablan de ajustes.
De despidos.
De lo que viene.

Ella ya vio esto antes.
Sabe cómo termina.
Sabe que solo juntos se sale.

Apaga la radio.
Mañana hay que estar atentos.

- **OPCIÓN:** Continuar


## FRAGMENTO_DIEGO_MARTES


{dignidad <= 2:
Diego piensa en vos.

En lo que te vi aceptar hoy.
Todo. Sin pelear.

"Yo voy a terminar igual", piensa.

Dejó Venezuela para esto.
Para terminar roto en otro país.
Igual de roto.
Igual de solo.

Su madre preguntó cómo estaba.
Mintió.

- **OPCIÓN:** Continuar
}

{conexion <= 1:
Diego cuenta sus contactos.

Tres personas hablan con él.
Tres.

En Venezuela no tenía muchos.
Acá tiene menos.

"Vine a estar solo en otro idioma", piensa.

La pieza alquilada.
El depósito.
Nadie.

- **OPCIÓN:** Continuar
}



Diego mira el techo.

El depósito anda raro.
Hablan de "reestructuración".
Él sabe qué significa eso.

Piensa en su madre.
En Venezuela.
En todo lo que dejó para venir acá.

No puede perder esto también.

- **OPCIÓN:** Continuar


## FRAGMENTO_MARCOS_MARTES


{dignidad <= 2:
Marcos te reconoce en la distancia.

Ahora sos como él.
Alguien que acepta.
Alguien que se dobla.

"Bienvenido", piensa.

Antes también era diferente.
Antes también tenía dignidad.

Ahora solo funciona.
Vos también vas a funcionar.
Solo funcionar.

- **OPCIÓN:** Continuar
}

{conexion <= 1:
Marcos mira los mensajes sin leer.

Quince personas que intentaron.
Quince personas que dejó de lado.

La asamblea del barrio.
La olla.
Los amigos.

Todo se cayó.
Todo se va a seguir cayendo.

La gente no cambia nada.
Nunca cambió nada.

- **OPCIÓN:** Continuar
}



Marcos está despierto.

La tele encendida.
El celular con mensajes sin leer.
No quiere hablar con nadie.

Antes era diferente.
Antes tenía ganas.
Ahora solo funciona.

Mañana será igual.
Siempre es igual.

- **OPCIÓN:** Continuar


## MARTES_CLIFFHANGER


El celular vibra.

Es de RRHH.

"Confirmamos reunión mañana 11 AM. Sala 3."

No dice más.
Pero sabés que no es bueno.

- **OPCIÓN:** Intentar dormir


## TRANSICION_MARTES_MIERCOLES

{salud_mental <= 0:
}

{llama <= 0:
}




## MIERCOLES_AMANECER





No dormiste bien.
Hoy es la reunión con RRHH.

- **OPCIÓN:** ...
-


{energia < 4: Te levantás con menos energía que ayer. La tensión se siente en el cuerpo.}

- **OPCIÓN:** ...
-

El café no calienta igual, o vos no sentís el calor igual.

Sabés que algo viene. No sabés qué.

- **OPCIÓN:** Ir al laburo


## MIERCOLES_LABURO




Llegás. Todo parece normal.
Los compañeros hacen lo de siempre.
Pero hay algo en el aire.

- **OPCIÓN:** ...
-

El jefe no te mira. Eso es raro.

A las 11 te llaman.

- **OPCIÓN:** Ir a la reunión


## MIERCOLES_REUNION





{ golpe == 2:
Algo en vos se endurece. No se quiebra. Se endurece.
"Esto no me define", pensás. Y por ahora, lo creés.
}
{ golpe == 1:
Respirás. Tragás. Seguís caminando.
No está bien, pero podés con esto. Ahora.
}
{ golpe == 0:
El pasillo se siente largo. Las piernas pesan.
La cabeza repite: "tu puesto fue afectado."
Fue. Afectado. Como si fuera algo que pasó solo.
}
{ golpe == -1:
Se te nubla la vista. Tenés que parar en el baño.
Te mirás al espejo. No te reconocés.
Las manos tiemblan. El aire no entra bien.
}

Alguien te dice "suerte" sin mirarte a los ojos.

Salís.

- **OPCIÓN:** Ir a la calle


## MIERCOLES_SALIDA




{idea_quien_soy:


No la elegiste. Llegó sola.
La empresa te convenció de que eras un "socio estratégico".
Ahora sos solo un número que ya no suma.

La pregunta quema. ¿Sos lo que hacés o lo que sos cuando nadie te paga?
}


¿Qué hacés?

- **OPCIÓN:** Ir a casa a procesar
- **OPCIÓN:** Caminar sin rumbo
- **OPCIÓN:** Ir al barrio, buscar a alguien


## MIERCOLES_FLASHBACK


Salís del edificio.
El sol pega.
Es mediodía.

- **OPCIÓN:** ...
-

{perdida == "familiar":
Por un segundo, ves a tu vieja en la calle.
No es ella. No puede ser.
Pero por un segundo...
Recordás cuando te dijo:
"Mientras tengas laburo, estás bien."
Ya no tenés laburo.
El fantasma se desvanece.
}

{perdida == "relacion":
Pensás en llamar a alguien.
Por un segundo, tu dedo va al contacto.
Todavía está ahí.
No lo borraste.
No llamás.
Pero por un segundo, quisiste.
}

{perdida == "futuro":
Recordás cuando tenías un plan.
Ibas a ser algo.
Tenías una forma.
Ahora no hay forma.
Solo hay esto.
Un mediodía, sin laburo.
}

{perdida == "vacio":
Hay algo.
No sabés qué.
Ese vacío que siempre estuvo.
Ahora más grande.
O quizás siempre fue así de grande.
Y recién ahora lo ves.
}



## MIERCOLES_CASA




Llegás a casa.
La casa vacía a las 12 del mediodía.
Nunca la viste así a esta hora.

- **OPCIÓN:** ...
-

Te sentás.
No prendés la tele.
No hacés nada.

Solo te sentás.

{energia <= 1: Estás destruido. No podés hacer nada más hoy.}

- **OPCIÓN:** {energia > 1} [Llamar a alguien] -> miercoles_llamar
- **OPCIÓN:** Quedarte ahí


## MIERCOLES_CAMINAR



Caminás.
No sabés bien a dónde.
Las calles de siempre pero distintas.

- **OPCIÓN:** ...
-

Porque ahora tenés tiempo.
Demasiado tiempo.

Pasás por la plaza.

- **OPCIÓN:** ...
-

El tipo que duerme en el banco sigue ahí.
Lo viste mil veces. Hoy lo mirás diferente.

No estás como él. Tenés tres meses.
Pero la distancia se siente más corta.

- **OPCIÓN:** Seguir caminando
- **OPCIÓN:** Ir a casa


## MIERCOLES_BARRIO


El barrio.
Tu barrio.

A esta hora hay gente.
Gente que no ves normalmente porque estás laburando.

- **OPCIÓN:** ...
-

Sofía está saliendo de su casa.
Te ve.

- **OPCIÓN:** Acercarte
- **OPCIÓN:** Evitarla, seguir de largo


## MIERCOLES_EVITAR



Bajás la cabeza.
Seguís de largo.
No querés hablar con nadie.

Pero Sofía te vio.
Y vos la viste ver.

- **OPCIÓN:** Ir a casa


## MIERCOLES_SOFIA


"¿Qué hacés acá a esta hora? ¿No tenías laburo?"

La pregunta pega.

- **OPCIÓN:** Contar lo que pasó
- **OPCIÓN:** Evadir: "Salí temprano hoy"


## MIERCOLES_EVADIR


"Salí temprano hoy."

Sofía te mira.
No te cree, pero no insiste.

"Bueno. Si necesitás algo..."

Deja la frase ahí.


- **OPCIÓN:** Ir a casa


## MIERCOLES_CONTAR



"Me echaron."

Sofía no dice nada por un momento.
Después:

"Mierda."

"Sí."

"¿Estás bien?"

"No sé."

{ abrirse == 2:
Se queda un rato. No dice nada esperanzador, no dice que todo va a estar bien.
Pero algo en su silencio te sostiene. Sentís que podés con esto.
}
{ abrirse == 1:
Se queda un momento. No te abraza, no te dice que todo va a estar bien.
Eso lo agradecés.
}
{ abrirse == 0:
Se queda un momento. Pero se nota que tiene la cabeza en otro lado.
La olla, los pibes, todo lo que la aplasta a ella también.
}
{ abrirse == -1:
Se te quiebra la voz. Mierda. No querías llorar.
Sofía te mira. No dice nada. Esperás que no le cuente a nadie.
}

- **OPCIÓN:** ...
-

"Mirá, la olla anda complicada, pero si querés venir a dar una mano... a veces ayuda hacer algo."

- **OPCIÓN:** Decir que sí
- **OPCIÓN:** Decir que no sabés
- **OPCIÓN:** Preguntar qué pasa con la olla


## MIERCOLES_PREGUNTA_OLLA


"¿Qué pasa con la olla?"

Sofía suspira.

"No tenemos para el viernes. Las donaciones bajaron. Estamos viendo qué hacer."


Otra cosa que cae.
Todo cae junto.

- **OPCIÓN:** Ofrecer ayuda
- **OPCIÓN:** Decir que no sabés si podés


## MIERCOLES_SI_OLLA



"Puedo venir. Ahora tengo tiempo."

Sofía medio sonríe.
No es una sonrisa feliz.
Es una sonrisa de "al menos algo".

"Mañana a la tarde estamos. Si te da."

Asiente y se va.
Tenés algo para mañana.
No es mucho. Pero es algo.

- **OPCIÓN:** Ir a casa


## MIERCOLES_NOSABE_OLLA


"No sé si puedo. Tengo que... no sé."

Sofía asiente.

"Obvio. Si necesitás algo, avisá."

Se va.

Te quedás solo.

- **OPCIÓN:** Ir a casa


## MIERCOLES_LLAMAR


¿A quién llamás?

- **OPCIÓN:** {vinculo == "sofia"} [A Sofía] -> miercoles_llamar_sofia
- **OPCIÓN:** {vinculo == "elena"} [A Elena] -> miercoles_llamar_elena
- **OPCIÓN:** {vinculo == "diego"} [A Diego] -> miercoles_llamar_diego
- **OPCIÓN:** {vinculo == "marcos"} [A Marcos] -> miercoles_llamar_marcos
- **OPCIÓN:** A nadie. Mejor no.


## MIERCOLES_LLAMAR_ELENA



Elena contesta al segundo ring.

"¿Qué pasó?"

Le contás. Ella escucha.
Cuando terminás, hay silencio.

- **OPCIÓN:** ...
-

"En el 2002 cerraron el frigorífico donde laburaba Raúl."

Raúl era su marido.

- **OPCIÓN:** ...
-

"Tres meses estuvo sin laburo. Yo trabajaba limpiando. Los pibes eran chicos. La olla del barrio nos salvó ese invierno."

"No sabía."

"No lo contamos mucho. Pero pasó. Y acá seguimos."

- **OPCIÓN:** "¿Cómo hicieron?"
- **OPCIÓN:** "Gracias por contarme."


## MIERCOLES_ELENA_COMO


"¿Cómo hicieron?"

"Juntos. No había otra. La gente se juntó. Los que tenían compartían con los que no. No fue lindo. Pero fue lo que hubo."




Es una idea heredada. De Elena. De Raúl. De los que estuvieron antes.

- **OPCIÓN:** Internalizar
La internalizás. La red o la nada.
No es optimismo. Es lo único que hay.
- **OPCIÓN:** Dejar pasar


## MIERCOLES_ELENA_GRACIAS


"Gracias por contarme."

"Para eso estamos."



## MIERCOLES_ELENA_FIN


Cortás.
Te sentís un poco menos solo.

- **OPCIÓN:** Ir a la noche


## MIERCOLES_LLAMAR_SOFIA



Llamás a Sofía. Contesta enseguida, de fondo se escuchan los pibes gritando.

"Hola. ¿Todo bien?"

Le contás. La reunión, el despido, el frío en el pecho.

"Puta madre. Lo siento mucho, de verdad."

Pausa. Se escucha que le dice a uno de los hijos que se baje de la mesa.

"Mirá, hoy estamos a mil, pero mañana venite a la olla. A veces lo mejor es tener las manos ocupadas para que la cabeza no piense tanto."

- **OPCIÓN:** "Voy a ir."
- **OPCIÓN:** "No sé si puedo."


## MIERCOLES_LLAMAR_DIEGO



Diego contesta.

"¿Hola?"

"Diego, soy yo."

"¿Qué onda? ¿No estás laburando?"

Le contás.

"La puta madre."

"Sí."

"¿Estás bien?"

"No sé."

Hay un silencio.

"Yo tengo miedo de que me pase lo mismo. En el depósito andan raros también."

Diego también tiene miedo.
No estás solo en eso.

"Si necesitás algo, avisá. No tengo mucho pero..."

"Gracias, Diego."

- **OPCIÓN:** Ir a la noche


## MIERCOLES_LLAMAR_MARCOS


Marcos no contesta.
El teléfono suena y suena.

Bueno.
No esperabas otra cosa.

- **OPCIÓN:** Ir a la noche


## MIERCOLES_NOCHE







La noche llega.
Primer día sin laburo.

Te acostás pero no dormís.
La cabeza no para.

- **OPCIÓN:** ...
-

La tarjeta. El alquiler. La obra social.
Tenés tres meses. Tres meses para resolver algo.

La cuenta regresiva empezó.

{conte_a_alguien: Al menos alguien sabe. No estás completamente solo.}
{not conte_a_alguien: No le contaste a nadie. El peso es solo tuyo.}



## FRAGMENTO_MIERCOLES




{conte_a_alguien && vinculo == "sofia":
}
{conte_a_alguien && vinculo == "diego":
}
{conte_a_alguien && vinculo == "elena":
}
{conte_a_alguien && vinculo == "marcos":
}
{vinculo == "marcos": -> fragmento_marcos_miercoles}
{vinculo == "sofia": -> fragmento_sofia_miercoles}
{vinculo == "elena": -> fragmento_elena_miercoles}


## FRAGMENTO_SOFIA_MIERCOLES


{dignidad <= 2:
Sofía piensa en vos.

En cómo te vio salir del edificio.
Vacío. Roto.

"Así empiezan todos", piensa.
"Primero el despido. Después la nada."

La olla está llena de gente así.
Gente que era otra cosa.
Ahora solo sobreviven.

Vos vas a ser uno más.

- **OPCIÓN:** Continuar
}

{conexion <= 1:
Sofía está en la olla vacía.

Hoy nadie vino a ayudar.
Mañana tampoco van a venir.

"El barrio se deshace", piensa.

Cada uno con su problema.
Cada uno solo.
Ya nadie viene.

La olla va a cerrar.
Es cuestión de tiempo.

- **OPCIÓN:** Continuar
}

Sofía tampoco puede dormir.

Está en la cocina, con la calculadora.
Los números de la olla no cierran.
Nunca cierran.

- **OPCIÓN:** ...
-

Piensa en vos.
Otro que cayó.
Pero también: otra persona que puede ayudar.

- **OPCIÓN:** ...
-

No es que se alegre de que te echaron.
Pero hay algo en que no estés solo.
En que quizás vengas mañana.

Apaga la luz.
Mañana hay que seguir.

- **OPCIÓN:** Continuar


## FRAGMENTO_DIEGO_MIERCOLES


{dignidad <= 2:
Diego piensa en vos.

En cómo te vio hoy.
Destruido. Humillado.

"Yo también voy a terminar así", piensa.
"Todos los que venimos de afuera terminamos así."

Dejó todo en Venezuela.
Para esto.
Para ver cómo te rompen en otro país.

Su madre preguntó cómo estaba.
"Bien, má."
Mentira.

Todo es mentira.

- **OPCIÓN:** Continuar
}

{conexion <= 1:
Diego está solo en su pieza.

Llegó hace dos años.
Tiene tres contactos en el celular.
Tres.

"Vine acá para estar solo en otro idioma", piensa.

En Venezuela no tenía a nadie.
Acá no tiene a nadie.

No hay diferencia.
Nunca hubo.

- **OPCIÓN:** Continuar
}

Diego está en su pieza.
Alquilada, chica, con olor a humedad.

Piensa en vos.
En lo que le contaste.
En que podría ser él mañana.

- **OPCIÓN:** ...
-

Llama a su madre.
"Sí, má, todo bien."
Miente.

Cuelga.
Mira el techo.

- **OPCIÓN:** ...
-

No sabe qué hacer.
Quiere ayudarte pero no sabe cómo.
Quiere ayudarse pero no sabe cómo.

Mañana te va a buscar.
No sabe para qué. Pero te va a buscar.

- **OPCIÓN:** Continuar


## FRAGMENTO_ELENA_MIERCOLES


{dignidad <= 2:
Elena piensa en Raúl.

Él también se rompió.
En el 2002, cuando cerró el frigorífico.

Por tres meses fue otra persona.
Vacía. Derrotada.

Piensa en vos.
En tu voz hoy.

"Ya empezó a romperse", piensa.
Y sabe que es difícil volver de eso.

Raúl nunca volvió del todo.
Murió un poco roto.

- **OPCIÓN:** Continuar
}

{conexion <= 1:
Elena está sola.

Raúl murió hace tres años.
Los hijos viven lejos.

El barrio ya no es lo que era.
Ya nadie se junta.
Ya nadie toca timbre.

"Nos volvimos un país de solos", piensa.

Antes había red.
Ahora hay puertas cerradas.

- **OPCIÓN:** Continuar
}

Elena no puede dormir.

Piensa en Raúl.
En el 2002.
En cómo pensó que no iban a salir.
Y salieron. Juntos.

Piensa en vos.
En lo que le contaste.
En la voz que tenías.

Mañana te va a llamar.
Va a ver cómo estás.
Es lo que se hace.

Prende la radio bajito.
Algo de compañía en la oscuridad.

- **OPCIÓN:** Continuar


## FRAGMENTO_MARCOS_MIERCOLES


{dignidad <= 2:
Marcos piensa en vos.

Ahora somos iguales.
Dos descartes del sistema.

"Ya vas a entender", piensa.
"Que no importa cuánto te esfuerces."
"Al final, sos solo una pieza que se cambia."

Él ya no pelea.
Espera que vos tampoco lo hagas.
Es más fácil así.

- **OPCIÓN:** Continuar
}

{conexion <= 1:
Marcos mira el teléfono.

Vio tu llamada perdida.
Vio el mensaje.

No respondió.

"Para qué", se pregunta.
"Un despedido consolando a otro despedido."
"Una miseria compartida no es menos miseria."

Mejor el silencio.
En el silencio no hay que fingir nada.

- **OPCIÓN:** Continuar
}

Marcos mira la tele.
Programas de política que ya no le dicen nada.
Gente de traje hablando de "macroeconomía" mientras el barrio se cae a pedazos.

Piensa en vos.
En que te echaron.
En que ahora sabés lo que se siente.

"Cagaste, uruguayo", murmura para el cuarto vacío.

Pero hay algo en su mirada.
Un resto de bronca que todavía no se convirtió en ceniza.

Mañana será otro día.

- **OPCIÓN:** Continuar


## TRANSICION_MIERCOLES_JUEVES

{salud_mental <= 0:
}

{llama <= 0:
}





## JUEVES_AMANECER





{conte_a_alguien:
El celular tiene un mensaje.
{vinculo == "sofia": Sofía: "¿Cómo amaneciste?"}
{vinculo == "elena": Elena: "Pensé en vos anoche. Pasá si querés."}
{vinculo == "diego": Diego: "Che, cualquier cosa avisá."}
{vinculo == "marcos": Marcos no escribió. Pero vos sabés que sabe.}
{vinculo == "ixchel": Ixchel: "Buenos días. Hoy cocino temprano si querés venir."}
}
{not conte_a_alguien:
Silencio.
El celular no suena.
Nadie sabe.
Nadie va a preguntar.
}

Te despertás.
Por un segundo, pensás que tenés que ir a laburar.

Después te acordás.

- **OPCIÓN:** ...
-

Ya no tenés laburo.

El despertador no sonó porque lo apagaste.
¿Para qué madrugar?


- **OPCIÓN:** Levantarte igual
- **OPCIÓN:** Quedarte en la cama


## JUEVES_CAMA



Te quedás.
Mirás el techo.
Pensás.

¿Cuánto duran tres meses?
¿Cuánto tarda en aparecer otro laburo?
¿Qué pasa si no aparece?

La cabeza no para.

Eventualmente te levantás.
El cuerpo no aguanta más la cama.



## JUEVES_MANANA


Te levantás.
El café.
La rutina, pero vacía.

Moler.
Agua caliente.
Prensa francesa.

- **OPCIÓN:** ...
-

El único mecanismo de supervivencia que hoy parece confiable.

Antes el café era apurado, entre ducharte y salir.
Ahora tenés todo el tiempo del mundo.

- **OPCIÓN:** ...
-

Demasiado tiempo.



## JUEVES_MANANA_TARDE


Son las 10 de la mañana.
Normalmente estarías laburando.

Ahora estás acá.
En tu casa.
Sin saber qué hacer.

{conte_a_alguien: Al menos alguien sabe. No estás completamente solo en esto.}
{not conte_a_alguien: Nadie sabe todavía. El peso es solo tuyo.}

¿Qué hacés hoy?

- **OPCIÓN:** Buscar laburo online
- **OPCIÓN:** Ir al barrio
- **OPCIÓN:** Quedarte en casa


## JUEVES_BUSCAR_LABURO



Abrís las páginas de empleo.
Hay ofertas.
Pocas que sirvan.

- **OPCIÓN:** ...
-

"Se busca. Experiencia mínima 5 años."
"Se busca. Hasta 25 años."
"Se busca. Disponibilidad full time. Pago por productividad."

- **OPCIÓN:** ...
-

Mandás algunos CVs.
No esperás respuesta.
Pero hay que hacer algo.


{energia > 0: Todavía podés hacer algo más hoy.}

- **OPCIÓN:** {energia > 0} [Salir al barrio] -> jueves_barrio
- **OPCIÓN:** Ya fue, quedarse


## JUEVES_QUEDARSE



Te quedás.
La tele.
El celular.
Nada.

Las horas pasan.
No hacés nada.
No hablás con nadie.

Es fácil quedarse.
Demasiado fácil.

- **OPCIÓN:** Ir a la noche


## JUEVES_BARRIO


Salís.

- **OPCIÓN:** Ir a la olla
- **OPCIÓN:** Caminar nomás
- **OPCIÓN:** Buscar a tu vínculo


## JUEVES_CAMINAR



El tipo que duerme en la plaza sigue ahí.
Lo viste mil veces.
Hoy lo mirás diferente.

- **OPCIÓN:** ...
-

No sos él.
Tenés tres meses.
Pero la distancia se siente más corta.

- **OPCIÓN:** Volver a casa
- **OPCIÓN:** Ir a la olla


## JUEVES_OLLA




Sofía está ahí.
Y otra gente que no conocés bien.


{conte_a_alguien && vinculo == "sofia":
}

{not conte_a_alguien || vinculo != "sofia":
- **OPCIÓN:** "Me echaron ayer."

{ resultado_jueves_abrirte == 2:
Sofía asiente. Algo en tu voz fue real. Crudo.
"Gracias por contarlo. No es fácil."
Te pone una mano en el hombro. Firme.
"Acá nadie juzga. ¿Querés dar una mano?"
}
{ resultado_jueves_abrirte == 1:
Sofía asiente. No dice "qué bajón" ni "vas a conseguir algo".
Solo asiente.
"Bueno. ¿Querés dar una mano?"
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
}
- **OPCIÓN:** "Tenía el día libre."
Sofía te mira.
No te cree.
Pero no insiste.
}


## JUEVES_OLLA_PREGUNTA


¿Querés ayudar?

- **OPCIÓN:** Sí
- **OPCIÓN:** Solo vine a ver


## JUEVES_OLLA_VER


"Solo vine a ver."

Sofía asiente.
"Bueno. Cuando quieras."


{not vino_marcos:
De reojo, ves a alguien en la esquina.
Campera oscura. Cabeza gacha.

Es Marcos.

Está mirando la olla desde lejos.
Como si quisiera entrar pero una pared invisible lo frenara.

- **OPCIÓN:** Salir a buscarlo
Salís rápido.
Pero Marcos te ve venir.
Gira y se va. Casi corriendo.

La vergüenza es más rápida que vos.
- **OPCIÓN:** Dejarlo mirar
Lo dejás estar.
A veces, mirar es el primer paso.

Se queda un minuto más. Y se va.
}


### jueves_olla_ver_post


- **OPCIÓN:** Irte


## JUEVES_OLLA_AYUDAR



{ixchel_relacion == 0:
En la cocina hay alguien que no conocés.

Una mujer baja, morena, pelo largo recogido.
Pica verduras con una precisión que parece innata.

}
{ixchel_relacion >= 1:
Ixchel está en la cocina.
Te saluda con un gesto breve.

}


"Si no conseguimos algo para el viernes, no sé qué hacemos", dice alguien.

Sofía no dice nada.
Solo sigue cocinando.

{idea_tengo_tiempo == false:


Antes no podías.
Laburabas, llegabas cansado, no había espacio.
Ahora sí.

- **OPCIÓN:** Internalizar la idea
Ahora tenés tiempo.
No es consuelo. Pero es algo que podés dar.
- **OPCIÓN:** Dejar pasar
- else:
}


## JUEVES_OLLA_FIN


Terminás de ayudar.
Son las 3 de la tarde.


- **OPCIÓN:** Ir a casa


## JUEVES_BUSCAR_VINCULO


{vinculo == "sofia": -> jueves_olla}
{vinculo == "elena": -> jueves_elena}
{vinculo == "diego": -> jueves_diego}
{vinculo == "marcos": -> jueves_marcos}


## JUEVES_ELENA


Buscás a Elena.
No está en la plaza. No está en su casa.

Probás en la olla.



Ahí está.
Sentada en un banquito.
Pelando papas.

"Ah, m'hijo. Vos acá."

- **OPCIÓN:** Sentarte a pelar con ella
- **OPCIÓN:** Solo saludar y mirar
"Solo pasaba a saludar."
"Bueno. Cuando quieras, agarrá un cuchillo."


## JUEVES_CHARLA_ELENA



Te sentás a su lado.
Agarrás un cuchillo.
Un balde de papas entre los dos.

Estás en la cocina de la olla.
Elena pela papas a tu lado.

- **OPCIÓN:** ...
-


{elena_relacion >= 3:
}

{escuche_sobre_2002:
}


{
- resultado == 2:  // Crítico


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


{idea_pedir_no_debilidad == false:


Hay algo en el silencio compartido.
En estar sin tener que explicar.
En ayudar sin que te lo pidan.

- **OPCIÓN:** Internalizar la idea



Pedir ayuda no es debilidad.
Estar para alguien no es caridad.
Es lo que se hace.
- **OPCIÓN:** Dejar pasar
- else:
}

- resultado == 1:  // Éxito


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


Hay algo cómodo en el silencio compartido.
Las manos ocupadas. La mente quieta.



- resultado == -1:  // Fumble


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



- else:  // Fallo normal


Pelás en silencio.
Elena también.

El trabajo fluye.
Sin palabras.

No está mal.
A veces el silencio es suficiente.

Las papas se acumulan.
El tiempo pasa.


}


## JUEVES_ELENA_FIN


Terminás de ayudar.
Las manos mojadas. El olor a papa.

Elena asiente.
"Gracias por la mano, m'hijo."

- **OPCIÓN:** Irte


## JUEVES_DIEGO




- **OPCIÓN:** Caminar juntos un rato
- **OPCIÓN:** Irte


## JUEVES_MARCOS



- **OPCIÓN:** Irte


## JUEVES_NOCHE






Primer día completo sin laburo.

Te acostás temprano.
¿Para qué quedarse despierto?

- **OPCIÓN:** ...
-

La cabeza sigue dando vueltas.
Tres meses.
Noventa días.
La cuenta regresiva.


{ resultado_jueves_noche == 2:
Pero algo te frena el espiral.
Un pensamiento claro entre la niebla:
"Hoy pasó el primer día. Y seguís acá."
No es mucho. Pero es suficiente para cerrar los ojos.
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
}

{vinculo == "sofia" || vinculo == "elena" || vinculo == "diego":
}

El viernes viene.
La olla necesita resolver algo.
Vos también.

- **OPCIÓN:** Dormir


## FRAGMENTO_JUEVES




{vinculo == "sofia": -> fragmento_sofia_jueves ->}
{vinculo == "elena": -> fragmento_elena_jueves ->}
{vinculo == "diego": -> fragmento_diego_jueves ->}
{vinculo == "marcos": -> fragmento_marcos_jueves ->}



## FRAGMENTO_MARCOS_JUEVES


{dignidad <= 2:
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

{ chance(50):
}
}

{conexion <= 1:
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

{ chance(60):
}
}



Marcos tampoco duerme.

El departamento vacío.
La tele encendida sin sonido.
Los mensajes sin responder.

Pensó en ir a la asamblea.
No fue.
Es más fácil no ir.

Mañana es otro día igual.



## FRAGMENTO_SOFIA_JUEVES


{dignidad <= 2:
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

{ chance(50):
}
}

{conexion <= 1:
Sofía está sola en la cocina.

Hoy vino poca gente.
Mañana va a venir menos.

"La olla se muere", piensa.

Cuando empezó, el barrio se juntaba.
Ahora cada uno se salva solo.

O no se salva.

La llama se apaga.
Y ella no sabe cómo volver a prenderla.

{ chance(60):
}
}





Mañana hay que buscar soluciones.



## FRAGMENTO_ELENA_JUEVES


{dignidad <= 2:
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

{ chance(50):
}
}

{conexion <= 1:
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

{ chance(60):
}
}






## FRAGMENTO_DIEGO_JUEVES


{dignidad <= 2:
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

{ chance(50):
}
- **OPCIÓN:** Continuar
}

{conexion <= 1:
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

{ chance(60):
}
}






## FRAGMENTO_COMUN_JUEVES



{fui_a_olla_jueves && vinculo != "sofia":
}

El barrio duerme.
Los problemas no.

- **OPCIÓN:** Continuar

{fui_a_olla_jueves:
}

- **OPCIÓN:** Continuar


## JUEVES_CLIFFHANGER


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

- **OPCIÓN:** Dormir


## TRANSICION_JUEVES_VIERNES

{salud_mental <= 0:
}
- (post_recovery_jueves)

{llama <= 0:
}



## RECOVERY_MENTAL_JUEVES

Todo se pone oscuro. La cabeza no funciona.

- **OPCIÓN:** ...
-

{conexion <= 1 && llama <= 1:
No hay nada.
No hay nadie.
No hay razón.

}

Pero algo te sostiene. Un recuerdo. Una cara. Algo.


No estás bien. Pero seguís.





## VIERNES_AMANECER





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

- **OPCIÓN:** ...
-

Ahora es solo otro día.

{fui_a_olla_jueves: Sofía dijo que hoy necesitaban resolver algo. La olla está en crisis.}

- **OPCIÓN:** Levantarte


## VIERNES_MANANA


El café.
La mañana.

El sostén energético más honesto: algo caliente y amargo que te hace funcionar.

{olla_en_crisis:
Pensás en la olla.
En que dijeron que no tenían para hoy.
En que hay gente que depende de eso.
}

¿Qué hacés hoy?

- **OPCIÓN:** Ir a la olla temprano
- **OPCIÓN:** Buscar laburo primero
- **OPCIÓN:** Ver qué pasa


## VIERNES_BUSCAR



Abrís la compu.
Más CVs.
Más portales.

Hay una oferta que parece real.
Mandás.

No esperás respuesta.
Pero hay que seguir intentando.

{energia > 1:
Todavía es temprano. Podés ir a la olla.
- **OPCIÓN:** Ir a la olla
- **OPCIÓN:** Quedarte buscando
Seguís buscando.
Las horas pasan.
A las 3 dejás.
}

- **OPCIÓN:** Ir a la tarde


## VIERNES_BARRIO


Salís a caminar.
El barrio.

A esta hora la gente hace sus cosas.
Compras, trámites, vida.

Pasás por la olla.
Hay movimiento.

- **OPCIÓN:** Entrar
- **OPCIÓN:** Seguir de largo


## VIERNES_OLLA_TEMPRANO







Te ven.

{ayude_en_olla:
- else:
Sofía te mira.
"¿Venís a ayudar o a mirar?"
- **OPCIÓN:** "A ayudar."
"Bien. Porque estamos en el horno."
- **OPCIÓN:** "Solo pasaba."
"Bueno. Si te animás, acá estamos."
}


## VIERNES_REUNION




Están: Sofía, Elena, dos o tres más que no conocés bien.

El problema es simple:
No hay plata para la comida de hoy.
Vienen 30 personas a comer.
No tienen qué darles.

- **OPCIÓN:** ...
-

"Las donaciones no llegaron."
"El municipio no contesta."
"Los comercios ya dijeron que no."

Silencio.

¿Qué se puede hacer?

- **OPCIÓN:** Proponer una colecta rápida
- **OPCIÓN:** Proponer pedir a vecinos
- **OPCIÓN:** Proponer cancelar por hoy
- **OPCIÓN:** Quedarte callado, escuchar


## VIERNES_ESCUCHAR


No decís nada.
Escuchás.

Los demás discuten.
Ideas van y vienen.




## VIERNES_COLECTA


"¿Y si hacemos una colecta? Rápida. Hoy."

Te miran.

"¿Cómo?"

"No sé. Golpear puertas. Pedir en la calle. Algo."

Sofía lo piensa.
"Es arriesgado. Pero no hay mucho más."

Elena:
"En el 2002 hacíamos eso. Funcionaba."




## VIERNES_VECINOS


"¿Y los vecinos? ¿Los que no vienen a la olla pero conocen?"

"Ya les pedimos."
"Algunos dieron. No alcanza."

"¿Y si pedimos distinto? No plata. Comida directa. Lo que tengan."

Sofía lo piensa.
"Puede ser. Es más fácil dar una papa que cien pesos."




## VIERNES_CANCELAR_OLLA


"Capaz que... capaz que hoy no."

Silencio.

Sofía te mira.

"¿Cancelar?"

"No podemos dar lo que no tenemos. Mejor cerrar hoy que... que improvisar mal."


Elena suspira.
"Tiene razón. Una vez cerramos en el 2002. Fue un día. Volvimos al otro."

Sofía se sienta.
Tiene la cara de alguien que no durmió.

- **OPCIÓN:** ...
-

"Okay. Cerramos."


Diego no dice nada.
Nadie dice nada.

El silencio pesa.

- **OPCIÓN:** Quedarte con ellos
- **OPCIÓN:** Irte


## VIERNES_QUEDARSE_CERRADO


Te quedás.
No hay mucho que hacer.
Pero te quedás.

Sofía hace café.
Elena mira por la ventana.
Diego ordena sillas vacías.

- **OPCIÓN:** ...
-

Es raro estar acá cuando no hay comida.
Cuando no hay gente.

Pero estás.


- **OPCIÓN:** Pasar la tarde


## VIERNES_IRTE_CERRADO


Te vas.
No hay nada que hacer acá.

Caminás por el barrio.
Pasás por la plaza.
El tipo del banco sigue ahí.

Hoy no hay olla.
Mañana capaz que sí.
Capaz que no.

- **OPCIÓN:** Ir a casa


## VIERNES_PLAN




Deciden hacer las dos cosas:
- Pedir comida directa a vecinos
- Colecta rápida en la zona

- **OPCIÓN:** ...
-

Se dividen.

"¿Vos podés ayudar?", pregunta Sofía.

- **OPCIÓN:** Sí, voy con la colecta
- **OPCIÓN:** Sí, voy a pedir a vecinos
- **OPCIÓN:** No puedo, tengo que hacer otra cosa


## VIERNES_NO_AYUDAR



"No puedo. Tengo que... buscar laburo."

Sofía asiente.
No dice nada.
Pero algo se enfría.

"Bueno. Si podés más tarde..."

Te vas.
Sabés que podrías haber ayudado.
Elegiste no hacerlo.



## VIERNES_COLECTA_ACCION




Diego se mueve diferente.
No pide con lástima. Pide con encanto.
Habla con las viejas. Les sonríe.

"Es un arte", te dice.
"Si das lástima, te dan sobras.
Si das alegría, te dan lo que tienen."


{ resultado_viernes_colecta == 2:
Aprendés algo nuevo.
El rebusque no es solo pedir. Es conectar.

La gente responde. Más de lo esperado.
Un almacenero da dos bolsas llenas. "Para los gurises", dice.
Una vecina trae una olla de arroz ya hecho.

Al final de la tarde, entre todos:
Hay de sobra. Por primera vez en semanas.

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

}



## VIERNES_VECINOS_ACCION





{ resultado_viernes_vecinos == 2:
Los vecinos responden. Con ganas.
Volvés con bolsas llenas. Papas, cebollas, fideos, hasta un pollo.
Elena sonríe. "¿Viste? La gente es buena. Solo hay que saber pedir."
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
}



## VIERNES_OLLA_TARDE




Vuelven todos.


La cocina empieza.
Todos ayudan.

{ixchel_relacion >= 1:
Ixchel está en la cocina.
No dice nada. Pero sigue cocinando.
Con lo que hay. Con lo que queda.

"Siempre se puede con menos", murmura.
"En mi pueblo, con menos se hacía más."

}

{energia > 0:
Te quedás ayudando.
Pelás, cortás, revolvés.
Sos parte de esto.
}

A las 7 la olla abre.

{veces_que_ayude == 1:
}



## VIERNES_TARDE





{juan_sabe_mi_situacion:
}

{olla_en_crisis && not ayude_en_olla:
Te preguntás cómo les habrá ido a los de la olla.
Si resolvieron.
Si cerraron.
}

El barrio sigue.
Vos seguís.
Pero algo falta.

- **OPCIÓN:** Ir a casa


## VIERNES_NOCHE





{ayude_en_olla:
Estás destruido.
Pero hiciste algo.
La olla funcionó hoy.
Mañana hay que ver de vuelta.

}

{not ayude_en_olla && olla_en_crisis:
Te quedaste afuera.
No sabés cómo les fue.
Quizás deberías haber ido.
}

{juan_relacion >= 4 && energia >= 1:

Te quedás pensando en Juan.
Siempre pareció el más seguro.
Pero hoy su voz temblaba un poco.

"Tengo miedo de ser el próximo", dijo.

El miedo no respeta antigüedad.
}


Mañana es sábado.
Hay una asamblea en el barrio.
Para hablar de la olla, de la situación.

{ayude_en_olla: Te invitaron. Podés ir.}
{not ayude_en_olla: Escuchaste que hay. Quizás podrías ir.}


- **OPCIÓN:** Dormir


## FRAGMENTO_VIERNES




{vinculo == "sofia": -> fragmento_sofia_viernes}
{vinculo == "elena": -> fragmento_elena_viernes}
{vinculo == "diego": -> fragmento_diego_viernes}
{vinculo == "marcos": -> fragmento_marcos_viernes}


## FRAGMENTO_SOFIA_VIERNES


{dignidad <= 2:
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
}
- **OPCIÓN:** Continuar
}

{conexion <= 1:
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
}
- **OPCIÓN:** Continuar
}



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

- **OPCIÓN:** Continuar


## FRAGMENTO_ELENA_VIERNES


{dignidad <= 2:
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
}
- **OPCIÓN:** Continuar
}

{conexion <= 1:
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
}
- **OPCIÓN:** Continuar
}



Elena piensa en Raúl.

En el 2002, él tampoco dormía.
Pero salieron.
Juntos, salieron.

Mañana hay asamblea.
Ella va a ir.
Tiene cosas que decir.

- **OPCIÓN:** Continuar


## FRAGMENTO_DIEGO_VIERNES


{dignidad <= 2:
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
}
- **OPCIÓN:** Continuar
}

{conexion <= 1:
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
}
- **OPCIÓN:** Continuar
}



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

- **OPCIÓN:** Continuar


## FRAGMENTO_MARCOS_VIERNES


{dignidad <= 2:
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
}
- **OPCIÓN:** Continuar
}

{conexion <= 1:
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
}
- **OPCIÓN:** Continuar
}



Marcos vio la asamblea desde lejos.

No entró.
No quiso.
O no pudo.

La gente hace cosas.
Él solo mira.

Quizás mañana.
Siempre quizás mañana.

- **OPCIÓN:** Continuar


## FRAGMENTO_VIERNES_DEFAULT


El barrio duerme.
Los problemas siguen.

Mañana hay asamblea.
Para hablar de cómo seguir.

- **OPCIÓN:** Continuar


## TRANSICION_VIERNES_SABADO

{salud_mental <= 0:
}
- (post_recovery_viernes)

{llama <= 0:
}



## RECOVERY_MENTAL_VIERNES

Todo se pone oscuro. Otra vez. Peor.

- **OPCIÓN:** ...
-

{conexion <= 1 && llama <= 1:
No queda nada.
Ni gente. Ni fuego. Ni razón.

}

Pero algo queda. Alguien dijo tu nombre hoy. Alguien te vio.


No estás bien. Pero todavía estás.





## SABADO_AMANECER





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

- **OPCIÓN:** ...
-

{ayude_en_olla: Hoy es la asamblea. A las 5 en la olla.}

- **OPCIÓN:** Levantarte


## SABADO_MANANA


La mañana de sábado.
El barrio más tranquilo.

{salud_mental <= 4: La cabeza sigue dando vueltas. Tres días sin laburo y ya parece una eternidad.}

{juan_sabe_mi_situacion && ayude_en_olla:
}

¿Qué hacés con la mañana?

- **OPCIÓN:** Llamar a alguien
- **OPCIÓN:** Salir a caminar
- **OPCIÓN:** Quedarte en casa


## SABADO_LLAMAR


¿A quién llamás?

- **OPCIÓN:** {vinculo == "marcos"} [A Marcos (otra vez)]
- **OPCIÓN:** A tu vieja / tu viejo
- **OPCIÓN:** A nadie, mejor no


## SABADO_MARCOS



"Dale. En la plaza. En una hora."

- **OPCIÓN:** Ir


## SABADO_MARCOS_PLAZA



"Me echaron."


"¿Cómo la llevás?"





- **OPCIÓN:** "Vamos juntos."
"Hace mucho que no voy. Siempre es lo mismo."
"Hoy no. Hoy vamos nosotros."
Marcos te mira. Hay algo ahí. Una duda.
"Vamos a ver", dice. Pero va.
- **OPCIÓN:** "No importa, era por decir."
"Mejor no. No estoy para eso."
"Bueno."


## SABADO_FAMILIA



Llamás a tu familia.

"Hola, má."

Hablás.
De todo y de nada.

- **OPCIÓN:** ...
-

No le contás lo del laburo.
O sí, depende.

- **OPCIÓN:** Contarle
"Má, me echaron."
Silencio.
"¿Estás bien? ¿Necesitás plata?"
"No sé. Era unipersonal. No hay indemnización. No hay nada."
"¿Cómo que no hay nada?"
"Así me contrataron. Facturaba. Como si fuera mi propia empresa."
Ella no entiende. Pero te escucha.
- **OPCIÓN:** No contarle
Hablás de otras cosas.
El clima. Los vecinos. Boludeces.
No querés preocuparla.
O no querés tener que explicar.


## SABADO_CAMINAR



Salís a caminar.


- **OPCIÓN:** Volver a casa
- **OPCIÓN:** Pasar por la olla


## SABADO_OLLA_TEMPRANO


Pasás por la olla.


Sofía te ve.

"¿Venís a la asamblea?"

- **OPCIÓN:** "Sí, vengo más tarde."
"Bien. A las 5."
- **OPCIÓN:** "No sé si puedo."
Sofía asiente.
"Bueno. Si podés, acá estamos."


## SABADO_CASA



Te quedás en casa.
Tele.
Celular.
Nada.

Las horas pasan.

- **OPCIÓN:** Ir a la asamblea igual
- **OPCIÓN:** No ir


## SABADO_TARDE



La tarde.

A las 5 es la asamblea.

{energia >= 1:
Podés ir.
- **OPCIÓN:** Ir a la asamblea
- **OPCIÓN:** No ir
- else:
Estás muy cansado.
No das más.
- **OPCIÓN:** Intentar ir igual
Te arrastrás hasta la olla.
- **OPCIÓN:** Quedarte
}


## SABADO_NOCHE_SOLO



No vas.

Te quedás en casa.
Pensás en que deberías haber ido.
Pero no fuiste.

- **OPCIÓN:** ...
-

La asamblea pasa sin vos.
No sabés qué decidieron.
No sabés qué viene.

Estás afuera.

- **OPCIÓN:** Dormir


## SABADO_ASAMBLEA_POST_CIERRE


El aire está raro.
Ayer la olla cerró.
Primera vez en meses.

- **OPCIÓN:** ...
-

Sofía está callada.
Elena tiene cara de preocupación.

"Bueno... tenemos que hablar de lo de ayer."

- **OPCIÓN:** ...
-

Sofía suspira.

"Ayer cerramos. Lo saben.
La pregunta es: ¿qué hacemos para que no pase de nuevo?"

{vos_propusiste_cerrar:
Te miran.
Vos propusiste cerrar.
Ahora te toca proponer qué sigue.

- **OPCIÓN:** Proponer sistema de reserva de emergencia
"Necesitamos un fondo. Aunque sea chico. Para días así."
Sofía asiente. "Tiene sentido."
La discusión sigue.

- **OPCIÓN:** Proponer red de donantes fijos
"Necesitamos gente que se comprometa a dar todos los meses."
Elena: "En el 2002 así empezamos."
La idea prende.

- **OPCIÓN:** Quedarte callado
No decís nada.
Sofía te mira. Esperaba más.
- else:
La discusión sigue sin que nadie te mire especialmente.
}


## SABADO_ASAMBLEA_CONTINUA


La conversación se amplía.
No es solo lo de ayer.
Es todo.

- **OPCIÓN:** Seguir


## SABADO_ASAMBLEA




{olla_cerro_viernes:
}



## SABADO_ASAMBLEA_DISCUSION_NORMAL





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

}

¿Qué hacés?

- **OPCIÓN:** Hablar
- **OPCIÓN:** Escuchar
- **OPCIÓN:** Proponer algo


## SABADO_ESCUCHAR_ASAMBLEA


Escuchás.

Las ideas van y vienen.
- Hacer más colectas.
- Buscar comercios que donen.
- Pedir al municipio de vuelta.
- Organizar una feria.

No hay solución mágica.
Solo ideas.
Solo gente tratando.



## SABADO_HABLAR


Hablás.

"Yo... hace tres días me quedé sin laburo. No sé bien qué puedo aportar. Pero tengo tiempo ahora. Y quiero ayudar."


{ resultado_sabado_hablar == 2:
}
{ resultado_sabado_hablar == 1:
}
{ resultado_sabado_hablar == 0:
}


### sabado_hablar_critico

Te miran.

- **OPCIÓN:** ...
-

Silencio. Y después algo inesperado: aplausos. Pocos, pero sinceros.

Sofía tiene los ojos húmedos.
Elena asiente con fuerza.

"Eso. Eso es lo que necesitamos. Gente que diga la verdad."

Tu voz encontró algo. Un nervio. Un lugar real.



### sabado_hablar_exito

Te miran.

- **OPCIÓN:** ...
-

Sofía asiente.
Elena sonríe.

"Eso es lo que necesitamos. Gente."



### sabado_hablar_fallo

Te miran.

- **OPCIÓN:** ...
-

Algunos asienten. Otros miran para otro lado.
No es un discurso brillante. Pero es honesto.

Sofía dice: "Gracias."
Y sigue la reunión.



### sabado_hablar_crit_fallo

Te miran.

- **OPCIÓN:** ...
-

Se te corta la voz. Te trabás.

"Bueno... eso."

Te sentás. Rojo.
Nadie dice nada. Lo que es peor que si dijeran algo.

Sofía pasa a otro tema. Con suavidad.
Pero el silencio te quema.

/*

## SABADO_PROPONER



"¿Y si hacemos algo más grande? Una jornada. Invitamos a todo el barrio. Mostramos lo que hace la olla. Pedimos ayuda abiertamente."

Silencio.

"Es mucho laburo."
"Pero puede funcionar."
"Hay que organizarlo."

Sofía:
"¿Vos te animás a ayudar con eso?"

- **OPCIÓN:** "Sí."
"Sí. Ahora tengo tiempo."
Risas nerviosas.
Pero es real.
Ahora tenés tiempo.
- **OPCIÓN:** "No sé si puedo."
"Bueno. La idea queda."
- **OPCIÓN:** /


## SABADO_ASAMBLEA_PROPONER

Te levantás.
Todos te miran.

{ veces_que_ayude >= 2:
}
{ participe_asamblea:
}
{ sofia_relacion >= 4:
}


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



- resultado == 1:  // Éxito
Proponés algo.
Un sistema de turnos.
Una red de ayuda.
Algo.

La gente asiente.
No es revolución.
Pero es algo.



- resultado == 0:  // Fallo
Empezás a hablar.
Te trabás.

Sofía interviene, suave.
"Gracias. ¿Alguien más?"

Te sentás.
No estuvo mal.
Pero tampoco estuvo bien.


- else:  // Fumble
Te levantás.
Abrís la boca.

Nada sale.

Te sentás de nuevo.
Nadie dice nada.


}


## ASAMBLEA_EXITO_TOTAL


El resto de la asamblea fluye diferente.
Tu intervención cambió algo.



## ASAMBLEA_EXITO


La asamblea continúa.
Tu idea se suma a las demás.



## ASAMBLEA_CONTINUA


La asamblea sigue.
Otras voces hablan.



## SABADO_ASAMBLEA_FIN




{idea_hay_cosas_juntos == false:


La asamblea te mostró algo.
No es que alguien tiene la respuesta.
Es que entre todos se busca.

- **OPCIÓN:** Internalizar
Hay cosas que se hacen juntos.
O no se hacen.
- **OPCIÓN:** Dejar pasar
- else:
}


## SABADO_NOCHE






Volvés a casa.
Cansado pero distinto.

Cuatro días sin laburo.
Tres meses de colchón.
La cuenta regresiva sigue.

- **OPCIÓN:** ...
-

Pero hoy estuviste en una asamblea.
Hoy fuiste parte de algo.

No resuelve nada.
Pero cambia algo.



- **OPCIÓN:** Dormir


## FRAGMENTO_SABADO




{vinculo == "sofia": -> fragmento_sofia_sabado}
{vinculo == "elena": -> fragmento_elena_sabado}
{vinculo == "diego": -> fragmento_diego_sabado}
{vinculo == "marcos": -> fragmento_marcos_sabado}


## FRAGMENTO_SOFIA_SABADO


{dignidad <= 2:
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

- **OPCIÓN:** Continuar
}

{conexion <= 1:
Sofía está sola en la olla.

Hoy hubo asamblea.
Vino poca gente.

"El barrio se muere", piensa.

Cada vez menos gente.
Cada vez más solos.

La olla va a cerrar.
Es cuestión de tiempo.

Y nadie va a hacer nada.

- **OPCIÓN:** Continuar
}



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

- **OPCIÓN:** Continuar


## FRAGMENTO_ELENA_SABADO


{dignidad <= 2:
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

- **OPCIÓN:** Continuar
}

{conexion <= 1:
Elena está sola.

Raúl murió.
El barrio se dispersó.

"Nos convertimos en islas", piensa.

Cuando Raúl murió, tres vecinos vinieron.
Antes hubiera sido el barrio entero.

Ahora ni eso.
Ahora solo puertas cerradas.

- **OPCIÓN:** Continuar
}



Elena sueña con Raúl.

Están en el barrio.
Hace calor.
Él sonríe.

"¿Viste? Siempre salimos."

Se despierta.
Es un buen sueño.

- **OPCIÓN:** Continuar


## FRAGMENTO_DIEGO_SABADO


{dignidad <= 2:
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

- **OPCIÓN:** Continuar
}

{conexion <= 1:
Diego está solo.

Tres contactos en Uruguay.
Su familia en Venezuela.

"Crucé un continente para seguir solo", piensa.

La asamblea.
El barrio.
Todo le queda lejos.

Siempre le quedó lejos.
Siempre va a quedar lejos.

- **OPCIÓN:** Continuar
}



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

- **OPCIÓN:** Continuar


## FRAGMENTO_MARCOS_SABADO


{dignidad <= 2:
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

- **OPCIÓN:** Continuar
}

{conexion <= 1:
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

- **OPCIÓN:** Continuar
}



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

- **OPCIÓN:** Continuar



## SABADO_VER_SOFIA


Sofía te ve llegar.

{ayude_en_olla && veces_que_ayude >= 2:
"Che, gracias por el viernes. No sé cómo hubiéramos hecho sin vos."

Alguien notó.
Alguien se acuerda.

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



## SABADO_VER_DIEGO


Diego está en la asamblea.

{hable_con_diego_profundo:
Te ve y se acerca.

"Che, lo que hablamos el otro día... me quedó dando vueltas.
Creo que tenías razón."

}
{conte_a_alguien && vinculo == "diego":
Diego asiente cuando te ve.

Hay algo compartido ahí.
Un secreto. Tu despido.
Él sabe. Y vos sabés que él sabe.
}




## FRAGMENTO_SABADO_DEFAULT


El barrio duerme.
La asamblea pasó.
Mañana es domingo.

La semana que viene empieza todo de vuelta.
Pero quizás no igual.

- **OPCIÓN:** Continuar


## TRANSICION_SABADO_DOMINGO

{salud_mental <= 0:
}
- (post_recovery_sabado)

{llama <= 0:
}



## RECOVERY_MENTAL_SABADO

La oscuridad viene de nuevo. Más fuerte.

- **OPCIÓN:** ...
-

{conexion <= 1 && llama <= 1:
No hay red. No hay llama. No hay mañana.

}

{participe_asamblea:
La asamblea. Las voces. Algo de eso queda.
- else:
Una cara. Un gesto. Algo mínimo.
}


Mañana es domingo. Último día. Algo tiene que pasar.





## DOMINGO_AMANECER





{participe_asamblea:
La asamblea de ayer fue... algo.
{marcos_vino_a_asamblea: Marcos estaba. No dijiste nada. Pero estaba.}
Hoy es domingo.
Último día de la semana.
}
{not participe_asamblea:
Domingo.
Ayer no fuiste a nada.
Hoy tampoco hay nada.
O capaz que sí, pero no te enteraste.
}

Una semana.

Hace una semana eras otra persona.
Tenías laburo.
Tenías rutina.
Tenías algo.

- **OPCIÓN:** ...
-

Ahora no tenés nada. Unipersonal.
Sin derechos. Sin colchón. Sin respuestas.

- **OPCIÓN:** Levantarte


## DOMINGO_MANANA


Domingo.
El día más lento.

{participe_asamblea: Ayer fue la asamblea. Hoy es día de procesar.}
{not participe_asamblea: No fuiste a la asamblea. No sabés qué pasó.}

La mañana está ahí.
Esperando.

¿Qué hacés?

- **OPCIÓN:** Quedarte en casa, pensar
- **OPCIÓN:** Salir al barrio
- **OPCIÓN:** Llamar a tu vínculo


## DOMINGO_PENSAR


Te quedás.
Pensás.

La semana que pasó.
Lo que viene.


{ resultado_domingo_reflexion == 2:
La cabeza se aquieta. Por primera vez en días.

Algo se acomoda. No es una respuesta. Es una calma.

Una semana atrás eras otro. Tenías laburo y nada más.
Ahora no tenés laburo. Pero tenés algo que antes no tenías.

{conexion >= 6: Gente. Caras. Nombres. Una red que no sabías que existía.}
{conexion < 6: Algo. Todavía no sabés qué. Pero algo.}

}
{ resultado_domingo_reflexion == 1:
{salud_mental <= 4:
La cabeza no para.
¿Quién sos ahora?
¿Qué hacés?
¿Qué viene?
}

{conexion >= 6:
Pero no estás solo.
Esta semana conociste gente.
O reconectaste con gente.
Eso es algo.
}

{conexion < 4:
Estás bastante solo.
Esta semana no conectaste mucho.
La soledad pesa.
}
}
{ resultado_domingo_reflexion == 0:
La cabeza da vueltas.
No llegás a ningún lado.

{conexion >= 4: Al menos hay gente. Eso debería alcanzar. Pero hoy no alcanza.}
{conexion < 4: Estás solo. Y el domingo es el peor día para estar solo.}

La tarde va a ser larga.
}
{ resultado_domingo_reflexion == -1:
La cabeza explota.

Todo se mezcla. El laburo. La plata. La olla. Las caras.
¿Qué sentido tiene? ¿Para qué?

El domingo es un espejo. Y no te gusta lo que ves.

}

- **OPCIÓN:** Ir a la tarde


## DOMINGO_BARRIO



Salís.


{marcos_vino_a_asamblea && marcos_relacion >= 4:
}



## DOMINGO_ENCUENTRO_GRUPO


Pasás por la olla.
No hay reunión hoy. Pero hay gente.

- **OPCIÓN:** ...
-

{participe_asamblea && ayude_en_olla:
Sofía está afuera.
Elena toma mate en la vereda.
Diego ordena cosas.
{marcos_vino_a_asamblea: Marcos está parado lejos, pero ahí.}
Te ven.

- **OPCIÓN:** Acercarte
- **OPCIÓN:** Saludar de lejos y seguir
}
{participe_asamblea && not ayude_en_olla:
Hay gente.
Te miran.
Saludan, pero...
Hay algo raro.
No sos parte. No del todo.

- **OPCIÓN:** Acercarte igual
- **OPCIÓN:** Seguir de largo
}
{not participe_asamblea:
La olla está cerrada.
No hay nadie.
O quizás hay, pero no te ven.
O no te buscan.

- **OPCIÓN:** Seguir
}


## DOMINGO_CIERRE_RED


Te acercás.

Sofía te pasa un mate.
Elena te hace lugar en el banco.
Diego asiente.

- **OPCIÓN:** ...
-

{marcos_vino_a_asamblea:
Marcos te mira desde lejos.
Levanta la mano.
Es un gesto mínimo.
Pero es algo.
}

- **OPCIÓN:** ...
-

Nadie dice nada importante.
Pero están.
Y vos estás.

Esto es algo.


- **OPCIÓN:** Quedarte un rato


## DOMINGO_CIERRE_DISTANTE


Saludás de lejos.
Seguís caminando.

Hay distancia.
Elegiste que la haya.
O la distancia te eligió.

- **OPCIÓN:** Seguir


## DOMINGO_CIERRE_INTENTO


Te acercás.

Sofía te mira.
Elena asiente.
Diego dice algo.

Pero no estás. No del todo.
Faltó algo. Ayudar, quizás.
O solo estar más.

No te rechazan.
Pero tampoco te llaman.

- **OPCIÓN:** Quedarte un poco


## DOMINGO_LLAMAR


{vinculo == "sofia": -> domingo_llamar_sofia}
{vinculo == "elena": -> domingo_llamar_elena}
{vinculo == "diego": -> domingo_llamar_diego}
{vinculo == "marcos": -> domingo_llamar_marcos}



## DOMINGO_LLAMAR_SOFIA






## DOMINGO_LLAMAR_ELENA






## DOMINGO_LLAMAR_DIEGO






## DOMINGO_LLAMAR_MARCOS






## DOMINGO_TARDE




La tarde.
El sol baja.

Mañana es lunes.
Pero no hay laburo al que ir.

- **OPCIÓN:** ...
-

La semana que viene:
- Hay que buscar laburo.
- Hay que ver qué pasa con la olla.
- Hay que seguir viviendo.

{conexion >= 6: Al menos no estás solo.}
{conexion < 4: Estás bastante solo. Quizás la semana que viene...}

{llama >= 5: Hay algo de esperanza. Pequeña, pero ahí.}
{llama < 3: Todo se ve gris. Pero mañana es otro día.}

- **OPCIÓN:** Ir a la noche


## DOMINGO_NOCHE




El final de la semana.

Te sentás.
Pensás en todo.

- **OPCIÓN:** ...
-

Una semana.
{fui_despedido: Te echaron.}
{ayude_en_olla: Ayudaste en la olla.}
{participe_asamblea: Fuiste a una asamblea.}
{conte_a_alguien: Le contaste a alguien.}

- **OPCIÓN:** ...
-

{not conte_a_alguien && not ayude_en_olla: Estuviste bastante solo esta semana.}

{juan_sabe_mi_situacion: Juan sabe lo que pasó. Te bancó a su manera.}




## DOMINGO_RESUMEN_IDEAS


Las ideas que internalizaste:
{idea_tengo_tiempo: - "Ahora tengo tiempo para esto."}
{idea_pedir_no_debilidad: - "Pedir ayuda no es debilidad."}
{idea_hay_cosas_juntos: - "Hay cosas que se hacen juntos."}
{idea_red_o_nada: - "La red o la nada."}
{idea_quien_soy: - "¿Quién soy sin laburo?" (involuntaria)}
{idea_esto_es_lo_que_hay: - "Esto es lo que hay." (involuntaria)}

La semana termina.
El juego también.
Por ahora.

- **OPCIÓN:** Ver el final


## SINTESIS_IDEAS



{ideas_activas >= 1:
Un momento de silencio.
Las ideas de la semana se acomodan.
}

{sinergia_colectiva >= 2:
Algo se armó esta semana. No fue solo vos.
Pedir ayuda, hacer juntos, sostener la red.
Esas tres cosas se cruzan. Se sostienen.
}

{sinergia_individual >= 2:
Algo cambió adentro. Todavía no sabés qué.
Pero el tiempo y las preguntas dejaron marca.
}

{ideas_activas >= 4:
Fue una semana entera. No una semana cualquiera.
Algo se movió. En vos. En el barrio. En los dos.
}

{ideas_activas == 0:
La semana pasó.
No sabés si algo cambió.
}

- **OPCIÓN:** ...


## EVALUAR_FINAL



{salud_mental <= 0:
}

{llama <= 0:
}

{vinculo == "ixchel" && ixchel_relacion >= 4 && ixchel_conto_historia && ayude_en_olla:
}

{conexion >= 9 && llama >= 8 && veces_que_ayude >= 3 && participe_asamblea && marcos_vino_a_asamblea && sofia_relacion >= 4 && elena_relacion >= 4 && tiene_todas_ideas():
}

{evaluar_lucha_colectiva():
}

{conexion >= 7 && llama >= 5 && ayude_en_olla:
}

{evaluar_vulnerabilidad():
}

{conexion <= 3 && llama <= 2:
}

{salud_mental <= 2 && conexion <= 4:
}

{evaluar_pequeno_cambio():
}

{conexion >= 5:
- else:
}








## FRAGMENTO_IXCHEL_INTRO



Ixchel termina de limpiar la cocina del restaurante.
Sus manos están rojas por el agua caliente y el detergente.

"Dale, bolita, apurate que cerramos", grita el encargado.

No es boliviana. Es guatemalteca. Maya-K'iche'.
Se lo dijo tres veces. Él sigue diciendo "bolita".
Para él, todos los indígenas son lo mismo.

Ixchel no contesta.
Su dignidad es un silencio antiguo.

Piensa en su abuela en Quetzaltenango.
En el tejido que le enseñó.
Acá no hay tejidos. Solo grasa y platos sucios.

Sale a la calle. El frío de Montevideo le corta la cara.
Le duele la espalda.
Pero sigue de pie.

"Mañana será otro día", dice en su lengua.
Nadie la escucha.
Nadie la entiende.
Pero ella se entiende.




## FRAGMENTO_CIUDAD_NOCHE



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







## FRAGMENTO_JUAN_LABURO


Juan llega al laburo.
Tu escritorio está vacío.

Nadie dice nada. Pero todos miran.

El jefe pasa como si nada. "Buenos días."

Juan aprieta los dientes.
Sigue laburando.




## FRAGMENTO_IXCHEL_TEJIDO


En un cuarto pequeño, Ixchel teje.

Los colores son de allá. Los movimientos son de acá.
Un puente entre mundos que nadie ve.

"Ri qa tzij, ri qa k'aslemal."
Nuestras palabras, nuestra vida.




## SELECCIONAR_FRAGMENTO_VIERNES

{ayude_en_olla:
- else:
{vinculo == "marcos":
- else:
}
}


## SELECCIONAR_FRAGMENTO_SABADO

{participe_asamblea:
- else:
{vinculo == "elena":
- else:
{vinculo == "diego":
- else:
}
}
}


## SELECCIONAR_FRAGMENTO_DOMINGO

{vinculo == "sofia":
}
{vinculo == "elena":
}
{vinculo == "diego":
}
{vinculo == "marcos":
}
{vinculo == "juan":
}
{vinculo == "ixchel":
}



## FINAL_LA_LLAMA





El lunes llega.

No tenés laburo.
Pero tenés algo que pocos tienen.

- **OPCIÓN:** ...
-

La olla no solo sobrevivió.
Creció.

La asamblea no fue solo un evento.
Fue el principio.

- **OPCIÓN:** ...
-

Sofía te mira diferente ahora.
"Sos parte del equipo."

Elena te dijo: "Raúl estaría orgulloso."

Diego ya no se siente tan solo.
"Gracias por bancarme."

{marcos_vino_a_asamblea:
Marcos volvió.
De a poco. Pero volvió.
"Capaz que hay algo," dijo ayer.
Capaz.
}

Y hay una llama.

No es esperanza ingenua.
No es ilusión.

- **OPCIÓN:** ...
-

Es conocimiento.
De que juntos, hay algo.

- **OPCIÓN:** ...
-

El sistema no cambió.
No va a cambiar mañana.
Quizás nunca.

Pero ustedes sí cambiaron.

- **OPCIÓN:** ...
-

Y la llama no se apaga.

Los tres meses empiezan.
No sabés qué viene.
Pero sabés con quién vas.

{pequenas_victorias >= 8:
No salvaste el mundo.
No cambiaste el sistema.

Pero te levantaste.
Te bañaste.
Cocinaste.
Saliste.

Eso, a veces, es todo.
}





## FINAL_RED





El lunes llega.
No tenés laburo.
Pero tenés algo.

- **OPCIÓN:** ...
-

La olla te espera.
Sofía te espera.
El barrio te espera.

- **OPCIÓN:** ...
-

No es solución.
No hay trabajo mágico.
No hay plata que aparece.

- **OPCIÓN:** ...
-

Pero hay una red.
Gente que te conoce.
Gente que sabe que existís.
Gente con la que hacés cosas.

- **OPCIÓN:** ...
-

Los tres meses van a pasar.
Quizás consigas algo.
Quizás no.

Pero no estás solo.

{idea_red_o_nada: Elena tenía razón. La red o la nada.}

{llama >= 7:
Y hay algo más.
Un fuego pequeño.
Una llama que no se apaga.
La esperanza de que las cosas pueden ser diferentes.
No mejor. Diferentes.
}

Esto no termina.
Es el principio de otra cosa.

{pequenas_victorias >= 8:
No salvaste el mundo.
No cambiaste el sistema.

Pero te levantaste.
Te bañaste.
Cocinaste.
Saliste.

Eso, a veces, es todo.
}





## FINAL_SOLO





El lunes llega.
No tenés laburo.
No tenés mucho.

- **OPCIÓN:** ...
-

La semana pasó.
No conectaste.
No ayudaste.
No estuviste.

- **OPCIÓN:** ...
-

El barrio sigue.
La olla sigue.
Pero sin vos.

- **OPCIÓN:** ...
-

Los tres meses van a pasar.
Vas a buscar laburo.
Quizás consigas.
Quizás no.

- **OPCIÓN:** ...
-

Pero vas a estar solo.
Como antes.
Como siempre.

- **OPCIÓN:** ...
-

No es el fin del mundo.
Solo es gris.
Todo gris.

{idea_quien_soy: ¿Quién sos sin laburo? Todavía no sabés.}

{pequenas_victorias >= 8:
No salvaste el mundo.
No cambiaste el sistema.

Pero te levantaste.
Te bañaste.
Cocinaste.
Saliste.

Eso, a veces, es todo.
}





## FINAL_QUIZAS





El lunes llega.
No tenés laburo.
Pero pasaron cosas.

- **OPCIÓN:** ...
-

Conociste gente.
O reconectaste.
Algo se movió.

- **OPCIÓN:** ...
-

No es suficiente todavía.
Pero es algo.

- **OPCIÓN:** ...
-

Los tres meses van a pasar.
No sabés qué viene.
Pero hay un "quizás" que antes no había.

- **OPCIÓN:** ...
-

Quizás la olla.
Quizás el barrio.
Quizás algo.

No es esperanza.
Es posibilidad.

{llama >= 4:
Y eso, a veces, alcanza.
}

{pequenas_victorias >= 8:
No salvaste el mundo.
No cambiaste el sistema.

Pero te levantaste.
Te bañaste.
Cocinaste.
Saliste.

Eso, a veces, es todo.
}





## FINAL_INCIERTO





El lunes llega.
No tenés laburo.
No sabés qué tenés.

- **OPCIÓN:** ...
-

La semana fue rara.
Pasaron cosas.
No pasó nada.

- **OPCIÓN:** ...
-

Los tres meses empiezan a correr.
La cuenta regresiva.

- **OPCIÓN:** ...
-

No sabés qué viene.
No sabés quién sos.
No sabés nada.

- **OPCIÓN:** ...
-

Pero estás vivo.
Eso es algo.
¿No?

{pequenas_victorias >= 8:
No salvaste el mundo.
No cambiaste el sistema.

Pero te levantaste.
Te bañaste.
Cocinaste.
Saliste.

Eso, a veces, es todo.
}





## FINAL_SIN_LLAMA





El barrio está en silencio.

No el silencio de la noche.
El silencio de la rendición.

- **OPCIÓN:** ...
-

La olla cerró.
No por falta de ganas.
Por falta de gente que crea.

- **OPCIÓN:** ...
-

Sofía se rindió.
"Para qué", dijo.
"Si nadie viene."

Elena ya no habla del 2002.
Ahora solo dice: "Era otra época."

Diego dejó de buscar.
"No hay nada que hacer."

- **OPCIÓN:** ...
-

Marcos tenía razón desde el principio.
No hay llama.
Nunca la hubo.

- **OPCIÓN:** ...
-

El tejido social no se rompe de golpe.
Se deshilacha.
Persona por persona.
Día por día.

- **OPCIÓN:** ...
-

Hasta que no queda nada.

Y reconstruirlo toma generaciones.
No días.
No semanas.

Generaciones.

- **OPCIÓN:** ...
-

{idea_hay_cosas_juntos:
Hay cosas que solo se hacen juntos.

Pero ya no hay "juntos".
}

{idea_red_o_nada:
La red o la nada.

Elegiste la nada.
Sin querer. Sin darte cuenta.
Pero la elegiste.
}

La llama se apagó.





## FINAL_APAGADO





La pantalla del teléfono te ilumina la cara en la oscuridad.

3:47 AM.

- **OPCIÓN:** ...
-

Mañana tenés turno con la psiquiatra.
O pasado.
No te acordás.

- **OPCIÓN:** ...
-

El antidepresivo está en el cajón.
"Tomar con alimentos."

No comiste nada desde... ayer? anteayer?

Da igual.

- **OPCIÓN:** ...
-

Lo que no te dicen es que el problema no está en tu cabeza.

El problema está en que no podés pagar el alquiler trabajando 60 horas.

El problema está en que "flexibilidad laboral" significa que no sabés si comés el jueves.

El problema está en que "resiliencia" es la palabra que usan cuando quieren que aguantes lo inaguantable.

- **OPCIÓN:** ...
-

No estás enfermo.

El sistema está enfermo.

- **OPCIÓN:** ...
-

Pero ellos te venden la pastilla.

Y vos te la tomás.

Porque mañana hay que levantarse igual.

- **OPCIÓN:** ...
-

{idea_quien_soy:
¿Quién sos sin laburo?

Nadie.
Eso es lo que el sistema te dice.
}

{idea_esto_es_lo_que_hay:
Esto es lo que hay.

Y lo que hay te está matando de a poco.
}

La luz del teléfono se apaga.





## FINAL_TEJIDO





El lunes llega.
No tenés laburo.
Pero tenés hilos.

- **OPCIÓN:** ...
-

Ixchel te enseñó algo que no tiene nombre en castellano.

Que la comunidad es un tejido.
Que cada persona es un hilo.
Que cuando uno se rompe, los demás sostienen.

- **OPCIÓN:** ...
-

No es la olla. No es la asamblea.
Es algo más antiguo.

Un saber que cruzó océanos y fronteras.
Que sobrevivió a todo lo que quisieron matarlo.

- **OPCIÓN:** ...
-

"Ri qa tzij, ri qa k'aslemal", dice Ixchel.
Nuestras palabras, nuestra vida.

No entendés el idioma.
Pero entendés el gesto.

{ixchel_conto_historia:
Los pájaros y las montañas del huipil.
El tejido que conecta.
Lo que sobrevive.
}

- **OPCIÓN:** ...
-

Mañana hay olla.
Mañana hay tejido.
Mañana hay comunidad.

No lo arregla. No lo soluciona.
Pero lo sostiene.





## FINAL_GRIS





El lunes llega.

Todo pesa.
El cuerpo.
La cabeza.
Todo.

- **OPCIÓN:** ...
-

{salud_mental <= 1:
La salud mental se desgastó.
No es una cosa.
Son muchas.
El despido.
La soledad.
Las preguntas sin respuesta.
}

Los tres meses están ahí.
Pero no los sentís como colchón.
Los sentís como cuenta regresiva.

- **OPCIÓN:** ...
-

No hay final feliz.
No hay final triste.
Solo hay mañana.
Y pasado.
Y el otro día.

- **OPCIÓN:** ...
-

Uno atrás del otro.
Hasta que algo cambie.
O no.

{idea_esto_es_lo_que_hay: Esto es lo que hay. Por ahora.}

{pequenas_victorias >= 8:
No salvaste el mundo.
No cambiaste el sistema.

Pero te levantaste.
Te bañaste.
Cocinaste.
Saliste.

Eso, a veces, es todo.
}





## FINAL_PEQUENO_CAMBIO





El lunes llega.
No tenés laburo.
Pero algo es distinto.

- **OPCIÓN:** ...
-

No es grande. No es histórico.
No cambia el mundo.

Pero vos cambiaste.

- **OPCIÓN:** ...
-

Un poco. Apenas.
Como cuando girás la cabeza y ves algo que siempre estuvo ahí.

{conte_a_alguien:
Le contaste a alguien. Eso cambió algo.
No en el mundo. En vos.
}

{ayude_en_olla:
Pelaste papas. Serviste guiso.
No es revolución. Es presencia.
}

- **OPCIÓN:** ...
-

Los tres meses empiezan.
No sabés qué viene.

Pero algo se movió.
Adentro. Donde importa.

{pequenas_victorias >= 5:
Pequeñas victorias.
Levantarse. Bañarse. Salir.
Hablar. Escuchar. Estar.

Eso, a veces, es el cambio.
}





## FINAL_VULNERABILIDAD_HONESTA





El lunes llega.
No tenés laburo.
Pero dejaste de fingir.

- **OPCIÓN:** ...
-

Le dijiste a alguien que estabas mal.
No es heroísmo. Es honestidad.

- **OPCIÓN:** ...
-

{conte_a_alguien:
Dijiste "estoy mal" y no se cayó el mundo.
La persona te escuchó.
No te arregló. No te salvó.
Te escuchó.
Y eso alcanzó.
}

{salud_mental <= 3:
La cabeza sigue pesando.
Pero ya no pesás solo.

Alguien sabe.
Alguien vio.
Eso cambia las cosas.
No las arregla. Las cambia.
}

- **OPCIÓN:** ...
-

Los tres meses empiezan.
La incertidumbre sigue.

Pero hay una grieta en el muro.
Una grieta por donde entra algo de luz.

No es esperanza. Es aire.

{idea_pedir_no_debilidad:
Pedir ayuda no es debilidad.
Lo aprendiste esta semana.
Duele. Pero funciona.
}





## FINAL_LUCHA_COLECTIVA





El lunes llega.
No tenés laburo.
Pero tenés un plan.

- **OPCIÓN:** ...
-

La asamblea no fue solo hablar.
Salieron cosas.
Propuestas. Ideas. Gente que se comprometió.

- **OPCIÓN:** ...
-

{participe_asamblea:
En la asamblea dijeron:
"Esto no se arregla solo."
"Esto se arregla juntos."
Y por primera vez, creíste.
}

{veces_que_ayude >= 3:
Ayudaste tantas veces que ya te conocen.
"El nuevo", dicen. Pero con cariño.
Sos parte.
}

- **OPCIÓN:** ...
-

La olla no es caridad.
Es organización.

La asamblea no es queja.
Es acción.

El barrio no es geografía.
Es decisión.

- **OPCIÓN:** ...
-

Los tres meses empiezan.
Pero esta vez no son solo tuyos.

{llama >= 7:
La llama arde.
No como incendio. Como fogón.
Como reunión. Como olla.
Como lo que pasa cuando la gente decide
que sola no puede,
pero junta sí.
}

Mañana hay asamblea de nuevo.
Y vos vas a estar.








## INICIO





Suena el despertador. Todavía está oscuro afuera.
El colchón tiene un hundimiento que ya tiene la forma de tu cuerpo.
En la cocina, la canilla gotea. Siempre gotea.

Otra semana que empieza. Otra semana como todas.
Todavía no sabés lo que viene.

- **OPCIÓN:** Levantarse


## CREACION_PERSONAJE




Te mirás en el espejo del baño. El vidrio tiene una rajadura en la esquina.
Treinta y algo. Ojeras que ya son parte de tu cara.

- **OPCIÓN:** ...
-

Laburás. Pagás las cuentas. Más o menos.
A veces llegás justo. A veces no llegás.

- **OPCIÓN:** ...
-

Vivís en el barrio.
Conocés a la gente de vista, de cruce, de historia compartida.
El almacenero que te fía. La vecina que barre la vereda a las siete.
El perro que ladra siempre en la misma esquina.

- **OPCIÓN:** ...
-

Pero hay cosas que solo vos sabés.
Cosas que cargás cuando caminás por la calle.
Cosas que no se ven.



## ELEGIR_PERDIDA




- **OPCIÓN:** Un plato que nadie más usa en la alacena.
La última vez que lo vi estaba en la cama del hospital, flaco como nunca.
Me apretó la mano. No dijo nada. No hacía falta.
Me dejó cosas: una caja de fotos, una deuda con el banco, la costumbre de mirar el teléfono a las ocho.

- **OPCIÓN:** Una taza de café que sobra todas las mañanas.
Se fue un martes. O un jueves. Ya no importa el día.
Dejó un cepillo de dientes que tardé meses en tirar.
A veces la veo en el almacén de la vuelta. Nos saludamos como desconocidos.
El barrio quedó partido al medio.

- **OPCIÓN:** Un diploma que junta polvo arriba del ropero.
Me acuerdo del día que rendí el último examen.
Pensé: "Ahora empieza todo". Todavía estoy esperando.
A veces agarro el cartón, le saco el polvo. Lo vuelvo a guardar.
El pibe que lo consiguió ya no existe.

- **OPCIÓN:** Una foto donde no reconozco mi propia sonrisa.
No sé cuándo pasó. No hubo un día, un momento.
Solo a veces me miro al espejo y veo a alguien cansado.
Algo se fue. O capaz nunca estuvo.
Sigo buscando.


## ELEGIR_ATADURA




- **OPCIÓN:** Una alarma en el celular que dice "llamar a mamá".
Suena todos los días a las ocho. A veces la ignoro. Después me siento mal.
Vive sola desde que murió mi viejo. No me pide nada. Pero sé que espera.
Hay días que pienso en irme lejos. Después pienso en ella sola en esa casa.

- **OPCIÓN:** La marca de mi altura en el marco de la puerta.
Crecí en estas calles. Conozco cada baldosa floja, cada perro que ladra.
Mi viejo pintó esta casa. Mi abuelo plantó el árbol de la vereda.
Irme sería como arrancarme un pedazo. No sé cuál.

- **OPCIÓN:** Una valija que armé hace dos años y nunca abrí.
Está debajo de la cama, juntando polvo.
A veces la miro. Pienso: mañana. Pasado.
Pero mañana llega y yo sigo acá, mirando la valija.

- **OPCIÓN:** El olor a pan de la panadería de la esquina.
No sé explicarlo. Hay algo en este lugar.
El saludo del almacenero. La vecina que siempre tiene yerba de más.
Pequeñas cosas. Casi nada. Pero algo.


## ELEGIR_POSICION




- **OPCIÓN:** El mismo camino al laburo, las mismas baldosas flojas.
Mañana va a ser igual que hoy. Y pasado igual que mañana.
No es queja. Es lo que hay.
Algunos le dicen resignación. Yo le digo realismo.

- **OPCIÓN:** Una planta que riego todas las mañanas.
La compré cuando me mudé. Casi se me muere dos veces.
Pero ahí sigue. Cada tanto le sale una hoja nueva.
Pequeñas cosas. Capaz que con todo es así.

- **OPCIÓN:** Un mensaje de grupo que tengo silenciado.
Antes opinaba. Discutía. Me calentaba.
Ahora leo por arriba y sigo de largo.
Ya vi esta película. Sé cómo termina.

- **OPCIÓN:** La gotera del techo que nunca arreglo.
Pongo el balde. Se llena. Lo vacío.
Podría arreglarlo. Podría no arreglarlo.
A veces me pregunto si importa.


## ASIGNAR_VINCULO




En el barrio hay gente. Caras conocidas, nombres que recordás a medias.

Pero un momento te vuelve siempre.

- **OPCIÓN:** Un tupper de guiso que apareció en tu puerta. "Sobró", te dijeron. Mentira.
Era Sofía. La de la olla popular.
Sus pibes iban a la misma escuela. O iban.
Nunca hablaron de ese tupper.
Pero desde entonces se miran distinto.

- **OPCIÓN:** Un banco de plaza. Una vieja que te dijo "mirá qué grande estás", como si te conociera de siempre.
Era Elena. La veterana.
Conoció a tu familia. O vos la ayudaste una vez.
Te mira como esperando algo.
No sabés si podés dárselo.

- **OPCIÓN:** Un tipo con una mochila, mirando un papel con una dirección. Le señalaste el camino.
Era Diego. Había llegado hacía poco.
Te buscó después. Preguntó cosas. Confió en vos.
No sabés si merecés esa confianza.

- **OPCIÓN:** Un portón cerrado. Sabés quién vive ahí. Hace rato que no lo ves.
Es Marcos. El que se alejó.
Antes eran cercanos. Antes de que él se quemara.
Ahora se cruzan y es raro.
Hay algo ahí que ninguno termina de cerrar.

- **OPCIÓN:** Una mujer en la cocina de la olla. Pica verduras como si rezara. No la conocés todavía.
Es Ixchel. No sabés su nombre todavía.
Pero algo en sus manos te llamó la atención.
Una precisión antigua. Un silencio que dice cosas.
Alguien te contó que vino de lejos.


## CONFIRMAR_INICIO




{perdida == "familiar": Perdiste a alguien. El hueco sigue.}
{perdida == "relacion": Perdiste una relación. Se disolvió.}
{perdida == "futuro": Perdiste un futuro. La forma que tenía tu vida.}
{perdida == "vacio": Perdiste algo que no sabés nombrar.}

{atadura == "responsabilidad": Te quedás por responsabilidad.}
{atadura == "barrio": Te quedás por el barrio.}
{atadura == "inercia": Te quedás por inercia.}
{atadura == "algo": Te quedás porque hay algo.}

{posicion == "ajeno": Nunca fuiste de política.}
{posicion == "quemado": Creías. Ya no.}
{posicion == "esperanzado": Todavía creés. Pero.}
{posicion == "ambiguo": No sabés qué creés.}

Tu historia está con {vinculo == "sofia": Sofía}{vinculo == "elena": Elena}{vinculo == "diego": Diego}{vinculo == "marcos": Marcos}{vinculo == "ixchel": Ixchel}.

La semana empieza.
Todavía no sabés lo que viene.

- **OPCIÓN:** Empezar la semana

