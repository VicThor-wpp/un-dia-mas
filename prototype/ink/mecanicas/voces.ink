// ============================================
// GABINETE DEL PENSAMIENTO - VOCES INTERNAS
// El sistema de diálogo interno reactivo
// ============================================

=== voces_reaccion ===
// Llamar en momentos de pausa o decisión
// Evalúa qué ideas tenés y si "hablan"

{ not voces_activas:
    ->->
}

// Probabilidad base
{ RANDOM(1, 100) > probabilidad_voz:
    ->->
}

// Prioridad: Ideas Involuntarias (Crisis)
{ idea_quien_soy && ultima_voz != "quien_soy":
    -> voz_quien_soy ->
    ->->
}

{ idea_no_soy_suficiente && ultima_voz != "suficiente":
    -> voz_suficiente ->
    ->->
}

// Prioridad: Ideas Políticas
{ idea_el_problema_no_soy_yo && ultima_voz != "problema":
    -> voz_problema_sistema ->
    ->->
}

{ idea_red_o_nada && ultima_voz != "red":
    -> voz_red ->
    ->->
}

// Conflictos
{ idea_salvacion_individual && idea_hay_cosas_juntos:
    -> conflicto_individual_colectivo ->
    ->->
}

->->

// --- VOCES ESPECÍFICAS ---

=== voz_quien_soy ===
~ ultima_voz = "quien_soy"
# VOZ:inseguridad
<i>(Tu cabeza te recuerda algo: a esta hora deberías estar en la oficina. Para el mundo productivo, ahora sos invisible.)</i>
->->

=== voz_suficiente ===
~ ultima_voz = "suficiente"
# VOZ:miedo
<i>(¿Y si tenían razón? ¿Y si realmente no servís? Capaz que tuviste suerte tres años y ahora se acabó la mentira.)</i>
->->

=== voz_problema_sistema ===
~ ultima_voz = "problema"
# VOZ:politica
<i>(Mirás alrededor. No es mala suerte. Es un diseño. El sistema necesita gente desesperada para bajar los sueldos. Vos sos parte del engranaje, aunque estés afuera.)</i>
->->

=== voz_red ===
~ ultima_voz = "red"
# VOZ:elena
<i>(Te acordás de Elena. "Nadie se salva solo". Suena lindo, pero qué difícil es confiar cuando estás cayendo.)</i>
->->

=== voz_orden ===
~ ultima_voz = "orden"
# VOZ:bruno
<i>(Mucha mugre. Mucho desorden. Capaz que Bruno tiene razón. Alguien tiene que venir a limpiar todo esto.)</i>
->->

// --- CONFLICTOS ---

=== conflicto_individual_colectivo ===
~ ultima_voz = "conflicto"
# VOZ:conflicto
<i>(Una parte tuya quiere mandar todo a la mierda y salvarse sola. "Yo primero". Pero la otra parte sabe que sin los demás, no durás dos días. La guerra civil en tu cabeza no para.)</i>
->->

// --- VOCES DE CONTEXTO ---

=== voz_olla_vacia ===
// Llamar cuando ves la olla vacía
# VOZ:tristeza
<i>(El silencio de la cocina es peor que el ruido. Es el sonido del hambre esperando.)</i>
->->

=== voz_lujo_ajeno ===
// Llamar cuando ves a alguien con plata
# VOZ:rencor
<i>(Mirás sus zapatos. Nuevos. Cuero. Podrías comer una semana con lo que valen esos zapatos. El pensamiento es feo, pero es real.)</i>
->->
