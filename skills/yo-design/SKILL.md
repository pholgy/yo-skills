---
name: yo-design
description: Analyze, draft, review, or record software designs and architecturally significant decisions before costly implementation. Use for public contracts, data models and migrations, trust/security boundaries, concurrency and reliability models, cross-service workflows, framework or protocol choices, substantial alternatives, design docs/RFCs, ADRs, and "should we choose A or B?" requests.
---

# Yo Design

Make consequential choices reviewable while they are still cheap to change, then preserve the rationale at the right level. Do not create repository artifacts or post them externally unless the user authorized that action.

## Choose the mode

- **Advise:** compare or recommend in chat; no file writes.
- **Draft:** produce a design/RFC/ADR draft in chat or a requested location, but do not treat it as accepted.
- **Record:** write an accepted decision into the repository's established decision-record convention.
- **Review:** evaluate an existing design or ADR read-only for missing drivers, weak alternatives, risks, and unverifiable claims.

If the user asks only for design, stop before implementation. If they ask to design and build, design is an internal gate; pause only when a material unresolved choice requires new user authority or changes product intent.

## When design work earns its cost

Use this workflow when one or more are true:

- the decision changes a public/wire contract, durable data, protocol, trust boundary, tenancy, or recovery model;
- rollback is costly, lossy, coordinated, or unavailable;
- several teams/components must share an invariant or interface;
- security, privacy, availability, performance, operability, or cost goals trade off materially;
- the approach is novel, uncertain, disputed, or requires a spike to validate;
- future maintainers will reasonably ask why this option won.

Do not trigger only because many files change or because a local Yo risk tier has a particular number. A large mechanical change may need an execution plan, not architecture. A small public schema choice may need a design and ADR.

## Select the artifact

| Need | Artifact |
|---|---|
| Advice or a reversible local choice | Chat/plan note |
| Proposed cross-cutting change that needs approach review | Design doc or repository RFC |
| One accepted architecturally significant decision | ADR/decision record |
| Proposal plus one or more accepted significant choices | Design doc plus separate ADRs |
| Status, sequencing, and task ownership | Implementation plan/spec, not an ADR |

Follow the repository's existing convention, template, numbering, location, status vocabulary, and ownership model. Do not create parallel `docs/design` or `docs/adr` systems when an RFC, proposal, decision log, wiki, or issue-based process already exists. See [references/artifacts.md](references/artifacts.md).

## Design workflow

### 1. Verify context and current state

Read repository guidance and relevant existing designs/ADRs. Confirm the problem, current architecture, affected consumers, and constraints using `yo-verify-premise` and `yo-impact` as appropriate.

Identify stakeholders and the actual decision owner. Separate facts, requirements, assumptions, preferences, and unknowns. A design cannot resolve a product decision that nobody has authorized it to make.

### 2. Define decision drivers

State:

- problem and user/business outcome;
- goals and explicit non-goals;
- invariants and constraints;
- prioritized quality scenarios, such as load, failure, attack, rollback, or evolution;
- decision criteria and how evidence will be obtained.

Use concrete scenarios rather than adjectives. "At 10x request load, p99 remains below the agreed target" is reviewable; "must be scalable" is not.

### 3. Develop viable alternatives

Include the current/status-quo approach only when it is viable. For each real option, compare the same decision drivers:

- correctness and invariant fit;
- compatibility and migration;
- failure/recovery and rollback;
- security/privacy and operational control;
- performance, capacity, and cost;
- implementation and long-term maintenance complexity;
- ecosystem maturity, team capability, and dependency risk.

Do not manufacture strawmen or use an unexplained weighted score to hide judgment. When uncertainty could change the decision, propose the smallest time-bounded spike, benchmark, threat model, or compatibility test that would discriminate among options.

### 4. Describe the proposed design

Write enough that a reviewer can trace important scenarios and object to the approach:

- components and ownership boundaries;
- key control/data flows and state transitions;
- APIs, schemas, events, and invariants;
- authorization and trust decisions;
- concurrency, idempotency, ordering, and consistency model;
- failure modes, cleanup, retries, degradation, and recovery;
- observability, operations, capacity/cost, and support implications.

Use diagrams only when relationships or sequence are materially clearer than prose. Keep implementation details out unless they constrain correctness or compatibility.

### 5. Design the transition, not only the end state

Cover old/new readers and writers, version skew, migration/backfill, partial rollout, rollback floor, feature gating, data retention, and decommissioning where relevant. Define the safe sequence and the signal that permits each transition.

For a truly reversible change, say why reversal is safe and what state must be cleaned up. "Rollback available" without a procedure or data story is not a design.

### 6. Define verification and operations

Map the important scenarios and invariants to evidence:

- focused, contract, integration, migration, load, security, and failure tests as relevant;
- rollout metrics, logs/traces, dashboards, alerts, and audit events;
- success thresholds, guardrails, rollback triggers, and post-rollout checks;
- unresolved risks and the evidence needed to close them.

The verification plan should be usable by `yo-feature`, `yo-audit`, and operators without rediscovering intent.

### 7. Review and decide

Surface open questions, decision owner, required reviewers, and decision deadline. Seek review before expensive implementation when the approach is still contestable.

Do not require ceremonial approval for an already-authorized, bounded decision. Do pause when alternatives imply materially different product behavior, irreversible data effects, public commitments, significant spend, or authority the user has not granted.

Record the outcome:

- accepted, with explicit rationale and consequences;
- rejected, with the deciding evidence;
- deferred, with the missing fact or trigger;
- experimental, with exit criteria and a revisit date/event.

## Design doc shape

Adapt to repository convention and consequence. Use the shortest document that makes the decision reviewable; there is no page quota.

```markdown
# <Title>
Status / owner / date / reviewers

## Context and problem evidence
## Goals, non-goals, constraints, and invariants
## Decision drivers and scenarios
## Current state
## Proposed design
## Alternatives and tradeoffs
## Failure, security/privacy, and operational analysis
## Compatibility, migration, rollout, and rollback
## Verification and observability
## Open questions and decision
```

Omit irrelevant sections and add domain-specific ones when they improve the decision.

## ADR lifecycle

An ADR records one accepted or proposed architecturally significant decision, not the full implementation design.

- A **Proposed** ADR may evolve during review.
- Once **Accepted**, do not silently rewrite the decision or historical rationale.
- Update status and supersession links according to repository convention.
- A changed decision gets a new ADR that supersedes the old record.
- A non-semantic factual correction, typo, or repaired source link may be amended transparently with a dated correction note or version-control history; it does not invent a new decision.
- A retroactive ADR must say it was recorded later, cite available evidence, and mark unknown rationale as unknown rather than reconstructing a convenient story.

Use the repository's template. A good record normally includes context/drivers, considered options, the decision, positive/negative consequences, validation or revisit triggers, status, date, and links.

## Review standard

A design is ready when:

- problem and current-state evidence are credible;
- goals, non-goals, invariants, and owners are explicit;
- at least the viable alternatives receive fair treatment;
- high-priority quality scenarios trace through the proposal;
- compatibility, failure, operations, and rollback are proportionate to risk;
- unknowns are visible and have closure evidence;
- the decision and consequences are distinguishable from implementation tasks.

## Guardrails

- Do not write files or post a design merely because this skill was invoked.
- Do not use a fixed page/file/risk-tier threshold as a substitute for significance.
- Do not design from a stale or unverified premise.
- Do not hide product choices inside technical assumptions.
- Do not treat an ADR as a task tracker, changelog, or broad architecture encyclopedia.
- Do not silently rewrite accepted rationale or fabricate retroactive intent.
- Do not let design continue indefinitely when a small experiment can settle the uncertainty.

## Handoff

- `yo-engineering` supplies proportional risk lenses and quality gates.
- `yo-impact` supplies consumer, compatibility, and transition surfaces.
- `yo-deps` evaluates a framework/library choice before it becomes a decision.
- `yo-feature` converts an accepted design into executable slices and verification.
- `yo-audit` uses the design and ADR as intent evidence, not proof of correctness.
- `yo-gh-write` formats or publishes design discussion only when explicitly requested.

## References

- [Artifact selection and lifecycle](references/artifacts.md)
- [Research and decisions](references/sources.md)
