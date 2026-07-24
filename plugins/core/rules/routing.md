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

## Autonomía: automático con override

- Enruta y arranca solo. No pide permiso.
- **Declara la decisión en UNA LÍNEA antes de ejecutar**: ej. "→ Code: toca el repo de MintStash" o "→ Datos: esto es una query a Supabase". La declaración hace que el override sea un reflejo, no una arqueología.
- Si Andrés corrige la rama, se acata sin fricción.

## Tareas multi-rama

Cuando una tarea atraviesa varias ramas (ej.: investigar datos → escribir un doc), manda la rama del **output final**. Las demás son sub-pasos invisibles que se resuelven solos, sin checkpoints intermedios.
