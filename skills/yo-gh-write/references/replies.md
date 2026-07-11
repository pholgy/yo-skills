# Reply and closure templates — yo-gh-write

Reply in the original thread when the response belongs to a specific review comment. Name the decision, change, or missing evidence; do not post empty acknowledgements such as `Done` or `Fixed`.

## Contents

- [Review-thread replies](#review-thread-replies)
- [Issue and PR conversation replies](#issue-and-pr-conversation-replies)
- [Thread discipline](#thread-discipline)

## Review-thread replies

### Fixed

```markdown
Fixed in `<SHA>`: <describe the actual change>.

Verified with `<command>` — <result>.
```

### Partially fixed

```markdown
Addressed <completed portion> in `<SHA>`.

<Remaining portion> is still open because <reason>. I’m leaving this thread
unresolved until <completion condition>.
```

### No code change

```markdown
I checked <relevant behavior or contract>. Keeping this as-is because
<concrete reason>, supported by <evidence or existing convention>.
```

### Valid but out of scope

```markdown
This is valid, but it is outside this PR’s <named scope>. Filed #<issue>
with the relevant context and linked this thread there.
```

### Cannot reproduce

```markdown
I couldn’t reproduce this against `<SHA>` using <environment or steps>.

I ran:

- `<command or step>` — <actual result>

Could you share <specific missing information>?
```

### Clarification needed

```markdown
I see two possible interpretations:

1. <Interpretation and consequence>
2. <Interpretation and consequence>

Which behavior should this PR preserve?
```

### Superseded by a later change

```markdown
Superseded by `<SHA>`: <how the later approach removes or changes the original
concern>. Verified with `<command>` — <result>.
```

## Issue and PR conversation replies

### Acknowledge and state the next action

```markdown
Confirmed: <restated concrete finding>.

Next: <specific action and expected evidence>.
```

Use only when work has not yet completed. Do not imply a fix.

### Need more information

```markdown
I’m missing <specific fact> needed to verify this.

Please provide:

- <item>
- <item>

With that, I can check <specific claim>.
```

### Duplicate

```markdown
Closing as a duplicate of #<canonical issue>. Both track <same underlying
problem>; the canonical issue contains <why it is the right place>.
```

### Completed

```markdown
Completed in #<PR> at `<merge SHA>`.

Verified with `<command or user-visible check>` — <result>.
```

### Not planned

```markdown
Closing as not planned because <specific product, technical, or scope reason>.

<Alternative or condition that would justify revisiting, when one exists.>
```

### Deferred

```markdown
Deferring this from the current scope because <reason>. Tracking the bounded
follow-up in #<issue>, with <owner or next decision>.
```

### Reopen

```markdown
Reopening because <new evidence or changed condition> invalidates the previous
closure: <specific fact>.
```

## Thread discipline

- Reply per addressed thread, then post one summary only when the review had multiple threads.
- Resolve a thread only when the concern is addressed, explicitly declined with rationale, or moved to a linked issue under the repository's convention.
- Keep a thread open when evidence, implementation, or reviewer confirmation is still pending.
- Do not thank mechanically on every reply; use gratitude when it is natural and specific.
- Do not claim resolution from a commit SHA alone. State the change and, when relevant, its verification.

Standards basis: GitHub conversation-resolution behavior and Google guidance for handling reviewer comments constructively. See `sources.md`.
