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

### El estado vigente tiene tope: 3 ítems y un log de deuda (añadida 2026-09-08)

**El estado vigente es un doc con forma, no un cajón.** Su contenido son **como máximo 3 ítems**:
las próximas cosas sobre las que se va a actuar. Todo lo demás que sea trabajo pendiente vive en el
**log de deuda técnica**, que es un fichero aparte y sin tope. Nada más entra en el estado vigente.

**Por qué un tope y no disciplina.** El estado vigente es el primer fichero que se lee cada sesión,
así que su tamaño es coste de contexto directo en todas. Y sin tope crece por acumulación, porque
añadir un pendiente es gratis y quitarlo requiere decidir. Medido en el vault de mintstash: 74 KB el
2026-08-18, podado a 18 KB, y **66 KB otra vez el 2026-09-08**, con 16 pendientes en una sola
sección. Tres semanas para volver al punto de partida.

**El tope es del contenido, no de los bloques de narración.** Un gate que cuenta bloques de estado
no ve esto: el vault de mintstash tenía uno y pasaba en verde con el fichero en 50 KB, porque lo que
había engordado eran dos secciones que no son bloques. Si el vault implementa el tope con un
control, que cuente **ítems**.

**Y un gate de pre-push no vale para este fichero.** El estado vigente se escribe cada sesión y se
empuja de vez en cuando: el mismo vault llevaba 29 commits sin empujar con el gate en rojo, o sea
que la comprobación existía y no se había ejecutado nunca en esos 29. Si hay control, va antes: en
el commit, o en el ritual de cierre.

**EL TOPE NO VALE SOLO: hay que decir dónde sigue la cola** (añadido 2026-09-08, y esto corrige la
versión que se escribió sin ello). Un tope que no nombra al cuarto ítem no ordena nada, **convierte
un desorden visible en uno invisible**: lo que sale del estado vigente cae en el log de deuda, y un
log de deuda no es una cola. Medido en el vault de mintstash el 2026-09-08: **173 fichas activas,
141 sin prioridad**, y su propio índice avisa en mayúsculas de que no es un orden de trabajo.

Así que el reparto es de tres sitios, no de dos, y cada uno contesta una pregunta distinta:

| Pregunta | Dónde vive |
|---|---|
| ¿Qué estoy tocando ahora? | **Estado vigente**, con tope de 3 ítems |
| ¿Qué va después? | **Plan vigente** (categoría 5 de arriba) |
| ¿Qué hay apuntado para algún día? | **Log de deuda**, cada ficha con su disparador |

**Y lo que sale de la cabeza sale con disparador, no con prioridad**, porque una prioridad se podre
sin avisar y un disparador o se cumplió o no. Medido el mismo día, auditando las 15 fichas del vault
de mintstash que declaraban prioridad: **cuatro estaban muertas o contestadas, dos necesitaban
reencuadre y una era doce veces peor de lo que decía.** La más alta llevaba tres semanas siendo ALTA
sobre una tabla que una migración había borrado. Casi la mitad de las prioridades declaradas
mentían, y ninguna daba señal de estarlo.

**Las dos puntas se declaran una a la otra.** El estado vigente dice que su cola está en el plan, y
el plan dice que su cabeza está en el estado. Un puntero en un solo sentido se queda huérfano en
silencio el día que alguien cambia el otro lado.

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
