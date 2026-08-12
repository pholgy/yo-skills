---
name: yo-impact
description: Map consumers, contracts, persisted data, sibling paths, and observable effects before changing existing behavior or integrating a material boundary. Use the full workflow after the premise and cause are understood for shared, public, dynamic, persisted, authorization, external, mixed-version, or uncertain-consumer changes, and for standalone "where is this used?" or "is this safe to change?" requests. Keep contained local impact checks inline in the owning workflow.
---

# Yo Impact

Map what can observe a proposed change before editing so implementation covers
the real surface and no more. Use either an inline local result or a compact
impact brief, not duplicate artifacts, speculative compatibility work, or a
ritual search quota.

Do not take ownership from an additive `yo-feature` merely because its words
include API, cursor, URL, query parameter, or serialized state. An established
cursor filter/order extension preserving default/issued behavior and a fixed
local URL-filter set remain inline impact checks. Return to the feature owner;
do not create this standalone workflow.

## Calibrate the depth

Analyze the integration surface, not whether the diff adds or edits lines.

- Skip S0 wording/formatting changes and truly isolated, unused artifacts with no integration point.
- For contained S0/S1 work with statically knowable consumers, let the owning
  workflow inspect the target, direct consumers, focused tests, and plausible
  dynamic references inline. Record `target -> consumers -> proof`, then stop;
  do not invoke this standalone workflow or create a separate brief.
- Use the full workflow when one of these surfaces creates material risk or
  uncertain reach: shared/public contracts, dynamic lookup,
  persisted/transmitted data, auth, config, public exports, jobs, events,
  external systems, mixed versions, or operational behavior. An established,
  additive, reversible contract—including a small local query-parameter
  extension—with known consumers may stay inline when compatibility is
  preserved and the local search closes its observable surface.
  The same applies to an established cursor endpoint when legacy default cursors
  remain valid and new query dimensions are bound or rejected deterministically.
- A finite, explicitly named multi-provider implementation does not require this
  standalone workflow when its owning engineering/feature brief already maps
  every lifecycle boundary, authority, identity, side effect, and proof. Use
  full impact only for a reach question still capable of changing the affected
  surface—not to restate the provider list.
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

Require evidence before selecting those mechanisms. An unknown external
consumer must remain an explicit risk, but it does not automatically justify
dual writes, versioning, adapters, or permanent compatibility code. Add only
the machinery required by a supported contract, real mixed-version operation,
persisted data, authorized rollout, or demonstrated failure mode.

For destructive or externally observable operations, include authorization, idempotency, retries, cascades, auditability, and recovery. A new endpoint can have a large impact surface before any caller exists.

For an infrastructure-as-code refactor that changes resource addresses or state
identity, inventory the old address, new address, and physical object for every
affected state. Prefer explicit configuration moves; isolate exceptional state
commands and require a zero-create/delete/replace plan for protected resources.
Before the first real apply, execute the reverse or recovery path against a
disposable copy of representative state and record the state version, exact
path, observed plan/result, and recovery point. Keeping an old module version or
an unexecuted rollback command is not a rehearsal.

Inventory every affected state before rollout, but produce state-dependent plans
just in time: first for the canary, then for each authorized batch against its
current lineage and serial. Apply the zero-destructive-action assertion to every
workspace before that workspace changes. Do not precompute a fleet of saved
plans that drift will invalidate or rerun all workspaces after each batch; reopen
only the states whose content or identity changed.

Separate the release-candidate audit from authorized external rollout. The
default continuity is `implementation and recovery rehearsal -> authorized
representative canary -> one audit of the exact artifact, mapping, rehearsal,
and canary evidence -> authorized batches`. Do not place that audit before the
canary while claiming its verdict binds canary evidence. Each later S3 batch
then terminates on its own current lineage/serial, just-in-time plan,
immutable-ID check, functional probes, and immediate no-change plan. Do not
make the audit verdict depend on collecting terminal evidence from all
workspaces or re-gate earlier batches at fleet completion. Re-audit only an
artifact or invariant that changed; separately audit shipped fleet state only
when that is the user's requested endpoint.

When the physical identities, address mapping, zero-destructive-action
invariant, and recovery rehearsal are known, this impact brief is the sufficient
transition record: resume normal implementation and consequential audit. Do not
add `yo-design` just because many states or workspaces participate. Add it only
when an unresolved topology, ownership, compatibility, or end-state choice can
change the mapping or migration mechanism.

### 7. Establish only the baseline evidence you need

Locate existing focused, contract, integration, and transitive tests that define the surface. Run a pre-edit baseline when failure attribution matters or the surface is already suspect. For a clean, tiny local change, reading an adequate focused test may be enough.

Record what was checked, what was not available, and any coverage gap. Baseline evidence characterizes current behavior; it does not replace reasoning about untested consumers.

## Output

For a contained local check, return only:

```text
Impact: <target> -> <direct consumers> -> <focused proof>; <closed local surface or escalation trigger>.
```

For a standalone request or material boundary, write a compact brief:

```markdown
Change: <target and before/after observable behavior>
Consumers: <producers/consumers and searched boundaries>
Observable effects: <relevant behavior dimensions>
Compatibility/data: <old/new and rollout implications, or none>
Siblings: <included, excluded with reason, or follow-up>
Evidence: <searches, tests, history when useful>
Unknowns: <external or unverified surfaces>
Decision: <safe as scoped, needs compatibility/design, or blocked on evidence>
Minimum affected surface: <paths that must change and mechanisms not justified>
```

The `Decision` and `Minimum affected surface` fields are the downstream handoff.
Add this one-sentence summary only when another artifact or workflow needs a
standalone blast-radius statement:

> This changes `<behavior>` observed by `<consumers/flows>`; `<siblings and compatibility decision>`; `<remaining unknowns or why the searched surface is closed>`.

Do not require both forms for the local path. If a summary claim cannot be
supported by the brief, the full map is incomplete.

## Guardrails

- Do not edit while performing a standalone impact-analysis request.
- Do not infer safety from a single reference search, a clean compiler result, or an absent in-repository caller.
- Do not claim there are no external consumers unless the contract and search boundary make that knowable.
- Do not require blame, a fixed number of searches, a fixed duration, or a test run when it cannot affect the decision.
- Do not repeat an impact map already bound to equivalent content and consumers;
  inspect only the delta or state that changed.
- Do not turn a fleet-wide inventory into a fleet-wide pre-canary execution
  gate; schedule volatile proof at the smallest batch where it authorizes action.
- Do not widen implementation scope merely because similar code exists.
- Do not turn an explicit unknown into speculative compatibility machinery
  without a supported contract or real transition requirement.
- Do not turn impact analysis into root-cause analysis. If the mechanism is unknown, return to `yo-debug`.
- During active production impact, `yo-incident` preempts this workflow.

## Handoff

- `yo-verify-premise` establishes whether the claim is current and real.
- `yo-debug` establishes the causal mechanism when it is unknown.
- `yo-engineering` owns proportional risk and quality gates.
- `yo-design` records a multi-component or staged change only when an unresolved
  design choice can change the implementation; scale alone is not a handoff.
- `yo-fix-loop` and `yo-feature` consume the impact brief when implementing.
- `yo-audit` later checks whether consequential implementation stayed inside the
  declared radius when independence is required; routine local work uses scoped
  self-review.

## References

- [Search strategy](references/search-strategy.md)
- [Research and decisions](references/sources.md)
