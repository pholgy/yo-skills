# Issue templates — yo-gh-write

Read live issue forms, issue templates, `CONTRIBUTING.md`, and `SECURITY.md` before using a fallback. Keep facts separate from suspected causes.

## Contents

- [Select a shape](#select-a-shape)
- [Write only enough](#write-only-enough)
- [Readiness and semantic gate](#readiness-and-semantic-gate)
- [Business and engineering boundary](#business-and-engineering-boundary)
- [Use GitHub-native structure](#use-github-native-structure)
- [Bug report](#bug-report)
- [Feature request](#feature-request)
- [Task or chore](#task-or-chore)
- [Investigation or spike](#investigation-or-spike)
- [Follow-up](#follow-up)
- [Decision or RFC](#decision-or-rfc)
- [Security boundary](#security-boundary)

## Select a shape

| Need | Template |
|---|---|
| Reproducible incorrect behavior | Bug report |
| New user or operator capability | Feature request |
| Bounded engineering deliverable | Task or chore |
| Evidence needed before choosing work | Investigation or spike |
| Deferred item discovered during other work | Follow-up |
| Architectural or product choice needs agreement | Decision or RFC |

## Write only enough

Choose depth from the work, not from a desire to fill a template:

| Work | Smallest useful body |
|---|---|
| Clear, reversible, low-risk change | Use only `Why`, `Outcome`, `Acceptance criteria` by default |
| Standard feature or engineering task | Add `Technical scope` and `Not doing` only when they prevent ambiguity or scope drift |
| High-risk or hard-to-reverse change | Add only the material migration, rollout, rollback, security, data, compatibility, or observability controls |

Stop when a developer can implement and verify the intended behavior without
guessing a material product rule. Do not add prose that neither changes a
decision, reduces a demonstrated risk, nor supplies evidence.

Optional sections are opt-in. A verified component name that merely repeats the
acceptance criteria does not justify `Technical scope`. A list of architectures,
features, or cleanups nobody would reasonably add does not justify `Not doing`.

## Readiness and semantic gate

Before presenting a feature or task as ready for development, confirm:

- the affected user, operator, or business need is understood;
- the intended observable outcome is clear;
- acceptance criteria are measurable or otherwise verifiable;
- material product, policy, compatibility, and failure-path decisions are made;
- known blockers and dependencies are represented; and
- the issue is a small, coherent unit of value rather than a grab bag.

If a missing decision changes required behavior, preserve it as a question and
use an investigation, RFC, or explicit not-ready state. Never invent the answer
or disguise the decision as an implementation detail.

Run this semantic pass on the resulting contract:

- state one observable rule per acceptance item;
- remove contradictions, duplicates, vague absolutes, and unbounded claims;
- define enumerated cases, fallback behavior, and unknown inputs when material;
- define absent versus `null`, default behavior, and compatibility boundaries
  when a public or persisted contract changes;
- define operational terms, status values, and booleans whose ordinary meaning
  could produce different behavior;
- for stateful retry, reconciliation, or recovery work, define the meaningful
  states, terminal conditions, convergence or idempotency rule, and who may
  trigger destructive or compensating action;
- treat available APIs, hooks, permissions, and provider capabilities as facts,
  not authorization or product policy. Never infer that a destructive action
  should run merely because the system can run it. If the accepted outcome can
  be delivered safely without destruction, keep the first slice non-destructive
  and defer that policy; otherwise route the missing trigger and authority to a
  decision issue;
- separate verified facts, assumptions, decisions, and unresolved questions;
- replace promises such as `all consumers remain compatible` with the exact
  supported consumers or compatibility behavior that evidence can establish.

When rules combine or three or more cases repeat the same fields, use one compact
decision table such as `Case | Required behavior | Fallback`. Do not expand a
simple rule into decorative tables or full Gherkin.

For a decision issue, map materially different combinations even while their
answers remain `TBD`. The artifact is complete when it records the selected rule,
its rationale and compatibility effect, and the authorized implementation
follow-up—not when it merely lists options.

## Business and engineering boundary

- **Why** names who is affected, the current friction or risk, and its supported
  consequence. Stop at the highest user or business effect the evidence supports.
- **Outcome** states what will become observably different. Add an inline
  `Success signal` only when a post-release indicator is known; label an expected
  effect honestly and do not fabricate a revenue or adoption metric.
- **Acceptance criteria** are the single completion contract. Do not restate them
  as separate `Required behavior`, `Scope`, and `Done when` lists.
- **Technical scope** is opt-in and requires live repository evidence plus a
  non-obvious implementation boundary or constraint worth preserving. Format
  it as `` `<verified surface>` — <intended behavior and material constraint> ``.
  Name an exact path or symbol only after inspecting it. Prescribe an approach
  only when a verified cause, current contract, repository boundary, or recorded
  decision requires it; otherwise preserve implementation freedom.
- **Verification** describes the behavior that needs proof, not a mandatory test
  layer or new test file. Existing tests may be sufficient when they faithfully
  prove the criterion.
- **Not doing** is opt-in and names only adjacent work a reasonable implementer
  might otherwise include. Do not repeat acceptance in negative form or list
  speculative architectures solely to prohibit them.

## Use GitHub-native structure

Keep the body as the current source of truth for intent and behavior. Move
priority, effort, status, dates, ownership, issue type, and other structured
tracking into repository-supported fields, labels, milestones, and Projects.

- Use a task list for acceptance or verification items, not as a second
  implementation plan.
- Use sub-issues for independently owned or tracked work. Let the parent own the
  shared `Why`, outcome, and overall boundary; let each child state its valuable
  contribution, acceptance, and technical scope. Prefer coherent vertical slices
  over frontend/backend layers unless a layer is independently deliverable.
- Use issue dependencies for actual blocking relationships instead of burying
  them in prose.
- Treat comments as discussion history. After a decision changes the contract,
  update the issue body so readers do not need to reconstruct current truth from
  the thread.

## Bug report

```markdown
## Summary

<One sentence describing the observed failure and affected user or system.>

## Steps to reproduce

1. <Exact starting state>
2. <Exact action>
3. <Exact action that exposes the failure>

Reproduction rate: <always / intermittent / N of N attempts>.

## Actual result

<What happened, including the exact error when available.>

## Expected result

<What should have happened.>

## Environment

- Version or commit: `<value>`
- OS/runtime/browser: `<value>`
- Relevant configuration: `<value>`

## Evidence

<Minimal logs, screenshots, traces, or file references. Label any suspected
cause as a hypothesis rather than a fact.>
```

## Feature request

```markdown
## Why

<Who is affected, what can they not do today, and what supported consequence does that create?>

## Outcome

<Observable result without prescribing unnecessary implementation.>

Success signal: <Optional post-release indicator; omit when unknown or unnecessary.>

## Acceptance criteria

- [ ] <One observable, verifiable behavior.>
- [ ] <Material boundary, fallback, or compatibility behavior.>
```

When justified, append `Technical scope` with verified surfaces and non-obvious
constraints, or `Not doing` with a tempting adjacent scope. Do not append either
section by default.

## Task or chore

```markdown
## Why

<Why this work matters now: user impact, operator toil, delivery constraint, or demonstrated risk.>

## Outcome

<Observable engineering or operational result, not an implementation checklist.>

## Acceptance criteria

- [ ] <Observable completion condition.>
- [ ] <Behavior or invariant that requires proof.>
```

Use the same opt-in `Technical scope` and `Not doing` rule as the feature
template.

## Investigation or spike

```markdown
## Question

<What decision or uncertainty must this investigation resolve?>

## Known facts

- <Verified fact>
- <Verified fact>

## Unknowns

- <Question>
- <Question>

## Exit criteria

- [ ] <Evidence required>
- [ ] <Decision or recommendation produced>

## Non-goals

- <Work that will not be implemented during the investigation>
```

## Follow-up

```markdown
## Context

<Where this was found and why it matters>

## Scope

<Smallest independent unit of deferred work>

## Acceptance criteria

- [ ] <Verifiable result>
- [ ] <Required regression or operational proof>

## Source

Refs #<issue or PR> and <comment or file link>.
```

## Decision or RFC

```markdown
## Context

<Current system, constraint, and why a decision is needed>

## Decision needed

<One precise question>

## Constraints

- <Constraint>
- <Constraint>

## Options

### Option A — <name>

<Trade-offs>

### Option B — <name>

<Trade-offs>

## Recommendation

<Recommended choice and why>

## Exit criteria

- [ ] <Selected rule, rationale, precedence, and material compatibility behavior are recorded.>
- [ ] <Authorized implementation follow-up is opened or linked; omit when the decision itself is the endpoint.>

## Decision record

<Fill after agreement: decision, owner, and date>
```

## Security boundary

Never open a public issue containing exploit details, secrets, or an unpatched vulnerability. Read `SECURITY.md`; use private vulnerability reporting or a draft repository security advisory. If no private route exists, open only a minimal public request asking maintainers for a security contact.

Standards basis: Mozilla bug-writing guidance and GitHub issue templates/forms, issue types, sub-issues, dependencies, and security-advisory guidance. See `sources.md`.
