# Changelog — claude-system-core

La historia evolutiva del proceso. Cada cambio al flow vive aquí.

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
