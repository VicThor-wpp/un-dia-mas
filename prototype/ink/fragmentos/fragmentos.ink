// ============================================
// FRAGMENTOS - Sistema de perspectivas alternas
// ============================================

// Los fragmentos son ventanas a la vida de otros personajes.
// Ocurren durante la noche, cuando el protagonista duerme.
// El jugador no controla estas escenas, solo las observa.

// La mayoría de los fragmentos están integrados en cada día
// para mantener el contexto narrativo.

// Este archivo contiene fragmentos compartidos y utilidades.

// ============================================
// FRAGMENTOS DE IXCHEL (la guatemalteca)
// ============================================

=== fragmento_ixchel_intro ===

// Ixchel aparece a partir del jueves
// Reemplaza el lugar que ocupaba la "venezolana" genérica

Ixchel termina de limpiar la cocina del restaurante.
Sus manos están rojas por el agua caliente y el detergente.

"Dale, bolita, apurate que cerramos", grita el encargado.

No es boliviana. Es guatemalteca. Maya-K'iche'.
Se lo dijo tres veces. Él sigue diciendo "bolita".
Para él, todos los indígenas son lo mismo.

Ixchel no contesta.
Su dignidad es un silencio antiguo.

Piensa en su abuela en Quetzaltenango.
En el tejido que le enseñó.
Acá no hay tejidos. Solo grasa y platos sucios.

Sale a la calle. El frío de Montevideo le corta la cara.
Le duele la espalda.
Pero sigue de pie.

"Mañana será otro día", dice en su lengua.
Nadie la escucha.
Nadie la entiende.
Pero ella se entiende.

->->

// ============================================
// FRAGMENTOS DE LA CIUDAD
// ============================================

=== fragmento_ciudad_noche ===

// Fragmento genérico de la ciudad de noche

La ciudad duerme.
O finge dormir.

Los que no tienen techo buscan donde quedarse.
Los que tienen techo tratan de no verlos.

Las luces de la rambla.
Los edificios de Pocitos.
Los cantegriles al fondo.

Todo convive.
Todo ignora.

La misma ciudad.
Mundos distintos.

->->

// ============================================
// NOTAS DE DISEÑO
// ============================================

// Los fragmentos sirven para:
// 1. Mostrar que otros personajes tienen sus propias vidas
// 2. Dar información que el protagonista no tiene
// 3. Crear empatía con la comunidad
// 4. Mostrar las consecuencias sistémicas

// Reglas de los fragmentos:
// - El jugador NO puede actuar durante un fragmento
// - Los fragmentos son cortos (50-100 palabras)
// - Cada fragmento muestra UN momento, UNA perspectiva
// - Los fragmentos dependen de las acciones del día

// ============================================
// FRAGMENTO DE JUAN EN EL LABURO
// ============================================

=== fragmento_juan_laburo ===
// Fragmento de Juan en el laburo sin vos

Juan llega al laburo.
Tu escritorio está vacío.

Nadie dice nada. Pero todos miran.

El jefe pasa como si nada. "Buenos días."

Juan aprieta los dientes.
Sigue laburando.

->->

// ============================================
// FRAGMENTO DE IXCHEL TEJIENDO
// ============================================

=== fragmento_ixchel_tejido ===
// Fragmento de Ixchel tejiendo de noche

En un cuarto pequeño, Ixchel teje.

Los colores son de allá. Los movimientos son de acá.
Un puente entre mundos que nadie ve.

"Ri qa tzij, ri qa k'aslemal."
Nuestras palabras, nuestra vida.

->->

// ============================================
// SISTEMA DE SELECCION DE FRAGMENTOS
// ============================================

=== seleccionar_fragmento_viernes ===
// Elige un fragmento para la noche del viernes
{ayude_en_olla:
    -> fragmento_sofia_cocina ->
- else:
    {vinculo == "marcos":
        -> fragmento_marcos_insomnio ->
    - else:
        -> fragmento_ciudad_noche ->
    }
}
->->

=== seleccionar_fragmento_sabado ===
// Elige un fragmento para la noche del sabado
{participe_asamblea:
    -> fragmento_sofia_asamblea ->
- else:
    {vinculo == "elena":
        -> fragmento_elena_recuerdo ->
    - else:
        {vinculo == "diego":
            -> fragmento_diego_llamada ->
        - else:
            -> fragmento_marcos_balcon ->
        }
    }
}
->->

=== seleccionar_fragmento_domingo ===
// Fragmento final - basado en vinculo
{vinculo == "sofia":
    -> fragmento_sofia_pibes ->
}
{vinculo == "elena":
    -> fragmento_elena_banco ->
}
{vinculo == "diego":
    -> fragmento_diego_mate ->
}
{vinculo == "marcos":
    -> fragmento_marcos_musica ->
}
{vinculo == "juan":
    -> fragmento_juan_cena ->
}
{vinculo == "ixchel":
    -> fragmento_ixchel_altar ->
}
// Fallback
-> fragmento_ciudad_noche ->
->->
