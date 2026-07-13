---
name: yo-flow
description: >-
  Route ambiguous software-engineering requests to the appropriate bundled
  yo-* workflow without making the user repeat context. Use when explicitly
  invoked, when the user asks which Yo skill or what to do next, says they are
  unsure where to start, or gives a request whose desired outcome is materially
  ambiguous between fixing, building, reviewing, shipping, or writing. Clear,
  low-risk work bypasses the router and continues through the normal task
  workflow. Active production impact preempts the router and goes to
  yo-incident.
---

# Yo Flow

Act as the bundle's router, not its orchestrator. Identify the smallest accurate
destination, preserve the user's context, and hand off. Do not perform the
downstream workflow here.

## Core contract

- Use only bundled `yo-*` skills. Never require an external skill.
- Bypass this router when the requested outcome is already clear and no
  specialized Yo workflow is needed.
- Prefer one primary destination. Add a preceding risk or design gate only when
  the request actually needs it.
- Use available context and cheap read-only inspection before asking the user,
  but do not turn routing into diagnosis or implementation.
- Carry the user's goal, evidence, constraints, and requested endpoint into the
  handoff so they do not need to repeat themselves.

## Route in this order

### 1. Preempt for live impact

Route active production impact directly to `yo-incident`. Do not show a menu.
Examples include an outage, live login failure, widespread errors, or a harmful
deploy affecting users now.

### 2. Bypass routing for clear direct work

Continue through the normal task workflow without a Yo handoff when all of the
following are true:

- the outcome and target are clear;
- the change is confined to one file or a few directly related files for the
  same local outcome;
- the work is local and readily reversible;
- a focused read or existing check can establish the premise and prove the
  result;
- no material authorization/security boundary, public contract, persisted-data
  or migration surface, concurrency risk, active incident, destructive action,
  deployment, or other external state is involved.

The file-scope condition is a containment guard, not permission to classify a
cross-cutting change as trivial. Do not use changed-line count alone as a proxy
for risk. An obvious one-file documentation correction qualifies from the rule
text alone. A localized, deterministic bug with a known cause may also stay
direct when its regression test and repository gates fully observe the change.
Still discover applicable
instructions and verification commands, preserve user work, and run the
proportionate operating-baseline checks; bypassing the router does not bypass
engineering discipline.

Exit the direct lane as soon as inspection reveals a disputed premise, unknown
cause, broader consumer or contract surface, an unexplained failing baseline,
an unfaithful test seam, or any consequential/irreversible effect. Route the
newly discovered need rather than forcing the original classification.

Do not route a clear fix into a RED-test campaign. When the next action is
obvious, use the normal task workflow: inspect, make the scoped fix, add the
focused regression when a verified bug warrants it, run the narrow focused test,
then run the repository completion gate. Route to `yo-test-coverage` only when
the user asks for tests/coverage or choosing a faithful test strategy is
materially ambiguous.

### 3. Honor clear specialized intent

Read [the routing map](references/routing-map.md), select the primary skill, and
invoke it without a routing question.

Treat these as clear:

- "Make this best-engineer quality" -> `yo-engineering`
- "Review PR #311 for merge safety" -> `yo-audit`
- "Upgrade this dependency" -> `yo-deps`
- "Write or reply on GitHub" -> `yo-gh-write`
- "Plan this architecture; do not implement" -> `yo-design`
- "Cut the next release" -> `yo-release`

If the request is clear but no Yo skill owns it, say there is no specialized Yo
route and continue through the normal task workflow. Do not invent a skill.

For a destructive, external, or difficult-to-reverse action, route to the
appropriate Yo workflow and preserve the need for explicit approval. If
approval is the only unresolved choice, ask for that approval directly instead
of asking a generic routing question.

### 4. Clarify only material ambiguity

Read [the clarification patterns](references/clarification-patterns.md) when two
or more materially different destinations remain plausible.

Ask one targeted question that distinguishes those destinations. Use the
environment's structured choice control when available; otherwise use a short
numbered list. Always allow the user to answer in their own words.

Do not ask for information already supplied or cheaply discoverable. Do not
repeat a generic top-level wizard after the user's domain or partial intent is
known.

### 5. Hand off with context

Pass only the fields that exist:

- desired outcome and stopping point
- repository, issue, PR, branch, file, or other named artifact
- evidence already established
- constraints, non-goals, and choices already rejected
- risk or approval state
- unresolved decision, if any

Then stop routing. Let the destination skill own its workflow and later
handoffs.

### 6. Recover cleanly

When the user changes or corrects the goal, discard the earlier route and use
the revised intent. Never make them defend the correction.

After two unsuccessful clarification attempts, do not show another menu.
Summarize what is known, name the closest supported routes, and invite the user
to state the desired deliverable in their own words.

## Reference use

- Read [the routing map](references/routing-map.md) whenever selecting or chaining a destination.
- Read [the clarification patterns](references/clarification-patterns.md) only when a question is necessary.
- Read [the research record](references/sources.md) only when auditing or maintaining this skill.

## Guardrails

- Do not default to a fixed Q1/Q2 wizard.
- Do not duplicate the destination skill's intake questions or templates.
- Do not begin implementation, diagnosis, review, or GitHub writing here.
- Do not add a risk gate to trivial, reversible work.
- Do not use changed-line count alone as a proxy for risk; enforce the direct
  lane's bounded, directly related file scope as well as its risk conditions.
- Do not turn RED proof into a mandatory phase for ordinary clear fixes.
- Do not treat the menu options as exhaustive.
- Do not reference or require any non-Yo skill.
