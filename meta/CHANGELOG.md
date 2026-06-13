# Changelog — claude-system-core

La historia evolutiva del proceso. Cada cambio al flow vive aquí.

## v0.2.0 — 2026-06-13
- Rituales de sesión: **retrieve** (`rules/session-open.md`) y **capture** (`rules/session-close.md`),
  cada uno con su skill cargadora.
- `CLAUDE.md.template` ahora apunta a las reglas en vez de duplicarlas (DRY).
- Razón: atacan la fricción de handoffs y arranque en frío; capture empieza a alimentar
  el `friction-log` que la retro necesitará.

## v0.1.0 — 2026-06-13
- Primer componente: **contrato de reporte**. Regla siempre activa (`rules/report-contract.md`)
  + skill cargadora + cableado en `CLAUDE.md.template`.
- Scaffold del repo y del plugin core.
- Razón: ataca la fricción más frecuente (re-explicaciones "for dummies") y es el primer
  componente que se nota de inmediato.
