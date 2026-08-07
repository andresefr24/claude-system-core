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

## Scrub de datos sensibles (v0.14.0)

**Último paso antes de todo write al vault, siempre**: barrer lo que se va a escribir buscando
nombres de clientes o cuentas reales, credenciales, API keys, URLs internas y datos que identifiquen
personas. Se genericiza ("un cliente enterprise", no el nombre) o se omite. Corre al final, justo
antes de escribir — no al destilar, porque la consolidación puede reintroducir lo que el primer
pase limpió.

Razón (insights 2026-08-05): nombres de clientes reales aterrizaron en una entrada de KB pese a
instrucción explícita de excluirlos; hubo que auto-corregir después. El gate de aprobación no lo
cazó porque la preview resume — el scrub tiene que mirar el texto final.

## Umbral de calidad

Entra solo lo **durable y load-bearing**: lo que será cierto mañana y que algo o alguien necesitará leer. Lo efímero no entra. (La retro semanal hace el barrido periódico; la aprobación de Andrés es el gate de entrada.)

## Registro de fricción — incremental, un solo log

La fricción de PROCESO (retry, re-explicación, override de routing, hueco de contexto) se anota **en el momento en que ocurre**, una línea en `meta/friction-log.md` del repo del sistema, sin ceremonia y sin esperar aprobación: el gate de capture protege el vault del proyecto, no este log. El cierre solo consolida y revisa lo ya anotado — si la sesión pivota o muere sin cierre ordenado, la evidencia ya está en el log (enfermedad vista en idealista 07-08 y cohort 07-10: el capture acoplado al cierre se tragaba la fricción).

**Destino único:** la fricción de proceso vive SOLO en `claude-system-core/meta/friction-log.md`. Los vaults de proyecto no tienen friction-log propio; la deuda técnica y las ideas del proyecto sí van a su vault. La retro lee un único log para buscar enfermedades, no solo síntomas.

## Sugerir el cierre: por producción, no por longitud (v0.14.0)

Sugerir cortar la sesión es una afirmación sobre el estado del trabajo — y se verifica como
cualquier otra (ver `verify-source`, punto 5: la longitud es una pasada, no una medida).

- **La referencia es la producción real**: commits de la sesión (`git log`), deliverables creados,
  decisiones movidas. No el número de turnos ni la sensación de "llevamos mucho".
- **La sugerencia nombra su superficie**: "llevamos 6 commits y 2 deliverables, pero los últimos
  N turnos no produjeron ninguno" es una sugerencia válida; "llevamos mucho rato" no lo es.
- **Señales legítimas de corte**: producción estancada con retries crecientes, o hilos abiertos
  que ya exceden lo que un cierre puede capturar bien.

Razón: petición directa de Andrés (2026-08-07) — las sugerencias de corte se apoyaban solo en la
longitud de la sesión, que no mide nada; commits y artefactos son la fuente fiable de qué se hizo.

## Candidata a skill (no construir aún)

`capture-audit` — auditoría automática de lo que entra. Solo cuando la aprobación manual se vuelva cuello de botella por volumen.
