# Diagnostic techniques

Choose a technique because it can separate live hypotheses, not because it is familiar.

## Technique guide

| Situation | Useful technique | Required caution |
|---|---|---|
| Large failing input or sequence | Delta reduction / minimal reproduction | Preserve the same failure signature; a smaller different failure is not progress. |
| Working and failing cases exist | Differential comparison | Control revision, environment, state, and time; record remaining confounders. |
| Long component or data path | Boundary tracing / midpoint probes | Correlate the same request or state across boundaries. |
| Regression with stable oracle | History bisection | Verify endpoints, isolate build/schema setup, and classify only the target signal. |
| Intermittent or race-like failure | Repeated trials, seed/order capture, scheduler/load variation | Compare rates; instrumentation may suppress or amplify the failure. |
| One-off crash | Dump, symbols, full exception chain, correlated logs/traces | Match the exact binary/build and preserve evidence before rotation. |
| State corruption | Invariants, write/read tracing, provenance and timeline | Avoid mutating original evidence; work from a safe copy when possible. |
| Performance anomaly | Profiles/traces plus controlled benchmark comparison | Warm-up, load, resource contention, and sampling overhead can confound results. |
| Intermittent network or DNS failure | Bidirectional packet/request path plus resource-limit differential | Discriminate application/resolver behavior, node or ENI/IP/port capacity, conntrack/stateful inspection, upstream dependency, retry/search amplification, and load before changing capacity or topology. |

## Reliable observation

Name the oracle before automating experiments. It should identify the target failure rather than any nonzero exit, timeout, or error message.

For probabilistic observations, record trial count, successes/failures, environment, and confidence limits or at least the observed rate. A rate change can support a hypothesis; one pass does not prove an intermittent fix.

When judging an intervention, preserve the original load shape and distinctive
oracle, repeat enough equivalent trials to compare failure rates, and choose a
recurrence window from the observed intermittency rather than an arbitrary
duration. A lighter workload or one clean run is not closure.

For captured evidence, preserve the original artifact, build identity, symbol/version match, timestamps, and correlation identifiers. Derive sanitized or synthetic reproductions without discarding the source evidence.

## Reduction

Reduce input, event sequence, configuration, state, or environment only while the oracle continues to report the same signature. Minimize one dimension at a time when interactions matter. The result need only be small enough to expose the causal mechanism; mathematical minimality is not the goal.

## History bisection

Use bisection only when:

- one endpoint is repeatedly classified old/working and another new/failing;
- the property is sufficiently stable or the runner accounts for noise;
- each candidate can be built and exercised safely;
- environmental drift is not masquerading as a code regression.

An automated runner should return working only for a trustworthy working observation, failing only for the distinctive target failure, and skip for an unevaluable commit. Git reserves exit code 125 for skipped commits in `git bisect run`. Preserve the bisect log and inspect the candidate diff; the selected commit is a lead until its mechanism is demonstrated.

When migrations or toolchains differ, provision each commit's compatible environment or establish verified anchors and bisect within compatible epochs. If skips or oracle noise make the result ambiguous, stop and report a range rather than naming a false culprit.

## Instrumentation

- Prefer existing structured logs, traces, metrics, dumps, and correlation IDs first.
- Add probes at boundaries that divide competing hypotheses.
- Capture invariant-relevant state, not entire payloads.
- Redact secrets and personal data; bound volume and retention.
- Note sampling, buffering, clock, and instrumentation effects.
- Remove temporary probes, or intentionally retain the useful signal with tests and operational ownership.

## Causal confidence

- **High:** controlled intervention or direct trace confirms the mechanism and distinctive signature.
- **Medium:** multiple independent observations support the mechanism, but reproduction or intervention is incomplete.
- **Low:** the hypothesis fits some evidence but alternatives or key boundaries remain unresolved.

Confidence describes the evidence, not the investigator. List the next observation that would most reduce uncertainty.
