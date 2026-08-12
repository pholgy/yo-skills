# Research and decisions

Authority labels:

- **I:** official engineering/delivery guidance
- **M:** measured delivery research
- **R:** established practitioner pattern

## Evidence map

### Small coherent changes improve flow and recovery

- **I - Google Engineering Practices, Small CLs:** recommends self-contained changes with related tests, emphasizes reviewability and rollback, and explicitly says there is no universal line-count rule. This supports thin coherent slices while leaving commit topology to repository workflow.
  <https://google.github.io/eng-practices/review/developer/small-cls.html>
- **M - DORA software delivery performance metrics and small batches:** reducing batch size makes changes easier to rationalize, move through delivery, and recover from; small-batch capability predicts delivery and organizational performance.
  <https://dora.dev/guides/dora-metrics/>
  <https://dora.dev/capabilities/working-in-small-batches/>
- **I - Agile Manifesto principles:** working software is the primary progress measure and should be delivered frequently. This supports observable increments rather than layer-complete scaffolding.
  <https://agilealliance.org/agile101/12-principles-behind-the-agile-manifesto/>
- **R - Agile Alliance experience report on vertical slicing:** contrasts end-to-end value slices with horizontal architecture-layer slices and describes incremental audience rollout. It is practitioner evidence, not a universal mandate.
  <https://agilealliance.org/resources/experience-reports/a-tale-of-slicing-and-imagination/>

### Large changes can remain integrated and reversible

- **R - Martin Fowler, Branch by Abstraction:** describes gradual supplier replacement behind an abstraction while the system continues to build and run.
  <https://martinfowler.com/bliki/BranchByAbstraction.html>
- **R - Martin Fowler, Feature Toggles:** separates code deployment from feature release and explains toggle categories and lifecycle cost. This supports selective use with ownership and cleanup rather than flagging by default.
  <https://martinfowler.com/articles/feature-toggles.html>

### Completion includes production-readiness evidence

- **I - Kubernetes Enhancement Proposal template:** mature feature proposals include test plans, graduation criteria, enablement, monitoring, dependencies, scalability, version skew, upgrade, and rollback considerations.
  <https://www.kubernetes.dev/resources/keps/5468/>
- **I - Google SRE, Canarying Releases:** defines canarying as partial time-limited exposure evaluated against control signals and emphasizes small release artifacts, monitoring, and rollback. This supports staged verification only when deployment is in scope.
  <https://sre.google/workbook/canarying-releases/>
- **I - Software Engineering at Google, Testing Overview:** separates test scope and size and ties tests to observable behavior in a controlled environment. This supports selecting a faithful proof layer per slice.
  <https://abseil.io/resources/swe-book/html/ch11.html>

### URL state preserves an explicit router contract

- **K - Angular Router, QueryParamsHandling:** defines merge, preserve, and
  replace behavior for query parameters. This supports preserving unrelated
  parameters and choosing normalization/history behavior intentionally instead
  of letting every filter navigation use an implicit default.
  <https://angular.dev/api/router/QueryParamsHandling>
- **K - Angular Router, RouterConfigOptions:** exposes same-URL, canceled-
  navigation, URL-update, and default query-parameter behavior. This supports
  one canonical URL transition without feedback loops or accidental history
  semantics.
  <https://angular.dev/api/router/RouterConfigOptions>

## Bundle decisions

### Kept

- Scope before implementation, thin slices, one active coupled slice, runnable evidence, end-to-end verification, and cold verification for material changes.
- Context discipline through concise durable intent and evidence.

### Improved

- Process depth is driven by risk/uncertainty, so short destructive requests cannot escape review.
- Feature briefs and slice state reuse existing repository/session mechanisms instead of mandatory files.
- Slices represent coherent behavior or learning and are no longer equated with commits.
- Test strategy is acceptance- and fidelity-driven rather than universally test-first.
- Added walking skeletons, expand-contract, branch by abstraction, flag lifecycle, feature-level integration, operations, accessibility, and partial-work reporting.
- Local verified implementation is a valid endpoint; delivery actions require authority.

### Removed

- Root `SPEC.md` and `features.json` mandates.
- One-issue/one-branch/one-PR and one-slice/one-commit rules owned by `yo-branch`.
- Arbitrary line/week thresholds, hard-coded fresh-session/MCP/shell instructions, and stale UI claims.
- Automatic GitHub posting, raw-log publication, and deployment assumptions.
- The non-Yo cleanup-skill dependency.

## 2026 Golden Engineering Standard update

Google's small-change and simplicity guidance, Microsoft's focus on work that
contributes to done, Anthropic's simplest-effective-pattern guidance, and
OpenAI's smallest-tested-fix practice support direct implementation with
minimum necessary complexity. The full source-to-rule map is in
[the bundle quality standard](../../yo-engineering/references/quality-standard.md).

Derived rule: use one direct slice when it completely satisfies acceptance;
every additional concept or mechanism must answer a current requirement or
demonstrated risk, and the final diff receives a simplification pass.
