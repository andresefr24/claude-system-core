---
name: ingest
description: Ingiere material externo al vault del proyecto — handoffs de otras conversaciones, reportes de agentes ajenos, PDFs, páginas de Notion, URLs. Úsala cuando Andrés diga "ingiere esto", "trae este handoff", "procesa esta conversación", "guarda este doc al vault", o pegue un documento/transcripción con intención de archivarlo. Destila al esquema del vault, conserva el crudo, y presenta una preview para aprobación antes de aterrizar. No aplica a charla casual.
---

# Ingesta

Para entrar material externo al vault, aplica `../../rules/ingest.md`.

Pasos:

1. Lee `rules/ingest.md` del plugin si no tienes su contenido en contexto.
2. Procesa el material crudo (si es gordo, considera un subagente que devuelva solo el resumen).
3. Destila a los tipos del esquema (`SCHEMA.md`) y conserva el crudo como referencia.
4. Marca lo entrante `validated: false` (preview-aprobado) hasta validación a fondo.
5. Presenta una **preview resumida** y espera la aprobación de Andrés antes de escribir al vault.
6. En conflicto con contenido ya validado-a-fondo, no sobrescribas: marca y pregunta.
