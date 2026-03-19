// ============================================
// BÚSQUEDA DE EMPLEO - LA TOXICIDAD DEL MERCADO LABORAL
// Escenas de LinkedIn, entrevistas, rechazos, ghosting
// ============================================

// --- TUNNELS EXPORTADOS ---
// busqueda_linkedin_perfil - Optimizar perfil de LinkedIn
// busqueda_linkedin_scroll - Scrollear LinkedIn en la cama
// busqueda_linkedin_publicar - El post motivacional
// busqueda_cv_optimizar - "Optimizar" el CV
// busqueda_enviar_cvs - Mandar CVs al vacío
// busqueda_entrevista_startup - La startup tóxica
// busqueda_entrevista_grande - La empresa grande
// busqueda_entrevista_fantasma - El ghosting empresarial
// busqueda_rechazo_mail - El mail de rechazo genérico
// busqueda_networking_falso - El café con el "contacto"

// ============================================
// LINKEDIN - EL ESCENARIO DEL DESEMPLEADO
// ============================================

=== busqueda_linkedin_perfil ===
// Tunnel: Optimizar el perfil de LinkedIn

Abrís LinkedIn.

Tu perfil te mira.
La foto de hace dos años.
El título que ya no aplica.

* [...]
-

"Profesional con experiencia en..."

¿Experiencia en qué? ¿En que te echen?
¿En facturar como unipersonal sin derechos?

* [Actualizar el título]
    -> busqueda_linkedin_titulo
* [Dejarlo como está]
    No tenés energía para esto.
    El perfil sigue mintiendo.
    Pero todas las mentiras mienten.
    ->->

=== busqueda_linkedin_titulo ===

¿Qué ponés?

* ["En búsqueda activa"]
    El cartel de "desesperado" versión profesional.
    
    Dicen que los recruiters lo filtran.
    Que es mejor no ponerlo.
    Que el desempleo es contagioso.
    
    Lo ponés igual.
    Al menos es honesto.
    
    ~ subir_dignidad(1)
    ->->

* ["Open to work" (el marco verde)]
    El marco verde de la vergüenza.
    
    Todos saben lo que significa.
    Todos fingen que no juzgan.
    
    Lo activás.
    
    ~ bajar_dignidad(1)
    ->->

* ["Emprendedor independiente"]
    La mentira del autónomo por obligación.
    
    "Emprendedor" suena mejor que "me echaron".
    "Independiente" suena mejor que "sin derechos".
    
    La ficción de ser tu propio jefe
    cuando el único que facturás está en quiebra.
    
    ->->

=== busqueda_linkedin_scroll ===
// Tunnel: Scrollear LinkedIn en la cama (daño psicológico)

LinkedIn.
El infierno de las comparaciones.

* [Scrollear...]
-

Post de alguien que conocés:
"¡Feliz de anunciar que me uno al equipo de [empresa]!"
142 likes. 23 comentarios de "felicitaciones".

* [Seguir...]
-

Post motivacional:
"El desempleo es una oportunidad para reinventarte.
Yo estuve 6 meses sin laburo.
Ahora soy CEO de mi propia startup."

No menciona que su viejo le prestó plata.
No menciona los contactos.
No menciona la suerte.

* [Seguir...]
-

Otro post:
"Si no encontrás laburo, es porque no buscás bien.
El que quiere, puede."

~ bajar_dignidad(1)
~ aumentar_inercia(1)

* [Cerrar la app]
    Cerrás.
    Pero el veneno ya entró.
    ->->
* [Seguir scrolleando...]
    -> busqueda_linkedin_scroll_2

=== busqueda_linkedin_scroll_2 ===

Más posts.
Más "éxitos".
Más gente que "la tiene clara".

* [...]
-

Un post de un recruiter:
"URGENTE: Buscamos perfil junior con 5 años de experiencia.
Inglés nativo. Disponibilidad 24/7.
Ofrecemos: Excelente ambiente laboral."

No dice el sueldo.
Nunca dicen el sueldo.

* [...]
-

~ bajar_dignidad(1)

Otro:
"Empresa joven y dinámica busca..."

"Joven" = te vamos a explotar.
"Dinámica" = no hay horarios fijos.
"Busca" = hace 6 meses que no llenan el puesto.

* [Cerrar definitivamente]
    Cerrás.
    Son las 2 AM.
    No dormiste nada.
    Y ahora te sentís peor.
    
    ~ aumentar_inercia(1)
    ->->

=== busqueda_linkedin_publicar ===
// Tunnel: Escribir el post motivacional (la performance del desempleado)

Pensás en escribir algo.
Un post.
Para "mostrarte activo".

¿Qué ponés?

* [Algo honesto]
    -> busqueda_linkedin_post_honesto
* [Algo performático]
    -> busqueda_linkedin_post_falso
* [Nada, mejor no]
    No tenés energía para actuar.
    Y menos para ser honesto.
    ->->

=== busqueda_linkedin_post_honesto ===

Escribís:

"Hace una semana me despidieron.
Era unipersonal. No hay indemnización.
Estoy buscando trabajo.
Si alguien sabe de algo, avíseme."

Simple. Real.

* [Publicar]
    Lo publicás.
    
    2 likes. 0 comentarios.
    
    La honestidad no vende.
    Pero al menos no mentiste.
    
    ~ subir_dignidad(1)
    ->->
* [Borrar]
    Lo borrás.
    Muy expuesto.
    Muy real.
    ->->

=== busqueda_linkedin_post_falso ===

Escribís:

"Nuevos comienzos 🚀
A veces la vida nos empuja a reinventarnos.
Estoy emocionado de explorar nuevas oportunidades.
#OpenToWork #NuevosDesafios #Crecimiento"

El emoji del cohete.
Los hashtags vacíos.
La mentira de la emoción.

* [Publicar]
    Lo publicás.
    
    14 likes. 3 comentarios: "Mucha suerte!", "Éxitos!", "DM me 📩"
    
    El DM es de alguien vendiendo cursos.
    
    ~ bajar_dignidad(1)
    ->->
* [Borrar]
    Lo borrás.
    Demasiada actuación.
    ->->

// ============================================
// OPTIMIZAR EL CV - LA FICCIÓN DEL MÉRITO
// ============================================

=== busqueda_cv_optimizar ===
// Tunnel: "Optimizar" el currículum

Abrís el CV.
El documento que resume tu vida laboral.
O la versión de tu vida que vendés.

* [...]
-

"Experiencia profesional"

Lo que dice: "Responsable de..."
Lo que fue: Hacer el laburo de tres personas por el sueldo de una.

Lo que dice: "Lideré proyectos de..."
Lo que fue: El jefe se llevó el crédito.

Lo que dice: "Logré incrementar..."
Lo que fue: Trabajaste 60 horas semanales.

* [Agregar más keywords]
    "Proactivo". "Orientado a resultados". "Team player".

    Las palabras que los robots de Personal buscan.
    Las palabras que no significan nada.

    ~ bajar_dignidad(1)

    // The real CV — the one nobody reads
    Parás un segundo.

    Sacás una hoja en blanco.

    No para LinkedIn. No para el algoritmo.
    Para vos.

    "Sé hacer planillas. Sé coordinar equipos chicos.
    Sé resolver quilombos a las 6 de la tarde un viernes.
    Sé escuchar cuando alguien tiene un problema.
    Sé hacer café para veinte personas."

    {ayude_en_olla:
        "Sé pelar papas para sesenta."
    }

    Esas cosas no entran en un CV.
    Pero son reales.

    ~ subir_dignidad(1)
    # NOTIFICATION:positive:Sabés cosas que importan
    ->->

* [Dejarlo simple]
    Lo dejás como está.
    Si no alcanza, mala suerte.
    No vas a convertirte en un producto.
    
    ~ subir_dignidad(1)
    ->->

* [Pedir ayuda a alguien]
    {conexion >= 4:
        Le mandás a alguien del barrio.
        "¿Me das una mano con esto?"
        
        A veces el CV lo arregla otro par de ojos.
        ~ subir_conexion(1)
    - else:
        No tenés a quién pedirle.
        O no querés molestar.
    }
    ->->

// ============================================
// ENVIAR CVs - EL VACÍO QUE NO RESPONDE
// ============================================

=== busqueda_enviar_cvs ===
// Tunnel: Mandar CVs al vacío

Abrís las páginas de empleo.

* [...]
-

BuscoJobs. CompuTrabajo. LinkedIn Jobs.
El mismo puesto repetido en tres sitios.
El mismo sueldo que no dice.
Los mismos requisitos imposibles.

* [...]
-

"Se requiere: 5 años de experiencia en tecnología que existe hace 3."
"Excluyente: Inglés C2, Portugués avanzado, Excel nivel dios."
"Deseable: Que no tengas vida."
"Beneficios: Fruta en la oficina."

{fui_despedido:
    Seguís scrolleando y se te para el corazón.

    Ahí está. Tu puesto. Publicado ayer.
    El mismo puesto. La misma descripción.
    La mitad del sueldo.

    Te reemplazaron antes de que llegaras a tu casa.
}

* [Aplicar igual]
    -> busqueda_aplicar_masivo
* [Buscar algo más realista]
    -> busqueda_buscar_realista

=== busqueda_aplicar_masivo ===

Son las dos de la tarde.
Estás en calzoncillos.
El café al lado se enfrió hace horas.

La pantalla te ilumina la cara.
El cursor parpadea en el campo de "Carta de presentación".

* [...]
-

"Estimados, me dirijo a ustedes..."

La mentira más grande que vas a decir hoy.
No te dirigís a nadie.
Le hablás a un formulario que alimenta un algoritmo
que decide si existís o no.

Copy-paste. Adjuntar CV. Enviar.

* [...]
-

LinkedIn te sugiere: "Personas como vos también aplicaron a..."

847 postulantes.
847 personas que también están en calzoncillos a las dos de la tarde
mirando la misma pantalla.

Te preguntás si alguien lee estas cosas.
O si un algoritmo decide por vos.
Si una máquina mira tu CV dos segundos y dice "no"
antes de que ningún ser humano sepa que existís.

* [...]
-

Aplicás a otra.
Y a otra.
Cambiás el nombre de la empresa en la carta.
A veces te olvidás de cambiarlo.

"Estimados responsables de [EMPRESA ANTERIOR]:"

Mierda.

* [...]
-

Empezás a customizar.
"Soy proactivo."
"Orientado a resultados."
"Trabajo bien bajo presión."
"Work hard, play hard."

Con cada buzzword te odiás un poco más.
Con cada "sinergia" se te muere algo adentro.
Te convertís en un producto que se vende solo.

* [...]
-

15 postulaciones.
15 veces "Estimados".
15 veces la misma mentira con distinto logo.

~ rechazos_enviados += 15
~ bajar_dignidad(1)

Mandás.
Mandás.
Mandás.

El contador de "postulaciones enviadas" sube.
La respuesta: silencio.

Siempre silencio.

{vinculo == "diego" && diego_relacion >= 2:
    Diego te mandó un mensaje: "¿Cómo va la búsqueda?"
    No le contestás. No sabés qué decir.
}
{vinculo == "sofia" && sofia_relacion >= 2:
    Sofía: "Si necesitás usar internet, en la olla hay wifi."
    Pequeño gesto. Grande.
}

// The realization (appears after 2nd round of CVs)
{rechazos_enviados >= 20:
    Parás.

    Quince más. Cero respuestas. Otra vez.

    Pero esta vez algo es distinto.
    No es que te duele menos.
    Es que empezás a ver el patrón.

    Trescientas personas peleando por un puesto que paga menos que el anterior.
    El mismo algoritmo filtrando los mismos CVs.
    El mismo "agradecemos tu interés" automático.

    No es que no seas suficiente.
    Es que el sistema no necesita que seas suficiente.
    Necesita que sigas mandando CVs.

    # NOTIFICATION:info:Algo se aclara
    ~ subir_dignidad(1)
}

->->

=== busqueda_buscar_realista ===

Buscás algo que coincida de verdad.

* [...]
-

Encontrás uno.
Uno solo.
En toda la página.

"Se busca. Unipersonal."

Otra vez.
El mismo formato de contratación del que te echaron.
Sin derechos. Sin aportes. Sin nada.

* [Aplicar igual]
    No hay otra cosa.
    Aplicás.
    ~ rechazos_enviados += 1
    ->->
* [No aplicar]
    No vas a volver a lo mismo.
    O sí, pero no hoy.
    ->->

// ============================================
// ENTREVISTA STARTUP - "SOMOS FAMILIA"
// ============================================

=== busqueda_entrevista_startup ===
// Tunnel: La entrevista en la startup tóxica

El ascensor abre en un piso sin paredes.
Espacio abierto. Piso de cemento alisado. Cañerías a la vista.
Diseño que imita pobreza costando una fortuna.

Un neón fucsia en la pared dice "HUSTLE".
Otro, más chico, dice "DREAM BIG."
Hay un futbolito que nadie usa.
Una heladera de vidrio llena de cerveza artesanal.
Plantas que alguien riega. Una hamaca paraguaya en un rincón.

Todos tienen menos de treinta.
Remeras negras. Zapatillas caras. MacBooks.
Te miran cuando pasás. Sonríen.
Te sentís como un padre que entró al boliche equivocado.

* [...]
-

Una piba con pelo azul se acerca.
Descalza. En la oficina.

"¡Hola! Soy Martina, People Lead."

No Personal. No Recursos Humanos. People Lead.
La misma mierda con tipografía sans-serif.

"¿Querés agua?"

Te da una botella de aluminio que dice "HYDRATE OR DIE."

"Acá somos re informales," dice. Te tutea.
"No me digas usted, por favor, me hace sentir vieja."

Tiene veinticinco.

* [...]
-

Se sientan en unos sillones que parecen bolsas de dormir.
No hay escritorio. No hay mesa.
Vos tenés las rodillas más altas que la cadera.
Te sentís ridículo.

"Bueno, antes de hablar del puesto, quiero conocerte a vos."

Sonríe. Esperás.

"¿Qué animal serías?"

* ["¿Perdón?"]
    "Qué animal serías. Si fueras un animal."

    Pensás: un burro. Porque acá me están tomando para la joda.

    "Un... ¿perro?"

    "¡Copado! ¿Por qué?"

    "Porque es leal."

    "Amamos la lealtad acá."

    -> busqueda_startup_preguntas

* [Seguirle el juego]
    "Un gato."

    "¿Por qué?"

    "Porque es independiente."

    Se le congela la sonrisa un segundo.
    Acá no quieren independientes.

    -> busqueda_startup_preguntas

=== busqueda_startup_preguntas ===

"¿Y cuál dirías que es tu superpoder?"

Superpoder.
Tenés cuarenta y pico, te echaron hace cuatro días,
y esta piba te pregunta por tu superpoder.

"Soy... organizado."

"Ah, re. ¿Y cuál es tu debilidad?"

"Soy demasiado honesto."

Ni ella se lo cree. Ni vos.
Pero el protocolo sigue.

* [...]
-

"Contame de un fracaso y cómo lo convertiste en aprendizaje."

Un fracaso.
Te echaron hace cuatro días. ¿Cuenta?

Llevaste quince años a un lugar que te sacó por mail.
¿Eso es un fracaso o es una lección?
¿Es aprendizaje o es que te cagaron?

"En mi trabajo anterior hubo una reestructura..."

Reestructura. La palabra linda para decir que te rajaron.

"...y lo tomé como una oportunidad para replantearme."

Mentís. No te replanteaste nada.
Estás acá sentado en una bolsa de dormir
contestando qué animal serías.

Martina asiente. Toma notas en un iPad.

* [...]
-

"Bueno, te cuento de nosotros."

"Acá somos una familia."

La frase. La red flag nuclear.

"No hay jefes, hay líderes.
No hay horarios, hay ownership.
No hay empleados, hay co-creadores."

Mirás alrededor.
Los co-creadores tienen ojeras.
Uno come una barrita de cereal sobre el teclado.
Son las siete de la tarde.

"Ah, y los viernes tenemos happy hour y pizza."

La pizza. El soborno más viejo de la startup.

* [Preguntar por el sueldo]
    -> busqueda_startup_sueldo

* [Seguir escuchando]
    -> busqueda_startup_sueldo

=== busqueda_startup_sueldo ===

"¿Y la remuneración?"

Se acomoda en el sillón-bolsa.

"Mirá, nosotros pensamos en compensación total.
Tenés el snack bar, el gym, la heladera con birra,
días de wellness, retiros de equipo en Rocha..."

"Pero en plata."

"Estamos en el rango de mercado para el cargo."

"¿Cuánto?"

Silencio.

Martina se mira las uñas, pintadas de negro.

Te dice un número.

* [...]
-

Es cuarenta por ciento menos que tu último sueldo.
Cuarenta por ciento menos. Por un trabajo que dice "senior" en el título.

"Pero tenemos equity," agrega rápido.

Equity. Acciones.
De una startup que vende... algo.
En la entrevista entera no entendiste bien qué vende.
¿Software? ¿Una plataforma? ¿Vibraciones positivas?

"Es una oportunidad de crecimiento re grosa."

Crecimiento para ellos. Pobreza para vos.

* [...]
-

Martina se para. La entrevista terminó.

"Fue un placer re grande conocerte."

Te da la mano. Agarre suave.
Te acompaña al ascensor.

"Te vamos a estar contactando."

No te van a contactar.
Lo sabés. Ella lo sabe.
Pero los dos sonríen.
El protocolo del rechazo disfrazado de esperanza.

El ascensor baja.
Tu reflejo en la puerta de acero inoxidable.
La botella de HYDRATE OR DIE todavía en tu mano.

* [Irte con dignidad]
    El ascensor se abre.

    Te das vuelta.

    "Martina."

    Se da vuelta, sorprendida.

    "Gracias, pero no es lo que busco."

    La cara del People Lead. No esperaba un no.
    Nadie dice que no. Todos necesitan laburo.

    Pero vos dijiste que no.

    ~ subir_dignidad(1)
    -> busqueda_startup_despues

* [Irte sonriendo]
    "Dale, genial, esperamos tu llamado."

    Mentís. Mienten. Todos mienten.
    La sonrisa te dura hasta la planta baja.

    Después se te cae la cara.

    -> busqueda_startup_despues

=== busqueda_startup_despues ===

Pasan tres semanas.
Nada.

~ rechazos_ghosting += 1
~ rechazos += 1

Ni un mail. Ni un mensaje.
El ghosting empresarial.
Simplemente, dejás de existir.

La botella de HYDRATE OR DIE termina en la basura.

->->

// ============================================
// ENTREVISTA EMPRESA GRANDE - EL PROCESO KAFKIANO
// ============================================

=== busqueda_entrevista_grande ===
// Tunnel: La entrevista en empresa grande

El edificio es de vidrio y acero.
Logo corporativo enorme en la entrada.
Seguridad, torniquetes, credencial de visitante.
Te cuelgan del cuello una tarjeta que dice "INVITADO" en rojo.
Como si necesitaras un cartel que diga que no pertenecés.

* [...]
-

La sala de espera tiene sillas de plástico duro.
Y una mesa ratona con revistas de 2019.

Hay otros seis candidatos.
Todos con la misma cara de "necesito esto."
Todos evitando mirarse entre sí.

Uno mueve la pierna sin parar.
Otra revisa el celular, scrollea sin leer.
Un pibe de traje prestado se mira los zapatos.
Nadie habla.

La solidaridad entre desempleados no existe acá.
Acá son competencia.
Cada uno de ellos es el enemigo.
Aunque todos están en la misma mierda.

Esperás cuarenta y cinco minutos.
Nadie se disculpa.

* [...]
-

Te llaman.

Una sala con mesa larga, luces frías.
Tres personas del otro lado.
Vos solo de este.

La del medio pregunta. Pelo tirante, traje gris.
La de la izquierda toma notas. No levanta la vista.
El de la derecha te mira. Solo te mira.
No anotó nada. No preguntó nada.
Está ahí para ponerte nervioso, y funciona.

"¿Por qué querés trabajar acá?"

Porque necesito comer, pensás.
Porque el alquiler no se paga con motivación.
Porque si no consigo algo me voy a la mierda.

"Siempre admiré la trayectoria de la empresa," decís.

La del medio asiente. La de la izquierda anota.
El de la derecha parpadea.

* [El discurso ensayado]
    "Soy un profesional con amplia experiencia en..."

    Las palabras salen solas. Las dijiste tantas veces
    que ya no significan nada.

    Son un ruido que hacés con la boca
    mientras tres desconocidos deciden si merecés comer.
    -> busqueda_grande_proceso

* [Algo más real]
    "Mire, trabajo en esto hace años. Me despidieron hace poco. Necesito laburo."

    La de las notas levanta la vista por primera vez.
    La del medio se acomoda en la silla.
    El de la derecha no se inmuta.

    "Valoramos la honestidad, pero ¿podés enfocarte más en tus competencias?"

    Tus competencias. No tu hambre. Tus competencias.

    ~ subir_dignidad(1)
    -> busqueda_grande_proceso

=== busqueda_grande_proceso ===

La del medio junta las manos.

"Bueno, te explico el proceso."

"Este es el primer paso."

* [...]
-

"Después viene la prueba técnica."

"Después la evaluación psicológica."

"Después entrevista con el gerente de área."

"Después entrevista grupal con otros candidatos."

"Después un período de prueba de tres meses. Sin contrato formal."

"Y después, si todo sale bien, vemos."

Siete etapas.
Siete veces vestirte bien, ponerte nervioso, esperar, sonreír.
Siete chances de que te digan que no.
Para un trabajo que paga lo mínimo.

"¿El período de prueba es remunerado?"

Silencio.

"Es un período de observación mutua."

Observación mutua. Tres meses de laburo gratis
con nombre de psicología.

* ["Perfecto, cuando quieran."]
    "Contá conmigo."

    La necesidad te hace flexible.
    Demasiado flexible.

    ~ bajar_dignidad(1)
    -> busqueda_grande_espera

* ["¿Siete etapas para esto?"]
    "Es el proceso estándar de la industria."

    "¿La industria de qué? ¿De perder el tiempo de la gente?"

    Se miran entre ellos.
    El de la derecha sonríe por primera vez.

    "Gracias, pero no me interesa."

    Te levantás.
    Dejás la credencial de INVITADO en la mesa.

    ~ subir_dignidad(1)
    ~ rechazos += 1
    ->->

=== busqueda_grande_espera ===

Pasás la primera.
Pasás la segunda.
La prueba psicológica te pregunta si preferís trabajar solo o en equipo.
Marcás "en equipo" porque sabés que eso quieren leer.

Hacés el caso práctico. Un fin de semana entero.
Diez horas de trabajo gratis que llaman "evaluación."

* [...]
-

Después: nada.

Un lunes. Un martes. Una semana.

El jueves, un mail.

"Estimado/a,

Agradecemos su interés en formar parte de nuestra organización.
Tras una evaluación exhaustiva de los perfiles recibidos,
hemos decidido continuar el proceso con otros candidatos
cuyo perfil se ajusta mejor a los requerimientos actuales del cargo.

Le deseamos éxito en su búsqueda profesional.

Atentamente,
Dirección de Capital Humano"

* [...]
-

Capital Humano.
No te llamaron por tu nombre.
Porque no saben tu nombre.
Lo generó un algoritmo que cruza una base de datos
con un template de rechazo.

Quince horas de tu vida.
Cinco etapas.
Para un mail automático.

~ rechazos += 1
~ aumentar_inercia(1)

No sabés qué hiciste mal.
Nunca sabés.
Porque no te dicen.
Porque probablemente ni ellos saben.
Probablemente el puntaje de un Excel decidió por ellos.

La credencial de INVITADO la tiraste a la basura al salir.
Pero el olor a oficina corporativa te quedó en la ropa.

->->

// ============================================
// EL GHOSTING EMPRESARIAL
// ============================================

=== busqueda_entrevista_fantasma ===
// Tunnel: La entrevista que nunca se concreta

Te citaron a las 10.
Zoom.
Estás listo 15 minutos antes.

* [Entrar a la sala]
-

"Esperando a que el anfitrión inicie la reunión."

10:00. Esperás.
10:05. Esperás.
10:10. Esperás.

* [Escribirle]
    Mandás un mail:
    "Hola, estoy en la sala esperando. ¿Todo bien?"

    Nada.

    - (espera_respuesta)

    * [Seguir esperando]
        10:20. Nada.
        10:30. Te vas.
        
        ~ rechazos_ghosting += 1
        ~ bajar_dignidad(1)
        
        Nunca responden.
        Ni para cancelar.
        Tu tiempo no vale nada.
        ->->

* [Irte]
    Te vas.
    No tenés por qué esperar.
    
    Dos días después, un mail:
    "Disculpá, surgió algo. ¿Podemos reagendar?"

    - (decidir_reagendar)

    * [Reagendar]
        Reagendás.
        
        La segunda vez: lo mismo.
        
        ~ rechazos_ghosting += 1
        ~ bajar_dignidad(1)
        
        Aprendés la lección.
        ->->
    * [No contestar]
        No contestás.
        
        El ghosting se devuelve.
        Pero no se siente bien.
        Solo se siente vacío.
        ->->

// ============================================
// EL MAIL DE RECHAZO
// ============================================

=== busqueda_rechazo_mail ===
// Tunnel: Recibir un mail de rechazo genérico

Nuevo mail.

"Re: Tu postulación a [Empresa]"

El corazón salta un segundo.

* [Abrirlo]
-

"Estimado/a [NOMBRE],

Gracias por tu interés en formar parte de nuestro equipo.

Lamentablemente, en esta oportunidad hemos decidido
continuar el proceso con otros candidatos.

Te deseamos mucho éxito en tu búsqueda laboral.

Saludos cordiales,
Equipo de Talento Humano"

* [...]
-

~ rechazos += 1

El mismo mail.
Siempre el mismo mail.
Cambia el logo arriba. El texto es igual.

No dicen por qué.
No dicen qué fallaste.
No dicen nada útil.

Solo que no.

{rechazos >= 3:
    Vas perdiendo la cuenta.
    ¿Este es el tercero? ¿El cuarto?
}

{rechazos >= 5:
    Ya perdiste la cuenta.
    Son todos iguales.
    Todos dicen lo mismo.
    Ninguno te elige.
}

->->

// ============================================
// NETWORKING FALSO
// ============================================

=== busqueda_networking_falso ===
// Tunnel: El café con el "contacto"

Alguien de LinkedIn te contestó.
"Dale, tomemos un café y vemos."

Te ilusionás un poco.
Un contacto. Una posibilidad.

* [Ir al café]
-

Llegás.
Él ya está.
Sonrisa de vendedor.

* [...]
-

"Mirá, laburo no tengo para ofrecerte ahora mismo.
Pero te quería contar de una oportunidad."

* [Escuchar]
    "Es un modelo de negocio increíble.
    Vos invertís un poco al principio,
    y después generás ingresos pasivos."
    
    Esquema piramidal.
    O coaching.
    O criptomonedas.
    O las tres cosas.

    - (decidir_piramide)

    * ["No me interesa."]
        "Pero ni escuchaste la propuesta."
        
        "No necesito escucharla. Gracias por el café."
        
        Te vas.
        
        ~ subir_dignidad(1)
        ~ bajar_conexion(1)
        ->->
    
    * [Escuchar por cortesía]
        30 minutos después, sabés que viniste al pedo.
        
        "¿Entonces? ¿Te sumás?"
        
        "Lo pienso y te aviso."
        
        No le vas a avisar nada.
        
        ~ bajar_dignidad(1)
        ->->

// ============================================
// AGEISMO - "BUSCAMOS PERFILES JUNIOR"
// ============================================

=== busqueda_ageismo ===
// Tunnel: Experimentar el ageismo del mercado

Otra entrevista.
Esta vez presencial.

El entrevistador te mira.
Algo en su cara cambia.

* [...]
-

"¿Cuántos años de experiencia tenés?"

"Quince."

"Ah."

* [...]
-

El resto de la entrevista es un trámite.
Ya sabés que no te van a llamar.

Al final:

"Mirá, vamos a seguir buscando.
Estamos apuntando a perfiles más... junior."

"¿Junior con cinco años de experiencia requerida?"

Silencio.

"Bueno, junior en términos de... adaptabilidad."

* [...]
-

~ rechazos += 1

Adaptabilidad = joven.
Joven = que aguante más por menos.
Más por menos = explotación.

Salís.
El ascensor te muestra tu reflejo.
¿Cuándo te pusiste viejo para el mercado?

{rechazos >= 5 && idea_no_soy_suficiente == false:
    # IDEA INVOLUNTARIA DISPONIBLE: "NO SOY SUFICIENTE"
    
    El pensamiento viene solo.
    No lo pediste.
    
    Quizás el problema sos vos.
    Quizás no servís.
    Quizás todos esos rechazos dicen algo.
    
    * [Aceptar la idea (peligroso)]
        ~ idea_no_soy_suficiente = true
        ~ aumentar_inercia(2)
        
        # IDEA INTERNALIZADA: "NO SOY SUFICIENTE"
        
        El mercado habló.
        Vos escuchaste.
        
        ->->
    * [Resistir el pensamiento]
        No.
        No vas a dejar que te coman la cabeza.
        Es el sistema. No sos vos.
        
        ~ subir_dignidad(1)
        ->->
- else:
    ->->
}

// ============================================
// IDEA: EL PROBLEMA NO SOY YO
// ============================================

=== busqueda_idea_el_problema_no_soy_yo ===
// Knot: Desbloqueo de idea positiva (requiere conexion alta + que alguien te lo diga)

{conexion < 6:
    // Sin suficiente conexión, nadie te lo dice
    ->->
}

// Con conexion >= 6, alguien te mira
Alguien te mira.

{vinculo == "elena":
    Elena.
    "M'hijo, ¿vos te creés que en el 2002 nos echaban porque éramos malos laburantes?"
}
{vinculo == "sofia":
    Sofía.
    "Che, no seas boludo. El sistema te necesita sintiéndote culpable."
}
{vinculo == "diego":
    Diego.
    "En Venezuela era igual. Siempre es culpa tuya, nunca del patrón."
}
{vinculo == "marcos":
    Marcos. Sí, Marcos.
    "Mirá, yo sé lo que es que te echen. Y te digo una cosa: no sos vos el problema."
}
{vinculo == "ixchel":
    Ixchel.
    "En mi país, los patrones también decían que era culpa nuestra. Nunca lo fue."
}

* [...]
-

"El problema no sos vos. Nunca fuiste vos."

# IDEA DISPONIBLE: "EL PROBLEMA NO SOY YO"

* [Internalizar]
    ~ idea_el_problema_no_soy_yo = true
    ~ disminuir_inercia(2)
    {idea_no_soy_suficiente:
        ~ idea_no_soy_suficiente = false
        La otra idea, la oscura, se desvanece.
        No del todo. Pero pierde fuerza.
    }
    
    # IDEA INTERNALIZADA: "EL PROBLEMA NO SOY YO"
    
    El mercado está roto. No vos.
    
    ->->
* [No estás convencido]
    Quisieras creerle.
    Todavía no podés.
    ->->

// ============================================
// SÍNTESIS DE BÚSQUEDA
// ============================================

=== busqueda_reflexion_domingo ===
// Knot: Reflexión del domingo sobre la búsqueda de empleo

{rechazos >= 1:
    Pensás en la semana.
    En los CVs enviados.
    En los silencios.
    En los rechazos.
    
    {rechazos >= 5:
        Cinco. Más de cinco.
        ¿Cuántos más van a ser?
    }
    {rechazos_ghosting >= 2:
        Y los que ni siquiera contestaron.
        Esos son peores.
        El rechazo al menos es una respuesta.
        El ghosting es nada.
    }
}

{rechazos_enviados >= 10:
    Mandaste montones de CVs.
    A empresas que no sabés si existen.
    A puestos que no sabés si son reales.
    Al vacío.
}

// What the búsqueda taught you
{rechazos_enviados >= 10:
    Una semana buscando laburo te enseñó algo.

    No lo que esperabas.

    No aprendiste a "venderte mejor" ni a "optimizar tu marca personal".

    Aprendiste que el sistema no te necesita.
    Y que eso no dice nada sobre tu valor.

    {ayude_en_olla:
        En la olla sí te necesitan.
        No por tu CV. Por tus manos.
    }
}

{rechazos_enviados >= 15 && not idea_no_es_individual:

    Quince postulaciones. Cero respuestas.

    Pero esta vez no te sentís inútil.
    Te sentís estafado.

    Porque viste los números.
    847 postulantes para un puesto.
    La mitad del sueldo que pagaban antes.
    "Beneficios: fruta en la oficina."

    No es que no valés.
    Es que el mercado necesita que creas que no valés.
    Así aceptás cualquier cosa.
    Así bajás el precio de tu laburo.
    Así la ganancia de alguien sube.

    ~ activar_no_es_individual()
    # IDEA DESBLOQUEADA: "NO ES SOLO MI PROBLEMA"
    # NOTIFICATION:info:Lo viste solo. Sin que nadie te lo diga.
}

La semana que viene, más de lo mismo.
O capaz que no.
Capaz que alguien contesta.

Capaz.

->->
