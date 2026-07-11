# Writing standard — yo-gh-write

Apply this standard to every GitHub artifact after selecting its artifact-specific template.

## Content order

1. Lead with the purpose, verdict, user-visible problem, or decision.
2. State the verified facts and their impact.
3. Explain why when the reason is not visible from the code or diff.
4. Give the next action, decision, or closure state.
5. Attach only the evidence needed to support the claim.

## Titles

| Artifact | Pattern | Example |
|---|---|---|
| Pull request | Imperative verb + specific change | `Prevent stale events from updating the active session` |
| Bug issue | Observable symptom + triggering context | `Session cost updates after switching chats mid-stream` |
| Feature issue | Desired capability or user outcome | `Allow operators to replay failed generation jobs` |
| Task issue | Concrete deliverable | `Document the staging rollback procedure` |
| Investigation | Question or uncertainty to resolve | `Determine why queue retries lose action logs` |
| Release | Version or product name + useful qualifier | `v1.4.0 — Queue recovery and audit visibility` |

Avoid titles such as `Fix bug`, `Improvements`, `Phase 1`, `Update code`, or a verbatim copy of the problem statement when the artifact represents the solution.

## Editorial pass

- Use active voice and concrete verbs.
- Prefer short sentences and paragraphs, but keep related cause and effect together.
- Use one term for one concept throughout the artifact.
- Fix spelling, grammar, punctuation, capitalization, tense, and articles.
- Remove filler, repetition, throat-clearing, and claims that do not change a decision.
- Remove or replace vague words such as `successfully`, `comprehensive`, `robust`, `leverage`, `ensure`, `various`, and `several`.
- Replace category claims with observable facts: write `28/28 tests pass` instead of `testing is comprehensive`.
- Use `I` only when it makes ownership natural. Avoid corporate `we` unless a team decision is genuinely being represented.
- Keep the tone calm and respectful. Critique code and behavior, never the person.
- Preserve uncertainty when it is real: `I could not reproduce this` is better than converting incomplete evidence into a verdict.

## Technical accuracy pass

Recheck every item that can silently become false:

- issue and PR numbers;
- commit SHAs and branch names;
- file paths, symbols, flags, and commands;
- test counts and exit results;
- version numbers and compatibility claims;
- links, mentions, labels, milestones, assignees, and reviewers;
- `Closes`, `Fixes`, `Resolves`, and `Refs` intent;
- whether the text still matches the latest diff and discussion.

Never say `all tests pass` when only a focused subset ran. Name the exact gate and any honest skips.

## Markdown pass

- Use inline code for identifiers, paths, flags, commands, and SHAs.
- Use fenced blocks with a language tag for code or console excerpts.
- Use task lists only for actionable acceptance or verification items.
- Use tables for repeated fields with at least three meaningful rows.
- Use `<details>` for long supporting logs, not for the main verdict.
- Keep headings proportional to length; do not give a four-sentence comment three sections.
- Put the main conclusion above collapsed evidence.

## Final check

Before showing or posting the draft, confirm:

- the artifact has one clear job;
- the first paragraph carries the important information;
- every factual claim has a source;
- required sections are present and irrelevant sections are absent;
- the prose is concise, natural, and technically precise;
- the Markdown will render without placeholders or broken fences;
- no secret, credential, private vulnerability detail, assistant/vendor mention, or `Co-Authored-By` line appears.

Standards basis: Google Engineering Practices for change descriptions and review comments, Microsoft technical-writing guidance, GitHub formatting guidance, and Mozilla bug-writing guidance. See `sources.md`.
