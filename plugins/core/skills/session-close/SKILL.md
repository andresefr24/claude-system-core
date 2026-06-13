---
name: session-close
description: Ejecuta el ritual de cierre (capture) al terminar una tarea o sesión de trabajo. Úsala cuando Andrés diga "cerremos", "terminamos por hoy", "guarda esto", "captura lo de hoy", o cuando una tarea sustantiva concluye. Propone los deltas durables para el vault del proyecto (decisiones, gotchas, cambio de estado, hilos abiertos) y espera aprobación antes de escribir; registra fricción del proceso en el friction-log. No aplica a charla casual.
---

# Ritual de cierre (capture)

Al terminar una tarea o sesión, aplica el ritual definido en `../../rules/session-close.md`.

Pasos:

1. Lee `rules/session-close.md` del plugin si no tienes su contenido en contexto.
2. Reúne los deltas durables: decisiones tomadas, gotchas descubiertos, cambio de estado de `active-context.md`, hilos abiertos.
3. Enruta las oportunidades de mejora: del proceso → `meta/friction-log.md` del repo del sistema; del proyecto → vault del proyecto.
4. PROPÓN los deltas como lista breve y espera aprobación de Andrés antes de escribir nada al vault.
5. Aplica el umbral: solo lo durable y load-bearing.
6. Registra cualquier fricción de la sesión (retry, re-explicación, override, hueco de contexto) en el friction-log, una línea por evento.

Regla siempre activa, no opcional.
