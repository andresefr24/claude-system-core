# claude-system-core

El plugin de proceso. Genérico, sin nada específico de ningún proyecto.

## Componentes

| Componente | Tipo | Estado |
|---|---|---|
| Contrato de reporte | regla + skill cargadora | ✅ v0.1.0 |
| Retrieve (apertura) | regla + skill cargadora | ✅ v0.2.0 |
| Capture (cierre) | regla + skill cargadora | ✅ v0.2.0 |
| Routing | regla + skill cargadora | ✅ v0.3.0 |
| Ingesta | regla + skill cargadora | ✅ v0.4.0 |
| Retro | regla + skill cargadora | ✅ v0.5.0 |
| Inception | regla + skill cargadora | ✅ v0.6.0 |
| Verificar contra la fuente | regla + inline en el template | ✅ v0.9.0 |
| Registro | regla + inline en el template | ✅ v0.10.0 |
| Comms | regla + inline en el template | ✅ v0.13.0 |
| Patrón antes que reparación | regla + inline en el template | ✅ v0.13.0 |

Los requisitos completos de cada componente están en el documento de requisitos
(fuera del repo, en las notas de diseño).

## Reglas siempre activas

Viven en `rules/`. Se activan vía el `CLAUDE.md` de cada repo (en Claude Code) y las
instrucciones de proyecto (en Cowork). Las skills de `skills/` son cargadores finos que
apuntan a estas reglas.

**Una regla existe si se carga.** Hay tres vías y no más: una skill cargadora, un hook, o un
resumen operativo inline en `templates/CLAUDE.md.template`. Un fichero en `rules/` sin ninguna
de las tres es prosa: no falla, no avisa, y da sensación de estar cubierto.

`hooks/rules-have-loaders.sh` lo comprueba, y comprueba también la mitad que de verdad muerde:
que el `CLAUDE.md` **desplegado** en cada repo lleve lo que el template declara. El template no
es lo que se carga. Corre en cada arranque de sesión, callado si todo está bien.
