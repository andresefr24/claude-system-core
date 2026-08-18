---
name: session-open
description: Ejecuta el ritual de apertura (retrieve) al empezar una tarea o sesión de trabajo en cualquier proyecto con vault. Úsala al iniciar trabajo, al retomar un proyecto, o cuando Andrés diga "vamos a trabajar en X", "retomemos", "empecemos con". Trae del vault el contexto necesario (active-context, normativos, decisiones, gotchas) con profundidad proporcional a la rama, y pausa si falta contexto crítico. No aplica a charla casual.
---

# Ritual de apertura (retrieve)

Al empezar una tarea o sesión, aplica el ritual definido en `../../rules/session-open.md`.

Pasos:

1. Lee `rules/session-open.md` del plugin **siempre**, no solo si no lo tienes en contexto. Ahí viven las categorías y su número, y este fichero no los repite a propósito (ver abajo).
2. Identifica la rama de la tarea (código, datos, docs, web, browser, diseño, specs, ingesta) para fijar la profundidad de lectura.
3. Roza las categorías que declara la regla, con la profundidad que le toque a esa rama.
4. Si el contexto que la tarea necesita no existe en el vault, AVISA y PREGUNTA antes de seguir. No procedas de memoria.
5. El retrieve va inline en la conversación principal; no lo delegues a un subagente.

Regla siempre activa, no opcional.

## Por qué el paso 3 no enumera (2026-08-18)

Enumeraba: decía «los cuatro» y los nombraba por fichero. **Y esa lista es la que se lee de
verdad**, porque llega antes que la regla y con aire de checklist, así que una regla ampliada en
`rules/session-open.md` se queda sin efecto mientras este fichero siga dictando otra cosa.

Pasó el 2026-08-18 al añadir el **plan vigente** como quinta categoría: la regla decía cinco y
este paso seguía diciendo cuatro. Es la enfermedad de las dos listas que el propio sistema
persigue en otros sitios —un control que reimplementa lo que vigila mide su copia—, aquí entre un
rito y su lanzador.

La cura no es sincronizarlas. Es que haya una sola: la regla enumera, la skill remite.
