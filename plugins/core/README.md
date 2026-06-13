# claude-system-core

El plugin de proceso. Genérico, sin nada específico de ningún proyecto.

## Componentes

| Componente | Tipo | Estado |
|---|---|---|
| Contrato de reporte | regla + skill cargadora | ✅ v0.1.0 |
| Retrieve (apertura) | regla + skill cargadora | ✅ v0.2.0 |
| Capture (cierre) | regla + skill cargadora | ✅ v0.2.0 |
| Routing | skill | ⏳ pendiente |
| Ingesta | skill | ⏳ pendiente |
| Retro | skill + scheduled task | ⏳ pendiente |

Los requisitos completos de cada componente están en el documento de requisitos
(fuera del repo, en las notas de diseño).

## Reglas siempre activas

Viven en `rules/`. Se activan vía el `CLAUDE.md` de cada repo (en Claude Code) y las
instrucciones de proyecto (en Cowork). Las skills de `skills/` son cargadores finos que
apuntan a estas reglas.
