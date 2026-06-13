---
name: route-task
description: Determina a qué rama de ejecución y herramienta pertenece una tarea, al inicio de cualquier trabajo. Úsala al empezar una tarea para decidir entre Claude Code (código), conectores de datos, research web, browser, docs, diseño, specs o ingesta. Enruta automáticamente según el tipo de output que produce la tarea y declara la decisión en una línea antes de ejecutar. No aplica a charla casual.
---

# Routing

Al empezar una tarea, decide su rama según `../../rules/routing.md`.

Pasos:

1. Lee `rules/routing.md` del plugin si no tienes su contenido en contexto.
2. Identifica qué output produce la tarea y mapéalo a su rama con la tabla.
3. Aplica la frontera Código: cualquier cambio en un repo real → Claude Code; Cowork solo snippets de ejemplo.
4. **Declara la rama elegida en una línea antes de ejecutar** (ej. "→ Code: toca el repo").
5. Si la tarea atraviesa varias ramas, manda la del output final; las demás son sub-pasos invisibles.
6. Enruta automáticamente; si Andrés corrige, acata sin fricción.

Regla siempre activa, no opcional.
