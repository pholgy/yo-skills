# Research and decisions

Authority labels:

- **K:** official tool or interoperability specification
- **I:** official engineering/operations guidance
- **M:** peer-reviewed or measured research

## Evidence map

### Troubleshooting is evidence-driven, not reproduction-gated

- **I - Google SRE, Effective Troubleshooting:** presents hypothesis-driven diagnosis, working-vs-failing comparison, safe experiments, evidence notes, and correlation caution. It explicitly notes that production reproduction may be unsafe or impossible, tests can perturb behavior, and multiple factors may jointly cause a failure.
  <https://sre.google/sre-book/effective-troubleshooting/>
- **I - Google SRE, Postmortem Culture:** focuses on contributing causes and preventive actions without blaming individuals. This supports recording enabling conditions rather than forcing every failure into one simplistic root cause.
  <https://sre.google/sre-book/postmortem-culture/>

### Reduction and flake diagnosis need a trustworthy signal

- **M - Zeller and Hildebrandt, Simplifying and Isolating Failure-Inducing Input:** formalizes delta debugging to reduce failure-inducing circumstances. The skill uses reduction when an oracle can preserve the same signature, not as a universal prerequisite.
  <https://www.st.cs.uni-saarland.de/papers/tse2002/>
- **M - Google Research, De-Flake Your Tests:** evaluates automated localization of flaky-test causes across hundreds of Google projects. This supports treating repeated-run history and failure localization as evidence instead of demanding an immediately deterministic local reproduction.
  <https://research.google/pubs/de-flake-your-tests-automatically-locating-root-causes-of-flaky-tests-in-code-at-google/>

### Bisection requires honest classifications

- **K - Git, `git bisect`:** defines old/new endpoint search, automated runners, `skip`, and exit code 125 for untestable commits. This supports schema-aware runners, skipped revisions, and preserving ambiguity when commits cannot be classified.
  <https://git-scm.com/docs/git-bisect>

### Diagnostic evidence must be correlated and safe

- **K - OpenTelemetry, Context Propagation:** trace and span context correlates telemetry across service boundaries. This supports request/trace identifiers and boundary tracing.
  <https://opentelemetry.io/docs/concepts/context-propagation/>
- **I - OWASP Logging Cheat Sheet:** logging should exclude or de-identify sensitive data and account for legal and security constraints. This supports privacy-safe evidence capture and targeted instrumentation.
  <https://cheatsheetseries.owasp.org/cheatsheets/Logging_Cheat_Sheet.html>

## Bundle decisions

### Kept

- Falsifiable hypotheses, controlled experiments, negative evidence, reduction, bisection, targeted instrumentation, and a written causal chain.
- A strong preference for a minimal deterministic reproduction when it is safe and available.
- Incident mitigation preemption and converting a reproduction into regression coverage.

### Improved

- Replaced the deterministic-reproduction gate with a hierarchy of trustworthy observations.
- Defined a cause as an intervention-sufficient mechanism, with calibrated confidence and unresolved alternatives.
- Added evidence preservation, explicit failure signatures, good/bad comparison, hypothesis ledgers, privacy, confounders, and instrumentation effects.
- Made bisection conditional on a reliable oracle, compatible environments, and honest skipped commits.
- Allowed multiple contributing factors and probabilistic evidence for complex or one-off failures.
- Made diagnosis-only requests read-only and routed impact analysis before implementation.

### Removed

- The claims that no debugging can begin without on-command reproduction and that an unreproduced failure must only be filed and abandoned.
- The instruction to treat the first application stack frame as the cause.
- The implication that observation before prediction teaches nothing.
- Universal single-variable, fixed-attempt, fixed-probe, and single-root-cause rules.
- Book-derived slogans where stronger primary or official guidance is available.
