// ============================================
// UBICACIÓN: LA CASA
// Escenas en el hogar del protagonista
// ============================================

// --- DESPERTAR ---

=== casa_despertar ===
// Llamar al inicio de cada día

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

* [Levantarte de una] # EFECTO:dignidad+
    -> casa_levantarse_rapido
* [Cinco minutos más] # COSTO:1 # EFECTO:dignidad?
    -> casa_cinco_mas
* {tiene_laburo} [Apagar el despertador y quedarte] # COSTO:1 # EFECTO:dignidad-
    -> casa_quedarse
* {not tiene_laburo} [Quedarte en la cama] # COSTO:1 # EFECTO:conexion-
    -> casa_quedarse_sin_laburo

=== casa_levantarse_rapido ===

Te levantás de una.
La disciplina del cuerpo que ya no pregunta.

{tiene_laburo: Años de lo mismo. El cuerpo sabe.}
{not tiene_laburo: El cuerpo todavía no sabe que ya no hace falta.}

-> casa_mate

=== casa_cinco_mas ===

Cinco minutos más.
El techo.
La luz que entra.

{perdida == "familiar": Por un segundo pensás en tu vieja. O en tu viejo. En las mañanas de antes.}
{perdida == "relacion": La cama está vacía del otro lado. Ya te acostumbraste. Casi.}
{perdida == "futuro": Pensás en todo lo que ibas a ser. Y en esto que sos.}
{perdida == "vacio": Hay algo que falta. Nunca sabés qué.}

Los cinco minutos se estiran.
Son diez.

~ energia -= 1

{tiene_laburo:
    Mierda. Vas a llegar tarde.
    * [Levantarte apurado] -> casa_mate_apurado
}
{not tiene_laburo:
    No importa.
    No hay a dónde llegar.
    * [Levantarte] -> casa_mate
}

=== casa_quedarse ===

Apagás el despertador.
Te quedás.

El techo.
El silencio.
La pregunta de siempre: ¿para qué?

...

No. Hay que ir.
Hay cuentas que pagar.
Hay un sistema que te necesita funcionando.

~ energia -= 1

Te levantás. Tarde.

* [Apurarte] -> casa_mate_apurado

=== casa_quedarse_sin_laburo ===

Te quedás en la cama.
No hay apuro.

~ energia -= 1

El techo.
El silencio.
Los pensamientos.

{salud_mental <= 4:
    ¿Quién sos ahora?
    ¿Qué hacés?
    ¿Para qué te levantás?
}

Eventualmente, el cuerpo pide moverse.

* [Levantarte] -> casa_mate

=== casa_mate ===

# EL CAFÉ

El café de especialidad en la prensa francesa.
El ritual que te despierta y te sostiene.

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

No es gusto.
Es sostén energético.
Una forma de sobrevivir a la mañana.

El café se termina.

->->

=== casa_mate_apurado ===

No hay tiempo para café.
Un vaso de agua y listo.

El día empieza mal.
Pero empieza.

->->

// --- SALIR DE CASA ---

=== casa_salir ===
// Momento de salir, encuentros en el barrio

# LA SALIDA

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

->->

// --- VOLVER A CASA (NOCHE) ---

=== casa_llegada_noche ===
// Cuando llegás a casa de noche

# NOCHE

Llegás a casa.

{energia <= 1: Estás destruido. No das para nada.}
{energia == 2: Estás cansado. Pero se puede.}
{energia >= 3: Todavía tenés algo de energía.}

* {energia >= 2} [Cocinar algo decente] # COSTO:1 # EFECTO:dignidad+
    -> casa_cocinar
* [Comer cualquier cosa] # EFECTO:dignidad-
    -> casa_comer_rapido
* {energia >= 2} [Llamar a alguien] # COSTO:1 # STAT:conexion # EFECTO:conexion+
    -> casa_llamar_noche
* [Tele y a dormir] # EFECTO:conexion-
    -> casa_tele

=== casa_cocinar ===

~ energia -= 1

Cocinás algo.
Nada elaborado.
Pero comida de verdad.

Mientras cocinás, pensás.
{tiene_laburo: En el laburo. En lo que viene.}
{not tiene_laburo: En lo que no tenés. En lo que tenés que buscar.}

Comés.
No está mal.

-> casa_noche_final

=== casa_comer_rapido ===

Cualquier cosa.
Lo que haya.
Pan con algo.
Sobras.

Comés parado, mirando el celular.
Las noticias.
Las redes.
Nada bueno.

-> casa_noche_final

=== casa_llamar_noche ===

~ energia -= 1

Llamás a alguien.

{vinculo == "sofia":
    ~ ultima_tirada = d6()
    {ultima_tirada >= 4:
        Sofía contesta. Hablan un rato.
        De los pibes, de la olla, de la vida.
        ~ subir_conexion(1)
    - else:
        Sofía no contesta. Está acostando a los pibes.
    }
}
{vinculo == "elena":
    Elena contesta. Siempre contesta.
    Hablan un rato. Te hace bien.
    ~ subir_conexion(1)
}
{vinculo == "diego":
    Diego contesta.
    Hablan boludeces. Está bien.
    ~ subir_conexion(1)
}
{vinculo == "marcos":
    Marcos no contesta.
    Como siempre.
}

-> casa_noche_final

=== casa_tele ===

Prendés la tele.
Canales.
Noticias.

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

-> casa_noche_final

=== casa_noche_final ===

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

->->

// --- FIN DE SEMANA / DÍA LIBRE ---

=== casa_dia_libre ===
// Para días sin laburo o fines de semana

La mañana.
{dia_actual == 6 || dia_actual == 7: Fin de semana.}
{not tiene_laburo && dia_actual < 6: Un día más sin laburo.}

No hay apuro.
Pero tampoco hay nada.

* [Quedarte en casa] # COSTO:1 # STAT:conexion
    -> casa_quedarse_dia
* [Salir]
    ->->  // El día maneja a dónde

=== casa_quedarse_dia ===

~ energia -= 1
~ bajar_conexion(1)

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

->->
