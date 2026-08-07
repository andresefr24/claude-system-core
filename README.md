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

## Cómo se actualiza (paso a paso canónico)

El marketplace `claude-system` apunta a esta carpeta local, no a un remoto: releerla y traer el
plugin son DOS pasos, uno solo no basta. Flujo verificado (sesión CC 2026-08-07):

```bash
# 0. Precondición: los cambios commiteados, y plugin.json y marketplace.json en la MISMA versión
#    (`claude plugin tag` valida justo eso; el desajuste ya mordió dos veces)
cd ~/Documents/andres.ferrero/claude-system-core && git status

# 1. Releer el marketplace
claude plugin marketplace update claude-system

# 2. Traer el plugin
claude plugin update claude-system-core@claude-system

# 3. Reiniciar la app ("restart required to apply" — la sesión abierta sigue con la versión vieja)

# 4. Confirmar la VERSIÓN
claude plugin list

# 5. Confirmar que CARGÓ — la versión listada no lo garantiza (incidente v0.14.1: plugin
#    instalado, versión correcta en el listado, y cero reglas activas por un "Hook load failed").
#    En la primera sesión nueva: comprobar que las skills claude-system-core:* aparecen; si no,
#    buscar errores de carga del plugin.
```

**Disciplina de release:** cada subida de versión termina con (a) `marketplace.json` sincronizado a
la misma versión que `plugin.json`, y (b) este paso a paso entregado a Andrés en el mensaje de
cierre. Una versión que sube sin que Andrés la instale no existe: entre v0.10.0 y v0.14.0 hubo
tres versiones de reglas que ninguna sesión llegó a cargar.

## Cómo se evoluciona

Toda mejora al proceso se hace AQUÍ, upstream, y sube de versión. Nunca se parchea el
proceso dentro de un proyecto. Cada componente nuevo = una entrada en `meta/CHANGELOG.md`.

## Estado

- v0.1.0 — contrato de reporte (primer componente).
- Siguientes: rituales de sesión (open/close), routing, ingesta, retro. Ver
  `meta/CHANGELOG.md` y el documento de requisitos.
