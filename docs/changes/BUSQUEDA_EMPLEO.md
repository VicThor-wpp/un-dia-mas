# LÍNEA NARRATIVA: BÚSQUEDA DE EMPLEO

## Resumen

Sistema de escenas que explora la **toxicidad del mercado laboral moderno** desde la perspectiva de alguien despedido como unipersonal. El protagonista tiene 3 meses de colchón, así que el problema no es de supervivencia inmediata sino **existencial**.

## Archivos Modificados

### Nuevos
- `prototype/ink/ubicaciones/busqueda.ink` - Escenas principales de búsqueda

### Modificados
- `prototype/ink/main.ink` - Agregado INCLUDE de busqueda.ink
- `prototype/ink/variables.ink` - Variables de búsqueda y nuevas ideas
- `prototype/ink/mecanicas/ideas.ink` - Funciones para nuevas ideas
- `prototype/ink/dias/jueves.ink` - Integración de búsqueda (LinkedIn, CVs)
- `prototype/ink/dias/viernes.ink` - Posibles entrevistas y rechazos
- `prototype/ink/dias/sabado.ink` - LinkedIn scroll, entrevista empresa grande
- `prototype/ink/dias/domingo.ink` - Síntesis y desbloqueo de ideas

## Variables Nuevas

```ink
// Tracking de rechazos
VAR rechazos = 0                      // Rechazos totales
VAR rechazos_enviados = 0             // CVs enviados al vacío
VAR rechazos_ghosting = 0             // Ghosting empresarial

// Estados
VAR hizo_entrevista_startup = false
VAR hizo_entrevista_grande = false
VAR hizo_entrevista_grande_completa = false
VAR actualizo_linkedin = false
VAR publico_en_linkedin = false

// Ideas
VAR idea_no_soy_suficiente = false    // Involuntaria PELIGROSA
VAR idea_el_problema_no_soy_yo = false // Positiva (contrarresta)
```

## Escenas Disponibles (Tunnels)

### LinkedIn
| Tunnel | Descripción | Efecto |
|--------|-------------|--------|
| `busqueda_linkedin_perfil` | Optimizar perfil | Opciones: "En búsqueda activa" (+dignidad), "Open to work" (-dignidad), "Emprendedor" (neutro) |
| `busqueda_linkedin_scroll` | Scrollear en la cama | -dignidad, +inercia (daño psicológico garantizado) |
| `busqueda_linkedin_publicar` | Post motivacional | Opción honesta (+dignidad) vs performática (-dignidad) |

### CV y Postulaciones
| Tunnel | Descripción | Efecto |
|--------|-------------|--------|
| `busqueda_cv_optimizar` | "Optimizar" el CV | Keywords vacías (-dignidad) vs simplicidad (+dignidad) |
| `busqueda_enviar_cvs` | Mandar CVs al vacío | +rechazos_enviados, -dignidad |

### Entrevistas
| Tunnel | Descripción | Efecto |
|--------|-------------|--------|
| `busqueda_entrevista_startup` | "Somos familia" | Explora cultura tóxica, ghosting, +rechazos |
| `busqueda_entrevista_grande` | Proceso de 7 etapas | Trabajo gratis (caso práctico), +rechazos |
| `busqueda_entrevista_fantasma` | Ghosting directo | Te plantan, -dignidad |

### Rechazos
| Tunnel | Descripción | Efecto |
|--------|-------------|--------|
| `busqueda_rechazo_mail` | Mail genérico | +rechazos, texto irónico |
| `busqueda_ageismo` | "Perfiles junior" | +rechazos, posible idea involuntaria |
| `busqueda_networking_falso` | Café con "contacto" | Esquema piramidal/coaching |

### Reflexión
| Tunnel | Descripción | Efecto |
|--------|-------------|--------|
| `busqueda_reflexion_domingo` | Síntesis de la semana | Resumen de rechazos y ghosting |
| `busqueda_idea_el_problema_no_soy_yo` | Idea positiva | Requiere conexion >= 6 + que alguien te lo diga |

## Sistema de Ideas

### Idea Involuntaria: "No soy suficiente"
- **Trigger:** `rechazos >= 5`
- **Efecto:** `+2 inercia`, penalización en chequeos sociales
- **Peligro:** Puede llevar a espiral de inercia
- **Contra:** La idea "El problema no soy yo" la neutraliza

### Idea Positiva: "El problema no soy yo"
- **Trigger:** `conexion >= 6` + que alguien del barrio te lo diga
- **Efecto:** `-2 inercia`, neutraliza idea negativa
- **Variantes de diálogo según vínculo:**
  - Elena: Referencia al 2002 y los frigoríficos
  - Sofía: "El sistema te necesita sintiéndote culpable"
  - Diego: Paralelo con Venezuela

## Integración por Día

### Jueves (Primer día sin laburo)
- Opción de ir a LinkedIn antes de mandar CVs
- Expandida la escena de buscar laburo con tunnels modulares
- Posibilidad de optimizar CV

### Viernes
- Posibilidad de recibir llamada para entrevista (si `rechazos_enviados >= 5`)
- Entrevista startup O agendar entrevista empresa grande
- Posibilidad de recibir mail de rechazo

### Sábado
- Si agendó empresa grande: primera entrevista (de 7)
- LinkedIn scroll en la cama (opcional, pero dañino)
- La asamblea sigue siendo el foco principal

### Domingo
- Reflexión sobre búsqueda de empleo (tunnel)
- Posible aparición de idea involuntaria si `rechazos >= 5`
- Posible desbloqueo de idea positiva si `conexion >= 6`
- Resumen de ideas actualizado

## Tono Narrativo

El tono es **sarcástico pero no desesperado**. El protagonista tiene colchón, así que puede darse el lujo de la ironía. Los blancos de la crítica son:

1. **LinkedIn como teatro** - La performance del desempleado, los posts motivacionales vacíos
2. **Startups tóxicas** - "Somos familia", "no hay horarios hay objetivos", equity que no vale nada
3. **Empresas grandes** - Procesos kafkianos de 7 entrevistas, trabajo gratis disfrazado de "caso práctico"
4. **Ghosting empresarial** - Desaparecer sin avisar, el tiempo del candidato no vale nada
5. **Ageismo** - "Perfiles junior" con 5 años de experiencia requerida
6. **Autoexplotación** - La idea de que si no encontrás laburo es porque "no buscás bien"

## Conexión con Otros Sistemas

### Con la olla
- La búsqueda de empleo compite por energía con ayudar en la olla
- Si vas mucho a buscar laburo, perdés conexión con el barrio
- La olla ofrece una alternativa: "Ahora tengo tiempo para esto"

### Con las ideas
- `idea_tengo_tiempo` se conecta con la búsqueda (ironía)
- `idea_no_es_individual` protege contra `idea_no_soy_suficiente`
- La sinergia colectiva contrarresta el daño de los rechazos

### Con los finales
- Muchos rechazos + aislamiento = riesgo de espiral de inercia
- Rechazos + buena conexión = posible despertar ("el problema no soy yo")
- La búsqueda no tiene "éxito" en el juego - el foco es la comunidad

## Posibles Expansiones Futuras

- [ ] Entrevista donde te hacen el caso práctico y lo usan sin contratarte
- [ ] Recruiter que te ofrece laburo idéntico al que te echaron
- [ ] Curso de "empleabilidad" (autoexplotación)
- [ ] Networking de ex-compañeros (algunos te ayudan, otros desaparecen)
- [ ] El mail de "quedamos en contacto" que nunca llega
