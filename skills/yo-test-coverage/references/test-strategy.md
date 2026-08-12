# Test strategy

## Select scope by failure mechanism

| Mechanism or risk | Primary proof | Useful complement |
|---|---|---|
| Pure transformation or invariant | Focused unit test through the owned API | Property/parameter cases for meaningful partitions |
| Adapter maps peer response/error | Component test with controlled transport or owned fake | Contract/sandbox test for real peer compatibility |
| Serialization or schema | Round-trip and contract tests with old/new fixtures | Cross-version or generated-client check |
| Database constraint/transaction | Integration test with the real database engine or faithful hermetic instance | Migration/rollback test for persisted data |
| Queue/job retry or idempotency | Component/integration test with controlled delivery and clock | Duplicate, delayed, and out-of-order cases |
| Race or ordering bug | Controlled schedule/barrier plus invariant assertion | Repeated stress to explore schedules |
| User journey/emergent behavior | Focused system/end-to-end test | Lower-layer tests for each causal boundary |
| Performance regression | Controlled benchmark with declared workload and environment | Profile/trace explaining the difference |

The layer is wrong if the test bypasses the mechanism or cannot distinguish the failure from unrelated noise.

For concurrent optimistic or intent-based state, one representative race is not
enough when other settlement orders can produce a different visible result.
Enumerate the meaningful success, failure, cancellation, and out-of-order
settlement classes; drive each with controlled promises, barriers, or fake time;
and assert that visible state is recomputed from the authoritative base plus the
intents still pending. Reconcile every owned projection of that entity, including
list and detail caches, rather than proving only the currently visible component.
Do not rely only on generation checks or restoring an old snapshot when several
operations can overlap.

For two optimistic intents, make the finite matrix explicit: run both settlement
orders for success/success, success/failure, failure/success, and
failure/failure, plus cancellation only when the product supports it. This is a
bounded decision-relevant matrix, not permission to create a general
permutation framework.

For a memoization or rendering-performance fix, instrumentation alone is not a
behavior oracle. Under unchanged calculation inputs, assert the same rendered
result while unrelated state changes and show the measured work is skipped;
then change each real calculation dependency and assert both recomputation and
the correct new rendered result under the comparable workload.

For latest-request-wins UI behavior, drive controlled success, failure, clear,
loading, cancellation, and repeated-identical-query sequences. Prove that no
terminal path from an obsolete request can alter any visible state.

When replacing a custom interactive shell with an established accessible
primitive, preserve the existing accepted behavior and layout unless the request
changes them. Exercise every existing close/dismiss path as well as accessible
name/description, initial focus, focus containment, Escape policy, and focus
restoration.

## Regression sensitivity

Separate the test change from the production change conceptually even when they land together. In an isolated workspace, apply or retain only the test and necessary test-support changes while production code remains at the pre-fix behavior. Confirm:

1. the test builds and is discovered;
2. it executes the intended path;
3. it fails at the bug-specific oracle;
4. the same test passes with the fix;
5. nearby relevant tests remain green.

For a probabilistic bug, compare a controlled reproduction or failure rate rather than calling one red/green pair decisive. Record trials, environment, and target signature. Prefer making the causal schedule, clock, seed, or event order controllable.

## Characterization without accidental canonization

Characterization can protect a refactor when requirements are incomplete, but each assertion still needs intent:

- **preserve:** behavior is expected and should remain;
- **observe temporarily:** current behavior is required only to separate refactor from a known correction;
- **investigate:** behavior is surprising and should not be pinned until premise or product intent is resolved.

Name or comment temporary observation tests with the linked defect and removal condition. Do not let a golden snapshot turn incidental timestamps, ordering, identifiers, formatting, or a known violation into permanent contract.

## Doubles and boundary fidelity

- Prefer the real object for deterministic value logic and lightweight dependencies.
- Prefer a maintained fake when it implements an owned contract and can be checked against the real implementation.
- Use stubs to select specific inputs or peer outcomes; keep them local to the proposition.
- Use interaction assertions only when the interaction itself is the contract, such as exactly-once publication.
- When the peer is external, define the seam in code you own. Model documented responses and errors, then use a contract, sandbox, or recorded-schema check to detect drift.

Do not call a live public service from the ordinary unit suite. Do not let a unit double become the only evidence for a compatibility-sensitive boundary.

## Nondeterminism and quarantine

- Capture seed, order, clock, host/runtime, and target failure signature.
- Replace sleeps and polling guesses with explicit synchronization or fake time.
- Distinguish product races from test isolation, shared data, environment, and infrastructure failures.
- Treat repeated execution as measurement or schedule exploration, not permission to ignore failures.
- A quarantine needs visible ownership and an exit condition; it should not silently satisfy a required check.
