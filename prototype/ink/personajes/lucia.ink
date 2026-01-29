// LUCÍA - La Sindicalista Pragmática
// ============================================

=== lucia_escena_mate ===
// Escena Lunes/Martes: Oficina, mate, advertencia.
// Lucía te pasa el mate y te tira la posta.

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

=== lucia_consejo_despido ===
// Escena Miércoles: Si la llamás después del despido.

"¿Te dieron la liquidación final o un papel con promesas?"

* ["Me dijeron que soy unipersonal."]
    Del otro lado del teléfono, Lucía bufa.

    "Hijos de puta. El fraude laboral de manual."

    "Escuchame. No te vayas a casa a llorar. Andá al ministerio. Hacé la denuncia. Aunque te digan que no sirve."

    * [Decirle que vas a ir.]
        "Voy a ir."
        "Bien. Eso es lo que no quieren. Que molestes."
        ~ lucia_consejo_sindical = true
        ~ disminuir_inercia(1) // Acción concreta
        ->->

    * [Decirle que no tenés fuerza.]
        "No sé si puedo ahora, Lucía."
        "Te entiendo. Pero la bronca usala para moverte, no para comerte la cabeza."
        ->->
- ->->

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

=== fragmento_lucia_numeros ===
// Lucía hace números de noche

Lucía tiene la calculadora en la mano.
Papeles por todos lados.

Suma lo que la empresa se ahorró
echándolos a todos.

Tres sueldos.
Aguinaldo proporcional.
Vacaciones.

"Un millón doscientos."

Por cabeza.

Apaga la luz.
Mañana hay que pelear.

->->

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