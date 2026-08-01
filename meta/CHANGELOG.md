# Changelog — claude-system-core

La historia evolutiva del proceso. Cada cambio al flow vive aquí.

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
