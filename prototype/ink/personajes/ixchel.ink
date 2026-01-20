// ============================================
// PERSONAJE: IXCHEL
// Migrante guatemalteca, indígena.
// Representa la dignidad, el trabajo invisible y la comunalidad.
// ============================================

=== ixchel_encuentro_casual ===

Ves a una mujer barriendo la vereda frente a la mercería.
Es Ixchel. Siempre lleva un huipil colorido bajo el delantal de trabajo.
Se mueve con una parsimonia que contrasta con el ritmo frenético del barrio.

* [Saludar] -> ixchel_saludo
* [Ayudarla con algo] -> ixchel_ayudar
* [Seguir de largo] -> ixchel_ignorar

=== ixchel_saludo ===

"Buen día, Ixchel."

Ella levanta la vista. Sus ojos son profundos, como si vieran más allá de la calle rota.

"Buen día para quien sabe caminarlo", dice con una leve sonrisa.

{not tiene_laburo:
    "Lo veo cargando mucho peso en los hombros, joven. No todo lo que pesa es mochila."
- else:
    "Que la prisa no le quite el camino."
}

->->

=== ixchel_ayudar ===

"¿Te doy una mano con eso?"

Ixchel te entrega la escoba sin dudar.
"La limpieza es un acto sagrado. Gracias."

~ subir_conexion(1)
~ ixchel_estado = "ayudando"

Barray juntos un rato. El sonido de la paja contra el cemento es hipnótico.

"¿Hace mucho que te viniste de Guatemala?"

"Guatemala vive en mi ombligo, joven. Mi familia cuidaba los cerros, defendiendo la tierra de los que venían con máquinas y papeles a decirnos que el agua tenía dueño. Me vine hace cinco años, cuando los líderes empezaron a no volver a casa. Mi tierra no sabe de fronteras, solo de heridas que aún supuran."

->->

=== ixchel_ignorar ===

Pasás rápido.
Ixchel sigue barriendo.
Para ella, el tiempo no es algo que se gasta, es algo que se habita.

->->

// --- EN LA OLLA ---

=== ixchel_en_olla ===

Ixchel está en un rincón, separando legumbres con una velocidad asombrosa.
Parece que sus manos tienen ojos propios.

"La diversidad es lo que hace al guiso", dice sin mirarte.

* ["¿Cómo hacés tan rápido?"]
    "Aprendí de mis abuelas. Ellas decían que el alimento se prepara primero con la intención y después con las manos."
* ["Parece un laburo salado."]
    "El trabajo duro es el que se hace solo, joven. Dios nos dio manos para compartir la carga. Entre muchos, es celebración."

~ subir_llama(1)

->->

// --- CONVERSACION PROFUNDA ---

=== ixchel_sobre_xenofobia ===

Un vecino pasó y dijo algo ofensivo sobre "los que vienen de afuera".
Ixchel no bajó la cabeza. Ni siquiera dejó de separar las lentejas.

"¿No te jode?", preguntás.

"Él tiene el corazón nublado. Que el Señor lo perdone, porque no sabe que la tierra no le pertenece por un papel. La tierra es de Dios, nosotros solo la caminamos."

Te mira fijo.

"Ustedes los uruguayos a veces tienen miedo de ser nosotros. Pero en el hambre, todos tenemos la misma cara."

~ subir_dignidad(1)
~ subir_conexion(1)

->->

// --- FRAGMENTO NOCTURNO ---

=== ixchel_fragmento_noche ===

Ixchel prende una vela pequeña en su cuarto.
El olor a copal llena el aire, tapando el olor a humedad de la pensión.

{ixchel_estado == "ayudando":
    Piensa en el joven.
    En cómo agarró la escoba.
    En que todavía hay manos que no tienen miedo de tocar la tierra.
}

Mira una foto vieja. Unas montañas verdes que parecen tocar el cielo.

"Un día más lejos de la montaña", murmura.
"Pero un día más cerca de Su voluntad y de la comunidad."

Se envuelve en su rebozo.
Mañana hay que barrer de nuevo.
Mañana hay que sostener de nuevo.

->->
