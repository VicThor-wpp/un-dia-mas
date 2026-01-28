// SISTEMA DE REFLEXIONES NOCTURNAS (Gabinete del Pensamiento)
// ============================================

=== reflexion_nocturna ===
// Se llama al final del día, antes del fragmento nocturno.
// Procesa las interacciones del día.

# GABINETE DEL PENSAMIENTO

Te acostás.
El cuerpo descansa.
La cabeza no.

// --- REFLEXIÓN LUCÍA (Lunes/Martes) ---
{lucia_relacion >= 1 && not idea_organizacion_real && not idea_no_es_individual:
    La voz de Lucía vuelve.
    "No es personal. Es limpieza."
    "Números que no cierran."

    * [Pensar: "Tiene razón. Soy un número."]
        Es frío. Pero es real.
        Si sos un número, no es tu culpa.
        Es matemática.
        ~ unlock_idea(idea_no_es_individual)
        ~ disminuir_inercia(1)
        ->->

    * [Pensar: "No, yo valgo. Se equivocaron conmigo."]
        Te aferrás a tu valor.
        Pero duele más.
        Porque si valés, ¿por qué te descartan?
        ~ subir_dignidad(1)
        ->->
}

// --- REFLEXIÓN CACHO (Jueves) ---
{cacho_deuda > 0 || cacho_estafado:
    Pensás en Cacho.
    En sus perfumes falsos.
    En su "mentalidad de tiburón" en una casa que se cae.

    * [Pensar: "Pobre tipo."]
        Es un espejo roto.
        No querés ser eso.
        ~ subir_dignidad(1)
        ->->

    * [Pensar: "Al menos lo intenta."]
        Él se mueve.
        Vende humo, pero vende.
        ¿Y vos?
        ~ unlock_idea(idea_salvacion_individual)
        ~ aumentar_inercia(1)
        ->->
}

// --- REFLEXIÓN CLAUDIA (Viernes) ---
{claudia_hostilidad > 0 || lista_entregada:
    La cara de Claudia.
    La planilla.
    "Una cédula, un plato."

    * [Pensar: "Es violencia."]
        Pedir papeles para comer es violencia.
        No es orden. Es castigo.
        La rabia te despierta.
        ~ unlock_idea(idea_antagonismo_clase)
        ~ disminuir_inercia(1)
        ->->

    * [Pensar: "Es necesario."]
        Sin control, todo se desmadra.
        Alguien tiene que contar.
        Aunque duela.
        ~ unlock_idea(idea_numero_frio)
        ~ aumentar_inercia(1)
        ->->
}

// --- REFLEXIÓN BRUNO (Viernes/Sábado) ---
{bruno_tension > 0:
    La camioneta negra.
    "Orden."
    "Disciplina."

    * [Pensar: "Es un facho."]
        Quiere esclavos, no trabajadores.
        Se aprovecha del hambre.
        ~ subir_dignidad(1)
        ->->

    * [Pensar: "Al menos ofrece algo."]
        Techo. Comida.
        ¿Qué ofrece la Olla? Incertidumbre.
        ¿Qué ofrece el Estado? Papeles.
        El orden tienta.
        ~ unlock_idea(idea_orden_autoritario)
        ~ aumentar_inercia(1)
        ->->
}

// Default si no hay nada específico
El silencio de la noche.
Mañana será otro día.

->->

=== function unlock_idea(ref idea_var) ===
    ~ idea_var = true
    # IDEA DESBLOQUEADA
