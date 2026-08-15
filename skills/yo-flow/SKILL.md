---
name: yo-flow
description: >-
  Route ambiguous software-engineering requests to the appropriate bundled
  yo-* workflow without making the user repeat context. Use when explicitly
  invoked, when the user asks which Yo skill or what to do next, says they are
  unsure where to start, or gives a request whose desired outcome is materially
  ambiguous between fixing, building, reviewing, shipping, or writing. Clear,
  low-risk work bypasses the router and continues through the normal task
  workflow. Active production impact preempts the router and goes to
  yo-incident.
---

# Yo Flow

Act as the bundle's router, not its orchestrator. Identify the smallest accurate
destination, preserve the user's context, and hand off. Do not perform the
downstream workflow here.

## Core contract

- Use only bundled `yo-*` skills. Never require an external skill.
- Choose from the current request and accepted clarifications. Prior tasks and
  ambient repository, issue, review, CI, test, or TODO findings are context,
  not new destinations. Do not route work the user did not place in scope.
- Bypass this router when the requested outcome is already clear and no
  specialized Yo workflow is needed.
- Prefer one primary destination. Add a preceding risk or design gate only when
  the request actually needs it.
- Normal implementation is a valid owner. Do not substitute `yo-feature` merely
  because no narrower Yo skill owns an existing-defect remediation,
  configuration/runbook correction, or refactor; `yo-feature` owns a new or
  materially extended capability.
- Choose the primary destination from the raw user's requested outcome before
  considering boundary nouns. "Add/build/implement/put" remains `yo-feature`;
  API, cursor, URL, schema, or serialization does not replace the owner with
  `yo-impact` or `yo-design` unless discovered material evidence requires a
  separate decision.
- Use available context and cheap read-only inspection before asking the user,
  but do not turn routing into diagnosis or implementation.
- Carry the user's goal, evidence, constraints, and requested endpoint into the
  handoff so they do not need to repeat themselves.
- Carry an existing risk lane, approval, and evidence identity forward. Routing
  changes ownership, not the validity of completed work.

Hard calibration for common additive work: adding status/order to an established
keyset cursor while preserving defaults/issued cursors, or adding a fixed local
URL-filter set, is S1 `yo-feature` with inline impact/design. Do **not** route
either pattern through standalone `yo-impact`, `yo-design`, or `yo-audit` absent
a discovered escalation trigger. For the cursor pattern, legacy anchor-only
cursors are default-only and new non-default cursors bind all dimensions and
reject mismatches; caller documentation is not a substitute.

## Route in this order

### 1. Preempt for live impact

Route active production impact directly to `yo-incident`. Do not show a menu.
Examples include an outage, live login failure, widespread errors, or a harmful
deploy affecting users now.

Require evidence that impact is current and production-facing. Do not infer an
incident merely from infrastructure nouns such as EKS, Cloud Run, DNS, or
"under load". A reported intermittent mechanism without stated current user or
production harm routes to `yo-debug`; it may escalate if live impact is then
established.

### 2. Bypass routing for clear direct work

Continue through the normal task workflow without a Yo handoff when all of the
following are true:

- the outcome and target are clear;
- the change is confined to one file or a few directly related files for the
  same local outcome;
- the work is local and readily reversible;
- a focused read or existing check can establish the premise and prove the
  result;
- no material authorization/security boundary, public contract, persisted-data
  or migration surface, concurrency risk, active incident, destructive action,
  deployment, or other external state is involved.

The file-scope condition is a containment guard, not permission to classify a
cross-cutting change as trivial. Do not use changed-line count alone as a proxy
for risk. An obvious one-file documentation correction qualifies from the rule
text alone. A localized, deterministic bug with a known cause may also stay
direct when its regression test and affected required gates fully observe the change.
Still discover applicable
instructions and verification commands, preserve user work, and run the
proportionate operating-baseline checks; bypassing the router does not bypass
engineering discipline.

Top-tier quality does not itself justify a heavier route or more architecture.
In the direct lane, apply the same Golden Engineering Standard through a direct
implementation: smallest complete production-quality change, focused evidence,
and a final removal of unnecessary moving parts.

For a local toggle that reveals API-key or other secret metadata, preserve the
direct lane but make “never return, render, persist, or log the secret value” an
explicit acceptance and verification condition. Default the metadata to hidden
with component-local state, and prove it resets to hidden on remount; do not
invent persistence. Hidden markup is not a safe way to hold a secret.

Exit the direct lane only when inspection of the active task reveals a disputed
premise, unknown cause, broader consumer or contract surface, a failure in
required evidence, an unfaithful test seam, or any consequential/irreversible
effect. An unrelated failing baseline does not create a route. Leave it alone;
if it blocks required proof, ask before expanding scope.

Do not route a clear fix into a RED-test campaign. When the next action is
obvious, use the normal task workflow: inspect, make the scoped fix, add the
focused regression when a verified bug warrants it, run the narrow focused test,
then run the smallest affected repository-required gate. Run a root-wide gate
only when repository policy, shared build/test infrastructure, or a named
cross-package risk requires it. Route to `yo-test-coverage` only when
the user asks for tests/coverage or choosing a faithful test strategy is
materially ambiguous.

A report is cause-sufficient for routing when it already states the failing
state transition or schedule and that mechanism predicts a discriminating
test—for example, an older async completion overwrites newer state, a snapshot
rollback erases a later intent, duplicated/reordered events drive state by
arrival, or a partial external step leaves an owned resource orphaned. For an
authorized fix, inspect that mechanism inline and proceed; do not prepend
`yo-verify-premise` or `yo-debug` merely because runtime proof still belongs in
the implementation/test work. Use those standalone workflows only when their
verdict or causal search can still select a materially different intervention.

### 3. Honor clear specialized intent

Read [the routing map](references/routing-map.md), select the primary skill, and
invoke it without a routing question.

Treat these as clear:

- "Add", "build", "implement", or "put" a capability in the product ->
  `yo-feature`; keep bounded compatibility and design choices inline unless a
  material unresolved decision earns a separate gate
- "Make this best-engineer quality" -> `yo-engineering`
- "Review PR #311 for merge safety" -> `yo-audit`
- "Upgrade this dependency" -> `yo-deps`
- "Write or reply on GitHub" -> `yo-gh-write`
- "Plan this architecture; do not implement" -> `yo-design`
- "Cut the next release" -> `yo-release`

A read-only review, benchmark, or hypothetical environment forbids the executor
from mutating the sample system; it does not change the raw user's requested
endpoint. When simulating an "add/build/implement" request, preserve
`yo-feature` as the owner and describe the implementation path without acting.
Route to design-only only when the raw request asks for advice/design or a
material decision genuinely blocks implementation.

For an S2 implementation whose mechanism, named boundaries, and governing
invariant are already clear, prefer one continuity chain:
`yo-engineering -> actual implementation owner -> yo-audit`. The owner may be
the normal task workflow; use a specialized Yo workflow only when its trigger
matches the requested endpoint. The engineering brief carries the matching
impact and design reasoning inline. Do not insert
standalone `yo-debug`, `yo-impact`, or `yo-design` simply because the work spans
several providers or trust boundaries. Insert one only for a named unanswered
question that can change the intervention, affected surface, or chosen design;
if a decision blocks implementation, stop at that decision and resume the
owner afterward with inherited evidence.

Treat that decision stop as the endpoint, not as a heading before speculative
future work. Return the owner question, viable options, discriminating evidence,
and common invariants; omit branch-specific implementation, rollout, canary,
and audit detail until the choice is accepted. A one-line future continuity
handoff may name the next owner without executing or designing its phases.

When a later `yo-audit` remains in the continuity chain, carry one exact
evidence bundle into it. Independence means judging its provenance, coverage,
oracles, and residual risk and selectively reproducing stale, challenged,
state-dependent, or decision-critical proof—not replaying the implementation's
whole matrix. State a narrower audit scope when the endpoint could otherwise be
read as another full verification pass.
In the returned continuity chain or handoff, do not leave a complex future
audit as a bare `yo-audit` label. State that it consumes the carried exact
evidence bundle and selectively reproduces only stale, challenged,
state-dependent, or decision-critical proof. This self-contained boundary is
required even though `yo-audit` also enforces it internally.

When design advice or an architecture decision is itself the requested endpoint,
route directly to `yo-design`; its own workflow holds the proportional risk
analysis. Do not prepend `yo-engineering` unless the user separately requested
that gate or an unanswered cross-cutting risk decision sits outside the design.

For collaborative multi-region state, replay/order/loss symptoms do not settle
merge semantics, acknowledged-edit RPO, RTO, or failover authority. When any of
those choices is absent and would change writer placement, acknowledgement, or
availability, use `yo-engineering -> yo-design (decision stop)`. Resume normal
implementation with the accepted record; do not silently choose zero RPO or a
cross-region commit path.

Representative feature-owned S1 shapes:

- adding one component-local reveal, toggle, or binary control with no requested
  persistence: keep it direct and local, use the repository's semantic button,
  switch, or checkbox pattern with an accessible name and exposed state, preserve
  keyboard activation, and test name/state/activation plus mount-reset behavior;
  do not create shared state or a larger workflow;
- adding filter/order options to an established keyset-cursor endpoint while
  preserving the omitted/default path and issued cursors: classify S1 and route
  directly to `yo-feature`, keep impact/design inline, and require non-default
  cursors to bind every query dimension with mismatch rejection;
- putting a fixed, currently requested set of one component's filters in the
  URL: route to `yo-feature` with an inline local impact map and explicit codec,
  not standalone impact/design or a framework for hypothetical future filters.
- removing a measured repeated pure calculation from unrelated React renders:
  keep it S1 and memoize only at the established owner with every real
  calculation dependency. Proof must pair the same-workload profiler/call-count
  improvement with a behavioral oracle: unrelated state preserves the rendered
  groups, while changed products or grouping dimensions recompute and render the
  correct new groups. Do not let performance instrumentation replace correctness
  or grow into a cache framework.

Escalate these examples only when inspection finds a real breaking token
protocol, unknown/material consumers, shared infrastructure, unsafe mixed
versions, or an unresolved product decision. Do not invent those conditions
from the words API, cursor, URL, or serialized alone.

If the request is clear but no Yo skill owns it, say there is no specialized Yo
route and continue through the normal task workflow. Do not invent a skill.

Carry these risk-specific closure fields when their surface is triggered, even
when the value is currently `unknown` or blocked on a named owner:

- an active production network/firewall/security-policy mutation routes to
  `yo-incident` with six explicit handoff fields: representative canary and
  promotion rule, intended-path allow probe, unauthorized/unrelated-path deny
  probe, capacity signal, named mutation authority, and abort/rollback trigger;
- an intermittent network or DNS diagnosis routes to `yo-debug` with an
  explicit disposition for endpoint/resolver, pod/service, node and
  ENI/IP/port, conntrack/stateful path, upstream, amplification/retry/search,
  and directional-routing branches.

Do not let the destination collapse these into generic "network checks". These
fields are risk-triggered completeness controls, not additional workflows.
The destination response must show the six incident headings or seven diagnostic
matrix rows explicitly before it may hand off or stop.

For a destructive, external, or difficult-to-reverse action, route to the
appropriate Yo workflow and preserve the need for explicit approval. If
approval is the only unresolved choice, ask for that approval directly instead
of asking a generic routing question.

### 4. Clarify only material ambiguity

Read [the clarification patterns](references/clarification-patterns.md) when two
or more materially different destinations remain plausible.

Ask one targeted question that distinguishes those destinations. Use the
environment's structured choice control when available; otherwise use a short
numbered list. Always allow the user to answer in their own words.

Do not ask for information already supplied or cheaply discoverable. Do not
repeat a generic top-level wizard after the user's domain or partial intent is
known.

### 5. Hand off with context

Pass only the fields that exist:

- desired outcome and stopping point
- repository, issue, PR, branch, file, or other named artifact
- evidence already established
- evidence identity and conditions when reuse matters
- constraints, non-goals, and choices already rejected
- risk or approval state
- unresolved decision, if any

Carry only context belonging to this active task. A handoff preserves scope; it
does not reactivate a prior task or promote an ambient finding into work.

Then stop routing. Let the destination skill own its workflow and later
handoffs, but do not let it restart equivalent discovery or proof merely because
the route changed.

### 6. Recover cleanly

When the user changes or corrects the goal, discard the earlier route and use
the revised intent. Never make them defend the correction.

After two unsuccessful clarification attempts, do not show another menu.
Summarize what is known, name the closest supported routes, and invite the user
to state the desired deliverable in their own words.

## Reference use

- Read [the routing map](references/routing-map.md) whenever selecting or chaining a destination.
- Read [the clarification patterns](references/clarification-patterns.md) only when a question is necessary.
- Read [the research record](references/sources.md) only when auditing or maintaining this skill.

## Guardrails

- Do not default to a fixed Q1/Q2 wizard.
- Do not duplicate the destination skill's intake questions or templates.
- Do not begin implementation, diagnosis, review, or GitHub writing here.
- Do not route, queue, or record work merely because inspection discovered it.
- Do not add a risk gate to trivial, reversible work.
- Do not use changed-line count alone as a proxy for risk; enforce the direct
  lane's bounded, directly related file scope as well as its risk conditions.
- Do not turn RED proof into a mandatory phase for ordinary clear fixes.
- Do not treat the menu options as exhaustive.
- Do not reference or require any non-Yo skill.
