# Inception — arranque de proyecto

Regla del componente. Montar un proyecto nuevo desde cero de forma consistente, para no reinventar la estructura cada vez. (Ya se repitió a mano con MintStash, la app de coordinadores de seguridad y la búsqueda de pisos — regla de tres cumplida.)

## Qué hace

1. **Scaffold del vault.** Copia `templates/vault-schema/` a la carpeta `{proyecto}-knowledge`: `active-context.md`, `decisions.md`, `gotchas.md`, `SCHEMA.md`, y añade un `CONVENTIONS.md`.
2. **Siembra `active-context.md`** con lo mínimo: qué es el proyecto, su objetivo, stakeholders, estado inicial. Pregunta lo que falte — **no inventes** contexto.
3. **Cablea la superficie:**
   - Proyecto de **código** → copia `CLAUDE.md.template` a la raíz del repo y rellena los placeholders.
   - **Cowork** → crea el Proyecto y pega `templates/cowork-project-instructions.md` como **instrucciones permanentes del proyecto**, no por conversación. (Lección del test 2026-06-24: las reglas always-on solo se sostienen a nivel de Proyecto.)
4. **Normativos desde el inicio.** Si el proyecto tiene reglas propias (marca, esquema de datos, tono), créalas como archivos normativos ya — la regla "nunca de memoria" depende de que existan.

## Qué NO hace

No llena el vault de archivos especulativos. Arranca con la base canónica (los 4 del esquema + `CONVENTIONS.md`); los archivos específicos (`people.md`, `roadmap.md`, `feedback.md`, etc.) nacen cuando el proyecto los pide, no antes.

## Frontera personal / laboral

Decisión abierta de Andrés: si inception aplica también a proyectos personales o solo laborales. Hasta que la cierre, **pregunta al arrancar** si el proyecto es personal o de trabajo — afecta dónde vive el vault y qué normativos aplican.
