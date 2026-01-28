// ============================================
// PERSONAJE: LUCÍA
// Compañera de trabajo, sector contable
// La que politiza en la oficina
// ============================================

// --- PRIMER ENCUENTRO ---

=== lucia_primer_encuentro ===

En el almuerzo hay una mujer que no conocés.
Bueno, la viste. Pero nunca hablaron.

Lucía. Sector contable. Lleva como ocho años.

Tiene cara de pocos amigos.
Pero hoy se sienta cerca.

* [Saludar]
    "Hola. Lucía, ¿no?"
    
    "Sí. Y vos sos el nuevo del cuarto."
    
    "Nuevo... hace dos años."
    
    "Acá todos son nuevos hasta que los echan, bo."
    
    ~ lucia_relacion += 1
    ->->

* [Ignorar]
    Comés en silencio.
    Ella también.
    ->->

=== lucia_en_almuerzo ===
// Tunnel: Lucía aparece en el almuerzo

Lucía está en la mesa del fondo.
La que nadie usa porque está cerca del baño.

Come sola. Lee algo en el celular.
A veces se ríe. A veces niega con la cabeza.

->->

// --- ESCENA CLAVE: CÁLCULO DE PLUSVALÍA ---

=== lucia_calculo_plusvalia ===
// Esta escena desbloquea la idea de antagonismo de clase

Lucía se sienta sin pedir permiso.

"¿Puedo?"

Ya se sentó. No espera respuesta.

* [...]
-

Saca el celular. Calculadora abierta.

"¿Sabés cuánto factura la empresa por cada informe que hacemos?"

"Ni idea."

"Ocho mil pesos. Mínimo. A veces doce.
Esta consultora vende 'Inteligencia de Negocios', pero lo que vendemos es humo bien presentado."

* [...]
-

"Entre todos los del sector hacemos veinte informes por día.
Veinte por ocho mil, ciento sesenta lucas.
Por mes, con veinte días hábiles... tres millones doscientos."

Baja la voz.

"¿Sabés cuánto ganamos los seis del sector?
Todos facturamos como unipersonal, ¿no? Cuarenta mil pesos nominales.
Doscientos cuarenta mil pesos le costamos a la empresa."

* [...]
-

"¿Y los otros tres millones?"

Te mira. Esperando.

"Se los lleva la empresa."

"Bingo."

* [...]
-

Guarda el celular.

"No digo que sea robo. Ellos ponen el edificio, los clientes, el nombre.
Pero nosotros ponemos las horas, el cuerpo, las ideas.
Y nos llevan migajas, che."

* ["Nunca lo pensé así."]
    "Nadie lo piensa. Por eso funciona."
    
    Lucía se levanta.
    
    "Buen provecho."
    
    ~ activar_antagonismo_clase()
    
    # IDEA DESBLOQUEADA: "HAY INTERESES OPUESTOS"
    
    No es que "estamos todos en el mismo barco".
    Unos reman. Otros pasean.
    ->->

* [Quedarte callado]
    Lucía se encoge de hombros.
    
    "Pensalo. O no. Igual te van a explotar."
    
    Se levanta. Se va.
    
    Pero algo quedó.
    ->->

// --- LUCÍA PROPONE ACCIÓN ---

=== lucia_propone_paro ===
// Lucía sugiere una acción colectiva

~ hable_con_lucia_sobre_paro = true

Es viernes. La oficina está vacía.
Lucía te cruza en el pasillo.

"¿Viste lo del piso cuatro?"

"Sí. Los echaron a todos."

* [...]
-

"El lunes le toca al quinto. Lo sé porque vi los papeles."

"¿Cómo?"

"Trabajo en contable, nene. Veo todo."

* [...]
-

Mira para los costados.

"Hay gente hablando de parar. De no ir el lunes.
Que vean qué pasa sin nosotros."

* ["¿Vos estás?"]
    "Siempre estuve. La pregunta es si ustedes están."
    
    Te mira directo.
    
    "Tu amigo Juan tiene miedo. Lo entiendo.
    Pero el miedo no te salva del despido.
    Solo te hace más fácil de echar."
    
    ~ lucia_relacion += 1
    ->->

* ["Es muy arriesgado."]
    "Todo es arriesgado. Quedarte callado también.
    La diferencia es que si paramos, por lo menos jodemos un poco."
    
    Se ríe. Sin alegría.
    
    "Pensalo."
    ->->

* ["No sé..."]
    "Nadie sabe. Pero hay que decidir igual."
    
    Se va.
    ->->

// --- LUCÍA CONTRADICCIÓN (ella no retrocede) ---

=== lucia_post_represion ===
// Después de la represión, Lucía sigue

~ lucia_sigue_luchando = true

Lucía salió de la comisaría hace dos días.
La rajaron del laburo. Obviamente.

La encontrás en un bar.
Tiene un ojo morado. Sonríe igual.

"¿Cómo estás?"

"Viva. Eso ya es mucho."

* [...]
-

"¿Te arrepentís?"

Piensa. Toma un trago.

"Del paro, no. De confiar en que iban a bancarnos más, sí."

* [...]
-

"Pero sabés qué, bo. 
Yo ya estuve en esto antes. En el sindicato.
Sé cómo funciona.
Se pierde más de lo que se gana.
Pero lo que se gana no te lo quita nadie."

* ["¿Qué ganaste?"]
    "Dignidad. Y un par de contactos.
    Ya me van a llamar de otro lado.
    Los quilomberos siempre nos encontramos."
    
    ~ subir_dignidad(1)
    ->->

* [Quedarte callado]
    Lucía termina el trago.
    
    "Vos hacé lo que puedas. Pero no te achiques.
    Achicarse no sirve de nada."
    ->->

// --- FRAGMENTO NOCTURNO ---

=== lucia_fragmento_noche ===

Lucía fuma en el balcón de su departamento.
Un monoambiente en el Cerro.
Lo que le alcanza.

{lucia_sigue_luchando:
    Mañana tiene una entrevista en una cooperativa.
    No paga mucho. Pero no hay patrón.
    Algo es algo.
- else:
    Mañana hay que ir a laburar.
    Sonreír. Aguantar. Calcular.
    Y esperar el momento justo.
}

Su viejo era delegado en el frigorífico.
Lo rajaron en el 2002.
Nunca se recuperó.

Lucía sí.
Lucía aprendió que el golpe viene igual.
Lo único que elegís es si te agarra parado o arrodillado.

Apaga el cigarro.
Mañana es otro día.

->->
