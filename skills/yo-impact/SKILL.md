---
name: yo-impact
description: Map consumers, contracts, persisted data, sibling paths, and observable effects before changing existing behavior or integrating a new boundary. Use after the premise and cause are understood, before fixes, refactors, signature or schema changes, routes, config changes, migrations, and standalone "where is this used?" or "is this safe to change?" requests.
---

# Yo Impact

Map what can observe a proposed change before editing. The output is a compact impact brief and a one-sentence blast-radius summary, not permission to implement or a ritual search quota.

## Calibrate the depth

Analyze the integration surface, not whether the diff adds or edits lines.

- Skip only S0 wording/formatting changes and truly isolated, unused artifacts with no integration point.
- For a private local symbol with one known caller, inspect the definition, caller, focused tests, and plausible dynamic references. Stop when the evidence closes the local surface.
- For routes, schemas, serialized fields, data, auth, config, public exports, jobs, events, or operational behavior, map the relevant boundary even when the code is new.
- If the map reveals multiple components, irreversible data effects, or a staged transition, use `yo-engineering` to reclassify risk and `yo-design` when a design is needed.

Do not turn a small edit into archaeology. Do not call a boundary change "additive" to avoid compatibility analysis.

## Workflow

### 1. State the proposed observable delta

Name the exact target and the before/after behavior. Include the relevant revision and environment when they matter.

Examples of observable deltas include:

- source or type shape;
- wire name, default, validation rule, or error response;
- stored representation or migration behavior;
- ordering, timing, retries, or side-effect count;
- permission, audit, logging, metric, or user-visible behavior.

If the intended delta is unclear, resolve that before mapping its impact.

### 2. Recover rationale when it changes the decision

Read nearby code, comments, tests, and documentation first. Consult file or line history when the behavior is surprising, workaround-like, security-sensitive, or likely to encode an earlier tradeoff. Follow the introducing commit or linked review when available.

History provides provenance and rationale leads; it does not prove that the old behavior is still correct. A deliberate earlier choice is evidence to reconcile with the current request, not an automatic veto. Record uncertainty when the rationale cannot be recovered.

### 3. Map consumers and boundaries

Use the search layers in [references/search-strategy.md](references/search-strategy.md). Cover only the layers plausible for this change, but do not rely on compiler references alone when names or values cross dynamic, generated, persisted, or external boundaries.

For every discovered site, identify whether it defines, produces, consumes, validates, stores, forwards, documents, monitors, or tests the behavior. State the repository and environment boundaries searched. Unknown external consumers remain an explicit unknown; "none found" means none found within the declared search scope.

### 4. Classify what each observer can notice

Check the dimensions relevant to the change:

- **Source:** callers, implementors, imports, and generated clients still build.
- **Wire:** field names, routes, status codes, defaults, and encodings remain readable.
- **Semantic:** valid requests retain intended meaning, including edge cases.
- **Data:** old and mixed-version data remains readable, migratable, or deliberately rejected.
- **Failure:** error type, retryability, fallback, and partial-success behavior.
- **Order and time:** ordering, latency, async completion, races, and timeout behavior.
- **Side effects:** writes, notifications, jobs, webhooks, cache invalidation, and audit events.
- **Operations and UX:** logs, metrics, alerts, runbooks, permissions, and user-visible state.

Use `yo-engineering` for the applicable risk lenses rather than exhaustively checking irrelevant dimensions.

### 5. Find sibling paths without silently expanding scope

Search for copied logic, parallel implementations, sync/async variants, API versions, platform variants, and other paths through the same cause. Enumerate relevant siblings and decide one of:

- include them because the change would otherwise be inconsistent or incomplete;
- exclude them with a concrete reason;
- propose a follow-up because they are real but outside the authorized scope.

Finding a sibling does not authorize editing it. Unstated siblings are the failure; deliberate scope is not.

### 6. Resolve compatibility and rollout implications

For persisted or transmitted shapes, account for old writers, new writers, old readers, new readers, rollback, and partial deployment. Decide whether the change needs compatibility reads, dual write/read, versioning, backfill, feature gating, or coordinated rollout.

For destructive or externally observable operations, include authorization, idempotency, retries, cascades, auditability, and recovery. A new endpoint can have a large impact surface before any caller exists.

### 7. Establish only the baseline evidence you need

Locate existing focused, contract, integration, and transitive tests that define the surface. Run a pre-edit baseline when failure attribution matters or the surface is already suspect. For a clean, tiny local change, reading an adequate focused test may be enough.

Record what was checked, what was not available, and any coverage gap. Baseline evidence characterizes current behavior; it does not replace reasoning about untested consumers.

## Output

Write a compact brief:

```markdown
Change: <target and before/after observable behavior>
Consumers: <producers/consumers and searched boundaries>
Observable effects: <relevant behavior dimensions>
Compatibility/data: <old/new and rollout implications, or none>
Siblings: <included, excluded with reason, or follow-up>
Evidence: <searches, tests, history when useful>
Unknowns: <external or unverified surfaces>
Decision: <safe as scoped, needs compatibility/design, or blocked on evidence>
```

Then summarize:

> This changes `<behavior>` observed by `<consumers/flows>`; `<siblings and compatibility decision>`; `<remaining unknowns or why the searched surface is closed>`.

The sentence is a durable handoff, not a substitute for the evidence above. If its claims cannot be supported, the map is incomplete.

## Guardrails

- Do not edit while performing a standalone impact-analysis request.
- Do not infer safety from a single reference search, a clean compiler result, or an absent in-repository caller.
- Do not claim there are no external consumers unless the contract and search boundary make that knowable.
- Do not require blame, a fixed number of searches, a fixed duration, or a test run when it cannot affect the decision.
- Do not widen implementation scope merely because similar code exists.
- Do not turn impact analysis into root-cause analysis. If the mechanism is unknown, return to `yo-debug`.
- During active production impact, `yo-incident` preempts this workflow.

## Handoff

- `yo-verify-premise` establishes whether the claim is current and real.
- `yo-debug` establishes the causal mechanism when it is unknown.
- `yo-engineering` owns proportional risk and quality gates.
- `yo-design` records a multi-component or staged change before implementation.
- `yo-fix-loop` and `yo-feature` consume the impact brief when implementing.
- `yo-audit` later checks whether the implementation stayed inside the declared radius.

## References

- [Search strategy](references/search-strategy.md)
- [Research and decisions](references/sources.md)
