# Pull request templates — yo-gh-write

Read the repository's live PR template first. Use these only when it has no template or when a matching repo profile explicitly selects one.

## Contents

- [Select a shape](#select-a-shape)
- [Small PR](#small-pr)
- [Standard PR](#standard-pr)
- [High-risk PR](#high-risk-pr)
- [Draft PR](#draft-pr)
- [Dependency PR](#dependency-pr)
- [PR quality checks](#pr-quality-checks)

## Select a shape

| Situation | Template |
|---|---|
| Tiny, low-risk change | Small PR |
| Normal feature, fix, or refactor | Standard PR |
| API, data, security, deployment, migration, or broad user-flow risk | High-risk PR |
| Work is intentionally incomplete and needs early feedback | Draft PR |
| Dependency addition or upgrade | Dependency PR |

Write an imperative, specific title. Describe the change rather than repeating the issue title.

## Small PR

```markdown
<Explain why the change is needed and what changed in two to four sentences.>

Validation: `<command>` — <result>.

Closes #<issue>.
```

Use only when extra headings would be heavier than the change.

## Standard PR

```markdown
## Why

<Describe the user-visible problem, engineering constraint, or reason for
the change. Include enough context to understand it without opening the issue.>

## Approach

- <Important implementation decision>
- <Important invariant, boundary, or compatibility decision>
- <Regression protection or verification decision>

## Validation

- [x] `<command>` — <result>
- [x] <user-facing or integration check> — <result>

## Risk

<Include only when a meaningful residual risk exists. Otherwise omit.>

Closes #<issue>.
```

## High-risk PR

```markdown
## Why

<Problem, affected users or systems, and why the change is needed now>

## Approach

<Design and important decisions. Link a design or ADR when one exists.>

## Compatibility

<API, schema, persisted-data, client, or deployment compatibility>

## Rollout

<Deployment order, migration sequence, feature flag, monitoring, and owner>

## Rollback

<Exact reversible action, decision point, and any rollback limit>

## Validation

- [x] `<focused command>` — <result>
- [x] `<full gate>` — <result>
- [x] <staging or production-shaped check> — <result>

Closes #<issue>.
```

## Draft PR

```markdown
## Goal

<What this work is trying to establish>

## Current state

- Completed: <work>
- In progress: <work>
- Not started: <work>

## Feedback needed

- <Specific decision, design question, or area to review>

## Validation so far

- `<command>` — <result>
```

Do not imply readiness. Name incomplete work and the exact feedback requested.

## Dependency PR

```markdown
## Why

<Security fix, required capability, compatibility need, or maintenance reason>

## Change

- `<package>`: `<old version>` → `<new version>`
- Upstream notes: <link>

## Compatibility

<Relevant breaking changes, migrations, transitive changes, or “No documented
breaking change applies to the paths used here.”>

## Validation

- [x] Lockfile reviewed for unrelated changes
- [x] `<focused command>` — <result>
- [x] `<full gate>` — <result>

Refs #<issue or advisory>.
```

Do not copy release notes wholesale. State only the upstream changes that affect this repository.

## PR quality checks

- Explain both what changed and why.
- Include decisions, not a file-by-file narration.
- State known shortcomings or follow-ups honestly.
- Re-read the body after review changes so it still matches the final diff.
- Use `Closes #N` only when merge should close the issue; otherwise use `Refs #N`.

Standards basis: Google Engineering Practices for CL descriptions and small changes, plus GitHub PR templates and issue-linking behavior. See `sources.md`.
