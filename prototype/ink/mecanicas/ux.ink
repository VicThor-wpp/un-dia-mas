// ============================================
// SISTEMA DE UX - DIARIO Y GLOSA
// Mecánicas de registro y contexto
// ============================================

=== diario_escribir ===
// Llamar cada noche antes de dormir

~ diario_entradas += 1

# DIARIO
Abrís el cuaderno.
La birome apenas tiene tinta.

{ ayude_en_olla:
    -> entrada_olla
}

{ not ayude_en_olla && olla_en_crisis:
    -> entrada_culpa
}

{ fui_despedido:
    -> entrada_despido
}

{ conexion >= 5:
    -> entrada_conexion
}

{ inercia >= 7:
    -> entrada_inercia
}

* [Cerrar el diario]
    Cerrás el cuaderno.
    Mañana será otro día.
    ->->

=== entrada_olla ===
"Hoy las manos me huelen a cebolla.
Es un olor fuerte, se te mete en la piel.
Pero es mejor que el olor a oficina cerrada.
Al menos hoy alguien comió gracias a que yo estuve ahí."
~ total_victorias_morales += 1
->->

=== entrada_culpa ===
"Hoy no fui.
Sabía que necesitaban gente. Pero no fui.
Me quedé en mi burbuja.
La burbuja es segura, pero el aire se está viciando."
~ total_traiciones += 1
->->

=== entrada_despido ===
"Sigo esperando que suene el despertador y sea todo un sueño.
Pero no.
Soy un ex-empleado.
Un 'recurso optimizado'.
Qué forma elegante de decir 'basura'."
->->

=== entrada_conexion ===
"El barrio está raro. O yo estoy raro.
La gente me saluda distinto.
Como si me vieran de verdad.
Capaz que antes yo no miraba."
->->

=== entrada_inercia ===
"Hoy me costó levantarme.
No porque tuviera sueño.
Sino porque no tenía razón para despertarme.
La cama es un pozo gravitacional."
->->

// --- SISTEMA DE GLOSA (HELPERS) ---

// Esto se usará como tunnel para "explicar" cosas si el jugador pregunta
// En el texto principal se usa markup [MIDES|Ministerio...]
// Aquí ponemos explicaciones más largas si se necesitan

=== explicar_mides ===
El MIDES (Ministerio de Desarrollo Social) se creó en 2005, post-crisis.
Para el barrio, es la cara del Estado.
A veces trae comida. A veces trae planillas y burocracia.
Sofía tiene una relación de amor-odio con ellos.
->->

=== explicar_unipersonal ===
La "Unipersonal" es la trampa perfecta.
Sos una empresa de una sola persona.
Le facturás a tu "patrón".
Si te echan, no es despido. Es "cese de contrato".
Sin indemnización. Sin seguro de paro. Sin nada.
Es la forma moderna de la servidumbre.
->->
