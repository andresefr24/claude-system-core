# Retro — el segundo loop

Regla del componente. El sistema se mejora a sí mismo. Esto es **diagnóstico, no contabilidad**: la retro no cuenta números, busca la enfermedad detrás de ellos.

## Cadencia y output

- **Semanal y acotada.** No es un hobby; es ~30 min del juicio de Andrés sobre propuestas ya digeridas.
- **Output:** propuestas **priorizadas por impacto** (cuánta fricción eliminan), cada una con su evidencia (apareció N veces). **Tope de 3 propuestas por retro** — fuerza priorización, evita el agujero de optimizar.
- La retro **propone, Andrés dispone.** Ningún cambio al proceso se aplica sin su OK.

## Las tres capas del diagnóstico

**1. Síntomas (se cuentan).** Lee `meta/friction-log.md` y las sesiones recientes. Métricas:
   - retries / v2 evitados
   - sesiones que arrancaron en frío
   - re-explicaciones pedidas ("for dummies")
   - overrides de routing

**2. Enfermedades (se infieren).** La retro está OBLIGADA a nombrar la causa raíz detrás de los síntomas recurrentes, no a parchear el síntoma. Ejemplo: "5 retries en firmas" es el síntoma; "no se fuerza leer el normativo" es la enfermedad. Toda propuesta apunta a una enfermedad, no a un síntoma.

**3. Auto-auditoría.** Revisa si las correcciones de retros pasadas movieron su métrica objetivo (mirar el `CHANGELOG.md` y comparar con el friction-log posterior). Un fix que NO movió la aguja es la prueba de un diagnóstico fallido —se trató un síntoma— y se reabre.

## Barrido del vault

La retro también hace el barrido periódico del vault que el capture deja pendiente: a grosso modo, revisar que lo guardado siga siendo durable y load-bearing, y señalar lo que sobra.

## Ejecución

Puede correr como subagente (lee friction-log + transcripciones, contexto pesado) y devolver solo las 3 propuestas, sin ensuciar la conversación principal. Idealmente disparada por una scheduled task semanal (ver nota de setup en el README del repo).

## Destino de las propuestas aprobadas

Lo aprobado se edita en el plugin, sube de versión, y se anota en `meta/CHANGELOG.md`. Las ideas que aún no cruzan el umbral van a `meta/skill-candidates.md`.
