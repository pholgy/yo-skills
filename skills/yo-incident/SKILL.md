---
name: yo-incident
description: >-
  Coordinate active production incidents from declaration through safe
  mitigation, recovery, handoff, and follow-up. Use for current availability,
  latency, data-integrity, security, privacy, or safety impact; paging alerts;
  active exploitation or exfiltration; and regressions that are harming users now.
---

# Yo Incident

## Outcome

Reduce current harm quickly without creating a second incident, losing evidence,
or confusing containment with recovery. Maintain one command structure, one live
state, controlled production mutations, factual communications, and explicit
recovery criteria.

Mitigation outranks complete root-cause analysis, but not safety. Gather the
minimum facts needed to avoid an unsafe rollback, data loss, wider compromise, or
misdirected action. The fastest action is the fastest *safe* action.

Use `references/command.md` for the live-state, timeline, handoff, and update
templates. Use `references/mitigation.md` for action selection and special data,
security, and dependency hazards. Post-incident structure is in
`references/post-incident.md`.

## Trigger and route

Invoke for confirmed or credibly suspected current production impact. Declare a
suspected incident early when impact is not yet proven; downgrade or close it
with evidence later. Do not wait for a root cause before coordinating response.

Do not use this for ordinary backlog bugs, hypothetical production risk, local
development failures, or CI failures with no live impact. Those return to
`yo-verify-premise`, `yo-debug`, or `yo-branch`.

Follow the organization's incident runbook, on-call model, security plan,
severity taxonomy, and communication policy when available. This skill fills
gaps; it does not replace an established command system.

## Authority survives urgency

Credentials and technical capability are not authorization.

- "Investigate" authorizes urgent read-only assessment and a mitigation
  recommendation, not production mutation or messages to other audiences.
- "Fix," "restore," or "contain" authorizes normal in-scope actions only when
  the user's operator authority and the applicable runbook are clear.
- Paging responders, declaring an incident in a shared system, changing traffic,
  flags, credentials, data, or deployments, and publishing status updates are
  external mutations. Use explicit user authority or pre-authorized runbooks.
- Destructive, hard-to-reverse, evidence-destroying, data-rewriting, or
  broad-blast-radius actions need the runbook's break-glass authority or explicit
  approval even during an incident.
- Customer, public, regulatory, law-enforcement, partner, and broad internal
  communications require the designated communications authority.

If mutation is not authorized, do not stall: scope the incident read-only,
identify the safest executable mitigation, state its risks and expected proof,
and escalate to the named operator or ask for the minimum approval needed.

## 1. Declare and establish command

Use the organization's incident mechanism when authorized. Establish:

- incident ID, status, start/detection times, affected service, and source of truth;
- Incident Commander (IC), Operations Lead (OL), Communications Lead (CL), and
  Scribe/Planning owner;
- primary responder channel or bridge and an out-of-band path if the normal
  system may be compromised;
- severity from the organization's impact scheme, not an invented P/SEV label;
- next internal update time and any authorized stakeholder cadence.

The IC coordinates, prioritizes, and owns the state; the OL owns production
changes; the CL owns audience-specific updates; the scribe maintains the record
and future work. One person may hold several roles in a small incident, but name
the hats. When staffing permits, the IC should not be the person typing every
production command.

Only the OL or a delegated operator changes the affected system. Other responders
investigate read-only and report concise evidence to command. Use explicit verbal
or written handoff with acknowledgment whenever a role changes.

## 2. Bound harm and freeze interference

Capture the top of the live state before deep investigation:

- user-visible symptom and earliest known onset;
- affected tenants, regions, functions, percentages, and business workflows;
- availability, latency, error, saturation, data-integrity, confidentiality,
  privacy, financial, and safety impact;
- black-box user signal plus relevant service-level and dependency signals;
- ongoing harmful writes, retries, queue growth, exfiltration, or attacker activity;
- last known good state and recent deploy, config, flag, dependency, credential,
  traffic, infrastructure, and third-party changes;
- current hypotheses, clearly labeled as hypotheses.

Pause unrelated deploys and automation only for the affected scope when they can
obscure evidence or change the system during response. Do not freeze the entire
organization by reflex.

Protect the highest-value invariant first. That may mean preserving life/safety,
stopping data theft, preventing corrupt writes, protecting payment idempotency,
or retaining service availability. Availability is not always the top priority.

## 3. Keep a safe append-only record

Use the existing incident system or an in-session record. Create no repository
scratch file, ticket, channel, or document unless authorized. Record absolute
timestamps with timezone, actor/role, observation, hypothesis, decision, action,
expected signal, actual result, and evidence link. Correct earlier entries with a
new entry; do not rewrite the past.

Never paste secrets, credentials, raw personal data, customer payloads, or
sensitive forensic artifacts into normal chat, issues, or status updates. Use
approved restricted evidence storage and reference identifiers or redacted
fingerprints. The timeline indexes evidence; it is not the evidence repository.

## 4. Choose mitigation as a controlled experiment

For each candidate, write a one-line decision record:

- harm it stops and the hypothesis it tests;
- scope and expected user/system signal;
- compatibility, data, security, and forensic hazards;
- reversibility and rollback/abort path;
- owner, authority, start time, and observation window.

For a production network, firewall, routing, identity, or security-policy
mutation, also name the representative canary, an expected-allow probe, an
expected-deny probe, capacity or saturation signal, and the exact Operations
Lead or delegated authority. A correlation with the latest change may prioritize
a reversible mitigation, but it does not eliminate competing cause checks.

A network/security mitigation proposal is incomplete until all six fields below
are filled with concrete observations or explicitly blocked with an owner. Do
not replace them with generic black-box, compatibility, or security wording:

```markdown
Representative canary and promotion rule:
Expected-allow probe on the intended path:
Expected-deny probe from an unauthorized or unrelated path:
Capacity/saturation signal:
Named operator and mutation authority:
Abort and rollback trigger:
```

`Named operator and mutation authority` means the actual operator when supplied,
or the designated Operations Lead role plus `unassigned — mutation blocked`
when the scenario provides no human or runbook. Never invent a person or treat a
role placeholder as authorization; the honest blocked handoff is complete for a
read-only recommendation, while the mutation remains forbidden.

For an intermittent network or DNS incident, explicitly discriminate endpoint
or resolver behavior, pod/service capacity, node and ENI/IP/port limits,
conntrack or stateful inspection, upstream dependencies, retry/search
amplification, and directional routing before declaring a causal fix. A durable
network change must prove symmetry, representative capacity, failover, and
failback; recovery from one successful path is insufficient.

The canary and denial proof must be stated as executable observations: identify
the limited representative target, exercise the intended path, and confirm an
unrelated or unauthorized source/destination remains denied. Do not treat a
generic black-box request as both proofs.

Candidate mitigations include disabling a feature, revoking a credential,
quiescing writes, entering read-only mode, pausing a queue, load shedding, rate
limiting, scaling capacity, shifting or failing over traffic, reverting config,
rolling back a deploy, or applying a narrow forward correction. There is no
universal ordering. Choose the fastest option with acceptable risk and strong
observability.

### Rollback gate

Rollback is preferred only when the previous state remains compatible with the
current data, schema, protocols, queues, external side effects, and mixed-version
fleet. A previous binary is not "known good" against state created after it left
production. For migrations or ongoing writes, validate read/write compatibility,
loss window, replay behavior, and recovery point before routing traffic backward.

When rollback is unsafe, a flag, containment boundary, read-only mode, additive
compatibility repair, or small roll-forward may be safer. Do not make
fix-forward universally last; make unbounded, unreviewed improvisation last.

### Security and data gate

For active compromise, stop the adversary or compromised authority while
preserving evidence when doing so does not prolong harm. Credential revocation,
session invalidation, isolation, and egress blocking may outrank availability.
Coordinate with security/forensics and required legal, privacy, compliance, and
communications owners. Use out-of-band coordination if the attacker may observe
normal channels.

For suspected corruption, stop or isolate harmful writes, preserve queues and
in-flight state, confirm backups or point-in-time recovery, snapshot where safe,
and define reconciliation before replay. A healthy page over corrupt data is not
recovery.

For cross-provider access deactivation, make one internal authorization boundary
the immediate deny authority. Treat vendor session revocation and notifications
as asynchronous idempotent effects keyed by a stable subject and revocation
generation; reconcile them until inactive identities and derivative sessions
are accounted for. A notification channel never determines access state.
The incident handoff must explicitly name the lifecycle identity authority,
external-to-internal stable identity key, current revocation generation,
idempotency key, reconciliation result or gap, and audit trail. Do not leave
these implied by product names.

When the authorized endpoint, organization policy, or incident owner also
includes the permanent cross-provider correction, carry that exact incident
evidence into one durable execution chain: reuse the lifecycle/impact/design
decisions, implement the scoped authorization and vendor-revocation correction,
run lifecycle tests plus reconciliation proof, and obtain one consequential
audit. Do not restart incident discovery or create another design cycle while
content and conditions remain equivalent. That continuation ends at verified
immediate internal denial, eventual vendor-session revocation, reconciled
notification state, and no Blocker/Major—not merely an accepted design. Without
that continuation authority, stop at stable incident recovery and hand off the
evidence as a recommendation.

## 5. Execute one controlled mutation at a time

The OL announces the action, owner, expected signal, abort condition, and scope.
Use a peer or runbook confirmation for high-risk changes. Timestamp start and end,
then observe long enough for monitoring latency and propagation before attributing
the outcome.

Prefer one major production mutation at a time so its effect is attributable.
Parallelize read-only investigation across independent hypotheses, but centralize
decisions through the IC. If a mitigation fails, record the counterevidence,
restore any temporary state if safe, update the hypothesis, and choose the next
action. Do not thrash between changes.

If an action reaches an abort condition, stop it immediately. If observed harm is
worse than expected, favor containment and escalation over finishing the plan.

## 6. Communicate through the designated owner

The CL sends only authorized updates to the correct audience. Each update states:

- confirmed impact and time window;
- current incident status;
- mitigation in progress or completed;
- what is known versus still under investigation;
- next update time or event trigger.

Avoid blame, root-cause speculation, internal attack detail, secrets, personal
data, and promises without evidence. Internal responder notes, executive updates,
support guidance, customer status, and regulatory notices are different artifacts
with different access and approval rules.

Use the organization's cadence. If none exists, set the next update explicitly
from incident severity and stakeholder need rather than hardcoding a universal
number. Update sooner on material impact or status change. Silence should not
force the OL to abandon mitigation work; the CL owns the communication load.

## 7. Verify mitigation, recovery, and resolution separately

- **Contained/mitigated** - current harm is stopped or materially reduced, but
  the underlying defect, compromise, backlog, or data inconsistency may remain.
- **Recovering/monitoring** - user paths and system signals are returning while
  backlog, replicas, caches, queues, or downstream systems converge.
- **Recovered** - user-visible behavior, service objectives, data integrity,
  security controls, dependent systems, and critical business flows meet the
  declared criteria for a suitable stability window.
- **Resolved** - the IC has verified recovery criteria, assigned residual work,
  captured the final timeline/state, communicated closure through authorized
  channels, and deliberately ended incident command.

Recovery proof combines black-box user checks with error, latency, traffic,
saturation, region/tenant coverage, data reconciliation, queue/backlog state,
security telemetry, and the incident-specific invariant. Use non-destructive
probes or approved test accounts; a checkout test must not create real charges or
orders accidentally.

Choose the stability window from recurrence risk, propagation delay, traffic
cycle, and runbook—not an arbitrary duration. Re-enable paused automation,
traffic, alerts, or features deliberately and observe each transition.

Security containment is not eradication. Confirm alternate credentials,
persistence, lateral movement, and affected data before declaring security
recovery. A rolled-back deploy is mitigation, not the permanent fix.

## 8. Handoff and post-incident work

For long incidents, hand off roles and live state explicitly: impact, current
status, actions and outcomes, active hypotheses, hazards, pending decisions,
credentials/access boundaries, next update, and recovery criteria.

Stable recovery and deliberate resolution complete the current incident
endpoint. Do not automatically continue into debugging, a permanent fix, an
audit, or a postmortem. Preserve the timeline and artifacts and name a separate
recommended continuation. Route causal analysis to `yo-debug` only when the
user's request, organization policy, or an authorized incident owner explicitly
includes that post-recovery work. In that continuation, separate trigger,
contributing conditions, detection gaps, mitigation gaps, and systemic causes;
do not force one human or one line of code into a single "root cause."

Create a post-incident review when organization policy or incident impact,
novelty, duration, data/security risk, near miss, or learning value warrants it.
Use `references/post-incident.md`. Follow-up items need a concrete acceptance
condition, owner, priority under the organization's scheme, and durable tracker.
Route the implementation wave through `yo-fix-loop` and regression proof through
`yo-test-coverage`.

Do not automatically create tickets, post recovery notes, publish a postmortem,
or contact stakeholders. When authorized, use `yo-gh-write` only for artifacts
whose destination is actually GitHub; incident status normally belongs in the
organization's designated incident and status systems.

## Stop and report

If the incident is still active, report it as active and continue or hand off; do
not manufacture a completion message. If blocked by authority, access, evidence,
or another owner, state the current harm, actions not taken, exact blocker, safest
recommended action, and who must act.

At handoff or resolution include incident ID/status, impact window, roles, current
state, mitigations and outcomes, recovery evidence, residual risk, frozen or
altered system state, pending communications, follow-up owners, and next action.
If recommending a production network or security-policy mutation, include the
named operator/authority and the allow, deny, capacity, abort, and rollback
evidence explicitly rather than leaving them implied.

Repeat these fields in the handoff when the mutation changes production network
reach or a security policy; one generic black-box check cannot fill both allow
and deny.

## Anti-patterns

- Debugging indefinitely while harm continues.
- Rolling back because a deploy is recent without checking state compatibility.
- Treating availability as more important than data integrity or containment.
- Letting several responders mutate production without command.
- Acting because credentials exist rather than because authority exists.
- Retrying or changing multiple variables without attribution.
- Declaring recovery from one internal metric or one synthetic check.
- Posting secrets, personal data, or forensic evidence in ordinary channels.
- Calling security containment eradication or rollback a permanent fix.
- Creating an unowned timeline, postmortem, or action-item graveyard.

## Research basis

Primary sources and derived rules are in `references/sources.md`.
