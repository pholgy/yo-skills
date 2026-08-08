---
name: yo-engineering
description: >-
  Apply a senior software-engineering risk and decision gate to broad or
  consequential work. Use when the user asks for "best engineer", "make it
  excellent", top-tier quality with less over-engineering, architecture or
  maintainability judgment, or when a change crosses API, data, security,
  privacy, concurrency, reliability, user-flow, or operational boundaries.
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

## Calibrate the process

Use this local Yo taxonomy to choose the lightest sufficient process. These
labels are bundle conventions, not an industry standard.

| Tier | Typical shape | Required response |
|---|---|---|
| S0 — direct | Local, reversible, no meaningful behavior or contract change | Make the narrow change and run the smallest relevant check. |
| S1 — scoped | Limited blast radius with observable behavior change | State the plan, map impact, run focused evidence, and self-review. |
| S2 — consequential | Cross-boundary API, data, security, concurrency, reliability, or user-flow risk | Write the engineering brief, apply matching risk lenses, define rollout and rollback, and obtain an independent audit. |
| S3 — controlled action | Destructive, externally visible, production-changing, policy-changing, or difficult to reverse | Confirm the exact target, consequences, recovery path, and specific user authorization before acting. |

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

Use `yo-impact` before modifying existing behavior to map consumers,
compatibility, history, and blast radius. Escalate the tier if that map is wider
than the initial framing.

## Choose a reversible path

Prefer self-contained changes that remain buildable, reviewable, and
revertible. When one direct slice is not possible, read
[the delivery patterns](references/delivery-patterns.md) and choose a staged
pattern that fits the repository and deployment model.

Do not use a line-count or calendar threshold as a substitute for judgment.
Split when a reviewer cannot understand the purpose and risk, when verification
cannot isolate failure, or when rollback would remove unrelated value.

## Hand off instead of duplicating

Attach the tier, brief, selected lenses, execution shape, and approval state to
the immediate Yo workflow. Include lane contracts only when delegation passed
the gate:

- architecture or an approach decision -> `yo-design`
- new capability -> `yo-feature`
- claimed bug -> `yo-verify-premise`; use `yo-debug` if confirmed but unexplained
- multiple findings -> `yo-fix-loop`
- completed consequential change -> `yo-audit`
- dependency decision -> `yo-deps`
- branch, GitHub text, or release -> `yo-branch`, `yo-gh-write`, or `yo-release`

Let the destination skill own its detailed procedure and subsequent handoffs.

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

## Completion gate

Do not claim completion from a plausible diff or stale green check. Run fresh
evidence against the state being handed off, report what was and was not
verified, and name residual risk. Then run the final simplification pass from
the Golden Engineering Standard: remove every new moving part that is not
required by acceptance, a current contract, a demonstrated risk, a repository
boundary, or faithful evidence, and rerun affected checks. Use `yo-audit` for
an independent check of S2 work before merge or release.

## Guardrails

- Do not add ceremony without corresponding risk.
- Do not invoke every lens by default.
- Do not hide scope expansion inside the implementation.
- Do not confuse more architecture, more process, or more code with higher
  quality.
- Do not delegate by tier, stack count, file count, or provider count alone.
- Do not treat speed and stability as opposing goals.
- Do not require any skill outside the Yo bundle.

Read [the research record](references/research.md) only when maintaining or
auditing this skill.
