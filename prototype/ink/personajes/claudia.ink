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
