# Issue templates — yo-gh-write

Read live issue forms, issue templates, `CONTRIBUTING.md`, and `SECURITY.md` before using a fallback. Keep facts separate from suspected causes.

## Contents

- [Select a shape](#select-a-shape)
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
## Problem

<Whose problem is this, and what can they not do today?>

## Desired outcome

<Observable result without prescribing unnecessary implementation.>

## Scope

- <Included behavior>
- <Included behavior>

## Acceptance criteria

- [ ] <Verifiable outcome>
- [ ] <Verifiable outcome>

## Out of scope

- <Explicit boundary>

## Context

<Constraints, related issues, prior decisions, or examples; omit when empty.>
```

## Task or chore

```markdown
## Goal

<Concrete result this task should produce>

## Scope

- <Included work>
- <Included work>

## Acceptance criteria

- [ ] <Observable completion condition>
- [ ] <Required verification>

## Notes

<Dependencies, constraints, or links; omit when empty.>
```

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

## Decision record

<Fill after agreement: decision, owner, and date>
```

## Security boundary

Never open a public issue containing exploit details, secrets, or an unpatched vulnerability. Read `SECURITY.md`; use private vulnerability reporting or a draft repository security advisory. If no private route exists, open only a minimal public request asking maintainers for a security contact.

Standards basis: Mozilla bug-writing guidance and GitHub issue templates/forms, issue types, sub-issues, dependencies, and security-advisory guidance. See `sources.md`.
