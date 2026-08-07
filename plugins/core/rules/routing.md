# Routing

Regla siempre activa. Decide a qué rama (y herramienta) va cada tarea, sin que Andrés delibere. El routing es automático: enruta y arranca, declarando su decisión.

## Señal de decisión

La pregunta es una sola: **¿qué output produce esta tarea?** El output determina la rama. No se enruta por esfuerzo ni por gusto, sino por lo que se va a producir.

## Tabla output → rama → ejecutor

| Output que produce la tarea | Rama | Ejecutor |
|---|---|---|
| Un commit (cambio en un repo real) | Código | **Claude Code** |
| Un dato, métrica o análisis | Datos | Cowork + conectores (Supabase, Metabase, Amplitude) |
| Conocimiento de fuentes externas | Web | Cowork (research) |
| Una acción en un servicio web o verificación en vivo | Browser | Cowork + Claude in Chrome |
| Un documento, página de Notion, deck | Docs | Cowork |
| Un mensaje a humanos (email, Slack, copy, respuesta a creador) | Docs → aplica `comms.md` | Cowork |
| Un prototipo o visual | Diseño | Claude Design / Figma (Cowork prepara el brief) |
| Un PRD, requerimiento o prompt | Specs & prompts | Cowork |
| Memoria que entra al vault (handoff, agente ajeno, doc) | Ingesta | Cowork + skills de captura |

## Frontera Código (Code vs Cowork)

Casi todo el código va a **Claude Code**. Cowork no toca código salvo snippets de ejemplo en una explicación. Cualquier cambio en un repo real —por trivial que parezca— se enruta a Code, porque allí el toolchain (tests, linter, git, hooks) fuerza la calidad. Lo que no produce un commit no es rama Código.

### Escrituras y git en repos montados desde el sandbox de Cowork

**Las escrituras y las operaciones git sobre un repo real montado van por Claude Code / Mac, no por el sandbox de Cowork.** El sandbox queda para lecturas (leer el código, grepear, entender) y para escribir donde no toca la infraestructura del repo. Razón (fricción ×3, 2026-07-25 y 2026-08-01): el mount de Cowork es **crear-pero-no-borrar** (`rm` falla con "Operation not permitted" sin permiso explícito) y el Write tool **protege `.claude/`**; git desde el sandbox deja lockfiles huérfanos y puede firmar con la identidad equivocada. No es imposible —bash crea archivos y `allow_cowork_file_delete` desbloquea el borrado— pero es semi-seguro y frágil, y un error no se deshace fácil. Si un build hay que hacerlo desde Cowork, hazlo consciente del límite; por defecto, ese trabajo es de Code.

## Autonomía: automático con override

- Enruta y arranca solo. No pide permiso.
- **Declara la decisión en UNA LÍNEA antes de ejecutar**: ej. "→ Code: toca el repo de MintStash" o "→ Datos: esto es una query a Supabase". La declaración hace que el override sea un reflejo, no una arqueología.
- Si Andrés corrige la rama, se acata sin fricción.

## Design gate (decisiones que fijan estructura)

Antes de codificar una tarea que crea o muta estructura —modelo de datos, tabla/vista/flag nuevos, read path, contrato público—, se expone primero el espacio de diseño: **2-3 opciones con tradeoffs (o el modelo más simple posible) y se invita explícitamente la intención arquitectónica de Andrés**. El primer prototipo no es la conversación de diseño; saltar a la primera solución que funciona costó una migración one-way de 3992 filas rehecha como flag (oracle-price, 2026-07-16). No aplica a lo que no fija estructura: bugfixes, ajustes de UI, refactors sin superficie nueva.

## Verificación de UI en navegador

Al verificar UI en vivo (rama Browser), los límites del tooling son parte del resultado:

- **Declara el viewport real alcanzado.** `resize_window` tiene mínimo real (~500px de ventana; la emulación móvil ha llegado a ~312px, no a 390). Una auditoría "móvil" que no alcanzó el viewport objetivo lo dice explícitamente; nunca se reporta como verificado un tamaño que no se montó.
- **No asumas límites del tooling: reprodúcelos hoy antes de trabajar alrededor de ellos.** (Corrección 2026-07-25: Claude-in-Chrome sí entra a localhost, contra lo que el friction-log registró en junio.) Una regla o workaround sobre una limitación no verificada contra el estado presente de la herramienta nace muerta.
- **Setup antes de mirar (v0.14.0).** La verificación empieza cuando el entorno está confirmado, no antes: (1) si hay dev server, matar el viejo y arrancar desde la raíz del repo, confirmando que la URL responde; (2) fijar el viewport objetivo y **confirmarlo en el DOM**, no asumir que el resize aplicó; (3) solo entonces mirar/screenshot. Si hace falta móvil, es una pasada separada y etiquetada, no la misma ventana reusada. Razón (insights 2026-08-05): fricción recurrente en 148 llamadas de browser — puerto ocupado por un server viejo, cwd equivocado, y un viewport a 375px enseñando la barra móvil cuando se auditaba el sidebar de desktop.

## Tareas multi-rama

Cuando una tarea atraviesa varias ramas (ej.: investigar datos → escribir un doc), manda la rama del **output final**. Las demás son sub-pasos invisibles que se resuelven solos, sin checkpoints intermedios.
