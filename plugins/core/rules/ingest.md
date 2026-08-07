# Ingesta

Regla del componente. Entrada al vault de material externo: handoffs de otras conversaciones, outputs de agentes ajenos, PDFs, páginas de Notion, URLs. Su deliverable es **memoria**, no un documento ni un commit.

## El gate (igual que capture)

La ingesta nunca aterriza en silencio. El flujo es:

1. Procesar el material crudo.
2. Presentar a Andrés una **preview resumida** de lo que se va a guardar.
3. Andrés audita y aprueba.
4. Solo entonces aterriza en el vault.

Capture e ingesta comparten este gate: "propón resumen → apruebo → aterriza". Es la misma puerta para toda memoria que entra al vault, venga de dentro (sesión) o de fuera (ingesta).

## Procesamiento

Hacer las dos cosas:

- **Destilar** el material a los tipos del esquema del vault (decisiones, gotchas, etc.), siguiendo `SCHEMA.md`.
- **Conservar el crudo** como referencia, por si hay que volver al original.

## Scrub de datos sensibles

Igual que en capture (ver `session-close.md`): último paso antes de escribir, barrer nombres de
clientes reales, credenciales, URLs internas y datos identificantes; genericizar u omitir. En
ingesta aplica **también al crudo que se conserva**: si el original trae datos sensibles, el crudo
se guarda redactado y se anota que se redactó.

## Dos niveles de confianza

- **preview-aprobado** (ligero): pasó el vistazo de Andrés al resumen. Entra utilizable pero marcado `validated: false`.
- **validado-a-fondo** (pesado): leído y confirmado en detalle por un humano. Marcado `validated: true`.

El retrieve trata lo `validated: false` como señal más débil.

## Conflictos

Si lo que entra contradice algo que ya está en el vault: **lo validado-a-fondo gana** sobre lo recién ingerido. No se sobrescribe contenido validado con material que solo pasó la preview; se marca y se pregunta.

## Subagente

La destilación de material crudo y gordo (un PDF largo, una transcripción) puede correr en un subagente: procesa el ruido y devuelve solo la preview-resumen que Andrés aprueba. El subagente reporta al orquestador, nunca a otro subagente.
