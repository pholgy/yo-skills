# Repository profiles — yo-gh-write

Repository profiles add local conventions without replacing the repository's live instructions.

## Precedence

Apply conventions in this order:

1. The repository's current `.github` templates, issue forms, `CONTRIBUTING.md`, `SECURITY.md`, code-owner rules, and explicit user instructions.
2. The first matching profile in this file, but only for fields the live repository does not define.
3. The generic fallback below.

Never let a stale profile override current repository truth. If a profile conflicts with the live repository, follow the repository and flag the profile for later correction.

## Universal user rules

Apply to every repository unless the user explicitly changes them for the task:

- no `Co-Authored-By` line;
- no assistant/vendor names or generated-content markers in public text or commit messages;
- draft non-trivial public text before posting;
- use concise, natural technical prose;
- verify the rendered artifact after posting.

## Generic fallback

- **Templates:** Use the matching fallback reference only when the repository has no applicable template.
- **Tone:** Inspect a few recent accepted artifacts when tone materially varies; do not copy stale structure blindly.
- **Assignee:** Do not guess. Use `@me` only when the user or repository convention makes self-assignment clear.
- **Reviewers:** Do not guess. Use requested reviewers, code owners, or explicit profile rules.
- **Labels, type, project, milestone:** Apply only when supported by live repository values and justified by the work.
- **CI:** Report actual check state. Do not translate pending, skipped, neutral, or infrastructure failures into `pass`.

## HQ Desktop

- **Detection:** working directory under `hq-inc/ProofOfConcept.2.Desktop` or origin matching `iron-software/HQ.Desktop*`.
- **PR fallback:** `Why / Approach / Validation`; use the repository's live PR template when present.
- **Assignee:** self.
- **Request review from:** `@amagdum-iron`.
- **CI note:** Mention a confirmed external API or quota failure once with evidence; do not retry it indefinitely or call the change verified because product tests passed locally.

## Profile template

Add new profiles above this template.

```markdown
## <Repository name>

- **Detection:** <working-directory pattern or origin glob>
- **PR fallback:** <reference template and local additions>
- **Issue fallback:** <reference template and local additions>
- **Title convention:** <only when the repository defines one>
- **Assignee:** <self, named user, or none>
- **Reviewers:** <user/team handles, code owners, or none>
- **Labels/type/project/milestone:** <live values and selection rules>
- **CI notes:** <repository-specific interpretation or escalation rules>
- **Tone:** <only a real deviation from the universal writing standard>
```
