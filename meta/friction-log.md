# Friction log

Una línea por evento de fricción del PROCESO (no de los proyectos). Lo escribe Claude al
cerrar sesión, como parte del capture. La retro semanal lo lee para buscar enfermedades,
no solo síntomas.

Formato: `FECHA | tipo | qué pasó | rama/contexto`
Tipos: retry · frio (arrancó sin contexto) · reexplicacion · override (routing) · miss-vault

<!-- entradas debajo -->

2026-06-13 | contrato/reexplicacion | en sesión de trabajo larga (cohort MintStash, browser+supabase) los deliverables sustantivos NO aplicaron el contrato de reporte pese a instrucciones a nivel de proyecto. Micro-pasos sin contrato = correcto; borradores y status = deberían haber llevado la espina y no lo hicieron. | enfermedad candidata: las reglas always-on viven como prosa y no se imponen de forma fiable sobre un contexto largo y dominado por tool calls; falta un mecanismo que las re-afirme en el momento de producir el output. | confound: la sesión puede ser anterior al install de hoy — pendiente verificar con test limpio antes de prescribir fix.
