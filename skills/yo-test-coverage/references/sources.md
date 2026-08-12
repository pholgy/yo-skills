# Research and decisions

Authority labels:

- **I:** official engineering guidance
- **M:** measured or peer-reviewed research
- **R:** canonical practitioner source used for terminology

## Evidence map

### Tests belong with behavior changes and must be useful

- **I - Google Engineering Practices, What to look for in a code review:** asks for the appropriate unit, integration, or end-to-end tests in the same changelist as production code except emergencies, and asks whether tests fail when code is broken. This supports atomic review and explicit sensitivity proof.
  <https://google.github.io/eng-practices/review/reviewer/looking-for.html>
- **I - Google Engineering Practices, Small CLs:** related tests normally stay with the change, while independent characterization coverage can land before a refactor. This supports same-reviewable-change language rather than a universal literal-commit rule.
  <https://google.github.io/eng-practices/review/developer/small-cls.html>

### Scope, behavior, and maintainability matter more than raw coverage

- **I - Software Engineering at Google, Testing Overview:** separates test size from scope and defines a test around a behavior, input, observable output, and controlled environment. This supports selecting the smallest faithful scope.
  <https://abseil.io/resources/swe-book/html/ch11.html>
- **I - Software Engineering at Google, Unit Testing:** recommends testing through public APIs, testing state more than interactions, and naming tests after behaviors. This supports behavior-centered propositions and stable oracles.
  <https://abseil.io/resources/swe-book/html/ch12.html>
- **M - Code Coverage at Google:** describes coverage as actionable change-level information while documenting adoption and limitations at scale. Coverage identifies areas to inspect; it does not establish test quality by itself.
  <https://research.google/pubs/code-coverage-at-google/>
- **M - State of Mutation Testing at Google:** mutation analysis asks whether tests detect introduced faults and is used selectively at review scale. This supports sensitivity checks when pre-fix replay is impractical without requiring mutation for every change.
  <https://research.google/pubs/state-of-mutation-testing-at-google/>

### Doubles trade speed for fidelity

- **I - Software Engineering at Google, Test Doubles:** recommends real implementations when practical, fakes when a double is needed, and attention to fidelity and brittleness. It explicitly uses controlled doubles for external services and recommends supplementing them with larger tests.
  <https://abseil.io/resources/swe-book/html/ch13.html>
- **I - Software Engineering at Google, Larger Testing:** explains the fidelity gaps of unit doubles and the role of integration and larger-scope tests at behavioral contracts. This supports boundary-level complementary coverage.
  <https://abseil.io/resources/swe-book/html/ch14.html>

### Flakiness must remain visible and owned

- **M - Google Testing Blog, Flaky Tests at Google:** documents the trust and productivity cost of flaky tests and Google's investment in detection, tracking, and mitigation. This supports explicit classification and ownership rather than silent retries.
  <https://testing.googleblog.com/2016/05/flaky-tests-at-google-and-how-we.html>
- **M - Google Research, De-Flake Your Tests:** evaluates automated localization of flaky-test causes across hundreds of Google projects. This supports preserving failure history and treating flake diagnosis as evidence work.
  <https://research.google/pubs/de-flake-your-tests-automatically-locating-root-causes-of-flaky-tests-in-code-at-google/>

### Characterization is observation, not approval

- **R - Michael Feathers, _Working Effectively with Legacy Code_ (2004):** provides the canonical characterization-test term for learning and pinning existing behavior before change. The bundle explicitly adds intent labels so observed defects are not mistaken for desired contracts.

### Stateful UI tests cover the user-visible contract

- **K - W3C WAI-ARIA APG, Modal Dialog Pattern:** defines contained focus,
  Escape behavior, accessible naming, initial focus, visible close affordance,
  and focus restoration. This supports exercising the established dialog
  primitive without silently dropping existing interaction paths.
  <https://www.w3.org/WAI/ARIA/apg/patterns/dialog-modal/>
- **K - TanStack Query, Optimistic Updates:** documents cancellation,
  snapshots/rollback, settlement invalidation, and list updates through owned
  query keys. The bundle adds the concurrency-specific requirement to test all
  meaningful settlement orders and reconcile every owned projection rather
  than treating one rendered cache as the whole invariant.
  <https://tanstack.com/query/latest/docs/framework/react/guides/optimistic-updates>
- **K - React, `useMemo` and `Profiler`:** `useMemo` recomputes from declared
  reactive dependencies and is explicitly a performance optimization, while
  Profiler measures commits. The bundle therefore pairs measurement/call-count
  proof with rendered-result correctness for unchanged and changed inputs.
  <https://react.dev/reference/react/useMemo>
  <https://react.dev/reference/react/Profiler>

## Bundle decisions

### Kept

- Regression tests should detect pre-fix behavior and pass with the fix.
- Tests match repository idioms, focus on a behavior, avoid implementation coupling, and pair with the production change.
- Characterization and risk-based backfill remain distinct modes.

### Improved

- Added contract mode, faithful layer selection, owned test seams, concurrency patterns, and higher-fidelity complements for doubles.
- Replaced the broken parent-worktree example with four valid sensitivity-proof patterns.
- Characterization no longer declares every observed behavior a contract.
- Disabled/quarantined tests are reported as gaps, not counted as protection.
- Atomicity is defined at the reviewable-change level; `yo-branch` owns commit topology.
- Completion uses the smallest repository-required gate that observes the
  affected surface; root-wide verification needs an explicit policy or
  cross-surface risk trigger.

### Removed

- TDD culture-war commentary unrelated to the task.
- The absolute ban on third-party test doubles.
- Fixed flake percentages, framework-specific skip syntax, and permanent skip-as-solution advice.
- Commit-SHA reporting when no commit exists.
- An unrelated cleanup-skill dependency outside this bundle.

## 2026 Golden Engineering Standard update

Google's review guidance treats tests as maintained code and asks whether they
are simple and useful; Google SRE treats unnecessary code as ongoing liability.
The primary links and full policy are in
[the bundle quality standard](../../yo-engineering/references/quality-standard.md).

Derived rule: choose the smallest faithful test and do not build a fixture
framework, helper hierarchy, or overlapping cases unless they close a distinct
risk or reduce total test complexity now.
