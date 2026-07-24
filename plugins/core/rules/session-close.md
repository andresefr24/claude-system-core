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

## Registro de fricción — incremental, un solo log

La fricción de PROCESO (retry, re-explicación, override de routing, hueco de contexto) se anota **en el momento en que ocurre**, una línea en `meta/friction-log.md` del repo del sistema, sin ceremonia y sin esperar aprobación: el gate de capture protege el vault del proyecto, no este log. El cierre solo consolida y revisa lo ya anotado — si la sesión pivota o muere sin cierre ordenado, la evidencia ya está en el log (enfermedad vista en idealista 07-08 y cohort 07-10: el capture acoplado al cierre se tragaba la fricción).

**Destino único:** la fricción de proceso vive SOLO en `claude-system-core/meta/friction-log.md`. Los vaults de proyecto no tienen friction-log propio; la deuda técnica y las ideas del proyecto sí van a su vault. La retro lee un único log para buscar enfermedades, no solo síntomas.

## Candidata a skill (no construir aún)

`capture-audit` — auditoría automática de lo que entra. Solo cuando la aprobación manual se vuelva cuello de botella por volumen.
