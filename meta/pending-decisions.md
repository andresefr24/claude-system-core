# Pendientes de decisión

El buzón entre la retro y Andrés. Cada retro deposita aquí sus propuestas; ninguna propuesta
se considera viva hasta tener fila aquí, y ninguna sale del buzón sin decisión registrada.
Es el ÚNICO archivo que una corrida automática de retro puede escribir.

Estados: **pendiente** · **aprobada → vX.Y.Z** · **rechazada (razón en una línea)**.
Una rechazada con razón vale tanto como una aprobada: evita re-proponerla.

| Fecha retro | Propuesta | Enfermedad que ataca | Estado |
|---|---|---|---|
| 2026-06-26 | Guard de freshness del vault | el vault canónico no es lo que se consume (miss-vault ×4) | Aprobada → v0.7.0 (hook `vault-freshness`) — decidida 2026-07-25 |
| 2026-06-26 | Regla de comms dentro de Docs | audiencia+registro+canal no eran inputs de primera clase | Aprobada → v0.7.0 (`rules/comms.md`) — decidida 2026-07-25 |
| 2026-06-26 | Mantener aparcado el hook de enforcement general (no-acción) | disciplina de auto-auditoría | Confirmada 2026-07-25 — sigue aparcado (ver `skill-candidates.md`) |
| 2026-07-07 | Cerrar el loop retro→decisión (este archivo + wiring en retro/session-open) | las propuestas de retro morían sin decisión registrada | Aprobada → v0.8.0 — decidida 2026-07-25 |
| 2026-07-07 | Registro llano promovido a regla global | la cláusula de registro (v0.6.1) no cubría explicaciones ad-hoc / digestiones | Aprobada → v0.8.0 (`rules/registro.md`) — decidida 2026-07-25 |
| 2026-07-07 | "UI local → deploy a preview" en la regla de verificación | — | Rechazada — premisa falsa: Claude-in-Chrome sí entra a localhost (Andrés, 2026-07-25); corrección anotada en friction-log |
| 2026-07-25 | Autorizar a la retro un write a `pending-decisions.md` | propuestas de retro morían en transcripts efímeros | Ya resuelta por v0.8.0 antes de esta retro — sin acción |
| 2026-07-25 | Codificar límites de verificación de UI en navegador (viewport real declarado; verificar limitaciones contra el presente) | la regla de verificación asumía capacidades no escritas del tooling (viewport cap ×2) | Aprobada → v0.9.0 (`rules/routing.md`) — decidida 2026-07-25. Parte localhost excluida (rechazada 07-07) |
| 2026-07-25 | Capture incremental de fricción + friction-log único de sistema | fricción acoplada al cierre ordenado se perdía en pivots (idealista, cohort); log duplicado en tech-knowledge | Aprobada → v0.9.0 (`rules/session-close.md`) — decidida 2026-07-25 |
| 2026-07-17 | Cerrar "prod ≠ local sin aviso" en mintstash (remote inalcanzable ×3 + debugging fantasma 16-jul) | la ceremonia de release/Actions asume push por CLI que este setup no tiene; `main` local se adelanta a `origin` sin señal | Aprobada — decidida 2026-07-25. Resolución raíz: Andrés configura el remote con acceso completo (acción suya, fuera del plugin). Sin regla-parche de deploy-state; reabrir si el drift recurre con el remote ya autenticado |
| 2026-07-17 | Design gate: en decisiones que fijan estructura, exponer 2-3 opciones con tradeoffs antes de codificar | ante problemas que moldean arquitectura se salta a la primera solución que funciona (oracle-price: migración one-way rehecha como flag) | Aprobada → v0.10.0 (`rules/routing.md`) — decidida 2026-07-25 |
