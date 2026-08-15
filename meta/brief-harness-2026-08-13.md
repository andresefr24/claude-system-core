---
title: Brief para la retro — el harness de enforcement de claude-system-core
type: reference
updated: 2026-08-13
validated: false
tags: [proceso, enforcement, hooks, retro]
ingested: 2026-08-14 (retro; crudo conservado tal cual llegó — correcciones de la retro al final)
---

# Brief para la retro: el harness de enforcement

> **Para el Claude de la retro.** Esto es contexto traído de otra sesión (Cowork, 13-ago, trabajo sobre MintStash). No lo des por bueno: cada cifra lleva su fuente y todas son re-derivables desde `claude-system-core` y `mintstash-knowledge`. Si algo no cuadra con lo que ves en disco, gana el disco.
>
> **Lo que esta sesión NO hizo:** no se escribió ni un hook, no se tocó `hooks.json`, no se modificó ninguna regla. Todo esto es diagnóstico y diseño.

---

## 1. La tesis, en una frase

Andrés: *"necesito hacer que Claude no tenga que tomar la decisión de hacer algo o no con reglas, sino que hayan hooks en los cuales confiar. En pocas palabras, necesito un harness."*

Y el reencuadre que salió al desarrollarlo: **el objetivo no es tener más checks, es tener menos reglas.** Un hook no compite por atención; una regla sí, y compite peor cuanto más larga es la sesión. Toda regla que pueda bajar a hook debe bajar, precisamente para que las que queden arriba —las de criterio— sean tan pocas que se sostengan.

---

## 2. Auditoría del fix anterior — esto es lo primero que la retro debería mirar

`verify-source` se materializó como **regla siempre-activa** (`rules/verify-source.md`, v0.11.0) tras cruzar la regla de tres, con el argumento explícito de que un skill que solo dispara al reconocer la anomalía trata el síntoma.

**Resultado medido: el fix no funcionó.** Siete entradas en `meta/friction-log.md` entre el 5 y el 10 de agosto, **todas posteriores a que la regla existiera**:

| fecha | etiqueta de la entrada |
|---|---|
| 2026-08-05 | `verify-source/regla-existente-no-disparó` — TRES fallos del mismo tipo en una sesión |
| 2026-08-06 | `epistémico/rework` — CINCO instancias en una sola sesión |
| 2026-08-07 | `verify-source/capacidad` — 1ª recurrencia CON la cláusula nueva ya cargada |
| 2026-08-08 | `verify-source/capacidad · el espejo comprobado a medias` |
| 2026-08-09 | `verify-source/capacidad · la regla se cargó, se leyó en voz alta, y aun así no disparó` |
| 2026-08-09 | `verify-source/capacidad · un recuento no es una clasificación` (3 instancias en una sesión) |
| 2026-08-10 | `verify-source/capacidad · una comprobación que no podía salir roja` |

**Y la sesión del 13-ago suma dos más, sin buscarlas:**

1. Afirmé que TEMPEST-STORE no tenía Taiga, Tundra ni Volcanic Island. Falso — sí las tenía, en PO/LP. La causa: usé un cruce contra wantslist que aplicaba en silencio el suelo de condición de la lista, y lo reporté como inventario. Andrés lo corrigió con dos capturas de pantalla.
2. Conté **139 criaturas legendarias** en la colección de Andrés. Son **39**. La consulta no filtraba por `portfolio_id` y sumaba los holdings de todos los usuarios de MintStash. Lo detecté yo al verificar antes de escribir, pero el primer número ya había entrado en mi razonamiento.

**Nueve recurrencias con la regla activa.** La conclusión para la retro no es "reforzar la regla": es que **la prosa siempre-activa no es un mecanismo de enforcement**, y la propia entrada del 6-ago ya lo dice — *"LA MEJOR PRUEBA de la entrada anterior está en este mismo log"*.

---

## 3. Medición del friction-log

51 entradas. Clasificadas por script sobre las etiquetas de tipo que escribe Claude al cerrar sesión:

| bucket | n | % |
|---|---|---|
| entorno / herramienta | 19 | 37 % |
| registro / comunicación | 8 | 16 % |
| verificar antes de afirmar | 8 | 16 % |
| meta / otros | 6 | 12 % |
| entrega / gate | 4 | 8 % |
| vault | 3 | 6 % |
| proceso / diseño | 3 | 6 % |

**Lectura.** El bucket mayor es entorno, pero casi nada de eso es accionable por Andrés: política de Claude-in-Chrome, remoto de git de otra cuenta, MCP en solo-lectura, el mount que crea pero no borra, el cwd que se resetea. **Quitado eso, el 63 % restante es interfaz** — que es exactamente la hipótesis de Andrés: *"claude-system-core existe para homogenizar el flujo de trabajo entre Claude y yo, y creo que la mayor parte del tiempo los roces surgen justo ahí."*

Nota de método: los bordes entre buckets son discutibles (metí `retry` en entorno). El orden de magnitud sí aguanta.

---

## 4. Estado real del harness hoy

Medido sobre `plugins/core/`:

- **11 reglas** en `rules/`. De ellas, **3** aparecen en algún script de `hooks/` (`retro`, `session-open`, `verify-source`). Las otras 8 cargan por skill o por `templates/CLAUDE.md.template`.
- **1 evento de hook cableado** en `hooks.json`: `SessionStart`, con `vault-freshness.sh` y `rules-have-loaders.sh --hook`.
- `SessionStart` es, de todos los eventos disponibles, **el único que no puede bloquear nada**. Solo inyecta contexto.

**Conclusión: el harness de hoy es 100 % inyección y 0 % verificación.** Garantiza que la prosa llega; nada garantiza que se aplique.

---

## 5. El agujero está en el criterio de `rules-have-loaders.sh`

El script es el meta-check correcto y su cabecera lo dice mejor que nadie: *"una regla escrita y nunca cargada es prosa. No falla, no avisa, y da la sensación de estar cubierto — que es peor que no tenerla."*

Pero acepta **tres vías** de carga y una de ellas es "una skill de `skills/` que la referencie". **Una skill dispara porque el modelo decide invocarla** — que es justo la decisión que el harness quiere quitar de en medio. Así que el check sale en verde mientras el enforcement sigue siendo consejo.

**Cambio propuesto (es de criterio, no de arquitectura):** que clasifique cada regla en *enforzable por hook* o *solo de criterio*, y falle cuando una enforzable se esté cargando por skill. Con eso el propio harness va diciendo qué queda por bajar, en vez de dar por cubierto.

---

## 6. La línea de reparto: core lleva los bordes, el proyecto el interior

Andrés puso la restricción: *"al este ser un looper y aparte un router, los escenarios que apliquen a otro tipo de proyecto no deberían dispararse todo el tiempo."*

Eso resuelve el reparto por perfil de disparo:

| | core | proyecto |
|---|---|---|
| `SessionStart`, `UserPromptSubmit`, `Stop`, `SessionEnd` | ✅ orden de unos pocos disparos por sesión | |
| `PreToolUse`, `PostToolUse` | | ✅ orden de cientos por sesión, y el predicado tiene forma de proyecto |

El *router* dispara una vez por petición; el *looper*, en los bordes del arco. Ninguno necesita saber nada de una llamada a herramienta concreta. Lo único que quiere disparar por tool-call es la vigilancia de invariantes del proyecto, y ésa es del proyecto por definición.

**Reparto de piezas:** core aporta los puntos de enganche, la semántica de bloqueo, un runner que descubre y ejecuta los checks del proyecto, y el esquema de "ticket con `done_when`". El proyecto aporta los parsers y los formatos (`### TD-N` bajo `## Active`, el formato de identificador, la regla de que un commit cite ticket).

---

## 7. Core silencioso por defecto — y esto también está ya en el log

Entrada del **2026-08-06**: *"el ritual de session-close asume un vault de proyecto con `active-context.md`, pero el trabajo de Landbot (Agent Experience) no tiene uno."* Es core disparando un escenario que no aplica, ya registrado como fricción.

Hoy `vault-freshness.sh` es lo contrario de silencioso: cuando no encuentra vault, **emite el aviso de "vault vacío"**. En MintStash es útil; en Landbot es ruido en cada sesión.

**Principio propuesto: core silencioso por defecto, ruidoso por opt-in.** Ausencia de marcador → salida en silencio, código 0. Mecanismo a decidir: declaración explícita del proyecto (un `.claude/harness.json` mínimo) para todo lo que hable, y descubrimiento por marcador solo para lo gratis.

---

## 8. Lo que el harness NO va a arreglar — y esto es lo importante

**La enfermedad dominante del interfaz es la menos hookeable de todas.** "¿Verificaste antes de afirmar?" no es un predicado sobre artefactos.

Los hooks van a cerrar limpiamente la familia **entrega/gate** (4 entradas: el plugin que no cargaba, el `lint` sin config, el ticket sin cerrar, `git add -A`) y no van a tocar los 8 de verify-source.

**Esto no invalida el harness, lo reencuadra:** los hooks no están para curar la enfermedad dominante, están para **liberar el presupuesto de atención** que hoy se gasta en lo mecánico, y del que verify-source depende. Once reglas compitiendo es una hipótesis razonable de por qué la que importa no dispara.

Si la retro quiere una métrica objetivo honesta: *bajar N reglas a hook* no debería medirse por número de hooks, sino por **si las recurrencias de verify-source caen** en las cuatro semanas siguientes. Si no caen, la hipótesis del presupuesto de atención era falsa y hay que buscar otra.

---

## 9. Regla nueva candidata (una, y sale del propio log)

La entrada del **10-ago** nombra algo transferible: *"una comprobación que no podía salir roja"*.

**Propuesta: antes de afirmar que una comprobación pasa, demostrar que puede fallar.** Correrla contra un caso malo conocido. Es mutation testing aplicado al razonamiento.

El precedente ya existe y es de Andrés, en `tech-debt#TD-134` del 8-ago: *"Verificado reintroduciendo el fallo exacto — 24 avisos contra el techo, el push se cae."* Esa frase es el estándar; falta convertirla en norma. Y encaja con el patrón `*:selftest` que el repo de MintStash ya usa (`review:selftest`, `tokens:selftest`).

---

## 10. Decisiones abiertas para la retro

1. **Por dónde empezar.** Recomendación de la sesión: `Stop`, porque es el único hook que no se puede esquivar por omisión — toda sesión termina. `PostToolUse` sobre el registro de tickets solo dispara si alguien lo edita.
2. **Mecanismo de opt-in** para que core no dispare fuera de lugar: declaración explícita vs descubrimiento por marcador.
3. **Fail-open vs fail-closed.** Los hooks corren en cada sesión de cada proyecto; un `exit 2` mal puesto bloquea todo hasta que se encuentre. Recomendación: nacer avisando, subir a bloqueo solo tres o cuatro.
4. **Si el criterio nuevo de `rules-have-loaders.sh` entra ya** o espera a tener el primer hook de verificación.
5. **Cuántos proyectos vivos hay aparte de MintStash.** Todo el argumento de "esto a core" descansa en que el harness se amortiza en el segundo proyecto. Si MintStash es el único a medio plazo, meterlo en `.claude/` del repo y extraer después es defendible y más barato.

---

## 11. Qué no está verificado

- **Las capacidades de los eventos de hook** (quién puede bloquear, con qué mecanismo, qué matchers admite) las verifiqué contra la documentación de Claude Code vía subagente. Un punto quedó marcado como **no documentado**: si `PostToolUse` con `decision: block` pausa el turno indefinidamente o solo empuja a reintentar. Si algo crítico se apoya ahí, probarlo antes de confiar.
- **El hook de `UserPromptSubmit` es la pieza más especulativa** de la propuesta: enrutar por disciplina desde un script implica clasificar intención con heurísticas de texto, que es lo que un hook hace peor que un modelo. Si algo se cae al implementarlo, apostaría por ése.
- **La clasificación del friction-log** es por script sobre etiquetas, no lectura entrada a entrada.
- **Mi lectura del vault de MintStash es del 9-ago**; el vault tiene commits del 13-ago que no incorporé. Las cifras de reglas y hooks de `claude-system-core` sí son de hoy.
- **Dejé basura:** un fichero `_probe-ok` en la raíz de `mintstash-knowledge`, creado para comprobar permisos de escritura y que no pude borrar por el gotcha del mount. Hay que borrarlo a mano. Es, además, la enésima manifestación de ese mismo gotcha: estaba documentado en el log, lo había leído veinte minutos antes, y aun así lo pisé.

---

## Correcciones de la retro 2026-08-14 (al ingerir este brief)

- **§2, "nueve recurrencias con la regla activa": la cifra necesita poda.** El addendum de `retro-2026-08-07.md` estableció que v0.11–v0.13 nunca se cargaron en runtime (el plugin corrió 0.10.0 hasta el 07-08, y el CLAUDE.md de mintstash no tuvo el bullet de verify-source hasta el 06-08). Las entradas del 05-08 y 06-08 caen fuera de la ventana de medición válida. La conclusión sobrevive con las ~7 recurrencias válidas (07-08 en adelante, incluidas las dos del 13-ago); la evidencia se poda.
- **Convergencia registrada:** la retro 2026-08-14 llegó independientemente al mismo diagnóstico (el fallo es el disparador, no el loader) y shipeó la escalera de enforcement en v0.15.0 (`rules/patterns.md`). Este brief aporta además: el reencuadre "menos reglas" (presupuesto de atención), el agujero del criterio de `rules-have-loaders.sh` (§5), y la métrica honesta (§8).
