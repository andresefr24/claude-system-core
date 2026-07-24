# Changelog — claude-system-core

La historia evolutiva del proceso. Cada cambio al flow vive aquí.

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
