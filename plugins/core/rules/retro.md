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

## El loop de decisión

La retro no termina al entregar el reporte: termina cuando Andrés decide. Mecanismo:

1. Toda retro **deposita sus propuestas** como filas `pendiente` en `meta/pending-decisions.md`.
   Es el ÚNICO archivo que una corrida automática puede escribir — reglas y vault siguen
   intocables sin OK.
2. La retro siguiente **abre re-listando las pendientes** sin decidir, antes del diagnóstico
   nuevo. Las propuestas no mueren en silencio: o se deciden, o se re-presentan.
3. Cada decisión queda registrada en su fila: aprobada → versión del CHANGELOG; rechazada →
   razón en una línea (tan valiosa como una aprobada: evita re-proponerla).

Razón (retro 07-jul-2026): la retro corría automática y sus propuestas quedaban en limbo —
dos propuestas maduras pasaron 11+ días sin decisión mientras su evidencia seguía creciendo.

## Auditor externo: /insights

Si hay un informe de `/insights` (Claude Code) en `meta/insights/` que ninguna retro cruzó aún,
crúzalo: es un diagnóstico independiente sobre las mismas sesiones. Convergencia valida el
diagnóstico propio; divergencia señala lo que uno de los dos no ve. Si el informe más reciente
tiene >30 días, recordar a Andrés en una línea que toca correr `/insights` y dejar el HTML en
`meta/insights/`.

## Destino de las propuestas aprobadas

Lo aprobado se edita en el plugin, sube de versión, se anota en `meta/CHANGELOG.md` y se cierra
su fila en `meta/pending-decisions.md`. Las ideas que aún no cruzan el umbral van a
`meta/skill-candidates.md`.

**La entrega es parte del cambio, no un después** (aprendido con v0.10.0→v0.14.0: tres versiones de
reglas que ninguna sesión llegó a cargar porque Andrés seguía en 0.10.0). Al subir versión:
(a) `marketplace.json` se sincroniza a la misma versión que `plugin.json`, y (b) el mensaje de
cierre incluye el paso a paso de update (README, § Cómo se actualiza). En la auto-auditoría, un fix
que Andrés no instaló cuenta como NO shipeado — su ventana de medición empieza al instalarse, no
al escribirse.
