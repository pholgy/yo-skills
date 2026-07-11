---
name: yo-test-coverage
description: Design, add, or assess automated tests that protect meaningful behavior. Use for regression tests paired with bug fixes, characterization before refactoring, risk-based coverage backfill, contract tests, flaky-test follow-up, and requests such as "add tests," "lock this in," "what covers this," or "prove the test catches the bug."
---

# Yo Test Coverage

Protect a precise behavioral proposition with a test that can fail for the right reason. Line coverage is a search aid, not the objective.

Respect the requested mode: review or planning stays read-only; implementation may add tests and, when authorized, the paired production change.

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

### 5. Prove sensitivity to the pre-fix mechanism

A regression test must fail for the bug-specific reason without the production fix and pass with it. Valid proof patterns include:

1. run the new test red before implementing the fix, then green after;
2. apply only the test/test-support diff to an isolated parent revision;
3. keep the new test while temporarily reverting the production fix in an isolated workspace;
4. mutate the diagnosed seam to restore the pre-fix behavior when revision replay is impractical.

Use the same targeted command and comparable environment on both sides. A compile error caused by a missing test helper, discovery failure, unrelated failure, or different behavior does not prove the regression test is sensitive.

If the parent cannot build, the failure is probabilistic, or environment drift prevents a fair comparison, report the limitation and the strongest alternate evidence. Do not write "failed before fix" unless it was observed.

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

Production behavior and its regression protection should land in the same reviewable change unless an emergency policy applies. Characterization coverage may land first as an independently green change before a refactor. Follow `yo-branch` for commit shape rather than inventing a commit rule here.

## Output

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

## Handoff

- `yo-verify-premise` supplies the confirmed behavior and `yo-debug` supplies the mechanism or reproducible signal.
- `yo-impact` identifies consumers that may need coverage at more than one layer.
- `yo-fix-loop` keeps the test and fix inside the same finding lifecycle.
- `yo-audit` independently checks test sensitivity and missing risk.
- `yo-engineering` owns the broader verification gate; `yo-branch` owns commit conventions.

## References

- [Test strategy](references/test-strategy.md)
- [Research and decisions](references/sources.md)
