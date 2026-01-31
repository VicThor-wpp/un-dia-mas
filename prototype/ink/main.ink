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

El cuerpo sabe que tiene que levantarse.
La cabeza sigue en otro lado.

Fragmentos.

Una mano que conocías.

* [La última vez, en el hospital. No dijo nada.]
    ~ perdida = "familiar"
* [Se fue un martes. El cepillo de dientes quedó.]
    ~ perdida = "relacion"
* [Tu mano, más joven. Sosteniendo un diploma.]
    ~ perdida = "futuro"
* [Vacía. Buscando algo que no encontrás.]
    ~ perdida = "vacio"

- Una calle. La tuya.

* [Tu madre sola, esperando. No podés irte.]
    ~ atadura = "responsabilidad"
* [El árbol que plantó tu abuelo. Estas calles son tu cuerpo.]
    ~ atadura = "barrio"
* [La valija que armaste hace dos años. Sigue ahí.]
    ~ atadura = "inercia"
* [El almacenero. La panadera. Algo que no sabés nombrar.]
    ~ atadura = "algo"

- Una voz. Lejana.

"...hay que organizarse..."

* [La ignorás. Ya escuchaste eso.]
    ~ posicion = "quemado"
* [Algo se mueve adentro.]
    ~ posicion = "esperanzado"
* [No entendés. No es tu mundo.]
    ~ posicion = "ajeno"
* [No sabés qué sentir.]
    ~ posicion = "ambiguo"

- Una cara.

Alguien del barrio. Alguien que importa.

* [Sofía. Un tupper que apareció en tu puerta.]
    ~ vinculo = "sofia"
* [Elena. "Mirá qué grande estás", te dijo.]
    ~ vinculo = "elena"
* [Diego. Le señalaste el camino. Te buscó después.]
    ~ vinculo = "diego"
* [Marcos. El portón cerrado. Algo sin cerrar.]
    ~ vinculo = "marcos"
* [Ixchel. Trabaja en la olla. Seria. Sin sonrisas de compromiso.]
    ~ vinculo = "ixchel"

-

* [Despertar] -> lunes_amanecer
