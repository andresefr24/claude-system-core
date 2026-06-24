# Friction log

Una línea por evento de fricción del PROCESO (no de los proyectos). Lo escribe Claude al
cerrar sesión, como parte del capture. La retro semanal lo lee para buscar enfermedades,
no solo síntomas.

Formato: `FECHA | tipo | qué pasó | rama/contexto`
Tipos: retry · frio (arrancó sin contexto) · reexplicacion · override (routing) · miss-vault

<!-- entradas debajo -->

2026-06-24 | contrato/reexplicacion | en sesión de trabajo larga (cohort MintStash, browser+supabase) los deliverables sustantivos NO aplicaron el contrato de reporte pese a instrucciones a nivel de proyecto. Micro-pasos sin contrato = correcto; borradores y status = deberían haber llevado la espina y no lo hicieron. | enfermedad candidata: las reglas always-on viven como prosa y no se imponen de forma fiable sobre un contexto largo y dominado por tool calls; falta un mecanismo que las re-afirme en el momento de producir el output. | confound: la sesión puede ser anterior al install de hoy — pendiente verificar con test limpio antes de prescribir fix.

2026-06-24 | RESOLUCIÓN del item anterior | test limpio (conversación fresca en proyecto MintStash, tarea sustantiva de outreach) → contrato, retrieve y capture dispararon COMPLETOS y bien. La hipótesis "enforcement de prosa insuficiente" NO se confirma: en sesión fresca, las instrucciones de proyecto sí imponen las reglas. Causa real probable del fallo del cohort: dilución por contexto largo/tool-heavy y/o sesión anterior al install. Acción: NO construir el mecanismo de enforcement; vigilar si la dilución reaparece en sesiones frescas que crezcan largas.

2026-06-24 | miss-vault | en el test, el snapshot de project-knowledge de Claude.ai ("TCG Vault") estaba desfasado (no contenía people.md); hubo que conectar el vault real a mano. Acercándose al trigger rule-of-three de automatizar el sync.

2026-06-24 | reexplicacion | RECURRENTE entre proyectos y conversaciones: Andrés pide "dumb downs" / "for dummies" de forma constante. | enfermedad: el contrato de reporte fijaba la estructura pero no el registro, así que el default salía demasiado denso. | RESUELTO en v0.6.1: cláusula de registro (llano por defecto, deep dives a petición).
