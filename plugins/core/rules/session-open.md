# Ritual de apertura (retrieve)

Regla siempre activa. Antes de ejecutar una tarea, trae del vault el contexto que necesita. El objetivo es que ninguna sesión arranque en frío y que nunca se produzca "de memoria".

## Lectura base (siempre los cuatro)

Al empezar cualquier tarea, roza SIEMPRE estos cuatro del vault del proyecto:

1. `active-context.md` — estado actual: en qué se trabaja, qué quedó abierto.
2. Normativos relevantes a la tarea (brand-identity, SCHEMA, etc.).
3. Decisiones recientes (`decisions.md`) — para no contradecir lo ya resuelto.
4. Gotchas del área que se va a tocar (`gotchas.md`).

## Profundidad proporcional a la rama

"Siempre los cuatro" significa rozarlos. Cuán profundo entrar lo decide la rama de routing:

- **Código, Datos** → lectura completa de los cuatro.
- **Docs, Specs, Diseño** → lectura ligera (titulares + lo que aplique).
- **Web, Browser** → vistazo mínimo; casi nada salvo que la tarea lo pida.

Una tarea ligera ve titulares; una migración o un envío a clientes los lee enteros.

## Vault vacío — la excepción a la fluidez

Si el contexto que la tarea necesita NO existe en el vault, **avisa y pregunta** antes de seguir. No procedas de memoria. Esta es la única pausa deliberada en un sistema por lo demás automático: es el punto exacto donde nacen las alucinaciones, así que merece una interrupción.

## Qué NO es retrieve

El retrieve va inline, en la conversación principal — el agente necesita ese contexto para trabajar. No se delega a un subagente.
