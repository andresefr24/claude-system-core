# Candidatas a skill

Ideas que aún NO cruzan el umbral de materialización. Sesgo hacia no crear: solo se construyen
cuando aparecen por tercera vez o en una pausa explícita de revisión. La retro las revisa.

| Candidata | Qué haría | Criterio para materializar |
|---|---|---|
| `capture-audit` | Auditar automáticamente lo que entra al vault | Cuando la aprobación manual de capture sea cuello de botella por volumen |
| Mecanismo de enforcement (hook `SessionStart` / output-gate) | Re-afirmar las reglas siempre-activas (contrato, routing, apertura) de forma estructural, en vez de depender de instrucciones-en-prosa que compiten con un contexto largo | **EN ESPERA.** Test limpio 2026-06-24 NO confirmó enforcement débil: en sesión fresca el contrato/retrieve/capture dispararon completos. La falla del cohort se atribuye a dilución por contexto largo o sesión heredada. Materializar solo si la dilución reaparece en sesiones frescas que crezcan largas. |
| Regla de comms (dentro de Docs) | Tratar audiencia + registro + canal como inputs de primera clase al redactar mensajes a humanos (ej. registro venezolano "ustedes", "español llano hacia fuera", largo según canal) | Evidencia: 3+ sesiones (coordinadores de seguridad, influencers, BCN). Probablemente **regla dentro de Docs, no rama nueva**. Materializar cuando se decida formalizar o aparezca otra vez. Ya hay working-preference naciendo. |
| Ops de volumen (pipeline / subagentes en serie) | Ejecutar loops repetitivos de alto volumen (montar N listas, contactar N personas) con checkpoints | Evidencia: sesión cohort (alto volumen + donde el sistema se diluyó). Es el "cuello de botella de volumen" que aparcamos en la decisión multi-agente vs. skills. **Reabrir esa decisión solo si recurre** — hoy es 1 ocurrencia clara. |
