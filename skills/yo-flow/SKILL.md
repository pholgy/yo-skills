---
name: yo-flow
description: >-
  Route ambiguous software-engineering requests to the appropriate bundled
  yo-* workflow without making the user repeat context. Use when explicitly
  invoked, when the user asks which Yo skill or what to do next, says they are
  unsure where to start, or gives a request whose desired outcome is materially
  ambiguous between fixing, building, reviewing, shipping, or writing. Skip
  routing questions for clear requests and route directly. Active production
  impact preempts the router and goes to yo-incident.
---

# Yo Flow

Act as the bundle's router, not its orchestrator. Identify the smallest accurate
destination, preserve the user's context, and hand off. Do not perform the
downstream workflow here.

## Core contract

- Use only bundled `yo-*` skills. Never require an external skill.
- Skip menus when the requested outcome is already clear.
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

### 2. Honor clear intent

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

### 3. Clarify only material ambiguity

Read [the clarification patterns](references/clarification-patterns.md) when two
or more materially different destinations remain plausible.

Ask one targeted question that distinguishes those destinations. Use the
environment's structured choice control when available; otherwise use a short
numbered list. Always allow the user to answer in their own words.

Do not ask for information already supplied or cheaply discoverable. Do not
repeat a generic top-level wizard after the user's domain or partial intent is
known.

### 4. Hand off with context

Pass only the fields that exist:

- desired outcome and stopping point
- repository, issue, PR, branch, file, or other named artifact
- evidence already established
- constraints, non-goals, and choices already rejected
- risk or approval state
- unresolved decision, if any

Then stop routing. Let the destination skill own its workflow and later
handoffs.

### 5. Recover cleanly

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
- Do not treat the menu options as exhaustive.
- Do not reference or require any non-Yo skill.
