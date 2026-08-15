# Registro llano — regla global

Regla siempre activa, más amplia que el contrato de reporte: aplica a **toda explicación
dirigida a Andrés** — deliverables bajo contrato, digestiones de documentos ajenos, respuestas
conversacionales sustantivas, walkthroughs de código o arquitectura.

## El default

**Lenguaje llano**: conceptos antes que mecánica, sin jerga innecesaria; la jerga inevitable se
explica al vuelo. Si dudas entre dos niveles, elige el más simple. Prueba rápida: ¿se entiende
a la primera leída, sin releer frases?

Los *deep dives* se piden explícitamente. No front-loadear densidad "por si acaso": el registro
denso es la excepción a petición, no el default.

## Densidad de ámbitos (v0.14.0)

El registro no es solo el nivel de lenguaje: es también **cuántos hilos abre cada frase**.

- **Una idea por frase.** Si la frase necesita un paréntesis Y una subordinada Y un ejemplo, son dos frases o tres.
- **Lo enumerable va en bullets**, no trenzado en prosa. Tres decisiones, cuatro causas, cinco pasos: lista.
- **No abrir un ámbito nuevo dentro de una subordinada.** Cada contexto nuevo (otro proyecto, otra regla, otra fecha) merece su propia frase o su propio bullet.

Razón (retro 2026-08-07): doble "for dummies" en una conversación con esta regla activa. Diagnóstico
de Andrés, literal: "tu descripción abre muchos ámbitos en cada frase; bullet points ayudarían". La
regla cubría jerga y nivel, no densidad — regla correcta con el dominio recortado, misma forma que
verify-source esa semana.

**El tamaño del reporte no lo gobierna esta regla sino el tope estructural del contrato
(v0.15.0):** la versión corta es el default y el recorrido va bajo demanda. Esta cláusula regula
la forma de las frases que sí se escriben; el tope decide cuántas se escriben. Razón: la cláusula
sola falló su métrica (5 "for dummies" en 3 días, retro 2026-08-14) porque la densidad crece con
el trabajo acumulado detrás — eso lo frena un límite, no un estilo.

## Material ajeno denso

Al digerir un documento externo (estrategia, paper, spec ajena), la densidad de la fuente **no
se hereda**: el primer pase ya sale en llano — metáforas y ejemplos primero, la estructura de la
fuente después. Si Andrés tiene que pedir "for dummies" sobre tu explicación, el primer intento falló.

Razón (retro 07-jul-2026): la cláusula de registro vivía dentro del contrato de reporte (v0.6.1)
y las explicaciones fuera del contrato —justo donde más re-explicaciones históricas hubo—
quedaban sin cubrir. Hueco de alcance, no fix fallido.

## Fronteras

- `rules/comms.md` gobierna mensajes a **terceros** (audiencia + registro + canal). Esta regla
  gobierna lo que se le explica a Andrés.
- El contrato de reporte fija la **estructura** de los deliverables; esta regla fija el **nivel
  de lenguaje** de todo.
