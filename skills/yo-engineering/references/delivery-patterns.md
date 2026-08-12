# Reversible delivery patterns

Choose a pattern from repository and deployment reality. These are options, not
mandatory architecture.

## Direct self-contained slice

Use when one focused change can remain buildable, testable, and independently
revertible. Include its related tests and necessary documentation.

## Preparatory slice

Use when the behavior change would otherwise be tangled. First add
characterization tests, extract a seam, or clarify an interface without changing
behavior. Land the behavior change separately when that makes review and
rollback materially clearer.

## Branch by abstraction

Introduce a stable seam over the current implementation, add the replacement
behind it, switch consumers, then remove the old path. Keep each stage usable
with mixed versions where the system requires them.

## Feature flag or dark launch

Use when incomplete slices must integrate before users can reach them or when a
controlled rollout is valuable. Define:

- owner and intended audience
- default state and failure behavior
- observation and rollback signals
- removal condition and follow-up

A flag without a removal plan becomes permanent branching complexity.

## Expand, migrate, contract

Use for public contracts or persisted data:

1. Expand with a compatible shape.
2. Make writers/readers tolerate old and new states.
3. Migrate or backfill in bounded, restartable steps.
4. Reconcile and prove the new state.
5. Contract only after old consumers and data are gone.

Use one migration runner or an explicit lease/fence, prove the real lock and
latency behavior, bound and throttle backfill batches, and rehearse rollback or
recovery from an interrupted step.
Do not combine an irreversible contract step with the initial expansion.

## Transactional outbox

Use when a committed database decision must cause queued, brokered, or external
side effects. Commit the domain mutation and durable outbox intent in one local
transaction. Give each event a stable identity and, where consumers depend on
aggregate order, a monotonic aggregate sequence; dispatch and consume without
silently reordering that sequence. Relays may retry or republish, so consumers
remain duplicate-safe and no workflow claims exactly-once delivery. Cover the
crash windows before commit, after commit/before publish, and after
publish/before acknowledgement, plus backlog reconciliation.

## Infrastructure identity transition

Use when an infrastructure-as-code refactor changes resource addresses or state
identity without intending to replace real infrastructure. Inventory every
address and physical object, encode explicit moves or a controlled state
migration, require a zero-create/delete/replace plan for protected resources,
then canary and batch. Rehearse the reverse or recovery procedure before the
first apply with a disposable or representative state copy; a clean forward plan
or an unexecuted runbook alone is not a rollback.
The handoff records the rehearsal target, command or path, observed result, and
recovery point; saying a runbook exists is insufficient.

## Stateful network transition

Use for cross-cloud routing, stateful firewalls, NAT, or multiple live paths.
Build one bidirectional packet-path model, assign inspection and route ownership,
prove representative capacity, drain existing flows before withdrawing a path,
fail over deterministically, and rehearse failback. Verify expected-allow and
expected-deny paths; a healthy tunnel or BGP session is not user-path proof.

## Progressive rollout or canary

Expose a nonemergency operational change to a limited, representative surface,
observe user-centered and system signals, then promote in stages. Define pause
and rollback thresholds before starting. Roll back before diagnosis when the
canary shows harmful unexpected behavior.

## Wire the entry point last

Use when additive internal pieces can safely land unused. Integrate the
user-visible route, button, job schedule, or public entry point only after the
supporting pieces are verified.

## Selection check

Choose the pattern that best answers:

- Can each intermediate state run safely?
- Can old and new versions coexist where required?
- Can a reviewer isolate intent and risk?
- Can tests attribute a failure to one slice?
- Can rollback preserve already-delivered unrelated value?
- Is temporary machinery owned and scheduled for removal?
