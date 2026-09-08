# Ritual de cierre (capture)

Regla siempre activa. Al terminar una sesión o tarea, lo durable va al vault para que la próxima sesión arranque caliente. Esto sustituye al handoff manual.

## Qué se captura

- **Decisiones tomadas** → categoría decisiones (default `decisions.md`; el destino real lo
  declara el `CONVENTIONS.md` del vault — ver el mapeo del ritual de apertura, v0.15.0).
- **Gotchas descubiertos** → categoría gotchas (default `gotchas.md`; ídem).
- **Cambio de estado** → actualizar el estado vigente (default `active-context.md`).
- **Hilos abiertos** → en el estado vigente (lo que hay que retomar — el reemplazo del handoff).
  Nombrar el caso y su consecuencia, no enumerar pendientes: «un usuario con colección, que es el
  que cambia el plan» disparó; «faltan casos por probar» no habría disparado (visto 08-11).
- **El tope del estado vigente se respeta al escribir, y es el paso que decide.** El estado vigente
  admite **3 ítems**, los de la próxima sesión (ver el ritual de apertura). Si el delta mete un
  cuarto, **el cierre no lo añade: propone cuál de los cuatro sale**, y sale al log de deuda
  técnica o al archivo, nunca al propio estado. Añadir es gratis y quitar exige decidir, así que si
  el cierre no fuerza esa decisión no la fuerza nadie y el fichero crece hasta doler.
- **Oportunidades de mejora**, según de qué sean:
  - del **proceso** (el flow falló, esto se podría automatizar) → `meta/friction-log.md` del repo del sistema (`claude-system`).
  - del **proyecto** (deuda técnica, ideas) → vault del proyecto.

## Control: proponer, no escribir

Al cerrar, PROPÓN los deltas como una lista breve y espera aprobación de Andrés antes de tocar el vault. La aprobación es la auditoría humana en la entrada. No escribas nada al vault sin el OK.

## Grep antes de proponer (v0.15.0)

Antes de proponer un delta, **grepear el vault por su idea** (dos o tres términos, no leer el
fichero entero). Si hay acierto, el delta no es "añadir" sino "afilar lo que ya está" — que
además suele ser mejor entrada. El gate humano no protege contra duplicados: Andrés aprueba una
descripción de una línea y no puede saber si ya existe; solo el grep lo sabe. Un duplicado
envenena el retrieval — grep devuelve las dos copias con el mismo peso.

Razón (2026-08-10): un delta aprobado resultó estar escrito en `working-preferences` §Tools desde
el 18-05. El capture proponía contra la memoria de la sesión, no contra el vault — "no lo he
visto" se convertía en "no está".

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

## El cierre acaba en clear, y ése es el ciclo (v0.16.0, 2026-09-08)

**Escribir al vault no cierra el ciclo: cerrarlo es vaciar el contexto.** Una vez escritos los
deltas, el último paso del ritual es **dejar la conversación en cero**, para que la siguiente
arranque del vault y no del arrastre de ésta.

**Por qué el clear es la mitad que hace que el vault sirva.** Sin él el vault es un backup que nadie
lee: la sesión siguiente arranca con el contexto de la anterior todavía puesto, así que el retrieve
no aporta y el estado escrito no se estrena. Y hay un fallo peor que el coste de contexto: **en una
conversación larga el modelo deriva hacia lo último que recibió feedback positivo** (el clásico «si
todo ha ido bien, ¿te parece que haga esto?»), y ese desvío se convierte en el centro de atención.
El ciclo abrir/cerrar re-ancla el foco cada sesión en vez de dejar que lo decida la conversación.
Y cuando una conversación infinita se comprime, el modelo se queda con lo que quiere, medio al azar,
que es la otra cara de lo mismo.

**Quién lo ejecuta, dicho para no prometer lo que el agente no puede hacer.** El agente **no puede
vaciar su propio contexto**. Lo que hace el ritual es cerrarlo explícitamente: confirmar que los
deltas están escritos y **pedir el clear en la última línea**, nombrando en qué fichero quedó el
estado para que la próxima apertura sepa por dónde entrar. Un cierre que escribe y sigue
conversando no ha cerrado.

## Candidata a skill (no construir aún)

`capture-audit` — auditoría automática de lo que entra. Solo cuando la aprobación manual se vuelva cuello de botella por volumen.
