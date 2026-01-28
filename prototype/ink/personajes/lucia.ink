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