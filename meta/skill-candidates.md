# Candidatas a skill

Ideas que aún NO cruzan el umbral de materialización. Sesgo hacia no crear: solo se construyen
cuando aparecen por tercera vez o en una pausa explícita de revisión. La retro las revisa.

| Candidata | Qué haría | Criterio para materializar |
|---|---|---|
| `capture-audit` | Auditar automáticamente lo que entra al vault | Cuando la aprobación manual de capture sea cuello de botella por volumen |
| Mecanismo de enforcement (hook `SessionStart` / output-gate) | Re-afirmar las reglas siempre-activas (contrato, routing, apertura) de forma estructural, en vez de depender de instrucciones-en-prosa que compiten con un contexto largo | **Evidencia: 1 ocurrencia** (sesión cohort 2026-06-13 — deliverables sustantivos sin contrato pese a instrucciones de proyecto). Materializar SOLO si el test limpio confirma enforcement débil; NO si resulta que era una sesión anterior al install. |
