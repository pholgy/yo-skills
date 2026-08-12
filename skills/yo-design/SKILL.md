---
name: yo-design
description: Analyze, draft, review, or record software designs and architecturally significant decisions before costly implementation. Use for material public contracts, data models and migrations, trust/security boundaries, concurrency and reliability models, cross-service workflows, framework or protocol choices, substantial alternatives, design docs/RFCs, ADRs, and "should we choose A or B?" requests. Keep established, reversible local choices inline.
---

# Yo Design

Make consequential choices reviewable while they are still cheap to change,
and prefer the simplest viable design that completely satisfies current
requirements and demonstrated risk. Do not create repository artifacts or post
them externally unless the user authorized that action.

Do not take ownership from an implementation request merely because it contains
an API, cursor, URL, or serialized representation. An established additive
cursor filter/order extension preserving default/issued behavior and a fixed
local URL-filter set stay in `yo-feature` with inline decisions. If routed here
without a discovered material choice, return to the feature owner rather than
manufacturing a design gate.

## Choose the mode

- **Advise:** compare or recommend in chat; no file writes.
- **Draft:** produce a design/RFC/ADR draft in chat or a requested location, but do not treat it as accepted.
- **Record:** write an accepted decision into the repository's established decision-record convention.
- **Review:** evaluate an existing design or ADR read-only for missing drivers, weak alternatives, risks, and unverifiable claims.

If the user asks only for design, stop before implementation. If they ask to design and build, design is an internal gate; pause only when a material unresolved choice requires new user authority or changes product intent.

An owner decision stop is terminal for the current turn. Before that decision,
describe only the viable options, the facts or smallest spike that distinguish
them, the invariants common to every acceptable option, and the exact owner
question. Do not design an unselected branch, prescribe its rollout/canary or
operational drills, or launch its audit plan. Carry those items forward only
after selection. A short deferred acceptance condition is enough when it helps
the owner compare options; it is not permission to elaborate the branch.

## When design work earns its cost

Use this workflow when one or more of these conditions is material to the current
decision:

- the decision changes a public/wire contract, durable data, protocol, trust boundary, tenancy, or recovery model;
- rollback is costly, lossy, coordinated, or unavailable;
- several teams/components must share an invariant or interface;
- security, privacy, availability, performance, operability, or cost goals trade off materially;
- the approach is novel, uncertain, disputed, or requires a spike to validate;
- future maintainers will need the rationale because the choice is costly to
  reverse, governs later work, or departed from an established standard.

Do not trigger only because many files change or because a local Yo risk tier has a particular number. A large mechanical change may need an execution plan, not architecture. A small public schema choice may need a design and ADR.

For an implementation request, do not serialize this workflow after an
engineering brief merely to expand an already selected, established pattern.
Several SaaS/BaaS providers or trust boundaries make the design fields
important, but provider count does not make a separate design cycle mandatory.
Keep the decision inline with the feature when field/lifecycle authority,
identity, idempotency, recovery, transition, and proof are already settled.
Use this workflow only when a named alternative or owner decision can still
change the design; if it blocks implementation, stop here, then hand the
accepted decision forward without rerunning prior gates.

Crossing a public, wire, code, or stack boundary is a signal to inspect, not a
sufficient trigger by itself. Keep an established, additive, reversible choice
with known consumers and no material compatibility, migration, security,
operational, or uncertainty risk in the owning plan as a short decision note.
The possibility that someone may ask "why" later cannot launch the full
workflow on its own.

An additive filter/order extension to an established cursor API is such an
inline choice when default and issued-cursor behavior is preserved and new
query dimensions are bound or rejected; the cursor label alone does not earn a
design cycle.
When the raw request says to add or implement that bounded extension,
`yo-feature` remains the owner; do not convert the request into design-only
advice because the current environment is read-only or hypothetical.
Legacy anchor-only cursors remain valid only for the default semantic path; new
non-default cursors bind every membership/order dimension and reject mismatches.
Do not recommend caller discipline as a substitute for an enforceable cursor
contract.
This pattern is an inline `yo-feature` decision, not a `yo-design` workflow,
unless inspection exposes a genuinely breaking or unresolved contract choice.

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

Read repository guidance and relevant existing designs/ADRs. Reuse current
premise and impact evidence carried by the owning workflow; invoke
`yo-verify-premise` or `yo-impact` only when a material unanswered question
could change the design.

Identify stakeholders and the actual decision owner. Separate facts, requirements, assumptions, preferences, and unknowns. A design cannot resolve a product decision that nobody has authorized it to make.

### 2. Define decision drivers

State:

- problem and user/business outcome;
- goals and explicit non-goals;
- invariants and constraints;
- prioritized quality scenarios, such as load, failure, attack, rollback, or evolution;
- a complexity budget: which new concepts or mechanisms are necessary now and
  what current requirement or risk justifies each one;
- decision criteria and how evidence will be obtained.

Use concrete scenarios rather than adjectives. "At 10x request load, p99 remains below the agreed target" is reviewable; "must be scalable" is not.

### 3. Develop viable alternatives

Include a direct change and the current/status-quo approach whenever either is
viable. More architecture must earn its cost against the simplest complete
option. For each real option, compare the same decision drivers:

- correctness and invariant fit;
- compatibility and migration;
- failure/recovery and rollback;
- security/privacy and operational control;
- performance, capacity, and cost;
- implementation and long-term maintenance complexity;
- ecosystem maturity, team capability, and dependency risk.

Do not manufacture strawmen or use an unexplained weighted score to hide judgment. When uncertainty could change the decision, propose the smallest time-bounded spike, benchmark, threat model, or compatibility test that would discriminate among options.

Do not choose an interface, service, event, generic framework, configuration
surface, migration mechanism, or operational component for hypothetical reuse
or scale. Choose it only when a current scenario, supported contract,
demonstrated failure, repository boundary, or measured constraint requires it.

### 4. Describe the proposed design

Write enough that a reviewer can trace important scenarios and object to the approach:

- components and ownership boundaries;
- key control/data flows and state transitions;
- APIs, schemas, events, and invariants;
- authorization and trust decisions;
- concurrency, idempotency, ordering, and consistency model;
- authoritative state through transitions and, for multi-region state, the
  explicit RPO/RTO and failover ownership;
- failure modes, cleanup, retries, degradation, and recovery;
- observability, operations, capacity/cost, and support implications.

For a lifecycle spanning several SaaS, BaaS, or control-plane providers, include
a compact integration authority record: field-level systems of record, stable
cross-provider identity mapping, a durable inbox with a unique
`provider + event ID` admission key, idempotent side effects,
ownership proof before lookup/adoption/compensation, reconciliation of drift and
partial failures on a recurring schedule, provider contract or sandbox evidence,
and secret/log handling. Publish derived internal state or entitlements through
an idempotent outbox rather than direct best-effort fan-out.
Capability to delete a resource is not authority to compensate it.

After field authority, conflict semantics, and repair ownership are accepted,
the final multi-provider implementation design must state each applicable item
explicitly:

- lifecycle and field authority plus the stable cross-provider identity key;
- durable-inbox admission/idempotency key and deterministic internal state or
  entitlement;
- owned outbox side effects and recurring reconciliation trigger;
- ownership evidence required before adoption or compensation;
- provider contract/sandbox tests and partial-failure cases; and
- secret references plus log/error redaction proof.

Do not substitute a list of providers or a generic state machine for this
record, and do not add `N/A` rows for genuinely irrelevant items.

When any of those owner choices is unresolved, stop with the authority matrix,
stable identity, admission/reconciliation invariant, deterministic derived-state
rule, conflict alternatives, and the focused duplicate/reorder/human-edit/crash
proof that discriminates them. Do not add historical repair, sandbox, canary,
secret/log, or rollout programs merely because several providers are named;
include one only when the stated failure, accepted option, or repository policy
makes it material.

After the topology is selected, for a stateful cross-cloud or multi-path network,
draw one bidirectional packet
path from source to destination and back. Name route ownership, translation,
stateful inspection ownership, capacity, deterministic failover and failback,
maintenance drain order, expected-allow and expected-deny probes, and the
rollback point. Do not call a topology safe from route advertisements alone.
The handoff must explicitly state the packet path, inspection owner, drain
sequence, capacity evidence, failover behavior, failback behavior, allow/deny
probes, and rollback trigger; do not leave a required field implicit.

For overlapping AWS VPC CIDRs, state that ordinary peering or Transit Gateway
routing cannot distinguish the overlap. `Preferred`, `proposed`, `leaning`, or
`expected` is not a hard constraint. For a finite set of services, compare
mirrored PrivateLink endpoint services with the translated Transit Gateway
alternative and stop for the network/service owner to select based on
initiation semantics, cost, operability, and policy. Before selection, limit the
design to the service-flow matrix, option-level tradeoffs, and deferred
acceptance that the selected path must prove both directions plus expected-deny
paths, including the complete forward and return packet paths and stateful
symmetry. Do not specify the translated topology, capacity/failover plan,
maintenance sequence, or other branch-only mechanics. Detail only the selected
branch after the owner chooses it. When Transit Gateway is explicitly mandatory
or true routed initiation
cannot be served by PrivateLink, allocate non-overlapping routable alias subnets,
use a Private NAT Gateway for source translation and an ELB endpoint for
destination translation on each initiating/serving side, and advertise only the
alias prefixes through Transit Gateway. AWS Network Firewall may inspect this
path but is not the NAT mechanism. Name both directional translations, native-
prefix isolation, DNS ownership, symmetry, and negative paths; otherwise stop on
the unresolved translation design instead of presenting a generic NAT appliance.

For GCP HA VPN to AWS Transit Gateway, bind preference to controls each side
actually evaluates. Keep equal AS-path length when MED is the selector; use a
Cloud Router import route policy to give learned AWS routes the chosen
corridor's lower MED, and an export policy or per-session base advertised
priority to advertise GCP routes with lower MED on that same corridor. Confirm
that the AWS TGW route table selects the lower-MED VPN route, and enable
appliance mode on the stateful inspection attachment. If the exact topology
cannot make both directions choose one corridor, do not claim deterministic
symmetry. For maintenance, drain state, preserve the viable backup route, then
withdraw the active BGP session and verify both directions before work; restore
preference through the same drain-and-proof sequence.

For a live schema transition, enforce one migration runner with a lease or
fence, bound and throttle each backfill batch, measure lock and latency impact,
reconcile before switching reads, and rehearse application rollback while the
expanded schema and delayed work remain present.
The handoff must explicitly name the runner/fence, batch bound and throttle,
lock/latency evidence, reconciliation, rollback rehearsal, and contraction gate.

For any multi-region durable state, the handoff must explicitly state the
authoritative writer/store, accepted RPO, accepted RTO, partition behavior,
failover authority, fencing mechanism, and failback proof. `Unknown — decision
blocked on <owner>` is valid; omission is not.

Concurrency proof must cover bounded, materially distinct schedule and failure
classes with invariant or property-based checks: duplicate, reorder, gap,
reconnect, retry, and each commit/acknowledgement boundary that can change the
outcome. Do not require a Cartesian replay of every combination or say “every
permutation” when representative equivalence classes close the same risk.

Do not convert an absent RPO into zero loss or choose cross-region durability
before the owner accepts its latency/availability cost. For a collaborative
stream, merge semantics and acknowledged-edit RPO are implementation-selecting
decisions: stop before fixing acknowledgement, writer, replication, or failover
architecture, then resume from the accepted record without reopening design.

For collaborative or replayed operation streams, also name the authoritative
revisioned operation log, stable operation identity, acknowledgement point,
causal/base revision, missing-revision detection and recovery, reconnect replay,
and duplicate handling. Buffering a gap without a recovery protocol or using a
merge algorithm without a durable revision authority is incomplete.

For OIDC or another federated login, define linking as a security decision:
bind an immutable issuer/subject pair to one internal identity, prevent
collision with pre-existing accounts, do not auto-link from email alone, and
specify re-linking/account-recovery authority. Cover first link, repeated login,
conflicting identity, and attempted takeover in negative tests. For public or
mobile clients, use Authorization Code with PKCE; validate issuer, audience,
signature, expiry, redirect URI, `state`, and `nonce` at the owning server
boundary. Stage authorization enforcement explicitly: observe/compare first
where safe, canary new sessions/clients, enforce server-side with a kill switch
or rollback floor, measure legacy use and denials, then remove the compatibility
bridge at its owned cutoff. UI checks never substitute for server enforcement.

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
- the selected option introduces no concept or moving part without a current
  driver, and is simpler than the viable alternatives after total lifecycle
  cost is considered;
- the decision and consequences are distinguishable from implementation tasks.
- every applicable multi-provider, stateful-network, live-migration, or
  multi-region record above is explicit; a generic architecture paragraph does
  not satisfy those risk-triggered fields.

## Guardrails

- Do not write files or post a design merely because this skill was invoked.
- Do not use a fixed page/file/risk-tier threshold as a substitute for significance.
- Do not design from a stale or unverified premise.
- Do not hide product choices inside technical assumptions.
- Do not treat an ADR as a task tracker, changelog, or broad architecture encyclopedia.
- Do not silently rewrite accepted rationale or fabricate retroactive intent.
- Do not let design continue indefinitely when a small experiment can settle the uncertainty.
- Do not mistake optionality, generality, or architectural novelty for quality.
- Do not design for imagined consumers, scale, or migration states without
  evidence that they belong to the supported problem.

## Handoff

- `yo-engineering` supplies proportional risk lenses and quality gates.
- `yo-impact` supplies consumer, compatibility, and transition surfaces.
- `yo-deps` evaluates a framework/library choice before it becomes a decision.
- `yo-feature` converts an accepted design into executable slices and verification.
- `yo-audit` uses the design and ADR as intent evidence, not proof of
  correctness. When named after a complex implementation, the handoff must say
  that it consumes the carried exact evidence bundle and selectively reproduces
  only stale, challenged, state-dependent, or decision-critical proof; do not
  leave a bare audit label that can imply replaying the implementation matrix.
- `yo-gh-write` formats or publishes design discussion only when explicitly requested.

Carry the decision, lane, constraints, and evidence identity into the next
workflow. A handoff must not reopen settled discovery or create another design
artifact for equivalent content.

## References

- [Artifact selection and lifecycle](references/artifacts.md)
- [Research and decisions](references/sources.md)
