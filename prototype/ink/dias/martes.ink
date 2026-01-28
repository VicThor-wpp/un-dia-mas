// ============================================
// MARTES - LA TENSIÓN CRECE
// Routing con tunnels, contenido específico del día
// ============================================

=== martes_amanecer ===

~ dia_actual = 2
~ energia = 4

# MARTES

// --- Ecos del lunes ---
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

// Despertar en casa
-> casa_despertar ->

// En el bondi, la gente habla de despidos
-> martes_bondi_tension

=== martes_bondi_tension ===

-> bondi_esperar_parada ->

// Contenido específico del martes: la tensión en el aire
Pero algo se siente diferente hoy.

En el micro, la gente habla de despidos.
En otras empresas, en otros lados.
"La cosa está jodida", dice alguien.

Vos escuchás.
No pensás que te toque a vos.

* [Ir al laburo] -> martes_laburo

=== martes_laburo ===

-> laburo_llegada ->

// El laburo hoy está raro - contenido específico del martes
El laburo hoy está raro.

El jefe no te mira.
Los de RRHH entran y salen.
Hay reuniones que no te incluyen.

// Chequeo mental: aguantar la tensión del martes
~ temp aguante = chequeo_mental(0, 4)
{ aguante == 2:
    Respirás hondo. Te concentrás en lo tuyo. Si pasa algo, pasa. Pero hoy estás entero.
    ~ pequenas_victorias += 1
}
{ aguante == 1:
    Intentás no pensar en eso. Te concentrás en la pantalla. Más o menos funciona.
}
{ aguante == 0:
    No podés dejar de mirar la puerta de RRHH. Cada vez que se abre, el estómago se cierra.
}
{ aguante == -1:
    Las manos te tiemblan. No podés concentrarte en nada. El miedo te paraliza.
    ~ aumentar_inercia(1)
}

-> laburo_manana ->

// Encuentro con Juan
-> juan_saludo_manana ->

// Trabajo de rutina
-> laburo_trabajo_rutina ->

// A la tarde, la citación
-> martes_citacion

=== martes_citacion ===

A la tarde, te llaman.

-> laburo_citacion_rrhh ->

-> martes_tarde

=== martes_tarde ===

~ energia -= 1

-> laburo_tarde ->

El resto del día es largo.
Las horas no pasan.

Pensás en mañana.
En lo que puede ser.
En lo que probablemente sea.

-> laburo_salida ->

-> martes_bondi_vuelta

=== martes_bondi_vuelta ===

-> bondi_vuelta ->

A las 5 te vas.

* [Ir a casa] # EFECTO:conexion-
    -> martes_casa
* {energia >= 2} [Buscar a alguien] # COSTO:1 # STAT:conexion # EFECTO:conexion+
    -> martes_buscar

=== martes_buscar ===

~ energia -= 1

Necesitás hablar con alguien.
O solo estar con alguien.

// Chequeo social: encontrar a tu vínculo
~ temp busqueda = chequeo_social(0, 3)
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
    ~ aumentar_inercia(1)
}

{vinculo == "sofia": -> martes_buscar_sofia}
{vinculo == "elena": -> martes_buscar_elena}
{vinculo == "diego": -> martes_buscar_diego}
{vinculo == "marcos": -> martes_buscar_marcos}

=== martes_buscar_sofia ===

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

~ subir_conexion(1)

-> martes_casa

=== martes_buscar_elena ===

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

~ subir_conexion(1)

-> martes_casa

=== martes_buscar_diego ===

Encontrás a Diego saliendo del depósito.

"¿Qué onda?"

"Nada. Mañana tengo una reunión."

Diego entiende.
Él vive con eso todos los días.
La precariedad.

"Si pasa algo, avisame."

"Dale."

~ subir_conexion(1)

-> martes_casa

=== martes_buscar_marcos ===

Llamás a Marcos.
No contesta.

Mandás mensaje.
"Visto" pero no responde.

Así es Marcos ahora.
Presente pero ausente.

-> martes_casa

=== martes_casa ===

-> casa_llegada_noche ->

// Contenido específico de la noche del martes: la tensión
Llegás a casa.
La noche es larga.

No dormís bien.

* [...]
-

En lo que viene.

// La angustia de la precariedad
Pensás en lo que viene. Si te echan, no hay nada. 
La "unipersonal" fue el invento perfecto: les diste tres años de tu vida y ellos no te deben ni el saludo. 
Sin indemnización. Sin despido. Sin red.
Solo una factura que ya no vas a emitir.
* [Intentar dormir] -> fragmento_martes

=== fragmento_martes ===

# MIENTRAS DORMÍS

// El fragmento de martes muestra la tensión de todos

{vinculo == "sofia": -> fragmento_sofia_martes}
{vinculo == "elena": -> fragmento_elena_martes}
{vinculo == "diego": -> fragmento_diego_martes}
{vinculo == "marcos": -> fragmento_marcos_martes}
-> fragmento_martes_default

=== fragmento_martes_default ===

La noche pasa despacio.
El barrio duerme.
Vos no.

* [...]
-

Pensás en el laburo.
En lo que significa.
En lo que sos sin él.

* [...]
-

¿Quién sos sin eso?
Mañana vas a saber.

* [Continuar] -> martes_cliffhanger

=== fragmento_sofia_martes ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Sofía piensa en vos.

    En cómo te vio hoy.
    Roto antes de tiempo.

    "Así empiezan a caer", piensa.
    "Primero la dignidad. Después todo."

    Conoció a tantos que terminaron así.
    Ahora vos también.

    ~ aumentar_inercia(1)
    * [Continuar] -> martes_cliffhanger
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Sofía está sola en la olla.

    Nadie ayudó hoy.
    Nadie preguntó.

    "El barrio se muere", piensa.

    Antes la gente se juntaba.
    Ahora cada uno en su casa.
    Cada uno solo.

    ~ bajar_llama(1)
    * [Continuar] -> martes_cliffhanger
}

// FRAGMENTO NORMAL
# SOFÍA

Sofía tampoco duerme bien.

La olla necesita cosas.
Siempre necesita cosas.
Y cada vez hay menos.

* [...]
-

Piensa en mañana.
En la comida que hay que conseguir.
En la gente que viene.

* [...]
-

El barrio la necesita.
Eso la mantiene despierta.

* [Continuar] -> martes_cliffhanger

=== fragmento_elena_martes ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
    Elena prende la radio.

    Hablan de despidos masivos.
    De gente que se rompe.

    Piensa en vos.
    En lo que vio en tu cara.

    "El 2002 quebró a muchos así", piensa.
    "Los que aceptaron todo hasta que no quedó nada."

    Raúl también estuvo cerca.
    Muy cerca.

    ~ aumentar_inercia(1)
    * [Continuar] -> martes_cliffhanger
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Elena mira por la ventana.

    El barrio oscuro.
    Todas las ventanas cerradas.

    "Ya nadie se conoce", piensa.
    "Ya nadie toca el timbre del vecino."

    Cuando Raúl murió, tres vecinos vinieron.
    Tres.

    Antes hubiera sido el barrio entero.

    ~ bajar_llama(1)
    * [Continuar] -> martes_cliffhanger
}

// FRAGMENTO NORMAL
# ELENA

Elena está con la radio.

Las noticias hablan de ajustes.
De despidos.
De lo que viene.

Ella ya vio esto antes.
Sabe cómo termina.
Sabe que solo juntos se sale.

Apaga la radio.
Mañana hay que estar atentos.

* [Continuar] -> martes_cliffhanger

=== fragmento_diego_martes ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
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

    ~ aumentar_inercia(1)
    * [Continuar] -> martes_cliffhanger
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
    Diego cuenta sus contactos.

    Tres personas hablan con él.
    Tres.

    En Venezuela no tenía muchos.
    Acá tiene menos.

    "Vine a estar solo en otro idioma", piensa.

    La pieza alquilada.
    El depósito.
    Nadie.

    ~ bajar_llama(1)
    * [Continuar] -> martes_cliffhanger
}

// FRAGMENTO NORMAL
# DIEGO

Diego mira el techo.

El depósito anda raro.
Hablan de "reestructuración".
Él sabe qué significa eso.

Piensa en su madre.
En Venezuela.
En todo lo que dejó para venir acá.

No puede perder esto también.

* [Continuar] -> martes_cliffhanger

=== fragmento_marcos_martes ===

{dignidad <= 2:
    // FRAGMENTO OSCURO - Dignidad destruida
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

    ~ aumentar_inercia(1)
    * [Continuar] -> martes_cliffhanger
}

{conexion <= 1:
    // FRAGMENTO OSCURO - Aislamiento total
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

    ~ bajar_llama(1)
    * [Continuar] -> martes_cliffhanger
}

// FRAGMENTO NORMAL
# MARCOS

Marcos está despierto.

La tele encendida.
El celular con mensajes sin leer.
No quiere hablar con nadie.

Antes era diferente.
Antes tenía ganas.
Ahora solo funciona.

Mañana será igual.
Siempre es igual.

* [Continuar] -> martes_cliffhanger

=== martes_cliffhanger ===

El celular vibra.

Es de RRHH.

"Confirmamos reunión mañana 11 AM. Sala 3."

No dice más.
Pero sabés que no es bueno.

* [Intentar dormir] -> transicion_martes_miercoles

=== transicion_martes_miercoles ===
// Chequeo de colapso mental antes de continuar
{peso_estructural <= 0:
    -> final_apagado
}

// Chequeo de destrucción del tejido social
{llama <= 0:
    -> final_sin_llama
}

-> miercoles_amanecer
