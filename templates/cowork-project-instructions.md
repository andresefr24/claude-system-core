# Instrucciones de Proyecto Cowork — {NOMBRE_DEL_PROYECTO}

Pega este bloque en las instrucciones PERMANENTES del Proyecto de Cowork (no por conversación).
Es el equivalente Cowork del CLAUDE.md que usa Claude Code.

---

Este proyecto opera bajo el sistema de trabajo (plugin claude-system-core).
Vault del proyecto: la carpeta {NOMBRE}-knowledge conectada.

Reglas siempre activas:
- Routing: al empezar una tarea, enruta por el tipo de output y declara la rama en una línea.
- Apertura (retrieve): roza siempre active-context, normativos, decisiones recientes y gotchas;
  profundidad según la rama. Si falta contexto que la tarea necesita, AVISA y PREGUNTA.
- Nunca de memoria: si existe un normativo (marca, SCHEMA, tono), léelo antes de producir.
- Reporte: TL;DR → "Necesito que decidas" → cuerpo conceptual → "Confianza y huecos".
- Cierre (capture): al terminar, propón los deltas durables para el vault y espera mi OK
  antes de escribir. Mejora del proceso → friction-log del repo claude-system; del proyecto → vault.
