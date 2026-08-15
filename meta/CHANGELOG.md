# Changelog — claude-system-core

La historia evolutiva del proceso. Cada cambio al flow vive aquí.

## v0.15.0 — 2026-08-14

- **Escalera de enforcement en `rules/patterns.md`**: una regla violada dos veces estando CARGADA
  no se re-escribe como más prosa — sube de vía (sustituto concreto "para <intención>, teclea Y",
  o gate determinista en la frontera de la acción). A la segunda violación, la entrada del
  friction-log propone el mecanismo y la retro lo encola; los builds encolados se revalidan contra
  el árbol al abordarse. Razón: retro 2026-08-14 — el fallo ya no es el loader sino el disparador;
  toda regla que falló la semana estaba cargada y leída ("«Nunca X» falló tres veces; «para este
  caso, teclea Y» funcionó a la primera").
- **Tope estructural en `rules/report-contract.md`** (+ puntero en `registro.md`): el reporte por
  defecto ES la versión corta — veredicto en una línea, "necesito que decidas" numerado, huecos; el
  recorrido solo bajo demanda; la versión de cinco líneas se escribe PRIMERO. Razón: el fix de
  densidad de v0.14.0 FALLÓ su métrica (5 "for dummies" en 3 días con la cláusula cargada) — la
  densidad crece con el trabajo acumulado y eso lo frena un límite, no un estilo. Diagnóstico
  reabierto y cerrado por otra vía.
- **Rituales por CATEGORÍAS, no ficheros** (`session-open.md`, `session-close.md`): las cuatro
  lecturas de apertura y los destinos de capture son categorías (estado vigente, normativos,
  decisiones, gotchas); el mapeo categoría→fichero lo declara cada vault una vez en su
  `CONVENTIONS.md` (proyecto→ESQUEMA, no solo proyecto→carpeta); sin declaración, se deduce y se
  deja rastro. Materializa el WATCH de la retro 08-07 (2ª aparición 08-10, mordió en apertura y
  cierre de la misma sesión).
- **Grep antes de proponer** en `session-close.md`: todo delta se grepea contra el vault antes de
  proponerse; el gate humano no protege contra duplicados, solo el grep. Razón: delta duplicado del
  08-10 (ya estaba escrito desde el 18-05).
- **Hilos abiertos con caso nombrado** en `session-close.md`: nombrar el caso y su consecuencia,
  no enumerar pendientes (el aviso «un usuario con colección, que es el que cambia el plan» disparó;
  «faltan casos por probar» no habría disparado — 08-11).
- Encolados lado-CC (mintstash), pendientes de build con revalidación previa: (a) `node -v` vs
  `.nvmrc` al arrancar rama código; (b) bloqueo mecánico de `npx vitest` → `npm test -- <fichero>`
  (hook PreToolUse); (c) disciplina git-escritura (add antes de mutar; sin `2>/dev/null` en writes;
  `git diff --cached --name-only` tras add con rutas).
- Retro 2026-08-14 registrada; `marketplace.json` sincronizado a 0.15.0.

## v0.14.2 — 2026-08-07 (tarde)
- **Canario de carga en `CLAUDE.md.template`**: primera comprobación de sesión, independiente del
  plugin — si las skills `claude-system-core:*` no aparecen, el plugin no cargó y se dice antes de
  continuar. Es el único mecanismo que sobrevive a un fallo total de carga: nada DENTRO del plugin
  puede avisar de que el plugin no cargó (v0.14.1 lo demostró: el hook vigilante estaba dentro del
  incendio). El CLAUDE.md de cada repo carga por su cuenta.
- **Paso de verificación de carga en README § Cómo se actualiza**: tras reiniciar, comprobar no solo
  la versión listada sino que el plugin CARGÓ (sin "Hook load failed", skills visibles).

## v0.14.1 — 2026-08-07 (tarde, hotfix de CC)
- **El manifiesto ya no declara `hooks/hooks.json`** (commit `c8e50e3`, hecho en la sesión de CC):
  el cargador nuevo de Claude Code rechaza referenciar el fichero estándar (se auto-carga) y el
  rechazo tumbaba EL PLUGIN ENTERO — contrato, rituales, routing y ambos hooks, sin ningún aviso
  más allá de un "Hook load failed" que nadie mira. La clave venía inofensiva desde v0.7.0; lo que
  cambió fue el cargador. Incidente: desde el reinicio post-update hasta el hotfix, cero reglas
  activas. Detalle en friction-log 08-07.

## Cambios de proceso del mismo bloque (van en v0.14.2)
- **La entrega como parte del release**: README § "Cómo se actualiza" (paso a paso canónico
  verificado en la sesión de CC) + cláusula en `rules/retro.md` — al subir versión se sincroniza
  `marketplace.json` y se entrega el paso a paso; **un fix no instalado cuenta como no shipeado**
  (su ventana de medición empieza al instalarse). Razón: Andrés corrió v0.10.0 durante toda la
  ráfaga v0.11–v0.14 — tres versiones de reglas que ninguna sesión llegó a cargar; misma enfermedad
  que v0.13.0 (lo que se carga ≠ lo que se escribe), un tramo más arriba. Addendum de corrección
  en `retro-2026-08-07.md`.
- **`/insights` como auditor externo de la retro**: carpeta `meta/insights/` (primer informe, el
  del 08-05, ya guardado), sección nueva en `rules/retro.md` y cruce cableado en la scheduled task.
  Razón: el informe llegó independientemente al mismo diagnóstico que la retro (premature
  completion); dos diagnósticos que convergen se validan mutuamente.
- `marketplace.json` re-sincronizado (iba por 0.12.0; 2ª deriva — la 1ª fue v0.8.0).

## v0.14.0 — 2026-08-07
- **Eje de capacidad en `rules/verify-source.md`** (punto 5 de la disciplina): antes de afirmar un
  número o diagnóstico, decir qué NO habría podido detectar el instrumento. Tres formas: una pasada
  no es una medida; verde solo dice lo que el check mira; si lo medido y lo observado se contradicen,
  duda del instrumento primero. Razón: retro 2026-08-07 — 5 fallos en una sesión (06-08) con la regla
  cargada; sus ejemplos eran todos de cobertura, ninguno de capacidad.
- **Cláusula de superficie nombrada en `rules/report-contract.md`**: toda afirmación load-bearing
  nombra en el texto qué superficie se consultó para verificarla, haciendo la omisión visible a ojo.
  Acotada a lo load-bearing. Razón: encargo de Andrés (08-05) — 3 afirmaciones falsas cazadas solo
  por él preguntando; las afirmaciones en prosa no tienen gate posible, solo visibilidad.
- **Cláusula de densidad de ámbitos en `rules/registro.md`**: una idea por frase; lo enumerable en
  bullets; no abrir un ámbito nuevo dentro de una subordinada. Razón: doble "for dummies" en la propia
  conversación de la retro con la regla activa — regulaba nivel de lenguaje pero no densidad. Diagnóstico
  de Andrés; materializada en pausa explícita de revisión (1ª aparición, sin esperar regla de tres).
- **Sugerir el cierre por producción, no por longitud** en `rules/session-close.md`: toda sugerencia
  de cortar la sesión se corrobora contra la producción real (commits, deliverables) y nombra su
  superficie; la longitud de la conversación no es evidencia. Razón: petición directa de Andrés
  (08-07); aplica el punto 5 de `verify-source` al propio estado de la sesión.
- **Scrub de datos sensibles** como último paso de capture (`session-close.md`) e ingesta
  (`ingest.md`, incluido el crudo conservado): nombres de clientes, credenciales, URLs internas y
  datos identificantes se genericizan u omiten antes de escribir al vault. Razón: insights 08-05 —
  nombres de clientes reales aterrizaron en una entrada de KB pese a instrucción explícita.
- **Setup antes de mirar** en la verificación de UI (`routing.md`): server limpio arrancado desde la
  raíz, viewport fijado y confirmado en el DOM, y solo entonces screenshot; móvil es pasada separada.
  Razón: insights 08-05 — fricción recurrente en 148 llamadas de browser (puerto ocupado, cwd
  equivocado, viewport a 375px auditando desktop).
- Propuesta 3 de la retro (mapa proyecto→vault en session-close/open) aprobada como **WATCH**:
  1ª aparición (daily AE 08-06), se materializa en 2ª. Registrada en `pending-decisions.md`.
- Backfill: entrada v0.13.0 escrita a posteriori (subió versión el 06-08 sin anotarse aquí;
  detectado por la retro 2026-08-07).

## v0.13.0 — 2026-08-06 *(entrada escrita el 08-07; la versión subió sin anotarse)*
- **Regla de patrones** (`rules/patterns.md`): antes de reparar, buscar la segunda instancia — una es
  un incidente, dos es un mecanismo. Inline en el template y en el CLAUDE.md de MintStash. Razón:
  friction-log 08-06 — 3 horas reorganizando docs de diseño sin cuestionar si el documento era el
  mecanismo; la capacidad de ver el patrón existía pero nada la invocaba.
- **Hook `rules-have-loaders.sh`** (SessionStart, callado si todo va bien): comprueba que cada fichero
  de `rules/` tenga vía de carga (skill, hook o inline) y que el CLAUDE.md desplegado lleve los bullets
  que el template declara. Con prueba negativa. Razón: `verify-source` llevaba 3 semanas en el template
  sin aterrizar en el CLAUDE.md de MintStash — el template no es lo que se carga; faltaba la entrega.

## v0.12.0 — 2026-08-01
- **Frontera de escrituras en repos montados** en `rules/routing.md`: las escrituras y git sobre un
  repo real montado van por Claude Code / Mac; el sandbox de Cowork queda para lecturas y para lo que
  no toca la infra del repo. Razón: fricción del mount ×3 (locks de git 07-25, `rm` de archivos 07-25,
  `.claude/` protegido + huérfano al construir `anomaly-debug` 08-01) → cruzó la regla de tres. No es
  imposible desde Cowork (bash crea + `allow_cowork_file_delete` borra), pero es semi-seguro y frágil.

## v0.11.0 — 2026-08-01
- **Regla base `verify-source`** (`rules/verify-source.md`, siempre activa) + wiring en
  `CLAUDE.md.template`: no afirmar un diagnóstico o dato con fuente accesible (BD, logs, código,
  estado de deploy, normativo) sin verificarlo antes; toda explicación de un síntoma es una hipótesis
  hasta confirmarla. Extiende el "nunca de memoria" (que solo cubría leer el normativo del vault) a
  diagnósticos y hechos. Razón: retro 2026-08-01 — la enfermedad "explicar de memoria en vez de
  verificar" (friction-log 16, 17-jul; 2/3) es un hueco de comportamiento BASE; Andrés eligió atacarla
  en su tier siempre-activo en vez de confiar en un skill *triggered* que no dispara justo cuando el
  modelo no reconoce que debe verificar. La regla es genérica y portable: describe el helper de forma
  abstracta ("un proyecto puede proveer un skill-procedimiento para el caso reconocido"); los helpers
  concretos (p. ej. el trust-debugging de mintstash) son instancias que viven en cada proyecto, no
  dependencias de la regla — nada de este plugin nombra un artefacto de un proyecto concreto.
- Retro 2026-08-01 registrada en `pending-decisions.md`: auditoría de la ráfaga v0.7.0–v0.10.0
  ejecutada (sin regresiones; caveats de hook SessionStart y cadencia del loop → watch); hueco de
  capture fuera de mintstash aprobado como watch; skill-candidates de mintstash decididos (#1 prompt-writing
  promote con venue CC-side por revisar, #2 visual audit demote, #3 trust-debugging promote reencuadrado
  como esta regla + helper).

## v0.10.0 — 2026-07-25
- **Design gate** en `rules/routing.md`: toda tarea que crea o muta estructura (modelo de datos,
  tabla/vista/flag, read path, contrato público) expone primero 2-3 opciones con tradeoffs —o el
  modelo más simple posible— e invita la intención arquitectónica de Andrés antes de codificar.
  Razón: retro 2026-07-17 — oracle-price se construyó como migración one-way de 3992 filas y se
  rehizo como flag que era la intención de Andrés desde el inicio (friction-log 16-jul).
- Retro 2026-07-17 registrada en `pending-decisions.md`: propuesta 1 (write de la retro) ya
  resuelta por v0.8.0; propuesta 2 (remote mintstash) aprobada con resolución raíz fuera del
  plugin (Andrés autentica el remote); propuesta 3 → esta versión.
- Scheduled task `retro-semanal-sistema` alineada con v0.8.0: su prompt prohibía todo write;
  ahora permite el único write autorizado (`meta/pending-decisions.md` + `meta/retro-YYYY-MM-DD.md`).

## v0.9.0 — 2026-07-25
- **Verificación de UI en navegador** codificada en `rules/routing.md`: declarar siempre el viewport
  real alcanzado (resize_window ~500px; emulación ~312px, no 390) y verificar limitaciones de tooling
  contra el estado presente antes de proponer workarounds. Razón: viewport cap ×2 en cohort 07-10;
  la parte "nunca localhost" quedó fuera (rechazada 07-07, premisa falsa).
- **Capture incremental de fricción + log único** en `rules/session-close.md`: la fricción de proceso
  se anota en el momento (sin gate de aprobación — el gate protege el vault, no el log) y el cierre solo
  consolida; destino único `claude-system-core/meta/friction-log.md`, los vaults de proyecto no tienen
  friction-log propio. Razón: idealista 07-08 murió sin OK y su fricción se perdió; cohort 07-10 no
  loggeó; apareció un log paralelo en `tech-knowledge/meta/`.
- Retro 2026-07-25 registrada en `pending-decisions.md` (3 propuestas: 1 ya resuelta por v0.8.0, 2 aprobadas).

## v0.8.0 — 2026-07-25
- **Loop retro→decisión cerrado**: nuevo `meta/pending-decisions.md` (buzón de propuestas con decisión
  registrada), wiring en `rules/retro.md` (la retro deposita ahí — único write permitido a la corrida
  automática — y re-lista pendientes al abrir) y en `rules/session-open.md` (aviso de una línea si hay
  pendientes >1 semana). Razón: retro 07-jul — dos propuestas maduras pasaron 11+ días en limbo porque
  el flujo terminaba en el reporte; una retro automática sin canal de decisión degenera en informe que nadie lee.
- **Registro llano promovido a regla global** (`rules/registro.md`): cubre toda explicación a Andrés,
  incluidas digestiones de material ajeno denso — no solo deliverables bajo contrato. El contrato
  conserva un puntero. Razón: doble "for dummies" post-v0.6.1 en digestión de doc externo — hueco de
  alcance de la cláusula, no fix fallido.
- Propuesta 3 de la retro 07-jul ("UI local → deploy a preview") **rechazada**: premisa invalidada por
  Andrés (Claude-in-Chrome sí accede a localhost). Corrección anotada en el friction-log.
- `marketplace.json` re-sincronizado a la versión del plugin (estaba en 0.6.1).

## v0.7.0 — 2026-07-25
- **Primer tier determinista de enforcement**: hook `SessionStart` (`hooks/vault-freshness.sh` + `hooks/hooks.json`).
  Corre siempre al abrir sesión, localiza el vault en disco e inyecta su verdad de tierra (HEAD, ficheros clave
  con marca de FALTA, identidad esperada del proyecto) más los guards de conector y de snapshot desfasado.
  Razón: la enfermedad dominante de la retro (semana 19–26 jun) fue "el vault canónico no es lo que se consume"
  (`miss-vault ×4`, incl. snapshot desfasado sin people.md y Gmail apuntando a landbot.io). No es dilución de
  prosa —el modelo NO puede detectar staleness/identidad leyendo—, así que la prosa nunca lo arreglaría: exige
  un tier determinista. Distinto del hook general de enforcement, que sigue APARCADO (ver skill-candidates).
- **Regla de comms** (`rules/comms.md`) + wiring en `routing.md` (fila Docs → mensajes a humanos).
  Audiencia + registro + canal como inputs de primera clase antes de redactar; registro venezolano al equipo,
  español llano hacia fuera; enforcement real = persistir correcciones en `working-preferences.md`.
  Razón: cruzó la regla de tres (Security app, Cohort, Influencer en una semana). Es regla dentro de Docs, no rama nueva.
- Caveat de runtime registrado: los hooks `SessionStart` son feature de Claude Code; su disparo en Cowork no está
  garantizado. El aviso de "vault vacío" de `session-open.md` sigue siendo el respaldo advisory donde el hook no corra.

## v0.6.1 — 2026-06-24
- Cláusula de **registro** añadida al contrato de reporte: por defecto lenguaje llano (conceptos
  antes que mecánica, sin jerga gratuita); los deep dives se piden explícitamente.
- Razón: cierra la causa raíz de los "for dummies" recurrentes — el contrato fijaba estructura pero no registro.

## v0.6.0 — 2026-06-24
- **Inception** (`rules/inception.md`) + skill cargadora `project-init`. Arranque consistente de
  proyectos nuevos: scaffold del vault, siembra de active-context, cableado de superficie, normativos.
- Añadido `templates/cowork-project-instructions.md` — cierra el hueco detectado en el test
  (Cowork necesita instrucciones a nivel de Proyecto, no por conversación).
- Razón: el arranque de proyecto se repitió a mano 3 veces (MintStash, app seguridad, búsqueda pisos) — regla de tres.
- Candidatas nuevas en `skill-candidates.md`: regla de comms (Docs) y ops de volumen (pipeline/subagentes).

## v0.5.0 — 2026-06-24
- **Retro** (`rules/retro.md`) + skill cargadora `retro`. Core de proceso completo.
- Tres capas: síntomas (métricas del friction-log), enfermedades (causa raíz obligatoria),
  auto-auditoría (¿los fixes pasados movieron su métrica?). Tope de 3 propuestas. Propone, Andrés dispone.
- Añadido `meta/skill-candidates.md` con `capture-audit` y el hook `SessionStart` registrados.
- Razón: institucionaliza la lucha contra el "enfoque en síntomas".

## v0.4.0 — 2026-06-24
- **Ingesta** (`rules/ingest.md`) + skill cargadora `ingest`.
- Gate compartido con capture (preview → aprobación → aterriza); destila al esquema + conserva
  crudo; dos niveles de confianza (`validated` flag); en conflicto gana lo validado-a-fondo.
- Razón: conecta el sistema con el mundo exterior sin contaminar el vault.

## v0.3.0 — 2026-06-24
- **Routing** (`rules/routing.md`) + skill cargadora `route-task`.
- Tabla output→rama→ejecutor para las 8 ramas; frontera Código (casi todo → Claude Code);
  routing automático con declaración en una línea; multi-rama = manda el output final.
- Razón: la columna vertebral. Elimina el "¿Cowork o Code?" como decisión por tarea.

## v0.2.0 — 2026-06-24
- Rituales de sesión: **retrieve** (`rules/session-open.md`) y **capture** (`rules/session-close.md`),
  cada uno con su skill cargadora.
- `CLAUDE.md.template` ahora apunta a las reglas en vez de duplicarlas (DRY).
- Razón: atacan la fricción de handoffs y arranque en frío; capture empieza a alimentar
  el `friction-log` que la retro necesitará.

## v0.1.0 — 2026-06-24
- Primer componente: **contrato de reporte**. Regla siempre activa (`rules/report-contract.md`)
  + skill cargadora + cableado en `CLAUDE.md.template`.
- Scaffold del repo y del plugin core.
- Razón: ataca la fricción más frecuente (re-explicaciones "for dummies") y es el primer
  componente que se nota de inmediato.
