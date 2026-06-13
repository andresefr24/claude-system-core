---
name: retro
description: Ejecuta la retro semanal de automejora del sistema. Úsala cuando Andrés diga "corramos la retro", "retrospectiva", "qué aprendió el sistema esta semana", o cuando la dispare una scheduled task semanal. Lee el friction-log y las sesiones recientes, distingue síntomas de enfermedades (causa raíz), audita si los fixes pasados funcionaron, y entrega máximo 3 propuestas priorizadas por impacto. Propone; Andrés dispone.
---

# Retro

Ejecuta el segundo loop según `../../rules/retro.md`.

Pasos:

1. Lee `rules/retro.md` del plugin si no tienes su contenido en contexto.
2. Considera correr como subagente (lee contexto pesado, devuelve solo las propuestas).
3. **Síntomas**: lee `meta/friction-log.md` y sesiones recientes; cuenta retries, arranques en frío, re-explicaciones, overrides.
4. **Enfermedades**: agrupa síntomas recurrentes y NOMBRA la causa raíz. Toda propuesta apunta a una enfermedad, no a un síntoma.
5. **Auto-auditoría**: revisa si los fixes de retros pasadas (en `CHANGELOG.md`) movieron su métrica; si no, reabre el diagnóstico.
6. Entrega **máximo 3 propuestas** priorizadas por impacto, con evidencia. Propone, no apliques sin OK de Andrés.
7. Haz el barrido a grosso modo del vault: señala lo que ya no es durable.
