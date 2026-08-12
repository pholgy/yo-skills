---
name: yo-debug
description: Diagnose a confirmed failure whose causal mechanism is unknown. Use for crashes, regressions, intermittent or CI-only failures, performance anomalies, data corruption, and debugging that has become speculative; skip it when the supplied failing transition or schedule already predicts the scoped intervention and discriminating test.
---

# Yo Debug

Turn a confirmed symptom into an evidence-backed causal explanation. Diagnose only unless the user also authorized a fix.

## Entry and preemption

Use this skill when the failure is observable but the mechanism is not known well enough to choose an intervention.

- If the claim itself is unverified, use `yo-verify-premise` first.
- If production is actively impaired, use `yo-incident` to mitigate and preserve evidence before cold diagnosis.
- If the mechanism is already intervention-sufficient, skip this loop. Map
  contained local impact inline before editing; use `yo-impact` only when the
  diagnosed change reaches a material shared, public, dynamic, persisted,
  authorization, external, mixed-version, or uncertain-consumer surface.

An explanation is intervention-sufficient when it identifies the mechanism and conditions well enough to predict why a specific change should prevent the failure. A suspicious line, correlation, or component name is not enough.

The evidence may come from the user's current report. A stated causal schedule
such as stale completion overwriting newer state, snapshot rollback erasing a
later intent, arrival-ordered events reversing authoritative state, or a
specified partial-failure window is sufficient to skip this workflow when it
already selects the correction and a discriminating test. Confirm it while
implementing; do not run a separate hypothesis loop solely to re-prove the
premise. A vague component association, timing correlation, or unexplained
symptom still requires diagnosis.

## Investigation loop

### 1. Define and preserve the failure signature

Record the smallest signature that distinguishes this failure from unrelated noise:

- expected and actual behavior;
- exact error, invariant violation, or measurable deviation;
- revision, build, environment, configuration, input characteristics, and time window;
- affected scope and known-good comparison;
- request, trace, job, test, seed, or crash identifiers;
- logs before and during the failure, traces, dumps, screenshots, and CI artifacts.

Preserve original evidence before rerunning or changing the system. Redact secrets and personal data; do not copy unsafe customer payloads merely to improve reproducibility.

### 2. Build the strongest safe observation available

A minimal deterministic reproduction is ideal, not a prerequisite for thought.

Use the strongest available signal:

1. a deterministic minimal reproduction;
2. a controlled but probabilistic reproduction with a measured failure rate and distinct signature;
3. a captured production/CI trace, dump, or correlated event with enough state to test hypotheses;
4. a plan to collect discriminating evidence on the next occurrence.

Match the original revision and environment before concluding that a local non-reproduction is contradictory. For intermittent failures, preserve seeds and order, vary scheduling or load deliberately, repeat enough to compare rates, and separate product, test, and infrastructure failure modes.

If no trustworthy observation exists, report that evidence gap and improve capture. Do not label the claim disproved or a speculative patch verified.

### 3. Trace the system and compare good with bad

Follow the request, state, or data across component boundaries. Read the full error chain and pre-failure context; the first application frame is a starting point, not automatically the cause.

Compare failing and working cases across input, state, time, host, architecture, dependency, configuration, deploy, and recent change. Build a short timeline when ordering matters. Search history for candidate changes, but do not confuse temporal proximity with causation.

Use correlation identifiers across services. When observability is missing, add the smallest safe probe that separates hypotheses.

### 4. Maintain a hypothesis ledger

Rank plausible hypotheses by likelihood, explanatory power, and test risk. For each one, write:

```markdown
Hypothesis: <possible mechanism>
Prediction: <evidence expected if true, and if false>
Test: <safe discriminating observation or experiment>
Result: <observed evidence>
Status: supported | weakened | rejected | unresolved
```

Prefer tests that distinguish several hypotheses. Change one controlled factor at a time when attribution depends on it; when that is impossible, record the confounders. Negative results narrow the search and belong in the ledger.

Do not retrofit a prediction after seeing the result. Updating a hypothesis from new observations is valid; pretending it predicted those observations is not.

### 5. Isolate with the appropriate technique

Use [references/techniques.md](references/techniques.md) to choose among reduction, boundary tracing, differential comparison, instrumentation, dumps/debuggers, repeated trials, and history bisection.

For intermittent network or DNS failures, explicitly disposition endpoint or
resolver behavior, pod/service saturation, node and ENI/IP/port limits,
conntrack or stateful inspection, upstream dependency, amplification, and
directional routing. Mark each supported, refuted, or still unknown; do not hide
an untested branch inside “networking.”

Initialize the following matrix before adding more specific hypotheses. A
network/DNS diagnosis is incomplete while a row is missing; `unknown` is honest
and preferable to omission:

| Branch | Supported / refuted / unknown | Discriminating evidence |
|---|---|---|
| Endpoint/resolver behavior | | |
| Pod/service saturation | | |
| Node and ENI/IP/port limits | | |
| Conntrack/stateful inspection | | |
| Upstream dependency | | |
| Amplification/retry/search behavior | | |
| Directional routing/path | | |

For a claimed intervention or permanent fix, repeat the same distinctive oracle
under an equivalent load and environment, compare the failure rate, and observe
for a recurrence-aware window derived from the original intermittency. One
successful trial or a different/lighter workload cannot close the diagnosis.

Important constraints:

- Reduction needs an oracle that preserves the same failure signature.
- Bisection needs verified old/new endpoints and a trustworthy classifier. Skip unevaluable commits; schema or environment drift may require separate epochs.
- Instrumentation can alter timing, load, and behavior. Keep it targeted, correlated, privacy-safe, and removable or deliberately promoted to durable observability.
- Production experiments must be low risk and authorized. Prefer passive evidence or a safe non-production equivalent.

### 6. Establish the causal explanation

Write the shortest explanation that accounts for all distinctive evidence:

> `<trigger>` under `<enabling conditions>` causes `<mechanism>`, which produces `<observed failure>` because `<causal link>`.

Include contributing factors when no single factor is sufficient. State confidence and unresolved alternatives. Strengthen the explanation with at least one of:

- a controlled intervention changes the predicted result;
- the mechanism reproduces the distinctive signature;
- independent evidence traces the state transition through the failure;
- the explanation predicts another observation that is then confirmed.

Stop when the explanation is sufficient to select and verify an intervention, not when every historical or architectural question is answered.

## Output

```markdown
Failure signature: <distinct symptom and scope>
Evidence: <artifacts, reproduction strength, and comparisons>
System boundary: <path traced and relevant environment>
Hypotheses tested: <results, including negative evidence>
Network/DNS disposition when applicable: <endpoint/resolver; pod/service;
node/ENI/IP/port; conntrack/stateful path; upstream; amplification/retry;
directional route — each supported, refuted, or unknown>
Causal explanation: <trigger, conditions, mechanism, failure>
Confidence and gaps: <high/medium/low with unresolved alternatives>
Next: <more evidence, yo-impact, or authorized fix workflow>
```

Do not collapse the network/DNS disposition into a generic hypothesis sentence;
every listed branch must remain visible until evidence closes it.

If cause remains unknown, say so. A high-quality partial diagnosis narrows the next observation; it does not manufacture certainty.

## Guardrails

- Do not edit during a diagnosis-only request.
- Do not shotgun-change multiple factors and attribute the outcome to one.
- Do not equate correlation, recent commits, or a stack-frame location with cause.
- Do not assume the framework or dependency is at fault or innocent; test the boundary. Use `yo-deps` if dependency action becomes necessary.
- Do not rerun destructive, privacy-sensitive, or production-impacting inputs without authority.
- Do not hide a flake with retries or broad exception handling.
- Do not require certainty that the available system cannot provide; state calibrated confidence.
- Repeated failed fixes are evidence to return to the signature and hypotheses, not a reason for another guess.

## Handoff

- Carry the causal evidence forward. Map contained local consumers inline; use
  `yo-impact` for a material boundary or uncertain blast radius before changing
  the diagnosed mechanism.
- Turn a safe reproduction into a regression test with `yo-test-coverage`.
- Use `yo-fix-loop` for multiple findings or `yo-feature` for genuinely new behavior.
- Use `yo-audit` to independently verify the completed change when the inherited
  lane is S2/S3, repository policy requires it, or independence is the explicit
  purpose. Otherwise finish with focused proof and scoped self-review.

## References

- [Diagnostic techniques](references/techniques.md)
- [Research and decisions](references/sources.md)
