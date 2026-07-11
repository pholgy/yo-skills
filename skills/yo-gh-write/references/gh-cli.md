# GitHub CLI posting patterns — yo-gh-write

Use these patterns after the text is fact-checked and any required draft review is complete. Commands are PowerShell-first for the user's normal Windows environment.

## Contents

- [Core rule: use a body file](#core-rule-use-a-body-file)
- [Read-only preflight](#read-only-preflight)
- [Pull requests](#pull-requests)
- [Issues](#issues)
- [Releases](#releases)
- [Verify the external result](#verify-the-external-result)
- [Failure handling](#failure-handling)

## Core rule: use a body file

Use `--body-file` for multiline PRs, issues, comments, reviews, and edits. Use `--notes-file` for releases. Avoid passing long Markdown through `--body` because shell quoting can corrupt backticks, quotes, newlines, and code fences.

Create a temporary body file with the normal file-editing tool. For a manual PowerShell session:

```powershell
$bodyFile = Join-Path $env:TEMP "yo-gh-body-$PID.md"
@'
<approved Markdown body>
'@ | Set-Content -LiteralPath $bodyFile -Encoding utf8

Get-Content -Raw -LiteralPath $bodyFile
```

The opening and closing markers of a PowerShell here-string must be on their own lines. Inspect the file before the external write.

## Read-only preflight

```powershell
gh auth status
gh repo view --json nameWithOwner,url,defaultBranchRef,pullRequestTemplates,issueTemplates,securityPolicyUrl
```

Confirm the repository, target artifact, template, base branch, and authentication before mutation.

## Pull requests

### Create

```powershell
gh pr create `
  --title "Prevent stale events from updating the active session" `
  --base develop `
  --assignee "@me" `
  --reviewer "amagdum-iron" `
  --body-file $bodyFile
```

Add `--draft` when the body explicitly describes incomplete work. Omit assignee or reviewer flags when they are not known from live repository rules or the matching profile.

### Edit

```powershell
gh pr edit 311 --body-file $bodyFile
```

### Top-level comment

```powershell
gh pr comment 311 --body-file $bodyFile
```

### Submit a review

```powershell
gh pr review 311 --approve --body-file $bodyFile
gh pr review 311 --comment --body-file $bodyFile
gh pr review 311 --request-changes --body-file $bodyFile
```

Run exactly one command matching the intended review outcome.

### Reply to an inline review thread

List review-comment IDs:

```powershell
gh api "repos/{owner}/{repo}/pulls/311/comments" `
  --jq '.[] | {id, path, line, body: .body[0:100]}'
```

Post the reply:

```powershell
$commentId = 123456789
gh api -X POST "repos/{owner}/{repo}/pulls/311/comments" `
  -F "body=@$bodyFile" `
  -F "in_reply_to=$commentId" `
  --jq '{id, html_url, body}'
```

Do not substitute a top-level `gh pr comment` when the response belongs to a specific thread.

## Issues

### Create

```powershell
gh issue create `
  --title "Session cost updates after switching chats mid-stream" `
  --assignee "@me" `
  --body-file $bodyFile
```

Use only labels, types, projects, milestones, parents, and dependencies that exist in the live repository. Issue types are version-dependent in GitHub CLI; add `--type Bug` only when `gh issue create --help` exposes `--type`.

### Edit

```powershell
gh issue edit 142 --body-file $bodyFile
```

### Comment

```powershell
gh issue comment 142 --body-file $bodyFile
```

### Close with a multiline explanation

`gh issue close --comment` does not accept a body file. Post the reviewed closure first, then close with the matching state:

```powershell
gh issue comment 142 --body-file $bodyFile
gh issue close 142 --reason completed
```

For duplicates, post the reviewed explanation first. Newer GitHub CLI versions expose a native `--duplicate-of` relationship, but older installed versions do not. Feature-detect it:

```powershell
gh issue comment 142 --body-file $bodyFile
$closeHelp = gh issue close --help | Out-String
if ($closeHelp -match '--duplicate-of') {
  gh issue close 142 --duplicate-of 98
} else {
  # The linked comment carries the canonical issue; this CLI cannot set the
  # native duplicate relationship.
  gh issue close 142 --reason "not planned"
}
```

Use `--reason "not planned"` only when the closure text gives the concrete rationale.

## Releases

```powershell
gh release create v1.4.0 `
  --verify-tag `
  --title "v1.4.0 — Queue recovery and audit visibility" `
  --notes-file $bodyFile
```

Use `--draft` for review before publication, `--prerelease` for non-production releases, and `--fail-on-no-commits` when duplicate releases must be prevented. If using `--generate-notes`, inspect and curate the generated result before publishing.

## Verify the external result

Reopen the written artifact immediately:

```powershell
gh pr view 311 --json title,body,url,baseRefName,headRefName,reviewDecision
gh issue view 142 --json title,body,url,state,stateReason,labels,assignees
gh release view v1.4.0 --json name,body,url,isDraft,isPrerelease,tagName
```

For comments or thread replies, open the returned URL or query the relevant comments endpoint. Confirm Markdown rendering, identifiers, metadata, and closing behavior—not just command success.

After successful verification, remove only the known temporary file:

```powershell
Remove-Item -LiteralPath $bodyFile
```

## Failure handling

- Authentication failure: surface it; do not loop. The user may need `gh auth login` or `gh auth refresh`.
- Reviewer or assignee rejected: re-read repository permissions and available users; do not assume the request succeeded.
- Version-dependent flag missing: inspect `<command> --help` and use the documented fallback; do not blindly retry a newer-manual example.
- Template or metadata mismatch: stop before posting and reconcile with the live repository.
- Network or API failure: check whether GitHub created the artifact before retrying to avoid duplicates.
- Render mismatch: edit from the same reviewed body file, then verify again.

Command basis: current GitHub CLI manuals for `gh pr create/edit/comment/review`, `gh issue create/edit/comment/close`, `gh api`, and `gh release create/view`. See `sources.md`.
