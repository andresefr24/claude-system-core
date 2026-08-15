# Ritual de apertura (retrieve)

Regla siempre activa. Antes de ejecutar una tarea, trae del vault el contexto que necesita. El objetivo es que ninguna sesión arranque en frío y que nunca se produzca "de memoria".

## Lectura base (siempre las cuatro CATEGORÍAS)

Al empezar cualquier tarea, roza SIEMPRE estas cuatro preguntas al vault del proyecto. Son
categorías, no nombres de fichero — cada vault puede implementarlas donde quiera:

1. **Estado vigente** — en qué se trabaja, qué quedó abierto. Default: `active-context.md`.
2. **Normativos** relevantes a la tarea (brand-identity, SCHEMA, etc.).
3. **Decisiones recientes** — para no contradecir lo ya resuelto. Puede vivir en `decisions.md`,
   en ficheros `decision-*.md` fechados, o en el bloque de decisiones del estado vigente.
4. **Gotchas del área** que se va a tocar. Puede vivir en `gotchas.md`, o promovido dentro de
   `working-preferences.md` / `tech-debt.md`.

**El mapeo categoría→fichero lo declara el vault, una vez, en su `CONVENTIONS.md`** (el mapa es
proyecto→ESQUEMA, no solo proyecto→carpeta). Si el vault no lo declara: se deduce, se deja el
mapeo deducido escrito en el reporte de apertura —para que quede rastro de si se acertó—, y al
cerrar se propone fijarlo en `CONVENTIONS.md` para no deducirlo dos veces.

Razón (retro 2026-08-14; apariciones 08-06 y 08-10): un rito que nombra la implementación obliga
a cada vault a tener el layout del rito, o al agente a improvisar el mapeo en cada apertura sin
dejar rastro. El vault de mintstash eligió otra implementación a propósito y mordió por los dos
extremos en una misma sesión (apertura y cierre).

## Profundidad proporcional a la rama

"Siempre los cuatro" significa rozarlos. Cuán profundo entrar lo decide la rama de routing:

- **Código, Datos** → lectura completa de los cuatro.
- **Docs, Specs, Diseño** → lectura ligera (titulares + lo que aplique).
- **Web, Browser** → vistazo mínimo; casi nada salvo que la tarea lo pida.

Una tarea ligera ve titulares; una migración o un envío a clientes los lee enteros.

## Vault vacío — la excepción a la fluidez

Si el contexto que la tarea necesita NO existe en el vault, **avisa y pregunta** antes de seguir. No procedas de memoria. Esta es la única pausa deliberada en un sistema por lo demás automático: es el punto exacto donde nacen las alucinaciones, así que merece una interrupción.

## Pendientes de retro (una línea, no bloquea)

Si `meta/pending-decisions.md` del repo del sistema está accesible y tiene propuestas sin
decidir con más de una semana, menciónalo en una línea al abrir la sesión ("hay N propuestas
de retro esperando tu decisión"). No interrumpe la tarea; solo evita que el loop de mejora
muera en silencio.

## Qué NO es retrieve

El retrieve va inline, en la conversación principal — el agente necesita ese contexto para trabajar. No se delega a un subagente.
