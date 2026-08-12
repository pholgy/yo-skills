---
name: yo-verify-premise
description: >-
  Verify a claimed bug, behavior, safety condition, or change premise against
  the current code and relevant runtime evidence before editing. Use when the
  user asks for verification or investigation, or when a fix depends on a
  premise that is uncertain, stale, disputed, environment-dependent,
  consequential, or causally unclear. Do not invoke the full workflow solely
  because a clear low-risk request says "fix"; a focused read or existing check
  may establish that premise inline. Bind material claims to a revision and
  environment, choose the cheapest strong evidence, distinguish symptom from
  cause, and report a calibrated verdict. If credible evidence was already
  supplied, validate that it still applies instead of repeating it blindly.
---

# Yo Verify Premise

Treat the report as a hypothesis, not a fact or a mistake. Establish what is
true in the current target before changing product code.

## Core contract

- Keep product code unchanged until the verdict is clear.
- Treat the current repository, revision, configuration, runtime, and live
  issue or PR state as authoritative for the target being changed.
- Use evidence proportionate to the claim. Prefer a cheap decisive check over a
  broad ritual.
- Reuse credible evidence while its revision, environment, and triggering
  conditions still match; validate identity instead of repeating the same check.
- For a clear low-risk task, the focused read or existing check can be the whole
  premise verification. Escalate into this workflow only when its verdict or
  evidence record changes the safe next action.
- For an authorized implementation request that already states a causal
  transition/schedule and a discriminating regression can prove it, inspect the
  relevant code/test inline. Do not create this standalone verdict step merely
  because the final fix still needs RED/green evidence.
- Distinguish observed symptom, proposed cause, impact, and proposed fix; each
  can have a different evidence state.
- Never turn failure to reproduce under one environment into proof that the
  report is false.

Active production impact preempts this workflow. Route to `yo-incident` to
mitigate first while preserving diagnostic evidence.

## Verification workflow

### 1. Bind the claim

Restate one falsifiable claim with:

- expected and observed behavior
- triggering input or action
- affected revision, branch, build, or deployment
- relevant environment and configuration
- cited issue, PR, file, log, test, or timestamp

Inspect available repository and tracking context before asking the user. Ask
only for missing information that materially changes the check.

When the user already reproduced the problem, treat that result as evidence.
Do not repeat an expensive reproduction by default. Confirm that its revision,
environment, and conditions still match the target now being changed.

### 2. Choose the strongest efficient check

Read [the evidence model](references/evidence-model.md). Start with non-mutating
inspection and the narrowest evidence that can distinguish the plausible
outcomes:

- focused existing test or controlled reproduction
- current code, configuration, and data-flow trace
- logs, traces, metrics, or artifacts bound to the reported time and build
- specification, contract, or documented expected behavior
- version history when the report may be stale or a behavior was deliberate

A fix-looking commit, guard, closed issue, or changelog entry is a lead, not
runtime proof. Trace that it covers the reported path and, when practical, run
the focused current-state behavior check before assigning a stale/resolved
verdict.

Search to locate the path, then read enough surrounding and connected code to
understand the relevant control and data flow. Widen the read when imports,
callers, configuration, generated code, or external boundaries affect the
claim. Do not substitute an arbitrary line window or mandatory full-file read
for understanding.

### 3. Test the hypothesis

Match the reported conditions as closely as practical. Record the exact command
or interaction, target revision, environment, observed output, and any
confounders.

For a static or architectural claim, trace the conditions required for it to be
true and verify whether those conditions are reachable. For intermittent or
environment-specific behavior, compare the failing and passing environments
instead of repeatedly exercising only the passing one.

Do not perform destructive diagnostics or alter production state merely to
obtain a reproduction. Use the relevant approval and risk gate first.

### 4. Separate symptom from cause

Answer independently:

1. Does the reported symptom occur on the target?
2. Under which conditions does it occur?
3. Is the reported cause supported, contradicted, or still unknown?
4. Is the proposed edit at the actual failure boundary?
5. Is the scope narrower or wider than reported?

If the symptom is confirmed but the cause remains unknown, route to `yo-debug`
before implementing a speculative fix.

### 5. Assign a calibrated verdict

Use exactly one primary verdict:

- **Confirmed** — the current target shows the claim under the stated
  conditions.
- **Confirmed differently** — a real problem exists, but the condition, cause,
  location, or expected behavior differs.
- **Confirmed broader** — the claim is real and materially understates scope or
  impact.
- **Not reproduced** — the tested conditions did not show it; the claim remains
  unresolved outside those conditions.
- **Disproved or stale** — a current trace or behavior check decisively
  contradicts the claim or shows the reported path was already resolved.
- **Insufficient evidence** — required target, environment, artifact, or safe
  test is unavailable.

Record cause separately as **known**, **probable**, **unknown**, or **not
applicable**. Mark a cause **known** only when the causal mechanism explains the
important conditions and is specific enough to justify the next intervention.
A failing component, exception, or nearest error boundary is not automatically
the root cause. A confirmed symptom is not proof of the reported cause.

### 6. Choose the next owner

- Confirmed with known cause -> map contained local impact inline as
  `target -> direct consumers -> focused proof`; use the full `yo-impact`
  workflow only for a material shared, public, dynamic, persisted,
  authorization, external, mixed-version, or uncertain-consumer surface.
- Confirmed with unknown cause -> `yo-debug`.
- Confirmed differently or broader -> surface the changed scope; ask only when
  it changes product intent, risk, or authorization materially.
- Not reproduced or insufficient -> state the missing evidence and the next
  cheapest discriminating check; do not ship a guess as a fix.
- Disproved or stale -> stop the proposed implementation and report the
  contradicting evidence.
- Consequential confirmed work -> attach the verdict to `yo-engineering`.

For multiple independent findings, pass the evidence states to `yo-fix-loop`
rather than expanding this check into an implementation wave.

## Report

Keep the handoff compact:

```text
Claim: <falsifiable statement>
Target: <revision/build/environment>
Checked: <files, commands, runtime path, issue/PR state>
Evidence: <observed result and important limits>
Verdict: <one primary verdict>; cause <known/probable/unknown/not applicable>
Next: <owner and exact next check or action>
```

If the user requested a GitHub update, pass this evidence to `yo-gh-write` with
the target commit or build. Otherwise report it locally; verification alone
does not authorize posting.

## Guardrails

- Do not accept plausibility as confirmation.
- Do not treat the reporter's proposed fix as evidence of cause.
- Do not treat the presence of a guard or fix-looking commit as proof that the
  reported behavior is resolved.
- Do not read only the cited symptom site when the flow crosses boundaries.
- Do not silently replace a disproved task with a different fix.
- Do not overstate what one environment, test, or trace proves.
- Do not require any skill outside the Yo bundle.

Read [the research record](references/sources.md) only when maintaining or
auditing this skill.
