---
name: project-init
description: Arranca un proyecto nuevo desde cero de forma consistente (inception). Úsala cuando Andrés diga "nuevo proyecto", "arranquemos X", "monta el vault para X", "inicializa el proyecto", o cuando empiece a trabajar en algo que aún no tiene vault. Scaffolda el vault desde la plantilla, siembra active-context, cablea la superficie (CLAUDE.md para código, instrucciones de proyecto para Cowork) y crea los normativos iniciales. No aplica a charla casual ni a proyectos ya existentes.
---

# Inception — arranque de proyecto

Para montar un proyecto nuevo, aplica `../../rules/inception.md`.

Pasos:

1. Lee `rules/inception.md` del plugin si no tienes su contenido en contexto.
2. Pregunta si el proyecto es personal o de trabajo (frontera aún abierta).
3. Scaffolda el vault: copia `templates/vault-schema/` a `{proyecto}-knowledge` y añade `CONVENTIONS.md`.
4. Siembra `active-context.md` con qué es, objetivo, stakeholders y estado; pregunta lo que falte, no inventes.
5. Cablea la superficie: `CLAUDE.md.template` a la raíz del repo (código) y/o `templates/cowork-project-instructions.md` como instrucciones permanentes del Proyecto de Cowork.
6. Crea los normativos propios del proyecto desde el inicio si los hay (marca, esquema, tono).
