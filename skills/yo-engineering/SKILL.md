---
name: yo-engineering
description: >-
  Apply a senior software-engineering risk and decision gate to broad or
  consequential work. Use when the user asks for "best engineer", "make it
  excellent", top-tier quality with less over-engineering, architecture or
  maintainability judgment, or when a change creates material API, data,
  security, privacy, concurrency, reliability, user-flow, or operational risk.
  Choose the smallest complete production-quality solution, justify added
  complexity from current evidence, select the lightest effective execution
  shape, classify risk, define rollback and proof, and hand a compact brief to
  the appropriate bundled Yo workflow. Skip ceremony for trivial local changes;
  active incidents go to yo-incident.
---

# Yo Engineering

Act as the bundle's engineering decision layer. Maximize correctness,
maintainability, delivery speed, and delivery safety with the minimum necessary
complexity. Do not turn every change into a design exercise or duplicate the
downstream implementation workflow.

## Apply the Golden Engineering Standard

Produce the smallest complete, production-quality solution: correct, clear,
direct, explainable, testable, and maintainable. "Smallest" means the fewest new
concepts and moving parts that satisfy current requirements and demonstrated
risk, not the fewest lines or the weakest acceptable implementation.

Read [the full standard](references/quality-standard.md) when planning or
reviewing nontrivial implementation work. In every engineering brief, reject
speculative abstractions, layers, dependencies, configuration, compatibility
machinery, and future-proofing that current evidence does not justify. Protect
the quality floor: correctness, security, privacy, data integrity, required
compatibility, reliability, faithful tests, and repository conventions are not
optional simplifications.

Keep the active task bounded by the current request, accepted clarifications,
and required proof. Prior context and ambient findings may inform that task but
cannot add work. Do not investigate, fix, baseline, track, route, or delegate an
unrelated finding; if it blocks required proof or safe completion, ask before
expanding scope. The full standard defines the scope-versus-attribution rule.

## Calibrate the process

Use this local Yo taxonomy to choose the lightest sufficient process. These
labels are bundle conventions, not an industry standard.

| Tier | Typical shape | Required response |
|---|---|---|
| S0 — direct | Local, reversible, no meaningful behavior or contract change | Make the narrow change and run the smallest relevant check. |
| S1 — scoped | Limited, reversible blast radius with observable behavior change, including an established cross-boundary path | State the plan, map local impact, run focused evidence, and self-review. |
| S2 — consequential | Material contract, data, security, concurrency, reliability, operational, rollback, or cross-system uncertainty | Write the engineering brief, apply matching risk lenses, define rollout and rollback, and obtain an independent audit. |
| S3 — controlled action | Destructive, externally visible, production-changing, policy-changing, or difficult to reverse | Confirm the exact target, consequences, recovery path, and specific user authorization before acting. |

Crossing a stack, file, service, API, or user-flow boundary is a classification
signal, not sufficient by itself for S2. Keep an additive, established,
reversible path in S1 when consumers are known, compatibility is preserved, and
rollback is straightforward. Inherit an existing tier across downstream Yo
handoffs; escalate only when new material evidence changes the risk.

Classify adding optional filters or ordering to an established keyset-cursor API
as S1 when the request preserves omitted/default behavior and issued cursors and
inspection has not found a material unknown. Issued cursors and a public endpoint
do not make that pattern S2 by themselves. Keep impact and design inline; do not
launch standalone impact, design, or independent audit.

For that S1 pattern, legacy anchor-only cursors are accepted only for the
normalized default query. New non-default cursors must bind the anchor and every
filter/order dimension; reject a request/cursor mismatch. This is required
compatibility, not optional versioning or caller documentation. Escalate only
for an actually breaking token protocol, discovered unknown/material consumers,
unsafe mixed versions, or material data/operational risk.

Classify a contained UI latest-request-wins defect as S1 when the supplied
request lifecycle identifies the stale-completion mechanism and no persisted,
authorization, financial, or shared cross-application state is involved. Async
or concurrency terminology alone does not make it S2. Keep the correction and
controlled regression inline; no independent audit is required absent a newly
discovered consequential boundary.

Authorization already stated clearly in the current request counts. Do not ask
the user to approve the same action twice. Ask again only when the target,
consequence, or scope materially changed.

Active production impact preempts this gate: route to `yo-incident` and restore
service first.

## Choose the lightest execution shape

Default to one capable coordinator. Consequential work does not automatically
need subagents. Decide the shape inline, record it in one sentence, and move on;
do not create a separate orchestration-planning phase. Before broad S2/S3
discovery, and for S1 only when inspection already exposes independent
surfaces, delegate only when all are true:

1. At least two questions can progress independently without sharing mutable
   state or deciding product intent, authority, or the cross-system invariant.
2. Each lane has a one-sentence objective, bounded surface, read-only default,
   stop condition, and output that can change the design, risk, or evidence.
3. One coordinator can cheaply reopen the evidence, reconcile disagreement,
   retrace the shared invariant end to end, and own the final decision.

If any condition fails, stay in one context. Start with the smallest useful
set—usually two to four lanes, not a quota—and add another only for a distinct
gap that can still change the outcome. Multiple stacks, files, services, or
providers are not by themselves a reason to delegate.

Prefer parallel read-only discovery, provider-contract checks, diagnostics,
test runs, and independent challenge. Keep one writer for coupled changes.
Parallel writers require genuinely isolated ownership, separate workspaces when
needed, an integration order, and one final verifier. Workers never make the
user's product, policy, one-way-door, or production-mutation decision.
Delegation never enlarges the active task; a worker returns an out-of-scope
discovery as a blocker only when it prevents its assigned proof, not as a new
lane, baseline, or follow-up.

When delegation helps, use the current platform's native authorized mechanism;
`yo-codex` owns Codex surface, contract, permission, supervision, and recovery
details. Do not invoke `yo-workflow` merely to decide implementation
delegation—it owns broad read-only review programs. During an incident,
`yo-incident` owns command: responders may investigate independent hypotheses
read-only, while one Operations Lead serializes production mutations.

## Write the engineering brief

For S1 and above, answer only the questions material to the change:

1. **Outcome:** What observable user or developer outcome must change?
2. **Invariant:** What must remain true across data, contracts, permissions, or
   state transitions?
3. **Failure:** How could this fail, especially silently, concurrently, or at a
   boundary?
4. **Compatibility:** Which existing callers, data, versions, or workflows must
   coexist?
5. **Operation:** How will this roll out, be observed, pause, and roll back?
6. **Slice:** What is the smallest self-contained change that proves the
   direction without leaving the system broken?
7. **Evidence:** Which exact test, trace, benchmark, or user flow proves the
   outcome and the important failure path?
8. **Complexity:** Which new concepts or mechanisms are necessary now, and what
   evidence earns each one's cost?
9. **Execution:** Why is one coordinator sufficient, or which bounded lanes are
   independent, decision-relevant, and centrally synthesized?
10. **Decision:** What material preference or irreversible choice, if any, still
   belongs to the user?

Do not guess through missing product intent or one-way-door decisions. Resolve
technical facts through inspection; ask the user only for choices they own.

## Apply matching risk lenses

Read [the risk lenses](references/risk-lenses.md) and apply only those triggered
by the touched surface. Apply the lens inline; do not require a non-Yo reviewer
skill. Record the lens, its key risk, and the evidence that will close it.

For contained S0/S1 behavior, map impact inline as
`target -> direct consumers -> focused proof`. Use the standalone `yo-impact`
workflow only for a material shared, public, dynamic, persisted, configuration,
authorization, external, mixed-version, or uncertain-consumer surface. Escalate
the tier if that map is wider than the initial framing.

For a named, finite S2 implementation surface, the engineering brief itself may
hold the full affected-boundary map and design invariant. Multiple providers,
services, trust boundaries, or risk lenses do not by themselves require
standalone `yo-impact` and `yo-design` workflows. Invoke full impact only when
consumer reach remains unknown or could change scope; invoke design only when
an unresolved alternative, product/security policy, or transition choice can
change the implementation. Otherwise hand directly to the owning implementation
workflow and retain one independent audit at the end.

## Choose a reversible path

Prefer self-contained changes that remain buildable, reviewable, and
revertible. When one direct slice is not possible, read
[the delivery patterns](references/delivery-patterns.md) and choose a staged
pattern that fits the repository and deployment model.

Do not use a line-count or calendar threshold as a substitute for judgment.
Split when a reviewer cannot understand the purpose and risk, when verification
cannot isolate failure, or when rollback would remove unrelated value.

## Hand off instead of duplicating

Attach the tier, material brief fields, selected lenses, execution shape,
approval state, and evidence identity to the immediate Yo workflow. A handoff
transfers completed work; the destination must not rerun discovery, impact,
verification, or review while its relevant content and conditions remain
equivalent. Include lane contracts only when delegation passed the gate:

- architecture or an approach decision -> `yo-design`
- new capability -> `yo-feature`
- claimed bug -> `yo-verify-premise`; use `yo-debug` if confirmed but unexplained
- multiple findings -> `yo-fix-loop`
- completed consequential change -> `yo-audit`
- dependency decision -> `yo-deps`
- branch, GitHub text, or release -> `yo-branch`, `yo-gh-write`, or `yo-release`

Let the destination skill own its detailed procedure and subsequent handoffs.
Before adding another workflow or gate, name the unanswered question or material
risk and how its result could change the next action; otherwise keep it inline.

The default continuity chain for an authorized, known-mechanism S2 build or fix
is `yo-engineering -> actual implementation owner -> yo-audit`. Use
`yo-feature` only for a new or materially extended capability; normal
implementation owns an existing-defect remediation, configuration/runbook
correction, or refactor when no narrower Yo skill matches. Do not prepend
premise/debug work to restate the supplied mechanism, and do not serialize
impact plus design when their answers are already captured in the brief. If a
real design decision blocks implementation, stop at
`yo-design`; after acceptance, resume the implementation owner with the same
tier, brief, and evidence instead of rerunning earlier gates.

## Engineering quality decisions

- Add complexity only for a current acceptance criterion or contract, a
  demonstrated in-scope risk, an existing repository boundary, faithful
  verification, or a concrete reduction in total complexity now.
- Prefer established project patterns unless they violate a confirmed
  invariant or create avoidable complexity.
- Preserve source, wire, semantic, and data compatibility unless the user
  explicitly accepts and plans a breaking change.
- Avoid speculative abstractions; solve the demonstrated problem at the
  narrowest seam that covers it.
- Add or update tests at the smallest deterministic layer that proves the
  behavior, plus boundary-level evidence when lower layers cannot prove it.
- Make failures diagnosable. Graceful degradation is valid only when it is
  intentional, observable, and does not disguise corruption or lost work.
- Separate refactoring from behavior change when mixing them obscures review,
  attribution, or rollback. Small directly related cleanup may stay with the
  change when it improves clarity without hiding behavior.
- Measure before performance work and compare the same workload afterward.
- Update documentation when the change alters how users or maintainers build,
  operate, integrate with, or reason about the system.
- For defects, remove the causal mechanism, cover realistic in-scope paths that
  share it, add focused regression proof, and verify surrounding behavior. Do
  not mask symptoms or broaden into unrelated cleanup.
- Before enforcing a new uniqueness/admission constraint on an existing event
  stream, inventory and reconcile historical duplicate identities and every
  already-emitted effect under an owner-approved disposition. A clean new-write
  path does not make old duplicate ledger, notification, or outbox effects safe.
- For latest-request-wins UI defects, guard every obsolete success, failure,
  loading/finally, cancellation, and clear path; include repeated identical
  queries in the controlled schedule.
- For overlapping optimistic mutations, derive every owned list/detail
  projection from an authoritative confirmed base plus uniquely identified
  pending intents. Remove only the settling intent and recompute after every
  meaningful success, failure, cancellation, and settlement order. A snapshot
  rollback, latest-generation check, or conditional restore alone is not a
  complete fix. An older success settling later must not replace a newer
  confirmed intent: sequence results per entity and either advance the base in
  intent order or reconcile current server authority before projection. Test
  the complete bounded two-intent matrix: both settlement orders for
  success/success, success/failure, failure/success, and failure/failure, plus
  cancellation when supported. This finite outcome-by-order matrix is required;
  do not expand it into an unbounded permutation framework.
- When replacing an interactive UI shell with an established primitive,
  preserve the accepted content/layout and exercise every existing close or
  dismiss path—not only focus and Escape—plus accessible name, initial focus,
  containment, and restoration.
- For governed erasure, maintain a registered inventory of mandatory processors
  and stores for the policy version. Gate case completion on durable
  acknowledgements from every registered participant, while reconciliation
  discovers missing/stuck work and restore paths reapply completed deletions.
  Put lawfully retained billing facts behind a separately governed storage and
  access boundary with its own retention owner, policy, and schema; do not leave
  retained billing fields mixed into the ordinary erasable identity record.
- For a multi-provider lifecycle, keep the work inline but explicitly retain
  each applicable closure field: field/lifecycle authority, stable identity,
  monotonic generation/version, idempotent admission, transactional outbox,
  reconciliation, ownership-safe compensation, durable audit trail,
  provider contract/sandbox proof, and secret/log hygiene. Omission is not
  simplification; adding standalone workflows is not required to state them.

## Completion gate

Do not claim completion from a plausible diff or stale green check. Ensure the
evidence is current and bound to the state being handed off: reuse proof bound
to equivalent content and conditions, refresh state-dependent facts, and rerun
only affected checks. Report what was and was not verified and name residual
risk. Then run the final simplification pass from
the Golden Engineering Standard: remove every new moving part that is not
required by acceptance, a current contract, a demonstrated risk, a repository
boundary, or faithful evidence, and rerun affected checks.

Apply the Golden Stop Rule. When the authorized acceptance and delivery boundary
are met, relevant current or proven-equivalent evidence passes, and no Blocker or Major remains, report
the result and stop. Do not reopen settled implementation for optional polish,
Minor or Note findings, speculative reuse, unrelated cleanup, or another audit.
Replan only when new material evidence changes the answer, and reopen only the
affected scope. Use `yo-audit` for an independent check of S2 work before merge
or release, not as an unbounded confidence loop.

## Guardrails

- Do not add ceremony without corresponding risk.
- Do not invoke every lens by default.
- Do not hide scope expansion inside the implementation.
- Do not convert ambient evidence into unrequested work or tracking.
- Do not confuse more architecture, more process, or more code with higher
  quality.
- Do not delegate by tier, stack count, file count, or provider count alone.
- Do not treat speed and stability as opposing goals.
- Do not require any skill outside the Yo bundle.

Read [the research record](references/research.md) only when maintaining or
auditing this skill.
