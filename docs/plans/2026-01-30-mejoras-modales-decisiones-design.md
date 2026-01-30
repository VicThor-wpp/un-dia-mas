# Diseño: Mejoras en Modales y Decisiones Iniciales

**Fecha:** 2026-01-30
**Estado:** Aprobado

## Resumen

Mejoras de UX/UI en dos áreas:
1. **Modales del menú inicial** (Manual y Manifiesto) - Mejorar legibilidad
2. **Decisiones de creación de personaje** - Hacer más claras manteniendo la narrativa

---

## 1. Modal del Manifiesto

### Problema
- Texto justificado crea "ríos" de espacios blancos
- Fuente pequeña (0.95rem) para texto denso
- line-height excesivo con justify

### Solución: Estilo Editorial

**Cambios CSS:**
```css
.manifesto-body p {
    text-align: left;           /* En vez de justify */
    font-size: 1.05rem;         /* Más legible */
    line-height: 1.7;           /* Reducido de 1.8 */
    margin-bottom: 0;           /* Sin espacio entre párrafos */
    text-indent: 1.5em;         /* Indentación francesa */
}

.manifesto-body p:first-child {
    text-indent: 0;             /* Primer párrafo sin indentar */
}
```

- Mantener drop cap en primer párrafo
- Mantener párrafo final destacado

---

## 2. Modal del Manual

### Problema
- Mucha información condensada sin jerarquía visual clara
- Difícil saber dónde estás en el contenido

### Solución: Scroll con Mini-Nav Flotante

**Estructura:**
- Mini-nav flotante a la derecha con indicadores numerados
- Cada sección tiene `id` para navegación
- Indicador activo se resalta según posición de scroll
- Click hace scroll suave a la sección

**Secciones (6):**
1. ¿De qué va?
2. Cómo se juega
3. Recursos
4. Dados
5. Guardar
6. Importante

**Cambios CSS:**
- Secciones con más espacio (`2rem` gap)
- Separadores más sutiles
- Mini-nav con posición sticky

---

## 3. Decisiones de Creación de Personaje

### Problema
- Opciones poéticas pero no siempre claras sobre qué se elige
- Encabezados ambiguos (ej: "ALGO FALTA" en vez de "¿QUÉ PERDISTE?")

### Solución: Formato híbrido

**Patrón para cada pantalla:**
1. Encabezado claro que enmarca la decisión
2. Opciones con contexto directo + imagen poética (separados por em-dash " — ")
3. Revelación después de elegir que expande el significado

**Nota técnica:** Ink no soporta saltos de línea dentro de los corchetes de opción, por lo que se usa el separador em-dash (—) para dividir visualmente el contexto directo de la imagen poética.

### Pantallas Rediseñadas

#### 1. Género
```
# ¿QUIÉN SOS?

* [Hombre — El mundo te deja pasar sin preguntar.]
* [Mujer — El mundo te mide antes de dejarte pasar.]
* [No binario — El mundo no sabe dónde ponerte.]
```

#### 2. Raza/Etnia
```
# ¿QUÉ VE EL MUNDO CUANDO TE MIRA?

* [Piel clara, herencia europea — Nadie te para en la calle por el color.]
* [Piel morena, mezcla de todo — Lo suficiente para pasar. Casi siempre.]
* [Piel oscura, herencia que pesa — La policía te para más seguido. "Rutina", dicen.]
* [Rasgos de otra tierra, otro origen — Invisible o exótico, según el día.]
```

#### 3. Pérdida
```
# ¿QUÉ PERDISTE?

* [Perdí a alguien — Un plato que nadie más usa en la alacena.]
* [Perdí una relación — Una taza de café que sobra todas las mañanas.]
* [Perdí un futuro — Un diploma que junta polvo arriba del ropero.]
* [Perdí algo que no sé nombrar — Una foto donde no reconozco mi propia sonrisa.]
```

#### 4. Atadura
```
# ¿POR QUÉ TE QUEDÁS?

* [Por responsabilidad — Una alarma en el celular que dice "llamar a mamá".]
* [Por el barrio — La marca de mi altura en el marco de la puerta.]
* [Por inercia — Una valija que armé hace dos años y nunca abrí.]
* [Por algo que no sé explicar — El olor a pan de la panadería de la esquina.]
```

#### 5. Posición
```
# ¿Y MAÑANA?

* [Mañana va a ser igual — El mismo camino al laburo, las mismas baldosas flojas.]
* [Algo puede cambiar — Una planta que riego todas las mañanas.]
* [Ya vi esta película — Un mensaje de grupo que tengo silenciado.]
* [No sé qué creer — La gotera del techo que nunca arreglo.]
```

#### 6. Vínculo
```
# HAY ALGUIEN.

En el barrio hay gente. Pero un momento te vuelve siempre.

* [Sofía, la de la olla popular — Un tupper de guiso que apareció en tu puerta.]
* [Elena, la veterana — Un banco de plaza. "Mirá qué grande estás", te dijo.]
* [Diego, el que llegó hace poco — Un tipo con mochila, mirando un papel con una dirección.]
* [Marcos, el que se alejó — Un portón cerrado. Sabés quién vive ahí.]
* [Ixchel, la que no habla de más — Una mujer en la cocina de la olla. Trabaja rápido, seria.]
```

---

## Archivos a Modificar

1. `prototype/web/style.css` - Estilos de modales
2. `prototype/web/modules/start-screen.js` - Mini-nav del manual
3. `prototype/ink/main.ink` - Texto de decisiones iniciales
