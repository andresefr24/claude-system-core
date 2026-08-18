# Ritual de apertura (retrieve)

Regla siempre activa. Antes de ejecutar una tarea, trae del vault el contexto que necesita. El objetivo es que ninguna sesión arranque en frío y que nunca se produzca "de memoria".

## Lectura base (siempre las cinco CATEGORÍAS)

Al empezar cualquier tarea, roza SIEMPRE estas cinco preguntas al vault del proyecto. Son
categorías, no nombres de fichero — cada vault puede implementarlas donde quiera:

1. **Estado vigente** — en qué se trabaja, qué quedó abierto. Default: `active-context.md`.
2. **Normativos** relevantes a la tarea (brand-identity, SCHEMA, etc.).
3. **Decisiones recientes** — para no contradecir lo ya resuelto. Puede vivir en `decisions.md`,
   en ficheros `decision-*.md` fechados, o en el bloque de decisiones del estado vigente.
4. **Gotchas del área** que se va a tocar. Puede vivir en `gotchas.md`, o promovido dentro de
   `working-preferences.md` / `tech-debt.md`.
5. **Plan vigente** — qué toca cuando no hay iniciativa activa. Default: `roadmap.md`.

### Por qué el plan vigente es una categoría y no un extra (añadida 2026-08-18)

**Era la única categoría que contestaba «qué toca» y la única que nadie abría al empezar**, y eso
tiene un coste medido. El `roadmap.md` de mintstash llevaba veinticuatro días afirmando como
pendientes dos puntos que ya estaban hechos: las alertas de caída llevaban trece días en
producción y la landing quince días reescrita. Nadie lo vio porque el rito leía el estado, los
normativos, las decisiones y los gotchas, y el plan no estaba entre ellos.

**Y el daño no fue el documento sucio, fue una recomendación construida encima.** Una auditoría
leyó ese roadmap, dio la landing por sin empezar y recomendó «vete a la landing, es la pieza de
mayor apalancamiento». O sea: mandar a rehacer lo ya hecho. Un plan vacío se nota; uno que miente
se obedece.

**Lo que NO cubre, para que no se confunda con un gate.** Que el plan esté fresco de fecha no
dice que sus prioridades sigan siendo verdad. Eso solo se ve contrastándolo con el árbol, y es
juicio, no comprobación: ninguna forma ofline lo alcanza. Lo que esta categoría compra es que
alguien lo TENGA DELANTE cada sesión, que es la condición para que el contraste llegue a ocurrir.

**Cuándo importa de verdad:** el día que una iniciativa cierra. Mientras hay secuencia activa, el
estado vigente contesta «qué toca» solo. En cuanto cierra, la pregunta vuelve a ser de
prioridad, y ese es exactamente el momento en que el plan tiene que estar limpio y en el que
lleva más tiempo sin que nadie lo mire.

**El mapeo categoría→fichero lo declara el vault, una vez, en su `CONVENTIONS.md`** (el mapa es
proyecto→ESQUEMA, no solo proyecto→carpeta). Si el vault no lo declara: se deduce, se deja el
mapeo deducido escrito en el reporte de apertura —para que quede rastro de si se acertó—, y al
cerrar se propone fijarlo en `CONVENTIONS.md` para no deducirlo dos veces.

Razón (retro 2026-08-14; apariciones 08-06 y 08-10): un rito que nombra la implementación obliga
a cada vault a tener el layout del rito, o al agente a improvisar el mapeo en cada apertura sin
dejar rastro. El vault de mintstash eligió otra implementación a propósito y mordió por los dos
extremos en una misma sesión (apertura y cierre).

## Profundidad proporcional a la rama

"Siempre las cinco" significa rozarlas. Cuán profundo entrar lo decide la rama de routing:

- **Código, Datos** → lectura completa de las cinco.
- **Docs, Specs, Diseño** → lectura ligera (titulares + lo que aplique).
- **Web, Browser** → vistazo mínimo; casi nada salvo que la tarea lo pida.

**El plan vigente es la excepción a la profundidad, y va al revés que las demás:** se roza SIEMPRE,
aunque la rama sea ligera, porque lo que se le pregunta es de una línea — ¿lo que dice que toca
sigue siendo lo que toca? — y porque su coste de estar sucio no lo paga la tarea de hoy sino la
decisión de la semana que viene.

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
