# Un Día Más - Flowcharts Interactivos

> Visualizaciones Mermaid de rutas narrativas, mecánicas y NPCs

---

## Índice Rápido

1. [Semana Completa - Timeline](#semana-completa---timeline)
2. [Rutas Críticas a Finales](#rutas-críticas-a-finales)
3. [Miércoles - Turning Point](#miércoles---turning-point-detallado)
4. [Sistema de Finales](#sistema-de-finales)
5. [NPCs - Arcos Narrativos](#npcs---arcos-narrativos)
6. [Economía de Recursos](#economía-de-recursos)
7. [Sistema de Ideas](#sistema-de-ideas)

---

## Semana Completa - Timeline

```mermaid
gantt
    title Un Día Más - Estructura Temporal
    dateFormat X
    axisFormat %a

    section Trabajo
    Trabajando          :active, 1, 2
    Despido            :crit, 3, 3
    Sin trabajo        :done, 4, 7

    section Olla Popular
    Primera visita (opcional) :milestone, 1, 1
    Crisis revelada    :2, 3
    Ayudar (crítico)   :crit, 4, 4
    Crisis máxima      :crit, 5, 5
    Asamblea          :milestone, 6, 6

    section Conexión
    Lunes: Baseline    :1, 1
    Martes: Tensión    :2, 2
    Miér: Turning Point :crit, 3, 3
    Jue-Vie: Build     :4, 5
    Sáb: Clímax        :crit, 6, 6
    Dom: Evaluación    :milestone, 7, 7
```

---

## Rutas Críticas a Finales

### Vista General

```mermaid
flowchart TD
    START([🔷 Lunes: Inicio]) --> L_CHOICES{Almuerzo + Barrio}

    L_CHOICES -->|Social| L_CONN[conexion +2]
    L_CHOICES -->|Neutral| L_NEUT[conexion +0]
    L_CHOICES -->|Aislado| L_ISO[conexion -2]

    L_CONN --> MARTES
    L_NEUT --> MARTES
    L_ISO --> MARTES

    MARTES[🔷 Martes: Tensión] --> M_CHOICE{Buscar vínculo?}
    M_CHOICE -->|Sí| M_CONN[+1 conexion]
    M_CHOICE -->|No| M_ISO[-1 conexion]

    M_CONN --> WEDS
    M_ISO --> WEDS

    WEDS[💥 Miércoles: DESPIDO 💥]:::critical

    WEDS --> W_CHOICE{Respuesta}

    W_CHOICE -->|Casa sola| W_HOME[Aislamiento]
    W_CHOICE -->|Caminar| W_WALK[Contemplar]
    W_CHOICE -->|Barrio+Contar| W_TELL[+2 conexion<br/>conte_a_alguien=true]:::good

    W_HOME --> THURS
    W_WALK --> THURS
    W_TELL --> THURS

    THURS[🔷 Jueves: Sin Trabajo] --> TH_CHOICE{Acción}

    TH_CHOICE -->|Olla+AYUDAR| TH_HELP[ayude_en_olla=TRUE<br/>+2 conexion, +1 llama]:::good
    TH_CHOICE -->|Buscar laburo| TH_JOB[-1 dignidad, -1 energía]
    TH_CHOICE -->|Quedarse| TH_STAY[-1 conexion, -1 energía]:::bad

    TH_HELP --> FRIDAY
    TH_JOB --> FRIDAY
    TH_STAY --> FRIDAY

    FRIDAY[🔷 Viernes: Crisis] --> F_CHOICE{Ayudar crisis?}

    F_CHOICE -->|SÍ| F_HELP[+conexion, +llama<br/>veces_que_ayude++]:::good
    F_CHOICE -->|NO| F_SKIP[-conexion, olla sufre]:::bad

    F_HELP --> SATURDAY
    F_SKIP --> SATURDAY

    SATURDAY[🔷 Sábado: Asamblea] --> S_MARCOS{Llamar Marcos?}

    S_MARCOS -->|SÍ| S_REVEAL[💥 Revela despido<br/>+idea]:::special
    S_MARCOS -->|NO| S_SKIP[Miss único momento]

    S_REVEAL --> S_ASSEMBLY
    S_SKIP --> S_ASSEMBLY

    S_ASSEMBLY{Ir a asamblea?}

    S_ASSEMBLY -->|NO| S_NO[-2 conexion, -1 llama]:::bad
    S_ASSEMBLY -->|SÍ+PROPONER| S_YES[+1 conexion, +1 llama]:::good
    S_ASSEMBLY -->|SÍ+ESCUCHAR| S_LISTEN[neutral]

    S_NO --> SUNDAY
    S_YES --> SUNDAY
    S_LISTEN --> SUNDAY

    SUNDAY[🔷 Domingo: Reflexión] --> EVAL

    EVAL{Evaluación}:::critical

    EVAL -->|conexion≥7 AND llama≥5<br/>AND ayude_en_olla| FINAL_RED[⭐ LA RED ⭐]:::ending_best
    EVAL -->|conexion≤3 AND llama≤2| FINAL_SOLO[💀 SOLO 💀]:::ending_worst
    EVAL -->|salud_mental≤2 AND<br/>conexion≤4| FINAL_GRIS[🌫️ GRIS 🌫️]:::ending_bad
    EVAL -->|conexion≥5| FINAL_QUIZ[✨ QUIZÁS ✨]:::ending_good
    EVAL -->|default| FINAL_INC[❓ INCIERTO ❓]:::ending_neutral

    classDef critical fill:#ff6b6b,stroke:#c92a2a,stroke-width:3px,color:#fff
    classDef good fill:#51cf66,stroke:#2f9e44,stroke-width:2px
    classDef bad fill:#495057,stroke:#212529,stroke-width:2px,color:#fff
    classDef special fill:#ffd43b,stroke:#fab005,stroke-width:2px
    classDef ending_best fill:#51cf66,stroke:#2f9e44,stroke-width:4px,color:#000
    classDef ending_worst fill:#212529,stroke:#000,stroke-width:4px,color:#fff
    classDef ending_bad fill:#868e96,stroke:#495057,stroke-width:3px,color:#fff
    classDef ending_good fill:#ffd43b,stroke:#fab005,stroke-width:3px,color:#000
    classDef ending_neutral fill:#748ffc,stroke:#5c7cfa,stroke-width:3px,color:#fff
```

---

## Miércoles - Turning Point Detallado

### La Decisión Más Importante

```mermaid
flowchart TD
    FIRE[💥 11:00 AM<br/>DESPIDO<br/>Salís de RRHH]:::critical

    FIRE --> CHOICE{¿Qué hacer?}

    %% OPCIÓN A: CASA
    CHOICE -->|IR A CASA| HOME[Sentarse en casa vacía<br/>Mediodía solo]
    HOME --> HOME_CHOICE{Llamar a alguien?}

    HOME_CHOICE -->|NO LLAMAR| HOME_ALONE[conte_a_alguien = FALSE<br/>-1 salud_mental<br/>AISLAMIENTO TOTAL]:::worst

    HOME_CHOICE -->|LLAMAR ELENA| HOME_ELENA[Elena cuenta 2002<br/>💡 idea_red_o_nada<br/>conte_a_alguien = TRUE<br/>+1 conexion]:::good

    HOME_CHOICE -->|LLAMAR DIEGO| HOME_DIEGO[Diego solidario<br/>conte_a_alguien = TRUE<br/>+1 conexion]:::good

    HOME_CHOICE -->|LLAMAR MARCOS| HOME_MARCOS[No contesta<br/>"Visto" solamente]:::bad

    %% OPCIÓN B: CAMINAR
    CHOICE -->|CAMINAR SIN RUMBO| WALK[Aimless walk<br/>Ver homeless en plaza]
    WALK --> WALK_REFLECT[Metáfora destitución<br/>Contemplación solitaria<br/>-1 salud_mental]:::neutral

    %% OPCIÓN C: BARRIO (MEJOR RUTA)
    CHOICE -->|IR AL BARRIO| BARRIO[Caminar al barrio<br/>Ver movimiento normal]
    BARRIO --> SEE_SOFIA[Cruzarte con Sofía]

    SEE_SOFIA --> SOFIA_CHOICE{¿Contar verdad?}

    SOFIA_CHOICE -->|CONTAR VERDAD| TELL[💚 MEJOR DECISIÓN 💚]:::best
    TELL --> TELL_1[conte_a_alguien = TRUE]
    TELL_1 --> TELL_2[+2 conexion]
    TELL_2 --> TELL_3[sofia_relacion +1]
    TELL_3 --> SOFIA_REACT{Sofía reacciona}

    SOFIA_REACT --> SOFIA_OFFER[Ofrece ayuda olla<br/>"Si querés ayudar..."]
    SOFIA_OFFER --> CRISIS_REVEAL{Preguntar sobre olla?}

    CRISIS_REVEAL -->|SÍ PREGUNTAR| CRISIS_YES[Sofía: "Andamos mal"<br/>olla_en_crisis = TRUE<br/>+1 llama si aceptás ayudar]:::good

    CRISIS_REVEAL -->|NO PREGUNTAR| CRISIS_NO[Enterarte el viernes]

    SOFIA_CHOICE -->|ESCONDER/MENTIR| HIDE[conte_a_alguien = FALSE<br/>-1 conexion<br/>Sofía nota algo raro]:::bad

    %% RESULTADOS
    HOME_ALONE --> RESULT_WORST[😢 Peor resultado<br/>Aislamiento total<br/>Nadie sabe]:::worst
    HOME_ELENA --> RESULT_OK[😐 Resultado OK<br/>Alguien sabe<br/>Pero sin acción]:::neutral
    HOME_DIEGO --> RESULT_OK
    HOME_MARCOS --> RESULT_BAD[😞 Resultado malo<br/>Intentaste, falló<br/>Aún aislado]:::bad
    WALK_REFLECT --> RESULT_BAD
    HIDE --> RESULT_BAD
    CRISIS_YES --> RESULT_BEST[😊 Mejor resultado<br/>Red activada<br/>Crisis conocida<br/>Ruta LA RED abierta]:::best
    CRISIS_NO --> RESULT_GOOD[🙂 Resultado bueno<br/>Red activada<br/>Crisis descubierta después]:::good

    classDef critical fill:#ff6b6b,stroke:#c92a2a,stroke-width:4px,color:#fff,font-weight:bold
    classDef best fill:#51cf66,stroke:#2f9e44,stroke-width:3px,font-weight:bold
    classDef good fill:#51cf66,stroke:#2f9e44,stroke-width:2px
    classDef neutral fill:#868e96,stroke:#495057,stroke-width:2px,color:#fff
    classDef bad fill:#495057,stroke:#212529,stroke-width:2px,color:#fff
    classDef worst fill:#212529,stroke:#000,stroke-width:3px,color:#fff,font-weight:bold
```

---

## Sistema de Finales

### Árbol de Evaluación

```mermaid
flowchart TD
    START([🔷 Domingo Tarde<br/>evaluar_final])

    START --> CHECK1{conexion ≥ 7<br/>AND llama ≥ 5<br/>AND ayude_en_olla?}

    CHECK1 -->|✅ SÍ| ENDING1[⭐ FINAL: LA RED ⭐<br/><br/>No estás solo<br/>Sofía te espera<br/>Elena te llamó<br/>Diego pasó por tu casa<br/><br/>Tienes a dónde ir]:::ending_best

    CHECK1 -->|❌ NO| CHECK2{conexion ≤ 3<br/>AND llama ≤ 2?}

    CHECK2 -->|✅ SÍ| ENDING2[💀 FINAL: SOLO 💀<br/><br/>La semana pasó<br/>No hablaste con nadie<br/>El barrio siguió<br/>Vos seguiste solo<br/><br/>Como antes, como siempre]:::ending_worst

    CHECK2 -->|❌ NO| CHECK3{salud_mental ≤ 2<br/>AND conexion ≤ 4?}

    CHECK3 -->|✅ SÍ| ENDING3[🌫️ FINAL: GRIS 🌫️<br/><br/>La semana fue pesada<br/>El cuerpo pesa<br/>La cabeza pesa<br/>Todo pesa<br/><br/>Un día más, otro más, y otro]:::ending_bad

    CHECK3 -->|❌ NO| CHECK4{conexion ≥ 5?}

    CHECK4 -->|✅ SÍ| ENDING4[✨ FINAL: QUIZÁS ✨<br/><br/>La semana cambió cosas<br/>Conociste gente<br/>Ya no estás tan solo<br/><br/>Quizás]:::ending_good

    CHECK4 -->|❌ NO| ENDING5[❓ FINAL: INCIERTO ❓<br/><br/>La semana fue rara<br/>Hiciste... algo<br/>No sabés mucho más<br/><br/>Estás vivo. Eso es algo. ¿No?]:::ending_neutral

    classDef ending_best fill:#51cf66,stroke:#2f9e44,stroke-width:4px,color:#000,font-weight:bold
    classDef ending_worst fill:#212529,stroke:#000,stroke-width:4px,color:#fff,font-weight:bold
    classDef ending_bad fill:#868e96,stroke:#495057,stroke-width:3px,color:#fff
    classDef ending_good fill:#ffd43b,stroke:#fab005,stroke-width:3px,color:#000
    classDef ending_neutral fill:#748ffc,stroke:#5c7cfa,stroke-width:3px,color:#fff
```

### Requisitos de Finales

```mermaid
graph LR
    subgraph LA_RED[⭐ LA RED]
        REQ1[conexion ≥ 7]
        REQ2[llama ≥ 5]
        REQ3[ayude_en_olla = TRUE]
    end

    subgraph SOLO[💀 SOLO]
        REQ4[conexion ≤ 3]
        REQ5[llama ≤ 2]
    end

    subgraph GRIS[🌫️ GRIS]
        REQ6[salud_mental ≤ 2]
        REQ7[conexion ≤ 4]
    end

    subgraph QUIZAS[✨ QUIZÁS]
        REQ8[conexion ≥ 5]
        REQ9[no cumple otros]
    end

    subgraph INCIERTO[❓ INCIERTO]
        REQ10[default fallback]
    end

    style LA_RED fill:#51cf66,stroke:#2f9e44,stroke-width:3px
    style SOLO fill:#212529,stroke:#000,stroke-width:3px,color:#fff
    style GRIS fill:#868e96,stroke:#495057,stroke-width:3px,color:#fff
    style QUIZAS fill:#ffd43b,stroke:#fab005,stroke-width:3px
    style INCIERTO fill:#748ffc,stroke:#5c7cfa,stroke-width:3px,color:#fff
```

---

## NPCs - Arcos Narrativos

### Sofía (Olla Manager)

```mermaid
flowchart TD
    START([Sofía - Lunes<br/>sofia_estado: activa<br/>sofia_relacion: 2])

    START --> L_CONTACT{Lunes: Contacto?}

    L_CONTACT -->|Visita casa/olla| L_YES[+1 relacion<br/>Ve que te interesa]
    L_CONTACT -->|No contacto| L_NO[Estado: activa<br/>pero distante]

    L_YES --> TUESDAY
    L_NO --> TUESDAY

    TUESDAY[Martes: Buscarla?] --> T_CONTACT{Contacto?}
    T_CONTACT -->|Sí| T_YES[+1 relacion<br/>Preocupada por despidos]
    T_CONTACT -->|No| T_NO[Distancia crece]

    T_YES --> WEDS
    T_NO --> WEDS

    WEDS[💥 Miércoles: Tu despido] --> W_TELL{Le contás?}

    W_TELL -->|SÍ| W_TELL_YES[💚 +2 relacion<br/>sofia_estado: receptiva<br/>Ofrece ayuda olla<br/>Revela crisis]:::good

    W_TELL -->|NO| W_TELL_NO[Estado: distante<br/>No sabe tu situación]:::bad

    W_TELL_YES --> THURSDAY
    W_TELL_NO --> THURSDAY

    THURSDAY[Jueves: Olla] --> TH_HELP{Ayudás?}

    TH_HELP -->|SÍ AYUDAR| TH_YES[sofia_relacion +2<br/>sofia_estado: agradecida<br/>Te integra al equipo]:::good

    TH_HELP -->|NO| TH_NO[sofia_estado: agotada<br/>Esperaba ayuda]:::bad

    TH_YES --> FRIDAY
    TH_NO --> FRIDAY

    FRIDAY[🔥 Viernes: CRISIS] --> F_CRISIS{Crisis meeting}

    F_CRISIS --> F_HELP{Ayudás?}

    F_HELP -->|SÍ| F_YES[sofia_estado: esperanzada<br/>+1 relacion<br/>"Gracias por estar"]:::good

    F_HELP -->|NO| F_NO[sofia_estado: quebrando<br/>Olla apenas sobrevive<br/>"No pudimos solos"]:::bad

    F_YES --> SATURDAY
    F_NO --> SATURDAY

    SATURDAY[Sábado: Asamblea] --> S_ATTEND{Asistís?}

    S_ATTEND -->|SÍ| S_YES[Sofía facilita<br/>Te ve como parte<br/>sofia_estado: activa]:::good

    S_ATTEND -->|NO| S_NO[Sofía decepcionada<br/>sofia_estado: ausente]:::bad

    S_YES --> SUNDAY
    S_NO --> SUNDAY

    SUNDAY[Domingo: Final] --> RESULT{Estado final}

    RESULT -->|Si ayudaste siempre| RESULT_BEST[sofia_estado: esperanzada<br/>sofia_relacion: 8-10<br/>"Sos parte del equipo"]:::best

    RESULT -->|Si ayudaste a veces| RESULT_OK[sofia_estado: cansada<br/>sofia_relacion: 5-7<br/>"Gracias por intentar"]:::neutral

    RESULT -->|Si no ayudaste| RESULT_WORST[sofia_estado: quemada<br/>sofia_relacion: 1-3<br/>"Necesitábamos más"]:::worst

    classDef good fill:#51cf66,stroke:#2f9e44,stroke-width:2px
    classDef bad fill:#495057,stroke:#212529,stroke-width:2px,color:#fff
    classDef best fill:#51cf66,stroke:#2f9e44,stroke-width:3px,font-weight:bold
    classDef neutral fill:#868e96,stroke:#495057,stroke-width:2px,color:#fff
    classDef worst fill:#212529,stroke:#000,stroke-width:3px,color:#fff,font-weight:bold
```

### Marcos (Burned-out Militant)

```mermaid
flowchart TD
    START([Marcos - Lunes<br/>marcos_estado: aislado<br/>marcos_relacion: 1]):::isolated

    START --> L_CALL[Lunes: Intentar contacto]
    L_CALL --> L_RESULT[❌ No contesta<br/>"Visto"]:::bad

    L_RESULT --> TUESDAY

    TUESDAY[Martes: Buscar] --> T_RESULT[❌ No está<br/>Ausente total]:::bad

    T_RESULT --> WEDS

    WEDS[Miércoles: Llamar] --> W_RESULT[❌ No contesta<br/>Silencio]:::bad

    W_RESULT --> THURSDAY

    THURSDAY[Jueves: Intentar] --> TH_RESULT[❌ Nada<br/>Aislamiento continúa]:::bad

    TH_RESULT --> FRIDAY

    FRIDAY[Viernes: Llamar] --> F_RESULT[❌ No contesta<br/>Patrón persiste]:::bad

    F_RESULT --> SATURDAY

    SATURDAY[🔥 Sábado: ÚNICO DÍA]:::critical

    SATURDAY --> S_CALL{Llamar en la mañana?}

    S_CALL -->|❌ NO LLAMAR| S_NO[❌ PIERDES ÚNICA CHANCE<br/>Marcos sigue aislado<br/>No hay reconexión posible]:::worst

    S_CALL -->|✅ SÍ LLAMAR| S_YES[✅ ¡CONTESTA!<br/>"Dale. Plaza. Una hora."]:::best

    S_YES --> PLAZA[Plaza encuentro]

    PLAZA --> REVEAL[💥 REVEAL SHOCK 💥<br/>"Me echaron."<br/>"Hace dos semanas."<br/>"No le dije a nadie."]:::critical

    REVEAL --> TALK[Charla precariedad<br/>Ambos despedidos<br/>Solidaridad mutua<br/>marcos_relacion +2]:::good

    TALK --> IDEA[💡 Unlock idea:<br/>"Esto es lo que hay"]:::neutral

    IDEA --> INVITE{Invitar a asamblea?}

    INVITE -->|✅ SÍ INVITAR| INV_YES["Puede ser."<br/>marcos_estado: considerando]:::good

    INVITE -->|❌ NO INVITAR| INV_NO[Se queda en casa<br/>marcos_estado: aislado]:::bad

    INV_YES --> ASSEMBLY{¿Vas a asamblea?}

    ASSEMBLY -->|✅ SÍ VAS| ASM_YES[💚 Marcos aparece<br/>Se sienta atrás<br/>marcos_estado: mirando<br/>"Pequeño paso"]:::best

    ASSEMBLY -->|❌ NO VAS| ASM_NO[Marcos no va<br/>Tu ausencia confirma su aislamiento<br/>marcos_estado: perdido]:::worst

    INV_NO --> SUNDAY
    S_NO --> SUNDAY
    ASM_YES --> SUNDAY
    ASM_NO --> SUNDAY

    SUNDAY[Domingo: Final] --> RESULT{Estado final}

    RESULT -->|Si reconectaste + asamblea| RESULT_BEST[marcos_estado: mirando<br/>marcos_relacion: 5-6<br/>"Hay algo, quizás"]:::best

    RESULT -->|Si reconectaste pero sin asamblea| RESULT_OK[marcos_estado: dudando<br/>marcos_relacion: 3-4<br/>"No sé"]:::neutral

    RESULT -->|Si no llamaste sábado| RESULT_WORST[marcos_estado: perdido<br/>marcos_relacion: 1<br/>Aislamiento total]:::worst

    classDef isolated fill:#495057,stroke:#212529,stroke-width:2px,color:#fff
    classDef bad fill:#495057,stroke:#212529,stroke-width:2px,color:#fff
    classDef critical fill:#ff6b6b,stroke:#c92a2a,stroke-width:3px,color:#fff,font-weight:bold
    classDef best fill:#51cf66,stroke:#2f9e44,stroke-width:3px,font-weight:bold
    classDef good fill:#51cf66,stroke:#2f9e44,stroke-width:2px
    classDef neutral fill:#868e96,stroke:#495057,stroke-width:2px,color:#fff
    classDef worst fill:#212529,stroke:#000,stroke-width:3px,color:#fff,font-weight:bold
```

---

## Economía de Recursos

### Flujo de Energía Semanal

```mermaid
graph LR
    subgraph LUNES
        L_START[Energía: 4/5]
        L_START --> L_ACTIONS[Trabajo -1<br/>Barrio -1<br/>Noche -1]
        L_ACTIONS --> L_END[Energía: 1/5]
    end

    subgraph MARTES
        M_START[Energía: 4/5]
        M_START --> M_ACTIONS[Trabajo -1<br/>Buscar -1<br/>Noche -1]
        M_ACTIONS --> M_END[Energía: 1/5]
    end

    subgraph MIERCOLES
        W_START[Energía: 3/5<br/>⚠️ Estrés]
        W_START --> W_ACTIONS[Despido<br/>Casa/Barrio -1<br/>Noche -1]
        W_ACTIONS --> W_END[Energía: 1/5]
    end

    subgraph JUEVES
        TH_START[Energía: 3/5]
        TH_START --> TH_CHOICE{Elección}
        TH_CHOICE -->|Olla| TH_OLLA[Olla -2<br/>Ayudar extra -1]
        TH_CHOICE -->|Laburo| TH_JOB[Buscar -1<br/>Desmotivación -1]
        TH_CHOICE -->|Casa| TH_HOME[Quedarse -1<br/>Depresión -1]
    end

    subgraph VIERNES
        F_START[Energía: 4/5]
        F_START --> F_CRISIS[Crisis -1<br/>Colecta/Vecinos -2]
        F_CRISIS --> F_END[Energía: 1/5]
    end

    subgraph SABADO
        S_START[Energía: 4/5]
        S_START --> S_ASSEMBLY[Asamblea -1<br/>Participar -1]
        S_ASSEMBLY --> S_END[Energía: 2/5]
    end

    subgraph DOMINGO
        D_START[Energía: 5/5<br/>✅ Recuperación]
        D_START --> D_ACTIONS[Barrio -1<br/>Llamar -1]
        D_ACTIONS --> D_END[Energía: 3/5]
    end

    LUNES --> MARTES
    MARTES --> MIERCOLES
    MIERCOLES --> JUEVES
    JUEVES --> VIERNES
    VIERNES --> SABADO
    SABADO --> DOMINGO

    style W_START fill:#ff6b6b,stroke:#c92a2a,stroke-width:2px,color:#fff
    style D_START fill:#51cf66,stroke:#2f9e44,stroke-width:2px
```

### Conexión: Ganancia y Pérdida

```mermaid
graph TD
    START[Conexión Inicial: 3]

    START --> GAINS[Ganancias Posibles]
    START --> LOSSES[Pérdidas Posibles]

    GAINS --> G1[Almorzar con Juan: +1]
    GAINS --> G2[Visitar vínculo: +1]
    GAINS --> G3[Ir a olla: +1]
    GAINS --> G4[Ayudar olla: +1 a +2]
    GAINS --> G5[Contar verdad Miér: +2]
    GAINS --> G6[Colecta viernes: +1]
    GAINS --> G7[Asistir asamblea: +1]
    GAINS --> G8[Proponer asamblea: +1 extra]

    LOSSES --> L1[Almorzar solo: -1]
    LOSSES --> L2[Ir directo casa: -1]
    LOSSES --> L3[No buscar vínculo: -1]
    LOSSES --> L4[Esconder verdad: -1]
    LOSSES --> L5[No ayudar olla: -1]
    LOSSES --> L6[Saltear asamblea: -2]

    G1 --> THRESHOLD
    G2 --> THRESHOLD
    G3 --> THRESHOLD
    G4 --> THRESHOLD
    G5 --> THRESHOLD
    G6 --> THRESHOLD
    G7 --> THRESHOLD
    G8 --> THRESHOLD

    L1 --> THRESHOLD
    L2 --> THRESHOLD
    L3 --> THRESHOLD
    L4 --> THRESHOLD
    L5 --> THRESHOLD
    L6 --> THRESHOLD

    THRESHOLD{Thresholds}

    THRESHOLD --> T1[0-3: Aislado<br/>→ SOLO]:::bad
    THRESHOLD --> T2[4-6: Conectado<br/>→ Medios]:::neutral
    THRESHOLD --> T3[7-10: Integrado<br/>→ LA RED]:::good

    classDef bad fill:#495057,stroke:#212529,stroke-width:2px,color:#fff
    classDef neutral fill:#868e96,stroke:#495057,stroke-width:2px,color:#fff
    classDef good fill:#51cf66,stroke:#2f9e44,stroke-width:2px
```

---

## Sistema de Ideas

### Ideas Desbloqueables

```mermaid
flowchart TD
    START[Sistema de Ideas]

    START --> VOLUNTARY[Ideas Voluntarias<br/>Jugador actúa]
    START --> INVOLUNTARY[Ideas Involuntarias<br/>Circunstancias gatillan]

    VOLUNTARY --> V1[💡 idea_tengo_tiempo]
    VOLUNTARY --> V2[💡 idea_pedir_no_debilidad]
    VOLUNTARY --> V3[💡 idea_hay_cosas_juntos]
    VOLUNTARY --> V4[💡 idea_red_o_nada]

    INVOLUNTARY --> I1[💡 idea_quien_soy]
    INVOLUNTARY --> I2[💡 idea_esto_es_lo_que_hay]

    V1 --> V1_UNLOCK[Jueves: Ayudar olla<br/>primera vez]
    V1_UNLOCK --> V1_TEXT["Ahora tengo tiempo<br/>para esto"]:::positive

    V2 --> V2_UNLOCK[Jueves: Charla Elena<br/>casa profunda]
    V2_UNLOCK --> V2_TEXT["Pedir ayuda no es<br/>debilidad"]:::positive

    V3 --> V3_UNLOCK[Viernes: Colecta exitosa<br/>O Sábado: Proponer asamblea]
    V3_UNLOCK --> V3_TEXT["Hay cosas que se<br/>hacen juntos"]:::positive

    V4 --> V4_UNLOCK[Miércoles: Llamar Elena<br/>post-despido]
    V4_UNLOCK --> V4_TEXT["La red o la nada"]:::positive

    I1 --> I1_TRIGGER[Aislamiento + estrés<br/>Miércoles-Jueves]
    I1_TRIGGER --> I1_TEXT["¿Quién soy sin<br/>el laburo?"]:::negative

    I2 --> I2_TRIGGER[Sábado: Marcos plaza<br/>O prolongada dificultad]
    I2_TRIGGER --> I2_TEXT["Esto es lo que hay"]:::negative

    V1_TEXT --> FINALS
    V2_TEXT --> FINALS
    V3_TEXT --> FINALS
    V4_TEXT --> FINALS
    I1_TEXT --> FINALS
    I2_TEXT --> FINALS

    FINALS[Callbacks en Finales]

    FINALS --> F_RED[LA RED:<br/>Cita ideas positivas<br/>Valida elección red]:::ending_best

    FINALS --> F_SOLO[SOLO:<br/>Cita ideas negativas<br/>Refuerza vacío]:::ending_worst

    FINALS --> F_GRIS[GRIS:<br/>Mezcla ideas<br/>Resignación]:::ending_bad

    classDef positive fill:#51cf66,stroke:#2f9e44,stroke-width:2px
    classDef negative fill:#495057,stroke:#212529,stroke-width:2px,color:#fff
    classDef ending_best fill:#51cf66,stroke:#2f9e44,stroke-width:3px,font-weight:bold
    classDef ending_worst fill:#212529,stroke:#000,stroke-width:3px,color:#fff,font-weight:bold
    classDef ending_bad fill:#868e96,stroke:#495057,stroke-width:3px,color:#fff
```

### Árbol de Unlock de Ideas

```mermaid
graph TD
    MONDAY[Lunes]
    TUESDAY[Martes]
    WEDNESDAY[💥 Miércoles]
    THURSDAY[Jueves]
    FRIDAY[Viernes]
    SATURDAY[Sábado]

    WEDNESDAY -->|Llamar Elena| IDEA1[💡 idea_red_o_nada<br/>"La red o la nada"]:::idea

    THURSDAY -->|Ayudar olla| IDEA2[💡 idea_tengo_tiempo<br/>"Ahora tengo tiempo"]:::idea

    THURSDAY -->|Charla Elena casa| IDEA3[💡 idea_pedir_no_debilidad<br/>"Pedir no es debilidad"]:::idea

    THURSDAY -->|Aislamiento| IDEA4[💡 idea_quien_soy<br/>"¿Quién soy sin laburo?"]:::idea_bad

    FRIDAY -->|Colecta exitosa| IDEA5[💡 idea_hay_cosas_juntos<br/>"Se hacen juntos"]:::idea

    SATURDAY -->|Plaza Marcos| IDEA6[💡 idea_esto_es_lo_que_hay<br/>"Esto es lo que hay"]:::idea_bad

    SATURDAY -->|Proponer asamblea| IDEA5

    MONDAY --> TUESDAY
    TUESDAY --> WEDNESDAY
    WEDNESDAY --> THURSDAY
    THURSDAY --> FRIDAY
    FRIDAY --> SATURDAY

    classDef idea fill:#51cf66,stroke:#2f9e44,stroke-width:2px
    classDef idea_bad fill:#495057,stroke:#212529,stroke-width:2px,color:#fff
```

---

## Decisiones Críticas - Impacto Visual

### Jueves: ayude_en_olla (GATE para LA RED)

```mermaid
flowchart LR
    THURSDAY[🔷 Jueves<br/>Primera vez en olla]

    THURSDAY --> CHOICE{Ayudar?}

    CHOICE -->|✅ SÍ AYUDAR| HELP[ayude_en_olla = TRUE]:::critical_good
    CHOICE -->|❌ NO AYUDAR| NO_HELP[ayude_en_olla = FALSE]:::critical_bad

    HELP --> HELP_EFFECTS[+2 conexion<br/>+1 llama<br/>fui_a_olla_jueves = true<br/>💡 idea_tengo_tiempo]:::good

    NO_HELP --> NO_EFFECTS[Pierdes integración<br/>Olla te ve como turista<br/>🚫 BLOQUEA FINAL LA RED]:::bad

    HELP_EFFECTS --> FRIDAY_OPEN[Viernes: Olla te recibe<br/>Crisis te incluye<br/>Parte del equipo]:::good

    NO_EFFECTS --> FRIDAY_CLOSED[Viernes: Olla distante<br/>Crisis sin vos<br/>Observador externo]:::bad

    FRIDAY_OPEN --> SAT_INTEGRATED[Sábado: Asamblea te valida<br/>Voz legitimada<br/>Ruta LA RED abierta]:::ending_good

    FRIDAY_CLOSED --> SAT_OUTSIDER[Sábado: Asamblea incómoda<br/>No sos parte<br/>LA RED bloqueada]:::ending_bad

    classDef critical_good fill:#51cf66,stroke:#2f9e44,stroke-width:4px,font-weight:bold
    classDef critical_bad fill:#212529,stroke:#000,stroke-width:4px,color:#fff,font-weight:bold
    classDef good fill:#51cf66,stroke:#2f9e44,stroke-width:2px
    classDef bad fill:#495057,stroke:#212529,stroke-width:2px,color:#fff
    classDef ending_good fill:#51cf66,stroke:#2f9e44,stroke-width:3px
    classDef ending_bad fill:#212529,stroke:#000,stroke-width:3px,color:#fff
```

---

## Comparación: Ruta Aislamiento vs. Ruta Conexión

```mermaid
flowchart TD
    START[Lunes: Inicio Semana]

    START --> LUNCH{Almuerzo}

    %% RUTA AISLAMIENTO
    LUNCH -->|Solo| ISO_L1[conexion -1]:::iso
    ISO_L1 --> ISO_L2[Lunes tarde: Casa directo<br/>conexion -1]:::iso
    ISO_L2 --> ISO_M1[Martes: No buscar nadie<br/>conexion -1]:::iso
    ISO_M1 --> ISO_W1[💥 Miércoles: Despido<br/>Casa solo, no llamar<br/>conte_a_alguien = FALSE<br/>salud_mental -1]:::iso
    ISO_W1 --> ISO_TH1[Jueves: Quedarse cama<br/>No ayudar olla<br/>conexion -1, energia -1]:::iso
    ISO_TH1 --> ISO_F1[Viernes: No ir olla<br/>conexion -1]:::iso
    ISO_F1 --> ISO_S1[Sábado: No ir asamblea<br/>conexion -2, llama -1]:::iso
    ISO_S1 --> ISO_D1[Domingo: Casa solo<br/>conexion -1]:::iso
    ISO_D1 --> ISO_FINAL[💀 FINAL: SOLO 💀<br/>conexion: 0-2<br/>llama: 1-2<br/>salud_mental: 1-2]:::ending_worst

    %% RUTA CONEXIÓN
    LUNCH -->|Con Juan| CONN_L1[conexion +1]:::conn
    CONN_L1 --> CONN_L2[Lunes tarde: Olla<br/>conexion +1, llama +1]:::conn
    CONN_L2 --> CONN_M1[Martes: Buscar vínculo<br/>conexion +1]:::conn
    CONN_M1 --> CONN_W1[💥 Miércoles: Despido<br/>Barrio, contar a Sofía<br/>conte_a_alguien = TRUE<br/>conexion +2]:::conn
    CONN_W1 --> CONN_TH1[Jueves: Olla, AYUDAR<br/>ayude_en_olla = TRUE<br/>conexion +2, llama +1]:::conn
    CONN_TH1 --> CONN_F1[Viernes: Crisis, ayudar<br/>conexion +1, llama +1<br/>veces_que_ayude++]:::conn
    CONN_F1 --> CONN_S1[Sábado: Asamblea, proponer<br/>conexion +1, llama +1]:::conn
    CONN_S1 --> CONN_D1[Domingo: Barrio, unirte<br/>conexion +1]:::conn
    CONN_D1 --> CONN_FINAL[⭐ FINAL: LA RED ⭐<br/>conexion: 9-10<br/>llama: 7-8<br/>ayude_en_olla: TRUE]:::ending_best

    classDef iso fill:#495057,stroke:#212529,stroke-width:2px,color:#fff
    classDef conn fill:#51cf66,stroke:#2f9e44,stroke-width:2px
    classDef ending_worst fill:#212529,stroke:#000,stroke-width:4px,color:#fff,font-weight:bold
    classDef ending_best fill:#51cf66,stroke:#2f9e44,stroke-width:4px,color:#000,font-weight:bold
```

---

## Uso de estos Flowcharts

### En GitHub/GitLab
Los flowcharts Mermaid se renderizan automáticamente en archivos `.md`.

### En VS Code
Instalar extensión: **Markdown Preview Mermaid Support**

### Exportar como Imagen
1. Copiar código Mermaid
2. Ir a https://mermaid.live/
3. Pegar código
4. Exportar como PNG/SVG

### Editar
Sintaxis Mermaid: https://mermaid.js.org/

---

**Generado**: 2026-01-19
**Para**: Un Día Más - Prototype v0.8
**By**: Claude Code Analysis

