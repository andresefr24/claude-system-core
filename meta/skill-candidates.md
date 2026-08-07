# Candidatas a skill

Ideas que aún NO cruzan el umbral de materialización. Sesgo hacia no crear: solo se construyen
cuando aparecen por tercera vez o en una pausa explícita de revisión. La retro las revisa.

| Candidata | Qué haría | Criterio para materializar |
|---|---|---|
| `capture-audit` | Auditar automáticamente lo que entra al vault | Cuando la aprobación manual de capture sea cuello de botella por volumen. **Evidencia nueva (insights 08-05):** el informe propone independientemente su versión madura ("self-healing vault pipeline": re-verificar cada claim del vault contra el código vivo, marcar STALE, redactar sensible, abrir PR semanal). Corrobora la idea y esboza el diseño; el criterio de materialización no cambia |
| Mecanismo de enforcement GENERAL (hook / output-gate que re-afirma contrato+routing+apertura) | Re-afirmar las reglas siempre-activas de juicio de forma estructural | **SIGUE EN ESPERA (retro 2026-07-25).** Ni el test del 24-jun ni la semana 19–26 dieron señal fresca de dilución en sesión fresca; el contrato aguantó con 0 fallos. La única evidencia (Handoff de memoria) fue sesión heredada. NO confundir con el hook de vault-freshness (v0.7.0), que ataca observabilidad, no dilución de prosa. Materializar solo si la dilución reaparece en sesiones frescas largas. |
| ~~Regla de comms (dentro de Docs)~~ | Audiencia + registro + canal como inputs de primera clase | **MATERIALIZADA en v0.7.0** (`rules/comms.md`). Cruzó regla de tres en la semana 19–26 (Security app, Cohort, Influencer). |
| Ops de volumen (pipeline / subagentes en serie) | Ejecutar loops repetitivos de alto volumen (montar N listas, contactar N personas) con checkpoints | Evidencia: sesión cohort (alto volumen + donde el sistema se diluyó). Es el "cuello de botella de volumen" que aparcamos en la decisión multi-agente vs. skills. **Reabrir esa decisión solo si recurre** — hoy es 1 ocurrencia clara. |
