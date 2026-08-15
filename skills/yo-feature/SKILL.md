---
name: yo-feature
description: Build a new capability or materially extend product behavior from intent through verified implementation. Use for "build/add/implement" requests that require scope, acceptance criteria, design or impact checks, thin delivery slices, integration proof, rollout planning, and an honest local or shipped handoff; not primarily for diagnosing an existing bug or clearing a list of findings.
---

# Yo Feature

Turn intent into a verified capability through the smallest complete,
production-quality solution. Prefer direct, explainable code and the fewest new
concepts that satisfy current acceptance and demonstrated risk. The default
endpoint is an implemented and locally verified change. Commits, branches,
pull requests, issue updates, deployment, and publication require the user's
request or an already-authorized workflow.

## Calibrate before adding process

Choose depth by risk, uncertainty, and integration surface, not sentence length or file count:

- **Direct change:** clear, low-risk, one coherent slice with known verification.
- **Planned feature:** multiple behaviors/boundaries or unfamiliar code; use an internal/existing tracker and explicit slices.
- **Designed feature:** a consequential contract, data, security, concurrency,
  operational, or costly-to-reverse decision remains unresolved; use
  `yo-design` before implementation only when resolving it can change the
  approach. A consequential but already-settled pattern stays in the inherited
  engineering brief and feature workflow.

A one-sentence destructive admin endpoint is not trivial. A many-file mechanical addition behind an established abstraction may still be straightforward.

## Workflow

### 1. Orient to current truth

Read repository instructions, status, relevant issue/spec/RFC, neighboring code/tests, and existing planning conventions. Preserve unrelated working-tree changes. Verify current behavior or assumptions that the feature depends on; use `yo-verify-premise` when the request asserts existing behavior that may be stale.

The current request and accepted clarifications define the feature. Read an
issue, failure, TODO, or adjacent surface only when it is named by that task or
strictly needed for its acceptance. Discovery does not authorize another slice,
fix, baseline, tracker update, or follow-up.

Identify the delivery boundary: local implementation only, a branch/PR, deployment, or another explicit endpoint. Do not infer the later actions from "build."

### 2. Form the smallest sufficient feature brief

Capture in the existing issue/RFC/plan or session plan unless the user asked for a new file:

```markdown
Outcome: <user/business result>
Actors and entry points: <who invokes what>
Acceptance examples: <observable given/when/then cases>
Non-goals: <scope exclusions>
Constraints/invariants: <contracts, data, auth, performance, operations>
Complexity budget: <new concepts/mechanisms required now and why>
Delivery/rollout boundary: <local, gated, staged, or shipped>
Open decisions: <only material unknowns>
```

For one direct slice, keep the brief to the acceptance, non-goal, and proof that
actually constrain the change; omit empty fields instead of filling a template
for ceremony.

Ask one focused question only when an answer would materially change behavior, safety, cost, or public contract. Otherwise state bounded assumptions and proceed.

### 3. Run proportional decision gates

- Inherit a supplied Yo risk tier and valid evidence. When none exists, classify
  risk inline; invoke the full `yo-engineering` gate only for broad or
  consequential judgment, not every direct feature.
- For contained existing behavior with known consumers, map impact inline as
  `target -> direct consumers -> focused proof`. Use `yo-impact` for material
  contracts, persisted/transmitted shapes, shared infrastructure, dynamic or
  external consumers, authorization, mixed versions, or uncertain blast radius.
  A small established, additive, reversible query-parameter or response-field
  extension with known consumers may remain inline when compatibility is
  preserved.
  The same is true for an established cursor endpoint when the default path and
  issued cursors remain valid. For non-default filtered/ordered pagination,
  bind every query dimension into the cursor or reject mismatches; an anchor-
  only cursor plus a caller promise to repeat parameters is not sufficient.
- Use `yo-design` for contested or architecturally significant choices.
- Use `yo-deps` before adding or materially upgrading a dependency.

Do not run every gate mechanically. A handoff carries completed decisions and
evidence; do not restart them without changed content, conditions, or material
risk. Do not skip a gate merely because the feature is new; new routes and data
flows already have consumers, authorization, and operational consequences.

When an inherited S2 engineering brief already names the finite services or
providers, field/lifecycle authority, stable identities, failure model,
transition, and proof, keep that impact/design record inside this feature and
implement it. Provider count is not an impact or design trigger. Invoke a
standalone gate only when a specific unknown consumer or unresolved alternative
can still change scope or architecture; do not repeat the same integration
record in three workflows.

For that inline multi-provider record, preserve every applicable closure item:
field/lifecycle authority and stable identity; monotonic lifecycle generation;
idempotent inbox/admission; deterministic internal state; transactional outbox;
recurring reconciliation; ownership-safe adoption/compensation; durable audit
trail; provider contract or sandbox tests including partial failure; and secret
references plus log/error redaction. These are implementation acceptance fields,
not reasons to launch additional workflows.

#### Cursor compatibility invariant

When adding filter or direction dimensions to a keyset cursor:

- preserve the legacy cursor format and semantics for the normalized default
  request;
- accept legacy cursors only on that default semantic path;
- issue a new opaque/versioned cursor for non-default requests that binds the
  anchor plus every filter and direction dimension affecting page membership or
  order; and
- reject an explicit request/cursor dimension mismatch.

Inspect the actual query plan and index contract as part of this slice. Each
supported filtered/order path needs an index whose leading equality dimensions
and complete deterministic ordering tuple match the keyset predicate; reverse
both tuple comparison and ordering for reverse traversal. Reuse a proven
existing index when it satisfies the plan—do not add one ceremonially.

Do not interpret an anchor-only legacy cursor under non-default dimensions and
do not rely on documentation that asks the caller to repeat parameters. This is
the smallest complete compatibility rule, not a generic cursor framework.

For a fixed set of filters local to one UI surface, keep the URL impact map and
typed parse/serialize decision inline. A hypothetical larger filter set does not
earn a registry, schema framework, or standalone design/impact workflow.
Preserve the surface's established navigation-history contract: user filter
changes must create or update history intentionally, and back/forward must
restore the exact three-filter state while unrelated query parameters survive.
Do not silently replace every navigation merely to simplify synchronization.
The URL is canonical: parsing absent, malformed, duplicate, or noncanonical
values must produce the documented state and, when normalization is needed,
write one canonical URL using the appropriate replace/history behavior without
losing unrelated parameters or creating a feedback loop.

### 4. Slice for value, learning, and safe integration

Create the smallest ordered slices that each produce one coherent, verifiable outcome. Prefer vertical slices through the necessary layers over horizontal piles of database/backend/frontend scaffolding.

If one direct change can completely satisfy acceptance and remain easy to
review and verify, use one slice. Do not manufacture scaffolding, phases, or
tracking ceremony merely because this workflow supports larger features.

A useful first slice may be a walking skeleton that proves a risky end-to-end integration with minimal behavior. Later slices add meaningful cases, policies, scale, or polish. A technical-enabling slice is acceptable when it leaves the repository working, is needed by a near-term value slice, and has a clear consumer.

For each slice record:

```markdown
Slice: <observable outcome or learning goal>
Acceptance: <specific behavior/invariant>
Boundaries affected: <interfaces, data, auth, operations>
Dependencies: <prior slice or external decision>
Verification: <faithful tests and manual/runtime evidence>
Integration state: <deployable, inert, gated, or not independently landable>
```

Keep one implementation slice active at a time when slices share code or state. Parallelize only genuinely independent read-only discovery or independently owned changes with a reconciliation plan. `yo-branch`, not this skill, decides commit and branch topology.

See [references/slicing.md](references/slicing.md) for split patterns.

### 5. Implement one slice

Re-read the exact touched code and local patterns. Implement the smallest
complete change that satisfies the slice acceptance criteria without
speculative future infrastructure or unrelated cleanup. Reuse an existing
local pattern directly when it fits.

Every new abstraction, interface, factory, dependency, configuration value,
state, compatibility bridge, flag, queue, cache, retry, or layer needs a current
acceptance, contract, demonstrated risk, repository-boundary, or verification
reason. A hypothetical second implementation, future provider, future scale,
or possible requirement is not enough. Add the mechanism when evidence earns
it; otherwise keep the logic concrete and local.

Design the proof at the faithful layer before or alongside production code:

- focused tests for local behavior;
- component/contract tests for boundaries;
- integration tests for data, transactions, queues, or processes;
- end-to-end/manual checks where emergent UI or runtime behavior cannot be proven lower.

Use `yo-test-coverage` for regression-sensitive or characterization needs. Test-first is optional; a trustworthy oracle and change-sensitive test are not.

For incomplete multi-slice work, keep the system usable and compatible. Feature flags, branch by abstraction, parallel change, or an inert entry point may help, but each temporary mechanism needs an owner, safe default, observability, and removal condition. Never use a flag to bypass authorization or data compatibility.

### 6. Verify the slice

Run evidence proportionate to its risk:

1. focused acceptance tests;
2. relevant surrounding/contract/integration tests;
3. lint/type/build or repository gate affected by the change;
4. realistic user/runtime exercise for UI, provider, migration, or operational behavior;
5. `yo-audit` for a material completed change when independent verification is required.

Verify negative and failure paths, not only the happy path. Bind evidence to the current revision/environment and distinguish unavailable proof from a pass.

An unrelated failure revealed by a broader command remains outside this
feature. Do not investigate, fix, baseline, assign, link, or create follow-up
work for it. If it prevents a required gate from proving the feature, report the
limitation and ask before bringing the separate work into scope.

Before marking the slice complete, run a simplification pass over the final
diff. Remove any new file, type, helper, branch, configuration, dependency, or
indirection that does not protect acceptance, an invariant, a supported
contract, or faithful evidence. Rerun affected checks after simplifying.

Mark a slice complete only when its acceptance is observed and the repository remains in its declared integration state. Update project trackers only when authorized and only in the repository's established system.

### 7. Integrate the feature as a whole

After slices pass, verify interactions the slice checks cannot prove:

Apply only dimensions introduced, touched, or named by acceptance and risk.
Omitting an inapplicable dimension is not a gap and needs no `N/A` record.

- every feature-level acceptance example;
- old/new, enabled/disabled, and authorized/denied states;
- cross-slice data/control flow, retries, ordering, and cleanup;
- migration, partial rollout, rollback, and retained-data behavior;
- observability, documentation, accessibility, support, and operational readiness;
- temporary flags, adapters, dual writes, and scaffolding have explicit retirement state.

Use staged or canary evidence only when deployment is in scope and authorized. A healthy build is not proof that the user outcome works.

### 8. Handoff at the authorized boundary

When feature-level acceptance and the requested delivery boundary are met,
relevant current or proven-equivalent evidence passes, and no Blocker or Major remains, treat the work
as terminal: report and stop. Do not manufacture another slice for optional
polish, possible future reuse, unrelated cleanup, or extra confidence. Reopen
only the smallest slice invalidated by new material evidence.

Report:

```markdown
Outcome: <implemented capability>
Slices: <completed/remaining>
Verification: <commands, counts, runtime evidence>
Rollout/compatibility: <state and limits>
Working tree / delivery state: <uncommitted, committed, PR, deployed>
Open risks: <none or explicit gaps>
```

If work is partial, say exactly which behavior is usable and what remains. Do not call a hidden, unverified, or unintegrated path complete.

If commit/PR work was requested, use `yo-branch` for readiness and topology, then `yo-gh-write` for the artifact. Auditing or building a feature does not by itself authorize GitHub writes or deployment.

## Planning and context discipline

- Reuse the repository's issue, RFC, plan, project board, or feature tracker; do not force root `SPEC.md` or `features.json` files.
- Keep the active brief and slice state concise enough to re-derive from current code and evidence.
- Preserve paths, symbols, decisions, assumptions, and commands; do not paste large stale code blobs into tracking artifacts.
- After interruption or context change, recheck repository status, current revision, and slice evidence before resuming.
- Avoid carrying more than one coupled implementation slice as work in progress.

## Guardrails

- Do not classify by how briefly the user described the feature.
- Do not create planning files, commits, branches, PRs, comments, or deployments without authority.
- Do not duplicate an existing planning/tracking convention.
- Do not split exclusively by technical layer when no slice proves behavior or learning.
- Do not mark acceptance complete from implementation inspection alone.
- Do not let a passing test with the wrong oracle stand in for the user outcome.
- Do not leave compatibility bridges or feature flags without retirement ownership.
- Do not add an extension point, generic framework, configuration surface, or
  operational mechanism for an unrequested future.
- Do not optimize for raw line count when a slightly larger direct solution is
  clearer or required for correctness.
- Do not expand scope for adjacent refactors unless needed for the accepted slice.
- Do not turn discovered repository work into another slice or tracking item.
- Do not continue after the accepted feature is proven merely because another
  improvement is possible.
- Do not continue implementation when discovery invalidates a material design decision; return to `yo-design`.

## Handoff relationships

- `yo-flow` routes new-capability work here.
- `yo-fix-loop` handles a list of existing findings; `yo-debug` handles an unexplained confirmed failure.
- `yo-engineering`, `yo-impact`, `yo-design`, and `yo-deps` provide proportional decision gates.
- `yo-test-coverage` resolves a materially ambiguous test strategy; `yo-audit`
  strengthens verification when consequence, policy, or an explicit request
  requires independence.
- `yo-branch` and `yo-gh-write` own authorized delivery artifacts.

## References

- [Slicing and integration patterns](references/slicing.md)
- [Research and decisions](references/sources.md)
