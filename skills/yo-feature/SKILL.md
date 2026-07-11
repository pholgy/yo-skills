---
name: yo-feature
description: Build a new capability or materially extend product behavior from intent through verified implementation. Use for "build/add/implement" requests that require scope, acceptance criteria, design or impact checks, thin delivery slices, integration proof, rollout planning, and an honest local or shipped handoff; not primarily for diagnosing an existing bug or clearing a list of findings.
---

# Yo Feature

Turn intent into a verified capability through small, coherent delivery slices. The default endpoint is an implemented and locally verified change. Commits, branches, pull requests, issue updates, deployment, and publication require the user's request or an already-authorized workflow.

## Calibrate before adding process

Choose depth by risk, uncertainty, and integration surface, not sentence length or file count:

- **Direct change:** clear, low-risk, one coherent slice with known verification.
- **Planned feature:** multiple behaviors/boundaries or unfamiliar code; use an internal/existing tracker and explicit slices.
- **Designed feature:** consequential contract, data, security, concurrency, operational, or costly-to-reverse decision; use `yo-design` before implementation.

A one-sentence destructive admin endpoint is not trivial. A many-file mechanical addition behind an established abstraction may still be straightforward.

## Workflow

### 1. Orient to current truth

Read repository instructions, status, relevant issue/spec/RFC, neighboring code/tests, and existing planning conventions. Preserve unrelated working-tree changes. Verify current behavior or assumptions that the feature depends on; use `yo-verify-premise` when the request asserts existing behavior that may be stale.

Identify the delivery boundary: local implementation only, a branch/PR, deployment, or another explicit endpoint. Do not infer the later actions from "build."

### 2. Form the smallest sufficient feature brief

Capture in the existing issue/RFC/plan or session plan unless the user asked for a new file:

```markdown
Outcome: <user/business result>
Actors and entry points: <who invokes what>
Acceptance examples: <observable given/when/then cases>
Non-goals: <scope exclusions>
Constraints/invariants: <contracts, data, auth, performance, operations>
Delivery/rollout boundary: <local, gated, staged, or shipped>
Open decisions: <only material unknowns>
```

Ask one focused question only when an answer would materially change behavior, safety, cost, or public contract. Otherwise state bounded assumptions and proceed.

### 3. Run proportional decision gates

- Use `yo-engineering` to classify relevant risk and verification depth.
- Use `yo-impact` before changing existing behavior, contracts, persisted/transmitted shapes, or shared infrastructure.
- Use `yo-design` for contested or architecturally significant choices.
- Use `yo-deps` before adding or materially upgrading a dependency.

Do not run every gate mechanically. Do not skip a gate merely because the feature is new; new routes and data flows already have consumers, authorization, and operational consequences.

### 4. Slice for value, learning, and safe integration

Create the smallest ordered slices that each produce one coherent, verifiable outcome. Prefer vertical slices through the necessary layers over horizontal piles of database/backend/frontend scaffolding.

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

Re-read the exact touched code and local patterns. Implement the smallest change that satisfies the slice acceptance criteria without speculative future infrastructure or unrelated cleanup.

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

Mark a slice complete only when its acceptance is observed and the repository remains in its declared integration state. Update project trackers only when authorized and only in the repository's established system.

### 7. Integrate the feature as a whole

After slices pass, verify interactions the slice checks cannot prove:

- every feature-level acceptance example;
- old/new, enabled/disabled, and authorized/denied states;
- cross-slice data/control flow, retries, ordering, and cleanup;
- migration, partial rollout, rollback, and retained-data behavior;
- observability, documentation, accessibility, support, and operational readiness;
- temporary flags, adapters, dual writes, and scaffolding have explicit retirement state.

Use staged or canary evidence only when deployment is in scope and authorized. A healthy build is not proof that the user outcome works.

### 8. Handoff at the authorized boundary

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
- Do not expand scope for adjacent refactors unless needed for the accepted slice.
- Do not continue implementation when discovery invalidates a material design decision; return to `yo-design`.

## Handoff relationships

- `yo-flow` routes new-capability work here.
- `yo-fix-loop` handles a list of existing findings; `yo-debug` handles an unexplained confirmed failure.
- `yo-engineering`, `yo-impact`, `yo-design`, and `yo-deps` provide proportional decision gates.
- `yo-test-coverage` and `yo-audit` strengthen verification.
- `yo-branch` and `yo-gh-write` own authorized delivery artifacts.

## References

- [Slicing and integration patterns](references/slicing.md)
- [Research and decisions](references/sources.md)
