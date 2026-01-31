// ============================================
// UBICACIÓN: EL BONDI
// Escenas de transporte público
// ============================================

// --- VIAJE DE IDA (mañana) ---

=== bondi_esperar_parada ===
// Llamar desde el día: -> bondi_esperar_parada

La parada del bondi.
Hay gente esperando.
Cada uno en su mundo.

* [Esperar tranquilo] # DADOS
    -> bondi_esperar_tranquilo
* [Mirar el celular] # DADOS # EFECTO:dignidad?
    -> bondi_esperar_celular
* {energia >= 3} [Hablar con alguien] # COSTO:1 # DADOS:conexion # EFECTO:conexion+
    -> bondi_esperar_hablar

=== bondi_esperar_tranquilo ===

Esperás.
El bondi tarda.
Siempre tarda.

La gente mira el celular o el vacío.

~ ultima_tirada = d6()

{ultima_tirada == 6:
    El bondi llega rápido. Día de suerte.
    -> bondi_subir
}
{ultima_tirada == 1:
    El bondi tarda una eternidad.
    ~ energia -= 1
    -> bondi_subir_tarde
}

El bondi llega.
Normal.

-> bondi_subir

=== bondi_esperar_celular ===

Mirás el celular.
Noticias.

~ ultima_tirada = d6()

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

-> bondi_subir

=== bondi_esperar_hablar ===

~ energia -= 1

Hay una señora que siempre está a esta hora.
Nunca hablaste con ella.

"Buen día."

* [...]
-

"Buen día." Te mira sorprendida. "¿Todo bien?"

"Sí, sí. Esperando el bondi nomás."

"Como todos."

* [...]
-

~ ultima_tirada = d6()

{ultima_tirada >= 4:
    "Yo trabajo acá cerca hace 20 años. Antes el bondi venía cada 10 minutos. Ahora..."
    Se encoge de hombros.
    "Todo empeora de a poco. Uno se acostumbra."
    No es una conversación feliz.
    Pero es una conversación.
    ~ subir_conexion(1)
}

El bondi llega.

-> bondi_subir

=== bondi_correr_para_agarrar ===
// Cuando llegás tarde y el bondi está por irse

El bondi está por irse.
Corrés.

// Chequeo físico: llegar al bondi a tiempo
~ temp carrera = chequeo_fisico(0, 3)
{ carrera == 2:
    Lo agarrás de taquito. El chofer te ve llegar corriendo y espera.
    "Dale, subí." Ni transpirado estás.
    -> bondi_subir
}
{ carrera == 1:
    Lo agarrás justo.
    El chofer te mira con cara de "siempre lo mismo".
    Pero te deja subir.
    -> bondi_subir
}
{ carrera == 0:
    Se va.
    El bondi se va en tu cara.

    Mierda.

    * [Esperar el próximo] # COSTO:1
        -> bondi_esperar_otro
    * [Caminar] # COSTO:1
        -> bondi_caminar_alternativa
}
{ carrera == -1:
    Corrés y te torcés el tobillo en la vereda rota.
    El bondi se va.

    Mierda. Mierda.

    ~ gastar_energia(1)

    * [Esperar el próximo renqueando] # COSTO:1
        -> bondi_esperar_otro
    * [Caminar como puedas] # COSTO:1
        -> bondi_caminar_alternativa
}

=== bondi_esperar_otro ===

Esperás el próximo.
20 minutos.

~ energia -= 1

Llegás tarde.

-> bondi_subir_tarde

=== bondi_caminar_alternativa ===

Decidís caminar.
40 minutos, más o menos.

~ energia -= 1

Es un día {d6() >= 4: lindo|gris} al menos.
Caminás.

Llegás tarde.
Pero llegás.

-> bondi_llegada_destino_tarde

=== bondi_subir ===

# EN EL BONDI

El bondi lleno.
Cuerpos apretados.
Olor a cuerpos, a sudor de madrugada, a cansancio acumulado.

* [...]
-

Conseguís un lugar donde agarrarte.

-> bondi_continuar_viaje

=== bondi_continuar_viaje ===

* [Mirar por la ventana] -> bondi_ventana
* [Cerrar los ojos] -> bondi_ojos_cerrados
* [Escuchar conversaciones] -> bondi_escuchar

=== bondi_subir_tarde ===

# EN EL BONDI (tarde)

Subís al bondi.
Ya es tarde.
El estrés se suma al cansancio.

El bondi va más vacío a esta hora, al menos.
Te sentás.

-> bondi_ventana

=== bondi_ventana ===

La ciudad pasa.
Los edificios.
La gente en las veredas.

* [...]
-

Los carteles de "Se alquila", "Se vende", "Cerrado".

{dia_actual == 1: Cada vez más carteles de esos.}
{dia_actual >= 4 && not tiene_laburo: Los carteles se sienten diferentes ahora. Más cercanos.}

-> bondi_llegada_destino

=== bondi_ojos_cerrados ===

Cerrás los ojos.
El ruido del bondi.
El movimiento.

* [...]
-

Por un segundo, casi te dormís.

...

* [...]
-

{d6() >= 4:
    Tu parada. Justo a tiempo.
- else:
    Alguien te empuja.
    Casi te pasás.
}

-> bondi_llegada_destino

=== bondi_escuchar ===

Dos personas atrás hablan:

~ ultima_tirada = d6()

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

-> bondi_llegada_destino

=== bondi_llegada_destino ===

Tu parada.
Bajás.

->->
// El día que llama debe continuar el flujo después de esto

=== bondi_llegada_destino_tarde ===

Tu parada.
Bajás.
Tarde.

->->

// --- VIAJE DE VUELTA (tarde) ---

=== bondi_vuelta ===
// Llamar cuando volvés del laburo

El bondi de vuelta.
Menos lleno que a la mañana.

Te sentás.

* [...]
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

* [Pensar en el día] -> bondi_vuelta_pensar
* [Desconectar] -> bondi_vuelta_desconectar
* [Mirar a la gente] -> bondi_vuelta_gente

=== bondi_vuelta_pensar ===

Pensás en el día.

{dia_actual == 1 && hable_con_juan_sobre_rumores:
    En lo que dijo Juan.
    En los despidos.
    En la reunión.
}

* [...]
-

{not tiene_laburo:
    En que no tenés laburo.
    En que no hay colchón. Nada.
    Unipersonal. Sin derechos.
}

El bondi llega al barrio.

-> bondi_llegada_barrio

=== bondi_vuelta_desconectar ===

Desconectás.
Música en los auriculares.
O nada.

* [...]
-

Solo el ruido del bondi.

Por un rato, no pensás.

El bondi llega al barrio.

-> bondi_llegada_barrio

=== bondi_vuelta_gente ===

Mirás a la gente.

Un viejo con bolsas.
Una mina con uniforme de trabajo.
Un pibe con la mochila del colegio.

* [...]
-

Todos volviendo a algún lado.
Todos con sus cosas.

El bondi llega al barrio.

-> bondi_llegada_barrio

=== bondi_llegada_barrio ===

Tu parada.
El barrio.

Bajás.

->->
