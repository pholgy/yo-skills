# Authoritative sources — yo-gh-write

These sources define the rationale behind the bundled writing standards and templates. Repository-local instructions still take precedence for repository-specific shape and metadata.

## Contents

- [Pull requests and change descriptions](#pull-requests-and-change-descriptions)
- [Issues and bug reports](#issues-and-bug-reports)
- [Reviews and replies](#reviews-and-replies)
- [Technical writing and Markdown](#technical-writing-and-markdown)
- [Releases, incidents, and security](#releases-incidents-and-security)
- [GitHub CLI](#github-cli)

## Pull requests and change descriptions

- **Google Engineering Practices — Writing good CL descriptions**
  Requires a short, focused description of what changed, followed by the problem, why the approach was chosen, relevant shortcomings, context, and a final reread against the actual change.
  https://google.github.io/eng-practices/review/developer/cl-descriptions.html

- **Google Engineering Practices — Small CLs**
  Supports reviewable scope, related tests, and enough context for a reviewer to understand the change without unrelated external knowledge.
  https://google.github.io/eng-practices/review/developer/small-cls.html

- **GitHub Docs — About issue and pull request templates**
  Establishes repository templates as the mechanism for standardizing the information contributors provide.
  https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/about-issue-and-pull-request-templates

- **GitHub Docs — Linking a pull request to an issue**
  Defines `Closes`, `Fixes`, and `Resolves` behavior and cross-repository syntax.
  https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/linking-a-pull-request-to-an-issue

## Issues and bug reports

- **Mozilla — Bug Writing Guidelines**
  Treats precise reproduction steps as load-bearing and separates actual results, expected results, facts, environment, and speculation.
  https://bugzilla.mozilla.org/page.cgi?id=bug-writing.html

- **GitHub Docs — Syntax for issue forms**
  Defines structured, required inputs for actionable bug, feature, and task reports.
  https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/syntax-for-issue-forms

- **GitHub Docs — About issues**
  Covers issues as bugs, features, ideas, tasks, sub-issues, dependencies, and planning artifacts.
  https://docs.github.com/en/issues/tracking-your-work-with-issues/learning-about-issues/about-issues

## Reviews and replies

- **Google Engineering Practices — How to write code review comments**
  Requires respectful comments about code, explanations of why, balanced guidance, explicit severity, and useful positive feedback.
  https://google.github.io/eng-practices/review/reviewer/comments.html

- **Google Engineering Practices — How to handle reviewer comments**
  Supports constructive replies, improving the code rather than leaving durable explanations only in the review tool, and resolving disagreements professionally.
  https://google.github.io/eng-practices/review/developer/handling-comments.html

- **GitHub Docs — About pull request reviews**
  Defines the `Comment`, `Approve`, and `Request changes` outcomes.
  https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/about-pull-request-reviews

- **GitHub Docs — Commenting on a pull request**
  Defines line/file comments, suggestion blocks, batched reviews, thread replies, resolution, and moving out-of-scope work to an issue.
  https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/commenting-on-a-pull-request

## Technical writing and Markdown

- **Microsoft Learn — Style and voice quick start**
  Supports spell-and-grammar checking, concise sentences, natural technical language, strong information order, and scannable structure.
  https://learn.microsoft.com/en-us/contribute/content/style-quick-start

- **Microsoft Style Guide — Writing tips**
  Supports conventional grammar and punctuation, simple sentence structure, and consistent terminology.
  https://learn.microsoft.com/en-us/style-guide/global-communications/writing-tips

- **GitHub Docs — Basic writing and formatting syntax**
  Defines headings, lists, task lists, fenced code, tables, links, and `<details>` rendering.
  https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax

## Releases, incidents, and security

- **GitHub Docs — Automatically generated release notes**
  Defines generated merged-PR, contributor, category, and full-changelog content and requires checking generated notes before publication.
  https://docs.github.com/en/repositories/releasing-projects-on-github/automatically-generated-release-notes

- **Google SRE Workbook — Postmortem culture**
  Supports factual, non-blaming incident records with impact, mitigation, root cause, verifiable data, and clearly owned action items.
  https://sre.google/workbook/postmortem-culture/

- **GitHub Docs — Privately reporting a security vulnerability**
  Establishes private vulnerability reporting, `SECURITY.md`, and draft advisories instead of public exploit disclosure.
  https://docs.github.com/en/code-security/how-tos/report-and-fix-vulnerabilities/report-privately

- **GitHub Docs — Repository security advisories**
  Covers private collaboration, affected and fixed versions, mitigation, coordinated disclosure, and publication.
  https://docs.github.com/en/code-security/concepts/vulnerability-reporting-and-management/repository-security-advisories

## GitHub CLI

- `gh pr create`: https://cli.github.com/manual/gh_pr_create
- `gh pr edit`: https://cli.github.com/manual/gh_pr_edit
- `gh pr comment`: https://cli.github.com/manual/gh_pr_comment
- `gh pr review`: https://cli.github.com/manual/gh_pr_review
- `gh issue create`: https://cli.github.com/manual/gh_issue_create
- `gh issue edit`: https://cli.github.com/manual/gh_issue_edit
- `gh issue comment`: https://cli.github.com/manual/gh_issue_comment
- `gh issue close`: https://cli.github.com/manual/gh_issue_close
- `gh api`: https://cli.github.com/manual/gh_api
- `gh release create`: https://cli.github.com/manual/gh_release_create
- `gh release view`: https://cli.github.com/manual/gh_release_view

These manuals support file-backed bodies (`--body-file`), release-note files (`--notes-file`), explicit review outcomes, thread replies through the API, and read-after-write verification.

GitHub CLI manuals track the latest release and can be newer than the user's installed binary. Feature-detect version-dependent flags with `<command> --help` and preserve a documented fallback in `gh-cli.md`.
