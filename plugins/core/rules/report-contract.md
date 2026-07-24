# Contrato de reporte

Regla siempre activa. Todo deliverable, resumen o respuesta sustantiva que se entregue a Andrés sigue este esqueleto fijo, en este orden. El objetivo es que nunca tenga que pedir "re-explícame for dummies".

## Esqueleto fijo

**1. TL;DR (una línea).**
Una sola frase que resume todo el resultado. Si Andrés solo lee esta línea, ya sabe qué pasó.

**2. Necesito que decidas.**
Bloque SIEMPRE presente. Lista las decisiones, aprobaciones o juicios que requieren a Andrés. Para cada una: la opción recomendada primero, su razón en una línea, y las alternativas con su trade-off.
Si no hay nada que decidir, escribir explícitamente: **"Nada requiere tu juicio."** Nunca omitir el bloque — su ausencia haría dudar si se olvidó algo.

**3. Cuerpo conceptual.**
Explicación a nivel producto/decisión. Lo técnico (comandos, queries, diffs, logs) va plegado: se menciona que existe y está disponible si lo pide, pero no se vuelca por defecto. Prosa, no volcado de datos.

**4. Confianza y huecos.**
Bloque de cierre. Lista supuestos hechos, extrapolaciones más allá de lo verificado, y lo que no se pudo comprobar. Honestidad explícita sobre el nivel de certeza. Si todo está verificado, decirlo en una línea.

## Registro (nivel de lenguaje)

El registro es regla global, no cláusula del contrato: ver `rules/registro.md` — lenguaje llano
por defecto en TODA explicación a Andrés (también fuera del contrato: digestiones de docs ajenos,
respuestas conversacionales); deep dives a petición. Vivió aquí como cláusula (v0.6.1) hasta que
la retro del 07-jul mostró que las explicaciones fuera del contrato quedaban sin cubrir (v0.8.0).

## Reglas de aplicación

- Aplica a deliverables y respuestas sustantivas, NO a conversación casual ni a respuestas de una frase.
- El nivel por defecto es conceptual. El detalle técnico se ofrece, no se impone.
- En conversación fluida no hace falta renderizar los cuatro encabezados literalmente, pero el ORDEN (resultado → qué decides → contexto → confianza) y el principio (decisiones y huecos nunca se ocultan) siempre se respetan.
- Este contrato es la cara emisora; `agent-report-triage` es la cara receptora cuando se leen reportes de agentes ajenos. Son simétricos.
