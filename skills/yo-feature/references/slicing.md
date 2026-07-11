# Slicing and integration patterns

## A good slice

A slice is small enough to reason about and complete, but large enough to prove one behavior, invariant, or high-value uncertainty. It has:

- one observable outcome or learning goal;
- a faithful acceptance oracle;
- declared boundaries and dependencies;
- a safe integration state;
- no invisible reliance on a later slice for basic correctness.

Slice size is a judgment, not a line-count or time quota.

## Split patterns

### By scenario

Start with the simplest valid path, then add denied, invalid, retry, timeout, cancellation, partial failure, and recovery cases.

### By business rule

Deliver a narrow rule set end to end, then add distinct policy variants. Avoid implementing every data field before any user flow works.

### By data partition

Support one meaningful entity/type/source first when the contract is stable, then expand. Do not use this if the partition hides a compatibility or authorization invariant.

### By operation

Read before write, create before update, or one state transition before the full lifecycle when each increment is coherent and safe.

### By channel or actor

One authorized actor, client, or integration first, then others, while keeping shared contract behavior consistent.

### By risk/learning

Build a walking skeleton or spike around the least-known boundary. A spike is evidence, not production code unless it meets production quality and acceptance.

### By rollout cohort

Use a feature flag or routing rule to expose a completed behavior to internal users, a small cohort, or a canary before wider release. Deployment and release remain separate decisions.

## Evolution patterns

### Branch by abstraction

Put an existing supplier behind a stable owned interface, move consumers, introduce the new implementation, switch gradually, then remove the old implementation and temporary abstraction when appropriate.

### Parallel change / expand-contract

For contracts and schemas:

1. expand readers/consumers to accept old and new;
2. deploy compatible readers;
3. change writers/producers;
4. migrate/backfill and observe;
5. contract/remove legacy only after rollback and retained-data windows close.

### Feature flags

Use flags at coherent entry points, not scattered through every branch. Define:

- owner and purpose;
- safe default and failure behavior;
- target cohorts and authorization interaction;
- metrics/rollback trigger;
- expiry/removal condition.

Flags add state combinations and operational debt. Use them when they reduce greater integration/release risk.

## Slice anti-patterns

- Database schema, then backend, then UI, with nothing observable until the end.
- A "foundation" containing unused abstractions for imagined later work.
- A slice that compiles only because dead code is unreachable but has no consumer or proof.
- A flag that makes incompatible data or unauthorized behavior reachable.
- A temporary adapter with no removal condition.
- Several coupled slices edited in parallel and integrated only at the end.
- A small diff that is not independently safe, understandable, or reversible.

## Slice completion questions

- What can a user/caller/operator observe now?
- Which invariant or uncertainty did this slice close?
- Does its test include the real mechanism/boundary?
- Can it be integrated safely before later slices?
- What old/new or enabled/disabled combinations exist?
- What temporary mechanism was added, and when does it leave?
