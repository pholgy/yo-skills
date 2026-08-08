---
name: yo-test-coverage
description: Design, add, or assess automated tests that protect meaningful behavior. Use for regression tests paired with bug fixes, characterization before refactoring, risk-based coverage backfill, contract tests, flaky-test follow-up, and requests such as "add tests," "lock this in," "what covers this," or "prove the test catches the bug."
---

# Yo Test Coverage

Protect a precise behavioral proposition with the smallest faithful test that
can fail for the right reason. Tests are maintained production assets: keep
them direct, readable, deterministic, and no more abstract than the behavior
requires. Line coverage is a search aid, not the objective.

Respect the requested mode: review or planning stays read-only; implementation may add tests and, when authorized, the paired production change.

## Default regression path for one bug

A confirmed deterministic bug with a known cause enters **regression** mode
automatically. Do not ask the user to choose a mode or require the full workflow
when this compact path is sufficient:

1. Discover the target's local test idiom, applicable instructions, focused
   command, and proportionate repository gates. Note a pre-existing failure
   before attributing it to the change.
2. State one given/when/then proposition and choose the narrowest faithful layer
   with an observable behavior, invariant, or owned-boundary oracle.
3. Add focused regression protection at the narrowest faithful layer, covering
   realistic in-scope paths that share the diagnosed mechanism, and implement
   the scoped fix in the same reviewable change. For a known bug in a Bun
   repository, prefer the narrow focused Bun regression command; otherwise use
   the repository's native focused runner.
4. Use red-before-green proof only when the risk justifies proving sensitivity,
   using a valid pattern in step 5 below. An ordinary clear, low-risk bug does
   not need a separate RED phase merely to satisfy ceremony.
5. Run the narrow focused command first, then the repository completion gate;
   add a surrounding or contract suite only when it protects a distinct risk.
   Report the test, any required sensitivity evidence, post-fix checks, and gap.

This is the default for a production bug fix, not an absolute claim that every
defect has a faithful executable seam. If the cause is unknown, route through
`yo-debug`. If a regression test would mock away the mechanism, cannot execute
in the available environment, or an incident exception applies, use the full
workflow's honest-gap rules and make the missing protection an owned follow-up.

Use the full workflow for characterization, backfill, contract work, multiple
affected surfaces, concurrency or nondeterminism, difficult sensitivity proof,
or any case where the compact path stops being faithful.

Terminology matters:

- A **regression test** protects behavior so the bug cannot return silently.
- **RED proof** demonstrates that the test fails against the pre-fix mechanism
  and passes with the fix. It is sensitivity evidence, not a separate test kind.
- The same test can be a "focused Bun regression test with red-before-green
  proof."

Keep the test and fix together unless the user explicitly requests separate
evidence or a repository policy requires a separately reviewable
characterization step. Do not let RED proof delay an obvious implementation
without a risk-based reason.

## Choose the test's job

- **Regression:** encode the confirmed failure signature and the intended corrected behavior so the same mechanism cannot return silently.
- **Characterization:** record selected current behavior before a behavior-preserving refactor. This describes observation, not approval or product contract.
- **Coverage backfill:** protect the highest-risk untested behavior, invariant, failure mode, or boundary rather than the easiest uncovered line.
- **Contract:** verify assumptions at a component, wire, schema, provider, or consumer boundary where a unit double could drift.

For a known defect, do not disguise current behavior as desired behavior. Prefer the desired regression test with the fix. If a separate refactor must preserve the defect temporarily, label the characterization as temporary, link the defect, and define when it will be replaced.

## Workflow

### 1. State the proposition and oracle

Write the behavior before writing the fixture:

> Given `<state/input>`, when `<action>`, then `<observable outcome>`.

For a regression, include the distinctive failure mechanism from `yo-debug` or the verified premise. Choose an oracle that detects user- or contract-visible behavior, an invariant, or an owned boundary outcome. A status code, returned state, emitted event, persisted record, or explicit domain error is usually stronger than an internal call count.

Name the test after the behavior and condition, using the repository's convention. Multiple closely related assertions are fine when they jointly prove one proposition and failures remain diagnostic.

### 2. Read the local test system

Inspect adjacent tests, shared fixtures, builders, fakes, test commands, CI grouping, and repository guidance. Reuse the established idiom unless it cannot express the required behavior. Identify what the existing suite already proves to avoid redundant tests.

Do not create a new fixture framework, builder hierarchy, custom runner, or
generic helper for one case unless it makes the test materially clearer and
reduces total test complexity now. A small local setup is often the better
design.

### 3. Select the narrowest faithful layer

Choose the smallest scope that still contains the diagnosed mechanism:

- pure logic or local state transition: focused unit test;
- owned adapter or component boundary: component test with a controlled peer;
- database, serialization, transaction, queue, filesystem, or process boundary: integration/contract test;
- behavior emerging only across a deployed journey: focused end-to-end or system test.

Do not force a unit test by mocking away the bug. Do not default to end-to-end when a smaller faithful test can prove the same proposition. Use [references/test-strategy.md](references/test-strategy.md) for boundary, concurrency, and nondeterminism patterns.

### 4. Choose real dependencies and doubles deliberately

Prefer a real implementation when it is fast, deterministic, safe, and easy to construct. Otherwise place a fake or stub at an owned seam:

- model only the documented behavior needed for the proposition;
- trigger rare errors directly rather than sleeping or using a live network;
- assert the system-under-test outcome, not the double's implementation choreography;
- supplement a low-fidelity double with a contract or larger-scope test against the real boundary when compatibility matters.

For third-party SDKs, keep the owned adapter real and control its transport or owned interface. Do not invent undocumented provider behavior in a mock.

### 5. Prove sensitivity when risk warrants it

Design every regression test to exercise the pre-fix mechanism. Require observed
RED proof when its extra confidence is material, including:

- reliability, concurrency, security, idempotency, checkpoint, retry, or
  circuit-breaker defects;
- subtle bugs or defects that previously escaped an audit while tests were
  green;
- work whose stated objective is to prove the test catches the pre-fix
  mechanism;
- a PR or audit claim that a test closes an important regression.

Do not require RED proof merely because an issue exists. It is normally optional
for a small known-cause bug, simple coverage backfill, characterization before a
refactor, or clear implementation work without a verified defect.

When RED proof is warranted, the regression test must fail for the bug-specific
reason without the production fix and pass with it. Valid proof patterns include:

1. run the new test red before implementing the fix, then green after;
2. apply only the test/test-support diff to an isolated parent revision;
3. keep the new test while temporarily reverting the production fix in an isolated workspace;
4. mutate the diagnosed seam to restore the pre-fix behavior when revision replay is impractical.

Use the same targeted command and comparable environment on both sides. A compile error caused by a missing test helper, discovery failure, unrelated failure, or different behavior does not prove the regression test is sensitive.

If the parent cannot build, the failure is probabilistic, or environment drift prevents a fair comparison, report the limitation and the strongest alternate evidence. Do not write "failed before fix" unless it was observed.

Keep the RED check narrow and time-bounded. Do not create a long RED-only branch
or phase without implementation, run a broad suite to hunt for an unknown-scope
failure, force RED on every issue, or use sensitivity proof as a reason to delay
a clear fix without proportional benefit.

### 6. Make the test trustworthy

- Test behavior or invariants through a stable public/owned seam, not private implementation details.
- Control clocks, randomness, locale, order, scheduling, network, and data where they affect the proposition.
- For concurrency, use barriers, controllable executors, model/state checks, or repeated stress as supplementary evidence; a single lucky pass is not proof.
- Keep setup relevant and failure output diagnostic. Avoid branching or reimplementing production logic inside the test.
- Isolate mutable state and clean up resources even when the assertion fails.
- Cover the error/negative path that caused the bug, not only the happy path.

Retries may measure or investigate a flake; they must not convert an unexplained failure into a green result. Route an unexplained intermittent through `yo-debug`.

### 7. Handle unexecutable coverage honestly

A disabled, skipped, quarantined, or expected-failure test is documentation and future work, not regression protection.

If the required environment is unavailable:

- first seek a lower, faithful seam or hermetic harness;
- otherwise follow repository quarantine policy with a specific reason, owner, issue, and review/expiry condition where supported;
- report the coverage gap and do not count the test as passing proof.

Emergency fixes may ship before complete coverage when incident policy requires it, but the missing test becomes an owned follow-up rather than a forgotten exception.

### 8. Verify and ship atomically

Run the focused test, the relevant surrounding suite, and the repository's proportionate verification gate. Confirm the test is discovered in the normal CI path.

Review the test diff for accidental complexity. Remove helpers, branches,
fixtures, snapshots, or duplicated cases that do not protect a distinct
behavior or make the oracle clearer, then rerun affected tests.

Production behavior and its regression protection should land in the same reviewable change unless an emergency policy applies. Characterization coverage may land first as an independently green change before a refactor. Follow `yo-branch` for commit shape rather than inventing a commit rule here.

## Output

For one straightforward regression, this short form is sufficient:

```text
Regression: <test name> — sensitivity <required proof, not required with reason, or limitation>; post-fix <focused command then repo gate>.
Gap: <none, or the explicit unprotected boundary/follow-up>.
```

Use the full record when the mode, evidence, or remaining risk needs more
context:

```markdown
Mode: <regression | characterization | backfill | contract>
Proposition: <given/when/then behavior>
Layer and oracle: <scope and observable proof>
Tests changed: <names and purpose>
Pre-fix proof: <observed failure and environment, or limitation>
Post-fix proof: <focused and surrounding results>
Coverage gaps: <quarantine, external boundary, or none>
```

Do not require a commit SHA when no commit was requested or created.

## Guardrails

- Do not optimize for a percentage without identifying the risk it represents.
- Do not accept a test that passes before and after the target mechanism unless it is explicitly characterization or backfill.
- Do not snapshot broad unstable output when a precise semantic assertion exists.
- Do not freeze a known defect as an unlabeled contract.
- Do not make real customer or production data a hidden fixture dependency.
- Do not silently disable a test or count a quarantined test as protection.
- Do not add overlapping tests that increase maintenance without closing a distinct risk.
- Do not build generalized test infrastructure for hypothetical future cases.

## Handoff

- `yo-verify-premise` supplies the confirmed behavior and `yo-debug` supplies the mechanism or reproducible signal.
- `yo-impact` identifies consumers that may need coverage at more than one layer.
- `yo-fix-loop` keeps the test and fix inside the same finding lifecycle.
- `yo-audit` independently checks test sensitivity and missing risk.
- `yo-engineering` owns the broader verification gate; `yo-branch` owns commit conventions.

## References

- [Test strategy](references/test-strategy.md)
- [Research and decisions](references/sources.md)
