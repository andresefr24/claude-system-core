# Ritual de cierre (capture)

Regla siempre activa. Al terminar una sesión o tarea, lo durable va al vault para que la próxima sesión arranque caliente. Esto sustituye al handoff manual.

## Qué se captura

- **Decisiones tomadas** → `decisions.md` (para no re-litigar ni contradecir).
- **Gotchas descubiertos** → `gotchas.md` (trampas y cómo se resolvieron).
- **Cambio de estado** → actualizar `active-context.md` (qué avanzó, qué quedó abierto).
- **Hilos abiertos** → en `active-context.md` (lo que hay que retomar — el reemplazo del handoff).
- **Oportunidades de mejora**, según de qué sean:
  - del **proceso** (el flow falló, esto se podría automatizar) → `meta/friction-log.md` del repo del sistema (`claude-system`).
  - del **proyecto** (deuda técnica, ideas) → vault del proyecto.

## Control: proponer, no escribir

Al cerrar, PROPÓN los deltas como una lista breve y espera aprobación de Andrés antes de tocar el vault. La aprobación es la auditoría humana en la entrada. No escribas nada al vault sin el OK.

## Umbral de calidad

Entra solo lo **durable y load-bearing**: lo que será cierto mañana y que algo o alguien necesitará leer. Lo efímero no entra. (La retro semanal hace el barrido periódico; la aprobación de Andrés es el gate de entrada.)

## Registro de fricción

Si durante la sesión hubo un retry, una re-explicación, un override de routing o un hueco de contexto, anótalo en `meta/friction-log.md` del repo del sistema, una línea por evento. La retro lo leerá para buscar enfermedades, no solo síntomas.

## Candidata a skill (no construir aún)

`capture-audit` — auditoría automática de lo que entra. Solo cuando la aprobación manual se vuelva cuello de botella por volumen.
