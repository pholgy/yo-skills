# Premise evidence model

Choose evidence by how well it distinguishes the live claim, not by how
impressive or expensive the check looks.

## Evidence selection

| Evidence | Strong when | Important limit |
|---|---|---|
| Controlled reproduction | It matches the reported input, revision, environment, and configuration | A passing attempt in different conditions does not disprove an intermittent or environment-specific failure. |
| Focused automated test | It exercises the reported boundary and would fail for the claimed defect | A test can encode the wrong expectation or miss production configuration. Read it. |
| Current code and configuration trace | The claim is deterministic and every reachable condition can be established statically | Dynamic state, generated behavior, reflection, deployment config, or external systems may invalidate the trace. |
| Logs, traces, metrics, crash artifacts | They are bound to the relevant timestamp, request, build, and environment | They may prove a symptom without proving the proposed cause. Redaction or sampling can hide context. |
| Contract or specification | It establishes expected behavior authoritatively | It does not prove the implementation or deployed state conforms. |
| History and linked change | It shows when and why behavior changed or suggests that a reported target may be stale | A guard, diff, or commit message is not runtime proof. Trace the reported path and, when practical, run its focused behavior check. |
| Reporter narrative | It supplies conditions, observations, and leads | Treat proposed location, cause, severity, and fix as hypotheses until supported. |

Use multiple evidence types when one cannot close the claim. Prefer independent
agreement between runtime behavior, current source, and the stated contract.

## Confidence language

- **Proves within tested conditions:** decisive result for the named target and
  conditions.
- **Supports:** increases confidence but leaves plausible alternatives.
- **Contradicts:** conflicts with the claim but may not cover every condition.
- **Does not address:** looks relevant but cannot distinguish the claim.

Avoid "works" or "fixed" without naming the target and conditions.

## Verdict distinctions

- `Not reproduced` describes a test result.
- `Disproved` requires evidence that rules out the claim on the target.
- `Stale` means the report described an older state and a current trace or
  behavior check shows the relevant path changed.
- `Insufficient evidence` means a decisive check cannot currently be made.
- A symptom can be `Confirmed` while its reported cause remains `Unknown`.

Cause states:

- `Known` — the mechanism explains the material conditions and supports a
  justified next intervention.
- `Probable` — evidence favors the mechanism but a plausible alternative
  remains.
- `Unknown` — only the symptom or failing boundary is established.
- `Not applicable` — the claim was disproved or does not assert a failure cause.

Do not label the nearest error, exception, or failing component as a known cause
when the reason it failed remains unexplained.

## Efficiency rules

1. Start with the highest-likelihood, lowest-risk discriminating check.
2. Reuse existing evidence when its target and conditions match.
3. Stop once the verdict and next owner are supported; do not collect evidence
   for ceremony.
4. Escalate to instrumentation or environment reproduction only when cheaper
   evidence cannot distinguish the remaining hypotheses.
5. Preserve commands, outputs, revisions, and limitations so the next workflow
   does not repeat the investigation.
