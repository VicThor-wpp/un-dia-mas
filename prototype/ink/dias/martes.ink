// ============================================
// MARTES - LA TENSIÓN CRECE
// Routing con tunnels, contenido específico del día
// ============================================

=== martes_amanecer ===

~ dia_actual = 2
~ energia = 4

# MARTES

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

-> laburo_manana ->

// Encuentro con Renzo
-> renzo_saludo_manana ->

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
Pensás en mañana.
En la reunión.
En lo que viene.

Tres meses de indemnización si te echan.
No es el fin del mundo.
Pero algo termina igual.

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

Pensás en el laburo.
En lo que significa.
En lo que sos sin él.

¿Quién sos sin eso?
Mañana vas a saber.

* [Continuar] -> miercoles_amanecer

=== fragmento_sofia_martes ===

# SOFÍA

Sofía tampoco duerme bien.

La olla necesita cosas.
Siempre necesita cosas.
Y cada vez hay menos.

Piensa en mañana.
En la comida que hay que conseguir.
En la gente que viene.

El barrio la necesita.
Eso la mantiene despierta.

* [Continuar] -> miercoles_amanecer

=== fragmento_elena_martes ===

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

* [Continuar] -> miercoles_amanecer

=== fragmento_diego_martes ===

# DIEGO

Diego mira el techo.

El depósito anda raro.
Hablan de "reestructuración".
Él sabe qué significa eso.

Piensa en su madre.
En Venezuela.
En todo lo que dejó para venir acá.

No puede perder esto también.

* [Continuar] -> miercoles_amanecer

=== fragmento_marcos_martes ===

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

* [Continuar] -> miercoles_amanecer
