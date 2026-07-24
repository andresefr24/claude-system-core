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
