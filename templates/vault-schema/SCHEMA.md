# Esquema del vault

Todo vault de proyecto respeta este esquema para que el plugin lo lea igual sin importar
el proyecto.

| Archivo | Qué guarda |
|---|---|
| `active-context.md` | Estado actual: en qué se trabaja ahora, qué quedó abierto. |
| `decisions.md` | Decisiones tomadas, para no re-litigar ni contradecir. |
| `gotchas.md` | Trampas conocidas y cómo se resolvieron. |
| (normativos) | Archivos de reglas del proyecto: brand-identity.md, etc. |

## Flag de validación

El contenido ingerido de fuera entra con `validated: false` hasta que un humano lo
confirme a fondo. En un conflicto, lo validado-a-fondo gana sobre lo recién ingerido.
