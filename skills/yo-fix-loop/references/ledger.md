# Finding ledger

Use a ledger when multiple source findings can be lost, duplicated, reordered,
or partially satisfied. Keep it in the session unless the repository already
has a tracker or the user requests a durable artifact.

## Compact shape

| ID | Source | Intent | Claim | Cluster | Priority | State | Acceptance | Evidence or next step |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| R1 | PR thread link | required | Null currency must not crash checkout | C1 | high | verified | checkout accepts missing currency | focused test command and result |
| R2 | audit F-07 | required | Same formatter dereference | C1 | high | duplicate of R1 | covered by C1 | exact overlap note |
| R3 | PR thread link | optional | Rename local variable | C2 | low | accepted-no-change | not applicable | existing name follows local convention |

Use stable source IDs. A cluster ID represents one root cause or one coherent
remediation, not merely adjacent files.

## States

- **candidate** - captured but not yet evaluated.
- **confirmed** - premise is supported and disposition is not yet planned.
- **planned** - assigned to a remediation cluster with acceptance proof.
- **in-progress** - current code or tests are being changed.
- **fixed-unverified** - an implementation exists, but the acceptance proof has
  not passed. This is never done.
- **verified** - the exact claim passed its acceptance proof on the current
  working state.
- **refuted** - the claim is false or stale, with contrary evidence.
- **duplicate** - another row represents the same claim; record the target ID or
  cluster and ensure its proof really covers this row.
- **accepted-no-change** - no edit is warranted. Record the technical rationale
  and, for a consequential required item, the decision authority.
- **deferred** - valid but intentionally outside the current wave. Record why,
  who owns the decision, and the next tracking location if one is authorized.
- **blocked** - valid and in scope, but a named prerequisite is unavailable.
- **unresolved** - evidence is insufficient or contradictory. Record exactly
  what would resolve it.

`blocked`, `unresolved`, and unauthorized `deferred` required work prevent a
complete-wave claim. Reopen `verified` when later evidence or a changed revision
invalidates its proof; do not preserve a stale green state for appearances.

## Source intent is separate from state

Store whether the source is required, a question, optional, a nit, FYI, or
unclear. For example:

- a required finding can become `refuted`;
- a question can become `accepted-no-change` after an evidenced answer;
- an optional suggestion can become `verified` if applied;
- a duplicate can still be required at its source.

This separation prevents two common errors: implementing every comment as a
blocker and dismissing a serious question because it was not phrased as an
order.

## Priority is contextual

Prefer the project's existing scheme. Otherwise record a short order rationale
from impact, urgency, dependencies, confidence, remediation risk, and available
proof. Do not compute a fake numeric score when the inputs are qualitative.

Security severity is only one input. Environment, exposure, active exploitation,
customer impact, and available mitigations can change remediation priority.

## Evidence rules

Evidence should be reproducible and bound to the state being judged:

- command plus relevant result, including revision or working-tree context;
- runtime observation with inputs and expected/actual outcome;
- code trace with file and symbol references;
- explicit reason a test is not possible and the substitute proof used.

Avoid "looks fixed," screenshots without context, or a broad green suite that
never exercises the claim. Curate the relevant output; keep raw logs only when
they help another person reproduce the result.

## Reconciliation checklist

Before closing a wave:

- every intake source appears once;
- every duplicate points to a canonical row or cluster;
- every required row is verified, refuted, a proven duplicate, or an authorized
  no-change decision;
- each verified row cites current evidence;
- no fixed-unverified, blocked, or unresolved row is hidden;
- late feedback is included as an intake delta;
- combined-wave checks cover interactions between clusters.
