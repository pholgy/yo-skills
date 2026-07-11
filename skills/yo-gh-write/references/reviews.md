# Review templates — yo-gh-write

Review the code, not the author. Put one actionable topic in each inline comment, explain why it matters, and make the required response unambiguous.

## Contents

- [Choose the GitHub review outcome](#choose-the-github-review-outcome)
- [Severity vocabulary](#severity-vocabulary)
- [Comment structure](#comment-structure)
- [Review summaries](#review-summaries)
- [Review quality checks](#review-quality-checks)

## Choose the GitHub review outcome

| Outcome | Use when |
|---|---|
| Comment | Sharing feedback without approval or a required change |
| Approve | No merge-blocking correctness or requirement gap remains |
| Request changes | At least one finding must be addressed before merge |

Do not use the written label alone to imply GitHub enforcement. Select the matching review outcome when posting.

## Severity vocabulary

| Label | Meaning |
|---|---|
| `Blocker` | Unsafe to merge: correctness, security, data, compatibility, or severe user impact |
| `Required` | Must be addressed before approval but is not a critical safety defect |
| `Suggestion` | Optional improvement with clear value |
| `Nit` | Minor, non-blocking consistency or style point |
| `Question` | Clarification needed; not automatically a defect |
| `FYI` | Information for future consideration; no action expected here |
| `Praise` | A good decision worth reinforcing, with the reason it is good |

## Comment structure

Use the smallest complete shape:

1. severity or intent;
2. precise observation and trigger;
3. consequence or reason;
4. evidence;
5. optional direction when it genuinely helps.

### Blocker

```markdown
**Blocker:** <Specific defect and triggering condition>.

<Explain the correctness, security, compatibility, data, or user impact.>

Evidence: `<file:line, command, or observed behavior>`.
```

### Required change

```markdown
**Required:** <Behavior or contract that must change>.

<Explain why the current form does not meet the requirement.>
```

### Suggestion

```markdown
**Suggestion:** <Proposed improvement>.

<Explain why it would improve clarity, maintainability, or behavior.>
Non-blocking.
```

### Nit

```markdown
**Nit:** <Small consistency or style correction>. Non-blocking.
```

### Question

```markdown
**Question:** <What needs clarification?>

I’m asking because <specific uncertainty or possible consequence>.
```

### FYI

```markdown
**FYI:** <Useful context>. No change needed in this PR.
```

### Praise

```markdown
**Praise:** <Specific good decision>. This <concrete benefit or risk avoided>.
```

### Direct suggestion block

Use GitHub's suggestion syntax only when the replacement is small and unambiguous:

````markdown
**Suggestion:** <Reason for the change>. Non-blocking.

```suggestion
<exact replacement>
```
````

Do not redesign the author's solution inside a review comment when describing the defect is enough.

## Review summaries

### Approve

```markdown
**Approved.**

Checked:

- <Important behavior or contract>
- <Important risk area>
- `<verification command>` — <result>

No blocking findings.
```

### Comment only

```markdown
**Comment only.**

<What was reviewed and what feedback remains. State explicitly why this is
neither approval nor a change request.>
```

### Request changes

```markdown
**Requesting changes.**

<N> blocking findings:

1. `<file:line>` — <defect and impact>
2. `<file:line>` — <defect and impact>

<Optional: what was otherwise verified or looked sound.>
```

## Review quality checks

- Read the PR purpose before reviewing details.
- Comment on the narrowest useful line or file.
- Separate blockers, suggestions, and questions.
- Explain why when the consequence is not obvious.
- Offer direction without taking ownership of the implementation.
- Batch related review comments into one review to reduce notification noise.
- Give praise only when it teaches what should be repeated.
- Never approve based only on the PR description; verify the diff and relevant behavior.

Standards basis: Google Engineering Practices for review comments and GitHub's comment, approve, request-changes, suggestion, and conversation behavior. See `sources.md`.
