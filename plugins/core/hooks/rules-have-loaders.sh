#!/usr/bin/env bash
# rules-have-loaders — comprueba que cada regla tenga por dónde entrar en contexto.
#
# Enfermedad que ataca: una regla escrita y nunca cargada es prosa. No falla, no
# avisa, y da la sensación de estar cubierto — que es peor que no tenerla, porque
# se deja de pensar en el problema. El 2026-08-06 encontramos tres reglas del
# plugin en ese estado, una de ellas escrita ese mismo día.
#
# Las tres vías válidas, y no hay más:
#   1. una skill de skills/ que la referencie
#   2. un hook de hooks/ que la aplique
#   3. inline en templates/CLAUDE.md.template, que cada repo copia y se autocarga
#
# Uso:  bash plugins/core/hooks/rules-have-loaders.sh
# Sale con 1 si alguna regla queda huérfana.

set -uo pipefail

# Modo hook (--hook): callado cuando todo está bien, y emite additionalContext de
# SessionStart cuando no. Una regla que deja de cargarse es exactamente el tipo de
# hueco que el modelo no puede detectar solo: en contexto no se ve lo que falta.
HOOK_MODE=0
[ "${1:-}" = "--hook" ] && { HOOK_MODE=1; shift; }
say() { [ $HOOK_MODE -eq 0 ] && printf '%s\n' "$*"; return 0; }
emit() {
  python3 - "$1" <<'PYEMIT' 2>/dev/null
import json,sys
print(json.dumps({"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":sys.argv[1]}}))
PYEMIT
}
CORE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATE="$(cd "$CORE/../.." && pwd)/templates/CLAUDE.md.template"

orphans=()
for rule in "$CORE"/rules/*.md; do
  name="$(basename "$rule" .md)"
  via=""

  grep -rqls "rules/$name.md" "$CORE/skills" 2>/dev/null && via="skill"
  [ -z "$via" ] && grep -rqls "rules/$name.md" "$CORE/hooks" 2>/dev/null && via="hook"
  # Inline: el template nombra la regla explícitamente en su resumen operativo.
  [ -z "$via" ] && [ -f "$TEMPLATE" ] && grep -qs "rules/$name.md" "$TEMPLATE" && via="inline"

  if [ -z "$via" ]; then
    orphans+=("$name")
  else
    say "$(printf "  ✅ %-18s %s" "$name" "$via")"
  fi
done

failed=0
if [ ${#orphans[@]} -gt 0 ]; then
  failed=1
  say ""
  say "  ❌ Reglas sin vía de carga — son prosa, no reglas:"
  for o in "${orphans[@]}"; do say "     rules/$o.md"; done
  say ""
  say "  Dale una de las tres: una skill cargadora, un hook, o un resumen"
  say "  operativo en templates/CLAUDE.md.template que la nombre."
fi

# Segunda mitad, y es la que de verdad muerde: el template NO es lo que se carga.
# Lo que se carga es el CLAUDE.md de cada repo. Si el template avanza y el fichero
# desplegado no, la regla existe en el sitio que nadie lee. Fue el caso de
# verify-source: escrita, metida en el template, y ausente del repo donde
# trabajábamos.
REPO="${1:-${CLAUDE_PROJECT_DIR:-$PWD}}"
DEPLOYED="$REPO/CLAUDE.md"
if [ -f "$DEPLOYED" ] && grep -qs "claude-system-core" "$DEPLOYED"; then
  say ""
  say "  CLAUDE.md desplegado: $DEPLOYED"
  # Casar por subcadena da falsos verdes: "Registro" aparece dentro de "Registro
  # llano por defecto" en otra regla. Se exige el nombre EN NEGRITA, que es como
  # se escribe un bullet siempre-activo, y se admite que el repo lo matice
  # ("**Reporte (contrato)**" cumple "**Reporte**").
  missing=()
  while IFS= read -r bullet; do
    grep -qF "**${bullet}" "$DEPLOYED" || missing+=("$bullet")
  done < <(grep -oE '^\*\*[^.*]+\.\*\*' "$TEMPLATE" | sed 's/^\*\*//; s/\.\*\*$//')

  if [ ${#missing[@]} -gt 0 ]; then
    failed=1
    say "  ❌ El template declara reglas siempre-activas que este repo no carga:"
    for m in "${missing[@]}"; do say "     $m"; done
    say ""
    say "  Cópialas al bloque 'Reglas siempre activas' de su CLAUDE.md."
  else
    say "  ✅ lleva las $(grep -cE '^\*\*[^.*]+\.\*\*' "$TEMPLATE") reglas del template"
  fi
fi

# En modo hook la señal es el mensaje inyectado, no el código de salida: un hook
# de arranque que sale con error se lee como hook roto, no como aviso.
if [ $failed -eq 1 ] && [ $HOOK_MODE -eq 1 ]; then
  emit "[rules-have-loaders] Hay reglas del sistema de trabajo que NO se están cargando en este repo (ver arriba, o corre: bash \${CLAUDE_PLUGIN_ROOT}/hooks/rules-have-loaders.sh). Una regla escrita y no cargada es prosa: no la des por vigente."
fi
[ $failed -eq 1 ] && { [ $HOOK_MODE -eq 1 ] && exit 0; exit 1; }
say ""
say "  Todas las reglas tienen por dónde entrar en contexto."
