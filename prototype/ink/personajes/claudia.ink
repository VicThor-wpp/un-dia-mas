// CLAUDIA - La Violencia Administrativa
// ============================================
// Expandida: aviso temprano, humanización opcional, consecuencias

// === AVISO TEMPRANO (MIÉRCOLES) ===

=== claudia_aviso_miercoles ===
// Escena Miércoles: Llega el aviso

Sofía tiene un papel en la mano.
Lo lee tres veces.

"¿Qué es?", preguntás.

Te lo pasa.

"MINISTERIO DE DESARROLLO SOCIAL
AVISO DE INSPECCIÓN PROGRAMADA
Fecha: Viernes [fecha]
Hora: 10:00
Motivo: Verificación de cumplimiento normativo
y trazabilidad de insumos."

* ["¿Y esto qué significa?"]
    Sofía suspira.
    
    "Significa que viene la auditora.
    Y va a querer la lista."
    
    "¿Qué lista?"
    
    "Nombre, cédula y firma de cada persona que come acá."
    
    ~ sabe_de_claudia = true
    ->->

* ["Puedo ayudar en algo?"]
    "Rezar, capaz."
    
    Sofía intenta sonreír. No le sale.
    
    ~ sabe_de_claudia = true
    ->->

=== claudia_tension_jueves ===
// Escena Jueves: La tensión crece

La olla está rara hoy.
Sofía habla en voz baja con Ixchel.
Elena mira por la ventana.

"¿Qué pasa?", preguntás.

Diego se acerca.

"Mañana viene la del ministerio.
Van a pedir papeles. Trazabilidad.
Si no tenemos todo en orden..."

No termina la frase.

* ["¿Y qué van a hacer?"]
    "No sabemos. Sofía no quiere dar la lista.
    Dice que es vigilancia disfrazada de burocracia."
    
    "¿Y vos qué pensás?"
    
    Diego se encoge de hombros.
    "Pienso que el arroz no viene solo."
    
    ~ tension_olla = true
    ->->

* [No preguntar más.]
    Hay cosas que se sienten en el aire.
    El miedo es una de ellas.
    
    ~ tension_olla = true
    ->->

// === LLEGADA DE CLAUDIA (VIERNES) ===

=== claudia_llegada ===
// Escena Viernes mañana: Claudia aparece

Un auto gris estaciona frente a la olla.
Matrícula oficial.

Baja una mujer.
Traje. Carpeta. Cara de nada.

Sofía se tensa.
"La auditora."

Claudia camina como quien revisa una obra.
Toca las paredes. Mira los cajones.
Anota.

No saluda a nadie.
Nadie existe para ella.
Solo los números.

->->

=== claudia_primera_inspeccion ===
// Escena Viernes: Primera ronda de inspección

Claudia saca fotos.
De la cocina. De las ollas. Del depósito.

"¿Cuántos kilos de arroz recibieron este mes?"

Sofía busca un cuaderno.
"Cuarenta."

"Cuarenta. ¿Y cuántas raciones prepararon?"

"No llevamos cuenta exacta de—"

"Deberían."

Claudia anota algo.
El rasguido del lapicero suena a sentencia.

* [Intervenir.]
    "¿Hay algún problema?"
    
    Claudia te mira.
    Como quien mira una mancha en la pared.
    
    "No hay problema. Hay inconsistencias.
    Son cosas distintas."
    
    Sigue anotando.
    
    ~ claudia_hostilidad += 1
    ->->

* [Observar en silencio.]
    Dejás que Sofía maneje.
    No es tu pelea.
    Todavía.
    
    ->->

// === LA AUDITORÍA PRINCIPAL ===

=== claudia_la_auditoria ===
// Escena Viernes: El conflicto central

Claudia despliega su carpeta sobre la mesa de la cocina.
Pone alcohol en gel antes de tocar nada.

"Estuve revisando los números."

Mira a Sofía. Mira a Ixchel. Te mira a vos.

"Hay una inconsistencia del 30% entre los insumos entregados y las raciones declaradas.
O están tirando comida, o la están robando, o están inflando los números."

Sofía tiembla de rabia. "La gente repite, Claudia. Tienen hambre."

"La repetición no está contemplada en el protocolo. Una cédula, un plato."

Saca una planilla vacía.
# PAUSA

"Necesito nombre, cédula y firma de cada persona que comió hoy.
Si no está la lista para el lunes, se corta el suministro seco."

* [Negarse a entregar la lista.]
    "No somos policías, Claudia. No vamos a pedir documentos para dar de comer."
    
    Ella guarda la carpeta. Despacio.
    "Entonces no son una olla popular. Son un club privado financiado con plata pública."
    
    Se va.
    "El lunes sale la orden de cese."
    
    ~ claudia_hostilidad += 2
    ~ subir_dignidad(2)
    ~ olla_en_crisis = true
    ->->

* [Aceptar (Traición).]
    "Está bien. Vamos a pedir las cédulas."

    Sofía te mira con decepción.
    Ixchel deja de cocinar y se va al fondo.

    Claudia asiente. "Es lo correcto. Transparencia."

    Conseguiste el arroz.
    Perdiste el barrio.

    ~ lista_entregada = true
    ~ bajar_conexion(2)
    ~ aumentar_inercia(1)
    ~ unlock_idea(idea_numero_frio)
    ->->

* [Intentar negociar.]
    "¿No hay otra forma? Algo intermedio."
    
    Claudia suspira.
    
    "Hay una forma. Pueden hacer un registro anónimo.
    Solo cantidad. Sin nombres.
    Pero entonces pierden el estatus de programa social.
    Y el arroz que viene con él."
    
    Sofía: "O sea que nos das a elegir entre vigilancia o hambre."
    
    Claudia: "Yo no elijo nada. Aplico el protocolo."
    
    ~ claudia_hostilidad += 1
    ~ olla_en_crisis = true
    ->->

// === EL TUPPER ===

=== claudia_el_tupper ===
// Escena: Claudia ve a alguien llevarse comida

Claudia ve el tupper.

"¿Eso qué es?"

"Comida para mi abuela. No puede venir."

"El protocolo es claro.
Una cédula, un plato.
Consumo en el local."

Anota algo en la planilla.

"Si esto sigue pasando,
voy a tener que informar
irregularidades en la distribución."

El hambre convertido en infracción administrativa.
La solidaridad, en delito contable.

->->

=== claudia_el_desperdicio ===
// Escena: Claudia critica la cantidad de comida

Claudia mira el guiso.

"¿Cuánta carne le pusieron?"

Sofía: "La que teníamos."

"Eso es mucho para el cálculo base.
Están gastando insumos de tres días en uno."

Ixchel: "La gente tiene hambre."

"La gente siempre tiene hambre.
Por eso hay que administrar.
Si no, se termina antes."

* [Defender la porción.]
    "Si hay comida hoy, se come hoy.
    Mañana vemos mañana."
    
    Claudia te mira.
    
    "Esa es la mentalidad que genera dependencia."
    
    Anota algo.
    
    ~ claudia_hostilidad += 1
    ~ subir_dignidad(1)
    ->->

* [No decir nada.]
    Sofía sigue cocinando.
    Nadie le responde a Claudia.
    
    El silencio es una respuesta también.
    ->->

// === AMENAZA FINAL ===

=== claudia_amenaza_final ===
// Escena Viernes tarde: El ultimátum

Claudia cierra la carpeta.
Te mira.
Mira a Sofía.

"Voy a ser clara."

Saca un papel.
Sello oficial.

"Este lugar opera sin habilitación municipal.
Sin control bromatológico.
Sin registro de beneficiarios."

Sofía abre la boca.
Claudia la corta.

"Sé lo que van a decir. Que es solidaridad.
Que la gente tiene hambre.
Que el Estado no llega."

Guarda el papel.
# PAUSA

"El Estado soy yo.
Y estoy llegando."

* [Confrontarla.]
    "El Estado también somos nosotros, Claudia.
    O te olvidaste de quién paga tu sueldo."

    Claudia se ríe.
    Una risa fría.

    "Ustedes no pagan nada.
    Por eso estoy acá."

    ~ claudia_hostilidad += 2
    ~ subir_dignidad(1)
    ->->

* [Intentar negociar.]
    "¿Qué necesitás para dejarnos trabajar?"

    "La lista. Nombre, cédula, firma.
    De cada persona que comió acá esta semana."

    Sofía niega con la cabeza.

    "Si me dan la lista, les doy una semana más.
    Si no..."

    Deja la frase sin terminar.

    ~ olla_en_crisis = true
    ->->

* [No decir nada.]
    Dejás que Sofía hable.
    No es tu pelea.

    Todavía.

    ->->

// === MOMENTO DE HUMANIZACIÓN (OPCIONAL) ===

=== claudia_sola ===
// Escena opcional: Claudia sola en el auto
// Fragmento para mostrar (o no) su humanidad

{claudia_hostilidad >= 2:
    -> claudia_sola_maquina
- else:
    -> claudia_sola_humana
}

=== claudia_sola_maquina ===
// Versión: Claudia es pura máquina

Claudia en su auto.
Revisa las notas del día.

"Olla Nº 47. Irregularidades: múltiples.
Recomendación: cese de suministros."

Manda el mail.
Prende el auto.
Se va.

No piensa en las personas.
No hay personas.
Hay números que no cierran.

->->

=== claudia_sola_humana ===
// Versión: Un atisbo de humanidad

Claudia en su auto.
No prende el motor.

Mira la olla desde afuera.
La fila. Los gurises. Las ollas humeando.

"Carajo."

Piensa en su abuela.
En las historias del 2002.
En las ollas que la mantuvieron viva.

"No es lo mismo", se dice.
"Ahora hay protocolos. Controles."

Pero la imagen no se va.

Prende el auto.
Se va.

Mañana tiene que decidir.
Hoy prefiere no pensar.

->->

=== claudia_segundo_round ===
// Escena Sábado: Claudia vuelve a presionar

{claudia_hostilidad >= 1 && not lista_entregada:
    Claudia aparece de nuevo.
    Esta vez con otro papel.

    "Última oportunidad.
    La lista o cierro el lunes."

    Sofía mira a todos.
    Elena. Diego. Vos.

    "No."

    Claudia guarda el papel.
    # PAUSA

    "Bien. El lunes nos vemos en el juzgado."

    Se va.

    ~ claudia_hostilidad += 1
    ~ olla_en_crisis = true
    ~ subir_dignidad(1)
    ->->
- else:
    ->->
}

// === CONSECUENCIAS DE LA LISTA ===

=== claudia_domingo_lista_entregada ===
// Escena Domingo: Consecuencias si entregaste la lista

{lista_entregada:
    // Claudia ganó - hay lista
    El lunes llega la confirmación.
    "Suministros aprobados para la próxima semana."

    Pero el barrio no festeja.
    Saben lo que costó.

    Hay gente que dejó de venir.
    "No quiero que tengan mi cédula."
    
    La doña del fondo, la que traía a los nietos.
    Ya no viene.
    "No voy a firmar nada. Después te caen."

    * [...]
        Elena te mira.
        No dice nada.
        No hace falta.

        La olla sobrevive.
        Pero algo se rompió.

        ~ bajar_llama(1)
        ~ bajar_conexion(1)
        ->->
- else:
    ->->
}

=== claudia_domingo_sin_lista ===
// Escena Domingo: Consecuencias si no entregaste la lista

{not lista_entregada && claudia_hostilidad >= 2:
    // Claudia perdió - resistieron
    El domingo suena el teléfono.
    Es Sofía.

    "Claudia mandó una nota.
    Dice que tenemos hasta el miércoles
    para regularizar o nos cierran."

    Pausa.

    "Pero también dice algo más.
    Que hay un recurso. Una apelación.
    Elena conoce a alguien del municipio."

    * ["¿Vamos a pelear?"]
        "Siempre peleamos.
        Es lo único que sabemos hacer."
        
        ~ subir_dignidad(1)
        ~ subir_llama(1)
        ->->
    
    * ["¿Qué necesitan?"]
        "Gente. Firmas. Ruido.
        Que sepan que no nos vamos callados."
        
        ~ subir_conexion(1)
        ->->

    No es victoria. Es resistencia.

    ~ subir_dignidad(1)
    ->->
- else:
    ->->
}

=== claudia_consecuencias_largas ===
// Escena Domingo: Efectos secundarios de la lista

{lista_entregada:
    
    // Efectos negativos de haber entregado la lista
    
    Tiago no vino más.
    "Si me tienen fichado, me van a buscar."
    Tiene razón.
    
    La familia venezolana del fondo dejó de venir.
    Miedo a inmigración.
    
    El viejo que dormía en la plaza tampoco.
    No tiene cédula.
    "Una cédula, un plato."
    Sin cédula, sin plato.
    
    ~ bajar_conexion(1)
    ->->
- else:
    
    // Efectos de resistir
    
    "¿Escuchaste? No pidieron cédula."
    La voz corre por el barrio.
    
    Viene gente nueva.
    Gente que no venía por miedo.
    
    La olla está más llena.
    Y no hay arroz del ministerio.
    
    Pero hay algo más.
    Confianza.
    
    ~ subir_conexion(1)
    ->->
}

// === FRAGMENTO NOCTURNO ===

=== fragmento_claudia_oficina ===
// Claudia en su oficina, de noche

Claudia revisa planillas.
Números que no cierran.
Raciones que no cuadran.

Su jefe la presiona.
"Ordená esas ollas o las cerramos."

Ella sabe lo que significa cerrar.
Gente sin comer.

Pero no es su problema.
Su problema es el Excel.

Toma un café frío.
Sigue sumando.

Lo que no está en la planilla
no existe.

->->

=== fragmento_claudia_casa ===
// Claudia en su casa

Claudia llega a las diez.
Departamento vacío. Gato que maúlla.

Calienta algo en el microondas.
Come parada.

Mira el celular.
Mensajes del jefe.
"¿Cerraste lo de la olla 47?"

"Mañana", responde.

Se sienta.
El gato se le sube encima.

Por un momento, piensa en la vieja de la olla.
La que pelaba papas.
Le recordó a alguien.

"No es personal", se dice.
"Es el sistema."

Pero el sistema tiene cara.
Y es la suya.

Apaga la luz.
Mañana tiene que decidir.

->->

// === VARIABLES DE CLAUDIA ===
// claudia_hostilidad: nivel de conflicto con Claudia (0-5)
// sabe_de_claudia: el protagonista sabe de la auditoría
// tension_olla: hay tensión en la olla por la auditoría
// lista_entregada: se entregó la lista con nombres
// olla_en_crisis: la olla está en crisis por la auditoría
