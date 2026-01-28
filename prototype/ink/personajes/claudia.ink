// CLAUDIA - La Burócrata
// ============================================

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
    ~ olla_en_crisis = true // Crisis real de recursos
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
