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
# AUDIO:bgm_rutina

Suena el despertador. Todavía está oscuro afuera.
El colchón tiene un hundimiento que ya tiene la forma de tu cuerpo.
En la cocina, la canilla gotea. Siempre gotea.

Otra semana que empieza. Otra semana como todas.
Todavía no sabés lo que viene.

* [Levantarse] -> creacion_personaje

=== creacion_personaje ===

Te mirás en el espejo del baño. El vidrio tiene una rajadura en la esquina.
Treinta y algo. Ojeras que ya son parte de tu cara.

# ¿QUIÉN SOS?

* [Hombre — El mundo te deja pasar sin preguntar.]
    ~ genero = "varon"
    La barba de dos días. Las manos ásperas.
    Caminar de noche por el barrio sin pensarlo dos veces. El privilegio de la invisibilidad.
    -> creacion_cuerpo

* [Mujer — El mundo te mide antes de dejarte pasar.]
    ~ genero = "mujer"
    El pelo que nunca queda como querés. La cara sin maquillaje.
    El cálculo automático de riesgos antes de salir. La alerta que no se apaga.
    -> creacion_cuerpo

* [No binario — El mundo no sabe dónde ponerte.]
    ~ genero = "no_binario"
    Ni esto ni lo otro. El mundo te pone en cajas. Vos las rompés.
    Pero romperse cansa. Y afuera siguen queriendo etiquetarte.
    -> creacion_cuerpo

=== creacion_cuerpo ===

Y debajo de la ropa, la piel.
Esa frontera con el mundo. Lo que te abre puertas o te las cierra.

# ¿QUÉ VE EL MUNDO CUANDO TE MIRA?

* [Piel clara, herencia europea — Nadie te para en la calle por el color.]
    ~ raza = "blanco"
    No pensás en eso. Nunca tuviste que pensarlo.
    -> transicion_barrio

* [Piel morena, mezcla de todo — Lo suficiente para pasar. Casi siempre.]
    ~ raza = "mestizo"
    Como la mayoría. Ni una cosa ni la otra.
    -> transicion_barrio

* [Piel oscura, herencia que pesa — La policía te para más seguido. "Rutina", dicen.]
    ~ raza = "afro"
    A veces te miran diferente. Más en algunos barrios.
    No hace falta que te expliquen. Ya sabés.
    -> transicion_barrio

* [Rasgos de otra tierra, otro origen — Invisible o exótico, según el día.]
    ~ raza = "indigena"
    Tus abuelos vinieron del norte. O del oeste.
    Acá sos minoría. Pero sabés de dónde venís. Y eso es algo.
    -> transicion_barrio

=== transicion_barrio ===

Laburás. Pagás las cuentas. Más o menos.
Vivís en el barrio. Conocés a la gente de vista, de cruce, de historia compartida.

Pero hay cosas que solo vos sabés. Cosas que cargás. Cosas que no se ven.

* [...] -> elegir_perdida

=== elegir_perdida ===

# ¿QUÉ PERDISTE?

* [Perdí a alguien — Un plato que nadie más usa en la alacena.]
    ~ perdida = "familiar"
    La última vez que lo vi estaba en la cama del hospital, flaco como nunca.
    Me apretó la mano. No dijo nada. No hacía falta.
    Me dejó cosas: una caja de fotos, una deuda con el banco, la costumbre de mirar el teléfono a las ocho.
    -> elegir_atadura

* [Perdí una relación — Una taza de café que sobra todas las mañanas.]
    ~ perdida = "relacion"
    Se fue un martes. O un jueves. Ya no importa el día.
    Dejó un cepillo de dientes que tardé meses en tirar.
    A veces la veo en el almacén de la vuelta. Nos saludamos como desconocidos.
    El barrio quedó partido al medio.
    -> elegir_atadura

* [Perdí un futuro — Un diploma que junta polvo arriba del ropero.]
    ~ perdida = "futuro"
    Me acuerdo del día que rendí el último examen.
    Pensé: "Ahora empieza todo". Todavía estoy esperando.
    A veces agarro el cartón, le saco el polvo. Lo vuelvo a guardar.
    El pibe que lo consiguió ya no existe.
    -> elegir_atadura

* [Perdí algo que no sé nombrar — Una foto donde no reconozco mi propia sonrisa.]
    ~ perdida = "vacio"
    No sé cuándo pasó. No hubo un día, un momento.
    Solo a veces me miro al espejo y veo a alguien cansado.
    Algo se fue. O capaz nunca estuvo.
    Sigo buscando.
    -> elegir_atadura

=== elegir_atadura ===

# ¿POR QUÉ TE QUEDÁS?

* [Por responsabilidad — Una alarma en el celular que dice "llamar a mamá".]
    ~ atadura = "responsabilidad"
    Suena todos los días a las ocho. A veces la ignoro. Después me siento mal.
    Vive sola desde que murió mi viejo. No me pide nada. Pero sé que espera.
    Hay días que pienso en irme lejos. Después pienso en ella sola en esa casa.
    -> elegir_posicion

* [Por el barrio — La marca de mi altura en el marco de la puerta.]
    ~ atadura = "barrio"
    Crecí en estas calles. Conozco cada baldosa floja, cada perro que ladra.
    Mi viejo pintó esta casa. Mi abuelo plantó el árbol de la vereda.
    Irme sería como arrancarme un pedazo. No sé cuál.
    -> elegir_posicion

* [Por inercia — Una valija que armé hace dos años y nunca abrí.]
    ~ atadura = "inercia"
    Está debajo de la cama, juntando polvo.
    A veces la miro. Pienso: mañana. Pasado.
    Pero mañana llega y yo sigo acá, mirando la valija.
    -> elegir_posicion

* [Por algo que no sé explicar — El olor a pan de la panadería de la esquina.]
    ~ atadura = "algo"
    El saludo del almacenero. La vecina que siempre tiene yerba de más.
    Pequeñas cosas. Casi nada. Pero algo.
    -> elegir_posicion

=== elegir_posicion ===

# ¿Y MAÑANA?

* [Mañana va a ser igual — El mismo camino al laburo, las mismas baldosas flojas.]
    ~ posicion = "ajeno"
    No es queja. Es lo que hay.
    Algunos le dicen resignación. Yo le digo realismo.
    -> asignar_vinculo

* [Algo puede cambiar — Una planta que riego todas las mañanas.]
    ~ posicion = "esperanzado"
    La compré cuando me mudé. Casi se me muere dos veces.
    Pero ahí sigue. Cada tanto le sale una hoja nueva.
    Pequeñas cosas. Capaz que con todo es así.
    -> asignar_vinculo

* [Ya vi esta película — Un mensaje de grupo que tengo silenciado.]
    ~ posicion = "quemado"
    Antes opinaba. Discutía. Me calentaba.
    Ahora leo por arriba y sigo de largo.
    Sé cómo termina.
    -> asignar_vinculo

* [No sé qué creer — La gotera del techo que nunca arreglo.]
    ~ posicion = "ambiguo"
    Pongo el balde. Se llena. Lo vacío.
    Podría arreglarlo. Podría no arreglarlo.
    A veces me pregunto si importa.
    -> asignar_vinculo

=== asignar_vinculo ===

# HAY ALGUIEN.

En el barrio hay gente. Pero un momento te vuelve siempre.

* [Sofía, la de la olla popular — Un tupper de guiso que apareció en tu puerta.]
    ~ vinculo = "sofia"
    "Sobró", te dijo. Mentira.
    Sus pibes iban a la misma escuela. O iban.
    Nunca hablaron de ese tupper.
    Pero desde entonces se miran distinto.
    -> confirmar_inicio

* [Elena, la veterana — Un banco de plaza. "Mirá qué grande estás", te dijo.]
    ~ vinculo = "elena"
    Conoció a tu familia. O vos la ayudaste una vez.
    Te mira como esperando algo.
    No sabés si podés dárselo.
    -> confirmar_inicio

* [Diego, el que llegó hace poco — Un tipo con mochila, mirando un papel con una dirección.]
    ~ vinculo = "diego"
    Le señalaste el camino. Te buscó después.
    Preguntó cosas. Confió en vos.
    No sabés si merecés esa confianza.
    -> confirmar_inicio

* [Marcos, el que se alejó — Un portón cerrado. Sabés quién vive ahí.]
    ~ vinculo = "marcos"
    Antes eran cercanos. Antes de que él se quemara.
    Ahora se cruzan y es raro.
    Hay algo ahí que ninguno termina de cerrar.
    -> confirmar_inicio

* [Ixchel, la que no habla de más — Una mujer en la cocina de la olla. Trabaja rápido, seria.]
    ~ vinculo = "ixchel"
    Todavía no sabés su nombre.
    Pero hay algo en cómo trabaja que te llamó la atención.
    Eficiente. Sin sonrisas de compromiso.
    Alguien te contó que tuvo que irse de Guatemala. Una minera, dijeron.
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

Tu historia está con {vinculo == "sofia": Sofía}{vinculo == "elena": Elena}{vinculo == "diego": Diego}{vinculo == "marcos": Marcos}{vinculo == "ixchel": Ixchel}.

La semana empieza.
Todavía no sabés lo que viene.

* [Empezar la semana] -> lunes_amanecer
