// ============================================
// UBICACION: EL BARRIO
// Escenas generales del barrio
// ============================================

// --- CAMINAR POR EL BARRIO ---

=== barrio_caminar ===
// Tunnel para caminar por el barrio
// Llamar: -> barrio_caminar ->

# EL BARRIO

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

~ ultima_tirada = d6()

{ultima_tirada == 1:
    -> barrio_encuentro_vecino_molesto ->
}
{ultima_tirada == 2:
    -> barrio_encuentro_perro ->
}
{ultima_tirada == 6:
    -> barrio_encuentro_positivo ->
}

El barrio sigue.
Vos seguís.

->->

=== barrio_encuentro_vecino_molesto ===

Un vecino te para.

"Che, ¿vos no viste quién me raya el auto?"

"No, ni idea."

"Siempre lo mismo en este barrio de mierda."

Se va enojado.

->->

=== barrio_encuentro_perro ===

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

->->

=== barrio_encuentro_positivo ===

Una vecina te saluda.
"¡Buen día!"

"Buen día."

{d6() >= 4:
    "¿Todo bien?"
    "Sí, ahí andamos."
    "Bueno. Cuidate."

    Una conversación breve.
    Pero humana.
    ~ subir_conexion(1)
- else:
    Sigue caminando.
    Pero te saludó.
    Eso está bien.
}

->->

// --- LA PLAZA ---

=== barrio_plaza ===
// Tunnel para ir a la plaza
// Llamar: -> barrio_plaza ->

# LA PLAZA

La plaza del barrio.

Un par de bancos, algunos árboles, los juegos oxidados.

* [...]
-

Pibes jugando a la pelota.
Viejos sentados.
Madres con cochecitos.

~ veces_en_plaza += 1

{veces_en_plaza == 1:
    No venías hace rato.
}

{not tiene_laburo:
    Antes solo venías los fines de semana.
    Ahora tenés todo el tiempo del mundo.
}

* [Sentarte en un banco] # EFECTO:dignidad+ -> barrio_plaza_banco ->
    ->->
* [Caminar por la plaza] -> barrio_plaza_caminar ->
    ->->
* [Mirar a los pibes jugar] # EFECTO:conexion? -> barrio_plaza_pibes ->
    ->->
* [Irte] ->->

=== barrio_plaza_banco ===

Te sentás en un banco.

El sol.
El ruido de los pibes.
El viento.

* [...]
-

Por un rato, no pensás en nada.

{d6() >= 5:
    Alguien se sienta al lado tuyo.
    Un viejo.

    "Linda tarde."

    "Sí."

    Se quedan en silencio.
    No hace falta más.

    ~ subir_conexion(1)
}

->->

=== barrio_plaza_caminar ===

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

->->

=== barrio_plaza_pibes ===

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

->->

// --- EL KIOSCO ---

=== barrio_kiosco ===
// Tunnel para ir al kiosco
// Llamar: -> barrio_kiosco ->

# EL KIOSCO

El kiosco de la esquina.

Esas viejas, caramelos, cigarrillos.

* [...]
-

Revistas que nadie compra.
Un cartel de Coca-Cola de hace 20 años.

{not conozco_al_kiosquero:
    El kiosquero es un tipo de unos 60.
    Bigote.
    Cara de pocos amigos.
    ~ conozco_al_kiosquero = true
- else:
    El kiosquero está ahí, como siempre.
}

"¿Qué va a ser?"

* [Comprar algo] -> barrio_kiosco_comprar ->
    ->->
* [Solo saludar]
    "Nada, pasaba nomás. Buen día."
    Te mira raro pero no dice nada.
    ->->

=== barrio_kiosco_comprar ===

~ ultima_tirada = d6()

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

    * ["Sí, todo bien."]
        "Sí, todo bien."
        "Bueno."
        ->->
    * ["Ahí andamos."]
        "Ahí andamos. Perdí el laburo."
        "Uh. Está jodido."
        "Está jodido."
        "Bueno. Suerte."
        ->->
- else:
    ->->
}

// --- EL TIPO DEL BANCO ---

=== barrio_tipo_del_banco ===
// Tunnel para encontrar al tipo que duerme en el banco
// Llamar: -> barrio_tipo_del_banco ->

# EL BANCO DE LA ESQUINA

El tipo que duerme en el banco.

Siempre está ahí.
Con sus bolsas, sus cartones, su mundo.

* [...]
-

{not hable_con_el_del_banco:
    Nunca le hablaste.
    Nadie le habla.
    Pasa la gente y no lo mira.
}

* [...]
-

{not tiene_laburo:
    Ahora lo mirás distinto.
    ¿Cuántos pasos hay entre vos y él?
    Unipersonal. Sin indemnización. Sin seguro.
    Muy pocos pasos.
}

* [Acercarte] -> barrio_banco_acercarse
* [Dejarlo tranquilo]
    Lo dejás tranquilo.
    Él no pidió que lo molesten.
    ->->

=== barrio_banco_acercarse ===

Te acercás.

Está despierto.
Te mira.

* [...]
-

Ojos cansados.
Barba de días.
Ropa sucia pero no tanto.

{not hable_con_el_del_banco:
    "¿Qué querés?"

    No suena agresivo.
    Solo cansado.

    * [Preguntarle si necesita algo]
        "¿Necesitás algo?"

        Te mira.

        "¿Y vos qué me vas a dar?"

        No sabés qué decir.

        "Un café, si querés."

        "Bueno."

        ~ hable_con_el_del_banco = true
        ~ nombre_del_banco = "Roberto"

        -> barrio_banco_cafe

    * [Sentarte cerca]
        Te sentás en el otro extremo del banco.

        Se quedan en silencio.

        "Me llamo Roberto."

        "Yo soy {vinculo == "sofia": Martín|Diego}."

        "Bueno."

        ~ hable_con_el_del_banco = true
        ~ nombre_del_banco = "Roberto"

        Silencio.
        No hace falta más.

        ->->

    * [Irte]
        "Nada. Perdón."
        "Está bien."
        ->->

- else:
    "Ah, vos otra vez."

    {nombre_del_banco != "": "¿Cómo andás, {nombre_del_banco}?"}

    "Acá. Siempre acá."

    * [Ofrecerle un café] -> barrio_banco_cafe
    * [Sentarte un rato] -> barrio_banco_charla
    * [Irte]
        "Bueno. Nos vemos."
        "Chau."
        ->->
}

=== barrio_banco_cafe ===

Le traés un café del kiosco.

"Gracias."

Toma.

* [...]
-

{d6() >= 4:
    "Yo laburaba, ¿sabés? En una fábrica. Hace años."
    No preguntaste.
    Pero te cuenta.
    "Después cerró. Y bueno. Una cosa lleva a la otra."
    Toma el café.
    "Pero no estoy mal. Tengo mis cosas. Conozco gente. Vivo."
    ~ subir_conexion(1)
}

->->

=== barrio_banco_charla ===

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

    ~ subir_conexion(1)
}

->->

// --- ENCUENTROS ALEATORIOS ---

=== barrio_encuentro_aleatorio ===
// Tunnel para encuentros random en el barrio
// Llamar: -> barrio_encuentro_aleatorio ->

~ ultima_tirada = d6()

{ultima_tirada == 1:
    -> barrio_encuentro_sofia ->
}
{ultima_tirada == 2:
    -> barrio_encuentro_musica ->
}
{ultima_tirada == 3:
    -> barrio_encuentro_discusion ->
}
{ultima_tirada == 4:
    -> barrio_encuentro_nenes ->
}
{ultima_tirada == 5:
    -> barrio_encuentro_vieja ->
}
{ultima_tirada == 6:
    -> ixchel_encuentro_casual ->
}

->->

=== barrio_encuentro_sofia ===

{vinculo == "sofia":
    Sofía viene por la vereda con los pibes.

    "¡Ey! ¿Qué hacés por acá?"

    "Nada. Caminando."

    "¿Todo bien?"

    * ["Sí, todo bien."] # STAT:conexion
        "Sí, todo bien."
        "Bueno. Cualquier cosa..."
        "Sí, ya sé."
        ~ subir_conexion(1)
        ->->
    * ["Más o menos."] # STAT:conexion
        "Más o menos."
        "Uh. ¿Querés hablar?"
        "Después. Ahora no."
        "Bueno. Sabés dónde estoy."
        ~ subir_conexion(1)
        ->->
- else:
    Una vecina pasa.
    Te saluda.
    "Buen día."
    "Buen día."
    ->->
}

=== barrio_encuentro_musica ===

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

->->

=== barrio_encuentro_discusion ===

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
    ~ bajar_salud_mental(1)
}

->->

=== barrio_encuentro_nenes ===

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

->->

=== barrio_encuentro_vieja ===

Una vieja camina despacio.
Con bolsas del super.
Le cuesta.

* [Ayudarla] # STAT:conexion # EFECTO:conexion+
    "¿La ayudo?"
    "Ay, sí. Gracias, m'hijo."

    Le llevás las bolsas hasta la esquina.

    "Dios te bendiga."

    ~ subir_conexion(1)
    ->->
* [Seguir] # EFECTO:conexion-
    Seguís caminando.
    Ella sigue caminando.
    Cada uno con lo suyo.
    ->->

=== barrio_encuentro_silencio ===

Por un momento, todo está en silencio.

No hay gente.
No hay autos.
No hay nada.

* [...]
-

Solo vos y el barrio.

{not tiene_laburo:
    ¿Esto es la vida ahora?
    ¿Caminar por el barrio sin rumbo?
}

* [...]
-

El momento pasa.
Un auto pasa.
Todo sigue.

->->

// --- BARRIO DE NOCHE ---

=== barrio_noche ===
// Tunnel para el barrio de noche
// Llamar: -> barrio_noche ->

# EL BARRIO DE NOCHE

El barrio de noche.

Pocas luces.
Perros ladrando.

* [...]
-

La televisión prendida en las casas.

* [...]
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

->->

// --- BARRIO DOMINGO ---

=== barrio_domingo ===
// Tunnel para el barrio en domingo
// Llamar: -> barrio_domingo ->

# EL BARRIO EN DOMINGO

Domingo.
El barrio más tranquilo que nunca.

* [...]
-

Los negocios cerrados.
Poca gente en la calle.

* [...]
-

Alguien pasea un perro.
Un viejo toma café en un vaso térmico en la vereda.

{d6() >= 5:
    El olor a asado viene de algún lado.
    Domingos en familia.
    Vos no tenés eso hoy.
}

->->

// --- GRUPO DE LA OLLA ---

=== barrio_grupo_olla ===
// Tunnel para encontrar al grupo de la olla en la calle
// Llamar: -> barrio_grupo_olla ->

El grupo de la olla.
Sofía, Elena, otros.

Hablando en la vereda.
Tomando café.

* [...]
-

"¿Todo bien?", te preguntan.

Te quedás un rato.
Escuchando.
Siendo parte.

~ subir_conexion(1)

->->

// --- CAMINAR SIN RUMBO ---

=== barrio_caminar_sin_rumbo ===
// Tunnel para caminar sin destino
// Llamar: -> barrio_caminar_sin_rumbo ->

Caminás sin rumbo.

No hay a donde ir.
No hay a donde volver.

* [...]
-

El barrio te conoce.
Pero hoy te siente distinto.

* [...]
-

{not tiene_laburo:
    Sin laburo, las calles son diferentes.
    Antes eran camino al trabajo.
    Ahora son solo calles.
}

* [...]
-

Las horas pasan.
Caminando.
Pensando.

->->

// --- BARRIO SABADO ---

=== barrio_sabado ===
// Tunnel para el ambiente del sábado
// Llamar: -> barrio_sabado ->

# SABADO EN EL BARRIO

Sábado.
El barrio más relajado.

* [...]
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

->->

// --- CAMINAR DE TARDE ---

=== barrio_caminar_tarde ===
// Tunnel para caminar de tarde
// Llamar: -> barrio_caminar_tarde ->

La tarde en el barrio.

El sol bajando.
Las sombras largas.

* [...]
-

Gente volviendo de trabajar.
Gente saliendo a caminar.

{d6() >= 5:
    Un vecino te saluda.
    "¿Qué tal?"
    "Ahí andamos."
    El intercambio de siempre.
}

->->

// --- CAMINAR DE MANANA ---

=== barrio_caminar_manana ===
// Tunnel para caminar de mañana
// Llamar: -> barrio_caminar_manana ->

La mañana en el barrio.

El sol recién saliendo.
El rocío en los autos.

* [...]
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

->->
