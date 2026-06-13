# claude-system

Mi sistema de trabajo personal con Claude. **Este repo es proceso, no contenido.**
Define *cómo trabajo*; el contenido de cada proyecto vive en su propio vault, y mi
conocimiento personal transversal vive en un repo `second-brain` aparte.

## Qué hay aquí

```
.claude-plugin/marketplace.json   → hace el repo instalable en Claude Code
plugins/
  core/                           → el plugin de proceso (genérico)
    .claude-plugin/plugin.json
    skills/                       → cargadores de las reglas (report-contract, …)
    rules/                        → las reglas siempre activas
  landbot-pack/                   → (futuro) lo específico del trabajo
meta/
  friction-log.md                 → una línea por retry / re-explicación / miss
  CHANGELOG.md                    → la historia evolutiva del proceso
templates/
  CLAUDE.md.template              → se copia a cada repo de código
  vault-schema/                   → semilla del vault de un proyecto nuevo
```

## Cómo se instala

**Claude Code:** `/plugin marketplace add <tu-usuario>/claude-system` y luego instalar
`claude-system-core`. (Verifica el comando exacto contra la doc vigente de Claude Code.)

**Cowork:** instalar el archivo `core.plugin` empaquetado.

## Cómo se evoluciona

Toda mejora al proceso se hace AQUÍ, upstream, y sube de versión. Nunca se parchea el
proceso dentro de un proyecto. Cada componente nuevo = una entrada en `meta/CHANGELOG.md`.

## Estado

- v0.1.0 — contrato de reporte (primer componente).
- Siguientes: rituales de sesión (open/close), routing, ingesta, retro. Ver
  `meta/CHANGELOG.md` y el documento de requisitos.
