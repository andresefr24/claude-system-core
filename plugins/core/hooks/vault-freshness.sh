#!/usr/bin/env bash
# vault-freshness — SessionStart hook (tier determinista de enforcement)
#
# Enfermedad que ataca: el vault canónico (en disco) no es lo que se consume
# al trabajar. El modelo NO puede detectar por sí mismo que un snapshot está
# desfasado, que faltan ficheros, o que un conector apunta a la cuenta
# equivocada — son huecos de observabilidad, no de prosa. Este hook corre
# SIEMPRE al abrir sesión e inyecta la verdad de tierra del vault en disco,
# más los guards que el modelo debe aplicar en tiempo de tool-call.
#
# Portable: descubre el vault desde CLAUDE_PROJECT_DIR (o cwd) buscando hacia
# arriba un directorio que contenga active-context.md. Si no lo encuentra,
# emite el aviso de "vault vacío" alineado con rules/session-open.md.
#
# Salida: JSON con hookSpecificOutput.additionalContext (contrato SessionStart).

set -uo pipefail

# --- localizar el vault --------------------------------------------------
start_dir="${CLAUDE_PROJECT_DIR:-$PWD}"
vault=""
dir="$start_dir"
for _ in 1 2 3 4 5 6; do
  if [ -f "$dir/active-context.md" ]; then vault="$dir"; break; fi
  # también acepta un subdir de conocimiento típico
  for cand in "$dir"/*-knowledge "$dir"/vault "$dir"/knowledge; do
    if [ -f "$cand/active-context.md" ]; then vault="$cand"; break 2; fi
  done
  parent="$(dirname "$dir")"
  [ "$parent" = "$dir" ] && break
  dir="$parent"
done

emit() {
  # $1 = texto de additionalContext (ya escapado como bloque)
  python3 - "$1" <<'PY' 2>/dev/null || printf '{"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":%s}}\n' "\"$1\""
import json,sys
print(json.dumps({"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":sys.argv[1]}}))
PY
}

if [ -z "$vault" ]; then
  emit "[vault-freshness] No se encontró un vault (ningún active-context.md desde ${start_dir} hacia arriba). Si esta sesión va a producir trabajo sustantivo, aplica la excepción de rules/session-open.md: AVISA y PREGUNTA antes de proceder. No trabajes de memoria."
  exit 0
fi

# --- fingerprint canónico del vault en disco -----------------------------
head_line="(sin git)"
git_state=""
if git -C "$vault" rev-parse --git-dir >/dev/null 2>&1; then
  sha="$(git -C "$vault" rev-parse --short HEAD 2>/dev/null)"
  when="$(git -C "$vault" log -1 --format=%cd --date=short 2>/dev/null)"
  head_line="${sha:-?} (${when:-?})"
  dirty="$(git -C "$vault" status --porcelain 2>/dev/null | wc -l | tr -d ' ')"
  ahead="$(git -C "$vault" rev-list --count @{u}..HEAD 2>/dev/null || echo '?')"
  behind="$(git -C "$vault" rev-list --count HEAD..@{u} 2>/dev/null || echo '?')"
  git_state="working-tree dirty=${dirty} · local ahead=${ahead} behind=${behind}"
fi

# inventario de ficheros clave (people.md fue el fallo real de la retro; roadmap.md
# entró el 2026-08-18, cuando llevaba 24 días afirmando como pendientes dos cosas
# ya hechas y nadie lo abría al empezar — es la quinta categoría de session-open, y
# aquí es donde deja de ser prosa)
inv=""
for f in active-context.md roadmap.md decisions.md gotchas.md people.md working-preferences.md feedback.md; do
  if [ -f "$vault/$f" ]; then inv="${inv}${f} "; else inv="${inv}${f}(FALTA) "; fi
done

expected_identity="(no declarada)"
[ -f "$vault/.vault-identity" ] && expected_identity="$(head -1 "$vault/.vault-identity" 2>/dev/null)"

ctx="[vault-freshness · verdad de tierra al arrancar]
Vault CANÓNICO en disco: ${vault}
  · HEAD: ${head_line}
  · ${git_state}
  · Ficheros clave: ${inv}
  · Identidad esperada del proyecto: ${expected_identity}

Guards que DEBES aplicar en esta sesión (el hook no puede hacerlos por ti):
1. El vault en disco es la ÚNICA fuente de verdad. Si un snapshot de project-knowledge o cualquier contexto que te dieron difiere de lo de arriba (p.ej. marca un fichero que aquí aparece como FALTA, o un HEAD distinto), IGNORA el snapshot y lee el vault en disco. Avisa del desfase.
2. Antes de leer correo/datos por un conector, CONFIRMA que la cuenta conectada coincide con la identidad esperada de arriba. Si dice landbot.io cuando el proyecto es otro, para y avísalo — no asumas.
3. Si un fichero clave figura como (FALTA) y la tarea lo necesita, aplica la excepción de session-open: avisa y pregunta, no procedas de memoria."

emit "$ctx"
exit 0
