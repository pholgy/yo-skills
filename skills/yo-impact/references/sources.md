# Research and decisions

This reference records the evidence behind the workflow and the local decisions made for the Yo bundle. Source authority is labeled as:

- **K:** normative or compatibility guidance
- **I:** official implementation guidance
- **M:** measured research
- **R:** useful reasoning model, not empirical proof

## Evidence map

### Search more than textual references

- **I - Software Engineering at Google, Large-Scale Changes:** codebase analysis combines textual and semantic search; generated or dynamically configured uses can evade standard tools; tests of transitive dependents help expose impact. This supports layered search and explicit search limits.
  <https://abseil.io/resources/swe-book/html/ch22.html>
- **I - GitHub, Navigating code:** semantic code navigation can find definitions and references for supported languages. This supports starting with symbol-aware search without treating it as complete.
  <https://docs.github.com/en/repositories/working-with-files/using-files/navigating-code-on-github>

### Compatibility has multiple dimensions

- **K - Google AIP-180, Backwards compatibility:** distinguishes source, wire, and semantic compatibility and explains why seemingly small API changes can break consumers. These categories are retained and extended with data and operational effects for non-API work.
  <https://google.aip.dev/180>
- **I - Google Engineering Practices, What to look for in a code review:** asks reviewers to consider functionality, complexity, tests, documentation, and effects across the system rather than only the changed lines. This supports examining callers, tests, and system behavior together.
  <https://google.github.io/eng-practices/review/reviewer/looking-for.html>

### History is a lead, not proof

- **K - Git, `git blame`:** documents line provenance and its limits, including moved, copied, deleted, and replaced lines. This supports conditional history inspection and following commits rather than treating blame as rationale or a mandatory gate.
  <https://git-scm.com/docs/git-blame>

### Observable behavior deserves caution

- **R - Hyrum's Law:** a useful warning that consumers may depend on observable behavior. It is a heuristic for asking what can be observed, not proof that every possible dependency exists and not a reason to block all change.
  <https://www.hyrumslaw.com/>

## Bundle decisions

### Kept

- Direct, textual, dynamic, generated, persisted, and external consumer searches.
- Classification of behavioral effects beyond type signatures.
- Sibling-path discovery, persisted/in-flight compatibility, and baseline evidence.
- A one-sentence blast-radius summary for downstream handoff.

### Improved

- Depth is proportional to the integration surface and risk, not a fixed time budget.
- New routes, schemas, config, and destructive operations are not exempt merely because they are additive code.
- History is conditional and evidentiary; deliberate history is not an automatic veto.
- Search scope and unknown external consumers must be stated.
- Siblings are enumerated and scoped rather than automatically edited.
- The compact evidence brief supports the final sentence instead of making one sentence carry the entire analysis.
- A test baseline is required when it improves attribution, not as ritual for every local edit.

### Removed

- Mandatory blame and line-history checks for every change.
- A universal five-minute calibration.
- Unsupported supplementary-fix percentages.
- The claim that the compiler sees a fixed fraction of usages.
- Automatic escalation or implementation beyond the user's authorized scope.
