// LUCÍA - La Sindicalista Pragmática
// ============================================
// Edad: 29 | Rol: Delegada sindical, compañera de trabajo
// Arquetipo: La Conciencia de Clase / La Casandra
// 
// Variables de estado:
// - lucia_relacion: nivel de relación (0-5)
// - lucia_consejo_sindical: dio consejo sobre qué hacer
// - lucia_historia_conocida: contó por qué dejó la carrera
// - lucia_sigue_luchando: sigue activa después del domingo

// ============================================
// ESCENAS PRE-DESPIDO (LUNES/MARTES)
// ============================================

=== lucia_escena_mate ===
// Escena Lunes: Oficina, mate, primera advertencia.

Lucía se acerca con el termo bajo el brazo.
Te deja el mate en el escritorio sin preguntar.

"Tomá. Calentate las manos."

Mira alrededor. Baja la voz.

"Están llamando gente al cuarto piso. De a uno."

* [Preguntar qué sabe.]
    "¿Qué sabés, Lucía?"
    
    Ella se encoge de hombros.
    "Lo de siempre. Números que no cierran en la planilla de algún gerente que nunca pisó este lugar."
    
    Te mira fijo.
    
    "Si te llaman, no firmes nada sin leer. Y pedí copia."
    
    ~ lucia_relacion += 1
    ~ aumentar_inercia(1) // La realidad duele
    ->->

* [Hacerte el desentendido.]
    "Seguro son reuniones de rutina."
    
    Lucía se ríe. Una risa seca.
    "Sí, claro. Rutina de limpieza."
    
    Agarra el mate.
    "Suerte con la rutina."
    
    ->->

=== lucia_almuerzo_oficina ===
// Escena Martes: Almuerzo tenso

Lucía se sienta a tu lado en el comedor.
Abre un tupper. Arroz con verduras.

"¿Viste la cara del jefe hoy?"

* [Preguntar qué vio.]
    "¿Qué pasa?"

    Lucía baja la voz.
    "Están preparando la lista.
    Los que sobran."

    "¿Y vos?"

    "Yo ya me peleé con todos.
    Si me echan, me echan peleando."

    ~ lucia_relacion += 1
    ->->

* [Cambiar de tema.]
    "Prefiero no pensar en eso."

    Lucía asiente.
    "Entiendo.
    Pero pensar es lo único que nos queda."

    ->->

=== lucia_no_firmes_sin_leer ===
// Escena Martes: Lucía te intercepta antes de irte

Estás guardando las cosas.
Lucía aparece con un papel.

"Tomá. Leé esto."

Es una lista.
Tus derechos si te despiden.
Liquidación. Vacaciones. Aguinaldo proporcional.

"No firmes nada que diga 'renuncia'. Nunca."

* [Agradecer.]
    "Gracias, Lucía."

    "No me agradezcas. Cuidate."

    Se va rápido.
    Como si tuviera miedo de que la vean.

    ~ lucia_relacion += 1
    ->->

* [Preguntar por qué tanto cuidado.]
    "¿Por qué me das esto?"

    Lucía te mira.

    "Porque ya vi cómo funciona.
    Primero te asustan.
    Después te apuran.
    Y cuando firmás, ya no podés reclamar nada."

    # PAUSA

    "No seas boludo."

    ~ lucia_relacion += 1
    ->->

// ============================================
// HISTORIA PERSONAL - POR QUÉ DEJÓ LA CARRERA
// ============================================

=== lucia_historia_carrera ===
// Escena cualquier día: Lucía cuenta por qué dejó Relaciones Laborales
// Trigger: lucia_relacion >= 2

{lucia_relacion < 2:
    ->->
}

Lucía está fumando afuera.
Es la primera vez que la ves fumar.

"¿Puedo?"

Se encoge de hombros.

Silencio largo.

* [Preguntar por la carrera.]
    "Nunca terminaste Relaciones Laborales, ¿no?"

    Lucía tira el pucho.

    "No."

    # PAUSA

    "Llegué hasta tercero. Después tuve que elegir: o laburaba o estudiaba."

    * * [Escuchar.]
        -> lucia_historia_desarrollo

    * * [Preguntar si se arrepiente.]
        "¿Te arrepentís?"

        "A veces."

        -> lucia_historia_desarrollo

* [Quedarte en silencio.]
    Se fuman el cigarrillo juntos.
    A veces el silencio es suficiente.
    ->->

=== lucia_historia_desarrollo ===

"Mi vieja se enfermó. Lupus.
No podía laburar.
Alguien tenía que bancar la casa."

# PAUSA

"Dejé para 'después'.
Pero después nunca llega."

Prende otro cigarrillo.

"Lo peor no fue dejar.
Fue darme cuenta de que todo lo que estudié...
no sirve para nada si no tenés poder."

* ["¿Cómo que no sirve?"]
    "Sabés todas las leyes.
    Todos los artículos.
    Pero si del otro lado hay un estudio de abogados con plata infinita...
    vos tenés razón y ellos tienen tiempo."

    # PAUSA

    "Y el tiempo siempre gana."

    ~ lucia_historia_conocida = true
    ~ lucia_relacion += 1
    ->->

* [Asentir.]
    "Sí. Te entiendo."

    Lucía te mira.
    Por primera vez, con algo parecido a alivio.

    "Pocos entienden."

    ~ lucia_historia_conocida = true
    ~ lucia_relacion += 1
    ->->

// ============================================
// CONFLICTO CON EL "MACHIRULAJE" SINDICAL
// ============================================

=== lucia_machirulaje_reunion ===
// Escena: Lucía cuenta un conflicto reciente en el sindicato
// Puede ocurrir cualquier día si hay buena relación

{lucia_relacion < 2:
    ->->
}

Lucía llega enojada.
Más que lo normal.

"¿Qué pasó?"

"Reunión en el sindicato."

Tira la cartera en la silla.

"Hablé veinte minutos sobre el tema de los unipersonales.
Los contratos basura. Los monotributistas.
Todo el quilombo que se viene."

* [Preguntar qué dijeron.]
    "¿Y?"

    Lucía se ríe. Pero no es risa.

    "Después de que terminé, González —que estuvo mirando el celular todo el rato— dice: 'Bueno, pero eso ya lo veníamos pensando, ¿no? Capaz que el compañero Martínez puede resumir lo importante.'"

    # PAUSA

    "Martínez repitió exactamente lo que yo dije. Punto por punto. Y todos aplaudieron."

    ~ lucia_relacion += 1
    -> lucia_machirulaje_cierre

* [Esperar.]
    -> lucia_machirulaje_cierre

=== lucia_machirulaje_cierre ===

"Es siempre lo mismo.
Podés tener razón, datos, propuestas.
Pero si no tenés pija, no existís."

# PAUSA

"Por eso ya no voy a ciertas reuniones.
Para escuchar a tres tipos explicándome lo que yo misma viví mientras se sirven otro vino...
me quedo acá ayudando a Sofía."

* ["¿Y no te da bronca?"]
    "Bronca tengo de sobra.
    Pero la bronca sola no cambia nada."

    # PAUSA

    "Uso la energía donde sirve.
    No donde me la roban."

    ->->

* [Asentir en silencio.]
    No hay nada que agregar.
    Ella lo sabe. Vos lo sabés.

    ->->

=== lucia_machirulaje_en_vivo ===
// Escena: Ves el machirulaje en acción (asamblea o reunión)
// Trigger: participe_asamblea o lucia_en_asamblea

Están en la reunión.
Lucía levanta la mano.

"Propongo que armemos un fondo de emergencia rotativo.
Lo administramos entre todos.
Sin intermediarios."

Silencio.

Un tipo de barba —Ramiro, creo— carraspea.

"Está buena la idea. Pero capaz que primero habría que ver los números con más calma. ¿Querés que lo presente yo en la próxima?"

Lucía cierra los ojos un segundo.
Como contando hasta diez.

* [Intervenir.]
    "La compañera acaba de presentar la idea. Me parece que ella puede seguir explicándola."

    Ramiro te mira.
    Lucía también.

    "Gracias", dice ella.

    Y sigue hablando.
    Esta vez, escuchan.

    ~ lucia_relacion += 2
    ~ disminuir_inercia(1)
    ->->

* [No decir nada.]
    Ramiro sigue hablando.
    La idea de Lucía se convierte en la idea de Ramiro.

    Ella te mira.
    No con reproche.
    Con algo peor: confirmación.

    ~ aumentar_inercia(1)
    ->->

// ============================================
// ESCENAS POST-DESPIDO
// ============================================

=== lucia_consejo_despido ===
// Escena Miércoles: Si la llamás después del despido.

"¿Te dieron la liquidación final o un papel con promesas?"

* ["Me dijeron que soy unipersonal."]
    Del otro lado del teléfono, Lucía bufa.

    "Hijos de puta. El fraude laboral de manual."

    "Escuchame. No te vayas a casa a llorar. Andá al ministerio. Hacé la denuncia. Aunque te digan que no sirve."

    * * [Decirle que vas a ir.]
        "Voy a ir."
        "Bien. Eso es lo que no quieren. Que molestes."
        ~ lucia_consejo_sindical = true
        ~ disminuir_inercia(1) // Acción concreta
        ->->

    * * [Decirle que no tenés fuerza.]
        "No sé si puedo ahora, Lucía."
        "Te entiendo. Pero la bronca usala para moverte, no para comerte la cabeza."
        ->->
- ->->

=== lucia_post_despido ===
// Escena Jueves: Si la buscás después del despido

Lucía atiende el teléfono rápido.

"Me enteré. Hijos de puta."

No te deja hablar.

"Escuchame. No te quedes en casa.
Mañana a las 9 hay una reunión en el sindicato.
No por vos. Por todos los que vienen después."

* [Decir que vas a ir.]
    "Voy."

    "Bien. Y traete papeles.
    Recibos, mails, lo que tengas."

    ~ lucia_consejo_sindical = true
    ~ disminuir_inercia(1)
    ~ activar_no_es_individual()
    ->->

* [Decir que no tenés fuerzas.]
    "No sé si puedo, Lucía."

    Silencio.

    "Nadie puede solo.
    Por eso nos juntamos."

    Corta.

    ~ aumentar_inercia(1)
    ->->

=== lucia_ayuda_reclamo ===
// Escena Jueves/Viernes: Lucía te ayuda con el reclamo aunque no sirva de mucho

{lucia_consejo_sindical:
    Lucía te espera en la puerta del ministerio.
    Tiene una carpeta.

    "Traje los formularios. Ya los llené con lo que sabía."

    * [Agradecer.]
        "No tenías que venir."

        "Sí tenía. Esto no es caridad. Es solidaridad."

        -> lucia_reclamo_adentro

    * [Preguntarle si sirve de algo.]
        "¿Esto va a servir?"

        Lucía suspira.

        "Honestamente? Capaz que no.
        El MTSS está desbordado. Los juicios tardan años.
        Y vos sos unipersonal, así que ni siquiera entrás en la estadística de despidos."

        # PAUSA

        "Pero hay que hacerlo igual."

        -> lucia_reclamo_adentro
- else:
    ->->
}

=== lucia_reclamo_adentro ===

Adentro hay cola.
Mucha gente.
Todos con carpetas.

Lucía te mira.

"¿Ves? No sos el único.
Esto es un sistema, no un accidente."

Esperan juntos.
Tres horas.

Al final, un funcionario cansado toma los papeles.

"Van a contactarlo."

No suena convincente.

Afuera, Lucía prende un cigarrillo.

"Bueno. Hicimos lo que se podía."

* ["¿Y ahora qué?"]
    "Ahora esperás. Y mientras esperás, seguís moviéndote.
    La olla. El barrio. Los que están peor."

    # PAUSA

    "El Estado no te va a salvar. Pero vos podés ayudar a otros."

    ~ disminuir_inercia(1)
    ~ activar_no_es_individual()
    ->->

* [Quedarte en silencio.]
    Fuman juntos.
    No hay nada que agregar.

    ~ lucia_relacion += 1
    ->->

// ============================================
// FRAGMENTO NOCTURNO
// ============================================

=== fragmento_lucia_numeros ===
// Lucía hace números de noche - no sus cuentas, sino las de la empresa

Lucía tiene la calculadora en la mano.
Papeles por todos lados.

No son sus cuentas.
Son las de ellos.

Suma lo que la empresa se ahorró
echándolos a todos.

Tres sueldos completos: ahorro.
Aguinaldo proporcional: ahorro.
Vacaciones no gozadas: ahorro.
Aportes patronales: ahorro.

"Un millón doscientos."

Por cabeza.

Ocho despedidos esta semana.

"Nueve millones seiscientos."

# PAUSA

Piensa en el gerente.
El que nunca pisó la oficina.
El que cobra bonus por "eficiencia".

Esto es su eficiencia.
Nueve millones seiscientos en carne humana.

Apaga la calculadora.
Se sirve un vaso de agua.

Mañana hay que pelear.
Con los números en la mano.
Porque los números son el único idioma que entienden.

->->

=== fragmento_lucia_insomnio ===
// Lucía no puede dormir

Son las tres de la mañana.
Lucía mira el techo.

Piensa en la reunión del sindicato.
En González mirando el celular.
En Martínez repitiendo sus palabras.
En los aplausos.

Piensa en su vieja.
En las pastillas que cuestan más cada mes.
En el alquiler.
En las facturas.

Piensa en la olla.
En Sofía.
En Tiago.
En toda esa gente que no tiene sindicato.

Se levanta.
Prende la computadora.
Empieza a escribir un documento:

"Propuesta para incluir trabajadores informales
en la agenda del PIT-CNT"

Nadie lo va a leer.
Pero lo escribe igual.

Porque si no lo escribe,
no existe.

->->

// ============================================
// LUCÍA EN LA OLLA Y ASAMBLEA
// ============================================

=== lucia_en_olla ===
// Escena Viernes/Sábado: Lucía aparece en la olla

Lucía entra a la olla.
Sofía la abraza.

"¿Qué hacés acá?"

"Vine a dar una mano.
El sindicato puede esperar.
Esto no."

Se arremanga.
Agarra un cuchillo.

"¿Dónde están las papas?"

~ lucia_relacion += 1
~ subir_conexion(1)

->->

=== lucia_en_asamblea ===
// Escena Sábado: Lucía aparece en la asamblea del barrio

{lucia_relacion >= 2 && participe_asamblea:
    Lucía entra a la asamblea.
    Algunos la conocen del sindicato.

    "¿Qué hacés acá?", pregunta Sofía.

    "Vine a escuchar. Y a sumar.
    El sindicato tiene recursos.
    Ustedes tienen organización."

    Se sienta.
    Toma nota.

    "Juntos podemos más."

    ~ lucia_relacion += 1
    ~ subir_llama(1)
    ->->
- else:
    ->->
}

=== lucia_cierre_domingo ===
// Escena Domingo: Lucía reflexiona sobre la semana

{lucia_consejo_sindical:
    Lucía te llama el domingo.

    "¿Fuiste al ministerio?"

    * [Sí, fui.]
        "Bien. No va a cambiar nada mañana.
        Pero es un ladrillo. Uno de muchos."

        Silencio.

        "Seguimos el lunes. Hay asamblea en el sindicato."

        ~ lucia_sigue_luchando = true
        ~ subir_conexion(1)
        ~ activar_no_es_individual()
        ->->

    * [No pude.]
        "Entiendo. Pero no te quedes.
        Solo no se puede."

        Corta.

        ~ aumentar_inercia(1)
        ->->
- else:
    ->->
}

// ============================================
// EXPLICACIÓN LEGAL (UNIPERSONAL)
// ============================================

=== lucia_explica_unipersonal ===
// Lucía explica por qué los canales formales no funcionan para unipersonales

"¿Y el sindicato? ¿No pueden hacer algo?"

Lucía suspira.

"Mirá, yo quisiera. Pero vos no sos empleado. Sos 'prestador de servicios'."

* ["Es lo mismo."]
    "Para vos sí. Para la ley, no."
    -> lucia_explica_legal
* ["¿Y eso qué significa?"]
    -> lucia_explica_legal

=== lucia_explica_legal ===

"Significa que no tenés convenio colectivo. No tenés despido. No tenés BPS patronal. No tenés nada."

# PAUSA

"Facturás, cobrás, y cuando no les servís más... chau. Sin indemnización, sin seguro de paro, sin nada."

* ["Pero yo laburaba ahí todos los días..."]
    "Sí. Como empleado. Pero en los papeles sos un 'proveedor'. Como si vendieras tornillos."
    -> lucia_explica_sistema
* ["¿Y el MTSS?"]
    "Podés hacer la denuncia. Van a decir que es 'relación de dependencia encubierta'. Capaz ganás en tres años. Capaz."
    -> lucia_explica_sistema

=== lucia_explica_sistema ===

Lucía toma mate.

"El sistema está armado así. Las empresas tercerizan, contratan unipersonales, y se ahorran el treinta por ciento de aportes. Vos ponés el cuerpo, ellos ponen las reglas."

# PAUSA

"Nosotros peleamos desde adentro, pero los que están afuera... no tenemos cómo cubrirlos."

* ["Entonces estoy solo."]
    "No solo. Pero sí... desprotegido."
    -> lucia_cierre_institucional
* ["¿Y qué hago?"]
    -> lucia_cierre_institucional

=== lucia_cierre_institucional ===

"Mirá, yo no te voy a mentir. El Estado no te va a salvar. El sindicato tampoco, porque legalmente no sos de los nuestros."

# PAUSA

"Pero hay otras redes. La olla. Los vecinos. Eso no tiene convenio colectivo, pero existe."

~ lucia_consejo_sindical = true

"Es lo que hay."

->->
