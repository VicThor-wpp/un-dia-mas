// ============================================
// UBICACIÓN: EL LABURO
// Escenas en el trabajo
// ============================================

// --- LLEGADA ---

=== laburo_llegada ===

# EL LABURO

Llegás.
8:05.
Justo.

El edificio de siempre.
La puerta de siempre.
El ascensor de siempre.

* [...]
-

"Buen día."
"Buen día."
"Buen día."

Todos dicen buen día.
Nadie pregunta si lo es.

->->

=== laburo_llegada_tarde ===

# EL LABURO

Llegás.
8:25.
Tarde.

El jefe te ve entrar.
No dice nada.
Anota algo.

Mierda.

~ bajar_salud_mental(1)

->->

// --- MAÑANA DE TRABAJO ---

=== laburo_manana ===

# LA MAÑANA

El escritorio.
La computadora.
Los mails.

Lo de siempre.

{energia >= 3:
    Estás enfocado. El trabajo sale.
- else:
    Te cuesta concentrarte. El cansancio pesa.
}

->->

=== laburo_trabajo_rutina ===

Las horas pasan.

Mails.
Planillas.

* [...]
-

Reuniones que podrían ser mails.
Mails que podrían ser nada.

{d6() <= 2:
    El jefe pasa por tu escritorio.
    Te mira.
    No dice nada.
    Sigue.

    ¿Qué mierda fue eso?
    ~ bajar_salud_mental(1)
}

->->

// --- ALMUERZO ---

=== laburo_almuerzo ===

# ALMUERZO

12:30.
Hora de comer.

* [Almorzar acompañado] # DADOS # STAT:conexion # EFECTO:conexion+
    -> laburo_almuerzo_acompanado
* [Almorzar solo] # EFECTO:conexion-
    -> laburo_almuerzo_solo
* [Saltear el almuerzo] # COSTO:1 # EFECTO:dignidad-
    -> laburo_almuerzo_saltear

=== laburo_almuerzo_acompanado ===

Bajás al comedor.
Sacás el tupper de la mochila.

Lo que trajiste de casa.
Lo que pudiste armar anoche.

~ ultima_tirada = d6()
{ultima_tirada <= 2: Arroz con huevo. Otra vez.}
{ultima_tirada == 3 || ultima_tirada == 4: Fideos con tuco de ayer.}
{ultima_tirada >= 5: Milanesa fría. Lujo.}

Te sentás con alguien.
Hablás de cosas.
{d6() >= 4: Por un rato, te olvidás de los problemas.|Pero los problemas siguen ahí.}

~ subir_conexion(1)

->->

=== laburo_almuerzo_solo ===

Comés solo.
En un rincón del comedor.
El tupper sobre la mesa.

A veces está bien.
El silencio.
No tener que hablar.

* [...]
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

* [...]
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

El jefe y alguien de RRHH al frente.

* [...]
-

"Buenas tardes. Queríamos informarles..."

El aire se tensa.

"...que la empresa está atravesando un proceso de reestructuración."

Ahí está.

* [...]
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

~ bajar_salud_mental(1)

->->

// --- CITACIÓN A RRHH ---

=== laburo_citacion_rrhh ===

Te llaman.

"Mañana a las 11, en RRHH."

No dicen para qué.

* [Preguntar para qué]
    "¿Para qué?"
    "Es una reunión de rutina."
    No suena a rutina.
    -> laburo_citacion_fin
* [Asentir]
    Asentís.
    No preguntás.
    A veces es mejor no saber.
    -> laburo_citacion_fin

=== laburo_citacion_fin ===

~ bajar_salud_mental(1)

Aunque ya sabés.
O creés saber.

->->

// --- EL DESPIDO ---

=== laburo_despido ===

# LA REUNIÓN

La oficina de RRHH.
Dos personas que no conocés bien.
Un papel sobre la mesa.

"La empresa está reestructurando."

Ah.

* [...]
-

"Tu puesto fue afectado."

Así que era eso.

"Dejamos de necesitar tus servicios. Gracias por tu colaboración."

* [Escuchar] # FALSA
    No hay liquidación. No hay indemnización.
    Sos unipersonal. Facturás. "Independiente."
    Así te contrataron hace tres años.
    Así te echan hoy.

* [Aceptar] -> laburo_despido_firmar
* [Preguntar por qué] # EFECTO:dignidad? -> laburo_despido_preguntar

=== laburo_despido_preguntar ===

"¿Por qué yo?"

Se miran entre ellos.

"No es personal. Es reestructuración."

"Pero trabajo acá hace tres años."

* [...]
-

"Trabajás con nosotros. Facturás. Es diferente."

Claro. Siempre fue diferente cuando les convenía.
Nunca es personal.
Es el sistema funcionando como fue diseñado.

* [Irte] -> laburo_despido_firmar

=== laburo_despido_firmar ===

No hay nada que firmar.
Sos unipersonal. Simplemente dejás de facturar.

Te dan una caja para tus cosas.
No tenés muchas cosas.

* [...]
-

El escritorio se vacía rápido.

~ fui_despedido = true
~ tiene_laburo = false
~ bajar_salud_mental(1)

->->

// --- SALIDA DEL LABURO ---

=== laburo_salida ===

# LA SALIDA

5 de la tarde.
El laburo terminó.
Por hoy.

Caminás a la parada.
El cuerpo cansado.
La cabeza {d6() >= 4: cansada también|peor}.

->->

=== laburo_salida_despedido ===

# LA CALLE

Salís con tu caja.

La calle está igual que siempre.
El sol es el mismo sol.
La gente camina como si nada.

* [Seguir caminando] # FALSA
    Pero vos estás parado acá con una caja.
    A las 11:30 de la mañana de un miércoles.
    Sin laburo.

* [...]
-

Tenés tres meses de colchón.
No te estás muriendo.
Pero algo murió.

¿Quién sos ahora que no tenés laburo?

* [...]
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
    ~ bajar_salud_mental(1)
    ->->
}
