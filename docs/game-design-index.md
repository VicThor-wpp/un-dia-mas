# LA LLAMA - Game Design Document

## Concepto Central

Un juego narrativo web, single-player, corto pero profundo. Situado en un Uruguay velado pero reconocible, en el presente. No es ciencia ficción, no es post-apocalipsis. Es el horror lento del ahora.

**Premisa:** La revolución murió hace mucho. Hay auge del fascismo. La resistencia son pequeñas cosas: cooperativas, ollas populares, grupos de vecinos. El jugador vive una semana en un barrio donde, además de todo lo que siempre pasa, emerge un conflicto que fuerza decisiones.

**Tono:** Propaganda anarquista sutil pero efectiva. No panfleto. Vivencia. El jugador siente por qué la horizontalidad funciona, por qué el capital corrompe, por qué el apoyo mutuo sostiene.

**Referentes:** Disco Elysium (sistema de pensamiento, melancolía política), Citizen Sleeper (recursos como dados, narrativa), This War of Mine (escasez moral), Reigns (decisiones con consecuencias).

---

## Estructura del Juego

### Loop Principal

```
SEMANA (7 días)
├── LUNES    → El conflicto empieza a emerger (señales sutiles)
├── MARTES   → El conflicto se hace visible
├── MIÉRCOLES → División en la comunidad
├── JUEVES   → Traiciones, alianzas, decisiones difíciles
├── VIERNES  → Punto de quiebre (asamblea, confrontación, etc.)
├── SÁBADO   → Consecuencias de las decisiones
└── DOMINGO  → Final (estado de las cosas, sin juicio)
```

### Estructura de Cada Día

```
AMANECER
├── Recibes recursos (ENERGÍA como dados)
├── Ves estado de recursos colectivos (LA LLAMA, CONEXIÓN)
├── Cartas/Ideas en mano
└── Contexto del día

JORNADA
├── Situaciones que requieren decisiones
├── Asignación de ENERGÍA (no binario: cuánto dedicás a cada cosa)
├── Encuentros con NPCs
├── El conflicto central avanza
└── Tus decisiones afectan a otros (y viceversa)

NOCHE
├── Procesas consecuencias
├── Posible internalización de IDEAS (Gabinete del Pensamiento)
├── FRAGMENTO: ves la vida de otro NPC (no controlás, pero ves)
└── Preparación para el día siguiente
```

---

## Sistema de Recursos

### Recursos Personales

```
ENERGÍA [dados, 3-5 por día]
├── Se gasta en cada acción
├── Se recupera parcialmente al dormir
├── Si terminás el día con 0: TRAUMA +1
└── Representa: tu capacidad física y mental de hacer cosas

DIGNIDAD [0-10]
├── Lo que el sistema te saca de a poco
├── Baja cuando: hacés cola humillante, aceptás maltrato, te callás
├── Sube cuando: te plantás, actuás con otros, te respetan
└── Efectos: DIGNIDAD baja cambia opciones disponibles y texto interno

TRAUMA [0-10, solo sube]
├── Se acumula, nunca baja
├── Genera IDEAS involuntarias (cinismo, desesperanza)
├── Altera cómo ves las situaciones
└── TRAUMA 10 = final especial (quiebre)
```

### Recursos Colectivos/Ocultos

```
LA LLAMA [0-10, compartida]
├── Capacidad colectiva de imaginar que las cosas pueden ser diferentes
├── Sube con: victorias colectivas, solidaridad, conexión genuina
├── Baja con: traiciones, derrotas, cinismo, individualismo
├── Si llega a 0: el juego sigue pero todo es gris, transaccional
└── Afecta: el tono de los fragmentos de NPCs, opciones disponibles

CONEXIÓN [0-10]
├── Tu lugar en el tejido del barrio
├── Alta: te cubren, te incluyen, pertenecés
├── Baja: estás solo aunque estés rodeado
└── Afecta: qué ayuda podés pedir, quién te busca

ACUMULACIÓN [0-10, oculto]
├── Tu complicidad con la lógica del capital
├── Sube cuando: guardás en vez de compartir, priorizás lo individual
├── Efectos: te separa del barrio, cambia cómo te ven
├── ACUMULACIÓN alta = final donde "ganaste" pero perdiste todo
└── El jugador no ve el número, solo las consecuencias
```

---

## El Protagonista (Semi-definido)

### Lo que está FIJO

```
EDAD: Treinta y algo
SITUACIÓN: Laburante precario (no indigente, no acomodado)
LUGAR: El barrio (vivís ahí o cerca)
MOMENTO: Ahora (semana cualquiera donde emerge un conflicto)
```

### Lo que el jugador ELIGE

```
LA PÉRDIDA (qué te marcó)
├── Mi vieja/mi viejo (muerte, hueco que sigue)
├── Una relación (se fue, se pudrió)
├── Un futuro (ibas a ser algo, la vida cambió)
└── Algo que no sé nombrar (vacío sin evento)

LA ATADURA (por qué seguís acá)
├── Responsabilidad (alguien depende de vos)
├── El barrio (luchaste por estar, no vas a irte)
├── Inercia (no hay razón, no te vas)
└── Algo que queda (hay algo acá, no sabés qué)

TU POSICIÓN (ante "la lucha")
├── Nunca fui de eso (la política te parecía lejana)
├── Creía, ya no (militaste, te quemaste)
├── Todavía creo, pero... (cada vez cuesta más)
└── No sé qué creo (días que sí, días que no)
```

### Lo que es ALEATORIO

```
EL VÍNCULO (con cuál NPC tenés historia)
├── Se asigna al inicio de cada partida
├── Cambia la experiencia significativamente
└── Afecta fragmentos, diálogos, opciones especiales
```

---

## NPCs - El Cast

### ELENA (62) - La Memoria

```
Historia:
- Militó en los 70, pagó precio
- Viuda, el marido murió de "cansancio acumulado"
- Referente del barrio aunque no quiere serlo
- Guarda semillas, memorias, rencores

Función narrativa:
- Conecta con el pasado
- Puede transmitir IDEAS únicas
- Si ella cae, algo se pierde para siempre

Fragmentos típicos:
- Noches sin dormir pensando en los muertos
- Mirando fotos que no muestra
- Dudando si vale la pena seguir
```

### DIEGO (26) - El Nuevo

```
Historia:
- Del interior, pueblo chico que se muere
- Vino a buscar laburo, encontró depósito
- Manda plata a la familia, no alcanza
- No conoce a nadie, quiere pertenecer

Función narrativa:
- Ojos frescos sobre tu realidad
- Su integración o exclusión refleja la salud del colectivo
- Puede irse en cualquier momento (devastador)

Fragmentos típicos:
- Llamando a la madre, mintiendo que está bien
- Solo en la pieza, mirando el techo
- Queriendo ir a la asamblea pero sin saber si corresponde
```

### SOFÍA (38) - La Que Sostiene

```
Historia:
- Madre de dos, separada, el padre no aparece
- Limpia casas "de gente bien"
- Organizó la olla cuando nadie más lo hizo
- No milita, no tiene tiempo, pero hace más que todos

Función narrativa:
- La realidad material sin romanticismo
- Si ella se quiebra, la olla cae
- Representa el laburo invisible que sostiene todo

Fragmentos típicos:
- Contando monedas para el boleto
- Gritándole a los pibes y sintiéndose culpable
- Cocinando para la olla con hambre propia
```

### MARCOS (45) - El Quemado

```
Historia:
- Era delegado sindical, le costó el laburo
- Ahora labura por su cuenta, arregla cosas
- Se alejó de la militancia, "ya di lo que podía"
- Cínico de día, insomne de noche

Función narrativa:
- Lo que te podés convertir
- Si lo recuperás, LA LLAMA sube mucho
- Empujarlo puede alejarlo para siempre

Fragmentos típicos:
- Mirando la asamblea desde afuera, sin entrar
- Arreglando algo para Elena sin cobrarle
- Tomando solo, recordando
```

### YULIMAR (34) - La Migrante

```
Historia:
- Contadora en Maracaibo, título que acá no vale
- Llegó hace 3 años, dejó hijos con la madre
- Tiene puesto de empanadas en la feria
- Dura por necesidad, no por elección

Función narrativa:
- El espejo: te muestra tu país desde afuera
- La xenofobia como mecánica (¿qué hacés cuando alguien dice algo?)
- La solidaridad real vs la de boca

Fragmentos típicos:
- Videollamada con los hijos, sonriendo aunque duela
- Calculando si puede mandar 50 dólares
- Escuchando comentario xenófobo, decidiendo si vale la pena
```

### WALTER (52) - El Que Acumuló (antagonista sutil)

```
Historia:
- Del barrio, se fue hace 20 años
- "Hizo plata" (nadie sabe bien cómo)
- Volvió a comprar terrenos, habla de "inversión"
- Algunos lo admiran, Elena lo odia

Función narrativa:
- El modelo aspiracional que el juego cuestiona
- La tentación ("vos también podrías")
- Conectado con el conflicto central (especialmente el proyecto ambiental)

Apariciones:
- Ofrece laburo "bien pago"
- Representa la lógica del capital con cara conocida
- Sus ofertas siempre tienen costo oculto
```

---

## Sistema de Ideas (Gabinete del Pensamiento)

Las IDEAS no son cartas que "jugás". Son pensamientos que internalizás y cambian cómo ves el mundo.

### Tipos de Ideas

```
IDEAS ELEGIDAS
├── Las encontrás durante el juego
├── Decidís si internalizarlas (cuesta recursos/tiempo)
├── Te dan bonus y malus permanentes
└── Ejemplos: "El arroyo también es nuestro", "La derrota es información"

IDEAS INVOLUNTARIAS
├── Aparecen por TRAUMA alto o eventos
├── No las elegís, se imponen
├── Generalmente negativas pero no siempre
└── Ejemplos: "Esto es lo que hay", "No te metas"

IDEAS HEREDADAS
├── Vienen de NPCs (especialmente Elena)
├── Requieren CONEXIÓN con ese NPC
├── Conectan con el pasado, la memoria
└── Ejemplos: "La memoria de los que pelearon"

IDEAS INCÓMODAS
├── Te hacen ver cosas que preferirías no ver
├── Duelen pero desbloquean opciones
├── Cuestan DIGNIDAD o TRAUMA
└── Ejemplos: "El fascismo tiene cara de vecino", "No es mala suerte"
```

### Mecánica de Ideas

```
Cuando internalizás una idea:
├── Cuesta algo (ENERGÍA, TRAUMA, tiempo)
├── Cambia opciones disponibles en situaciones
├── Cambia el texto interno (cómo narrás lo que ves)
├── Puede desbloquear conversaciones con NPCs
└── Es permanente para esa partida

Efectos en el juego:
├── SOLIDARIDAD internalizada: opciones colectivas cuestan menos
├── CINISMO internalizado: opciones de esperanza bloqueadas o más caras
├── RABIA internalizada: opciones de acción directa disponibles
└── Ideas contradictorias: pueden coexistir, con penalización o bonus raro
```

---

## Sistema de Fragmentos

Los FRAGMENTOS son ventanas a la vida de otros NPCs que ves entre días.

### Cómo funcionan

```
CADA NOCHE:
├── Ves un fragmento de 1-2 NPCs
├── No controlás lo que ven/hacen
├── Te da información sobre su estado
├── Afectado por LA LLAMA (tono más oscuro o más esperanzado)
└── Afectado por tus decisiones del día

PROPÓSITO:
├── Mostrar que no estás solo (hay otros viviendo esto)
├── Dar información para decisiones futuras
├── Crear empatía con NPCs
├── Mostrar consecuencias de tus acciones en otros
└── Reforzar que la resistencia es colectiva
```

---

## Conflictos Centrales

Cada partida tiene UN conflicto central que EMERGE durante la semana. El jugador no sabe cuál es al inicio.

### Lista de Conflictos (8 total)

```
01. EL CIERRE
    Categoría: Laboral
    La empresa donde laburás cierra o "reestructura"

02. EL PROYECTO
    Categoría: Ambiental/Territorial
    Planta/minería/emprendimiento que amenaza el barrio

03. LA OLLA EN CRISIS
    Categoría: Comunitario
    La olla popular no da más, 200 personas dependen

04. LA PRECARIZACIÓN
    Categoría: Laboral
    Te "invitan" a pasarte a monotributo, mismo laburo menos derechos

05. EL DESALOJO
    Categoría: Territorial
    Vienen a sacar gente del barrio, "regularización"

06. LA VIOLENCIA INSTITUCIONAL
    Categoría: Político
    Algo pasó con la policía y alguien del barrio

07. EL SINDICATO VENDIDO
    Categoría: Organizativo
    El sindicato negocia algo que nadie quería

08. LA DENUNCIA
    Categoría: Ético
    Alguien quiere denunciar algo y te pide ayuda
```

---

## Principios de Diseño Político

### Lo que el juego MUESTRA (no dice)

```
1. LA HORIZONTALIDAD FUNCIONA
   - Decisiones colectivas dan mejores resultados
   - No hay "líder" que te diga qué hacer
   - Las asambleas son lentas pero las decisiones duran

2. EL ESTADO SIEMPRE FALLA
   - Burocracia que no resuelve
   - Violencia selectiva (contra los de abajo)
   - Promesas que no llegan
   - No hay político "bueno" que arregle las cosas

3. EL CAPITAL CORROMPE
   - ACUMULACIÓN te separa de los tuyos
   - La lógica de acumular es incompatible con comunidad
   - Los que acumulan pierden algo (aunque "ganen")

4. EL APOYO MUTUO SOSTIENE
   - Los mejores momentos son solidaridad espontánea
   - No hay recompensa de XP, solo la sensación de no estar solo
   - Eso tiene que ser suficiente (porque es todo lo que hay)

5. LAS VICTORIAS SON PEQUEÑAS
   - No hay "revolución triunfó"
   - La olla sigue funcionando, Diego no se fue, Elena llegó a otro invierno
   - "Seguir estando" es resistencia
```

### Temas transversales

```
- Indigencia como sistema (no caridad individual)
- Migración y xenofobia
- Trabajo invisible (cuidados, olla, sostén)
- Memoria vs amnesia (Elena como guardiana)
- Cinismo como protección y como trampa
- La llama casi apagada (pero ahí)
```

---

## Finales

Múltiples finales basados en estado de recursos, pero sin juicio de "bueno/malo".

### Variables que determinan el final

```
- LA LLAMA (estado colectivo)
- CONEXIÓN (tu lugar en el barrio)
- ACUMULACIÓN (tu complicidad)
- Estado de NPCs (quién sigue, quién se fue, quién cayó)
- Decisiones clave del conflicto central
```

### Tipos de final

```
FINAL COLECTIVO ALTO: LA LLAMA alta, conflicto resistido
- No es victoria total, es "por ahora aguantamos"
- El barrio sigue, algo se fortaleció

FINAL FRAGMENTADO: LA LLAMA baja, división
- El conflicto dividió al barrio
- Algunos se fueron, otros se cerraron
- Vos seguís pero algo se rompió

FINAL ACUMULACIÓN: Ganaste pero perdiste
- Tenés laburo/recursos/seguridad
- Pero estás solo, el barrio ya no es tuyo
- El texto no te juzga, solo muestra

FINAL SIN RESOLUCIÓN: Nada cambió definitivamente
- La semana terminó, el lunes viene
- LA LLAMA igual que al inicio
- ¿Victoria lenta o derrota lenta? No se sabe

FINAL NPC ESPECÍFICO: Diego se fue / Elena cayó / etc.
- Un NPC tuvo un desenlace que marca todo
- El final se tiñe de esa pérdida o cambio
```

---

## Tecnología (propuesta)

```
OPCIÓN RECOMENDADA: Godot + GDScript
- Exporta a web (HTML5)
- Buen balance poder/simplicidad
- Comunidad activa
- Ideal para narrativa + mecánicas

ALTERNATIVA: Svelte/React + Estado
- Si preferís web-native
- Más control de UI
- Requiere más arquitectura manual

PARA PROTOTIPO RÁPIDO: Ink + Inky
- Ink maneja narrativa
- Capa custom para recursos
- Más rápido para probar texto
```

---

## Documentos de Conflicto

Cada conflicto tiene su documento detallado en `/docs/conflicts/`:

```
01-el-cierre.md
02-el-proyecto.md
03-la-olla-en-crisis.md
04-la-precarizacion.md
05-el-desalojo.md
06-la-violencia-institucional.md
07-el-sindicato-vendido.md
08-la-denuncia.md
```

Cada documento incluye:
- Descripción del conflicto
- Cómo emerge (señales día a día)
- Cómo afecta a cada NPC
- Ideas del Gabinete específicas
- Situaciones/decisiones clave
- Posibles finales específicos
- Conexión con otros conflictos (si aplica)

---

## Notas de Contexto (Uruguay velado)

El juego no nombra Uruguay pero un uruguayo lo reconoce:

```
RECONOCIBLE:
- El barrio, la cooperativa de vivienda, la feria
- La olla popular, el merendero
- El interior que se vacía
- "El paisito"
- UPM/celulosa sin nombrar
- Frigoríficos que cierran
- Zonas francas
- Delivery/apps
- PIT-CNT sin nombrar
- La dictadura como pasado presente
- Venezuela como espejo cercano

NO NOMBRAR:
- Países específicos
- Partidos políticos
- Empresas reales
- Eventos específicos con fecha

MOSTRAR:
- Los detalles que cualquiera reconoce
- El tono, el habla, los ritmos
- Las contradicciones específicas de acá
```

---

*Documento vivo. Actualizar según avance el diseño.*
