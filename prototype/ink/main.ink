// ============================================
// UN DÍA MÁS - Prototipo Modular
// ============================================

// --- INCLUDES: MECÁNICAS ---
INCLUDE mecanicas/dados.ink
INCLUDE mecanicas/recursos.ink
INCLUDE mecanicas/ideas.ink
INCLUDE mecanicas/sistema_ideas.ink

// --- INCLUDES: VARIABLES ---
INCLUDE variables.ink

// --- INCLUDES: UBICACIONES ---
INCLUDE ubicaciones/casa.ink
INCLUDE ubicaciones/bondi.ink
INCLUDE ubicaciones/laburo.ink
INCLUDE ubicaciones/barrio.ink
INCLUDE ubicaciones/olla.ink
INCLUDE ubicaciones/busqueda.ink

// --- INCLUDES: PERSONAJES ---
INCLUDE personajes/juan.ink
INCLUDE personajes/sofia.ink
INCLUDE personajes/elena.ink
INCLUDE personajes/diego.ink
INCLUDE personajes/marcos.ink
INCLUDE personajes/ixchel.ink
INCLUDE personajes/lucia.ink
INCLUDE personajes/tiago.ink
INCLUDE personajes/cacho.ink
INCLUDE personajes/bruno.ink
INCLUDE personajes/claudia.ink

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

# UN DÍA MÁS
# AUDIO:bgm_sueno

Todavía no despertaste.

Fragmentos.

Una mano. Una calle. Una voz.

* [Tu madre esperando. El cepillo de dientes que quedó.]
    ~ perdida = "familiar"
    ~ atadura = "responsabilidad"
* [La valija sin abrir. El diploma en un cajón.]
    ~ perdida = "futuro"
    ~ atadura = "inercia"
* [El almacenero. La panadera. Las veredas rotas.]
    ~ perdida = "vacio"
    ~ atadura = "barrio"
* [El portón cerrado. Lo que no dijiste.]
    ~ perdida = "relacion"
    ~ atadura = "algo"

- "...hay que organizarse..."

La voz se pierde.

Una cara. Alguien del barrio.

* [Sofía. Un tupper que apareció en tu puerta.]
    ~ vinculo = "sofia"
    ~ posicion = "esperanzado"
* [Elena. "Mirá qué grande estás", te dijo.]
    ~ vinculo = "elena"
    ~ posicion = "quemado"
* [Diego. Le señalaste el camino. Te buscó después.]
    ~ vinculo = "diego"
    ~ posicion = "ajeno"
* [Marcos. El portón cerrado. Algo sin cerrar.]
    ~ vinculo = "marcos"
    ~ posicion = "ambiguo"
* [Ixchel. Trabaja en la olla. Seria. Sin sonrisas de compromiso.]
    ~ vinculo = "ixchel"
    ~ posicion = "esperanzado"

-

* [Despertar] -> lunes_amanecer
