---
name: yo-gh-write
description: >-
  Draft, revise, proofread, and post GitHub pull requests, issues, reviews, replies, evidence comments, status updates, release notes, and incident updates. Use when the user asks to write, rewrite, fix grammar or tone, open, comment on, review, reply to, close, or update any GitHub artifact. Preserve the user's concise technical voice and ground every claim in the live repository, diff, discussion, or verification evidence.
---

# yo-gh-write — GitHub Engineering Writing

Write the words that land on GitHub. Do not implement the underlying code change.

## Core rules

1. **Use live truth.** Read the issue, diff, code, discussion, and verification output needed to support the text. Never invent scope, results, identifiers, or intent.
2. **Follow repository conventions.** Read the repository's current templates and contributing guidance first. Use bundled templates only as the fallback. Apply matching additions from `references/repo-profiles.md` without overriding a live repository template.
3. **Separate drafting from posting.** Draft non-trivial text in chat first. Post only when the request authorizes the external action and the user has seen the draft or explicitly asked to skip review.
4. **Give each artifact one job.** Select the smallest fitting template. Omit empty or irrelevant sections instead of publishing placeholders.
5. **Prefer evidence over adjectives.** Bind verification claims to the command, result, and commit SHA. Curate logs; do not dump them.
6. **Protect sensitive reports.** Never put vulnerability details in a public issue. Follow the repository's security policy or private advisory workflow.

## Workflow

1. **Classify the artifact and action.** Identify PR, issue, review, reply, evidence, status, release, incident, or closure text. Distinguish draft-only from post/update/close authorization.
2. **Gather source material.** Read the current artifact, linked work, relevant code or diff, repository template, and actual verification evidence.
3. **Load only the matching references.** Use the routing table below. Do not load the full reference library for one comment.
4. **Draft from facts.** Lead with the problem, decision, verdict, or outcome. Explain why when it is not obvious from the code.
5. **Run the editorial pass.** Fix spelling, grammar, punctuation, tense, terminology, rhythm, repetition, hedging, and filler while preserving technical meaning.
6. **Run the accuracy pass.** Recheck names, issue numbers, SHAs, paths, commands, links, closing keywords, review severity, and Markdown structure.
7. **Review before mutation.** Show non-trivial drafts before posting unless the user explicitly waived that check.
8. **Post and verify.** Use PowerShell-safe `--body-file` or `--notes-file` patterns from `references/gh-cli.md`, then reopen the artifact and confirm its rendered body and metadata.

## Reference routing

| Need | Read |
|---|---|
| Voice, titles, proofreading, factual and Markdown checks | `references/writing-standard.md` |
| PR body or draft PR | `references/pull-requests.md` |
| Bug, feature, task, investigation, follow-up, or decision issue | `references/issues.md` |
| Inline review comment or review summary | `references/reviews.md` |
| Review-thread, issue-thread, closing, or deferral reply | `references/replies.md` |
| Audit proof, test evidence, progress update, or fix-wave wrap-up | `references/evidence-and-status.md` |
| Release notes, recovery update, postmortem, or security advisory | `references/releases-and-incidents.md` |
| Repository-specific assignees, reviewers, labels, and conventions | `references/repo-profiles.md` |
| Posting, editing, reviewing, replying, and render verification | `references/gh-cli.md` |
| Rationale and authoritative engineering sources | `references/sources.md` |

## House rules

- Write like a concise technical teammate, not a press release.
- Lead with why or the verdict; do not narrate the file list.
- Label review intent: `Blocker`, `Required`, `Suggestion`, `Nit`, `Question`, `FYI`, or `Praise`.
- Reply to each review thread that was addressed; do not hide all fixes in one summary.
- Use `Closes #N` only when merge should close the issue. Use `Refs #N` for context without auto-close intent.
- Do not add `Co-Authored-By`, assistant/vendor mentions, or generated-content markers.
- Keep public claims reproducible. If evidence is incomplete, say what was and was not verified.

## Handoffs

- Run `yo-branch` before opening a PR.
- Accept verified inputs from `yo-verify-premise`, `yo-feature`, `yo-fix-loop`, `yo-audit`, `yo-release`, and `yo-incident`; edit their wording without weakening or overstating their evidence.
- Use `yo-engineering` inputs for risk, compatibility, rollout, and rollback sections when the change is broad or high-risk.
