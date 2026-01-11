// ============================================
// LA LLAMA - Prototipo Modular
// ============================================

// --- INCLUDES: MECÁNICAS ---
INCLUDE mecanicas/dados.ink
INCLUDE mecanicas/recursos.ink

// --- INCLUDES: VARIABLES ---
INCLUDE variables.ink

// --- INCLUDES: UBICACIONES ---
INCLUDE ubicaciones/casa.ink
INCLUDE ubicaciones/bondi.ink
INCLUDE ubicaciones/laburo.ink
INCLUDE ubicaciones/barrio.ink
INCLUDE ubicaciones/olla.ink

// --- INCLUDES: PERSONAJES ---
INCLUDE personajes/renzo.ink
INCLUDE personajes/sofia.ink
INCLUDE personajes/elena.ink
INCLUDE personajes/diego.ink
INCLUDE personajes/marcos.ink

// --- INCLUDES: DÍAS ---
INCLUDE dias/lunes.ink
INCLUDE dias/martes.ink
INCLUDE dias/miercoles.ink
INCLUDE dias/jueves.ink
INCLUDE dias/viernes.ink
INCLUDE dias/sabado.ink
INCLUDE dias/domingo.ink

// --- INCLUDES: OTROS ---
INCLUDE fragmentos/fragmentos.ink
INCLUDE finales/finales.ink

// ============================================
// INICIO DEL JUEGO
// ============================================

-> inicio

=== inicio ===

# LA LLAMA
# Un juego sobre pertenecer cuando todo se reorganiza

La semana empieza como cualquier otra.
Todavía no sabés lo que viene.

* [Empezar] -> creacion_personaje

=== creacion_personaje ===

# ANTES DE EMPEZAR

Algunas cosas sobre vos:

Tenés treinta y algo.
Laburás. Pagás las cuentas. Más o menos.
Vivís en el barrio o cerca.
Conocés a la gente de vista, de cruce, de historia compartida.

Pero hay cosas que solo vos sabés.

-> elegir_perdida

=== elegir_perdida ===

# ¿QUÉ PERDISTE?

* [Mi vieja. O mi viejo.]
    ~ perdida = "familiar"
    Murió. Hace poco o hace mucho, pero el hueco sigue ahí.
    A veces pasás por lugares y te acordás.
    Heredaste algo: un objeto, una deuda, una promesa.
    -> elegir_atadura

* [Una relación.]
    ~ perdida = "relacion"
    Se fue. O te fuiste. O se pudrió de a poco.
    A veces la cruzás en el barrio. A veces evitás las calles.
    No terminó. Se disolvió.
    -> elegir_atadura

* [Un futuro que imaginabas.]
    ~ perdida = "futuro"
    Ibas a ser algo. Estudiaste, o casi.
    La vida tenía una forma. Ahora no tiene ninguna.
    A veces pensás en el vos que no fuiste.
    -> elegir_atadura

* [Algo que no sé nombrar.]
    ~ perdida = "vacio"
    No hubo evento. No hubo momento.
    Solo un día te diste cuenta de que algo faltaba.
    Seguís buscando qué es.
    -> elegir_atadura

=== elegir_atadura ===

# ¿POR QUÉ SEGUÍS ACÁ?

* [Responsabilidad.]
    ~ atadura = "responsabilidad"
    Alguien depende de vos. Tu vieja, tu viejo, alguien.
    No es cadena. Es peso. ¿Hay diferencia?
    -> elegir_posicion

* [El barrio.]
    ~ atadura = "barrio"
    Luchaste por estar acá. Años de historia.
    Irte es traicionar algo. No sabés bien qué.
    -> elegir_posicion

* [Inercia.]
    ~ atadura = "inercia"
    No hay razón. No hay plan.
    Podrías irte. No te vas.
    A veces eso se siente como elección. A veces como trampa.
    -> elegir_posicion

* [Algo que queda.]
    ~ atadura = "algo"
    Hay algo acá. En el barrio, en la gente.
    No sabés si es esperanza o costumbre.
    Pero todavía hay algo.
    -> elegir_posicion

=== elegir_posicion ===

# ¿QUÉ PENSÁS DE "LA LUCHA"?

La política, la militancia, eso de organizarse.

* [Nunca fui de eso.]
    ~ posicion = "ajeno"
    Siempre te pareció lejano. Cosa de otros.
    Ahora estás acá, en el barrio, y la política está en todo.
    No elegiste esto. Pero acá estás.
    -> asignar_vinculo

* [Creía. Ya no.]
    ~ posicion = "quemado"
    Militaste, o casi. Creíste en algo.
    Ahora no. El cinismo vino solo.
    A veces extrañás creer. A veces te da vergüenza haber creído.
    -> asignar_vinculo

* [Todavía creo. Pero.]
    ~ posicion = "esperanzado"
    Seguís pensando que las cosas pueden cambiar.
    Pero cada vez cuesta más. El "pero" pesa más.
    -> asignar_vinculo

* [No sé qué creo.]
    ~ posicion = "ambiguo"
    Hay días que sí. Días que no.
    Alguien dice algo y sentís algo.
    Las noticias dicen algo y no sentís nada.
    Estás en el medio. Siempre en el medio.
    -> asignar_vinculo

=== asignar_vinculo ===

// El vínculo se asigna aleatoriamente
~ temp dado = RANDOM(1, 4)

{
    - dado == 1:
        ~ vinculo = "sofia"
        Sofía. La de la olla.
        Los pibes van a la misma escuela, o iban.
        Sabés lo que carga. Ella sabe lo que cargás.
        No hablan de eso. Pero saben.
    - dado == 2:
        ~ vinculo = "elena"
        Elena. La veterana.
        Conocía a tu familia. O vos la ayudaste una vez.
        Te mira diferente. Espera algo de vos.
        No sabés si podés dárselo.
    - dado == 3:
        ~ vinculo = "diego"
        Diego. El nuevo.
        Llegó hace poco. Le diste una mano con algo.
        Te busca. Pregunta cosas. Confía en vos.
        No sabés si merecés esa confianza.
    - dado == 4:
        ~ vinculo = "marcos"
        Marcos. El que se alejó.
        Antes eran cercanos. Antes de que él se quemara.
        Ahora se cruzan y es raro.
        Hay algo ahí que ninguno termina de cerrar.
}

-> confirmar_inicio

=== confirmar_inicio ===

# LISTO

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

Tu historia está con {vinculo == "sofia": Sofía}{vinculo == "elena": Elena}{vinculo == "diego": Diego}{vinculo == "marcos": Marcos}.

La semana empieza el lunes.
Todavía no sabés lo que viene.

* [Empezar la semana] -> lunes_amanecer
