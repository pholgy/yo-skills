---
name: yo-workflow
description: Design and run a risk-based, read-only deep review when one pass cannot cover a broad, cross-cutting, or highly coupled system surface. Use for multi-flow audits, end-to-end authorization or data reviews, race and idempotency hunts, or one critical flow spanning many components; maps the system, selects a sequential or delegated review shape, discovers candidates, independently challenges them, and synthesizes confirmed findings, unresolved risks, and coverage limits.
---

# Yo Workflow

Run a deep review as a controlled evidence program:

> map -> discover -> challenge -> synthesize -> check completeness

The objective is high recall without exporting false certainty. This skill is read-only. It does not fix findings, change source, commit, post review comments, or mutate external systems.

## When to use it

Use this when review quality depends on systematic coverage across several flows, boundaries, states, or risk classes. A single named flow still qualifies when it crosses enough coupled components or carries high operational risk.

Use `yo-audit` instead for a bounded verification of one known change. Use `yo-incident` first while production is actively impaired. A simple focused code question does not need this orchestration.

## Operating principles

1. Bind every pass to the same immutable revision and declared environment.
2. Map the system before dividing the work; file count is not a system model.
3. Decompose only along boundaries that can be reviewed with limited shared state.
4. Use the simplest coordination shape that fits the task.
5. Treat model agreement as a lead, never as proof; ground decisions in code, tests, traces, configuration, and contracts.
6. `unresolved` is a valid result. Lack of confirmation is not refutation.
7. Preserve provenance, coverage, and uncertainty through synthesis.

## Phase 0: Frame the review contract

Record:

- repository and exact revision/base-head identity;
- review question, user intent, and desired confidence;
- in-scope flows/components and explicit exclusions;
- relevant deployment/configuration assumptions;
- read-only and external-state boundaries;
- effort/time constraint, if the user supplied one;
- required domain expertise or evidence that may be unavailable.

If the target moves, freeze the old report to its SHA and re-evaluate the delta before making a current-state claim.

## Phase 1: Build the system and coverage map

Trace before hunting. Identify:

- actors, entry points, trust and privilege boundaries;
- state stores, queues, caches, files, and external providers;
- data/control flow from source through transformations to sinks;
- happy, denied, failure, retry, timeout, cancellation, rollback, and recovery paths;
- assets and invariants such as authorization, conservation, uniqueness, ordering, idempotency, and auditability.

Create a flow-by-risk matrix using only relevant `yo-engineering` lenses:

- behavior/state correctness;
- authorization, security, and privacy;
- data integrity, migration, and compatibility;
- concurrency, ordering, retries, and idempotency;
- failures, fallbacks, cleanup, and recovery;
- observability, operability, and rollback;
- performance and resource bounds;
- user experience and accessibility where applicable.

Mark each cell `planned`, `covered`, `partial`, `blocked`, or `out of scope`, with evidence or reason. See [references/review-program.md](references/review-program.md).

## Phase 2: Select the execution architecture

Choose by task structure, not enthusiasm for agents:

- **Sequential single context:** strongly coupled flow, shared state, strict ordering, high tool density, or a surface that fits one context.
- **Parallel sectioning:** stable map with genuinely independent flows, components, or risk questions whose outputs can be reconciled later.
- **Central orchestrator-workers:** open-ended surface where useful partitions emerge during exploration and one coordinator must own scope, revision, coverage, and synthesis.
- **Targeted independent challenge:** material candidate where a fresh technical perspective is worth the added cost.

Do not use a swarm for a sequential reasoning problem. Do not split the same end-to-end invariant across workers unless one owner later re-traces it as a whole. Do not use majority vote to determine whether code is safe.

Start with the least complex shape and add a worker/pass only when it closes a distinct coverage gap or supplies meaningful independence. Detailed selection and delegation rules are in [references/orchestration.md](references/orchestration.md).

## Phase 3: Discovery passes

Each pass receives a narrow contract:

```markdown
Snapshot: <repo and immutable revision>
Objective: <flow, boundary, or risk question>
In scope: <entry points through sinks>
Invariants: <properties to preserve>
Exclusions: <owned elsewhere>
Evidence: trace real code/config/tests; do not infer deployment facts
Output: structured candidates plus coverage and unknowns
```

Trace real paths end to end. A discovery output is a candidate ledger, not a verdict:

```markdown
ID: <stable identifier>
Claim: <possible defect>
Scenario: <reachable input/state/sequence>
Location/path: <file:line and flow>
Invariant/consequence: <what could break and who observes it>
Evidence: <code, test, config, trace>
Unknowns: <facts needed to decide>
```

Do not spend discovery time designing fixes. Do not discard a candidate merely because its severity or reachability is not yet complete.

## Phase 4: Independent challenge

Challenge every material candidate. Use a fresh context for high-risk, ambiguous, or implementation-shaped conclusions when available; otherwise make a visibly separate opposing pass and disclose the weaker independence.

Give the challenger the claim, scenario, locations, snapshot, and raw evidence. Withhold the proposed fix and the finder's conclusion where practical. Ask the challenger to:

- prove or disprove reachability under declared configuration;
- locate guards, validation, ownership, cleanup, or compensating controls;
- test whether the stated invariant is actually violated;
- distinguish intended, unsupported, out-of-scope, and duplicate behavior;
- when the target is a change or comparison, record introduced, pre-existing,
  or unknown attribution separately from whether the defect is in scope;
- reproduce or obtain an independent evidence line where proportionate;
- calibrate consequence without relying on the finder's severity label.

Classify:

- **confirmed:** evidence supports the reachable defect and consequence;
- **refuted:** concrete counterevidence defeats the claim;
- **unresolved:** material fact or environment is unavailable or evidence conflicts;
- **out of scope:** the issue is real but outside the declared actors, flows,
  invariants, revision, or environment;
- **duplicate:** same causal mechanism as another candidate.

Refutation requires evidence. An inaccessible feature flag, repository, runtime, or customer state makes a candidate unresolved, not safe.

Pre-existing is attribution, not a disposition. A longstanding defect that is
reachable inside the declared snapshot and scope remains a confirmed finding.
Admission requires a concrete scenario, location or affected flow, violated
requirement or invariant, observable consequence, and evidence at the reviewed
snapshot; it never requires proof that a particular change introduced the defect.

## Phase 5: Synthesize centrally

The synthesizer owns the final judgment; it does not count votes. Reopen the material evidence and:

1. merge duplicates by causal mechanism while preserving every affected flow;
2. reconcile contradictions and retain unresolved disagreement;
3. apply the snapshot-review finding and severity contract from
   `references/review-program.md`, keeping attribution separate;
4. check cross-cutting invariants no single partition owned;
5. run a completeness pass against the original map, exclusions, and newly discovered boundaries;
6. confirm every claim remains bound to the reviewed snapshot.

For critical security, privacy, safety, financial, or domain-specific conclusions, identify any qualified human/owner review still required. Multiple agents do not manufacture expertise.

## Stop conditions

Stop when:

- every scoped map cell is covered or explicitly partial/blocked/out of scope;
- every material candidate is confirmed, refuted, or explicitly unresolved;
- cross-partition invariants and shared components have an owner;
- the latest pass found no new high-risk boundary that remains unexplored;
- the snapshot is still current for the requested claim;
- or the authorized effort budget is exhausted and remaining gaps are reported.

Never claim completeness merely because no worker returned more findings.

## Output

```markdown
Snapshot: <repo, revision, environment assumptions>
Scope and architecture: <map boundary and why sequential/parallel/centralized>

Confirmed findings:
- [Severity] <file:line> <scenario, invariant, consequence, evidence>

Unresolved risks:
- <candidate, missing fact, next discriminating check>

Refuted / deduplicated:
- <short disposition and counterevidence or parent finding>

Coverage:
- <covered, partial, blocked, and excluded flows/lenses>

Verification and limits:
- <commands/evidence, independence level, domain-review needs>
```

If there are no confirmed findings, say so without converting unresolved or uncovered surfaces into a clean bill of health.

## Execution and publication boundary

Keep working notes in conversation memory or an approved temporary location outside the reviewed repository. Do not create scratch or report artifacts in the repo during a read-only review.

This skill owns review design and evidence contracts, not platform commands, models, or concurrency flags. When Claude delegates review work to Codex, `yo-codex` owns that execution. Otherwise use the current platform's native, authorized mechanism. All workers remain read-only and return results to the central synthesizer.

Return the report in chat by default. Use `yo-gh-write` only if the user explicitly asks to draft or publish a GitHub artifact.

## Guardrails

- Do not edit while reviewing or silently transition from finding to fixing.
- Do not parallelize tightly coupled sequential reasoning.
- Do not let workers review different revisions or undeclared environments.
- Do not propagate another worker's conclusion as evidence.
- Do not call an unconfirmed candidate refuted.
- Do not suppress dissent or uncertainty to make synthesis look clean.
- Do not run production-impacting experiments to settle a review finding.
- Do not prescribe a model, shell, agent count, or fixed concurrency in this skill.

## Handoff

- `yo-audit` independently verifies a specific completed change.
- `yo-verify-premise` checks a disputed candidate before action.
- `yo-debug` traces a confirmed failure whose mechanism remains unknown.
- `yo-fix-loop` triages confirmed findings after the user authorizes edits.

## References

- [Orchestration architecture](references/orchestration.md)
- [Review program and schemas](references/review-program.md)
- [Research and decisions](references/sources.md)
